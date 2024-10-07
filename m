Return-Path: <linux-kernel+bounces-353422-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B60AB992D8E
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 15:40:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DCC51B24B98
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 13:40:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50B901D415D;
	Mon,  7 Oct 2024 13:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YvbTAP5i"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49698156875
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 13:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728308426; cv=none; b=R5yQuqNiDHaQnT0ZOFZk8rEA6Tho0mYMvrdkpgyIigrjKTVBSvR8DhgSp7Dmuwcr70VVK5nqtNn3LY68osrlw0du+qsKGVYlakbIMF+kWr1l+Jhvg1GlHrHlv9c3AZTP+G4k3iUZaW+Um7e3YlOJVgHS6F3QVOEQ+d9hdXXMdSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728308426; c=relaxed/simple;
	bh=KZ+4G1XHEdAZVwy9wafIGNJMH+3fSbVSPqFTCkMSOC8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m/plWAX73d1gXspCky83GaaG2Tb8Y4nMTnQ+CPSr2gwg7GH5GdmYHQsSW0HJbHnXySzZO4PcKmjW9JX38HJGE00dIorWfk9IX/rDYx4QtA65BR5YLbIrwV8xUMZ+O1OWWUS6msKdMnKeM5FMbT0QwnRliqBo4vvPsHCZZhHN8qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YvbTAP5i; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728308424;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=l9k79RozGYup9n/CkWKBDrupaPsKUfbpXyjWoGdRVkY=;
	b=YvbTAP5ixIwcDGG3NRed+rausnqhTA+jlcf1+etqV6/A78DZKZJdRHorHDazF3gZLeOLxW
	PBQgZkkTRHI6Cmw/LTEVYckM2RQyZV63F6hysUfx24206BUIrYqIGkWqZdXf+Rj+q+PJdD
	E1r9+InFfpjqTghCcY0SnkFcQ5955t0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-290-JVYsqiEhN1qS8Prbz_Hb8Q-1; Mon, 07 Oct 2024 09:40:21 -0400
X-MC-Unique: JVYsqiEhN1qS8Prbz_Hb8Q-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-42cb830ea86so35005165e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2024 06:40:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728308420; x=1728913220;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l9k79RozGYup9n/CkWKBDrupaPsKUfbpXyjWoGdRVkY=;
        b=rtztmA5BxOsGFF03g3H/FC1t1/duhAK9HwIz/m/6cvlFnAM/zuWxqevZuROwYUYAmp
         sBR8lqyt/Zi7oUbQtZLM+Ajvb7cJQ/I8kH4FS2TWedn49Yituhjaf1wG0ZO1XyiMUzwW
         b8+h5RATHAmvHRzuINbPgkLZepzaZd79Ft6RR3qzKTiaeH4Rx3RBPePWF48ZLLFDxaWp
         xLSm5sGcGPaQidvcLL6C07zXiC826tkkTYvJWEgIFs3EfhHaPfNijqYbPwdcstJvpLgM
         1YLPp5kKzbm8edSODet6RoBRFu2ky+J4AarDuiR2bjrchxEQLaxBt2waAmPEo8OEikJS
         jdew==
X-Forwarded-Encrypted: i=1; AJvYcCWqHvUdAhf66+HC/w3j5SlIg8POEldDpUoc9aphmFuPeIjKzo++Tk5iczBVVoqcLvHYZgZG87qKrJcojMI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFhqcGKef6uSWxHjnIJDN/tiKzAuacyJTPdvaW+uMYodW/Kcb2
	mWP3UHLZCVR3UfwXDueEzcrFZNTrtoB6UDaCCxRKY9aNZx0Me5ufPeNkRwwvT6laO955h16W5yl
	x9w2KxGZ3ifPSWy9F5Kh1Bx7R32rECmzF2OBtug7SsE5A9NCjUKeKMskzSj73qg==
