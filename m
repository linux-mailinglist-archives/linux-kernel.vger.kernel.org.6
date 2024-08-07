Return-Path: <linux-kernel+bounces-278417-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 51FCC94AFFF
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 20:52:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF79C282DE9
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 18:52:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 124A913D52E;
	Wed,  7 Aug 2024 18:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="USSz9Ogw"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEC5D2770E
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 18:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723056727; cv=none; b=P38VdgQFWC1gkXlFpc+QZBWrbkozGcXtAp3WBD08xqlM8AN1iVJYtosEsLKEARG0oaLijCLB7iWQohFB2BikV0Jup93yXjGxG17pMGacv1s/3p08rWbvP/sbhHtiaDCnUp5RrS5eI0170RwMatzDjy1WqTWx4esNkWs0d1eu354=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723056727; c=relaxed/simple;
	bh=uqnEFoTEUK/4p+qjGedIlfsJVMEBWzdRLsRdD6mLOWs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GahJMDnGkt8VFrxd/UACL9sSHTOeksKe5m1y5fE2DIwhM4Qb++BCMVNqdFIDry1bEEQCgdOtNpcGqA5aMqocwGQYO0qfAExxnS3Q2evKCELGD6QuJ3OHMKoDTOLF4UKQLHn8n8zVPkkXJiRJhY+4waXYKwvNDfPPo6brbZWBszQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=USSz9Ogw; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4779lNn6006676;
	Wed, 7 Aug 2024 18:51:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date
	:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=pp1; bh=myjIk1jplhDKGHKUR6onVW7OzlU
	VF9vD9ubGmB2w2zg=; b=USSz9OgwE4k6gwTLCHczD3YvSKcVE26XvNLggL7Vp5V
	nuud1qXotOidh0+DI4RNEITo4cZrW1LH9E9n8lkKgAYjTxKsil2k74dBk/ZTFISY
	olkH7dbIIUkmhW3PMi07UEJa1sF3MJjVb7LiLjgJ0FrIT6IkAMSqH4KYBCYZRWTr
	bF4+cC9mGP3TAtygGMjQD8YqyJadIqooDKLYACk0YS8AK46K4pKJFbkDVRNNP4eX
	gUATY7sZYPwsV1TR3vl5AGJUO9nDqK2ifojDtS7sIqd/zqiQ4uLlSz5M6UUXoPxL
	pjfba4CQ4qFuRmGirlBTcJuKgk7nMFk53Sr3axN3b8g==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40uqcmu4sk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 07 Aug 2024 18:51:34 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 477I9bEo024386;
	Wed, 7 Aug 2024 18:51:33 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 40sy90tmwq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 07 Aug 2024 18:51:33 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 477IpRXA10682840
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 7 Aug 2024 18:51:29 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A32DB20043;
	Wed,  7 Aug 2024 18:51:27 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A10BA20040;
	Wed,  7 Aug 2024 18:51:26 +0000 (GMT)
Received: from li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com (unknown [9.171.4.225])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed,  7 Aug 2024 18:51:26 +0000 (GMT)
Date: Wed, 7 Aug 2024 20:51:24 +0200
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Guenter Roeck <linux@roeck-us.net>, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org,
        Linux-MM <linux-mm@kvack.org>, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 6.10 000/809] 6.10.3-rc3 review
Message-ID: <ZrPCLM7saGqOc0YU@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
References: <20240731095022.970699670@linuxfoundation.org>
 <718b8afe-222f-4b3a-96d3-93af0e4ceff1@roeck-us.net>
 <CAHk-=wiZ7WJQ1y=CwuMwqBxQYtaD8psq+Vxa3r1Z6_ftDZK+hA@mail.gmail.com>
 <53b2e1f2-4291-48e5-a668-7cf57d900ecd@suse.cz>
 <f63c6789-b01a-4d76-b7c9-74c04867bc13@roeck-us.net>
 <CAHk-=wjmumbT73xLkSAnnxDwaFE__Ny=QCp6B_LE2aG1SUqiTg@mail.gmail.com>
 <CAHk-=wiss_E41A1uH0-1MXF-GjxzW_Rbz+Xbs+fbr-vyQFpo4g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wiss_E41A1uH0-1MXF-GjxzW_Rbz+Xbs+fbr-vyQFpo4g@mail.gmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 75wiWQMFail5IVE_49tyL7VLokPFOhMB
X-Proofpoint-ORIG-GUID: 75wiWQMFail5IVE_49tyL7VLokPFOhMB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-07_11,2024-08-07_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 clxscore=1011
 priorityscore=1501 impostorscore=0 mlxscore=0 malwarescore=0 spamscore=0
 suspectscore=0 mlxlogscore=342 bulkscore=0 adultscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2407110000
 definitions=main-2408070128

On Tue, Aug 06, 2024 at 10:49:58AM -0700, Linus Torvalds wrote:

Hi Linus,

Though this turned out to be a parisc issue, I'll still answer in
case you are interested.

...
> Or maybe it's the s390 ffs().
> 
> It looks like
> 
>   static inline int ffs(int word)
>   {
>         unsigned long mask = 2 * BITS_PER_LONG - 1;
>         unsigned int val = (unsigned int)word;
> 
>         return (1 + (__flogr(-val & val) ^ (BITS_PER_LONG - 1))) & mask;
>   }
> 
> where s390 has this very odd "flogr" instruction ("find last one G
> register"?) for the non-constant case.
> 
> That uses a "union register_pair" but only ever uses the "even"
> register without ever using the full 128-bit part or the odd register.
> So the other register in the register pair is uninitialized.

In case of "flogr" instruction the odd register contains output data only.
There is no need to initialize it.

> Does that cause random compiler issues based on register allocation?

Using the register_pair guarantees that an even+odd register pair
is "reserved". As result, the register allocation prevents "flogr"
instruction from corrupting otherwise random odd register.

> Just for fun, does something like this make any difference?
> 
>   --- a/arch/s390/include/asm/bitops.h
>   +++ b/arch/s390/include/asm/bitops.h
>   @@ -305,6 +305,7 @@ static inline unsigned char __flogr(unsigned long word)
>                 union register_pair rp;
> 
>                 rp.even = word;
>   +             rp.odd = 0;
>                 asm volatile(
>                         "       flogr   %[rp],%[rp]\n"
>                         : [rp] "+d" (rp.pair) : : "cc");
...

>               Linus

Thanks!

