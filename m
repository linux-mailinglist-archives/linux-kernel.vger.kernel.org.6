Return-Path: <linux-kernel+bounces-515109-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B3477A36054
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 15:25:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37AFC188DD32
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 14:25:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11306265CD5;
	Fri, 14 Feb 2025 14:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TcGr0mJl"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 874595BAF0
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 14:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739543139; cv=none; b=S8EdFFEZQGAgUbnNRWPlkJZuQj6CuSHGsI0QmUOIA0OQvLFLtL7Ajs7jeD3C/QZK1LcFLLPHKHbFxvgo+NcGyG2PiO4ADCjQ4seO+U2/N5xRreZyMBjCPYpdaU7aH1f++5lBOFPr4KH5KSrYPLefhsImAOO79JJK7/6AhOToTLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739543139; c=relaxed/simple;
	bh=hH+NmcqhzTaEVlNnyRn3V9gM8zMqewNJLaN1tuepj90=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=emVKTHdfeQ0ioZuD5Y2BKNb6lf4CAt4FQ6Sdj4ts8MtaxGrclqU+n8wyRMGmJMWU69iP1jwruFttIcGyd3DDiUhGHMNs+pqPaClUhhKC0j2KetUTpxFgEUTHGZ1u9o7rDc4vubClNcouekriiuKKVbkHzv+760Iuu1VAOQj/50g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TcGr0mJl; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739543136;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mP3cPzY7ftthg9IPz0fPNmprfepQxeBH3LVlXQ9lmjg=;
	b=TcGr0mJleWQxHUgtuiZari6yM7f5ExL7Kcmez8bi+6LFRrrlUk0PHTmc4JMa9J+GghT3y7
	NxiBb+EqKha58b1mSNxMwCEwVUVhf11ikvyTh2CCFqeMp6QvS+LI1P5vr0tRfCEAvmTrKz
	f1aRRVeg1IHlbqUkg0zKwsBelnA2Z1M=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-641-u1nv84vYP2m4co5AdQnipw-1; Fri, 14 Feb 2025 09:25:35 -0500
X-MC-Unique: u1nv84vYP2m4co5AdQnipw-1
X-Mimecast-MFC-AGG-ID: u1nv84vYP2m4co5AdQnipw_1739543134
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-38f2cefb154so579553f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 06:25:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739543134; x=1740147934;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mP3cPzY7ftthg9IPz0fPNmprfepQxeBH3LVlXQ9lmjg=;
        b=izWHVzGNCqu9Ze12sVbdXI7t6P5H7vOo29KUDVtGgT7lbdzj50LtvWcr6Q1e5f4W9O
         f4Xqjoe6u46/eZR3PpjbXntcvvl12wiRDjtTPBFFzmdRb4woBt1PfNG2v5ICIcEbcsbf
         PQ4f8Fv2jzDTdzxH8/oOljmOW3A5zCeUv5PCdcjoSTPTo8msdMJtlBrwZ8097gfPSAfr
         fccZgfM1/1Cl76LoaQKwfNiB3cpfYaTz7qKe8DQVnPFgaNdCYflwK7VdxNWGeDhkZ4E3
         ovm/KiYCh/xPj0cygfwJw8z58EEWGKmpK2+wtN18GLdBZqnVXKZvOWA0A0cWAy9eGtzy
         hJ2Q==
X-Forwarded-Encrypted: i=1; AJvYcCUQNtodXUPqnKhyOUOY+yB6FvD2G0VzQHS4RGkNzMsFgUcRjl4CFtdxZI9zUVhjiBZWi9E9dkOnsk+VeyY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4dHtNCeP5+UlpdqNPENgCMMxJgHDpcuLyOJ33/PrQQ8O2seN0
	iDusdYobtBUPFGQF3aEJJCri8lIbQad/xsQSp0VOB5XPdFsASjgpiO9qMRvW/qF7PuSHK7ujlyO
	iqHtgr+abSc0dpHRyAHDxI03KdfdS2w0RvW1n+lG5z/AldSp7Co7YreDHBytq+Q==
X-Gm-Gg: ASbGncuhP770cOu8zRot6b8lVCkIjszs/W+uZLqoEnXJNufZ7hm8vIqtw9/BDq2lol8
	6zlDkmUhpXLps74Ma0I2zBu0rKYAecEygl0tTNxCLkaoGkP5ZHUmXUpHX2xP8mMW4RkR6+vHyBU
	hzaNmWkkNSSj/HBShUrGnYoI7dtHatm789iaIp9umcGdm4YIAsZv0SmzPT2vcE6/FH6BnmkNK/P
	KD2OA84rlrT80HZvi7REOMzHJPfLttIzBUQ7JzzJTq69YPglTYv8Nd7KHZ+PZKxIVT3TBx+c+X8
	OGdtnXLDpheFzQwLSYxZBnz53sV+4kwdyXR6/Ki3yZysvQPcfDDTgNw76kY4m7Crmg==
