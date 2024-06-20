Return-Path: <linux-kernel+bounces-222308-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 568B690FF85
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 10:53:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 495FA1C21699
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 08:53:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 192C91AB524;
	Thu, 20 Jun 2024 08:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G7Gj16yM"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA45B19AD82
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 08:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718873401; cv=none; b=HW3waFOZBgOQzavAclcUMQg/fLxp+SRld9pO1RUV9CbzXbYDEhn9hClea4WE6R7uOyeMziso2c02Yn4Cko2apnwXZEMO2+AYgKcjvT2nxL+whzqH0z/ZtNUnVj1iRpFHKFO2sY4l3+8HZB4csfRPs0Vd2D2p1jqCvcqOnKtbSlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718873401; c=relaxed/simple;
	bh=bzculCUZfSMGCYqXnDb6dR+6gSGS8cxRKKu9enu6sOc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GRMyhFmVY7qZGDr0vrFB4L/pgPVQRYC6yp7YPKIBdWTvCJWnC0Dx1FxI+FXncIQ7h5VYgzQze0NsfSfLqtVSSKqagheoTEoSVlB8WZKuaeZlB1oqc+4ZSA+iRyOnc5Ha8hOug5dFepjerfpyBDhaEmkw0VDfo3vncwj2BfDSqKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=G7Gj16yM; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718873398;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=11iF2QK5flj/EkneGZ7Z1E7DadmY5aiwT25VCdi5z3s=;
	b=G7Gj16yMTHkmOBMjn/GM5krT2BCuCTxV38q4LuASQpPgEpBbjMbSKcyPO+xefxX3NQmqBW
	S7iyhZX/qLy6+GmgOre8D06graMraQGMh5DMAdenNEQLLBpzxg/kmM2J6qdQ7r4kBzGDti
	+J095+YLa2LVl6W8ajaD1PaDbUxjTWQ=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-687-R8wVTYEPOEGiqmE2rt59XA-1; Thu, 20 Jun 2024 04:49:57 -0400
X-MC-Unique: R8wVTYEPOEGiqmE2rt59XA-1
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-795589ae41fso112706685a.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 01:49:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718873396; x=1719478196;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=11iF2QK5flj/EkneGZ7Z1E7DadmY5aiwT25VCdi5z3s=;
        b=rDt6NuOQkAF8AL9eGSuJJqqpMc3o82mUPMrPISVr8k+pTk0+rDLXHVu+QCW0VvI+HD
         UTRFf0tdpXcBn0+SFarBuWCSijAnj7BFJBslSHonB3at+bXA579om+6Ws6KY9d4kMuDi
         ZSa+tdCyrAthzneLgXGayGhJCqAt23DQzYZ134pXGj1FsNK+tQgKDB+WKEf/ddNr1Frx
         cMaQKr66674G7oeIUceUeVEQWuyYtch6WcL7BxZFUyPMDW1d23Tzp1QyMyrCBZaEzott
         c4iCjkm/23wfxh8gdm3Kk9ScQMpVUrlsdrjvCkRpzfmkBc0D9ky9IMaa/L1Zt6Bn6PfE
         8YZg==
X-Forwarded-Encrypted: i=1; AJvYcCWQko0yPkI9q/nsusGrGCUY+jDtizhseNKjpL6knslbkfTImhcQooFIR/ox0G2Izo7xLyid9nFhUwmum33CoGPvcM5QlUk1rXZFD7JG
X-Gm-Message-State: AOJu0Yxb2Z3MttqkE0/0BaoyU5oZNKV7zwm8cyq0n5dhYX3QvBwpPBvJ
	/8lE9eb5iVrHWcrwm3VXppSPT1ueZQxnutaii7GDsvrcDNIKxQCXml8fexyibuSpF/guKjBW4ID
	4javN134shmd8M3MOLCNYaSuUvCuKf+Ut9WIzKKN90a8hxiAI6jVAQFL/ku5WQg==
X-Received: by 2002:a05:620a:4016:b0:795:5ab3:ba5b with SMTP id af79cd13be357-79bb3e3acc9mr487928985a.32.1718873396709;
        Thu, 20 Jun 2024 01:49:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEMWNNkzfAixl8czMPiKE9yMZGywPk4gvxEmIU6adP1ZFuF5GVoBwIIFYUdC+82dqVjHbKhFA==
X-Received: by 2002:a05:620a:4016:b0:795:5ab3:ba5b with SMTP id af79cd13be357-79bb3e3acc9mr487927185a.32.1718873396388;
        Thu, 20 Jun 2024 01:49:56 -0700 (PDT)
Received: from jlelli-thinkpadt14gen4.remote.csb ([176.206.3.168])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-798aacae6e3sm677075785a.10.2024.06.20.01.49.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 01:49:55 -0700 (PDT)
Date: Thu, 20 Jun 2024 10:49:51 +0200
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
Subject: Re: [PATCH] sched/deadline: fix task_struct reference leak
Message-ID: <ZnPtL055-NxMwMKl@jlelli-thinkpadt14gen4.remote.csb>
References: <20240618201940.94955-1-wander@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240618201940.94955-1-wander@redhat.com>

Hi Wander,

On 18/06/24 17:19, Wander Lairson Costa wrote:
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
> Signed-off-by: Wander Lairson Costa <wander@redhat.com>
> ---
>  kernel/sched/deadline.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> index c75d1307d86d..5953f89bfa96 100644
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c
> @@ -1805,7 +1805,9 @@ static void enqueue_task_dl(struct rq *rq, struct task_struct *p, int flags)
>  			 * problem if it fires concurrently: boosted threads
>  			 * are ignored in dl_task_timer().
>  			 */
> -			hrtimer_try_to_cancel(&p->dl.dl_timer);
> +			if (hrtimer_try_to_cancel(&p->dl.dl_timer) == 1 &&
> +			    !dl_server(&p->dl))
> +				put_task_struct(p);

Wonder if this deserves a little comment saying that if the timer
callback was running (hrtimer_try_to_cancel() returns -1) it will
eventually call put_task_struct(). Other than that, the fix makes sense
to me.

Oh, another thing is that I believe we should add 'Fixes: feff2e65efd8d
("sched/deadline: Unthrottle PI boosted threads while enqueuing")' in
the changelog, shouldn't we?

Thanks,
Juri


