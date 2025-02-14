Return-Path: <linux-kernel+bounces-514311-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 43576A35568
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 04:44:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 041BD16DA86
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 03:44:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8D311519BC;
	Fri, 14 Feb 2025 03:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="XBY/bmj+"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1E2F4A08
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 03:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739504671; cv=none; b=MIrcURV6zodJ+NECJy3dhGRqJ03Za5WWIooegYIzHuVOBiR3zIDTHZsm1Q4pE795taBvG/qv7buVelCMdHENRkjdKLUgunsuTpCUrIs2gRdK1iOYyndMnT11qRJFErkX1bLsN+Z1anDGdwZWnkVXA0B+Xn/7wZ+zA9fCE3tMKnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739504671; c=relaxed/simple;
	bh=pxuSNvdelWv1Vx3AHDtLoWPomWguWARJhl1CdCtZ39A=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=O3Wn/eAxa6T331ffqt8SiexaLpQwqPjS0IOE9pdH6FMSWQtYPryDaWLx3mVo2HW5ifzZ2RYAvlD3utftn0+gGZvAPSH6Vi8+loBAUrqfCp8vHdln7cJBQ5xOuwajtjTnKX77nw/tXxJbVO+tigZ98Kyv7C+teqn/jYOhVJ5ByWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=XBY/bmj+; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51E219TM016465;
	Fri, 14 Feb 2025 03:44:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=9MQAbG
	XpXA68E2ZJDNg599icK9mYCuj8iCWgPBB4/lU=; b=XBY/bmj+9Q2+lbMovhuXg5
	x4C+XB32kIvK6ZlGs/QaeECwPwVjg3qL14Gohl6abvrYSKKCj2xAne21XDv7TYwU
	P0oVYKo01XB1xu6v2moYeh91TALS47ZqiUbCQPfwhW6JDtdtRUWnefgZ7oc8qdb7
	OVKawYuU1aVYIWrVmjwe1FRE/SXpbQE5CnZCi+H7Si/o3fi3dhyddJwkgsZ66rdw
	GyxAs4JSmsKnjvGvNg+Q3nrYNfG4dGPtjho0uLZnlNBUfTdL7fdUkwMoSeY8qI6s
	+QvOKGCT8hzZT1FiQU3iRYhLsp5dRW5bOkW5uFCR6RkjThmF1A9/zeY8/w0u+qqA
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44skjuu23n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Feb 2025 03:44:23 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51E32LQj001051;
	Fri, 14 Feb 2025 03:44:23 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 44pjknhphk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Feb 2025 03:44:23 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 51E3iL7c38469952
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 14 Feb 2025 03:44:21 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 335AA20043;
	Fri, 14 Feb 2025 03:44:21 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1A4F020040;
	Fri, 14 Feb 2025 03:44:20 +0000 (GMT)
Received: from [9.43.98.203] (unknown [9.43.98.203])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 14 Feb 2025 03:44:19 +0000 (GMT)
Message-ID: <bdc8c274-960e-4f66-9790-736e9bd0eb76@linux.ibm.com>
Date: Fri, 14 Feb 2025 09:14:19 +0530
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
References: <8e73069b-5987-4a08-b13d-13fe691092ad@linux.vnet.ibm.com>
Content-Language: en-US
From: Sourabh Jain <sourabhjain@linux.ibm.com>
In-Reply-To: <8e73069b-5987-4a08-b13d-13fe691092ad@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: PYIGCqekOGocHD3qbqDxany28q78N8Kh
X-Proofpoint-ORIG-GUID: PYIGCqekOGocHD3qbqDxany28q78N8Kh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-14_01,2025-02-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 phishscore=0
 mlxlogscore=999 lowpriorityscore=0 mlxscore=0 spamscore=0 suspectscore=0
 priorityscore=1501 bulkscore=0 malwarescore=0 adultscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2501170000
 definitions=main-2502140024

Hello Venkat,


On 13/02/25 20:34, Venkat Rao Bagalkote wrote:
> Greetings!!!
>
> From kernel next-20250210, I am observing syscall kexec_file_load not 
> available, there by kdump service is failing to start.
>

powerpc do have support for kexec_file_load system. Seems like there is 
an issue.

Thanks for reporting the issue.

I will debug and find what went wrong with next-20250210 or the kexec 
you used to load the kdump kernel.

Thanks,
Sourabh Jain

>
> Logs:
>
> [root@ltc-zzci-1 ~]# kexec -p 
> --initrd=/boot/initramfs-6.14.0-rc2-next-20250212kdump.img 
> /boot/vmlinuz-6.14.0-rc2-next-20250212 -c
> Warning: append= option is not passed. Using the first kernel root 
> partition
> Modified cmdline: elfcorehdr=311424K 
> root=UUID=b5b1f89c-d479-48b3-90e2-744a2fd05667
> [root@ltc-zzci-1 ~]# kexec -p 
> --initrd=/boot/initramfs-6.14.0-rc2-next-20250212kdump.img 
> /boot/vmlinuz-6.14.0-rc2-next-20250212 -s
> syscall kexec_file_load not available.
> [root@ltc-zzci-1 ~]# kexec -v
> kexec-tools 2.0.27
> [root@ltc-zzci-1 ~]# uname -r
> 6.14.0-rc2-next-20250212
>
>
> Regards,
>
> Venkat.
>


