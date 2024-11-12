Return-Path: <linux-kernel+bounces-406296-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E0D79C5FF8
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 19:11:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 37899B2587A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 16:16:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 924D02036F8;
	Tue, 12 Nov 2024 16:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IkznnKYo"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C04C15A858
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 16:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731428155; cv=none; b=nqPGOa2jvEamQw19R51pCKAflEP0j7GFAlaJQc3PiHbns3qVx8i2Udm6DrkGtesY4clUHLswo9cPvrYzpgvP/meXLJ0ZRboh6z7lpXTxsCXVFv8kwbLPLdyy3CWeHdfalqsGE7ftLcgofhMRQ69AIO7bMh0/eWMyWYn8I0yBc6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731428155; c=relaxed/simple;
	bh=4UR5EKqZjpPBLzgaWuHRCxJQFNwcc0KOm0eSJp5sjKA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=C1dw3+et3K8wMnIssE5IW8tLXKodmtwYT8l4bVB1nBQJ/0JFXHSToyI9eZSAHzfjxXKPO+MIDMYS7kE84fbEXYvAiqsqCVR1Clvh/XZsADzi9CzXzcgbl8U9mHiVD8Z3rldV5c85GF/wwPBMEgvxVvTj3afP9Do1L/ShPfpfKW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IkznnKYo; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731428151;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CGSxKIhmgHQVS95IEwsr6vSLWHmQILSDnH5eKsxrAk0=;
	b=IkznnKYo+tBZwtumkzc1AwQRhXe/x6ojZ/aeulUAnmHHX9+TSUgnggFiBaTF9UU6nziaQV
	yfwZkb7AlpqHscUjUSyiq87fjj3bPmj7T04vtom0iSKfpboF3Sh7q0OI7WVf6gqZhtYp6e
	bDkouPKJ4ELq7JxEj2zoD08HLJqnEy0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-509-WIRgQfkMN1CH5INgpvMPrg-1; Tue, 12 Nov 2024 11:15:50 -0500
X-MC-Unique: WIRgQfkMN1CH5INgpvMPrg-1
X-Mimecast-MFC-AGG-ID: WIRgQfkMN1CH5INgpvMPrg
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-43154a0886bso41677475e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 08:15:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731428149; x=1732032949;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CGSxKIhmgHQVS95IEwsr6vSLWHmQILSDnH5eKsxrAk0=;
        b=ccdYER2v6rJ/7uk/TUzGRtbTSX9lbjQeF6Z0RtUatb7glc6NOQTP3Fh1J+QCcFeouY
         I3052ALaQMQWJJKyZvxPCorUktdTB9bOPwSa/V/xSt/Opx88JUl7h9u7kLAXmSfVLdLX
         WuREsWB9VtPb08Ytfx7zZrDjsZmWEQmOkq/CScjP1aVHeIaHDPhiS3b9bsgBWAiYXhJr
         S0EO7dblr+D3rqr0M2FT61nRWMRURCh0FvovudP8MTFnLCuMekD3NcQ/KEiGlsSSz/lE
         MQYEmTZyfyZudIr1xYlGUtSZn2blbhgVPHZZVRdVc5Kobs+Cp1kFz3aLoLJrn1OXvtgI
         QzOw==
X-Forwarded-Encrypted: i=1; AJvYcCUtKQ+QxDhilHGEmtaGLhgekn1UOmP5SL9rRrkC/30KgMsEdKVpwUGk4nLi/h3yt47nyDrE++jCfZgMatM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCoiA6Vl1FWirELTUI8Bma2R8+j/6DQVfAcavs51AKf9cJ2PIn
	Q8280JXqDFVIQDBBo0IYptwxkvd1QlFOAmYlJIgPktnl7ktWDQsrM+WUo+PBKMgQf4B8O94heUu
	HqIoNyDWKJ6mq5nzXEy7pXWlBd3RA9ozeeJA+UwO+CUEI8TjfASzMSpO8mmsNUA==
