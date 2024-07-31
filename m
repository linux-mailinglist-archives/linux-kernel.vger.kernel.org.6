Return-Path: <linux-kernel+bounces-269911-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9918794388E
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 00:01:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4897B283424
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 22:01:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54EB616C87F;
	Wed, 31 Jul 2024 22:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GKrPPHSV"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B7A4101EE
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 22:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722463298; cv=none; b=ilO2UIFQHR8sOsCyPx4sstAythTsfp89O1BZw9Dw1njeD9lpI3UqCeNAr9f1tvkZXoqMjlEFTR0uQbjeXA+R47PuGAUROQtFSTiiNHAgwZEm1GmS18Jeo03SftC8sLZQFAMxTSJYK4i90OWxLMm2jrAb9CYgitXC6GvwGUQVXX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722463298; c=relaxed/simple;
	bh=zBm2f+SS38Gn4v+LakfBmHXjnr6PaCiZjBFBfwoYREw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Disposition; b=VeBpk5EXQvYbbQRO4Xu6Qtn/ZXwE9M4Ev5+2QG7he8jxY0KzcotxUkt2J6bvWQkX7sBhUNx+hVOtXxaOPTR6WUFHvkDdj6m5yP4icwKLG4LysM/177UxWVHg70eG3c8tQsIK4QMGVHp9zd6Bl21Xx4G5Ik4eecQXBQC4VwW4Fas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GKrPPHSV; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722463294;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pZ9SG54DFMY9Tr+tAWopvPhBT8szwOL1za2ZdMexQWQ=;
	b=GKrPPHSVnzSe+DjZfDwvKN+ojDs0OlEvcBDkQfFTQAJ6p+4l7qsPdfRX4FcxbjukCnIbY9
	bLXQx/zvt2JkysyXKHbvnlFK2CzJUxobB+ZtUnIo3y4htwtzmSA0SknXiDvWchCxtpAX+B
	z8D6AVnvfENjLIUa1kuk5OKUPkf2Vk8=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-660-vV_B-bpgN4aZq8_rQdIiIA-1; Wed, 31 Jul 2024 18:01:32 -0400
X-MC-Unique: vV_B-bpgN4aZq8_rQdIiIA-1
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-81fa58fbeceso576723139f.2
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 15:01:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722463292; x=1723068092;
        h=content-transfer-encoding:content-disposition:mime-version
         :references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pZ9SG54DFMY9Tr+tAWopvPhBT8szwOL1za2ZdMexQWQ=;
        b=VDdfegB/D0X2Lab5xY7hhnoHf9jx8iqKrsbeWQbcOK0c7y4qSPqBpN+ISZIzciOLLQ
         udhsL8WLP0MeE+P50p1ZwFPewrLkmHW8FdHauy1N8P1KTjHeCwvqt2QfGAQzwWN66OeM
         yoMF/7FW9xgyi+UCBSBQOO0GK/hOoGQ0o/ABGE7xWe5sx6bYKbo2YDJ4MpPFK8tZJOkG
         Pq4EMb10G/B4ch99VBuPfath6shqePDa/qLjUV94m5XFMOzAJzU5ZEzV/p2xv1UqlMEC
         7KCGZAw4KWX3EeENcaXVgluh+1EKsYT2sSXWwYjTgyWwL/TNSaxLcWINTEFoG0eVs9sI
         vqmQ==
X-Forwarded-Encrypted: i=1; AJvYcCUoBMD1bJg5GZHto8hjcuhAI1OHL61kvN7JJ54aCkcWOjmpP3IZtpVSFJzlXfbN76dlW0RpvsTM7YrjCAjnqmO7k0Ex06vCGAlFAieo
X-Gm-Message-State: AOJu0YxqshhxqqXl5EeS/PyYtV2VCJSIZeBR8TIL3venwkETEGthiAH0
	k7P8A3IMTb9sScshj9YCi2/g8GdfQJvUhzMvgMLCkhO8vzk6YOgNwRqehLvbrrOIBzIUrpXaSBC
	ExXbBuzrMFBvpzMVB5LoRGmtBMhNLe0h4Xp6mY6aC+Nz98A1HwM2yxpozdoJQeA==
X-Received: by 2002:a05:6602:3fce:b0:81f:9826:19ff with SMTP id ca18e2360f4ac-81fcc10762amr72765739f.9.1722463292090;
        Wed, 31 Jul 2024 15:01:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGMzgE5kLoDFOdYOYdfEb9PV9w7LV6j92I0/pC3+GswmQQOWJ2wi+iHtqU6Et8UzM/GyaGfeg==
X-Received: by 2002:a05:6602:3fce:b0:81f:9826:19ff with SMTP id ca18e2360f4ac-81fcc10762amr72757939f.9.1722463291058;
        Wed, 31 Jul 2024 15:01:31 -0700 (PDT)
Received: from LeoBras.redhat.com ([2804:1b3:a803:da7:cfdf:ab65:d193:5573])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bb3fac19c5sm79214346d6.112.2024.07.31.15.01.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jul 2024 15:01:30 -0700 (PDT)
From: Leonardo Bras <leobras@redhat.com>
To: neeraj.upadhyay@kernel.org
Cc: Leonardo Bras <leobras@redhat.com>,
	linux-kernel@vger.kernel.org,
	rcu@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	mingo@kernel.org,
	peterz@infradead.org,
	paulmck@kernel.org,
	imran.f.khan@oracle.com,
	riel@surriel.com,
	tglx@linutronix.de
