Return-Path: <linux-kernel+bounces-577077-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 878FDA7180F
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 15:05:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8B8816799B
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 14:05:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F7F41EDA3F;
	Wed, 26 Mar 2025 14:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="E+MhRjrY"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0A9D18EB0
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 14:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742997910; cv=none; b=jkXJCPuJgwZNOi7dBvL+iTmFsBgBNQg8/Gl23mf6RwAbw1xuXS2KeufCsyF9JHJiULRmAJ9xoqLPnDupjz28mmyDkjfZl4H4yFY98q08MYFSos6bL+WsdFZcOQjwqmcdcqbh+Y1yKXMJkyEThryJdPjqzpO7+7AaTAcGRQ+/zfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742997910; c=relaxed/simple;
	bh=MAUPqztEcEvMzz9KKyDIk1n2vKwEIJ4+M6R7oK5I+Qw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BWcFK9p+Fc2MuQyEYiBBNSmCG4iduY18LZ17k3k+/8ppO1RXc12Iruvc3uMrdNsE0Ef8MRm0acBeXmVxWVL6N3Y1Y3+QaPudzihbBvhFMoWXhv0uVA+Nqjj1OapJoFJbBf51yxAkUWxYyPHNkMQiBgYfILGFYMn0ACL2CY2fPDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=E+MhRjrY; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52QAApOe027689;
	Wed, 26 Mar 2025 14:04:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=rLUoDI
	gLEIMNKtQPUuBdHTqMji1aMxNbTKWy0xmu5Kk=; b=E+MhRjrY0jN/wpDoFibz7b
	Dn801IOp07rk2Nkqs2xemWUkN/QoEhVMY/UXNGIkytZgTLU0xyfUnVtDJs4+sQ/5
	HwJHT7i6ymGNPdFc4/5jJQfwj/0M31CqIye5C1N5r/x74q2BJp4DXziO6SfKbPZ0
	RnQS3kvMkTtoMPm2L6lmEuqpr6kD6O6+SkxJgkSeLgNJXDXf82vlPrOE0tbfS63r
	2lj8pkpwQGVEotAvMR2bzJKQ4o8MCpoxu57PZqAia/2mpgaDWR8bCSwb9v3vfClO
	3w/vB6YEhA3p9MBob2AYJaDHYwLKmq50UmmXXC4bQR52Ad4dfH6NaQzLOc8vEsGA
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45kbjx38hn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Mar 2025 14:04:31 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 52QDqBnX010962;
	Wed, 26 Mar 2025 14:04:31 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45kbjx38hj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Mar 2025 14:04:31 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52QA1taf020029;
	Wed, 26 Mar 2025 14:04:30 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 45j8hp0ks7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Mar 2025 14:04:30 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 52QE4T3k20775614
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Mar 2025 14:04:29 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E1F8858053;
	Wed, 26 Mar 2025 14:04:28 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C003658043;
	Wed, 26 Mar 2025 14:04:12 +0000 (GMT)
Received: from [9.43.88.159] (unknown [9.43.88.159])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 26 Mar 2025 14:04:12 +0000 (GMT)
Message-ID: <1a130b61-bc34-4d9d-90b8-ebfb31946b05@linux.ibm.com>
Date: Wed, 26 Mar 2025 19:34:09 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] Please pull powerpc/linux.git powerpc-6.15-1 tag
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: adubey@linux.ibm.com, amachhiw@linux.ibm.com, arnd@arndb.de,
        atrajeev@linux.ibm.com, avnish@linux.ibm.com,
        christophe.leroy@csgroup.eu, gautam@linux.ibm.com,
        gbatra@linux.ibm.com, jk@ozlabs.org, kjain@linux.ibm.com,
        kuba@kernel.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au, naveen@kernel.org,
        npiggin@gmail.com, paulus@ozlabs.org, robh@kernel.org,
        schwab@linux-m68k.org, segher@kernel.crashing.org,
        sourabhjain@linux.ibm.com, tglx@linutronix.de,
        torvalds@linux-foundation.org, vaibhav@linux.ibm.com
References: <90872dd1a7f8844e313876afb74ec15aff7299b7.camel@physik.fu-berlin.de>
Content-Language: en-US
From: Madhavan Srinivasan <maddy@linux.ibm.com>
In-Reply-To: <90872dd1a7f8844e313876afb74ec15aff7299b7.camel@physik.fu-berlin.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: xGOttpnaiOg7-yul-hD8T_cr07eqDgad
X-Proofpoint-ORIG-GUID: 2BrsVHCAoIGqKxBLj5zGH2CuIJzrlqta
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-26_07,2025-03-26_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 priorityscore=1501 lowpriorityscore=0 phishscore=0 spamscore=0
 clxscore=1011 bulkscore=0 adultscore=0 suspectscore=0 malwarescore=0
 mlxlogscore=999 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2503260085



On 3/26/25 4:20 PM, John Paul Adrian Glaubitz wrote:
> Hello Madhavan,
> 
> does the removal of IBM Cell Blades affect the possibility to run Linux
> on the PlayStation 3 in any way? I assume there are still some hobbyists
> using it.

PS3 platform is still maintained. Only IBM Blade server platform 
is dropped.

> 
> There is at least one user within the Debian community using Linux on PS3.
> 

Glad to know we have users. :)

Maddy

> Thanks,
> Adrian
> 


