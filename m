Return-Path: <linux-kernel+bounces-515137-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68388A360B4
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 15:43:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8CF616B7BF
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 14:43:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2923B266587;
	Fri, 14 Feb 2025 14:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="TZmohm9r"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3D922661B9
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 14:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739544232; cv=none; b=MfaSonzZBLhmF/Dt7JH2wfstBFUZWwdo6KERRJVgz2PHn0o3PIcJPt9tWi9CL/fNSiSWTXQEyQdKHMieICUN8W95JUqLiLa1JtV/9zxJgnKZlbF9jQpGJoL3G9kZFc5TlGWkBWaZvIheZcdyLD7XlftIlqaCTuSLXY9yyB8KsAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739544232; c=relaxed/simple;
	bh=P/26S0LL4YCXMrmikxoNZZ9A4qLtjZ+7jToagoCQzUk=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=IouEZvtPiM7GM6g0SE1EvvNhStR7jBsx6jK5YLg5Bq94Z/HoQpTQK6caEv/b0rEocuwV1DWYZowzoVQXieqBWDlvzfFRMcwbmKDB4QkGNTcXQ72HbRtprc/BE0/ozOmmqwgqsSA2U3Xe71o8xvwG3JUWblrkXLcC9HTDKc4xMP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=TZmohm9r; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51E5O7HJ009421;
	Fri, 14 Feb 2025 14:43:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=2R46RF
	Bw2bl1J+ukk0Qah8+d4Igj6TzF9mpxXuFPr4o=; b=TZmohm9rLGsFB4KDMP/fIh
	bPAqSpxVTQeDL82kq1R7NxE9GEwxJEpAR+OwHuo7fw7wOGJE2k/gZBEmhE8HCnH7
	CHqnOVrgi1FfMM1uqakqd3rLtO5G+U69fRil3QjeAyKkgUgYVzDyBgCl8fWNYKxT
	chV9IAmj2u7ZKaczFkZrsPwj4T01O+DJUADdST4lxGHL89K2S3yiqnk66b2tamCI
	pl3SthzM2nGzcr1C17Dqk8AE75qb/8dUx3CSa8PfVFbg4682hMWbqHrkjWdgayo/
	93pKunVf4up9aFSSyFy+LMBiPnJLcZrhvkVyVzfheZzar3r454uF66mejxZLTwfw
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44syn82fjk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Feb 2025 14:43:45 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51ED1Os7011642;
	Fri, 14 Feb 2025 14:43:45 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 44pktkbs4j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Feb 2025 14:43:45 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 51EEhhEF54198764
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 14 Feb 2025 14:43:43 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 66FB42004D;
	Fri, 14 Feb 2025 14:43:43 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 38B2820040;
	Fri, 14 Feb 2025 14:43:42 +0000 (GMT)
Received: from [9.43.78.252] (unknown [9.43.78.252])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 14 Feb 2025 14:43:41 +0000 (GMT)
Message-ID: <afb134c7-edc1-4671-b4f8-7b8e1c8ac8f5@linux.ibm.com>
Date: Fri, 14 Feb 2025 20:13:41 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [linux-next-20250212] syscall kexec_file_load not available
From: Sourabh Jain <sourabhjain@linux.ibm.com>
To: Hari Bathini <hbathini@linux.ibm.com>,
        Venkat Rao Bagalkote <venkat88@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <8e73069b-5987-4a08-b13d-13fe691092ad@linux.vnet.ibm.com>
 <77c11ea2-f3ae-497a-aaba-f7b33f46743d@linux.ibm.com>
 <da9b637a-962a-4a9f-a4bf-b79e6119b29c@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <da9b637a-962a-4a9f-a4bf-b79e6119b29c@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: I43TyxtIu7bvLAqvw8OLVBPySEakWY6m
X-Proofpoint-GUID: I43TyxtIu7bvLAqvw8OLVBPySEakWY6m
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-14_06,2025-02-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 priorityscore=1501 lowpriorityscore=0 mlxscore=0 spamscore=0 bulkscore=0
 impostorscore=0 malwarescore=0 suspectscore=0 clxscore=1015
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2501170000 definitions=main-2502140105

Hello,


