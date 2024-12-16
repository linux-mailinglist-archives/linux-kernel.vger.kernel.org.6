Return-Path: <linux-kernel+bounces-446731-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 50E689F2889
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 03:43:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73D5A164BAA
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 02:43:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE2EF14D2A0;
	Mon, 16 Dec 2024 02:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="IOPb3Evw"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A247225632
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 02:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734316988; cv=none; b=lUs7XR1Ys0oW43qO77qeva3CQbBgHGPYjoSb5eIrMs/yLxBSZeHGqq5dRMAKeamYwUeOkl+ueMjeo8dP8aHngyjxkD6xzTle/Q0DvMgsvVQSZB5CthLTd4duhcsgb9tyHmntuEbtlt51qrG8C89ZlNp9wSrnCzk7O6JEwZbMTZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734316988; c=relaxed/simple;
	bh=XhZcPRfTKviIs58Im1/JawugrEqmE7Pc1eJat+x3zxI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P72DopZK1Y/OzDmH8nc50iCXQXtn214ZsIpliuAa3EvW8ckoK7SrGG2BVVnAeJkd9za3Z+jYN+AQjMqY8EkSak6UdyoSSKtALGjpWaXctVFnmR5vdP2Din3ClO8VxOLerE32HCESWOZo0TjBSd5iT7wCzwURH1R67/GxD4j40co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=IOPb3Evw; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BFLkmFc007226;
	Mon, 16 Dec 2024 02:42:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=DJWD5I
	HTprnQJpizlbbYq4Y/m24+PEuLlbPIF09EXVM=; b=IOPb3EvwmZ4Dg6Yzfh75ho
	Tzav8GSJ5iGcc6e/ixi8SD7vroTtOlxem4v861Bfh/eo4WqbQlPODS1XOCgJvkwT
	/DiypU8K/WaXzaPTCDM5SpIJDIYI3esYIKrZs6pt50+5AZnmRYuilTnG7G5tfQ9F
	P3Nki1YqPknyKJGVI9QCY2Wo+zcUlmmx1zswXBwyCmrvu9VpOxQZ5JVJcA66S72J
	GsLT/0PzI6bMONHpzXkEokiccErYsTGR8vXIB79iAzwWqdlsB/8Rol5HukUqobpR
	59LbakUVigy/y5Hb8Fc2AAZrF1ZzV893d3Snjh3GTL4vECJTndNFmRaYjuGBsYLw
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43j0k49p8d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Dec 2024 02:42:39 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4BG2gdsX025538;
	Mon, 16 Dec 2024 02:42:39 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43j0k49p8c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Dec 2024 02:42:39 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4BFNg83j005694;
	Mon, 16 Dec 2024 02:42:38 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 43hnbmv1et-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Dec 2024 02:42:38 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4BG2gcFN45810240
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Dec 2024 02:42:38 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 387CF58056;
	Mon, 16 Dec 2024 02:42:38 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1F93E58052;
	Mon, 16 Dec 2024 02:42:34 +0000 (GMT)
Received: from [9.43.66.47] (unknown [9.43.66.47])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 16 Dec 2024 02:42:33 +0000 (GMT)
Message-ID: <629f23f0-5b2a-4d6f-a047-41bf2fc9daf4@linux.ibm.com>
Date: Mon, 16 Dec 2024 08:12:29 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] powerpc/8xx: Drop legacy-of-mm-gpiochip.h header
To: Christophe Leroy <christophe.leroy@csgroup.eu>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Nicholas Piggin <npiggin@gmail.com>, Naveen N Rao <naveen@kernel.org>
References: <20241118123254.620519-1-andriy.shevchenko@linux.intel.com>
 <514964ea-0795-41d6-91d3-f3d4f193fc6d@csgroup.eu>
 <Z1sOTf6UZbruptnl@smile.fi.intel.com>
 <991aee8b-fb10-4152-89fb-6ac542ee87c1@csgroup.eu>
Content-Language: en-US
From: Madhavan Srinivasan <maddy@linux.ibm.com>
In-Reply-To: <991aee8b-fb10-4152-89fb-6ac542ee87c1@csgroup.eu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: yoBKrrLQGOVttaVwZ1mnMNXBnWCRwgZu
X-Proofpoint-ORIG-GUID: r-YDKyCtZxYSWOhqNWg273Mubikm9I24
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 malwarescore=0 bulkscore=0 mlxlogscore=768
 clxscore=1011 suspectscore=0 adultscore=0 phishscore=0 mlxscore=0
 spamscore=0 priorityscore=1501 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2411120000 definitions=main-2412160019



On 12/13/24 11:58 AM, Christophe Leroy wrote:
> 
> 
> Le 12/12/2024 à 17:24, Andy Shevchenko a écrit :
>> On Mon, Nov 18, 2024 at 03:10:09PM +0100, Christophe Leroy wrote:
>>> Le 18/11/2024 à 13:31, Andy Shevchenko a écrit :
>>>> Remove legacy-of-mm-gpiochip.h header file. The above mentioned
>>>> file provides an OF API that's deprecated. There is no agnostic
>>>> alternatives to it and we have to open code the logic which was
>>>> hidden behind of_mm_gpiochip_add_data(). Note, most of the GPIO
>>>> drivers are using their own labeling schemas and resource retrieval
>>>> that only a few may gain of the code deduplication, so whenever
>>>> alternative is appear we can move drivers again to use that one.
>>>>
>>>> As a side effect this change fixes a potential memory leak on
>>>> an error path, if of_mm_gpiochip_add_data() fails.
>>>>
>>>> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>>>
>>> Reviewed-by: Christophe Leroy <christophe.leroy@csgroup.eu>
>>
>> Thanks, what's next?
>>

Yes, will take this via powerpc tree

Maddy

> 
> Next step is that Michael or Madhavan apply it I guess ?
> 
> Christophe




