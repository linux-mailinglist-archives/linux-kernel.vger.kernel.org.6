Return-Path: <linux-kernel+bounces-514465-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37EEDA3575F
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 07:45:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BC9E3AE933
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 06:45:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 987AD18A6D5;
	Fri, 14 Feb 2025 06:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="nOzAgVgy"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 841A538DC8
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 06:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739515544; cv=none; b=j3UFbkNf9WjTsYf7mWRdKjZ/luSIcB9iZlh59ROW8IH0LC7y4d3gGK8VApvVCpHqnXlMcLcKKsu7vN+MJm2aAEHPc4lLpoSTw02Ch3kx/WAbktbS5gVWIIPDPgikBezaLZGitJohqVxFStiO/niCE+K3PyzsRkReOBGUyHS/frE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739515544; c=relaxed/simple;
	bh=jOmbKth323p3ll54Dd79pmXsuHR6esurCD30oTyo46U=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=oTPbe+qgU69j7r4ioPU9QXCvRIrCTRMN+vBVF5h4toIf4lh6g7g49RYMcmkk2IZWa58OI3Wb7SVCXi9Ym43OoQfVfRDnNazYr3Bc4LbJH+6zJ231Yl4fotHxcVof8Xx9aBVXNptAPmYVvWzLjp3Wg9DL9ujEYI/lNKB9SlvmfkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=nOzAgVgy; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51E5OUVt010341;
	Fri, 14 Feb 2025 06:45:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=suLyps
	BSmE6AszeJZb1uWjabD9IlIqQQNel8XNX6nn4=; b=nOzAgVgyaX+gzuT5QVtcD3
	J98N8pL4g9Cvc8NTC/w+/GPGjrok2HnaQPUo6xkmrZELV8o6Xtb5IOz4kNIsn/Qm
	rPyQy+JYbrBuyyOTfRY8SY3tWB1bupnp9LhSyFYNL6+iTzF95rnUJCChPxXNd60j
	0M6JTXqJaHkya2+r8nl+TtGavUNIIx3FcWtJT5CwOGvgxGnouqoo3tBsgIRGe0DC
	SH79efu0HdhLs93fjjCNwh6/W81FMMpSZd8TcSbmUV8Vd4lrCC7r8PiU+0YNfXWN
	XhIvRtvDrhAd7MzenG/lBCHVhqFmhLBLhy0oq5Kr4+ShTYRpSJ46b73PLRNvlfZQ
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44syn80964-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Feb 2025 06:45:37 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51E2U3n5000978;
	Fri, 14 Feb 2025 06:45:36 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 44pjknj9ce-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Feb 2025 06:45:36 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 51E6jYHk18415972
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 14 Feb 2025 06:45:34 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 98E1E20067;
	Fri, 14 Feb 2025 06:45:34 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 448872004F;
	Fri, 14 Feb 2025 06:45:33 +0000 (GMT)
Received: from [9.43.98.203] (unknown [9.43.98.203])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 14 Feb 2025 06:45:32 +0000 (GMT)
Message-ID: <da9b637a-962a-4a9f-a4bf-b79e6119b29c@linux.ibm.com>
Date: Fri, 14 Feb 2025 12:15:31 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [linux-next-20250212] syscall kexec_file_load not available
To: Hari Bathini <hbathini@linux.ibm.com>,
        Venkat Rao Bagalkote <venkat88@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <8e73069b-5987-4a08-b13d-13fe691092ad@linux.vnet.ibm.com>
 <77c11ea2-f3ae-497a-aaba-f7b33f46743d@linux.ibm.com>
Content-Language: en-US
From: Sourabh Jain <sourabhjain@linux.ibm.com>
In-Reply-To: <77c11ea2-f3ae-497a-aaba-f7b33f46743d@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: nuSfUP2hAdQ0LcOA-ozi6cFpn48kU42J
X-Proofpoint-GUID: nuSfUP2hAdQ0LcOA-ozi6cFpn48kU42J
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-14_02,2025-02-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 priorityscore=1501 lowpriorityscore=0 mlxscore=0 spamscore=0 bulkscore=0
 impostorscore=0 malwarescore=0 suspectscore=0 clxscore=1015
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2501170000 definitions=main-2502140047

