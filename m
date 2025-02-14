Return-Path: <linux-kernel+bounces-514446-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 97A05A35720
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 07:32:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 043F218921A9
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 06:33:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E6C9200BA8;
	Fri, 14 Feb 2025 06:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="sramY19A"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E88571487DC
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 06:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739514773; cv=none; b=XL/y1c27OWpRYXOY6e+wmDm/yTChV+5/R7mv9IyyRq7ugZq3PRTmoD3mw9/np1lsQ78m9nMTKYbYYyGDrO3mXODoqcf1V7BhCOHfXRMKWUpSzceskgUCmtb7lvjui8EF/GkSXDElVhNvNqg9VaRgflvY9OK64Oj8VZ0ZGowPXLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739514773; c=relaxed/simple;
	bh=MOsG8NVKcVO9UMUYZXQ/FmjYYe0V2HYYkcRn4te3esY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=droNl3083SzbSwJkW2batmUNqXETYgjRgQUfb43H5T1Ax53YI8sXTDbhioAajRcOgwEmxtJswUMVsuAfWFZfp0wr/VKBZrPZWWNfUA8WuE4lGEfmVcC8c4kh2f4zlGpMYfa8X6s2ZL4iLcpFmuNBayeWMgKCS877EzN3sw6h1RU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=sramY19A; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51E217tZ013379;
	Fri, 14 Feb 2025 06:32:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=jN4FaQ
	FIv+GkbRwAOYMg9naHXIwVApjxx0TVLhKgmUM=; b=sramY19AimOPPPGrbVgwjY
	b0S+Ll/CUN8nrwKAdMEd28ssBqpswYTitlRJvm58REd1QFbVqjHvq12otrnW8M1M
	TFc6IzmpgNP8lyYT8n6BWR8kRmp7/MqhtHxcs8JH5bV5MhNPo2esPEj3pu5p0JNz
	H1LJlCvvBY0muFi789DfhEvLez2xPIJNLgtpzITrGQ9K/Ocx6KPAt25iqvqeNuZe
	xLZ7oEx+TZGfOVU35fhNGAfS58Xp9370Q4G+yyudvCYnM7FZarsF5A8KOxuG+FTb
	rA4HCffPMDX+cpVjmA7Q9FnvXMgvcFfxdBaqaoB2WXz+MlswaYjTf73uXJ3UL7hw
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44svp08xbh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Feb 2025 06:32:46 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51E2jV9X016692;
	Fri, 14 Feb 2025 06:32:45 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 44pk3kj6mf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Feb 2025 06:32:45 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 51E6WhvH41812402
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 14 Feb 2025 06:32:43 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CB0E72004D;
	Fri, 14 Feb 2025 06:32:43 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 77EFE20040;
	Fri, 14 Feb 2025 06:32:42 +0000 (GMT)
Received: from [9.43.1.221] (unknown [9.43.1.221])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 14 Feb 2025 06:32:42 +0000 (GMT)
Message-ID: <77c11ea2-f3ae-497a-aaba-f7b33f46743d@linux.ibm.com>
Date: Fri, 14 Feb 2025 12:02:41 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [linux-next-20250212] syscall kexec_file_load not available
To: Venkat Rao Bagalkote <venkat88@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc: Sourabh Jain <sourabhjain@linux.ibm.com>
References: <8e73069b-5987-4a08-b13d-13fe691092ad@linux.vnet.ibm.com>
Content-Language: en-US
From: Hari Bathini <hbathini@linux.ibm.com>
In-Reply-To: <8e73069b-5987-4a08-b13d-13fe691092ad@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 8-I0An12dgEe2IHZiXdS89BwQYzIzGcq
X-Proofpoint-GUID: 8-I0An12dgEe2IHZiXdS89BwQYzIzGcq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-14_02,2025-02-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 mlxscore=0 malwarescore=0 phishscore=0 spamscore=0
 adultscore=0 mlxlogscore=854 priorityscore=1501 lowpriorityscore=0
 bulkscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502140047



On 13/02/25 8:34 pm, Venkat Rao Bagalkote wrote:
> Greetings!!!
> 
>  From kernel next-20250210, I am observing syscall kexec_file_load not 
> available, there by kdump service is failing to start.
> 
> 
> Logs:
> 
> [root@ltc-zzci-1 ~]# kexec -p --initrd=/boot/initramfs-6.14.0-rc2- 
> next-20250212kdump.img /boot/vmlinuz-6.14.0-rc2-next-20250212 -c
> Warning: append= option is not passed. Using the first kernel root 
> partition
> Modified cmdline: elfcorehdr=311424K root=UUID=b5b1f89c- 
> d479-48b3-90e2-744a2fd05667
> [root@ltc-zzci-1 ~]# kexec -p --initrd=/boot/initramfs-6.14.0-rc2- 
> next-20250212kdump.img /boot/vmlinuz-6.14.0-rc2-next-20250212 -s
> syscall kexec_file_load not available.
> [root@ltc-zzci-1 ~]# kexec -v
> kexec-tools 2.0.27
> [root@ltc-zzci-1 ~]# uname -r
> 6.14.0-rc2-next-20250212
> 

Is the kernel built with CONFIG_KEXEC_FILE ?

- Hari


