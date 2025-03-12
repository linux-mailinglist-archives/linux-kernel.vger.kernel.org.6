Return-Path: <linux-kernel+bounces-557478-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 328D7A5D9C3
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 10:42:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CEF83B2080
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 09:42:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90D1823BD14;
	Wed, 12 Mar 2025 09:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HVbllWJm"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33CA823BCE8
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 09:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741772566; cv=none; b=MPzO887BFw4w8zl+JBW6iNJCXSG+/7AD1S6e498pqRbf32XzVNcTmUBcwpQeBwgq+QVozgNs6ZxGsi34LDENa0bmyz6cwNOx72ZwojjNXFVSfsfhjdtyeo1HaaPFTNEg/6gNKd1P5mHDT71v9Kw0mGYYSUUeCM9JZO2SrzNd/AM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741772566; c=relaxed/simple;
	bh=9BHi7R0N1e0m6MI3+SIcypO7xwKr1WoHcHLF3jQDUW8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KIrpfg+acdjipS9Sza3FRIlIv7EPwfMbYRD/fgZ5KCWvUorTtm2FgctJNmPYYLOqXNUq63hslTCEbTQivzaEd0GvxxgYn8m0bofoN0iR9mKlYOwqBL5JUaeskSk/ovKFs6WVIC/162Nfgg0dY29lgnCu98tcnMTBjvWEHj7T0b0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HVbllWJm; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741772563;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pFXifyzyx3TlWsPdUelbYNzLeb+XPxEQGzXrwyDafsQ=;
	b=HVbllWJmvcnJ4ipNA4Ggx1Hty/bnm4YG7JmVJQcowpi3Dik+9B8rkP/6IJc3wwuiFlknpp
	RmMEAXbUaM6k0Yaug5CV3GHNC4a9wvi7QzE8oTH6fN5UCG+wI77lzSaRvkQ8NgBqzs/76D
	rZX6M0AboqmTK4D4F0JigjDXOI7jVCE=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-595-sjSfhu9XN-qebOJgX-DCSQ-1; Wed, 12 Mar 2025 05:42:42 -0400
X-MC-Unique: sjSfhu9XN-qebOJgX-DCSQ-1
X-Mimecast-MFC-AGG-ID: sjSfhu9XN-qebOJgX-DCSQ_1741772561
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-43cf172ff63so18578725e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 02:42:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741772559; x=1742377359;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pFXifyzyx3TlWsPdUelbYNzLeb+XPxEQGzXrwyDafsQ=;
        b=Ip2h4KUOUf5ktAtupz/2/NTC45gYITybpgtNEb4CZIpBam7BuzN4KQzxClAyD3wyZP
         oKg99R8E9kcAz7UWs0BtO9HmcWZmZTgnv3vJigknPN0DEabXKMmjZSkE0HlnufOCOO4a
         BGKnIZsNqGqgaIVZ25SPKXTawFCFdZH85SPgw8D235OvmA+aG1cWFgTHDWXIkhY/+I5i
         lNbb/oPhCKKWO6lJhIlQJYSBwdTCG+KE456kai9g47kfefv0azgrDFuX4QYIEpDaj/Bs
         sn/lop11Rbp+MRGIpb3ki7PBlzTYgtcUY/3Hwe7do6y3EDbKmPfrm9FIOMyOPDeN/ahu
         Z7WQ==
X-Forwarded-Encrypted: i=1; AJvYcCWpVbetgmJGWKntow3nEyZEvPzJw4Cmyy6SCO4UHtDQy3FZb/xQL9Uc8QtqPO0Ug3CaIx4dB23IYu5y26w=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxLsykn02X5NLBpyoZvbTy75n+/ZWES9BtKumZUI9ePfaz8XtF
	TmltF7E34ge2OfGfkv249DC7QZOGc61Hap3+Wm4yPggbktnyB6yPnKNbGfywRzxMFdmQEhxSGAD
	pCeTLLKFUvTzvJODO9X1M935TdclekHyFvO9PzbAZwhM/tkqSvagozXaJY0A6OYtUfblKUg==