Hello Hari,


On 14/02/25 12:02, Hari Bathini wrote:
>
>
> On 13/02/25 8:34 pm, Venkat Rao Bagalkote wrote:
>> Greetings!!!
>>
>>  From kernel next-20250210, I am observing syscall kexec_file_load 
>> not available, there by kdump service is failing to start.
>>
>>
>> Logs:
>>
>> [root@ltc-zzci-1 ~]# kexec -p --initrd=/boot/initramfs-6.14.0-rc2- 
>> next-20250212kdump.img /boot/vmlinuz-6.14.0-rc2-next-20250212 -c
>> Warning: append= option is not passed. Using the first kernel root 
>> partition
>> Modified cmdline: elfcorehdr=311424K root=UUID=b5b1f89c- 
>> d479-48b3-90e2-744a2fd05667
>> [root@ltc-zzci-1 ~]# kexec -p --initrd=/boot/initramfs-6.14.0-rc2- 
>> next-20250212kdump.img /boot/vmlinuz-6.14.0-rc2-next-20250212 -s
>> syscall kexec_file_load not available.
>> [root@ltc-zzci-1 ~]# kexec -v
>> kexec-tools 2.0.27
>> [root@ltc-zzci-1 ~]# uname -r
>> 6.14.0-rc2-next-20250212
>>
>
> Is the kernel built with CONFIG_KEXEC_FILE ?

I am able to reproduce it with CONFIG_KEXEC_FILE enabled.

Seems like there is something went wrong in next-20250210 and next-20250212.

kexec -p --initrd=/boot/initramfs-6.14.0-rc2-next-20250210kdump.img 
/boot/vmlinuz-6.14.0-rc2-next-20250210 -d -s

Try gzip decompression.
Try LZMA decompression.
[ 3375.712319] kexec_file: kernel: 00000000e539303c kernel_size: 0x2cdacf0
[ 3375.717022] ima: kexec measurement buffer for the loaded kernel at 0x0.
[ 3375.717076] kexec_elf: Loaded the kernel at 0x0
[ 3375.717094] kexec_elf: Loaded purgatory at 0x0
[ 3375.717104] Loaded the backup region at 0x0
[ 3375.717130] crash_core: Crash PT_LOAD ELF header. 
phdr=000000004720e656 vaddr=0xc000000000000000, paddr=0x0, sz=0x10000 
e_phnum=18 p_offset=0x0
[ 3375.717156] crash_core: Crash PT_LOAD ELF header. 
phdr=0000000005eb3f14 vaddr=0xc000000000010000, paddr=0x10000, 
sz=0xfff0000 e_phnum=19 p_offset=0x10000
[ 3375.717174] crash_core: Crash PT_LOAD ELF header. 
phdr=000000000ec70071 vaddr=0xc00000001ec20000, paddr=0x1ec20000, 
sz=0x13e0000 e_phnum=20 p_offset=0x1ec20000
[ 3375.717192] crash_core: Crash PT_LOAD ELF header. 
phdr=00000000b66c9c25 vaddr=0xc000000050000000, paddr=0x50000000, 
sz=0x3b0000000 e_phnum=21 p_offset=0x50000000
[ 3375.717215] Loaded elf core header at 0x0, bufsz=0x1000 memsz=0x80000
[ 3375.717229] kexec_elf: Loaded initrd at 0x0
[ 3375.718043] Memory node path: /memory@0
[ 3375.722854] kexec_elf: Loaded device tree at 0x0
syscall kexec_file_load not available.

Kernel is reporting that all kexec segments are getting loaded at 0x0.

Running kexec with strace shows that kexec_file_load system return -1 
EINVAL.

kexec_file_load(3, 4, 1, "\0", KEXEC_FILE_ON_CRASH) = -1 EINVAL (Invalid 
argument)

Based on the logs printed on the console and kexec_file_load return 
value. I am suspecting
kexec_file_load returned early form sanity_check_segment_list() because 
the segment is 0x0.

I am investigating further to find how segment.mem for all segment is 0x0.

Thanks,
Sourabh Jain




