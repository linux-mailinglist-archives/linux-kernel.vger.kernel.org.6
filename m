Return-Path: <linux-kernel+bounces-222793-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A2CBC91079C
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 16:10:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D13511C211DF
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 14:10:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2A3B1AD4B6;
	Thu, 20 Jun 2024 14:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QxEUg2yT"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14BAD1AB91B
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 14:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718892621; cv=none; b=eB1F+whaijfCMtwdMlH5Z8q3iRoKqwy5fV8uMoHN7Ly3MNFU3jqOcWmDECekqBdBJTC/VdWmIsLXuXdJEnOI+7qFckEQtzmo5IfVmCLD/aKtv91CJ8UVhTXS+9h+9BXz2G1Q+D5vV3k9AcXvVbfWXjL3AfLKNmuv1Cepz5Bir7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718892621; c=relaxed/simple;
	bh=x3UEEUew9N5uwAVDG2HfKtAynJHLalbXOUb+YS8n1QY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QvmsQKc5i7AgHqS3zQ8zsIfLe2PYQayqMAGOiAx7eCeMvdKmNCuQGbXPCFk6J95qTd+ZRrXxESovbQZgksh4DUzLSutBQC1fLt53T9fGkT0V07itmv+tDsDgs1bblD2KNDAYoj+z1ocj9pr0NiwEcM7SF+J+WwboH1192OQ2jgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QxEUg2yT; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718892619;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EgoF4xbfDzcZ+9TWeQokZXplXkAeH6KWftfX8EicHos=;
	b=QxEUg2yTU3QtbLrcgyA0lSYu8tCz/0M+KWMkaM0wYp/TjKBSXtSI+sYzcq0i131T/LXyX1
	Ce4Mb7hTmqozLgS2nYMP+mCaQ3ZO6p1pLP0dIdryGi+1Y8Qoc3Mg1ZP9llUmSFBgje8ZdI
	2nvRuhF5yDFRwkdfysAqC4JjKHfWmwU=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-136-Z4k7oFIuOaCmu3k3bTV5gw-1; Thu, 20 Jun 2024 10:10:17 -0400
X-MC-Unique: Z4k7oFIuOaCmu3k3bTV5gw-1
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-792ff5345c6so95122285a.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 07:10:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718892616; x=1719497416;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EgoF4xbfDzcZ+9TWeQokZXplXkAeH6KWftfX8EicHos=;
        b=wvw4g71rBpzywgB6rTE9g2Thtj1NvJGK95O3vKN3ZCVP0vimrt4brdJvEL1Rb+wjq9
         QuIcbxBQyhG+MR96EW5uBbHdOP6JwdwR+UvkjiS98BpkbdFTVqYw5A3D6KG1u6kzoch1
         WCsZ8EtzaSr92WnGctc4OdKdcPJ+Gua3Sd8YdzmT3unvq+/UVffp7kDModji3EMC5B64
         0ydDjNzJdMOIX6Nmwb/ygZs68+bIW5o+R21ij4aGjFMX5X9tl2/3zMn8nA8TfeOJFGTg
         DufpmLSLo6mZuOhjOvO/9EU2+cGUXHkzxTSOYOKQgWPARvv8iyUZJMV/U4awkSGx0+6P
         Vbgg==
X-Forwarded-Encrypted: i=1; AJvYcCUbd/KGGhzManG+la+AXNnstG0Fc4bsaOgczh9REN3YRvIJs2lJAt8hVVo1hVt3/LCzsZhpXK8QceWg3m/vi+xqhUuHOFG/rEWY94Q1
X-Gm-Message-State: AOJu0YzkEi10OOBtOv6xPO1dkaskrl8IN385kHTTj1vrFk6R+P85Lwdx
	Xm6Baz7NURhcWLVC5GKCdC5IdWgpQmLBLqC7hiM/kUL8P0wWU8D2tqxLK7Oiy4pb8/9y0QFeQ0E
	MDDKfWnDg0cRAH0dqteMgEYlNkaVLRmALrzJB6+rt8/98tDEQxJUIKDQGexavIg==
X-Received: by 2002:a05:620a:1a89:b0:792:c32f:caf0 with SMTP id af79cd13be357-79bb3ee1913mr596570585a.70.1718892616536;
        Thu, 20 Jun 2024 07:10:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFP8ld6TKKsUClR3j1PX+MKQsLFfGoYvyA37bK6/EiMinUJGEauZwG2wPLDyfuVrEBcMpoGEg==
