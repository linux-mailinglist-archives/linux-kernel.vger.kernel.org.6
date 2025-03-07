Return-Path: <linux-kernel+bounces-550653-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99807A5627A
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 09:19:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C495D1771A2
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 08:19:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2AD61C84BD;
	Fri,  7 Mar 2025 08:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="lTqn8ejM"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E14D1ACED9
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 08:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741335539; cv=none; b=Qkq3EbNoDGwT8s6LsFKoB/mZ0MWB7wcn4khwklVH+iVG4Vu1KF7Nsuwdk8qyYqsFbQhcjCAL9jUTsLCav8pNFCTcEwZRebUOjtD/VAHcDqqDhyNFCxjJwFiqD6RZ9IhwGJuRlJXknoHQScA/5Y5ttwmp4ozXcwSYFQW+GQf4kkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741335539; c=relaxed/simple;
	bh=nkNGMzzXdKLEMBuLY8GWMsqHKcKWqKD7ifdwtaZlYHw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=QWlOSNyzrPb/BYQV2a3bjcA6+tY07+j0Qw3CbRDIQm0iDrORjsTqpqlJhpnctpZfog5WAi1SGq+P/jUqnHb8H2tgCrRDnAmt8wBE7SGvCUVEFxB6vzMmHENoZJW9UiOfCbR9SbhfJ9gXCuUYKlR+FItNPNNO7Q9L/HpvKtV+lTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=lTqn8ejM; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52785Lnn005975;
	Fri, 7 Mar 2025 08:18:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=HUlocG
	2RnMX3+bo8rgZyFOe49j+CvldyoNogv34PoiA=; b=lTqn8ejMsy7P94bTmHyxXj
	e1I8DRmSmNAQUno5Qj6gA7VrKgMCXorx31kXfAYQDG70jbWTeaFJu7na+GhK2Jui
	QUQFnJXOvxQfG+5B+AtY2oUUkxvLmS1ydCGJA9f0qeGV5NqgywHwF7Bb3K1OZMYU
	f+9+gz/RNojIm7bI2rug/CNs+VNFiLrBqKReavO0Dk1kuHP6qx0vHOHOK4oNiLsh
	K0RnoOMh0q42MMCWZKOjo3yVLMKuFiaZHgenuzCBg+BvzC2pXTOxRU7tXJsMkhva
	mZrrimI3zmAiMTEGzRnkVn8ZpWdEZv6ix11/h1THsYpt3BY42JBr9ACTW1x62tcQ
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 457br2wab9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Mar 2025 08:18:45 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5275cKcD013724;
	Fri, 7 Mar 2025 08:18:44 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 454e2m5jq4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Mar 2025 08:18:44 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5278Ih9a31916604
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 7 Mar 2025 08:18:43 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8F24E58054;
	Fri,  7 Mar 2025 08:18:43 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BEA6F5805F;
	Fri,  7 Mar 2025 08:18:41 +0000 (GMT)
Received: from [9.61.252.177] (unknown [9.61.252.177])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  7 Mar 2025 08:18:41 +0000 (GMT)
Message-ID: <b52834e9-6611-46a0-b036-42f6e9fa202c@linux.ibm.com>
Date: Fri, 7 Mar 2025 13:48:40 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: PowerPC: sleftests/powerpc fails to compile linux-next
Content-Language: en-GB
To: Madhavan Srinivasan <maddy@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, Stephen Rothwell <sfr@canb.auug.org.au>,
        Michael Ellerman <mpe@ellerman.id.au>
References: <3267ea6e-5a1a-4752-96ef-8351c912d386@linux.ibm.com>
 <7d61512d-6dd1-4c09-b408-67bc16340237@linux.ibm.com>
From: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
In-Reply-To: <7d61512d-6dd1-4c09-b408-67bc16340237@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: h7aksYgr8NicgkMHYgcbHg6AcDX-CQFr
X-Proofpoint-ORIG-GUID: h7aksYgr8NicgkMHYgcbHg6AcDX-CQFr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-07_03,2025-03-06_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxscore=0
 spamscore=0 priorityscore=1501 bulkscore=0 clxscore=1015 mlxlogscore=999
 malwarescore=0 suspectscore=0 adultscore=0 impostorscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2503070057


