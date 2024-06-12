Return-Path: <linux-kernel+bounces-211242-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 27737904EE9
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 11:15:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2864D1C213AD
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 09:15:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9140E16D4FF;
	Wed, 12 Jun 2024 09:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="A0/6rNU1"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D78D16C6BE
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 09:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718183722; cv=none; b=q3aK3E84DIS7IZGzXGAyOagxshB1tqr1xRo2P5gzQh+i8+wC0XALlK4+6NSRZ/60XXZQRZdbX1XvmfZwN7Z6sBngPg3S+j9AdEhLhJ2S6YV9lGY52Br7PjvH/+6et+0WlFZlZIdAFLytjhefvmZQmx0qk90MyT6yQdZ5+70wySs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718183722; c=relaxed/simple;
	bh=VpRg2jBtDxnDxNjNIMBIDuNbYxBpIvKSKffcw3b+yic=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JD0GGNVhJNEBGQgL3MSlLjLhxo5fz106yKKa2IbZ0aXV6WJzzCuNa00KhpUxQ9+Ry49G9kDUKhChxTVHukLKJkHeiyv2b0K79FED0RTcUdyG3hQA1Yzc6exjdViVQOgzSTQ+DvHLxaWhiwu0nc2MKifVbDiRYa1FNIz+tnIipxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=A0/6rNU1; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45C7xAKZ025604;
	Wed, 12 Jun 2024 09:15:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=pp1; bh=p
	6+D8/IduoJEGhHkLzHb2IUEldb5xn7XpbW/PKnzI48=; b=A0/6rNU1UlogA4olM
	Qnopt78RCuzlJpNrXkLAzb/EiFnsDnNDagqqSOjQSmRYjyABI7Ncrjny3ggnHusm
	U7uc6bYT8Q6gZtsAinr2v+5fZ4GVMjs67qBTA0284PsdTuhRmnllZeeeQpeM32qL
	oUG1cBHODh/Q6s8k7VvjUPUah+nJ2A9IDklePo0yTUJIYoeTBVdR/IMwtt7qtART
	2u/czL0e4Mz9cqU5BqQSG0gARAA9t2Ws6ctwKlBtAQhLV32DCPUpB0GfbhZC3jxm
	y0w7yjyTSdTprKOcoFE258ueuZ8xNNkhcxH3+LnMBff49HqB6VM7LTjurEeRSBp8
	Jpyag==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yq7rjg8nx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Jun 2024 09:15:10 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 45C81bMx020045;
	Wed, 12 Jun 2024 09:15:09 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3yn34n41mc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Jun 2024 09:15:09 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 45C9F6vi39780966
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Jun 2024 09:15:08 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 64CE458067;
	Wed, 12 Jun 2024 09:15:06 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 900F25803F;
	Wed, 12 Jun 2024 09:15:05 +0000 (GMT)
Received: from [9.152.212.241] (unknown [9.152.212.241])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 12 Jun 2024 09:15:05 +0000 (GMT)
Message-ID: <e858cafd-27cc-4ae0-af8a-0ed71dca1fa8@linux.ibm.com>
Date: Wed, 12 Jun 2024 11:14:22 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] gcov: add support for GCC 14
To: Andrew Morton <akpm@linux-foundation.org>,
        Chuck Lever <chuck.lever@oracle.com>
Cc: linux-kernel@vger.kernel.org, allison.henderson@oracle.com
References: <20240610092743.1609845-1-oberpar@linux.ibm.com>
 <ZmcCfzJfsKoVvDpA@tissot.1015granger.net>
 <20240610104542.25a7d777b011d74463df9148@linux-foundation.org>
Content-Language: en-US
From: Peter Oberparleiter <oberpar@linux.ibm.com>
In-Reply-To: <20240610104542.25a7d777b011d74463df9148@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: bF9ilSvL66PaYQjhkjyfuX36AQRAx7Sz
X-Proofpoint-ORIG-GUID: bF9ilSvL66PaYQjhkjyfuX36AQRAx7Sz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-12_04,2024-06-11_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 adultscore=0
 bulkscore=0 spamscore=0 priorityscore=1501 phishscore=0 malwarescore=0
 suspectscore=0 mlxlogscore=972 impostorscore=0 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406120063

On 10.06.2024 19:45, Andrew Morton wrote:
> On Mon, 10 Jun 2024 09:41:19 -0400 Chuck Lever <chuck.lever@oracle.com> wrote:
>> On Mon, Jun 10, 2024 at 11:27:43AM +0200, Peter Oberparleiter wrote:
>>> Using gcov on kernels compiled with GCC 14 results in truncated 16-byte
>>> long .gcda files with no usable data. To fix this, update GCOV_COUNTERS
>>> to match the value defined by GCC 14.
>>>
>>> Tested with GCC versions 14.1.0 and 13.2.0.
>>>
>>
>> ...
>>
>> Tested-by: Chuck Lever <chuck.lever@oracle.com>
> 
> I assume this problem will affect people who use gcc-14 to compile
> older kernels, so I have added cc:stable to this patch.

Yes, adding this fix also to stable kernels makes sense.


-- 
Peter Oberparleiter
Linux on IBM Z Development - IBM Germany R&D


