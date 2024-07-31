Return-Path: <linux-kernel+bounces-269885-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A54C1943815
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 23:35:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 323D11F2257D
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 21:35:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B30C16C6B0;
	Wed, 31 Jul 2024 21:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OYTaz2e8"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C269D2F37
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 21:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722461749; cv=none; b=BezNcHz7KC9C44eFYSrOvl44dx/DfNxazB+RsdCSkEMwBwFcNd6qd5WUn4ti4vXA3D+0bhMvjJRlHSykwCNqImM3VwDtBBfrv2PbhuwpcHUa0KmEsngD4J3lCri7rr+DFMimg8SPAijy55enfFgfZ5+x3pjxsFAQ0tda8bdzZfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722461749; c=relaxed/simple;
	bh=51tGlN1RpwyAm5IO1Vh0a64ti3FduQN7FuycQfDvTdo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Disposition; b=uwlqnAZYeFz4ihn25gT4mty0/6+TFRCmC5fookyvQdb1MbpbWkrBJk0zgqeN8vHCiVApykOiRsBxBYD8sDpgKnFgpvG2Dny7rGhuXCn6/h6koFF4RGcyDEKWDUGvhgtZ2/ne52XAwQ/cb1ZC+w+vBxhIHrI8kFFRw9NgPhFrNQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OYTaz2e8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722461746;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YgHrKgc6PYYUk+SkMRyQ+ez15qiE37TO/PycT5kxTbA=;
	b=OYTaz2e8aFf046JCU2iNGSs3PAjIbBTiHID7jshNUQuwW/q1OvidZ98PnQ4NuQM8Bjsg10
	Ui4uT4rPjjJlcFZxZ0iJrTxl6Irwnh41wc269tTzCJV+0rn6CloNYDf4h6+W+k9Z+EXkgd
	FeYeeJS7KFZrhXYYELqA9qPAwwATZyE=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-222-HzNQBhbbPZmc_CSPCmnY1w-1; Wed, 31 Jul 2024 17:35:45 -0400
X-MC-Unique: HzNQBhbbPZmc_CSPCmnY1w-1
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-6b7917c2b69so78960446d6.1
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 14:35:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722461745; x=1723066545;
        h=content-transfer-encoding:content-disposition:mime-version
         :references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YgHrKgc6PYYUk+SkMRyQ+ez15qiE37TO/PycT5kxTbA=;
        b=Apg2oUI77e0/PrHUZfjBRY+34u6Ia5ZrY1vOXdTc6s6RUWRCtTNlSzCI1aDCL4tUw7
         anK7+shnK5OZffVNOxUUdLuArT1z+HdrTLBZGuP0dimuKChFBrALBrifk+FMCW0px1QI
         GUge0CtnooAhBgsbSk3tW4QPuVqc9bgwHpqtqXntQqLF/CGzQAH6rJmTByJ6FtiXgbNI
         ZYfyI3vO94rG/Q87Pj8h0eCrVlA6nU6xGeEGrlGVEZYq8x3QizIHxJWICKwltQaAPpAi
         yyyd2Tn0bluaax9mpEQhvtHZqCj9MsB3rjM2QulxbxXAoICerCQt1VZCP21bLuESAHSg
         R4gw==
X-Forwarded-Encrypted: i=1; AJvYcCW43IGOYffLX5UM7AqVOxmVSPkhQ8TfYzFI2WHOGj6vFQESmhcpGjecAXUBBCN0KBCdSEK3E5IcmEszWVVQMW/Z6O0TrTzDKZHWiyrj
X-Gm-Message-State: AOJu0YzPmerFxRdOte5WpO8y1y1ym+/k2EYelpvOBNARlfJzXe/GZYWn
	bKgpS9Pr9mdLYjDQskk3t8HhB4zA+FmtzvnKX9xPTkYllDV3CotWf4ZA/3wwXMih/p4F52+MNKn
	4a3LlLcL+pZNUduubdDlxsJRxd0rL2cgj6OxPPGhrgvnY5fkJ+8HEudrpTTMv3w==
X-Received: by 2002:a05:6214:3908:b0:6b4:fea8:6bfc with SMTP id 6a1803df08f44-6bb8d6845b9mr5535546d6.10.1722461744689;
        Wed, 31 Jul 2024 14:35:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEgMw/lq8z11iXy6NClEQGkS+wB2jJkXY1ZzhXNJmlxGdvJTy8QQN/FeK1tXC6AlJ6D1EuiIA==
X-Received: by 2002:a05:6214:3908:b0:6b4:fea8:6bfc with SMTP id 6a1803df08f44-6bb8d6845b9mr5535036d6.10.1722461743579;
        Wed, 31 Jul 2024 14:35:43 -0700 (PDT)
