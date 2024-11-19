Return-Path: <linux-kernel+bounces-415023-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E88B9D30B3
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 23:54:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C13E31F22E87
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 22:54:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B6131D1F6F;
	Tue, 19 Nov 2024 22:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EpRhTYxa"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 566501876
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 22:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732056881; cv=none; b=bxXz8aQ04Td9yH4JNulGZ+pBWn/wfAZY+JSLm7ToFRap4V0T+DV9z5RdC/Kmai77YAT9AGOFUqmxhUxE7eI8HSxIORVqGO/toOQC2hYMU7TlUawB4QWqStvCmRtlmpZBsqk0ylyeizwxqqL+ynuInLkEwxOC6CcKQtXI/zx9IhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732056881; c=relaxed/simple;
	bh=WA9PsIHZiknqd97XKlVnzX/W5inwClolowdlh7Pqhgs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=uoGEws8hPOGPnu0+8985vRMV9LzzHkutFfwD0syjcHbPYUZuQWo8Yjfs6yD142ahIgmo3RRoogUwAjwwNgw0g9DIgq/c/5vofswsWNyQXYx2AL0/z3gkmM7zxWEQpITxd9dT1MZJgpYKKpU+B40ncqaYa704J4LY4csdFnps+so=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EpRhTYxa; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732056878;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=X016mIeXHSvLreQ+nz8+yX6DqYMGq31RPOiVFPJKALg=;
	b=EpRhTYxaumXSMX3nk2n48s2utmFVeG5dri0i1OLDLQiLtEqJqv36hQRki4D3Tqo8gWNsuS
	WBf4PfwT8hQL8SN7gWZsuxY1pSwaJ3hecccF2aHxddjR1LE+JYt7426jBNSdSUhdb0hiMW
	LY9xA5NxO+nDw8JV6SV2E/3s3glxA0k=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-630-spmgjUduMTCfCup-aIO87g-1; Tue, 19 Nov 2024 17:54:36 -0500
X-MC-Unique: spmgjUduMTCfCup-aIO87g-1
X-Mimecast-MFC-AGG-ID: spmgjUduMTCfCup-aIO87g
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-38242a78f3eso810101f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 14:54:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732056875; x=1732661675;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=X016mIeXHSvLreQ+nz8+yX6DqYMGq31RPOiVFPJKALg=;
        b=oOFSEfsL6TNhjeUV2zns2RqwiL+vns33ng1gPLNnd3bjEfZKFnxIRjZMuXqZP1H8iA
         QJf3pRCrIS0JeiYQkhWhOCKN1HxJk3gezB1iXgnff3ijmozyS+egkAJeTQ8u8AccC/op
         DucgjyLQRDA9+hLsglZmTVWI3Vg5rCDw5wy3dK4IGThYvyGsS/1tHQDx5mZp/gmW2AHB
         6rCh3bwnqRLD9BIcD54oMVK+UQfju6uW6jUnfn0N2rMClhzy+EDrTy9sc/DO6i1L3ijE
         FBwAxsMUPJ0EpE1GSV7AdTWJs44N7hG8klIvk3LIUzigQ7u98tVdToAkIEuF69Dg1uKb
         RXIA==
X-Forwarded-Encrypted: i=1; AJvYcCViarKtDVcaJPXYkA7yOQBn6GbTg9zsRriNqtK+slTBYimyNFBP7yqfdTrec8P2JlgNSowHeTCfOI34idg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0082NMaPc4kI2Ib/NtHSRNF82qbsqtCQxi1CWLoWZnwpjfW1e
	2PjMPuHGX+O/wnnRQKaeI5qNHL+j+N5P/VYrkW5UdUOKTxjlyVwRoOxlUqQb74XzzkUdai/NcFI
	wyHZDvDrNwnukEkfmaWSwCT23Ev+RlfkeLw9yDDjuIkHAWgs4GpuiapsCrvB0vA==
