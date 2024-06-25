Return-Path: <linux-kernel+bounces-229043-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E5CDE916A21
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 16:20:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 811C0B25564
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 14:20:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA5FE168C33;
	Tue, 25 Jun 2024 14:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="PAUDX098"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2422130AFF
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 14:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719325207; cv=none; b=T/k8N119MWDK+ykF447gs7mZG2qI/P5b6UouyL78KXU9ioTCNMCB1B4KFIhZqSQ+EcBYHY31LSzgL3HiFi7X5v/bvcD/WkbAsVYspmvnDVWDmtpNq7Q6g0qs8kWU7ojeO9J19Vv8l0tYwzZVFyPBrnE3ypZ4/qvk+S0Gdlq0kqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719325207; c=relaxed/simple;
	bh=5BS9G1Um6RpL2uriUeKOOJiuIUTQaBfOsN9f2KEaAZg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OvCw8xyGo7gKgYk5NLlttvORDQVjpiBQkWcAKlxXcEY/zSHwhLessQf5fPRVdm0T+FkoQE4w0/0OKr5CBT48qnK2FbSvmGSQA6W7FWH0AfWcq9nVo5Xxx/BNfGCCj10gxkUfpA7x6hqlvnEptwtp6ecLYjC9xe/8KwYLbJNeaHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=PAUDX098; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a724e067017so313864666b.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 07:20:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1719325203; x=1719930003; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dL3pPbdoGh1VeCti9GYli9glNyTGQGtxsbxosMgkxhA=;
        b=PAUDX098ujs+DZ2wY+AHuG7UKXFiw9PMts+RB9tiI+P1i1z01MOkNcJx1hPktwVw/m
         VDutpeeFjHJGM6I4oRr581oYMpRt5KuFamT154HLGmuaTh0WK1dDox0RiUAgDR35GOVn
         3iGqhpdC68mSsccBKSiuC3ygngGdwFXWtKI2EG5v5kAG/gMLBn7r7goy3tWuro4woiDA
         3DAcMWpZ/+VOY8S6pbWNuI6+0PR7SrpKwJcFFj8y3UL8z2NTY2m2LBpMRJhCMmh45tB5
         c7hC8lW7wWcFpFxTA/yz/OLZ4RjuvT4L21xR16gjCDh0aFef4k0kZ1046j9F/HS5hatw
         MLEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719325203; x=1719930003;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dL3pPbdoGh1VeCti9GYli9glNyTGQGtxsbxosMgkxhA=;
        b=Hzqsj3xKXkM537RXbg2Uw6csztaZsDN/y9ype457bxBtA2cMDsTDBsE3S9ZMAsTvLE
         LZGindElZsaxPJLCAf0LeakK0A1zoY6uKeZ7LM3T3QzaRqyO9JmBrlpZmNsLwVQAOHJe
         AE4krJuajq5dGO8WlJS9EKjHbP/+6EgWJusEWvtAeNs+jjaL4XY33izLvD9zzD9Vferm
         Uu1G7nP5W58OZrw8tpst1eM7YtRxuLBSt7N57EXehhPNPS5u9Kz3+S2T5GbiShYXBd+J
         IYTOJlOF5YOIyeWeoJh9X++JwSwFiFvW0sar6rhW+EJ5n9sPlAtGJF9M8NTAKzt+0FS7
         5igg==
X-Gm-Message-State: AOJu0YwKclGnSfcwDSzGTl4/LUUwP5D1zjE9jEp+VNLVlgZEB/jTXzUl
	XvvD52QHPDzDC68bJ+Tcs5YNZsQSohPELWk9Q34eRQGwGqj9sSrrXO8zWsilPtc=
X-Google-Smtp-Source: AGHT+IGznf2yj9q4zpCi7c+gsltYKjD4hFFmpntpywlOFbX3OghzIJh8EEEactqTgGa4iPkJ05kg8g==
X-Received: by 2002:a17:906:70cf:b0:a6c:6fac:f1ff with SMTP id a640c23a62f3a-a7245b4cbd5mr447076666b.12.1719325203185;
        Tue, 25 Jun 2024 07:20:03 -0700 (PDT)
Received: from localhost (109-81-95-13.rct.o2.cz. [109.81.95.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7251563486sm245185266b.88.2024.06.25.07.20.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 07:20:02 -0700 (PDT)
Date: Tue, 25 Jun 2024 16:20:01 +0200
From: Michal Hocko <mhocko@suse.com>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Andrew Morton <akpm@linux-foundation.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Oleg Nesterov <oleg@redhat.com>
Subject: Re: [RFC PATCH 6/6] mm: Drain LRUs upon resume to userspace on
 nohz_full CPUs
Message-ID: <ZnrSEf1xuFxKxj1D@tiehlicka>
References: <20240625135244.20227-1-frederic@kernel.org>
 <20240625135244.20227-7-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240625135244.20227-7-frederic@kernel.org>

On Tue 25-06-24 15:52:44, Frederic Weisbecker wrote:
> LRUs can be drained through several ways. One of them may add disturbances
> to isolated workloads while queuing a work at any time to any target,
> whether running in nohz_full mode or not.
> 
> Prevent from that on isolated tasks with draining LRUs upon resuming to
> userspace using the isolated task work framework.
> 
> It's worth noting that this is inherently racy against
> lru_add_drain_all() remotely queueing the per CPU drain work and
> therefore it prevents from the undesired disturbance only
> *most of the time*.

Can we simply not schedule flushing on remote CPUs and leave that to the
"return to the userspace" path?

I do not think we rely on LRU cache flushing for correctness purposes anywhere.

Please also CC linux MM ML once the core infrastructure is agreed on.
-- 
Michal Hocko
SUSE Labs