X-Received: by 2002:a05:600c:198c:b0:42c:bbd5:af70 with SMTP id 5b1f17b1804b1-42f85af8a0cmr84988235e9.30.1728308420555;
        Mon, 07 Oct 2024 06:40:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGw/w093cBDLn/2XCKJ0z8FIs8qVnf8NSEBHPVRXhApXS41TizqFDG05krS8MeHA73VfKq1+g==
X-Received: by 2002:a05:600c:198c:b0:42c:bbd5:af70 with SMTP id 5b1f17b1804b1-42f85af8a0cmr84987955e9.30.1728308420048;
        Mon, 07 Oct 2024 06:40:20 -0700 (PDT)
Received: from jlelli-thinkpadt14gen4.remote.csb (host-80-47-4-206.as13285.net. [80.47.4.206])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f86b4475asm92665885e9.35.2024.10.07.06.40.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 06:40:19 -0700 (PDT)
Date: Mon, 7 Oct 2024 14:40:17 +0100
From: Juri Lelli <juri.lelli@redhat.com>
To: Christian Loehle <christian.loehle@arm.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Qais Yousef <qyousef@layalina.io>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	linux-pm <linux-pm@vger.kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Pierre Gondois <pierre.gondois@arm.com>
Subject: Re: [PATCHv2] cpufreq/schedutil: Only bind threads if needed
Message-ID: <ZwPkwaRPKrDtZFZQ@jlelli-thinkpadt14gen4.remote.csb>
References: <a4a70646-98a4-4b85-955e-62d66ba68927@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a4a70646-98a4-4b85-955e-62d66ba68927@arm.com>

Hi,

On 27/09/24 09:59, Christian Loehle wrote:
> Remove the unconditional binding of sugov kthreads to the affected CPUs
> if the cpufreq driver indicates that updates can happen from any CPU.
> This allows userspace to set affinities to either save power (waking up
> bigger CPUs on HMP can be expensive) or increasing performance (by
> letting the utilized CPUs run without preemption of the sugov kthread).
> 
> Signed-off-by: Christian Loehle <christian.loehle@arm.com>
> ---
> - v2: Add comment for the dl_task_check_affinity return (Juri)
> v1: https://lore.kernel.org/lkml/480f2140-ea59-4e1d-a68d-18cbcec10941@arm.com/
> 
>  kernel/sched/cpufreq_schedutil.c | 6 +++++-
>  kernel/sched/syscalls.c          | 7 +++++++
>  2 files changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
> index c6ba15388ea7..10faab849a3e 100644
> --- a/kernel/sched/cpufreq_schedutil.c
> +++ b/kernel/sched/cpufreq_schedutil.c
> @@ -691,7 +691,11 @@ static int sugov_kthread_create(struct sugov_policy *sg_policy)
>  	}
>  
>  	sg_policy->thread = thread;
> -	kthread_bind_mask(thread, policy->related_cpus);
> +	if (policy->dvfs_possible_from_any_cpu)
> +		set_cpus_allowed_ptr(thread, policy->related_cpus);
> +	else
> +		kthread_bind_mask(thread, policy->related_cpus);
> +
>  	init_irq_work(&sg_policy->irq_work, sugov_irq_work);
>  	mutex_init(&sg_policy->work_lock);
>  
> diff --git a/kernel/sched/syscalls.c b/kernel/sched/syscalls.c
> index aa70beee9895..2ef1cb8626bc 100644
> --- a/kernel/sched/syscalls.c
> +++ b/kernel/sched/syscalls.c
> @@ -1172,6 +1172,13 @@ int dl_task_check_affinity(struct task_struct *p, const struct cpumask *mask)
>  	if (!task_has_dl_policy(p) || !dl_bandwidth_enabled())
>  		return 0;
>  
> +	/*
> +	 * The special/sugov task isn't part of regular bandwidth/admission
> +	 * control so let userspace change affinities.
> +	 */
> +	if (dl_entity_is_special(&p->dl))
> +		return 0;
> +
>  	/*
>  	 * Since bandwidth control happens on root_domain basis,
>  	 * if admission test is enabled, we only admit -deadline

For the DEADLINE related bits,

Acked-by: Juri Lelli <juri.lelli@redhat.com>

Thanks,
Juri


