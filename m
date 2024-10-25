Return-Path: <linux-kernel+bounces-382260-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D82B9B0B96
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 19:32:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2EC07B21627
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 17:32:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D898418787C;
	Fri, 25 Oct 2024 17:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fMk+mTzP"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88C0B20D4E4
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 17:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729876895; cv=none; b=MJdVPjdxUUUrQID/BHltJyOPpqw0OeLSU3pjft3h0n0bWEetjQ1sL6+NdkOlD+5On5/XytwKyAm4/JkteskR98ZCrBpcuZNQXtAlEtmjEVp6JGYt4Pz3OMacvkgsFD2EF+Qpe81uclAkb0SHmgtSyFrv9OUchfURjAQjKagw0NQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729876895; c=relaxed/simple;
	bh=V0PMvAm0USx5TONjK4nNWLZfQ8BrEdeeq12P4PSfI4o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fPU8/uGW/d4lsTpj33tOWKz7Xb+t3OuJRPxWszHx8l+Y720tu0wpURdenYOiESwqw8WZc4GJhK0zH/WpeE/PiNqTAk2MKXw3kBpHEDnn8i0GQ+vIRgVJ8+F3ATtJeXQFbpAwlsz8dthb2I0N7BP7gtsTpgksDGTzDSXm56jN7ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fMk+mTzP; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729876891;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YYFBp0hgVP1nG9fG3+rITy5r1e26cgWYCoDwqmFbKgY=;
	b=fMk+mTzPTXXWiBWIIQgYtCIeFACpN19lvE5Ptuj+FT/U3uxl6hMTNWZ1WiRHvG7qyQ6zvp
	VF6deopBXyCHr45Lzn32AOSKXARFxpUnMpiVX/Sh0ncAbxUdDdd9q3k8S6GIIiJ81gZAwK
	SeXwvIETbVTRjVdKQBeXtVZi1IN6QhM=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-629-O-xGWXWHOvKnu-J4Vl2Tew-1; Fri, 25 Oct 2024 13:21:29 -0400
X-MC-Unique: O-xGWXWHOvKnu-J4Vl2Tew-1
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7b16c9a84efso349251585a.1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 10:21:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729876889; x=1730481689;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YYFBp0hgVP1nG9fG3+rITy5r1e26cgWYCoDwqmFbKgY=;
        b=MECNiKEuadosy0SQ18wg3RZTxqMgLMTrowPJ6Wm/k51DTMdiIwco4F2zL4xjjSPwcm
         KW4Bs5Ri6DPSAiI0zmEDCTO6ny5OV/mZ9bs3oL/eMQsk87jeRb0zQyK9eeoSZ3hixag6
         4/ZTodxehecLGjCpIgoi95YV5oRoaIGbJdJGGh/qE+BFUz56YwtTr/kHYqgzOnZzsQc3
         lskMs5g2myC5D0Zhdhi1sEbzAsXJ8GCQMuszZioWopX85ckNW/JRHlve3gjlUDGG08Rw
         nfMkIZ0WgqZAhg+iiWqj40b3omlGeakNO9poRvAcTlIr3H7c/1XR4JeKfzCuxtOGQv6J
         WTLg==
X-Forwarded-Encrypted: i=1; AJvYcCUNQ0q0Vt6inKL1mn3uhut8I1wSLW/TW+NIcymR2facbB1HdqtSN3QInAB7bX3jJkf1iimRs5etUI6BefY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNP6pTg6eKRkaNyTAAGeSfVCF6qoSrfoDLCj4bE1ax79Om/LO+
	dAnynPIRAK2jt86gOrKIasrwpYqw/BPlOtlKQn0uv0iNSHtgD5EmX23MPZglcs0qFk1U/Bx+dp1
	eLuQ+NQ9He40SO3r9bzcSAMwj1MuXWSV6hq/S3QdteI7mXxP0RCZ0QPBducs5rA==
X-Received: by 2002:a05:6214:4b0b:b0:6cb:ae56:1965 with SMTP id 6a1803df08f44-6d1856b3310mr1913966d6.15.1729876888774;
        Fri, 25 Oct 2024 10:21:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGjJIukeeGZtVth4mV9PATfWO2YB1odgM0ENEPgLvtqONOflLy5Gi/JmV1f2Sz/DsBzxBk0Dg==
X-Received: by 2002:a05:6214:4b0b:b0:6cb:ae56:1965 with SMTP id 6a1803df08f44-6d1856b3310mr1913626d6.15.1729876888290;
        Fri, 25 Oct 2024 10:21:28 -0700 (PDT)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-141-166.abo.bbox.fr. [213.44.141.166])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d17991ba53sm7439586d6.61.2024.10.25.10.21.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2024 10:21:27 -0700 (PDT)
From: Valentin Schneider <vschneid@redhat.com>
To: Steve Wahl <steve.wahl@hpe.com>
Cc: Steve Wahl <steve.wahl@hpe.com>, Ingo Molnar <mingo@redhat.com>, Peter
 Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann
 <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, Ben
 Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
 linux-kernel@vger.kernel.org, Russ Anderson <rja@hpe.com>, Dimitri
 Sivanich <sivanich@hpe.com>
Subject: Re: [PATCH] sched/topology: improve topology_span_sane speed
In-Reply-To: <Zxuz2I1Bn0yG4MYj@swahl-home.5wahls.com>
References: <20241010155111.230674-1-steve.wahl@hpe.com>
 <xhsmh34kxv3dc.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
 <Zxuz2I1Bn0yG4MYj@swahl-home.5wahls.com>