On 07/03/25 12:32 pm, Madhavan Srinivasan wrote:
>
> On 3/6/25 10:30 PM, Venkat Rao Bagalkote wrote:
>> Greetings!!
>>
>> I see selftests/powerpc fails to compile on next-20250306.
>>
>> This error has been introduced in next-20250218. Make is successful on next-20250217.
>>
>>
>> Attached is the .config used.
>>
>>
>> If you fix this, please add below tag.
>>
>> Reported-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
>>
>>
>> Errors:
>>
>> make -C powerpc/
>> make: Entering directory '/root/venkat/linux-next/tools/testing/selftests/powerpc'
>> Makefile:60: warning: overriding recipe for target 'emit_tests'
>> ../lib.mk:182: warning: ignoring old recipe for target 'emit_tests'
>> BUILD_TARGET=/root/venkat/linux-next/tools/testing/selftests/powerpc/alignment; mkdir -p $BUILD_TARGET; make OUTPUT=$BUILD_TARGET -k -C alignment all
>> make[1]: Nothing to be done for 'all'.
>> BUILD_TARGET=/root/venkat/linux-next/tools/testing/selftests/powerpc/benchmarks; mkdir -p $BUILD_TARGET; make OUTPUT=$BUILD_TARGET -k -C benchmarks all
>> make[1]: Nothing to be done for 'all'.
>> BUILD_TARGET=/root/venkat/linux-next/tools/testing/selftests/powerpc/cache_shape; mkdir -p $BUILD_TARGET; make OUTPUT=$BUILD_TARGET -k -C cache_shape all
>> make[1]: Nothing to be done for 'all'.
>> BUILD_TARGET=/root/venkat/linux-next/tools/testing/selftests/powerpc/copyloops; mkdir -p $BUILD_TARGET; make OUTPUT=$BUILD_TARGET -k -C copyloops all
>> make[1]: Nothing to be done for 'all'.
>> BUILD_TARGET=/root/venkat/linux-next/tools/testing/selftests/powerpc/dexcr; mkdir -p $BUILD_TARGET; make OUTPUT=$BUILD_TARGET -k -C dexcr all
>> make[1]: Nothing to be done for 'all'.
>> BUILD_TARGET=/root/venkat/linux-next/tools/testing/selftests/powerpc/dscr; mkdir -p $BUILD_TARGET; make OUTPUT=$BUILD_TARGET -k -C dscr all
>> make[1]: Nothing to be done for 'all'.
>> BUILD_TARGET=/root/venkat/linux-next/tools/testing/selftests/powerpc/mm; mkdir -p $BUILD_TARGET; make OUTPUT=$BUILD_TARGET -k -C mm all
>>    CC       pkey_exec_prot
>> In file included from pkey_exec_prot.c:18:
>> /root/venkat/linux-next/tools/testing/selftests/powerpc/include/pkeys.h: In function ‘pkeys_unsupported’:
>> /root/venkat/linux-next/tools/testing/selftests/powerpc/include/pkeys.h:96:34: error: ‘PKEY_UNRESTRICTED’ undeclared (first use in this function)
>>     96 |         pkey = sys_pkey_alloc(0, PKEY_UNRESTRICTED);
>>        |                                  ^~~~~~~~~~~~~~~~~
> Commit 6d61527d931ba ('mm/pkey: Add PKEY_UNRESTRICTED macro') added a macro PKEY_UNRESTRICTED to handle implicit literal
> value of 0x0 (which is "unrestricted"). belore patch add the same to powerpc/mm selftest.
>
> Can you try with this patch to check whether it fixes the build break for you
>
>
> diff --git a/tools/testing/selftests/powerpc/include/pkeys.h b/tools/testing/selftests/powerpc/include/pkeys.h
> index c6d4063dd4f6..d6deb6ffa1b9 100644
> --- a/tools/testing/selftests/powerpc/include/pkeys.h
> +++ b/tools/testing/selftests/powerpc/include/pkeys.h
> @@ -24,6 +24,9 @@
>   #undef PKEY_DISABLE_EXECUTE
>   #define PKEY_DISABLE_EXECUTE   0x4
>   
> +#undef PKEY_UNRESTRICTED
> +#define PKEY_UNRESTRICTED      0x0
> +
>   /* Older versions of libc do not define this */
>   #ifndef SEGV_PKUERR
>   #define SEGV_PKUERR    4
>
>
> Maddy

/Responding to all/

/
/

Tested with the above patch and it fixes the issue.

Please add below tag.

Tested-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>


Regards,

Venkat.

>
>
>> /root/venkat/linux-next/tools/testing/selftests/powerpc/include/pkeys.h:96:34: note: each undeclared identifier is reported only once for each function it appears in
>> pkey_exec_prot.c: In function ‘segv_handler’:
>> pkey_exec_prot.c:75:53: error: ‘PKEY_UNRESTRICTED’ undeclared (first use in this function)
>>     75 |                         pkey_set_rights(fault_pkey, PKEY_UNRESTRICTED);
>>        | ^~~~~~~~~~~~~~~~~
>> make[1]: *** [../../lib.mk:222: /root/venkat/linux-next/tools/testing/selftests/powerpc/mm/pkey_exec_prot] Error 1
>>    CC       pkey_siginfo
>> In file included from pkey_siginfo.c:22:
>> /root/venkat/linux-next/tools/testing/selftests/powerpc/include/pkeys.h: In function ‘pkeys_unsupported’:
>> /root/venkat/linux-next/tools/testing/selftests/powerpc/include/pkeys.h:96:34: error: ‘PKEY_UNRESTRICTED’ undeclared (first use in this function)
>>     96 |         pkey = sys_pkey_alloc(0, PKEY_UNRESTRICTED);
>>        |                                  ^~~~~~~~~~~~~~~~~
>> /root/venkat/linux-next/tools/testing/selftests/powerpc/include/pkeys.h:96:34: note: each undeclared identifier is reported only once for each function it appears in
>> pkey_siginfo.c: In function ‘segv_handler’:
>> pkey_siginfo.c:86:39: error: ‘PKEY_UNRESTRICTED’ undeclared (first use in this function)
>>     86 |                 pkey_set_rights(pkey, PKEY_UNRESTRICTED);
>>        |                                       ^~~~~~~~~~~~~~~~~
>> make[1]: *** [../../lib.mk:222: /root/venkat/linux-next/tools/testing/selftests/powerpc/mm/pkey_siginfo] Error 1
>> make[1]: Target 'all' not remade because of errors.
>> make: *** [Makefile:40: mm] Error 2
>> make: Leaving directory '/root/venkat/linux-next/tools/testing/selftests/powerpc'
>>
>>
>> Regards,
>>
>> Venkat.

