Return-Path: <linux-kernel+bounces-259728-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 478F6939C31
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 10:03:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2AC92831AB
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 08:03:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC29D14B95A;
	Tue, 23 Jul 2024 08:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ursulin-net.20230601.gappssmtp.com header.i=@ursulin-net.20230601.gappssmtp.com header.b="0PeeXPmc"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 685361C695
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 08:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721721809; cv=none; b=j3LkC/2R7pDyfQtJoH8agC6GdbShRnuNYYr96xHFFgDpwc48PGeHRFWLOgc3lNN7ImI0p42o+6uqYj3gLXjvvEYegV/uLVAZo3Dj+A2NC8LmosglWRtOg5t2BYMZFPGuVUhHpNHqdYvHMUT8cmjKBaE/GFSZoDi6UZyu6mfOIWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721721809; c=relaxed/simple;
	bh=8ojZbUS1q5+D9/vnXSIo9SnMct9lNQJr8ipCQDmzI9w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m/ZtmvNuPz+CR+vY3u6bfh5CG4XVavy96d3TRYa2xducORb2k79T1mowsAJ9UwXDhOYfnewIsuqnlONg/JKtLXhfGdM3Q5mMV1so70yomydvPVPR1U6r88cFYFpcQHh83+mNbDPHXJPX+bJi3rOS6rTQX7m7JZY21bxtwQBva54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ursulin.net; spf=none smtp.mailfrom=ursulin.net; dkim=pass (2048-bit key) header.d=ursulin-net.20230601.gappssmtp.com header.i=@ursulin-net.20230601.gappssmtp.com header.b=0PeeXPmc; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ursulin.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ursulin.net
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-42793fc0a6dso37124395e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 01:03:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ursulin-net.20230601.gappssmtp.com; s=20230601; t=1721721807; x=1722326607; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Dwumg9sA0boBT9f1y3l+ocDrc52hbXSna/PURnFOFoA=;
        b=0PeeXPmcpI5u6nvDk2dQPZrYi1K4ZrrxZ8L9AcNjhDH7rCitWX8vyIoQIccKB6M2vc
         z3U9iNxPcovkcOs9sBoDA9VUhMGwroCKKu09duBNUyGMJg42n1s0rmS5zgTC10xMAUDM
         swlvNtlF3hfsWK6OD/pNr+AkKUvxsPTS78WZYAIYw+fZFLmJZ9Znk/mrkTxxgJhNG6za
         G76QWlorFfyE+AgvyBkA3UYV5oh4Pbf4mTgBfPa+vhA+jIfpOp7HEshpV5IIRilr+TFw
         UHFxejDhA8+HdbqhnV1UsBEb2lzzI0OD6gRei2m08wB5LHWgqrYFK/IpJwGEV+Uja8Pc
         Ok7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721721807; x=1722326607;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Dwumg9sA0boBT9f1y3l+ocDrc52hbXSna/PURnFOFoA=;
        b=SYH1dfDVj9aAF0g7zAID/VNp5qSVJIPqlp+xzhGXzRnfzKDSrlwi20aqfQ3e7gvUld
         ggEkeRQl/+zlzT4qDnZIa+EUjV2/vU3eFhGics+Mx3vd8GY6Wj/5UrH1qKOaLEF6oO1h
         m+UGL76jZoW51p91A6fUS3rmTvLfhphl/FcukAYbWzNpnLzm5V8Af9IH7WNVfIV2bNtF
         Kp0506cNE0ZFC1yoX//3t9GC8TDn56xIoOo8PULthKogGdZ+E1xPRGyLDY1gsxdQybnj
         +NGYjpzRNFhhpJSJS244bgfaCLaGwzF1Ofhn/qWFcObluj004iAmzG5RaILw+FibPFrx
         1l2A==
X-Forwarded-Encrypted: i=1; AJvYcCXPGzmOvuOfvfF7BTiUmpPfXpY2bm09kHdCjKv9WU8Yb4quSL4YrsHMYjln+e68ZGkOKzEr1VKHkR27m8CpwI6XdaoJHgh3DjdLALDT
X-Gm-Message-State: AOJu0YwqmGuptYa7uDduykb1nb1pYDfXAXPtL5aK0lVMDyUTDai1SPI2
	dEX7bKctOkiq7Ao6q6n8pwPARZrd40aC/WL2I35dAVslXDNgq9Ao/ohqDFFxAoI=
X-Google-Smtp-Source: AGHT+IFd81ca7GfKvPbphmZbXFfNfzwy4ltQarxCc2MSfiPQ4ODrZWwDsqbJzw6O/OEzKQoLvMv3qg==
X-Received: by 2002:a05:600c:a07:b0:426:6416:aa73 with SMTP id 5b1f17b1804b1-427ecfe03fbmr13274895e9.12.1721721806759;
        Tue, 23 Jul 2024 01:03:26 -0700 (PDT)
Received: from [192.168.0.101] ([84.69.19.168])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427d292077dsm190059625e9.0.2024.07.23.01.03.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jul 2024 01:03:26 -0700 (PDT)
Message-ID: <be3871bd-fc25-482e-b4d4-91afc4d5b5a5@ursulin.net>
Date: Tue, 23 Jul 2024 09:03:25 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/7] drm/i915/pmu: Lazy unregister
To: Lucas De Marchi <lucas.demarchi@intel.com>,
 intel-gfx@lists.freedesktop.org, linux-perf-users@vger.kernel.org