X-Received: by 2002:a5d:5f89:0:b0:38d:bccf:f342 with SMTP id ffacd0b85a97d-38dea2eadefmr14874908f8f.43.1739543134012;
        Fri, 14 Feb 2025 06:25:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE8jQEs+0VE6Fqa4EJUJ5fT+oAK3LwpvCFCTnX+HB2t+3gzFONet6bAEavNTswAIwE/LFLPhA==
X-Received: by 2002:a5d:5f89:0:b0:38d:bccf:f342 with SMTP id ffacd0b85a97d-38dea2eadefmr14874855f8f.43.1739543133632;
        Fri, 14 Feb 2025 06:25:33 -0800 (PST)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-141-166.abo.bbox.fr. [213.44.141.166])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-439618854bbsm45135525e9.32.2025.02.14.06.25.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 06:25:32 -0800 (PST)
From: Valentin Schneider <vschneid@redhat.com>
To: Steve Wahl <steve.wahl@hpe.com>, Steve Wahl <steve.wahl@hpe.com>, Ingo
 Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Juri
 Lelli <juri.lelli@redhat.com>, Vincent Guittot
 <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel
 Gorman <mgorman@suse.de>, linux-kernel@vger.kernel.org, K Prateek Nayak
 <kprateek.nayak@amd.com>, Vishal Chourasia <vishalc@linux.ibm.com>, samir
 <samir@linux.ibm.com>
Cc: Naman Jain <namjain@linux.microsoft.com>, Saurabh Singh Sengar
 <ssengar@linux.microsoft.com>, srivatsa@csail.mit.edu, Michael Kelley
 <mhklinux@outlook.com>, Russ Anderson <rja@hpe.com>, Dimitri Sivanich
 <sivanich@hpe.com>
Subject: Re: [PATCH v3] sched/topology: improve topology_span_sane speed
In-Reply-To: <20250210154259.375312-1-steve.wahl@hpe.com>
References: <20250210154259.375312-1-steve.wahl@hpe.com>
Date: Fri, 14 Feb 2025 15:25:31 +0100
Message-ID: <xhsmhseogiox0.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 10/02/25 09:42, Steve Wahl wrote:
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
> should be a new mask, which can be uniquely identified by the lowest
> bit set in this mask.  Keep a pointer to this mask for future
> reference (in an array indexed by the lowest bit set), and add the
> CPUs in this mask to the list of those seen.
>
> If the current mask does collide with previously seen masks, it should
> be exactly equal to a mask seen before, looked up in the same array
> indexed by the lowest bit set in the mask, a single comparison.
>
> Move the topology_span_sane() check out of the existing topology level
> loop, let it use its own loop so that the array allocation can be done
> only once, shared across levels.
>
> On a system with 1920 processors (16 sockets, 60 cores, 2 threads),
> the average time to take one processor offline is reduced from 2.18
> seconds to 1.01 seconds.  (Off-lining 959 of 1920 processors took
> 34m49.765s without this change, 16m10.038s with this change in place.)
>
> Signed-off-by: Steve Wahl <steve.wahl@hpe.com>
> ---
>
> Version 3: While the intent of this patch is no functional change, I
> discovered that version 2 had conditions where it would give different
> results than the original code.  Version 3 returns to the V1 approach,
> additionally correcting the handling of masks with no bits set and
> fixing the num_possible_cpus() problem Peter Zijlstra noted.  In a
> stand-alone test program that used all possible sets of four 4-bit
> masks, this algorithm matched the original code in all cases, where
> the others did not.
>

So looking at my notes from v2 I was under the impression the array-less
approach worked, do you have an example topology where the array-less
approach fails? I usually poke at topology stuff via QEMU so if you have a
virtual topology description I'd be happy to give that a span.

> -	for_each_cpu_from(i, cpu_map) {
>               /*
> -		 * We should 'and' all those masks with 'cpu_map' to exactly
> -		 * match the topology we're about to build, but that can only
> -		 * remove CPUs, which only lessens our ability to detect
> -		 * overlaps
> +		 * Non-NUMA levels cannot partially overlap - they must be either
> +		 * completely equal or completely disjoint. Otherwise we can end up
> +		 * breaking the sched_group lists - i.e. a later get_group() pass
> +		 * breaks the linking done for an earlier span.
>                */
> -		if (!cpumask_equal(tl->mask(cpu), tl->mask(i)) &&
> -		    cpumask_intersects(tl->mask(cpu), tl->mask(i)))
> -			return false;
> +		for_each_cpu(cpu, cpu_map) {
> +			/* lowest bit set in this mask is used as a unique id */
> +			id = cpumask_first(tl->mask(cpu));
> +
> +			/* zeroed masks cannot possibly collide */
> +			if (id >= nr_cpu_ids)
> +				continue;
> +

Is it even legal for an online CPU's topology mask to be empty?! I would
assume it should *at least* contain itself.


