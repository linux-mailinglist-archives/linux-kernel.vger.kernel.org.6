Return-Path: <linux-kernel+bounces-275531-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B16F29486E2
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 03:05:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC6EE1C22352
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 01:05:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C3666FD5;
	Tue,  6 Aug 2024 01:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YzxEzO1F"
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 732B23D62
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 01:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722906328; cv=none; b=OIqJg/W/QWexfo0KELGOX+fKorkOmzKbsnjvXjkAfIo20l1WNvGi7quxW8cAGF8z0xJ+/0K3a1/XKXMwXx7Iv7FXg6c0xGBycElDOMcNe051UPG53uf1MQPaFvlLWtnuhU830CfEUb99pWXYyAcOFzwnURBfteoiqW6mJHnb1Pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722906328; c=relaxed/simple;
	bh=EWIVw3BD5pZ9LYfI27N3hczCVsae/1ZQC5jUV+hg/Gs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J087K3aYFc69FOGWFFCJXGVtf79oqBxylT+fdOubc+jY8rdyVB30iYGE0R7hK6MkAEfSo4ya/vH5HMShkHzEFaJt1PewM3TT9DEWcQq7BYN9KLJmQcVxggKnwMRwIPiKjjcgL7bGtAAkbiFt35+XQiTDkh7R2y8pBurvwbMC02I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YzxEzO1F; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-70b3b62025dso449741a34.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2024 18:05:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722906326; x=1723511126; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cgHEXBLzdjfR1flI96zKqgpNHrnaCn0RVRpjPfksRBM=;
        b=YzxEzO1FGxZuDWTBFla0PghlTjz0rk4v9GFOwDDuQ+gDF3yUGaamtD2envekeS/5yU
         NirnV2pGywRAKPc5SQi2/GkBKyqDS8L7dZqvGuEUYB3yqaue85S7lG5T1eF0yeSjmoJb
         fBsaIT4QiVWE898ebDYS0Eybgtir8eKXhrVdHXvruQ1IpXw8XWsMUhVoPR91c5TVYEWY
         1rpQRxXWrv3WJS0mVxNY8zVl53EZYyV/m6DjIzev/ZE2I021/1M1lULjfaF86Og3gorj
         /8ji+7UrLG40bhPHlmzF/0omnqp77saYSrdUy+lUDZSzNrEMKICfs2xu11sO35P9B9wE
         CHXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722906326; x=1723511126;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cgHEXBLzdjfR1flI96zKqgpNHrnaCn0RVRpjPfksRBM=;
        b=taSH4DtnDzvpWqBJl4i/nNKo3Ln6q2oBfa8N8fUA7VI7TyPKCsxkXw8F4pnj8vfB6Q
         w42WlV3DLce+qO8O9QUZOa0NhyoKziNIeDYhZ6H2ro4N+xVX0hk4v5zS88FydKQSu2Jw
         PZMrmoAv1kgT3LCUZYv9un/Db1Sx/nZGZjCQJouawmiEo23as3YbPP8Ahyh1GEP5AhWb
         fHWNzSrKb03deA8QJVuqVGW3GlmrKV6DozPKNXGyYizIoHn+rvm6Drfonb+O1quPrENS
         hESvK2c4d+kTdhoC+T5NvMG1AkEkW8zc3rbl9Y6aK7a0jGAsBF4YTx64urp7NjTciCQ9
         Iw8A==
X-Gm-Message-State: AOJu0YxrdHmh1n9vzBah98FFR810SzvvoEvQU7casnPc0gnQZ0sytSdp
	wTf/YUKPQPQ+Mx4T2wwtxNGBIdeKOJakkO+2eqpDAhI7ZJCn+2Uz1qPluzziSw==
X-Google-Smtp-Source: AGHT+IFZSqUe07+gWoVDJrLCl9r3PrZY3R04PnGB2hlgedOYvkft6In9wyh/t33eBaiNTM/qmdAuog==
X-Received: by 2002:a05:6830:6e19:b0:704:8660:2672 with SMTP id 46e09a7af769-709b996e591mr23789589a34.25.1722906326379;
        Mon, 05 Aug 2024 18:05:26 -0700 (PDT)
Received: from google.com (57.145.233.35.bc.googleusercontent.com. [35.233.145.57])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7b762e9c066sm4934403a12.13.2024.08.05.18.05.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Aug 2024 18:05:25 -0700 (PDT)
Date: Tue, 6 Aug 2024 01:05:22 +0000
From: Carlos Llamas <cmllamas@google.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, kernel-team@android.com,
	"J. R. Okajima" <hooanon05g@gmail.com>,
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
	Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v2] lockdep: upper limit LOCKDEP_CHAINS_BITS
Message-ID: <ZrF20rJmu2RwQ4V5@google.com>
References: <11faf952-c0f8-6e1d-3560-12d77847a8ac@i-love.sakura.ne.jp>
 <20240723164018.2489615-1-cmllamas@google.com>
 <20240731164823.c8ac96ab0f8968ce8213c02d@linux-foundation.org>
 <ZrEuz9bjZcBq6jNG@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZrEuz9bjZcBq6jNG@google.com>

On Mon, Aug 05, 2024 at 07:58:07PM +0000, Carlos Llamas wrote:
> On Wed, Jul 31, 2024 at 04:48:23PM -0700, Andrew Morton wrote:
> > btw, the help text "Bitsize for MAX_LOCKDEP_CHAINS" is odd.  What's a
> > bitsize?  Maybe "bit shift count for..." or such.
> 
> Yeah, maybe a _SHIFT suffix would have been better fit for these configs
> instead of _BITS. Similar to PAGE_SHIFT or NODES_SHIFT. Anyways, I can
> send a patch to improve the help text. How about something like:
>    "Size for ... (as a power of 2)"
> 
> I'll also send a separate patch to fix the rest of the upper limits. Any
> of the (1 << 30) shifts allocates static arrays that blow past the .bss
> segment. Just as originally reporeted by J. R. Okajima.

Ok, I've sent a patchset for these bits at:
https://lore.kernel.org/all/20240806010128.402852-1-cmllamas@google.com/

Thanks,
Carlos Llamas