X-Received: by 2002:a05:6000:1f82:b0:37c:babe:2c49 with SMTP id ffacd0b85a97d-381f1866fddmr14275459f8f.19.1731428149259;
        Tue, 12 Nov 2024 08:15:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFHYmklDuONGLyRS+lxwaMfrwWRygDU41ZfDfE9a5a5W0kE4CYAFlgPInHqQdbpI1Vo946hhQ==
X-Received: by 2002:a05:6000:1f82:b0:37c:babe:2c49 with SMTP id ffacd0b85a97d-381f1866fddmr14275412f8f.19.1731428148769;
        Tue, 12 Nov 2024 08:15:48 -0800 (PST)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-141-166.abo.bbox.fr. [213.44.141.166])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381eda04ceasm15542399f8f.102.2024.11.12.08.15.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2024 08:15:48 -0800 (PST)
From: Valentin Schneider <vschneid@redhat.com>
To: Steve Wahl <steve.wahl@hpe.com>, Steve Wahl <steve.wahl@hpe.com>, Ingo
 Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Juri
 Lelli <juri.lelli@redhat.com>, Vincent Guittot
 <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel
 Gorman <mgorman@suse.de>, linux-kernel@vger.kernel.org, K Prateek Nayak
 <kprateek.nayak@amd.com>, Vishal Chourasia <vishalc@linux.ibm.com>, samir
 <samir@linux.ibm.com>
