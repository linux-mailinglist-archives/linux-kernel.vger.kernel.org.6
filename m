Return-Path: <linux-kernel+bounces-366887-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7807599FBD2
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 00:58:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C6B01C2494D
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 22:58:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BBDC1D63D3;
	Tue, 15 Oct 2024 22:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b="gUSH+CtT"
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E4F51B0F0D
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 22:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.147.86
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729033118; cv=none; b=Bczj/T3nDWHzWF6utcSRe/SyVhZ5CIB0bqtDzTurUcSpmWubgyB+EDpTjUF329lG34mZBICVlJogt+HyM2RKEFUNdVbUAPRmu9Q+bVg/JBJ0SlJEEa/OQeBCltxBkPohZRYtU1XbjNmZcxH7vRpxX0J5jcwJHaYiDJYrfpFvbog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729033118; c=relaxed/simple;
	bh=jhfdTg1wCG9LnVg/pEbvf4lMey+GBpw/PyyHDDviQI8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ucI7yH3TIQjflBk8khMm+v68Tizci2inMjDmrsppuFre6xbUNnk9gj/h5CfetdQgM838hyHGdVGTHV8X0zOXkFtiqBwVdQUkHj0Hq8/zQxrg66cYpy564zsR59iixNTrM1LrcJIRBOCVyrl4EPCoPhDOAaCve+WdibTKu0+v6SY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com; spf=pass smtp.mailfrom=hpe.com; dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b=gUSH+CtT; arc=none smtp.client-ip=148.163.147.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpe.com
Received: from pps.filterd (m0150242.ppops.net [127.0.0.1])
	by mx0a-002e3701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49FKKKSI024651;
	Tue, 15 Oct 2024 22:32:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pps0720; bh=4PipRfAAvKjC9HGkRJeE+oWxzi
	BkUAMSsa9iUF+oprQ=; b=gUSH+CtTAmMyLR4fol/1UYYGZBKQeBZnBiCNoS5kGa
	ntKLVTqTircRfcfk7ydjf6OjE3HqhZbElIYTaLyHzWvnYiJB2duyJa3n8fPpitlb
	Ar0JZABv644CQM3NHzPNeuuUY2Bl2yEEKF7JUSWjzOHauxS/pkOFAlk/9ymsovcE
	BqAvnax7SNhF+DTpc/uE4381aVCMakbQwELcLw0L39ZGYIsDwv6bjg5AV31PQerx
	FGNQm4IPXiiFF5b24ejTJzYPoLUlXT3s+3UXEbkGnUHZ5aZNI5aIl5xv9rmuEDH5
	biPNc1kJ0Q11f50FpHu1DAbv2h1kO6oDEk/wQ549SJEQ==
Received: from p1lg14879.it.hpe.com ([16.230.97.200])
	by mx0a-002e3701.pphosted.com (PPS) with ESMTPS id 4298g8c3qw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Oct 2024 22:32:25 +0000 (GMT)
Received: from p1lg14885.dc01.its.hpecorp.net (unknown [10.119.18.236])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by p1lg14879.it.hpe.com (Postfix) with ESMTPS id 999911374F;
	Tue, 15 Oct 2024 22:32:24 +0000 (UTC)
Received: from swahl-home.5wahls.com (unknown [16.231.227.36])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by p1lg14885.dc01.its.hpecorp.net (Postfix) with ESMTPS id 5C2948038F8;
	Tue, 15 Oct 2024 22:32:22 +0000 (UTC)
Date: Tue, 15 Oct 2024 17:32:20 -0500
From: Steve Wahl <steve.wahl@hpe.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: K Prateek Nayak <kprateek.nayak@amd.com>, Steve Wahl <steve.wahl@hpe.com>,
        Russ Anderson <rja@hpe.com>, Dimitri Sivanich <sivanich@hpe.com>,
        Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
        Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched/topology: improve topology_span_sane speed
Message-ID: <Zw7tdG1J9-SoUdT3@swahl-home.5wahls.com>
References: <20241010155111.230674-1-steve.wahl@hpe.com>
 <60473622-e6f9-561b-a269-9da64add4966@amd.com>
 <20241015110544.GQ16066@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241015110544.GQ16066@noisy.programming.kicks-ass.net>
X-Proofpoint-GUID: 9xjGAWnl5hgOf05zQ7w9D2sC_SJ-xMlX
X-Proofpoint-ORIG-GUID: 9xjGAWnl5hgOf05zQ7w9D2sC_SJ-xMlX
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-05_02,2024-10-04_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 clxscore=1015
 lowpriorityscore=0 suspectscore=0 priorityscore=1501 malwarescore=0
 adultscore=0 phishscore=0 mlxscore=0 mlxlogscore=579 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410150148

On Tue, Oct 15, 2024 at 01:05:44PM +0200, Peter Zijlstra wrote:
> On Tue, Oct 15, 2024 at 03:50:49PM +0530, K Prateek Nayak wrote:
> 
> > > +	masks = kmalloc_array(num_possible_cpus(), sizeof(struct cpumask *), GFP_KERNEL);
> > > +	if (!masks)
> > > +		return ret;
> > 
> > That looks like a very large array that seems unnecessary. Instead, is
> > it possible to use "tl->mask(id)" down blow to check for equality? (I'll
> > elaborate more below)
> 
> drive-by comments, haven't got time atm to read this, but
> num_possible_cpus() is wrong, this should be nr_cpu_ids.
> 
> The CPU mask must not be assumed dense.

You're absolutly right, not sure how I did this, but Prateek's
suggestion will remove the array and needing to size it, so this
problem will be removed in the next iteration.

--> Steve

-- 
Steve Wahl, Hewlett Packard Enterprise

