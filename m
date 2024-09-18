Return-Path: <linux-kernel+bounces-332337-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 62C5A97B882
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 09:20:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0EDA31F2551B
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 07:20:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B733166F0C;
	Wed, 18 Sep 2024 07:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="YxWhcEwR"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A967B172BCE
	for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 07:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726643945; cv=none; b=VXpdaQeG2viXZgvyc6cnBKBModQJD01KiwOMuzmewqMPrBKSf9arQqaS7Ir7QlRRPQ4FH9AD2H2k07Hcrevny4z/WXSn33+675NKxcat/d1tkTpfHqRMzfHJ1okF/NewLyzqq5ES1EDQvQN1HhRGCrcWTz8xY9aZQY1kQjVgcxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726643945; c=relaxed/simple;
	bh=kTPeIU/j5jUeqN41PXaxQLwE/1Uka9ApKWzgFyfK52o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mTVE1a6JysQFEy+GCvSs9shjX0zkT6D/fh/ksx+1Fv28nfdftm2QsOyNS+WGpZxl+hqi1a3SGy081YXHJgH67PnCfk/pQmL8a/JEqDz+OnSObwdHDo9ITaR2qYSiUQlM4tloSwI6VDJYjU6bSWYYxixfDpt/S0J/h4/8QQzJgs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=YxWhcEwR; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a8a706236bfso353403466b.0
        for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 00:19:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1726643942; x=1727248742; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TqYtJ8YuLXQL4jCoAoDYqm0N+vE0UnC4CwyzicEGN7M=;
        b=YxWhcEwRPxjk7V/FkG2DNA+OeZA+jMj0QgF46dQSjC3RyVAjThHH5ArPvL2BrgTQfd
         gYA/TIKbkQNl0REyovcGHqrYG/g9kSGPzSPegpEnZq3reyYMMF3bIspe0Z2scKDvgDeh
         7+oLPJzk/YmAZR3XDLJ7wZThirJU5LcY/ZoGA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726643942; x=1727248742;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TqYtJ8YuLXQL4jCoAoDYqm0N+vE0UnC4CwyzicEGN7M=;
        b=kaku3zwkgEt7CXRi9g8YvW5deBens9mqJ5cLar6guP9ioj0TXLXbIu97A+vp8tUxiL
         LVeQPr3a4SlKNXwuurlm3vw2MIxBqXmin9YcsVGBnjkowXeqSWr81kNqCdQ18xo22rmM
         MOUmo9e1TEGW4TOptxDaKRp/Qao3LYCu8a9c3yIfkzQlRv0SwUHR2wM0AHkwuMHxAZTD
         1ASjFrL3G9V9HA9hfk6naCfRJ/oneVSO0lUubljbPbKc7BV+F92sj1Bb2Cg6SC8CXFLF
         MLRxH7Q+dLD5vjg4uJLx2dd++uhSO/rAQwK6X/s+TGE32ke3Vqfs/0pBSB0nrGDHqDns
         jnFQ==
X-Gm-Message-State: AOJu0YxIgC955sp57SdiAM2K9C42Z8LfPncXWf+N1+qOLStcQyDw2QMs
	C+LRgp3QYRMyE0x1XYD4IWU3UPa28A5jwdfQDbpaybXn5PSYgtsOISj1PSOJIo+eNGYBq87m60t
	tPsXg9Q==
X-Google-Smtp-Source: AGHT+IHSZkghdwo/znW04gSNZooEnaWWbcsaIJ/J86YcGffNChByDNFRYSEegCvvkohRvugXv2PefA==
X-Received: by 2002:a05:6402:3596:b0:5c4:2e8e:782f with SMTP id 4fb4d7f45d1cf-5c42e8e99f6mr21294739a12.17.1726643941865;
        Wed, 18 Sep 2024 00:19:01 -0700 (PDT)
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com. [209.85.208.44])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c42bb94a19sm4510299a12.83.2024.09.18.00.19.00
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Sep 2024 00:19:01 -0700 (PDT)
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5c42c3aac99so3166917a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 00:19:00 -0700 (PDT)
X-Received: by 2002:a05:6402:4310:b0:5c4:2d14:c725 with SMTP id
 4fb4d7f45d1cf-5c42d14c8b6mr21424243a12.2.1726643940613; Wed, 18 Sep 2024
 00:19:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240917143402.930114-1-boqun.feng@gmail.com>
In-Reply-To: <20240917143402.930114-1-boqun.feng@gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 18 Sep 2024 09:18:43 +0200
X-Gmail-Original-Message-ID: <CAHk-=wi76E2xxvOaZtgN2FK9YKmbK1ru_1atL8eBCs34z7UigA@mail.gmail.com>
Message-ID: <CAHk-=wi76E2xxvOaZtgN2FK9YKmbK1ru_1atL8eBCs34z7UigA@mail.gmail.com>
Subject: Re: [RFC PATCH 0/4] Add hazard pointers to kernel
To: Boqun Feng <boqun.feng@gmail.com>
Cc: linux-kernel@vger.kernel.org, rcu@vger.kernel.org, linux-mm@kvack.org, 
	lkmm@vger.kernel.org, "Paul E. McKenney" <paulmck@kernel.org>, 
	Frederic Weisbecker <frederic@kernel.org>, Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, 
	Joel Fernandes <joel@joelfernandes.org>, Josh Triplett <josh@joshtriplett.org>, 
	Uladzislau Rezki <urezki@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Lai Jiangshan <jiangshanlai@gmail.com>, 
	Zqiang <qiang.zhang1211@gmail.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>, 
	Mark Rutland <mark.rutland@arm.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Kent Overstreet <kent.overstreet@gmail.com>, Vlastimil Babka <vbabka@suse.cz>, maged.michael@gmail.com
Content-Type: text/plain; charset="UTF-8"

On Tue, 17 Sept 2024 at 16:34, Boqun Feng <boqun.feng@gmail.com> wrote:
>
> This series introduces hazard pointers [1] to kernel space. A TL;DR
> description of hazard pointers is "a scalable refcounting mechanim
> with RCU-like API". More information can be found at [2].

Please give actual "this is useful for X, and here is an actual real
load with numbers showing why it matters".

We don't just merge random infrastructure without a use-case and an
argument for it.

                 Linus

