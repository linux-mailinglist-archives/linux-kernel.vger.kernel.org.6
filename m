Return-Path: <linux-kernel+bounces-514459-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 52BD5A35749
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 07:40:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04C9018920D2
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 06:40:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26FC01FFC72;
	Fri, 14 Feb 2025 06:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="LTd6egzz"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2195B17E
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 06:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739515233; cv=none; b=mWP8KixqurNEDuyBJ9MRzd1kkV1JgLc6xbOC/ECEpPjpiT5S5DACkRhvp+r/gLndI2P4h3nh0odyDCFAoaAphPZY6j+p335e4UWOy0m++I25mUWo068aek3lbscxzZmuG8jQuIIqdtoLDl6JdN8oeE3UIGkfD0rcFO10I3iaeEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739515233; c=relaxed/simple;
	bh=5PPWOptl/YwW2wgNO8zYM57QPa9w1lWgGNZot+EV99s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gdtTIyqVvy5iu9+VJ5gto0t0wuyqGt15+iythyOtWK2moleP37BlAiAUyYKiHAgLpo/S8lPfR3+GanZ0LkJ/zIwTKoB8L/u4yBxJdHhFLBMFMrNbbOWs0LCxkQw74+CmEbVTfZXMug/OpkE/qpOIHlIynikW2yfQSHHkOkyE4ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.vnet.ibm.com; spf=none smtp.mailfrom=linux.vnet.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=LTd6egzz; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.vnet.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51DMnbkQ000644;
	Fri, 14 Feb 2025 06:40:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=MuwEtK
	LF7ofB4unmQfXvMcEmuv+K68chaMVfpQh/Qbk=; b=LTd6egzz2DEtYvVK44IMbb
	wa+BZ8Zj2sSdTLYxVcnmmttrbLPwhom3f7LZ29EYG/d6dgvORLDT0dyDtugWWCdB
	l1TnKFwPZBxbrbW7yirwM7HUBOp52GSK+T6F9rzr/YNXHJcqfU3YEqCI4G5EE7Y/
	b081uenieKQgspCwKwavvscxeDa4XGhbqH9LQD7M9nhX/Y6qo3l6UDDCzeXi60dU
	ZOVDypO2UDm4wEiid2O6lb3CQG5eTttXoSPAlkWH2g5f/6gqkUECORAw44g9SQ/H
	RnIaRQ2NrV464O6Hsyf0fHXVY9LMzfHsSExpVShw/N8vUQvF9j3FyuAx8hKLAqwg
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44ssva9kyp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Feb 2025 06:40:26 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51E4ff9o011677;
	Fri, 14 Feb 2025 06:40:25 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 44pktk9yvn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Feb 2025 06:40:25 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 51E6eO3n27722354
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 14 Feb 2025 06:40:24 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BA53F58057;
	Fri, 14 Feb 2025 06:40:24 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 763385805D;
	Fri, 14 Feb 2025 06:40:23 +0000 (GMT)
Received: from [9.61.255.185] (unknown [9.61.255.185])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 14 Feb 2025 06:40:23 +0000 (GMT)
Message-ID: <5a0d9847-54df-47f3-9e96-be393f76b3fb@linux.vnet.ibm.com>
Date: Fri, 14 Feb 2025 12:10:21 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [linux-next-20250212] syscall kexec_file_load not available
Content-Language: en-GB
To: Hari Bathini <hbathini@linux.ibm.com>, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Cc: Sourabh Jain <sourabhjain@linux.ibm.com>
References: <8e73069b-5987-4a08-b13d-13fe691092ad@linux.vnet.ibm.com>
 <77c11ea2-f3ae-497a-aaba-f7b33f46743d@linux.ibm.com>
From: Venkat Rao Bagalkote <venkat88@linux.vnet.ibm.com>
In-Reply-To: <77c11ea2-f3ae-497a-aaba-f7b33f46743d@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 6uYwXQ4X0eJylFIz94UmefSYhxhL2U3D
X-Proofpoint-ORIG-GUID: 6uYwXQ4X0eJylFIz94UmefSYhxhL2U3D
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-14_02,2025-02-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 mlxscore=0 spamscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 lowpriorityscore=0 phishscore=0 clxscore=1015
 impostorscore=0 mlxlogscore=812 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2501170000 definitions=main-2502140047

Yes Hari, its built with CONFIG_KEXEC_FILE=y

Regards,

Venkat.

On 14/02/25 12:02 pm, Hari Bathini wrote:
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
>
> - Hari
>

