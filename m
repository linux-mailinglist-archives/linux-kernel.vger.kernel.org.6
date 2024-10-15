Return-Path: <linux-kernel+bounces-366018-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C47B99EFBD
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 16:38:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A37E282157
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 14:38:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B8E21C4A22;
	Tue, 15 Oct 2024 14:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b+nibxxJ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B333E1D516F
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 14:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729003064; cv=none; b=R53yKpywmjmxKsjYHcAzcSoJF+Qr2tAsUV6XyQHY+OTcrN/4R5t7utUT3Ouu8FPnAWPx+Wln3w8eV0DKNdHcbLoCVuZHSUGmzJldT0tmTe3JHdBUaCXbzDrq/KNAPElQKjpYTnEJTX02RcmMdWg6K8lU7jkS+E2Az5VZ/FZVXnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729003064; c=relaxed/simple;
	bh=3ORK9QmMm9/z8HTBQ0Pu9FC8FS21Zyh6ymL8KvnFDf8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fnZmH3CsEmIUgRElomzXNfF0spkqUw8ziRahvBxSzevfcedxhN0F1Alz2RGiU5aA8SZLhxv6t34WVBdAd6yCsyB62aN9Dj+unpzCoV8avVW3VbiOIudi4bW/CWPfM1NgfO6cynPf2VC1s8z4FNKCERxuolaOsknVEOSOHCD0rR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=b+nibxxJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729003061;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Jil6rhBmUsYqPqrNl1QTFBKfvq936MO3YF89zRosvWA=;
	b=b+nibxxJq9eoO+1ajnEEmUv9K5BY2RzBdSgQGQQM24wCnR9MewXqLdXERiatBGze9x7fx4
	lRSrplY3I+TWjRbMfpK5G4Zst1PRQiYqtYKp2h9jTs2GEdJn4+R+y4LHzYahQA6LrJe+0C
	CCjRtDfzixdMTWLZutdS82/IW2nNYro=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-124-ta_CqULfP3Wqag03p_oDdw-1; Tue, 15 Oct 2024 10:37:40 -0400
X-MC-Unique: ta_CqULfP3Wqag03p_oDdw-1
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7b14073eabdso36415285a.3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 07:37:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729003060; x=1729607860;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Jil6rhBmUsYqPqrNl1QTFBKfvq936MO3YF89zRosvWA=;
        b=NZdVG6VWzSVYPB7ssF+h64jMsu5/QuasGiZCsu5mT8wXxg8fxsLOVZygUnBXNEk1iU
         98YBgaE9kyG2qRw61vYG08O9h5jIBJqzgI+DlVKjUE0XbRZHSxKP2XLK8mUOuoBNkG47
         oTAQD2xUbM7BMJIXujgGiDmja0NKG19hRyQVSJdRcDk7yZfaKrFlqVbiXDHl953A1ZAW
         eAvdP83YEVSU2m+Q6jCS6JZ5Nhf9ZuI+BS9nnzWMshqYQ/Igs1DpoHjJW9Z/H+LCdv+G
         6LjCsSRp/4JYUdDWYV05EwLmV0MkVCZv7Ego8ZYZmgqKsUgxdC1DTyF5Lk3SHEShKMwx
         8+QA==
X-Forwarded-Encrypted: i=1; AJvYcCXyYgsuDa8K2jePG9U4MV7QtYxF4vvhYlayY4fhoddmyC0JMAaY4yrTVyN0dBjB6Yn5Z4tFGKSiCgDoMnk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkazQuUcSSBqlvwCzkQIXJuZ2D77VolLo5voSfO3lNLuCYvRxP
	P94LYEgcRmRHqOw5KsdPGaVRp5j2qRyKFNkJHvpGwt+/AFH5+gbF/kSjQZrH6rkIaYTvhtTvnwo
	oFEttf2Pmzt9OLHaBDvqWjkzrlxBhKVqUevvhOLga63nKU4o0mUoeYz0UYzRXvA==
X-Received: by 2002:a05:620a:4408:b0:7a2:ce2:5702 with SMTP id af79cd13be357-7b120faaab2mr1977564285a.10.1729003059644;
        Tue, 15 Oct 2024 07:37:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH3ymHpLMnJbxeDBu/7nyTmVQPb6GTrB4/NCj4c6GJUw7QhrOo7gz/pjiPdY5W07O1ORQZSNw==
X-Received: by 2002:a05:620a:4408:b0:7a2:ce2:5702 with SMTP id af79cd13be357-7b120faaab2mr1977560385a.10.1729003059213;
        Tue, 15 Oct 2024 07:37:39 -0700 (PDT)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-141-166.abo.bbox.fr. [213.44.141.166])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b136395171sm76111185a.84.2024.10.15.07.37.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2024 07:37:38 -0700 (PDT)
From: Valentin Schneider <vschneid@redhat.com>
To: Steve Wahl <steve.wahl@hpe.com>, Steve Wahl <steve.wahl@hpe.com>, Ingo
 Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Juri
 Lelli <juri.lelli@redhat.com>, Vincent Guittot
 <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel
 Gorman <mgorman@suse.de>, linux-kernel@vger.kernel.org
Cc: Russ Anderson <rja@hpe.com>, Dimitri Sivanich <sivanich@hpe.com>
Subject: Re: [PATCH] sched/topology: improve topology_span_sane speed
In-Reply-To: <20241010155111.230674-1-steve.wahl@hpe.com>
References: <20241010155111.230674-1-steve.wahl@hpe.com>
Date: Tue, 15 Oct 2024 16:37:35 +0200
Message-ID: <xhsmh34kxv3dc.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 10/10/24 10:51, Steve Wahl wrote:
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

This isn't the first complaint about topology_span_sane() vs big
systems. It might be worth to disable the check once it has scanned all
CPUs once - not necessarily at init, since some folks have their systems
boot with only a subset of the available CPUs and online them later on.

I'd have to think more about how this behaves vs the dynamic NUMA topology
code we got as of

  0fb3978b0aac ("sched/numa: Fix NUMA topology for systems with CPU-less nodes")

(i.e. is scanning all possible CPUs enough to guarantee no overlaps when
having only a subset of online CPUs? I think so...)

but maybe something like so?
---
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 9748a4c8d6685..bf95c3d4f6072 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -2361,12 +2361,25 @@ static struct sched_domain *build_sched_domain(struct sched_domain_topology_leve
 static bool topology_span_sane(struct sched_domain_topology_level *tl,
 			      const struct cpumask *cpu_map, int cpu)
 {
+	static bool validated;
 	int i = cpu + 1;
 
+	if (validated)
+		return true;
+
 	/* NUMA levels are allowed to overlap */
 	if (tl->flags & SDTL_OVERLAP)
 		return true;
 
+	/*
+	 * We're visiting all CPUs available in the system, no need to re-check
+	 * things after that. Even if we end up finding overlaps here, we'll
+	 * have issued a warning and can skip the per-CPU scan in later
+	 * calls to this function.
+	 */
+	if (cpumask_equal(cpu_map, cpu_possible_mask))
+		validated = true;
+
 	/*
 	 * Non-NUMA levels cannot partially overlap - they must be either
 	 * completely equal or completely disjoint. Otherwise we can end up