Subject: Re: [PATCH v2 3/3] locking/csd-lock: Use backoff for repeated reports of same incident
Date: Wed, 31 Jul 2024 19:01:23 -0300
Message-ID: <Zqq0M92zcR1kcuKz@LeoBras>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240722133735.667161-3-neeraj.upadhyay@kernel.org>
References: <20240722133559.GA667117@neeraj.linux> <20240722133735.667161-3-neeraj.upadhyay@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Mon, Jul 22, 2024 at 07:07:35PM +0530, neeraj.upadhyay@kernel.org wrote:
> From: "Paul E. McKenney" <paulmck@kernel.org>
> 
> Currently, the CSD-lock diagnostics in CONFIG_CSD_LOCK_WAIT_DEBUG=y
> kernels are emitted at five-second intervals.  Although this has proven
> to be a good time interval for the first diagnostic, if the target CPU
> keeps interrupts disabled for way longer than five seconds, the ratio
> of useful new information to pointless repetition increases considerably.
> 
> Therefore, back off the time period for repeated reports of the same
> incident, increasing linearly with the number of reports and logarithmicly
> with the number of online CPUs.
> 
> [ paulmck: Apply Dan Carpenter feedback. ]
> 
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> Cc: Imran Khan <imran.f.khan@oracle.com>
> Cc: Ingo Molnar <mingo@kernel.org>
> Cc: Leonardo Bras <leobras@redhat.com>
> Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>
> Cc: Rik van Riel <riel@surriel.com>
> Reviewed-by: Rik van Riel <riel@surriel.com>
> Signed-off-by: Neeraj Upadhyay <neeraj.upadhyay@kernel.org>
> ---
>  kernel/smp.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/smp.c b/kernel/smp.c
> index 9385cc05de53..dfcde438ef63 100644
> --- a/kernel/smp.c
> +++ b/kernel/smp.c
> @@ -225,7 +225,7 @@ bool csd_lock_is_stuck(void)
>   * the CSD_TYPE_SYNC/ASYNC types provide the destination CPU,
>   * so waiting on other types gets much less information.
>   */
> -static bool csd_lock_wait_toolong(call_single_data_t *csd, u64 ts0, u64 *ts1, int *bug_id)
> +static bool csd_lock_wait_toolong(call_single_data_t *csd, u64 ts0, u64 *ts1, int *bug_id, unsigned long *nmessages)
>  {
>  	int cpu = -1;
>  	int cpux;
> @@ -248,7 +248,9 @@ static bool csd_lock_wait_toolong(call_single_data_t *csd, u64 ts0, u64 *ts1, in
>  	ts2 = sched_clock();
>  	/* How long since we last checked for a stuck CSD lock.*/
>  	ts_delta = ts2 - *ts1;
> -	if (likely(ts_delta <= csd_lock_timeout_ns || csd_lock_timeout_ns == 0))
> +	if (likely(ts_delta <= csd_lock_timeout_ns * (*nmessages + 1) *
> +			       (!*nmessages ? 1 : (ilog2(num_online_cpus()) / 2 + 1)) ||
> +		   csd_lock_timeout_ns == 0))

I think this is a nice change.

OTOH above condition is quite hard to read IMHO.

IIUC you want, for csd_lock_timeout_ns 5s, and num_online_cpus = 64
1st message: after 5s
2nd message: after 5 * 2 * (6 / 2 + 1) = 10 * 4 = 40s
3rd message: after 5 * 3 * 4 = 60s
...
Is that correct?


I think this could be achieved with:

	/* How long since we last checked for a stuck CSD lock.*/
	ts_delta = ts2 - *ts1;
+	if (*nmessages)
+		csd_lock_timeout_ns *= (*nmessages + 1) * (ilog2(num_online_cpus()) / 2 + 1)
	if (likely(ts_delta <= csd_lock_timeout_ns || csd_lock_timeout_ns == 0))
		return false;

Does that look better?

Thanks!
Leo

>  
>  	firsttime = !*bug_id;
> @@ -265,6 +267,7 @@ static bool csd_lock_wait_toolong(call_single_data_t *csd, u64 ts0, u64 *ts1, in
>  	pr_alert("csd: %s non-responsive CSD lock (#%d) on CPU#%d, waiting %lld ns for CPU#%02d %pS(%ps).\n",
>  		 firsttime ? "Detected" : "Continued", *bug_id, raw_smp_processor_id(), (s64)ts_delta,
>  		 cpu, csd->func, csd->info);
> +	(*nmessages)++;
>  	if (firsttime)
>  		atomic_inc(&n_csd_lock_stuck);
>  	/*
> @@ -305,12 +308,13 @@ static bool csd_lock_wait_toolong(call_single_data_t *csd, u64 ts0, u64 *ts1, in
>   */
>  static void __csd_lock_wait(call_single_data_t *csd)
>  {
> +	unsigned long nmessages = 0;
>  	int bug_id = 0;
>  	u64 ts0, ts1;
>  
>  	ts1 = ts0 = sched_clock();
>  	for (;;) {
> -		if (csd_lock_wait_toolong(csd, ts0, &ts1, &bug_id))
> +		if (csd_lock_wait_toolong(csd, ts0, &ts1, &bug_id, &nmessages))
>  			break;
>  		cpu_relax();
>  	}
> -- 
> 2.40.1
> 


