Return-Path: <linux-kernel+bounces-532351-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DEA21A44BEC
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 21:03:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 983C3170CA6
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 20:03:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4CA11ACEBB;
	Tue, 25 Feb 2025 20:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b="GzZaKiLY"
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D7DE2907
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 20:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.143.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740513817; cv=none; b=Nimi5eGenxDjCoA3iMZ6WsMAT6LcsOdniSvO/u34dhfIvX3d9TTe7RTDP/w5VJf58xDhuqH1hBV9jQyAcEaO28kejU1NiXJ1Q8TMHFcKnQCigTkdZ6C/8qrd+8GJlsjSMtDG1LhIyNeP+h2pqq/ms7dE/7MNMp30WAuRt6vrGJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740513817; c=relaxed/simple;
	bh=KFV6BPk7SMoF1OFd3EfwqHMNRKibLml95K6kF2VUFUM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CSP/0BJz+iFP8Cvpk4NFHNxr3arZIaKyaYLJXhg6Od5QLPk2Azo55lFhJhjCxIvGzwKptDsxbfM//Tg43QzY1LOZ1aJMU+zE8cp+PHtFp9KOr+i4JYjpwv20AwIzPsWrihrJQLAK42goFgluiJbeUHlgwGg0IXP94yGAMXI8qp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com; spf=pass smtp.mailfrom=hpe.com; dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b=GzZaKiLY; arc=none smtp.client-ip=148.163.143.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpe.com
Received: from pps.filterd (m0134423.ppops.net [127.0.0.1])
	by mx0b-002e3701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51PJ7wE1024711;
	Tue, 25 Feb 2025 20:02:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pps0720; bh=SugUAAbZpfAEyCPDpCT63EOxEc
	BGow/AfO3XyU1fKcw=; b=GzZaKiLYqNCWF5++bmV84XakC4IkHI7X2s7hj4LSWd
	OZj6kuTBsI6iwqEvgZySzfIRc2hrLkTI+4gEepD4KJNowNMTw+cREkzWBLy55OVO
	9mvrXbTZfyGnToUg/CjkR+TbjthEB3zW2dbVf+a1XYptlQNJa4n3F1uaStxT/i3m
	Z76GJFlc+cQhSFfTVg4GWG7XPGFaqozl4aT+tmkoyEGJQQy5Ey/R2dCUURxmurwQ
	MtGme5Fr+oQCbNA6Dh2Fd6s/hWCBhEBh0fsXLIlBOpyNT5fGMo+CQBM2v8nsq1PW
	ekiTEP4SVvK0Fqhhd5ymV4zV2VUs1TkUzCNurFuW0mGQ==
Received: from p1lg14881.it.hpe.com ([16.230.97.202])
	by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 451krj0ct3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Feb 2025 20:02:52 +0000 (GMT)
Received: from p1lg14885.dc01.its.hpecorp.net (unknown [10.119.18.236])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by p1lg14881.it.hpe.com (Postfix) with ESMTPS id 07F9380478D;
	Tue, 25 Feb 2025 20:02:51 +0000 (UTC)
Received: from swahl-home.5wahls.com (unknown [16.231.227.39])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by p1lg14885.dc01.its.hpecorp.net (Postfix) with ESMTPS id 19397801D88;
	Tue, 25 Feb 2025 20:02:47 +0000 (UTC)
Date: Tue, 25 Feb 2025 14:02:46 -0600
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
Message-ID: <Z74h5gJ_i8KgpZU8@swahl-home.5wahls.com>
References: <20250210154259.375312-1-steve.wahl@hpe.com>
 <xhsmhseogiox0.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
 <Z69kbnJM5n64Ac6h@swahl-home.5wahls.com>
 <xhsmhmsekj2xz.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
 <Z7eJmDg7tZ04ILWG@swahl-home.5wahls.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z7eJmDg7tZ04ILWG@swahl-home.5wahls.com>
X-Proofpoint-GUID: wBSNmDyJoSObAYI1yjxOvq97iesEJKyv
X-Proofpoint-ORIG-GUID: wBSNmDyJoSObAYI1yjxOvq97iesEJKyv
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-25_06,2025-02-25_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 impostorscore=0 malwarescore=0 priorityscore=1501 clxscore=1015
 adultscore=0 spamscore=0 mlxlogscore=999 phishscore=0 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502250120

