Return-Path: <linux-kernel+bounces-447594-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 411979F34AA
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 16:39:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 870141888764
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 15:39:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E5D414A0BC;
	Mon, 16 Dec 2024 15:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TuF0aSGZ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43F001428E7
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 15:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734363547; cv=none; b=SbBTforqzSMYQJQH03TBKM7hnfyXZY3NAwcE2ub4PdJuhVlnymgMbyu6gOvlluyVVw2EGgBhviWO/tAYR+GpSHgIvgKFjqjZz1zFZExnIIxwNr6EmKCn6sW/k1GtUqrhPFAS3iQd2tnxmO7IH1iGPWJA2ypGsVCL75F4SJDgXds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734363547; c=relaxed/simple;
	bh=nuT0nK01yCIltVLcHYhYzvdvLbfvdKHa+74fwmMyygQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=annZX/5x72cyLCjkyhjtNYhNblKoTnmjtYIpnuQ30uSY+Q+Ce5SYJrtBsV2vFie0CynUDWZLTVa/xgtSVLJ+9ISZs6MW1Gi6HZDj+gs8PFYK1MYxLOhVBrL1VLzhRvbnxLcI0q82ItgiQADsy9wxNVEK9F+rZuIFXPF1kgKoCwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TuF0aSGZ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734363544;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=D3+Ze8HsLa1EWfi1qHm76RqP+hqD/Snv65gqGa/Kezw=;
	b=TuF0aSGZM/a/fZRsIh50s+yXNOMFIUSqpaEfZMaXplZpNVY4BrXHhzm/LhnDvWqjqaWlVD
	En+CHBTN/TNb5YJisNNuLLLDkc1i5UZj8OPGN3X8NJrsgIVKFF0KfX+ZvzxMo7eSQsN4aL
	yruC4af0w/JR8+dFXuOGrtMZHrcTBfY=
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com
 [209.85.166.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-529-7nC9uwKAOAq_QrMQucv-eQ-1; Mon, 16 Dec 2024 10:39:03 -0500
X-MC-Unique: 7nC9uwKAOAq_QrMQucv-eQ-1
X-Mimecast-MFC-AGG-ID: 7nC9uwKAOAq_QrMQucv-eQ
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3ac98b49e4dso41593525ab.1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 07:39:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734363542; x=1734968342;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D3+Ze8HsLa1EWfi1qHm76RqP+hqD/Snv65gqGa/Kezw=;
        b=X0vzlt4RmnM2v2hbxUFUbhfzJxcoPV98fj1ETg3ZwthClW0y+wBHesWt/7yzil9O6c
         Ssyxzby/8kJL3Tyw5GPb89HnZr12ZRzQbNgA1vSXqE1XWOIa6NWTP32JsbS1Si0Q5Cy/
         utJ0j17kM461uII5hFvgK+APikgM4Ikt5PByYO3lOSPDItbr0z7KjY+3HebL3iP1mUuS
         rAReY9RNJoViqS80lnka39lbig/uDAg110Mr7hojJM57AXDOb/BAc1pFb/5HkzMLI4+B
         v7VDaOy66jMbsahdgDY9UMGaEGDUxZ6nKqXp09yuAxBvDrvW9I3+83Xur3ZQNccVxMXG
         eqoQ==
X-Forwarded-Encrypted: i=1; AJvYcCXJCqkt4MK4LIcCTBRx7h5CPnSUyGVvfbvA0KWl8aK6hFqu1y7Omp0YAfJyP8tARQxofhwObZDoIuqRAfc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRCcJGrXfOWBLFt5p6rYoAGxktLKPk8BfK4ENM3D7P9vSNAym0
	tAAeXAW2ATQqUD/852n6huK2vKT0XhjA2fiskLZcJrsxRoP+btO/9Fqn+GYhjvW31rCocQO5sYO
	XcbjfgeEy+49sqyYVqO6Kx+AakfI2RxlhV+yY9rsrl8ZyCpyJtL4GJfT/ew4Y/w==
X-Gm-Gg: ASbGnctzTtU1zZZI/lz+F0zCJ0TzMxGKa9192v6vsyORQMkvMlHzsZ8zIHj1M5M71F2
	mFsZ1mr0+Qs3bvmCWjU0AY3kAguwhMoPc0JihEKJVxbrlBXi1jicls4N7giW4ro4gaOb+Xudrqt
	KfegEXvRi5x4JCkVYZ9LVUkPXsFDcjUlT3aCwAJoWkfOHnhstrVGqb/oE7rJzJNclRduwCFwRsn
	h0uN4SCeWFXuHiIPr1ApkJEwBTFz6EdJurgwKkCaYdBWCh8TxS1mSljRJ7iDynEa/BLv7OSXBkG
	r0WbCpTo83WblEcYP/M/vJWQjJalE9NYdnTT2tMbAw==
X-Received: by 2002:a05:6e02:17c7:b0:3a7:fe8c:b004 with SMTP id e9e14a558f8ab-3aff0398fe6mr110904125ab.11.1734363542353;
        Mon, 16 Dec 2024 07:39:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHdthAoxKahA0IgjKrDgcp02WZX60JRFL5mNWkCZNI8fxYIaylalN7Uf3I5h1KQMrmhF8HFUQ==
X-Received: by 2002:a05:6e02:17c7:b0:3a7:fe8c:b004 with SMTP id e9e14a558f8ab-3aff0398fe6mr110903845ab.11.1734363541977;
        Mon, 16 Dec 2024 07:39:01 -0800 (PST)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-141-166.abo.bbox.fr. [213.44.141.166])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4e5e09471dasm1213422173.34.2024.12.16.07.38.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2024 07:39:00 -0800 (PST)
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
Date: Mon, 16 Dec 2024 16:38:57 +0100
Message-ID: <xhsmhttb3fxim.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain


Hi,

Sorry it took me this long to get to this.

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

Using the first CPU like we do in get_group() is clever; if we've seen the
first CPU then the spans must exactly match; else it must be a completely
new span.


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


Per the previous comment, if you hinge the condition on @id itself,
couldn't you "simplify" it as below?

	if (cpumask_test_cpu(id, id_seen)) {
		/* First CPU has already been seen, ensure identical spans */
		if (!cpumask_equal(tl->mask(id), tl_cpu_mask))
			return false;
	} else {
		/* First CPU hasn't been seen before, ensure it's a completely new span */
		if (cpumask_intersects(tl_cpu_mask, covered))
			return false;

		cpumask_or(covered, covered, tl_cpu_mask);
		cpumask_set_cpu(id, id_seen);
	}


