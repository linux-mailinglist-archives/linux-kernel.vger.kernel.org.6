Return-Path: <linux-kernel+bounces-338010-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C5E1985260
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 07:26:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92D011C230D8
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 05:26:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1362214F9E9;
	Wed, 25 Sep 2024 05:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="UISts3pl"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BDD414A62F
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 05:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727241969; cv=none; b=n3ow41iKErWxDixHL9YhUw/JXygZz/hMidYgajhHo44SSzWHidCyUVwkPMH5Vyqse7fg4Tcs0NXhVCAdC5eLoL26ZOcEvMeNksab1Lk6vulC/a5PwuHc6D39CZ4OqnGRIO/tmhqD7SfkUlBJXbCR0qhmT/q6w++Id5NIidu0oXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727241969; c=relaxed/simple;
	bh=aqpZHQjv+jbOIBhgEc/YCfWTw+VUkwC2p04dhOBAkv0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Ak5NyLnfWWce04bJkFLzjLrAThNhjVeDQPyCjhNGC5VcTsf7w+LlnDpcP6RuLKvDdIe6fuLCGW3uq2+FysTKNQltnh1FztKv4bqNsMMcnTOFhd8KlxTgIQKzEw3eLGUOI4TFtJS2JRXVqiC3BQzPHyRR/I6Ye1Quv2aHWssmnUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=UISts3pl; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48P1Wg6H018838;
	Wed, 25 Sep 2024 05:25:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date
	:from:to:cc:subject:message-id:reply-to:references:content-type
	:in-reply-to:mime-version; s=pp1; bh=tB2ZBQbiSdGrrrGZ+85E9Fm5yI1
	BjXBYFiE/q7sXLZ8=; b=UISts3ploAKMFIDNjscCsaPSaeMudYOA5VGMrNV0+lC
	Yo9/81XPx5qFkcZRrFnwdf1J8TsQ1PGcuJV+2dZwyPn7WZKL9j8GINurCGCM9fyF
	lewwSzewyhstTEffH6ffR7GIaepLDFnje6HVEunYhiotmEpenTODtQ6tBw3eMXen
	0IpWEDXm3IlUR2FgHyJYWndz/ftBjN09wNVSF1JwFLeLVKnxT5lqzNoTsev1sLDH
	N2AAH5N13dxV9yngnp5GT6WuEVlE5eNgfqeVDp62sNTkobJblnTcFY3TRVm42U7G
	wcM/5ka8RXTpeos6AKJR0Yb4I7CsoMmySBZkngve88w==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41skjrnyky-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Sep 2024 05:25:55 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 48P5PtNn013656;
	Wed, 25 Sep 2024 05:25:55 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41skjrnykw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Sep 2024 05:25:55 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 48P1oEce012507;
	Wed, 25 Sep 2024 05:25:54 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 41t9fpyp59-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Sep 2024 05:25:54 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 48P5Pqap50266412
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 25 Sep 2024 05:25:52 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8CCAC20040;
	Wed, 25 Sep 2024 05:25:52 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BA47B20043;
	Wed, 25 Sep 2024 05:25:50 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.126.150.29])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with SMTP;
	Wed, 25 Sep 2024 05:25:50 +0000 (GMT)
Date: Wed, 25 Sep 2024 10:55:49 +0530
From: Srikar Dronamraju <srikar@linux.ibm.com>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: paulmck@kernel.org, Tejun Heo <tj@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Valentin Schneider <vschneid@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] Fix scalability problem in workqueue watchdog touch
 caused by stop_machine
Message-ID: <20240925052549.GI1578937@linux.ibm.com>
Reply-To: Srikar Dronamraju <srikar@linux.ibm.com>
References: <20240625114249.289014-1-npiggin@gmail.com>
 <9d1d4a41-fcdb-448c-9a0f-bc9909193fa9@paulmck-laptop>
 <D29JH7VL4HH7.3FSD747K8GPF@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <D29JH7VL4HH7.3FSD747K8GPF@gmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: aPOqlh4XltmxDt_6UIjmNbXJ9E0Boiow
X-Proofpoint-ORIG-GUID: YyozFeZjLlBJCcdVPGosTvCQewj8CX0m
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-24_02,2024-09-24_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 priorityscore=1501
 spamscore=0 adultscore=0 lowpriorityscore=0 impostorscore=0 phishscore=0
 clxscore=1011 malwarescore=0 mlxlogscore=966 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2408220000
 definitions=main-2409250033

* Nicholas Piggin <npiggin@gmail.com> [2024-06-26 10:57:36]:

> On Wed Jun 26, 2024 at 12:53 AM AEST, Paul E. McKenney wrote:
> > On Tue, Jun 25, 2024 at 09:42:43PM +1000, Nicholas Piggin wrote:
> > > Here are a few patches to fix a lockup caused by very slow progress due
> > > to a scalability problem in workqueue watchdog touch being hammered by
> > > thousands of CPUs in multi_cpu_stop. Patch 2 is the fix.
> > > 
> > > I did notice when making a microbenchmark reproducer that the RCU call
> > > was actually also causing slowdowns. Not nearly so bad as the workqueue
> > > touch, but workqueue queueing of dummy jobs slowed down by a factor of
> > > several times when lots of other CPUs were making
> > > rcu_momentary_dyntick_idle() calls. So I did the stop_machine patches to
> > > reduce that. So those patches 3,4 are independent of the first two and
> > > can go in any order.
> >
> > For the series:
> >
> > Reviewed-by: Paul E. McKenney <paulmck@kernel.org>
> 
> Oh, it did get a comment :) Thanks Paul. Not sure who owns the
> multi_cpu_stop loop, Tejun and Peter I guess but that was 10+
> years ago :P
> 
> I might ask Andrew if he would take patches 3-4, if there are
> no objections.
> 

patches 3 and 4 are still not part of any tree.
Can we please include them or are there any reservations on them.

The patches still seem to apply on top of Linus tree except one line where
rcu_momentary_dyntick_idle() has been renamed to rcu_momentary_eqs()

Commit 32a9f26e5e26 ("rcu: Rename rcu_momentary_dyntick_idle() into
rcu_momentary_eqs()") 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/patch/?id=32a9f26e5e26

-- 
Thanks and Regards
Srikar Dronamraju