X-Received: by 2002:a05:620a:1a89:b0:792:c32f:caf0 with SMTP id af79cd13be357-79bb3ee1913mr596567785a.70.1718892616112;
        Thu, 20 Jun 2024 07:10:16 -0700 (PDT)
Received: from jlelli-thinkpadt14gen4.remote.csb ([176.206.3.168])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-798abc06e93sm696807285a.82.2024.06.20.07.10.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 07:10:15 -0700 (PDT)
Date: Thu, 20 Jun 2024 16:10:11 +0200
From: Juri Lelli <juri.lelli@redhat.com>
To: Wander Lairson Costa <wander@redhat.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Valentin Schneider <vschneid@redhat.com>,
	"open list:SCHEDULER" <linux-kernel@vger.kernel.org>,
	rrendec@redhat.com
Subject: Re: [PATCH v2] sched/deadline: fix task_struct reference leak
Message-ID: <ZnQ4Q72H7oNOnJ4Y@jlelli-thinkpadt14gen4.remote.csb>
References: <20240620125618.11419-1-wander@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240620125618.11419-1-wander@redhat.com>

On 20/06/24 09:56, Wander Lairson Costa wrote:
> During the execution of the following stress test with linux-rt:
> 
> stress-ng --cyclic 30 --timeout 30 --minimize --quiet
> 
> kmemleak frequently reported a memory leak concerning the task_struct:
> 
> unreferenced object 0xffff8881305b8000 (size 16136):
>   comm "stress-ng", pid 614, jiffies 4294883961 (age 286.412s)
>   object hex dump (first 32 bytes):
>     02 40 00 00 00 00 00 00 00 00 00 00 00 00 00 00  .@..............
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>   debug hex dump (first 16 bytes):
>     53 09 00 00 00 00 00 00 00 00 00 00 00 00 00 00  S...............
>   backtrace:
>     [<00000000046b6790>] dup_task_struct+0x30/0x540
>     [<00000000c5ca0f0b>] copy_process+0x3d9/0x50e0
>     [<00000000ced59777>] kernel_clone+0xb0/0x770
>     [<00000000a50befdc>] __do_sys_clone+0xb6/0xf0
>     [<000000001dbf2008>] do_syscall_64+0x5d/0xf0
>     [<00000000552900ff>] entry_SYSCALL_64_after_hwframe+0x6e/0x76
> 
> The issue occurs in start_dl_timer(), which increments the task_struct
> reference count and sets a timer. The timer callback, dl_task_timer,
> is supposed to decrement the reference count upon expiration. However,
> if enqueue_task_dl() is called before the timer expires and cancels it,
> the reference count is not decremented, leading to the leak.
> 
> This patch fixes the reference leak by ensuring the task_struct
> reference count is properly decremented when the timer is canceled.
> 
> ---
> 
> Changelog:
> 
> v2:
> * Add the fixes tag
> * Add a comment about canceling the timer while the callback was running

Uh, looks like these bits above should come after the SoB section so
that they are ignored when applying the patch? But, maybe, Peter, you
can fix that if you decide to take this version?

> 
> Signed-off-by: Wander Lairson Costa <wander@redhat.com>
> Fixes: feff2e65efd8 ("sched/deadline: Unthrottle PI boosted threads while enqueuing")

Apart from that

Acked-by: Juri Lelli <juri.lelli@redhat.com>

Thanks!
Juri

> ---
>  kernel/sched/deadline.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> index c75d1307d86d..9bedd148f007 100644
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c
> @@ -1804,8 +1804,13 @@ static void enqueue_task_dl(struct rq *rq, struct task_struct *p, int flags)
>  			 * The replenish timer needs to be canceled. No
>  			 * problem if it fires concurrently: boosted threads
>  			 * are ignored in dl_task_timer().
> +			 *
> +			 * If the timer callback was running (hrtimer_try_to_cancel == -1),
> +			 * it will eventually call put_task_struct().
>  			 */
> -			hrtimer_try_to_cancel(&p->dl.dl_timer);
> +			if (hrtimer_try_to_cancel(&p->dl.dl_timer) == 1 &&
> +			    !dl_server(&p->dl))
> +				put_task_struct(p);
>  			p->dl.dl_throttled = 0;
>  		}
>  	} else if (!dl_prio(p->normal_prio)) {
> -- 
> 2.45.2
> 


