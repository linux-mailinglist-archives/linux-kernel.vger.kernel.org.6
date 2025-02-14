Return-Path: <linux-kernel+bounces-515231-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DA11A3620F
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 16:45:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D57E8171476
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 15:43:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A341267385;
	Fri, 14 Feb 2025 15:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b="ejh43c0D"
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C3312673BF
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 15:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.143.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739547807; cv=none; b=WU/uFeLQ3qKlW+hGUKM/N0eBK1VJSaJhtwjOcsu+lHv9Pu1zkJyx1gsjU9ZBzNK+YjNw0gVKh90F92YcH1Gs5VNNvR7GzBgn+o1Jso7uae3bjeNiL3M0D4BgWFiD6pM97T6zy8xIgnMoA9+nZ0JU4G4BFy4DNyY9iOzTLqB8iJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739547807; c=relaxed/simple;
	bh=dZXzMQb5O2AmkC8jdkr9tRh/L3jqIDrNhlRxfV8ItQk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tsAWxNNg7u8ndpZt4Pz9WdN6G4UVW7jWwphRwSOMxxseLoFB26T9JKckpMFFke0ZR5Pi92upwBn8Vg902kRjOkq8o5hjCp3dbsiyAwJVczDoVIIZ5vKiIOv3M13JhhWXV411dnotv1rEF2/ifPcB9VuPcaHkjFWm/nyes2DWYjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com; spf=pass smtp.mailfrom=hpe.com; dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b=ejh43c0D; arc=none smtp.client-ip=148.163.143.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpe.com
Received: from pps.filterd (m0150245.ppops.net [127.0.0.1])
	by mx0b-002e3701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51E70HtZ007642;
	Fri, 14 Feb 2025 15:42:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pps0720; bh=mQViGdtRzrNwmncZLiu91Xx046
	g4R4eBJwDHCIKBEHY=; b=ejh43c0DspcOyrTIvdlnG1b0grhf90t+6hCgKKQJQV
	UjUPObfUyNnw078sGwCMDufVpmhe/p5VSf7ZjeMRMyHog7bVZ12n8jSp89XUqrIH
	Pnsm9WpCsN89KlRKC+DqnQ5m1aanyZJ8XPj9HjYVUNtCemnNqJynUdwI2t994mPC
	pfcHw93bxGQc+arMoO6L710RZnsgKqTCKQybIlHHbnO+F2CO5Kg2u4MxAxexHud+
	hqEvliB65BH9GHgMrRkBRK0HRbUM9NL3rXoDOG1zH5LycvdFnlXhF2/ndhdASkrc
	29T+P9j1YQFp+diB11LnWjeHV+TzKnGYDYpFR4D32Fyg==
Received: from p1lg14879.it.hpe.com ([16.230.97.200])
	by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 44t12bkm2w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Feb 2025 15:42:55 +0000 (GMT)
