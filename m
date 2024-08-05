Return-Path: <linux-kernel+bounces-275228-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 00F3C94821A
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 21:14:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B6091F2365A
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 19:14:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0957216B396;
	Mon,  5 Aug 2024 19:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uif/A8S7"
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0F57165F1B
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 19:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722885259; cv=none; b=Zj6ehRFq3QRfFETzaN1THo7xoObAGyhdYvJAsijV5LXB8UZy9IaB407mVaZajpL8pZZOPh8nILi1fTR0YuqQ0nmGYqVCHVY/q/aCL1M76spS73OS1OlyvE3ejuitJ2TsrdbUTyqWTjG1susetuuklOTz7jgwirXT/Cl2Lq1ezrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722885259; c=relaxed/simple;
	bh=3l7TBcOxCnbhG74ZJduzxWd/4AXV0T8TIJo3s/McpNo=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=UmPuR6ReTR+1rfRcm0nD0fuDT1GxuXl2cXBAIQ0bTjpwN20ydn4XYS4Aq0uBElTLytN5m3jSzHZQ0m2gx9Gcx8ocGzRBYBP8ZhtdU7Bx5CnYfRyPkjGmuAnJMsv9XLc2fRNgwlMYl+KtEFAgILy7wghILOEEZwC4lESTuVFi7qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uif/A8S7; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-3d9e13ef9aaso7666359b6e.1
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2024 12:14:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722885257; x=1723490057; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=d+yVWsX9O71c5CmAuQlWs0BaPbMW78Zm7yHDtPFLq7k=;
        b=uif/A8S7ga2ZlDgnuW3EMSPQDy2H6YMQ+Z/tPfGPgoolm1KNpiaZwHptgLe+uOimbw
         ndfMVSYFXy7JasyRLsHCp4BPiWyxrHb9wS7y79YNypPsF31n7478NQ0kNRDXs5dw+hxT
         kTOVPlqim/3oaoaPkuR1Y4B0khSPfXk+K4VV8/GmiRxSbyRWK9caBTyqOz2LxgI5cxR6
         0bzVFPsH9wnBcYOAqyTwwMhJINEALihxgSk5zk5lb/cFODICfHKa5oNUUDU+QgFRkT++
         w4KPVqqpTLoZ6a2zAEnlrrHHrZu26JnU+W+1wxWIDmrPbA9tKIk5zK9nQP9N4NKKXjPf
         dKzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722885257; x=1723490057;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d+yVWsX9O71c5CmAuQlWs0BaPbMW78Zm7yHDtPFLq7k=;
        b=UtphAuYNZLS2kTdgt4P3iO/ECwqR9vV6tgZ0BY96SJc8te/q7AXgku27jYGzoIp15y
         f5ZKwIcSfnR1AZncCNRrf2imJYCzJj53FDhYTXOsSnRVNZlTj85s0+TwyZfd6tygmkya
         F6K6VfDFtFVMc6lZ03bevOGfSq0xC6bMzHQl393tnR8oK08cIUwSD/5CqgCXgWluuJvX
         KkhPesVcytDDVl/JYDRwRz+3ep+G4JWMFqw1WFnmq0npN9Mp8l1QqOf8XMsYbuRdZ/Rp
         yY5HlE1eMY3xAQwIem2wuXFwelbqcJvENMeICSRcUwfMGVUCDkMEbeMXKOgpdOGY9nA+
         /iGA==
X-Forwarded-Encrypted: i=1; AJvYcCXaTbumIweO2oOMvMMgRqFOtVX2ww0UKcq4Pj9Sxikl8nvxNs3DCLe1FlMr9GvjxH2rkGZFTm4q8NBAmfWe34UQOjxbKNrP0v0DkAgC
X-Gm-Message-State: AOJu0YwnkI99iRpA7/4yaNE3J097YyKX2ydidEPuFMu5Gvs8CUl4wzfc
	DIHMjrI334C7hXfPW62QloLiZgo/ResAoeYDlbXSicvCZn4CM+6iBjMYjLKtew==
X-Google-Smtp-Source: AGHT+IEN5hqJaUD8lfzfLj831X3oY9F63MttOy3VZvLij11/G54SgwjIXoBQ+g9I2rzPksdXJHwR4Q==
X-Received: by 2002:a05:6808:2006:b0:3db:2afc:b19 with SMTP id 5614622812f47-3db55800e1dmr17493174b6e.12.1722885256559;
        Mon, 05 Aug 2024 12:14:16 -0700 (PDT)
