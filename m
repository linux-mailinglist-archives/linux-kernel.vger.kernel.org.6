Return-Path: <linux-kernel+bounces-270849-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A764944635
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 10:07:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F3931C2243B
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 08:07:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 178A3166313;
	Thu,  1 Aug 2024 08:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="eQHR7tPx"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 649B8157488
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 08:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722499631; cv=none; b=mXM2WLRPwuhcPD6ZiTpvSvOJZw37/IVHStBbF+PHvmHrmVakfL8fHMrIfULUEpNcnInHzcH7qFo3ejF0+agMq4ITMuvvKR4/TvdjtWpV2UA3AzuT5RtLILcgpKOxAQ1leOQ5ywB0nGaAiPYe27JnQMXJAAal54fMnfx3j3kBvkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722499631; c=relaxed/simple;
	bh=dxRHTEyglWDrXfJF94f67/auBHmkZ/1a94arDukSgTs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YKk8fFsvdhmwWt8H8gwV/0SWmaOtMg28fBrms/kvSCoKE6TeWruebCZq26OZKsdFzZ4NyaJ7AwvQ0WIE8bJsBDtEsp31lTIONFeN6jPOGpnV29Qr89+OFnsYdT1osFNTnN9OuUln5jVqgFNXgqt1bXX/Op+BVE6QuAHGxvPZH+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=eQHR7tPx; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4716TZk5025652;
	Thu, 1 Aug 2024 08:06:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=pp1; bh=z
	EJ35kZA6S/kXGZD/9MxIB1NcUqP6U4ESYSerPwyfa8=; b=eQHR7tPxPlEQPCGue
	pFavgZHzwVk+OcKBpTMeB0eoO7sQpIwFz04kVwAqFZRtrSbEpdYMmhyNrdxvAbMu
	kge5VxgXc/shTm76iOAgRNCY6hJe/1cJSgXXv2fuZbjrkv5/wZj0VZ1qiYrXbita
	ZLvrbYAWA+VT9w/tjN9iqGFf0TUzVccacyadWbUuIVMN7O9mkAjrdpw9CMOWtPTK
	pu3kfQkZHsFgtnnyj7dTsswLkMC4FXS220tNml3kY9bcQwY3BAqxmXrtzTU8XY57
	KhSzlh+S+EVmg+hPrWh/uJPS35VO/1wG26ieTCz9jb5xO0t1T8N4YU6aMpgFEjsk
	8rwsg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40r54u06ne-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 01 Aug 2024 08:06:55 +0000 (GMT)
Received: from m0353724.ppops.net (m0353724.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 47186sN9030950;
	Thu, 1 Aug 2024 08:06:54 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40r54u06nc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 01 Aug 2024 08:06:54 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 47183b9n018969;
	Thu, 1 Aug 2024 08:06:54 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 40nc7q0m6j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 01 Aug 2024 08:06:53 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 47186oka57344276
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 1 Aug 2024 08:06:52 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 06F2120040;
	Thu,  1 Aug 2024 08:06:50 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6D22F20043;
	Thu,  1 Aug 2024 08:06:47 +0000 (GMT)
Received: from [9.43.79.112] (unknown [9.43.79.112])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  1 Aug 2024 08:06:47 +0000 (GMT)
Message-ID: <b7a52f5b-df93-476b-a9b1-931fad1474e0@linux.ibm.com>
Date: Thu, 1 Aug 2024 13:36:46 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] kexec/crash: no crash update when kexec in progress
To: Baoquan He <bhe@redhat.com>
Cc: Hari Bathini <hbathini@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Sachin P Bappalige <sachinpb@linux.vnet.ibm.com>,
        linuxppc-dev@lists.ozlabs.org
References: <20240731152738.194893-1-sourabhjain@linux.ibm.com>
 <Zqs8veRya7v/pXEt@MiWiFi-R3L-srv>
Content-Language: en-US
From: Sourabh Jain <sourabhjain@linux.ibm.com>
In-Reply-To: <Zqs8veRya7v/pXEt@MiWiFi-R3L-srv>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: EmUxLjMbJNMxGW1YDEzR98PdsVJe6uf0
X-Proofpoint-ORIG-GUID: qj94FuyCbc8v7B-LkClrnY6NYyMkaLDR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-01_04,2024-07-31_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 adultscore=0 clxscore=1015 suspectscore=0 bulkscore=0
 mlxlogscore=864 phishscore=0 impostorscore=0 lowpriorityscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408010042

Hello Baoquan,

On 01/08/24 13:13, Baoquan He wrote:
> On 07/31/24 at 08:57pm, Sourabh Jain wrote:
>> The following errors are observed when kexec is done with SMT=off on
>> powerpc.
>>
>> [  358.458385] Removing IBM Power 842 compression device
>> [  374.795734] kexec_core: Starting new kernel
>> [  374.795748] kexec: Waking offline cpu 1.
>> [  374.875695] crash hp: kexec_trylock() failed, elfcorehdr may be inaccurate
>> [  374.935833] kexec: Waking offline cpu 2.
>> [  375.015664] crash hp: kexec_trylock() failed, elfcorehdr may be inaccurate
>> snip..
>> [  375.515823] kexec: Waking offline cpu 6.
>> [  375.635667] crash hp: kexec_trylock() failed, elfcorehdr may be inaccurate
>> [  375.695836] kexec: Waking offline cpu 7.
>>
>> During kexec, the offline CPUs are brought online, which triggers the
> Is this a generic action or specific on ppc about the offline CPUs being
> brought line during kexec?

I think it is powerpc specific.
Patch that introduced this on powerpc: e8e5c2155b003 ("powerpc/kexec: 
Fix orphaned offline CPUs across kexec")

- Sourabh Jain


