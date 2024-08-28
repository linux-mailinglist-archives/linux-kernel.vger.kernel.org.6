Return-Path: <linux-kernel+bounces-304309-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 65D91961DA6
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 06:33:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0FBAF1F24A34
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 04:33:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C28CF84A51;
	Wed, 28 Aug 2024 04:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="iKnQ/csp"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEB5DA48
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 04:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724819616; cv=none; b=N1PFTTxI82f0QlRTXlcfDyKodhis6O11IdU//EPkaC525qeeb3ZN7bOKfzroHmLH6sRUUGDBl+JyxSq+RhrXZvLihBBg+sfZHUThAoe2mA5MBBpqwYx8C0NAICSZP9BlO/ADAXmUGO2LziKQ7Uq+UmoATsiPfP7oZ8w43u8nkug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724819616; c=relaxed/simple;
	bh=DtOMVYHks3XezfZdOspCjx9wT576HLHWjfcSmxT4UWE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tL+YLa/vX2UwO7yynyxCtx3eRRwGooLqkVzvtTRm9jaRCtj5LUIX15AZd752+Z28NmiBKuAqvpf1u2bEG/vcCwixp4C/NtdiNwMyuvfXK2+YBH5EcBzP1jv+2s2kG8KLgg8HDVhXQeXBASB1u5PmR4XOw6BqQCMC8B9hBADmtWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=iKnQ/csp; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47RM3XNM027392;
	Wed, 28 Aug 2024 04:33:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date
	:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=pp1; bh=IFl+Vz26L0y0C7EQgmrvodKjpcF
	PDh2OiUaIKuQmjpE=; b=iKnQ/cspYz21xYnZ5QDh9w5zvJHTKjnJ2rHCLjOflfb
	j5tso33C0VRQ1+mhozTGRJerv0GBV+uCrnAotoOOd6qPdRa99seGOhdoMgXSJvmi
	axs0OCOinPfUEbZVeJ67Sy35xh/HUDJlc7517LOY3jZ9mHN90ebEXBfQK9yxmrez
	OqIlVVDh1GnZRffHGKBgesmD8S8DBgbPXID2XBXJDEX6/RygYpdJElw+gtW0/dbr
	8ZYhvu2B75+gqq9eS09CMTq8B0b+BREChIpl+ImOOqWooCn85r6/7IJWIfgwx3Zm
	Fn0pblhhJGKmvx/5ZK1Tc39fs1CC9ZcQPgoD19hSOoQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 419q8qs017-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 28 Aug 2024 04:33:19 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 47S4XJpB030232;
	Wed, 28 Aug 2024 04:33:19 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 419q8qs014-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 28 Aug 2024 04:33:19 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 47S0QVpJ030991;
	Wed, 28 Aug 2024 04:33:18 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 417t80x0rj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 28 Aug 2024 04:33:18 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 47S4XCYJ54919490
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 28 Aug 2024 04:33:12 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0626520043;
	Wed, 28 Aug 2024 04:33:12 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6187D20040;
	Wed, 28 Aug 2024 04:33:11 +0000 (GMT)
Received: from localhost (unknown [9.43.2.34])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 28 Aug 2024 04:33:11 +0000 (GMT)
Date: Wed, 28 Aug 2024 10:03:09 +0530
From: "Nysal Jan K.A." <nysal@linux.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>,
        Geetika Moolchandani <geetika@linux.ibm.com>,
        Vaishnavi Bhat <vaish123@in.ibm.com>,
        Jijo Varghese <vargjijo@in.ibm.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Naveen N Rao <naveen@kernel.org>, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/qspinlock: Fix deadlock in MCS queue
Message-ID: <ydj7mzamqvcd56a6culzelmlmrjbhx7zumcilxcms62vf7qhqg@a76xrftxbndd>
References: <20240826081251.744325-1-nysal@linux.ibm.com>
 <871q29fgn2.fsf@mail.lhotse>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <871q29fgn2.fsf@mail.lhotse>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: nuiwPHtG0V4FTjmO_lEyqeyq18DMaix2
X-Proofpoint-ORIG-GUID: 2GdTbzcklVE9fQFYV0puRnWFalRlDbAY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-28_02,2024-08-27_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 clxscore=1015 priorityscore=1501 mlxlogscore=445 spamscore=0 mlxscore=0
 suspectscore=0 lowpriorityscore=0 impostorscore=0 malwarescore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408280029

On Wed, Aug 28, 2024 at 01:52:33PM GMT, Michael Ellerman wrote:
> "Nysal Jan K.A." <nysal@linux.ibm.com> writes:
> > If an interrupt occurs in queued_spin_lock_slowpath() after we increment
> > qnodesp->count and before node->lock is initialized, another CPU might
> > see stale lock values in get_tail_qnode(). If the stale lock value happens
> > to match the lock on that CPU, then we write to the "next" pointer of
> > the wrong qnode. This causes a deadlock as the former CPU, once it becomes
> > the head of the MCS queue, will spin indefinitely until it's "next" pointer
> > is set by its successor in the queue. This results in lockups similar to
> > the following.
> ...
> >
> > Thanks to Saket Kumar Bhaskar for help with recreating the issue
> >
> > Fixes: 84990b169557 ("powerpc/qspinlock: add mcs queueing for contended waiters")
> > Cc: stable@vger.kernel.org # v6.2+
> > Reported-by: Geetika Moolchandani <geetika@linux.ibm.com>
> > Reported-by: Vaishnavi Bhat <vaish123@in.ibm.com>
> > Reported-by: Jijo Varghese <vargjijo@in.ibm.com>
>  
> Do we have links for any of these reports?

They are all internal reports on LTC bugzilla. I don't see one that is public.

> 
> cheers

Regards
--Nysal