X-Gm-Gg: ASbGncvKu/4PEetonRGPb72gW4s35MZSgtvgm997QcU7Sk1BdVRXo++uR+uJ+QdTh3I
	bTDMdx5U+T8FY73o70tf469HSC/8OOT5j5Dw93rD+pOUu476JaQd4yEimt/kXvqNtg9qikQGeu5
	Vc9pePQ2UNBwluMibDtj43qscYo297MJqNSHJHmEiyLvcRurGnQJTtXTZgUkoQKyg7GJJBRYh1/
	Prj1z2HOn7/T7RjxULeD4pGPZCNCpRNE9SWC3y0rgPUjW7P5yumBxlLdg9w4gfyzz+NhI9R91cR
	n0ybaFZZkJfwzNStICgKVysAMDshiElNKkDdIotZe7U=
X-Received: by 2002:a05:600c:1548:b0:43c:f81d:34 with SMTP id 5b1f17b1804b1-43d01bdbc0cmr60348265e9.9.1741772559297;
        Wed, 12 Mar 2025 02:42:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGIyoWUS2iyHpblJuK/FyfuGkvyqkX/245cGSIo/CYaKp2qCmaR23bGtQM/hs3jXJSEjN8Q1g==
X-Received: by 2002:a05:600c:1548:b0:43c:f81d:34 with SMTP id 5b1f17b1804b1-43d01bdbc0cmr60348045e9.9.1741772558886;
        Wed, 12 Mar 2025 02:42:38 -0700 (PDT)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.29.49.7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912c101febsm20045598f8f.81.2025.03.12.02.42.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 02:42:38 -0700 (PDT)
Date: Wed, 12 Mar 2025 10:42:35 +0100
From: Juri Lelli <juri.lelli@redhat.com>
To: Harshit Agarwal <harshit@nutanix.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] sched/deadline: Fix race in push_dl_task
Message-ID: <Z9FXC7NMaGxJ6ai6@jlelli-thinkpadt14gen4.remote.csb>
References: <20250307204255.60640-1-harshit@nutanix.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250307204255.60640-1-harshit@nutanix.com>

Hi Harshit,

Thanks for this!

On 07/03/25 20:42, Harshit Agarwal wrote:
> This fix is the deadline version of the change made to the rt scheduler
> here:
> https://lore.kernel.org/lkml/20250225180553.167995-1-harshit@nutanix.com/
> Please go through the original change for more details on the issue.

I don't think we want this kind of URLs in the changelog, as URL might
disappear while the history remains (at least usually a little longer
:). Maybe you could add a very condensed version of the description of
the problem you have on the other fix?
 
> In this fix we bail out or retry in the push_dl_task, if the task is no
> longer at the head of pushable tasks list because this list changed
> while trying to lock the runqueue of the other CPU.
> 
> Signed-off-by: Harshit Agarwal <harshit@nutanix.com>
> Cc: stable@vger.kernel.org
> ---
>  kernel/sched/deadline.c | 25 +++++++++++++++++++++----
>  1 file changed, 21 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> index 38e4537790af..c5048969c640 100644
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c
> @@ -2704,6 +2704,7 @@ static int push_dl_task(struct rq *rq)
>  {
>  	struct task_struct *next_task;
>  	struct rq *later_rq;
> +	struct task_struct *task;
>  	int ret = 0;
>  
>  	next_task = pick_next_pushable_dl_task(rq);
> @@ -2734,15 +2735,30 @@ static int push_dl_task(struct rq *rq)
>  
>  	/* Will lock the rq it'll find */
>  	later_rq = find_lock_later_rq(next_task, rq);
> -	if (!later_rq) {
> -		struct task_struct *task;
> +	task = pick_next_pushable_dl_task(rq);
> +	if (later_rq && (!task || task != next_task)) {
> +		/*
> +		 * We must check all this again, since
> +		 * find_lock_later_rq releases rq->lock and it is
> +		 * then possible that next_task has migrated and
> +		 * is no longer at the head of the pushable list.
> +		 */
> +		double_unlock_balance(rq, later_rq);
> +		if (!task) {
> +			/* No more tasks */
> +			goto out;
> +		}
>  
> +		put_task_struct(next_task);
> +		next_task = task;
> +		goto retry;

I fear we might hit a pathological condition that can lead us into a
never ending (or very long) loop. find_lock_later_rq() tries to find a
later_rq for at most DL_MAX_TRIES and it bails out if it can't.

Maybe to discern between find_lock_later_rq() callers we can use
dl_throttled flag in dl_se and still implement the fix in find_lock_
later_rq()? I.e., fix similar to the rt.c patch in case the task is not
throttled (so caller is push_dl_task()) and not rely on pick_next_
pushable_dl_task() if the task is throttled.

What do you think?

Thanks,
Juri


