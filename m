Return-Path: <linux-kernel+bounces-368393-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 953239A0F59
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 18:09:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4CC03286D91
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 16:08:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C926D20F5D7;
	Wed, 16 Oct 2024 16:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b="INS+QE1E"
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6384020F5AB
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 16:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.147.86
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729094934; cv=none; b=GuLBx3I5Bsn92+ffQ39Cdz8iUSJcOysBSZsusczzVyQ+tWsdV+cJVNpCLLy3dNovfYe7Ms2Fhs77xDHu9KguHHPA1beL9lJUZdSm2x8/PjC7cS2uK92rXd8h3yn+spxNb6oR408KgFve0nef9aJ+Aro7e97kGXcHspzbU6gLJhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729094934; c=relaxed/simple;
	bh=b3bOo2i+1abVW/coQ91SLdfp1716Zook8HBE3771CRA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qZHhp12JABxxlTDYKdGxEprPzac6ypG5h3AKj0bpRFr7inilVKOZ1tAfv/qkmdrn2gWDRtQMznmKWe4cXElN6QRx5mJMVkhlslqu/z3MJ18FZIPMMg/BXj53eWgNnWqRC8dq+ief3pCL6AlSLk6t0zEP5vV4P5HHEsyspKhSImQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com; spf=pass smtp.mailfrom=hpe.com; dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b=INS+QE1E; arc=none smtp.client-ip=148.163.147.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpe.com
Received: from pps.filterd (m0134421.ppops.net [127.0.0.1])
	by mx0b-002e3701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49GE9oDS014349;
	Wed, 16 Oct 2024 16:08:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pps0720; bh=vg/PUnTSN/yBdCkL+1GkKAunID
	/9Jo80W6vHksECXYA=; b=INS+QE1E06/PQ73P2DO6bYWV6gYhAvl6DhBzXS76Ya
	PsVlU/dhxwmv5KGY3OZwAtIp+VPg084uUY91keodvsKtY0Unf6Z8LR9EfnAbuSDR
	sWZmPA9D9MLAUm8sLm9GgqsGQaJyEbyeWVi6bsN1nfFtQ9/DnEVYUrqzwWWs3nZl
	l5ckYTBScmGlTVX0jqpwQiVQnWINS+ukFn3F/1g2TK8TnKBoiaLHXaBcmGUX0e9i
	d6fVwU2+kC0wkzHrPJp+gy8bnIvNAvrBDZK7+G4CUKc/O9hRote2r4TvVBvShwbn
	molGuS8mKfTs3Jk2h+3vegqryScWtK0VlE90Yv6bAjiQ==
Received: from p1lg14880.it.hpe.com ([16.230.97.201])
	by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 42af0th39p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 16 Oct 2024 16:08:34 +0000 (GMT)
Received: from p1lg14885.dc01.its.hpecorp.net (unknown [10.119.18.236])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by p1lg14880.it.hpe.com (Postfix) with ESMTPS id 1D68B800E9B;
	Wed, 16 Oct 2024 16:08:34 +0000 (UTC)
Received: from swahl-home.5wahls.com (unknown [16.231.227.39])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by p1lg14885.dc01.its.hpecorp.net (Postfix) with ESMTPS id 843578005C0;
	Wed, 16 Oct 2024 16:08:31 +0000 (UTC)
Date: Wed, 16 Oct 2024 11:08:29 -0500
From: Steve Wahl <steve.wahl@hpe.com>
To: Valentin Schneider <vschneid@redhat.com>
Cc: Steve Wahl <steve.wahl@hpe.com>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
        Mel Gorman <mgorman@suse.de>, linux-kernel@vger.kernel.org,
        Russ Anderson <rja@hpe.com>, Dimitri Sivanich <sivanich@hpe.com>
Subject: Re: [PATCH] sched/topology: improve topology_span_sane speed
Message-ID: <Zw_k_WFeYFli87ck@swahl-home.5wahls.com>
References: <20241010155111.230674-1-steve.wahl@hpe.com>
 <xhsmh34kxv3dc.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
 <xhsmhv7xstqn0.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xhsmhv7xstqn0.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
X-Proofpoint-GUID: tkVrUk_yP5fcx72PKkITZqL4uhug6EES
X-Proofpoint-ORIG-GUID: tkVrUk_yP5fcx72PKkITZqL4uhug6EES
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-05_03,2024-10-04_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 adultscore=0
 impostorscore=0 suspectscore=0 mlxlogscore=866 priorityscore=1501
 phishscore=0 lowpriorityscore=0 clxscore=1015 malwarescore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410160102

On Wed, Oct 16, 2024 at 10:10:11AM +0200, Valentin Schneider wrote:
> On 15/10/24 16:37, Valentin Schneider wrote:
> > On 10/10/24 10:51, Steve Wahl wrote:
> >> Use a different approach to topology_span_sane(), that checks for the
> >> same constraint of no partial overlaps for any two CPU sets for
> >> non-NUMA topology levels, but does so in a way that is O(N) rather
> >> than O(N^2).
> >>
> >> Instead of comparing with all other masks to detect collisions, keep
> >> one mask that includes all CPUs seen so far and detect collisions with
> >> a single cpumask_intersects test.
> >>
> >> If the current mask has no collisions with previously seen masks, it
> >> should be a new mask, which can be uniquely identified by the lowest
> >> bit set in this mask.  Keep a pointer to this mask for future
> >> reference (in an array indexed by the lowest bit set), and add the
> >> CPUs in this mask to the list of those seen.
> >>
> >> If the current mask does collide with previously seen masks, it should
> >> be exactly equal to a mask seen before, looked up in the same array
> >> indexed by the lowest bit set in the mask, a single comparison.
> >>
> >> Move the topology_span_sane() check out of the existing topology level
> >> loop, let it use its own loop so that the array allocation can be done
> >> only once, shared across levels.
> >>
> >> On a system with 1920 processors (16 sockets, 60 cores, 2 threads),
> >> the average time to take one processor offline is reduced from 2.18
> >> seconds to 1.01 seconds.  (Off-lining 959 of 1920 processors took
> >> 34m49.765s without this change, 16m10.038s with this change in place.)
> >>
> >
> > This isn't the first complaint about topology_span_sane() vs big
> > systems. It might be worth to disable the check once it has scanned all
> > CPUs once - not necessarily at init, since some folks have their systems
> > boot with only a subset of the available CPUs and online them later on.
> >
> > I'd have to think more about how this behaves vs the dynamic NUMA topology
> > code we got as of
> >
> >   0fb3978b0aac ("sched/numa: Fix NUMA topology for systems with CPU-less nodes")
> >
> > (i.e. is scanning all possible CPUs enough to guarantee no overlaps when
> > having only a subset of online CPUs? I think so...)
> >
> > but maybe something like so?
> 
> 
> I'd also be tempted to shove this under SCHED_DEBUG + sched_verbose, like
> the sched_domain debug fluff. Most distros ship with SCHED_DEBUG anyway, so
> if there is suspicion of topology mask fail, they can slap the extra
> cmdline argument and have it checked.

I understand the idea, but as I read closer, things under SCHED_DEBUG
and sched_verbose currently don't change any actions, just add
additional information output, and some checks that may or may not
print things but do not otherwise change what gets executed.

However, topology_span_sane failing currently causes
build_sched_domains to abort and return an error.  I don't think I
should change the action / skip the test if SCHED_DEBUG isn't on,
because I believe the debug version should always take the same paths
as non-debug.

So there's not much that could be removed when SCHED_DEBUG isn't on or
sched_verbose isn't set.

--> Steve

-- 
Steve Wahl, Hewlett Packard Enterprise

