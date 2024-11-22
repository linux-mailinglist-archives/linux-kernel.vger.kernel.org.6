Return-Path: <linux-kernel+bounces-417817-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A04C9D5965
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 07:27:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4E25AB2309A
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 06:27:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8CE3166315;
	Fri, 22 Nov 2024 06:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="SraPdsFF"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8B3122081
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 06:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732256840; cv=none; b=smru3B2wV6B9muVY4w8L9QGTVJ5GN+iMpejii510lUs/H2xSw62ct6cc7FCiWZ+JUppFXJ1I9xyhJNjnS5o4ntyJ0juKm5E1z/5ICNvVS4v72NLggOIAWX0sqCsZUZB7ju+V78okAwMUuTTvr3zadITP2GWSQJNwUhppDFa1Oog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732256840; c=relaxed/simple;
	bh=2/napg/9Lm6hc7Dhe3BKuUXbGr76GuzjXtORiDV/kHM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ELyAiHEBirLYh6VjThdRank+i3wGGwiHzAooo4+5c/y5nfE2LgfABi0KOMWJcesLYNZAUWj3OaFAdwmnb2spTp05wkrrS+HCdhIn+GWoa5X0LZExNgldyeHo7MxLWbdiRieh4dvIGuzDNQAU5SB6hziAzZGc72zyEEDPxBj5sDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=SraPdsFF; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AM1qIFJ009218;
	Fri, 22 Nov 2024 06:26:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=ICH6dp
	Z/5QQQ5oqYxXjudOdcrNfs0CM/rAq5NgUVmZc=; b=SraPdsFFcrbvujHkXcysh1
	bvfyqpkD1v+R57MjP0wfYzhS3w5thjox5zoP/oeew6DMoqcAKXliCmYC1Co+zLY6
	1uj+NZC8B00QBdxf7jaY8+a8uiy9FyUgG9/0HfRu+m03y7bIqULmlPlx7KbjRkh/
	8VfwMjVAaN9TvvLVLdeV77qzeogZBzxpYhN9AFIEMPr4OES41QIqSiK3qb8W76lb
	BpEWgiC0Kz8SSbdKQlKwZzU6o3t+Bl0dY5qp05KaTSn0IVqhWpq56210XX5lVYji
	gtMSElO5XWyyf0CB6a5PxlhQm4ri/HP0cpsi1GNmdXbykkh27ZJoEfmnrnlsXt6g
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 432fw215gj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 Nov 2024 06:26:51 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4AM61CVc030957;
	Fri, 22 Nov 2024 06:26:50 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 42y640fnar-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 Nov 2024 06:26:50 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4AM6Qno526870502
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 22 Nov 2024 06:26:49 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C4BAB5805A;
	Fri, 22 Nov 2024 06:26:49 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7BFE458054;
	Fri, 22 Nov 2024 06:26:45 +0000 (GMT)
Received: from [9.109.198.240] (unknown [9.109.198.240])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 22 Nov 2024 06:26:45 +0000 (GMT)
Message-ID: <5bbfcfe6-6e7f-437c-9c0e-cb80578b0c87@linux.ibm.com>
Date: Fri, 22 Nov 2024 11:56:44 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] nvme: always enable multipath
To: Bryan Gurney <bgurney@redhat.com>, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, kbusch@kernel.org, hch@lst.de,
        sagi@grimberg.me, axboe@kernel.dk, mpe@ellerman.id.au,
        naveen@kernel.org, maddy@linux.ibm.com, kernel@xen0n.name
Cc: jmeneghi@redhat.com, bmarzins@redhat.com
References: <20241121220321.40616-1-bgurney@redhat.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20241121220321.40616-1-bgurney@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Xho9_0v6reVO3SRlkNyKenSYw3mKZcoB
X-Proofpoint-ORIG-GUID: Xho9_0v6reVO3SRlkNyKenSYw3mKZcoB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 malwarescore=0
 adultscore=0 bulkscore=0 phishscore=0 spamscore=0 mlxscore=0
 lowpriorityscore=0 impostorscore=0 priorityscore=1501 mlxlogscore=999
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411220048



On 11/22/24 03:33, Bryan Gurney wrote:
> Since device-mapper multipath will no longer be operating on NVMe
> devices, there is no longer a need to set CONFIG_NVME_MULTIPATH=n.
> 
> Always enable NVMe multipath, remove CONFIG_NVME_MULTIPATH, and use
> the code paths that would be used if CONFIG_NVME_MULTIPATH=y.
> 
> Reviewed-by: John Meneghini <jmeneghi@redhat.com>
> Tested-by: Bryan Gurney <bgurney@redhat.com>
> Signed-off-by: Bryan Gurney <bgurney@redhat.com>
> ---
>  arch/loongarch/configs/loongson3_defconfig |  1 -
>  arch/powerpc/configs/skiroot_defconfig     |  1 -
>  drivers/nvme/host/Kconfig                  |  9 --
>  drivers/nvme/host/Makefile                 |  3 +-
>  drivers/nvme/host/core.c                   | 17 +---
>  drivers/nvme/host/ioctl.c                  |  3 +-
>  drivers/nvme/host/multipath.c              | 10 +--
>  drivers/nvme/host/nvme.h                   | 97 +---------------------
>  drivers/nvme/host/sysfs.c                  |  6 --
>  9 files changed, 7 insertions(+), 140 deletions(-)

I applied the above changes to my kernel tree and ran the below blktests:

# ./check nvme/033 nvme/034 nvme/035 nvme/036 nvme/037 nvme/039 
nvme/033 => nvme0n1 (tr=loop) (create and connect to an NVMeOF target with a passthru controller) [not run]
    /dev/nvme0n1 is a NVMe multipath device
nvme/034 => nvme0n1 (tr=loop) (run data verification fio job on an NVMeOF passthru controller) [not run]
    /dev/nvme0n1 is a NVMe multipath device
nvme/035 => nvme0n1 (tr=loop) (run mkfs and data verification fio job on an NVMeOF passthru controller) [not run]
    /dev/nvme0n1 is a NVMe multipath device
nvme/036 => nvme0n1 (tr=loop) (test NVMe reset command on an NVMeOF target with a passthru controller) [not run]
    /dev/nvme0n1 is a NVMe multipath device
nvme/037 => nvme0n1 (tr=loop) (test deletion of NVMeOF passthru controllers immediately after setup) [not run]
    /dev/nvme0n1 is a NVMe multipath device
nvme/039 => nvme0n1 (test error logging)                     [not run]
    /dev/nvme0n1 is a NVMe multipath device

As we can see here, the above tests were skipped because the test detects 
that the device (/dev/nvme0n1) is a multipath device. However, in fact, 
the test device is NOT a multipath. So I think we need to update the above 
tests. We may submit another patch to blktest and update above tests once 
your changes are merged upstream.

Otherwise, changes look good to me:
Reviewed-by: Nilay Shroff <nilay@linux.ibm.com> 

