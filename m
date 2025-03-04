Return-Path: <linux-kernel+bounces-544044-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 446DDA4DCCD
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 12:41:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A296D3AFBBC
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 11:41:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8E931FFC69;
	Tue,  4 Mar 2025 11:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="cbs2jcLx"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 836701FCD00
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 11:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741088500; cv=none; b=YBALRmR3OByC0euQrSeRswAuvczL7UdrnAPOv8CQfpZg6Xjo3QTgbPQUthnJPSZteIat4NJwJ2MJQ64B1h1R+Q48eNd5TodjhzGJkyBV335JI+3Fog5GEKzPVzyib7wF5OYjSenz2EMCwCVw2vjCDaDfjAm9tqYSEJFuwHD+wEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741088500; c=relaxed/simple;
	bh=I44sgI+u2joZdHUTtoqWCM8gDvnFAnNWYP1QyAt08vk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=juY4z0M7YwWv0nWRp6/4xNJvm6i0R4RWsxgVczHDL/+0vd2gyNaZzuNWRqQDcZ6/Q+tMTdBbNIjpiNrrIo6OPOAI+TvGtZmAu7r6jO7NX3n/Mrwesb0JGLIJdFC13spE/divXDej2NufrjCZImjZL1DUCo+AWr8djnuqcUZEXHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=cbs2jcLx; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 524AZcaE023022;
	Tue, 4 Mar 2025 11:41:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=OUxtYV
	zm+6IiOZ/jzardOjOvsD4thEc0+iR6C42pggo=; b=cbs2jcLxX848zDIM68P8Re
	Qz9oJule4qOVqICVeZzYNedH+d/Ei4Rj33d4LOWzqBOswIBvl0XzQeqcAxZr9HH/
	clU5u2VIaXBO2EpUpjTh0Tl4YPTRsi8jpH7o4CApEYlaB5fZDD0WtFs4Z2ExOSZY
	3bQ0Ms2RdUn44E1/SuxDljY98ddP+WwD3zdV1hn2AoFBkoXhuxzoxrpM6fuyS02+
	ONj9LutuOZ3EfRWJdBnk2qXzDmoRofrHAkbaasNzJN2b8EaZH9fXAB7don4E1j4/
	o6iqYEGePERGZ/8wNsyisplW7bOsHMzhT4tsk8tO3qJacMQ8ovKDQyXcaVbxicGA
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 455dunxdww-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Mar 2025 11:41:24 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52489uZD013776;
	Tue, 4 Mar 2025 11:41:23 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 454e2kn2ma-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Mar 2025 11:41:23 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 524BfLN525690750
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 4 Mar 2025 11:41:21 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F07A658045;
	Tue,  4 Mar 2025 11:41:22 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 37B5758054;
	Tue,  4 Mar 2025 11:41:21 +0000 (GMT)
Received: from [9.204.204.161] (unknown [9.204.204.161])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  4 Mar 2025 11:41:20 +0000 (GMT)
Message-ID: <2a8656cf-8ff5-40fa-8ed8-efb1245fddf2@linux.ibm.com>
Date: Tue, 4 Mar 2025 17:11:19 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Build Warnings at arch/powerpc/
Content-Language: en-GB
To: Madhavan Srinivasan <maddy@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, Stephen Rothwell <sfr@canb.auug.org.au>,
        Michael Ellerman <mpe@ellerman.id.au>
References: <8c4c3fc2-2bd7-4148-af68-2f504d6119e0@linux.ibm.com>
 <47aa8b75-96b6-4e37-bb62-ad758b414076@linux.ibm.com>
From: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
In-Reply-To: <47aa8b75-96b6-4e37-bb62-ad758b414076@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: v0imr_UqSZMlwgBJTuNKxA0mCg2N0V3s
X-Proofpoint-GUID: v0imr_UqSZMlwgBJTuNKxA0mCg2N0V3s
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-04_05,2025-03-03_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 adultscore=0 priorityscore=1501 malwarescore=0 bulkscore=0 spamscore=0
 suspectscore=0 mlxlogscore=999 phishscore=0 clxscore=1015 mlxscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2503040097

Hello Maddy,


Git bisect is poinitng to d543c29a68989ac9e39e0b50cfe8b592d92a1599 as 
the first bad commit.

Git Bisect log:

[root@ltc-zzci-1 linux-next]# git bisect log
git bisect start
# status: waiting for both good and bad commits
# good: [7eb172143d5508b4da468ed59ee857c6e5e01da6] Linux 6.14-rc5
git bisect good 7eb172143d5508b4da468ed59ee857c6e5e01da6
# status: waiting for bad commit, 1 good commit known
# bad: [cd3215bbcb9d4321def93fea6cfad4d5b42b9d1d] Add linux-next 
specific files for 20250303
git bisect bad cd3215bbcb9d4321def93fea6cfad4d5b42b9d1d
# bad: [f084774e60dd4171a536e7f5506f90031e3a8c6f] Merge branch 
'for-next' of git://git.kernel.org/pub/scm/linux/kernel/git/ath/ath.git
git bisect bad f084774e60dd4171a536e7f5506f90031e3a8c6f
# good: [a57419b6b3df381d61367a3034910d1d8a197fd7] Merge branch 
'fs-next' of linux-next
git bisect good a57419b6b3df381d61367a3034910d1d8a197fd7
# good: [4350f3677257b7762a89901f81bc2e5ef84bc30f] Merge branch 
'for-next' of git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git
git bisect good 4350f3677257b7762a89901f81bc2e5ef84bc30f
# good: [e87700965abeddcdb84c9540107c69ce08b87431] Merge tag 
'for-netdev' of https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next
git bisect good e87700965abeddcdb84c9540107c69ce08b87431
# bad: [0edfdc95d3459a6a9e9487a748b04c5b8fd2a69a] Merge branch 'master' 
of git://git.kernel.org/pub/scm/linux/kernel/git/klassert/ipsec-next.git
git bisect bad 0edfdc95d3459a6a9e9487a748b04c5b8fd2a69a
# good: [97fc6863637630cdf9a5e9ed2569fe9a7974434b] net: usb: cdc_mbim: 
fix Telit Cinterion FE990A name
git bisect good 97fc6863637630cdf9a5e9ed2569fe9a7974434b
# good: [bb7abf3049025f7e4ad91cff2d9fe8381a9278af] bpf: make 
state->dfs_depth < state->loop_entry->dfs_depth an invariant
git bisect good bb7abf3049025f7e4ad91cff2d9fe8381a9278af
# good: [0ba0ef012eba63652a50b318a7a3136963c37f74] selftests/bpf: Test 
bpf_usdt_arg_size() function
git bisect good 0ba0ef012eba63652a50b318a7a3136963c37f74
# good: [42c5e6d2accf31bba4cd31f8a742d5b9e19a7d28] selftests/bpf: Add 
selftests allowing cgroup prog pre-ordering
git bisect good 42c5e6d2accf31bba4cd31f8a742d5b9e19a7d28
# good: [b70c222ea9d66d51fc1f038f82e41ea17b38499f] Merge branch 
'bpf-next/master' into for-next
git bisect good b70c222ea9d66d51fc1f038f82e41ea17b38499f
# good: [cc18f482e8b60a2bcf2d7d57b48740bd0837fc04] xfrm: provide common 
xdo_dev_offload_ok callback implementation
git bisect good cc18f482e8b60a2bcf2d7d57b48740bd0837fc04
# bad: [d543c29a68989ac9e39e0b50cfe8b592d92a1599] Merge branch 
'for-next' of git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git
git bisect bad d543c29a68989ac9e39e0b50cfe8b592d92a1599
# good: [3ab37b090d1c458553a5268c7aaa8790ee759674] Merge branch 'main' 
of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git
git bisect good 3ab37b090d1c458553a5268c7aaa8790ee759674
# first bad commit: [d543c29a68989ac9e39e0b50cfe8b592d92a1599] Merge 
branch 'for-next' of 
git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git

On 04/03/25 11:43 am, Madhavan Srinivasan wrote:
>
> On 3/4/25 10:42 AM, Venkat Rao Bagalkote wrote:
>> Greetings!!
>>
>>
>> Observing build warnings with linux-next and powerpc repo's. Issue is currently not seen on mainline yet.
>>
>> PPC Repo: https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git merge branch
>>
>> PPC Kernel Version: 6.14.0-rc4-g1304f486dbf1
>> next Repo: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master branch
>>
>> next Kernel Version: 6.14.0-rc5-next-20250303
>>
>>
>> On linux-next kernel issue got introduced b/w next-20250227 and next-20250303
>>
>>
>> Build Warnings:
>>
>> arch/powerpc/kvm/book3s_hv_rmhandlers.o: warning: objtool: .text+0xe84: intra_function_call not a direct call
>> arch/powerpc/crypto/ghashp8-ppc.o: warning: objtool: .text+0x22c: unannotated intra-function call
>> arch/powerpc/kernel/switch.o: warning: objtool: .text+0x4: intra_function_call not a direct call
>>
>>
> Can you please specific the compiler and compiler version you found this issue with
>
> maddy
GCC Version: gcc (GCC) 11.4.1 20231218 (Red Hat 11.4.1-3)
>
>> If you fix this issue, please add below tag.
>>
>>
>> Reported-By: Venkat Rao Bagalkote <venkat88@linux.vnet.ibm.com>
>>
>>
>> Regards,
>>
>> Venkat.
>>
Regards,

Venkat.

>