On Thu, Feb 20, 2025 at 01:59:20PM -0600, Steve Wahl wrote:
> On Mon, Feb 17, 2025 at 11:11:36AM +0100, Valentin Schneider wrote:
> > On 14/02/25 09:42, Steve Wahl wrote:
> > > On Fri, Feb 14, 2025 at 03:25:31PM +0100, Valentin Schneider wrote:
> > >> On 10/02/25 09:42, Steve Wahl wrote:
> > >> > Use a different approach to topology_span_sane(), that checks for the
> > >> > same constraint of no partial overlaps for any two CPU sets for
> > >> > non-NUMA topology levels, but does so in a way that is O(N) rather
> > >> > than O(N^2).
> > >> >
> > >> > Instead of comparing with all other masks to detect collisions, keep
> > >> > one mask that includes all CPUs seen so far and detect collisions with
> > >> > a single cpumask_intersects test.
> > >> >
> > >> > If the current mask has no collisions with previously seen masks, it
> > >> > should be a new mask, which can be uniquely identified by the lowest
> > >> > bit set in this mask.  Keep a pointer to this mask for future
> > >> > reference (in an array indexed by the lowest bit set), and add the
> > >> > CPUs in this mask to the list of those seen.
> > >> >
> > >> > If the current mask does collide with previously seen masks, it should
> > >> > be exactly equal to a mask seen before, looked up in the same array
> > >> > indexed by the lowest bit set in the mask, a single comparison.
> > >> >
> > >> > Move the topology_span_sane() check out of the existing topology level
> > >> > loop, let it use its own loop so that the array allocation can be done
> > >> > only once, shared across levels.
> > >> >
> > >> > On a system with 1920 processors (16 sockets, 60 cores, 2 threads),
> > >> > the average time to take one processor offline is reduced from 2.18
> > >> > seconds to 1.01 seconds.  (Off-lining 959 of 1920 processors took
> > >> > 34m49.765s without this change, 16m10.038s with this change in place.)
> > >> >
> > >> > Signed-off-by: Steve Wahl <steve.wahl@hpe.com>
> > >> > ---
> > >> >
> > >> > Version 3: While the intent of this patch is no functional change, I
> > >> > discovered that version 2 had conditions where it would give different
> > >> > results than the original code.  Version 3 returns to the V1 approach,
> > >> > additionally correcting the handling of masks with no bits set and
> > >> > fixing the num_possible_cpus() problem Peter Zijlstra noted.  In a
> > >> > stand-alone test program that used all possible sets of four 4-bit
> > >> > masks, this algorithm matched the original code in all cases, where
> > >> > the others did not.
> > >> >
> > >>
> > >> So looking at my notes from v2 I was under the impression the array-less
> > >> approach worked, do you have an example topology where the array-less
> > >> approach fails? I usually poke at topology stuff via QEMU so if you have a
> > >> virtual topology description I'd be happy to give that a span.
> > >
> > > Valentin, thank you for your time looking at this patch.
> > >
> > > Note that I'm trying to make this patch function exactly as the code
> > > did before, only faster, regardless of the inputs.  No functional
> > > change.
> > >
> > > Your statement below about assuming a mask should at least contain the
> > > cpu itself is intertwined with finding differences.  This code is
> > > checking the validity of the masks.  If we can't already trust that
> > > the masks are disjoint, why can we trust they at least have the cpu
> > > itself set?
> > >
> > 
> > True... Though I think this would already be caught by the sched_domain
> > debugging infra we have, see sched_domain_debug_one().
> 
> Note that a previous patch of mine was reverted because it allowed
> another problem to surface on a small number of machines (and was
> later re-instated after fixing the other problem).
> 
> Reference: https://lore.kernel.org/all/20240717213121.3064030-1-steve.wahl@hpe.com
> 
> So, I am quite sensitive to introducing unintended behavior changes.
> 
> Anyway, sched_domain_debug_one() is only called when
> sched_debug_verbose is set.  But, at least as it sits currently,
> topology_span_sane() is run at all times, and its return code is acted
> on to change system behavior.
> 
> If there's a system out there where the cpu masks are buggy but
> currently accepted, I don't want this patch to cause that system to
> degrade by declaring it insane.
> 
> I don't fully understand all the code that sets up masks, as there's a
> lot of it.  But as an example, I think I see in
> arch/s390/kernel/topology.c, that update_cpu_masks() uses
> cpu_group_map() to update masks, and that function zeros the mask and
> then returns if the cpu is not set in cpu_setup_mask.  So potentially
> there can be some zeroed masks.
> 
> [Why am I looking at s390 code? Simply because a 'sort | uniq' on the
> possible tl->mask() functions took me to cpu_book_mask() first.]
> 
> > So roughly speaking I'd say SCHED_DEBUG+sched_verbose gives you basic
> > sanity checks on individual sched_domain's (and so indirectly topology
> > levels), while topology_span_sane() looks at the intersections between the
> > spans to check it all makes sense as a whole.
> > 
> > Arguably there is some intersection (!) between these two debugging
> > features, but I think it still makes sense to keep them separate.
> > 
> > > Where the assumption that a cpu's mask contains itself holds true, it
> > > appears v2 and v3 agree.
> > >
> > > An example of where the two disagree would be a set of four masks,
> > > 0010 0001 0001 0001.  These match the stated criteria being checked
> > > (no overlap between masks that don't exactly match), yet the v2
> > > algorithm would mark it insane, where the original code doesn't.
> > >
> > > If it's valid to mark some additional conditions as insane, I'd rather
> > > see that in a different patch, because I'm not comfortable enough with
> > > the ramifications of possibly marking as insane a system that current
> > > code reports as sane.
> > >
> > 
> > Per the above I think it's fairly safe to call that setup insane,
> > sched_domain_debug_one() would call it so.
> 
> But this isn't just debug code, at least as it sits now, and system
> operation changes based on what it returns.  It's not just a printk.
> 
> > IMO your v2 had sufficient checks and was quite neat without the
> > additional array. Unless I'm missing something I don't see why we couldn't
> > stick with that approach.
> 
> I won't deny I liked the appearance of v2.  As a separate follow on
> patch I certainly wouldn't object, especially if it came from someone
> working on improving the scheduling code, instead of someone who's
> just here because this code slows down large machines significantly.
> 
> But I would first like to see the speed-up in a low-risk form without
> possible functional changes.

Valentin,

How would you feel about a two part series, where part one is my v1
patch, and part 2 is the v2 improvements?  Then if there was a
problem with the v2 improvements, that could be reverted and we'd
still have the speed improvement.

Thanks for considering,

--> Steve Wahl

-- 
Steve Wahl, Hewlett Packard Enterprise

