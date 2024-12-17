Return-Path: <linux-kernel+bounces-449810-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B69559F566A
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 19:38:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D6B0C7A38AA
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 18:38:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32EB91F6671;
	Tue, 17 Dec 2024 18:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b="KpcHPUYJ"
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC4101EEE0
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 18:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.147.86
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734460692; cv=none; b=lr8PYUztD8rs4dugJr6zP9BCBizQo3/bpEarWkW6/XM5qw4ykSOyEG44JEkJa/ldK+tFx9fmlBRczWWtQoysx2rQG7gSHaiSw4PXdqkrUWpi6snfzoCboJzYtxbaz7EFb11yc5WDXGiZMxVc93uxSIWOFx785v8VxcD2myyT1HY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734460692; c=relaxed/simple;
	bh=zS1bwBZtL6m2CfEoUNHjCjI9PcNJCu80u7WtTMgjFjM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=APiYiMTNE7kToOahcThKli8jUKvCLuKVeuF1CdDm3Co3tjuyDEfZQ1gbUrZpPsy6+0cdzagwUEzsngcg91ccq5KIYrzLg99sq8mOufhEJrZ0jUKdImqmATc5irWX8hzYlM24iEFeX/yNy9OxwCECMwz4DDmUv9eX8kxeMrwm8oA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com; spf=pass smtp.mailfrom=hpe.com; dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b=KpcHPUYJ; arc=none smtp.client-ip=148.163.147.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpe.com
Received: from pps.filterd (m0148663.ppops.net [127.0.0.1])
	by mx0a-002e3701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BHGH829016464;
	Tue, 17 Dec 2024 18:16:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pps0720; bh=8ZMGMPv4qgNfOj3MGYi6mrLOH1
	kBDGANCNp78fh2934=; b=KpcHPUYJvULA7v2FcPj+zNz7Y0xTYM20dFA3MAHIYW
	g2uF5+Il6NeXPc958lxncfqRZaGBtEX16oW39s/v0L34vxTqjzoKXdt/IwMLIyoG
	dIzdM0F/GbWV59mlml9ELT/rtvCD51ZE1wUhjRSSCWw7LYaWy4v8ZAlQlVdzwJ6j
	NViMk9dCVslbXdvqOK5GtUS3IFhp9jTn7T/Xr4Ad1rHoQ0zKnUhdHISDdQnM/bCy
	FIWGaLKKsHryhGZTbc0WvMrEzYU8JK89RRUrbMY+17mcAF+RoHn/FVHfSR6esfxt
	sXi+SdBB/DGNo2SaLgWzEM0YwvlfSXjCn1TdM4Abm0UQ==
Received: from p1lg14879.it.hpe.com ([16.230.97.200])
	by mx0a-002e3701.pphosted.com (PPS) with ESMTPS id 43kcpg127g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Dec 2024 18:16:28 +0000 (GMT)
Received: from p1lg14886.dc01.its.hpecorp.net (unknown [10.119.18.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by p1lg14879.it.hpe.com (Postfix) with ESMTPS id 5036CD1EE;
	Tue, 17 Dec 2024 18:16:26 +0000 (UTC)
Received: from swahl-home.5wahls.com (unknown [16.231.227.39])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by p1lg14886.dc01.its.hpecorp.net (Postfix) with ESMTPS id 6D405811A79;
	Tue, 17 Dec 2024 18:16:23 +0000 (UTC)
Date: Tue, 17 Dec 2024 12:16:21 -0600
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
        Russ Anderson <rja@hpe.com>, Dimitri Sivanich <sivanich@hpe.com>
Subject: Re: [PATCH v2] sched/topology: improve topology_span_sane speed
Message-ID: <Z2G_9WqiSdlv3ItV@swahl-home.5wahls.com>
References: <20241031200431.182443-1-steve.wahl@hpe.com>
 <xhsmhttb3fxim.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xhsmhttb3fxim.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
X-Proofpoint-GUID: uq1ZSz9O_gZVp7SiQZeqP4B8IGFg-o4c
X-Proofpoint-ORIG-GUID: uq1ZSz9O_gZVp7SiQZeqP4B8IGFg-o4c
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-05_03,2024-10-04_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 priorityscore=1501 adultscore=0 bulkscore=0 impostorscore=0 clxscore=1015
 mlxscore=0 mlxlogscore=334 phishscore=0 spamscore=0 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412170139

On Mon, Dec 16, 2024 at 04:38:57PM +0100, Valentin Schneider wrote:
> 
> Hi,
> 
> Sorry it took me this long to get to this.
> 
...
> Per the previous comment, if you hinge the condition on @id itself,
> couldn't you "simplify" it as below?
> 
> 	if (cpumask_test_cpu(id, id_seen)) {
> 		/* First CPU has already been seen, ensure identical spans */
> 		if (!cpumask_equal(tl->mask(id), tl_cpu_mask))
> 			return false;
> 	} else {
> 		/* First CPU hasn't been seen before, ensure it's a completely new span */
> 		if (cpumask_intersects(tl_cpu_mask, covered))
> 			return false;
> 
> 		cpumask_or(covered, covered, tl_cpu_mask);
> 		cpumask_set_cpu(id, id_seen);
> 	}

After further evaluation, I wish to re-work this patch once again. I
ask that nobody consider merging this patch until I re-work it and
post v3.

Thanks,

--> Steve Wahl
-- 
Steve Wahl, Hewlett Packard Enterprise