Date: Fri, 25 Oct 2024 19:21:23 +0200
Message-ID: <xhsmh8quc5ca4.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 25/10/24 10:06, Steve Wahl wrote:
> On Tue, Oct 15, 2024 at 04:37:35PM +0200, Valentin Schneider wrote:
>> On 10/10/24 10:51, Steve Wahl wrote:
>> > Use a different approach to topology_span_sane(), that checks for the
>> > same constraint of no partial overlaps for any two CPU sets for
>> > non-NUMA topology levels, but does so in a way that is O(N) rather
>> > than O(N^2).
>> >
>> > Instead of comparing with all other masks to detect collisions, keep
>> > one mask that includes all CPUs seen so far and detect collisions with
>> > a single cpumask_intersects test.
>> >
>> > If the current mask has no collisions with previously seen masks, it
>> > should be a new mask, which can be uniquely identified by the lowest
>> > bit set in this mask.  Keep a pointer to this mask for future
>> > reference (in an array indexed by the lowest bit set), and add the
>> > CPUs in this mask to the list of those seen.
>> >
>> > If the current mask does collide with previously seen masks, it should
>> > be exactly equal to a mask seen before, looked up in the same array
>> > indexed by the lowest bit set in the mask, a single comparison.
>> >
>> > Move the topology_span_sane() check out of the existing topology level
>> > loop, let it use its own loop so that the array allocation can be done
>> > only once, shared across levels.
>> >
>> > On a system with 1920 processors (16 sockets, 60 cores, 2 threads),
>> > the average time to take one processor offline is reduced from 2.18
>> > seconds to 1.01 seconds.  (Off-lining 959 of 1920 processors took
>> > 34m49.765s without this change, 16m10.038s with this change in place.)
>> >
>>
>> This isn't the first complaint about topology_span_sane() vs big
>> systems. It might be worth to disable the check once it has scanned all
>> CPUs once - not necessarily at init, since some folks have their systems
>> boot with only a subset of the available CPUs and online them later on.
>>
>> I'd have to think more about how this behaves vs the dynamic NUMA topology
>> code we got as of
>>
>>   0fb3978b0aac ("sched/numa: Fix NUMA topology for systems with CPU-less nodes")
>>
>> (i.e. is scanning all possible CPUs enough to guarantee no overlaps when
>> having only a subset of online CPUs? I think so...)
>>
>> but maybe something like so?
>> ---
>> diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
>> index 9748a4c8d6685..bf95c3d4f6072 100644
>> --- a/kernel/sched/topology.c
>> +++ b/kernel/sched/topology.c
>> @@ -2361,12 +2361,25 @@ static struct sched_domain *build_sched_domain(struct sched_domain_topology_leve
>>  static bool topology_span_sane(struct sched_domain_topology_level *tl,
>>                            const struct cpumask *cpu_map, int cpu)
>>  {
>> +	static bool validated;
>>      int i = cpu + 1;
>>
>> +	if (validated)
>> +		return true;
>> +
>>      /* NUMA levels are allowed to overlap */
>>      if (tl->flags & SDTL_OVERLAP)
>>              return true;
>>
>> +	/*
>> +	 * We're visiting all CPUs available in the system, no need to re-check
>> +	 * things after that. Even if we end up finding overlaps here, we'll
>> +	 * have issued a warning and can skip the per-CPU scan in later
>> +	 * calls to this function.
>> +	 */
>> +	if (cpumask_equal(cpu_map, cpu_possible_mask))
>> +		validated = true;
>> +
>>      /*
>>       * Non-NUMA levels cannot partially overlap - they must be either
>>       * completely equal or completely disjoint. Otherwise we can end up
>
> I tried adding this, surprisingly I saw no effect on the time taken,
> perhaps even a small slowdown, when combined with my patch.  So at
> this point I don't intend to add it to v2 of the patch.
>

Thanks for testing, I assume your cpu_possible_mask reports more CPUs than
you have physically plugged in... I guess it would make sense to
short-circuit the function when cpu_map is a subset of what we've
previously checked, and then re-kick the testing once new CPU(s) are
plugged in. Something like the untested below?

Optimisations notwithstanding, IMO we shouldn't be repeating checks if we
can avoid it.

---
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 9748a4c8d6685..87ba730c34800 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -2354,6 +2354,8 @@ static struct sched_domain *build_sched_domain(struct sched_domain_topology_leve
 	return sd;
 }
 
+static cpumask_var_t topology_sane_cpus;
+
 /*
  * Ensure topology masks are sane, i.e. there are no conflicts (overlaps) for
  * any two given CPUs at this (non-NUMA) topology level.
@@ -2367,6 +2369,11 @@ static bool topology_span_sane(struct sched_domain_topology_level *tl,
 	if (tl->flags & SDTL_OVERLAP)
 		return true;
 
+	if (cpumask_subset(cpu_map, topology_sane_cpus))
+		return true;
+
+	cpumask_or(topology_sane_cpus, cpu_map, topology_sane_cpus);
+
 	/*
 	 * Non-NUMA levels cannot partially overlap - they must be either
 	 * completely equal or completely disjoint. Otherwise we can end up
@@ -2607,6 +2614,7 @@ int __init sched_init_domains(const struct cpumask *cpu_map)
 	zalloc_cpumask_var(&sched_domains_tmpmask, GFP_KERNEL);
 	zalloc_cpumask_var(&sched_domains_tmpmask2, GFP_KERNEL);
 	zalloc_cpumask_var(&fallback_doms, GFP_KERNEL);
+	zalloc_cpumask_var(&topology_sane_cpus, GFP_KERNEL);
 
 	arch_update_cpu_topology();
 	asym_cpu_capacity_scan();