Cc: Russ Anderson <rja@hpe.com>, Dimitri Sivanich <sivanich@hpe.com>
Subject: Re: [PATCH v2] sched/topology: improve topology_span_sane speed
In-Reply-To: <20241031200431.182443-1-steve.wahl@hpe.com>
References: <20241031200431.182443-1-steve.wahl@hpe.com>
Date: Tue, 12 Nov 2024 17:15:47 +0100
Message-ID: <xhsmh4j4cctsc.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 31/10/24 15:04, Steve Wahl wrote:
> Use a different approach to topology_span_sane(), that checks for the
> same constraint of no partial overlaps for any two CPU sets for
> non-NUMA topology levels, but does so in a way that is O(N) rather
> than O(N^2).
>
> Instead of comparing with all other masks to detect collisions, keep
> one mask that includes all CPUs seen so far and detect collisions with
> a single cpumask_intersects test.
>
> If the current mask has no collisions with previously seen masks, it
> should be a new mask, which can be uniquely identified ("id") by the
> lowest bit set in this mask.  Mark that we've seen a mask with this
> id, and add the CPUs in this mask to the list of those seen.
>
> If the current mask does collide with previously seen masks, it should
> be exactly equal to a mask seen before, identified once again by the
> lowest bit the current mask has set.  It's an error if we haven't seen
> a mask with that id, or if the current mask doesn't match the one we
> get by looking up that id.
>
> Move the topology_span_sane() check out of the existing topology level
> loop, let it do its own looping to match the needs of this algorithm.
>
> On a system with 1920 processors (16 sockets, 60 cores, 2 threads),
> the average time to take one processor offline is reduced from 2.18
> seconds to 1.01 seconds.  (Off-lining 959 of 1920 processors took
> 34m49.765s without this change, 16m10.038s with this change in place.)
>
> Signed-off-by: Steve Wahl <steve.wahl@hpe.com>
> ---
>
> Version 2: Adopted suggestion by K Prateek Nayak that removes an array and
> simplifies the code, and eliminates the erroneous use of
> num_possible_cpus() that Peter Zijlstra noted.
>
> Version 1 discussion:
>     https://lore.kernel.org/all/20241010155111.230674-1-steve.wahl@hpe.com/
>
>  kernel/sched/topology.c | 73 +++++++++++++++++++++++++++--------------
>  1 file changed, 48 insertions(+), 25 deletions(-)
>
> diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
> index 9748a4c8d668..6a2a3e91d59e 100644
> --- a/kernel/sched/topology.c
> +++ b/kernel/sched/topology.c
> @@ -2356,35 +2356,58 @@ static struct sched_domain *build_sched_domain(struct sched_domain_topology_leve
>  
>  /*
>   * Ensure topology masks are sane, i.e. there are no conflicts (overlaps) for
> - * any two given CPUs at this (non-NUMA) topology level.
> + * any two given CPUs on non-NUMA topology levels.
>   */
> -static bool topology_span_sane(struct sched_domain_topology_level *tl,
> -			      const struct cpumask *cpu_map, int cpu)
> +static bool topology_span_sane(const struct cpumask *cpu_map)
>  {
> -	int i = cpu + 1;
> +	struct sched_domain_topology_level *tl;
> +	struct cpumask *covered, *id_seen;
> +	int cpu;
>  
> -	/* NUMA levels are allowed to overlap */
> -	if (tl->flags & SDTL_OVERLAP)
> -		return true;
> +	lockdep_assert_held(&sched_domains_mutex);
> +	covered = sched_domains_tmpmask;
> +	id_seen = sched_domains_tmpmask2;
> +
> +	for_each_sd_topology(tl) {
> +
> +		/* NUMA levels are allowed to overlap */
> +		if (tl->flags & SDTL_OVERLAP)
> +			continue;
> +
> +		cpumask_clear(covered);
> +		cpumask_clear(id_seen);
>  
> -	/*
> -	 * Non-NUMA levels cannot partially overlap - they must be either
> -	 * completely equal or completely disjoint. Otherwise we can end up
> -	 * breaking the sched_group lists - i.e. a later get_group() pass
> -	 * breaks the linking done for an earlier span.
> -	 */
> -	for_each_cpu_from(i, cpu_map) {
>  		/*
> -		 * We should 'and' all those masks with 'cpu_map' to exactly
> -		 * match the topology we're about to build, but that can only
> -		 * remove CPUs, which only lessens our ability to detect
> -		 * overlaps
> +		 * Non-NUMA levels cannot partially overlap - they must be either
> +		 * completely equal or completely disjoint. Otherwise we can end up
> +		 * breaking the sched_group lists - i.e. a later get_group() pass
> +		 * breaks the linking done for an earlier span.
>  		 */
> -		if (!cpumask_equal(tl->mask(cpu), tl->mask(i)) &&
> -		    cpumask_intersects(tl->mask(cpu), tl->mask(i)))
> -			return false;
> +		for_each_cpu(cpu, cpu_map) {
> +			const struct cpumask *tl_cpu_mask = tl->mask(cpu);
> +			int id;
> +
> +			/* lowest bit set in this mask is used as a unique id */
> +			id = cpumask_first(tl_cpu_mask);
> +
> +			/* if this mask doesn't collide with what we've already seen */
> +			if (!cpumask_intersects(tl_cpu_mask, covered)) {
> +				/* Really odd case when cpu != id, likely not sane */
> +				if ((cpu != id) && !cpumask_equal(tl_cpu_mask, tl->mask(id)))
> +					return false;
> +				if (cpumask_test_and_set_cpu(id, id_seen))
> +					return false;
> +				cpumask_or(covered, tl_cpu_mask, covered);
> +			} else if ((!cpumask_test_cpu(id, id_seen)) ||
> +				    !cpumask_equal(tl->mask(id), tl_cpu_mask)) {
> +				/*
> +				 * a collision with covered should have exactly matched
> +				 * a previously seen mask with the same id
> +				 */
> +				return false;
> +			}
> +		}

Ok so you're speeding it up, but you still get a O(nr_cpu_ids) walk every
hotplug when the check itself only needs to be done at most once per
possible online CPU combination (~ 2^(nr_cpu_ids)). If all CPUs are kicked
to life at boot, then the check only needs to be done once. If you only
boot with a subset of present CPUs to speed things up, the check still
becomes irrelevant once you've kicked the rest to life.

I would reiterate my suggestion to get to a state where the check can be
entirely short-circuited [1].

[1]: http://lore.kernel.org/r/xhsmh8quc5ca4.mognet@vschneid-thinkpadt14sgen2i.remote.csb


