Return-Path: <linux-kernel+bounces-291438-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4D88956288
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 06:18:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02C161C210C8
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 04:18:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 812BE13B5A6;
	Mon, 19 Aug 2024 04:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="OxaHkZKC"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60F4813D283
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 04:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724040976; cv=none; b=JNW3T9PE42+cTeLg4k8OtTUJjSZyAqwqktzGT4ixb5g3ZLmbvzQZIntB/qxldZd0W25fVscG5kXwgcksPJM21M3vhYS3mxehZzxsAQfB399k7Kzza/nN0Ra4ZCqntFNpAAni5T26k7vaO6g9SGASV4lOIcNSPKv6DlbFzBMn+rU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724040976; c=relaxed/simple;
	bh=Hs76a2+BAqGkYgACURNBH0irOWcyhvutjEG2elcrxcM=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=apXBAPavuGSK7b8eDpdwGVNIDRV0aWZMEI7/EnWdHnXS6J+I5WqG820IoWVKZV52GrhOCsHJP6SpaRoPVJ9p6XrOSRw/y7sCOssqZH5gBxrC2VXFFhv3g6ZlWI61oepFLZSBbF4L8L50d/kUm6zSB9QYTXdUkx0JqWyh35WmIWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=OxaHkZKC; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47J3X8T1023559;
	Mon, 19 Aug 2024 04:16:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:date:mime-version:subject:from:to:cc:references
	:in-reply-to:content-type:content-transfer-encoding; s=pp1; bh=o
	2sTkt1iXiirRrY/2diJQwQvSmFwGnGarq5JCuO5sjM=; b=OxaHkZKCoiBJB6Phj
	FeTpU8GyzpzaFFgqj9RRmJuxbZjoP6q7caWDCHTTTB/szh35G8sIwRrP2GlcQtM0
	q2hVn1GIIsFLGxp37KH75bsSwmH0fQHnntbhFdU+kAmIrRwerRIEsdKJis8jscjO
	BAu0rxXaPz3qNM2Dh6Ud5vGmdCGG2NETbpEeBnYDvMz1dvmFvUtWr4OAJCEwesjQ
	76TJpyZ+x33FYKjn+FuC+VswvY/A4TOgD82MmsX/QoBGAvw30cjUfSLD3gg1ZaLK
	FbotKWKHTRU5K5TUc7Comvg6uf4k9obojC02woCzAXziibjaeS1tPXmjHZfJsEjv
	r5jxg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 412mc5xvda-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 19 Aug 2024 04:16:03 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 47J4G2wh022758;
	Mon, 19 Aug 2024 04:16:02 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 412mc5xvd8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 19 Aug 2024 04:16:02 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 47J2pneU013107;
	Mon, 19 Aug 2024 04:16:01 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 41366tvq0r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 19 Aug 2024 04:16:01 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 47J4FwAC27984422
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 19 Aug 2024 04:16:00 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 030F120043;
	Mon, 19 Aug 2024 04:15:58 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2906420040;
	Mon, 19 Aug 2024 04:15:56 +0000 (GMT)
Received: from [9.109.204.94] (unknown [9.109.204.94])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 19 Aug 2024 04:15:55 +0000 (GMT)
Message-ID: <355b58b1-6c51-4c42-b6ea-dcd6b1617a18@linux.ibm.com>
Date: Mon, 19 Aug 2024 09:45:55 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] kexec/crash: no crash update when kexec in progress
From: Sourabh Jain <sourabhjain@linux.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>, bhe@redhat.com
Cc: Hari Bathini <hbathini@linux.ibm.com>, kexec@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        x86@kernel.org, Sachin P Bappalige <sachinpb@linux.vnet.ibm.com>
References: <20240731152738.194893-1-sourabhjain@linux.ibm.com>
 <87v80lnf8d.fsf@mail.lhotse>
 <10c666ae-d528-4f49-82e9-8e0fee7099e0@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <10c666ae-d528-4f49-82e9-8e0fee7099e0@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: dkC9HdUkU1ndMyUpgCEV6AyZ0aEUDBK7
X-Proofpoint-ORIG-GUID: 9BpC5g6i3iCIjSgQoI-_tfZlERenEVta
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-19_01,2024-08-16_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 adultscore=0 mlxlogscore=999 clxscore=1015 bulkscore=0 spamscore=0
 lowpriorityscore=0 priorityscore=1501 mlxscore=0 phishscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408190029

Hello Michael and Boaquan

On 01/08/24 12:21, Sourabh Jain wrote:
> Hello Michael,
>
> On 01/08/24 08:04, Michael Ellerman wrote:
>> Sourabh Jain <sourabhjain@linux.ibm.com> writes:
>>> The following errors are observed when kexec is done with SMT=off on
>>> powerpc.
>>>
>>> [  358.458385] Removing IBM Power 842 compression device
>>> [  374.795734] kexec_core: Starting new kernel
>>> [  374.795748] kexec: Waking offline cpu 1.
>>> [  374.875695] crash hp: kexec_trylock() failed, elfcorehdr may be 
>>> inaccurate
>>> [  374.935833] kexec: Waking offline cpu 2.
>>> [  375.015664] crash hp: kexec_trylock() failed, elfcorehdr may be 
>>> inaccurate
>>> snip..
>>> [  375.515823] kexec: Waking offline cpu 6.
>>> [  375.635667] crash hp: kexec_trylock() failed, elfcorehdr may be 
>>> inaccurate
>>> [  375.695836] kexec: Waking offline cpu 7.
>> Are they actually errors though? Do they block the actual kexec from
>> happening? Or are they just warnings in dmesg?
>
> The kexec kernel boots fine.
>
> This warning appears regardless of whether the kdump kernel is loaded.
>
> However, when the kdump kernel is loaded, we will not be able to 
> update the kdump image (FDT).
> I think this should be fine given that kexec is in progress.
>
> Please let me know your opinion.
>
>> Because the fix looks like it could be racy.
>
> It seems like it is racy, but given that kexec takes the lock first 
> and then
> brings the CPU up, which triggers the kdump image, which always fails to
> update the kdump image because it could not take the same lock.
>
> Note: the kexec lock is not released unless kexec boot fails.

Any comments or suggestions on this fix?

Thanks,
Sourabh Jain