Received: from LeoBras.redhat.com ([2804:1b3:a803:da7:cfdf:ab65:d193:5573])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bb7bf7f7acsm18905066d6.54.2024.07.31.14.35.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jul 2024 14:35:43 -0700 (PDT)
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
Subject: Re: [PATCH v2 2/3] locking/csd_lock: Provide an indication of ongoing CSD-lock stall
Date: Wed, 31 Jul 2024 18:35:35 -0300
Message-ID: <ZqquJwsH1vqsZhD2@LeoBras>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240722133735.667161-2-neeraj.upadhyay@kernel.org>
References: <20240722133559.GA667117@neeraj.linux> <20240722133735.667161-2-neeraj.upadhyay@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Mon, Jul 22, 2024 at 07:07:34PM +0530, neeraj.upadhyay@kernel.org wrote:
> From: "Paul E. McKenney" <paulmck@kernel.org>
> 
> If a CSD-lock stall goes on long enough, it will cause an RCU CPU
> stall warning.  This additional warning provides much additional
> console-log traffic and little additional information.  Therefore,
> provide a new csd_lock_is_stuck() function that returns true if there
> is an ongoing CSD-lock stall.  This function will be used by the RCU
> CPU stall warnings to provide a one-line indication of the stall when
> this function returns true.

I think it would be nice to also add the RCU usage here, as for the 
function being declared but not used.

> 
> [ neeraj.upadhyay: Apply Rik van Riel feedback. ]
> 
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> Cc: Imran Khan <imran.f.khan@oracle.com>
> Cc: Ingo Molnar <mingo@kernel.org>
> Cc: Leonardo Bras <leobras@redhat.com>
> Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>
> Cc: Rik van Riel <riel@surriel.com>
> Signed-off-by: Neeraj Upadhyay <neeraj.upadhyay@kernel.org>
> ---
>  include/linux/smp.h |  6 ++++++
>  kernel/smp.c        | 16 ++++++++++++++++
>  2 files changed, 22 insertions(+)
> 
> diff --git a/include/linux/smp.h b/include/linux/smp.h
> index fcd61dfe2af3..3871bd32018f 100644
> --- a/include/linux/smp.h
> +++ b/include/linux/smp.h
> @@ -294,4 +294,10 @@ int smpcfd_prepare_cpu(unsigned int cpu);
>  int smpcfd_dead_cpu(unsigned int cpu);
>  int smpcfd_dying_cpu(unsigned int cpu);
>  
> +#ifdef CONFIG_CSD_LOCK_WAIT_DEBUG
> +bool csd_lock_is_stuck(void);
> +#else
> +static inline bool csd_lock_is_stuck(void) { return false; }
> +#endif
> +
>  #endif /* __LINUX_SMP_H */
> diff --git a/kernel/smp.c b/kernel/smp.c
> index 81f7083a53e2..9385cc05de53 100644
> --- a/kernel/smp.c
> +++ b/kernel/smp.c
> @@ -207,6 +207,19 @@ static int csd_lock_wait_getcpu(call_single_data_t *csd)
>  	return -1;
>  }
>  
> +static atomic_t n_csd_lock_stuck;
> +
> +/**
> + * csd_lock_is_stuck - Has a CSD-lock acquisition been stuck too long?
> + *
> + * Returns @true if a CSD-lock acquisition is stuck and has been stuck
> + * long enough for a "non-responsive CSD lock" message to be printed.
> + */
> +bool csd_lock_is_stuck(void)
> +{
> +	return !!atomic_read(&n_csd_lock_stuck);
> +}
> +
>  /*
>   * Complain if too much time spent waiting.  Note that only
>   * the CSD_TYPE_SYNC/ASYNC types provide the destination CPU,
> @@ -228,6 +241,7 @@ static bool csd_lock_wait_toolong(call_single_data_t *csd, u64 ts0, u64 *ts1, in
>  		cpu = csd_lock_wait_getcpu(csd);
>  		pr_alert("csd: CSD lock (#%d) got unstuck on CPU#%02d, CPU#%02d released the lock.\n",
>  			 *bug_id, raw_smp_processor_id(), cpu);
> +		atomic_dec(&n_csd_lock_stuck);
>  		return true;
>  	}
>  
> @@ -251,6 +265,8 @@ static bool csd_lock_wait_toolong(call_single_data_t *csd, u64 ts0, u64 *ts1, in
>  	pr_alert("csd: %s non-responsive CSD lock (#%d) on CPU#%d, waiting %lld ns for CPU#%02d %pS(%ps).\n",
>  		 firsttime ? "Detected" : "Continued", *bug_id, raw_smp_processor_id(), (s64)ts_delta,
>  		 cpu, csd->func, csd->info);
> +	if (firsttime)
> +		atomic_inc(&n_csd_lock_stuck);
>  	/*
>  	 * If the CSD lock is still stuck after 5 minutes, it is unlikely
>  	 * to become unstuck. Use a signed comparison to avoid triggering
> -- 
> 2.40.1
> 

IIUC we have a single atomic counter for the whole system, which is 
modified in csd_lock_wait_toolong() and read in RCU stall warning.

I think it should not be an issue regarding cache bouncing because in worst 
case scenario we would have 2 modify / cpu each csd_lock_timeout (which is 
5 seconds by default).

Thanks!
Leo