X-Received: by 2002:a05:6000:2a5:b0:382:4bc5:e5f0 with SMTP id ffacd0b85a97d-38254b21993mr331196f8f.39.1732056875520;
        Tue, 19 Nov 2024 14:54:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEfqjHPfOYxDSiHxvOPBzBoc3vOa1mKR/ONOMMkhecztmHulge2TgzPHRtnMd6A87BWQ+Tegg==
X-Received: by 2002:a05:6000:2a5:b0:382:4bc5:e5f0 with SMTP id ffacd0b85a97d-38254b21993mr331175f8f.39.1732056875152;
        Tue, 19 Nov 2024 14:54:35 -0800 (PST)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-141-166.abo.bbox.fr. [213.44.141.166])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3825490bfd6sm500148f8f.25.2024.11.19.14.54.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2024 14:54:34 -0800 (PST)
From: Valentin Schneider <vschneid@redhat.com>
To: Steve Wahl <steve.wahl@hpe.com>
Cc: Steve Wahl <steve.wahl@hpe.com>, Ingo Molnar <mingo@redhat.com>, Peter
 Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann
 <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, Ben
 Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
 linux-kernel@vger.kernel.org, K Prateek Nayak <kprateek.nayak@amd.com>,
 Vishal Chourasia <vishalc@linux.ibm.com>, samir <samir@linux.ibm.com>,
 Russ Anderson <rja@hpe.com>, Dimitri Sivanich <sivanich@hpe.com>
Subject: Re: [PATCH v2] sched/topology: improve topology_span_sane speed
In-Reply-To: <Zzz9MXHaUwpq2h0q@swahl-home.5wahls.com>
References: <20241031200431.182443-1-steve.wahl@hpe.com>
 <xhsmh4j4cctsc.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
 <ZzTI6l-9Z0oCbrEH@swahl-home.5wahls.com>
 <Zzz9MXHaUwpq2h0q@swahl-home.5wahls.com>