On 14/02/25 12:15, Sourabh Jain wrote:
> Hello Hari,
>
>
> On 14/02/25 12:02, Hari Bathini wrote:
>>
>>
>> On 13/02/25 8:34 pm, Venkat Rao Bagalkote wrote:
>>> Greetings!!!
>>>
>>>  From kernel next-20250210, I am observing syscall kexec_file_load 
>>> not available, there by kdump service is failing to start.
>>>
>>>
>>> Logs:
>>>
>>> [root@ltc-zzci-1 ~]# kexec -p --initrd=/boot/initramfs-6.14.0-rc2- 
>>> next-20250212kdump.img /boot/vmlinuz-6.14.0-rc2-next-20250212 -c
>>> Warning: append= option is not passed. Using the first kernel root 
>>> partition
>>> Modified cmdline: elfcorehdr=311424K root=UUID=b5b1f89c- 
>>> d479-48b3-90e2-744a2fd05667
>>> [root@ltc-zzci-1 ~]# kexec -p --initrd=/boot/initramfs-6.14.0-rc2- 
>>> next-20250212kdump.img /boot/vmlinuz-6.14.0-rc2-next-20250212 -s
>>> syscall kexec_file_load not available.
>>> [root@ltc-zzci-1 ~]# kexec -v
>>> kexec-tools 2.0.27
>>> [root@ltc-zzci-1 ~]# uname -r
>>> 6.14.0-rc2-next-20250212
>>>
>>
>> Is the kernel built with CONFIG_KEXEC_FILE ?
>
> I am able to reproduce it with CONFIG_KEXEC_FILE enabled.
>
> Seems like there is something went wrong in next-20250210 and 
> next-20250212.
>
> kexec -p --initrd=/boot/initramfs-6.14.0-rc2-next-20250210kdump.img 
> /boot/vmlinuz-6.14.0-rc2-next-20250210 -d -s
>
> Try gzip decompression.
> Try LZMA decompression.
> [ 3375.712319] kexec_file: kernel: 00000000e539303c kernel_size: 
> 0x2cdacf0
> [ 3375.717022] ima: kexec measurement buffer for the loaded kernel at 
> 0x0.
> [ 3375.717076] kexec_elf: Loaded the kernel at 0x0
> [ 3375.717094] kexec_elf: Loaded purgatory at 0x0
> [ 3375.717104] Loaded the backup region at 0x0
> [ 3375.717130] crash_core: Crash PT_LOAD ELF header. 
> phdr=000000004720e656 vaddr=0xc000000000000000, paddr=0x0, sz=0x10000 
> e_phnum=18 p_offset=0x0
> [ 3375.717156] crash_core: Crash PT_LOAD ELF header. 
> phdr=0000000005eb3f14 vaddr=0xc000000000010000, paddr=0x10000, 
> sz=0xfff0000 e_phnum=19 p_offset=0x10000
> [ 3375.717174] crash_core: Crash PT_LOAD ELF header. 
> phdr=000000000ec70071 vaddr=0xc00000001ec20000, paddr=0x1ec20000, 
> sz=0x13e0000 e_phnum=20 p_offset=0x1ec20000
> [ 3375.717192] crash_core: Crash PT_LOAD ELF header. 
> phdr=00000000b66c9c25 vaddr=0xc000000050000000, paddr=0x50000000, 
> sz=0x3b0000000 e_phnum=21 p_offset=0x50000000
> [ 3375.717215] Loaded elf core header at 0x0, bufsz=0x1000 memsz=0x80000
> [ 3375.717229] kexec_elf: Loaded initrd at 0x0
> [ 3375.718043] Memory node path: /memory@0
> [ 3375.722854] kexec_elf: Loaded device tree at 0x0
> syscall kexec_file_load not available.
>
> Kernel is reporting that all kexec segments are getting loaded at 0x0.
>
> Running kexec with strace shows that kexec_file_load system return -1 
> EINVAL.
>
> kexec_file_load(3, 4, 1, "\0", KEXEC_FILE_ON_CRASH) = -1 EINVAL 
> (Invalid argument)
>
> Based on the logs printed on the console and kexec_file_load return 
> value. I am suspecting
> kexec_file_load returned early form sanity_check_segment_list() 
> because the segment is 0x0.
>
> I am investigating further to find how segment.mem for all segment is 
> 0x0.


Posted a fix upstream:
https://lore.kernel.org/all/20250214125402.90709-1-sourabhjain@linux.ibm.com/


Thanks,
Soiurabh Jain