Received: from darker.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3db56362fa7sm2852642b6e.8.2024.08.05.12.14.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Aug 2024 12:14:15 -0700 (PDT)
Date: Mon, 5 Aug 2024 12:14:05 -0700 (PDT)
From: Hugh Dickins <hughd@google.com>
To: Yu Zhao <yuzhao@google.com>
cc: Hugh Dickins <hughd@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
    Barry Song <21cnbao@gmail.com>, linux-mm@kvack.org, 
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH mm-unstable v1 5/5] mm/swap: remove boilerplate
In-Reply-To: <Zq_0X04WsqgUnz30@google.com>
Message-ID: <9cf6f6fe-c2ce-3442-1593-c33ed77a82bb@google.com>
References: <20240711021317.596178-1-yuzhao@google.com> <20240711021317.596178-6-yuzhao@google.com> <714e77d3-f629-bc06-4808-f7f33ac6872d@google.com> <Zq_0X04WsqgUnz30@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Sun, 4 Aug 2024, Yu Zhao wrote:
> On Sat, Aug 03, 2024 at 11:55:51PM -0700, Hugh Dickins wrote:
> > On Wed, 10 Jul 2024, Yu Zhao wrote:
> > 
> > > Remove boilerplate by using a macro to choose the corresponding lock
> > > and handler for each folio_batch in cpu_fbatches.
> > > 
> > > Signed-off-by: Yu Zhao <yuzhao@google.com>
> > 
> > Andrew, please revert this "remove boilerplate" patch (and of course its
> > followup fix) from mm-unstable. From the title I presume it was intended
> > to make no functional change, but that's far from so.
> > 
> > Under tmpfs swapping load, on different runs I see various badnesses:
> > "Bad page" in __free_one_page(), Oops in __run_timer_base(),
> > WARNING at kernel/workqueue.c:790 in set_work_data(), PageBuddy BUG
> > at page-flags.h:1009 from __del_page_from_freelist(), something (I'd
> > given up taking better notes by this time) in __queue_work(), others.
> > 
> > All those were including the fix to Barry's report: without that fix,
> > the boot is drowned in warnings scrolling past too fast to be read.
> > 
> > (All the above were on the HP workstation, swapping to SSD; whereas on
> > this ThinkPad, swapping to NVMe, no problem seen at all - I mention the
> > swapping medium, but have no idea whether that's a relevant difference.
> > In each case, MGLRU compiled in but not enabled. THPs and 64kTHPs active.)
> > 
> > Sorry, but I've put no effort whatsoever into debugging this: "remove
> > boilerplate" didn't seem worth the effort, and my personal preference
> > is for readable boilerplate over hiding in a macro.  If you prefer the
> > macro, I expect Yu can soon come up with a fix (which I could test here):
> > but for now please revert "remove boilerplate", since its issues get in
> > the way of further mm testing.
> 
> Sorry for getting in your way, Hugh.
> 
> Apparently I didn't expect local_lock_t to be zero length, i.e., when
> CONFIG_DEBUG_LOCK_ALLOC is not set. So that might explain why you only
> had problems with one of the two machines, where it failed to disable
> IRQ when rotating clean pages after writeback.
> 
> The following should fix it, in case you want to verify the above:
> 
> diff --git a/mm/swap.c b/mm/swap.c
> index 4bc08352ad87..67a246772811 100644
> --- a/mm/swap.c
> +++ b/mm/swap.c
> @@ -254,7 +254,7 @@ static void __folio_batch_add_and_move(struct folio_batch __percpu *fbatch,
>  		folio,										\
>  		op,										\
>  		on_lru,										\
> -		offsetof(struct cpu_fbatches, op) > offsetof(struct cpu_fbatches, lock_irq)	\
> +		offsetof(struct cpu_fbatches, op) >= offsetof(struct cpu_fbatches, lock_irq)	\
>  	)
>  
>  static void lru_move_tail(struct lruvec *lruvec, struct folio *folio)

Well caught! Yes, I confirm that fixes all the bad behaviour I was seeing
(and fits with my having DEBUG_LOCK_ALLOC and lockdep enabled on the
untroubled machine, but not on the one showing problems) - thanks.

But it does reinforce my opinion that mm/swap.c is more understandable
without that macro than with it.

Hugh