Date: Tue, 19 Nov 2024 23:54:33 +0100
Message-ID: <xhsmh5xoij0ly.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 19/11/24 15:03, Steve Wahl wrote:
> On Wed, Nov 13, 2024 at 09:42:34AM -0600, Steve Wahl wrote:
>> On Tue, Nov 12, 2024 at 05:15:47PM +0100, Valentin Schneider wrote:
>> > On 31/10/24 15:04, Steve Wahl wrote:
>> > > Use a different approach to topology_span_sane(), that checks for the
>> > > same constraint of no partial overlaps for any two CPU sets for
>> > > non-NUMA topology levels, but does so in a way that is O(N) rather
>> > > than O(N^2).
>> > >
>> > > Instead of comparing with all other masks to detect collisions, keep
>> > > one mask that includes all CPUs seen so far and detect collisions with
>> > > a single cpumask_intersects test.
>> > >
>> > > If the current mask has no collisions with previously seen masks, it
>> > > should be a new mask, which can be uniquely identified ("id") by the
>> > > lowest bit set in this mask.  Mark that we've seen a mask with this
>> > > id, and add the CPUs in this mask to the list of those seen.
>> > >
>> > > If the current mask does collide with previously seen masks, it should
>> > > be exactly equal to a mask seen before, identified once again by the
>> > > lowest bit the current mask has set.  It's an error if we haven't seen
>> > > a mask with that id, or if the current mask doesn't match the one we
>> > > get by looking up that id.
>> > >
>> > > Move the topology_span_sane() check out of the existing topology level
>> > > loop, let it do its own looping to match the needs of this algorithm.
>> > >
>> > > On a system with 1920 processors (16 sockets, 60 cores, 2 threads),
>> > > the average time to take one processor offline is reduced from 2.18
>> > > seconds to 1.01 seconds.  (Off-lining 959 of 1920 processors took
>> > > 34m49.765s without this change, 16m10.038s with this change in place.)
>> > >
>> > > Signed-off-by: Steve Wahl <steve.wahl@hpe.com>
>> > > ---
>> > >
>> > > Version 2: Adopted suggestion by K Prateek Nayak that removes an array and
>> > > simplifies the code, and eliminates the erroneous use of
>> > > num_possible_cpus() that Peter Zijlstra noted.
>> > >
>> > > Version 1 discussion:
>> > >     https://lore.kernel.org/all/20241010155111.230674-1-steve.wahl@hpe.com/
>> > >
>> > >  kernel/sched/topology.c | 73 +++++++++++++++++++++++++++--------------
>> > >  1 file changed, 48 insertions(+), 25 deletions(-)
>> > >
>> > > diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
>> > > index 9748a4c8d668..6a2a3e91d59e 100644
>> > > --- a/kernel/sched/topology.c
>> > > +++ b/kernel/sched/topology.c
>> > > @@ -2356,35 +2356,58 @@ static struct sched_domain *build_sched_domain(struct sched_domain_topology_leve
>> > >
>> > >  /*
>> > >   * Ensure topology masks are sane, i.e. there are no conflicts (overlaps) for
>> > > - * any two given CPUs at this (non-NUMA) topology level.
>> > > + * any two given CPUs on non-NUMA topology levels.
>> > >   */
>> > > -static bool topology_span_sane(struct sched_domain_topology_level *tl,
>> > > -			      const struct cpumask *cpu_map, int cpu)
>> > > +static bool topology_span_sane(const struct cpumask *cpu_map)
>> > >  {
>> > > -	int i = cpu + 1;
>> > > +	struct sched_domain_topology_level *tl;
>> > > +	struct cpumask *covered, *id_seen;
>> > > +	int cpu;
>> > >
>> > > -	/* NUMA levels are allowed to overlap */
>> > > -	if (tl->flags & SDTL_OVERLAP)
>> > > -		return true;
>> > > +	lockdep_assert_held(&sched_domains_mutex);
>> > > +	covered = sched_domains_tmpmask;
>> > > +	id_seen = sched_domains_tmpmask2;
>> > > +
>> > > +	for_each_sd_topology(tl) {
>> > > +
>> > > +		/* NUMA levels are allowed to overlap */
>> > > +		if (tl->flags & SDTL_OVERLAP)
>> > > +			continue;
>> > > +
>> > > +		cpumask_clear(covered);
>> > > +		cpumask_clear(id_seen);
>> > >
>> > > -	/*
>> > > -	 * Non-NUMA levels cannot partially overlap - they must be either
>> > > -	 * completely equal or completely disjoint. Otherwise we can end up
>> > > -	 * breaking the sched_group lists - i.e. a later get_group() pass
>> > > -	 * breaks the linking done for an earlier span.
>> > > -	 */
>> > > -	for_each_cpu_from(i, cpu_map) {
>> > >                  /*
>> > > -		 * We should 'and' all those masks with 'cpu_map' to exactly
>> > > -		 * match the topology we're about to build, but that can only
>> > > -		 * remove CPUs, which only lessens our ability to detect
>> > > -		 * overlaps
>> > > +		 * Non-NUMA levels cannot partially overlap - they must be either
>> > > +		 * completely equal or completely disjoint. Otherwise we can end up
>> > > +		 * breaking the sched_group lists - i.e. a later get_group() pass
>> > > +		 * breaks the linking done for an earlier span.
>> > >                   */
>> > > -		if (!cpumask_equal(tl->mask(cpu), tl->mask(i)) &&
>> > > -		    cpumask_intersects(tl->mask(cpu), tl->mask(i)))
>> > > -			return false;
>> > > +		for_each_cpu(cpu, cpu_map) {
>> > > +			const struct cpumask *tl_cpu_mask = tl->mask(cpu);
>> > > +			int id;
>> > > +
>> > > +			/* lowest bit set in this mask is used as a unique id */
>> > > +			id = cpumask_first(tl_cpu_mask);
>> > > +
>> > > +			/* if this mask doesn't collide with what we've already seen */
>> > > +			if (!cpumask_intersects(tl_cpu_mask, covered)) {
>> > > +				/* Really odd case when cpu != id, likely not sane */
>> > > +				if ((cpu != id) && !cpumask_equal(tl_cpu_mask, tl->mask(id)))
>> > > +					return false;
>> > > +				if (cpumask_test_and_set_cpu(id, id_seen))
>> > > +					return false;
>> > > +				cpumask_or(covered, tl_cpu_mask, covered);
>> > > +			} else if ((!cpumask_test_cpu(id, id_seen)) ||
>> > > +				    !cpumask_equal(tl->mask(id), tl_cpu_mask)) {
>> > > +				/*
>> > > +				 * a collision with covered should have exactly matched
>> > > +				 * a previously seen mask with the same id
>> > > +				 */
>> > > +				return false;
>> > > +			}
>> > > +		}
>> >
>> > Ok so you're speeding it up, but you still get a O(nr_cpu_ids) walk every
>> > hotplug when the check itself only needs to be done at most once per
>> > possible online CPU combination (~ 2^(nr_cpu_ids)). If all CPUs are kicked
>> > to life at boot, then the check only needs to be done once. If you only
>> > boot with a subset of present CPUs to speed things up, the check still
>> > becomes irrelevant once you've kicked the rest to life.
>> >
>> > I would reiterate my suggestion to get to a state where the check can be
>> > entirely short-circuited [1].
>> >
>> > [1]: http://lore.kernel.org/r/xhsmh8quc5ca4.mognet@vschneid-thinkpadt14sgen2i.remote.csb
>>
>> Bringing forward a bit of that conversation:
>>
>> > > I tried adding this, surprisingly I saw no effect on the time taken,
>> > > perhaps even a small slowdown, when combined with my patch.  So at
>> > > this point I don't intend to add it to v2 of the patch.
>> > >
>> >
>> > Thanks for testing, I assume your cpu_possible_mask reports more CPUs than
>> > you have physically plugged in...
>>
>> That assumption is wrong.  I started with all CPUs enabled.  Disabled
>> and re-enabled cpus from there.  The timings I got were as I stated,
>> no effect, perhaps a small slowdown.
>>
>> > I guess it would make sense to short-circuit the function when
>> > cpu_map is a subset of what we've previously checked, and then
>> > re-kick the testing once new CPU(s) are plugged in. Something like
>> > the untested below?
>> >
>> > Optimisations notwithstanding, IMO we shouldn't be repeating checks if we
>> > can avoid it.
>>
>> I will attempt to measure it once more.  I was surprised at my
>> measured results, but that's why we take them, right?
>>
>> If I can't measure a difference, though, I am not sure it's
>> appropriate to include the change with this patch, the point of which
>> *is* optimization.
>
> I completed timing tests; test system has 1920 logical CPUS, 2 threads
> per core, 60 cores per NUMA node, and the script offlined then onlined
> both threads of half the cores in each node.  Four runs each were
> timed.  Times in seconds.
>
> Unpatched kernel:
>       Offline		Online
> min	3991.57		3967.22
> max	4025.59		4028.66
> avg	4013.79		3996.75
> stddev	15.28		29.90
>
> With my patch:
>       Offline		Online
> min	1987.97		2130.7
> max	2032.25		2150.93
> avg	2017.43		2140.18
> stddev	20.12		10.25
>
> With my patch + Valentin's extra short-circuit patch:
> min	2019.58		2137.43
> max	2056.89		2223.86
> avg	2033.04		2171.91
> stddev	16.83		37.73
>
> I'm at a loss as to why adding the short circuit slowed things down,
> but it's in the noise.  If you want a new version of the patch
> incorporating both changes after viewing these timings, I'm willing to
> make that change.  Let me know how you feel.
>

Huh, weird. Obviously your patch improves the situation and the
short-circuit as proposed doesn't, so I'd say go forth with your patch and
I'll poke around to figure out what's going on and submit a hopefully
working short-circuit.