Received: from p1lg14886.dc01.its.hpecorp.net (unknown [10.119.18.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by p1lg14879.it.hpe.com (Postfix) with ESMTPS id BE0AF2FCC7;
	Fri, 14 Feb 2025 15:42:43 +0000 (UTC)
Received: from swahl-home.5wahls.com (unknown [16.231.227.39])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by p1lg14886.dc01.its.hpecorp.net (Postfix) with ESMTPS id 6AB73810CF0;
	Fri, 14 Feb 2025 15:42:40 +0000 (UTC)
Date: Fri, 14 Feb 2025 09:42:38 -0600
From: Steve Wahl <steve.wahl@hpe.com>
To: Valentin Schneider <vschneid@redhat.com>
Cc: Steve Wahl <steve.wahl@hpe.com>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
        Mel Gorman <mgorman@suse.de>, linux-kernel@vger.kernel.org,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Vishal Chourasia <vishalc@linux.ibm.com>, samir <samir@linux.ibm.com>,
        Naman Jain <namjain@linux.microsoft.com>,
        Saurabh Singh Sengar <ssengar@linux.microsoft.com>,
        srivatsa@csail.mit.edu, Michael Kelley <mhklinux@outlook.com>,
        Russ Anderson <rja@hpe.com>, Dimitri Sivanich <sivanich@hpe.com>
Subject: Re: [PATCH v3] sched/topology: improve topology_span_sane speed
Message-ID: <Z69kbnJM5n64Ac6h@swahl-home.5wahls.com>
References: <20250210154259.375312-1-steve.wahl@hpe.com>
 <xhsmhseogiox0.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xhsmhseogiox0.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
X-Proofpoint-ORIG-GUID: _uZolY6R_HcE6Ik3ee4LXE-6KkGAl3Ft
X-Proofpoint-GUID: _uZolY6R_HcE6Ik3ee4LXE-6KkGAl3Ft
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-14_06,2025-02-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxlogscore=999
 malwarescore=0 adultscore=0 clxscore=1015 impostorscore=0
 lowpriorityscore=0 phishscore=0 bulkscore=0 suspectscore=0 mlxscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502140112

On Fri, Feb 14, 2025 at 03:25:31PM +0100, Valentin Schneider wrote:
> On 10/02/25 09:42, Steve Wahl wrote:
> > Use a different approach to topology_span_sane(), that checks for the
> > same constraint of no partial overlaps for any two CPU sets for
> > non-NUMA topology levels, but does so in a way that is O(N) rather
> > than O(N^2).
> >
> > Instead of comparing with all other masks to detect collisions, keep
> > one mask that includes all CPUs seen so far and detect collisions with
> > a single cpumask_intersects test.
> >
> > If the current mask has no collisions with previously seen masks, it
> > should be a new mask, which can be uniquely identified by the lowest
> > bit set in this mask.  Keep a pointer to this mask for future
> > reference (in an array indexed by the lowest bit set), and add the
> > CPUs in this mask to the list of those seen.
> >
> > If the current mask does collide with previously seen masks, it should
> > be exactly equal to a mask seen before, looked up in the same array
> > indexed by the lowest bit set in the mask, a single comparison.
> >
> > Move the topology_span_sane() check out of the existing topology level
> > loop, let it use its own loop so that the array allocation can be done
> > only once, shared across levels.
> >
> > On a system with 1920 processors (16 sockets, 60 cores, 2 threads),
> > the average time to take one processor offline is reduced from 2.18
> > seconds to 1.01 seconds.  (Off-lining 959 of 1920 processors took
> > 34m49.765s without this change, 16m10.038s with this change in place.)
> >
> > Signed-off-by: Steve Wahl <steve.wahl@hpe.com>
> > ---
> >
> > Version 3: While the intent of this patch is no functional change, I
> > discovered that version 2 had conditions where it would give different
> > results than the original code.  Version 3 returns to the V1 approach,
> > additionally correcting the handling of masks with no bits set and
> > fixing the num_possible_cpus() problem Peter Zijlstra noted.  In a
> > stand-alone test program that used all possible sets of four 4-bit
> > masks, this algorithm matched the original code in all cases, where
> > the others did not.
> >
> 
> So looking at my notes from v2 I was under the impression the array-less
> approach worked, do you have an example topology where the array-less
> approach fails? I usually poke at topology stuff via QEMU so if you have a
> virtual topology description I'd be happy to give that a span.

Valentin, thank you for your time looking at this patch.

Note that I'm trying to make this patch function exactly as the code
did before, only faster, regardless of the inputs.  No functional
change.

Your statement below about assuming a mask should at least contain the
cpu itself is intertwined with finding differences.  This code is
checking the validity of the masks.  If we can't already trust that
the masks are disjoint, why can we trust they at least have the cpu
itself set?

Where the assumption that a cpu's mask contains itself holds true, it
appears v2 and v3 agree.

An example of where the two disagree would be a set of four masks,
0010 0001 0001 0001.  These match the stated criteria being checked
(no overlap between masks that don't exactly match), yet the v2
algorithm would mark it insane, where the original code doesn't.

If it's valid to mark some additional conditions as insane, I'd rather
see that in a different patch, because I'm not comfortable enough with
the ramifications of possibly marking as insane a system that current
code reports as sane.

> > -	for_each_cpu_from(i, cpu_map) {
> >               /*
> > -		 * We should 'and' all those masks with 'cpu_map' to exactly
> > -		 * match the topology we're about to build, but that can only
> > -		 * remove CPUs, which only lessens our ability to detect
> > -		 * overlaps
> > +		 * Non-NUMA levels cannot partially overlap - they must be either
> > +		 * completely equal or completely disjoint. Otherwise we can end up
> > +		 * breaking the sched_group lists - i.e. a later get_group() pass
> > +		 * breaks the linking done for an earlier span.
> >                */
> > -		if (!cpumask_equal(tl->mask(cpu), tl->mask(i)) &&
> > -		    cpumask_intersects(tl->mask(cpu), tl->mask(i)))
> > -			return false;
> > +		for_each_cpu(cpu, cpu_map) {
> > +			/* lowest bit set in this mask is used as a unique id */
> > +			id = cpumask_first(tl->mask(cpu));
> > +
> > +			/* zeroed masks cannot possibly collide */
> > +			if (id >= nr_cpu_ids)
> > +				continue;
> > +
> 
> Is it even legal for an online CPU's topology mask to be empty?! I would
> assume it should *at least* contain itself.

Again, this is sanity checking untrusted inputs.  I realized that if a
mask was zero, the value of id would overindex the array.  The check
is cheap.

--> Steve

-- 
Steve Wahl, Hewlett Packard Enterprise