Cc: Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
 dri-devel@lists.freedesktop.org, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 linux-kernel@vger.kernel.org
References: <20240722210648.80892-1-lucas.demarchi@intel.com>
 <20240722210648.80892-7-lucas.demarchi@intel.com>
Content-Language: en-GB
From: Tvrtko Ursulin <tursulin@ursulin.net>
In-Reply-To: <20240722210648.80892-7-lucas.demarchi@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 22/07/2024 22:06, Lucas De Marchi wrote:
> Instead of calling perf_pmu_unregister() when unbinding, defer that to
> the destruction of i915 object. Since perf itself holds a reference in
> the event, this only happens when all events are gone, which guarantees
> i915 is not unregistering the pmu with live events.
> 
> Previously, running the following sequence would crash the system after
> ~2 tries:
> 
> 	1) bind device to i915
> 	2) wait events to show up on sysfs
> 	3) start perf  stat -I 1000 -e i915/rcs0-busy/
> 	4) unbind driver
> 	5) kill perf
> 
> Most of the time this crashes in perf_pmu_disable() while accessing the
> percpu pmu_disable_count. This happens because perf_pmu_unregister()
> destroys it with free_percpu(pmu->pmu_disable_count).
> 
> With a lazy unbind, the pmu is only unregistered after (5) as opposed to
> after (4). The downside is that if a new bind operation is attempted for
> the same device/driver without killing the perf process, i915 will fail
> to register the pmu (but still load successfully). This seems better
> than completely crashing the system.

So effectively allows unbind to succeed without fully unbinding the 
driver from the device? That sounds like a significant drawback and if 
so, I wonder if a more complicated solution wouldn't be better after 
all. Or is there precedence for allowing userspace keeping their paws on 
unbound devices in this way?

Regards,

Tvrtko

> 
> Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
> ---
>   drivers/gpu/drm/i915/i915_pmu.c | 24 +++++++++---------------
>   1 file changed, 9 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/gpu/drm/i915/i915_pmu.c b/drivers/gpu/drm/i915/i915_pmu.c
> index 8708f905f4f4..df53a8fe53ec 100644
> --- a/drivers/gpu/drm/i915/i915_pmu.c
> +++ b/drivers/gpu/drm/i915/i915_pmu.c
> @@ -1158,18 +1158,21 @@ static void free_pmu(struct drm_device *dev, void *res)
>   	struct i915_pmu *pmu = res;
>   	struct drm_i915_private *i915 = pmu_to_i915(pmu);
>   
> +	perf_pmu_unregister(&pmu->base);
>   	free_event_attributes(pmu);
>   	kfree(pmu->base.attr_groups);
>   	if (IS_DGFX(i915))
>   		kfree(pmu->name);
> +
> +	/*
> +	 * Make sure all currently running (but shortcut on pmu->closed) are
> +	 * gone before proceeding with free'ing the pmu object embedded in i915.
> +	 */
> +	synchronize_rcu();
>   }
>   
>   static int i915_pmu_cpu_online(unsigned int cpu, struct hlist_node *node)
>   {
> -	struct i915_pmu *pmu = hlist_entry_safe(node, typeof(*pmu), cpuhp.node);
> -
> -	GEM_BUG_ON(!pmu->base.event_init);
> -
>   	/* Select the first online CPU as a designated reader. */
>   	if (cpumask_empty(&i915_pmu_cpumask))
>   		cpumask_set_cpu(cpu, &i915_pmu_cpumask);
> @@ -1182,8 +1185,6 @@ static int i915_pmu_cpu_offline(unsigned int cpu, struct hlist_node *node)
>   	struct i915_pmu *pmu = hlist_entry_safe(node, typeof(*pmu), cpuhp.node);
>   	unsigned int target = i915_pmu_target_cpu;
>   
> -	GEM_BUG_ON(!pmu->base.event_init);
> -
>   	/*
>   	 * Unregistering an instance generates a CPU offline event which we must
>   	 * ignore to avoid incorrectly modifying the shared i915_pmu_cpumask.
> @@ -1337,21 +1338,14 @@ void i915_pmu_unregister(struct drm_i915_private *i915)
>   {
>   	struct i915_pmu *pmu = &i915->pmu;
>   
> -	if (!pmu->base.event_init)
> -		return;
> -
>   	/*
> -	 * "Disconnect" the PMU callbacks - since all are atomic synchronize_rcu
> -	 * ensures all currently executing ones will have exited before we
> -	 * proceed with unregistration.
> +	 * "Disconnect" the PMU callbacks - unregistering the pmu will be done
> +	 * later when all currently open events are gone
>   	 */
>   	pmu->closed = true;
> -	synchronize_rcu();
>   
>   	hrtimer_cancel(&pmu->timer);
> -
>   	i915_pmu_unregister_cpuhp_state(pmu);
> -	perf_pmu_unregister(&pmu->base);
>   
>   	pmu->base.event_init = NULL;
>   }

