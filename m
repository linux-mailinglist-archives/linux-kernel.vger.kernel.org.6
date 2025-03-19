Return-Path: <linux-kernel+bounces-567929-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 333DAA68C0D
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 12:45:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D2D418852D7
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 11:44:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D662920E31B;
	Wed, 19 Mar 2025 11:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="HCuZr5Ho"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A4F6221551
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 11:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742384672; cv=none; b=bxOCuG1AChkvKSgPcMSO2XefnA0wO/Fp+XzlXa0VMJEM4cpbEm2Vo0qh+vKh2xpcH+tXZ/Unj1cnFZJwFi7xu4ss4qXOyRT7kQXbOWHOzKb0RxMGAFCkxCd6D6xz6kVPt5h+9qiI2CZmuYtnzrWOtkgyYkGzgvsbBZJn1kl4dx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742384672; c=relaxed/simple;
	bh=1rE6hYqpBjWYetNgywdqgGqM6+qERitOJp2qkDS25BY=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:References:
	 In-Reply-To:Content-Type; b=aLSnsbZQGiVz07utgihAnDd7mHH2ZM9FZnz0wurNJGTN+LD1Sfe7G+dHJfbR9hKByxGR/5fEI4NW/h6E38vX3PsTgt1nEQd7K+VO8em1BOekJihT0S29jyXMlb378GpMEZ2lKXl10BvvE0vPFGT7zqgehZM8O8jYc0qXLdlJCbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=HCuZr5Ho; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52J3kDaU019347;
	Wed, 19 Mar 2025 11:44:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=vjxafd
	7/u5Y+QwmhmIFT9I0JYjjq9NcGj0d7ATle1OU=; b=HCuZr5HoY6TJ1PxP/MS0T0
	ECWr8BtK30zscdJQBHMYKjUrD1O5nQbbFYF0YeZEap8CrwabYNRbZS8/Mbi0w9lt
	58Qt69utk/JI78BnyEZRXoJZ7hmGzdHH2LQpQqcRG/KzW2Y0kjZN76x6K09amYiK
	1seQduMp9O0CY3ncI2hBGnK+VgM1pIszjBq4Bq6sgKHzZB2IbM02TBxl/IBdILf4
	DS401szlwlFUA2Vlfnu0e/LxV+1eT0ZSEKF2iq5JTGTg1fKnSdZYbj4vNVIJEpkA
	h0fATM1/Ve7dI+Zwl1akNCvCm0j+X1bddQWWZNYV4Qv1FD71dEoM7bVkEFg4KGwg
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45fpa9j3fa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Mar 2025 11:44:19 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52JBDxu1023196;
	Wed, 19 Mar 2025 11:44:18 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 45dp3ks3ts-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Mar 2025 11:44:18 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 52JBiHUg25887236
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Mar 2025 11:44:17 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7DFB65805C;
	Wed, 19 Mar 2025 11:44:17 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7C6A658054;
	Wed, 19 Mar 2025 11:44:15 +0000 (GMT)
Received: from [9.61.249.96] (unknown [9.61.249.96])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 19 Mar 2025 11:44:14 +0000 (GMT)
Message-ID: <6debfdf3-2e7b-4581-b1ab-cc5ec1607237@linux.ibm.com>
Date: Wed, 19 Mar 2025 17:14:12 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Subject: Re: [main-line][PowerPC]selftests/powerpc/signal: sigfuz fails
To: Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org,
        LKML <linux-kernel@vger.kernel.org>
References: <5f88a95b-1c8d-4a74-9753-9cdb2e64daf4@linux.ibm.com>
 <87v7s7di56.fsf@mpe.ellerman.id.au>
 <8efb89d6-cae0-441c-909c-3de5574e9058@linux.ibm.com>
Content-Language: en-GB
In-Reply-To: <8efb89d6-cae0-441c-909c-3de5574e9058@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: n8j5TlE9gbBlXD45tQbMS7QjYRdlzNth
X-Proofpoint-ORIG-GUID: n8j5TlE9gbBlXD45tQbMS7QjYRdlzNth
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-19_03,2025-03-19_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 phishscore=0 priorityscore=1501 spamscore=0 impostorscore=0 malwarescore=0
 clxscore=1015 mlxscore=0 adultscore=0 lowpriorityscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503190080

Thanks Michael and Maddy for the feedback.

On 18/03/25 4:20 pm, Madhavan Srinivasan wrote:
> On 3/17/25 4:43 PM, Michael Ellerman wrote:
>> Venkat Rao Bagalkote<venkat88@linux.ibm.com> writes:
>>> Greetings!!
>>>
>>> I am observing selftests/powerpc/signal:sigfuz test fails on linux
>>> mainline repo on IBM Power10 systems.
>>>
>>> The test passes on the kernel with commit head:
>>> 619f0b6fad524f08d493a98d55bac9ab8895e3a6 and fails on the kernel with
>>> commit head: ce69b4019001407f9cd738dd2ba217b3a8ab831b on the main line.
>>>
>>>
>>> Repo:https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>>>
>>> I tried to do git bisect and the bisect tool pointed first bad commit
>>> to: 16ebb6f5b6295c9688749862a39a4889c56227f8.
>>>
>>> But upon reverting the first bad commit issue is still seen. So please
>>> ignore, if the bisection dosent help.
>>>
>>>
>>> Error:
>>>
>>> # selftests: powerpc/signal: sigfuz
>>> # test: signal_fuzzer
>>> # tags: git_version:v6.14-rc7-1-g49c747976afa
>>> # !! killing signal_fuzzer
>>> # !! child died by signal 15
>>> # failure: signal_fuzzer
>>> not ok 3 selftests: powerpc/signal: sigfuz # exit=1
>> That error means the test is timing out and being killed by the test
>> harness.
>>
> I tired multiple times with the config shared by Venkat in my P10 LPAR
> and it always passes for me with default timeout as 0.
>
>
> ok 2 selftests: powerpc/signal: signal_tm
> # timeout set to 0
> # selftests: powerpc/signal: sigfuz
> # test: signal_fuzzer
> # tags: git_version:v6.14-rc2-61-g861efb8a48ee
> # success: signal_fuzzer
> ok 3 selftests: powerpc/signal: sigfuz
> # timeout set to 0
> # selftests: powerpc/signal: sigreturn_vdso
> # test: sigreturn_vdso
> # tags: git_version:v6.14-rc2-61-g861efb8a48ee
> # VDSO is at 0x7fff9aac0000-0x7fff9aacffff (65536 bytes)
> # Signal delivered OK with VDSO mapped
> # VDSO moved to 0x7fff9aa50000-0x7fff9aa5ffff (65536 bytes)
> # Signal delivered OK with VDSO moved
> # Unmapped VDSO
> # Remapped the stack executable
> # Signal delivered OK with VDSO unmapped
> # success: sigreturn_vdso
>
>
> Setup: P10 LPAR with 16CPUs, LPAR running only the selftest
> Kernel: powerpc/next (861efb8a48ee), config shared by venkat
>
> Maddy
>
>
> One key difference which I could figure out so far in the set up is, mine is Power10 system running on P11 FW.
>
> I quickly gave a try with P10 system with P10 FW, and issue is not seen.
>
> Logs from P10 system running on P10 FW:
>
> make -j 33 -C powerpc/signal/ run_tests make: Entering directory 
> '/root/venkat/linux/tools/testing/selftests/powerpc/signal' TAP 
> version 13 1..7 # timeout set to 0 # selftests: powerpc/signal: signal 
> # test: signal # tags: git_version:v6.14-rc7-69-g81e4f8d68c66 # 
> success: signal ok 1 selftests: powerpc/signal: signal # timeout set 
> to 0 # selftests: powerpc/signal: signal_tm # test: signal_tm # tags: 
> git_version:v6.14-rc7-69-g81e4f8d68c66 # [SKIP] Test skipped on line 
> 58 # skip: signal_tm ok 2 selftests: powerpc/signal: signal_tm # 
> timeout set to 0 # selftests: powerpc/signal: sigfuz # test: 
> signal_fuzzer # tags: git_version:v6.14-rc7-69-g81e4f8d68c66 # 
> success: signal_fuzzer ok 3 selftests: powerpc/signal: sigfuz # 
> timeout set to 0 # selftests: powerpc/signal: sigreturn_vdso # test: 
> sigreturn_vdso # tags: git_version:v6.14-rc7-69-g81e4f8d68c66 # VDSO 
> is at 0x7fffae2e0000-0x7fffae2effff (65536 bytes) # Signal delivered 
> OK with VDSO mapped # VDSO moved to 0x7fffae270000-0x7fffae27ffff 
> (65536 bytes) # Signal delivered OK with VDSO moved # Unmapped VDSO # 
> Remapped the stack executable # Signal delivered OK with VDSO unmapped 
> # success: sigreturn_vdso ok 4 selftests: powerpc/signal: 
> sigreturn_vdso # timeout set to 0 # selftests: powerpc/signal: 
> sig_sc_double_restart # test: sig sys restart # tags: 
> git_version:v6.14-rc7-69-g81e4f8d68c66 # success: sig sys restart ok 5 
> selftests: powerpc/signal: sig_sc_double_restart # timeout set to 0 # 
> selftests: powerpc/signal: sigreturn_kernel # test: sigreturn_kernel # 
> tags: git_version:v6.14-rc7-69-g81e4f8d68c66 # All children killed as 
> expected # success: sigreturn_kernel ok 6 selftests: powerpc/signal: 
> sigreturn_kernel # timeout set to 0 # selftests: powerpc/signal: 
> sigreturn_unaligned # test: sigreturn_unaligned # tags: 
> git_version:v6.14-rc7-69-g81e4f8d68c66 # success: sigreturn_unaligned 
> ok 7 selftests: powerpc/signal: sigreturn_unaligned make: Leaving 
> directory '/root/venkat/linux/tools/testing/selftests/powerpc/signal'
>> That could be due to a bug, but it could just be that your system is
>> overloaded or something. You can increase the timeout in the code by
>> adding a call to test_harness_timeout().
>>
>> The test also includes lots of randomisation, so if you actually need to
>> bisect it you'd want to change the code to use a consistent random seed
>> in the calls to srand().
>>
>> cheers
> I increased the timeout from 0 to 120, I still see the issue.
>
> Below are the logs with and with out time out.
>
> make -j 33 -C powerpc/signal/ run_tests all clean clean_mods_dir 
> emit_tests gen_mods_dir install run_tests [root@ltcden8-lp3 
> selftests]# make -j 33 -C powerpc/signal/ run_tests make: Entering 
> directory '/root/linux/tools/testing/selftests/powerpc/signal' CC 
> signal CC signal_tm CC sigfuz CC sigreturn_vdso CC 
> sig_sc_double_restart CC sigreturn_kernel CC sigreturn_unaligned TAP 
> version 13 1..7 # timeout set to 0 # selftests: powerpc/signal: signal 
> # test: signal # tags: git_version:v6.14-rc7-69-g81e4f8d68c66 # 
> success: signal ok 1 selftests: powerpc/signal: signal # timeout set 
> to 0 # selftests: powerpc/signal: signal_tm # test: signal_tm # tags: 
> git_version:v6.14-rc7-69-g81e4f8d68c66 # [SKIP] Test skipped on line 
> 58 # skip: signal_tm ok 2 selftests: powerpc/signal: signal_tm # 
> timeout set to 0 # selftests: powerpc/signal: sigfuz # test: 
> signal_fuzzer # tags: git_version:v6.14-rc7-69-g81e4f8d68c66 # !! 
> killing signal_fuzzer # !! child died by signal 15 # failure: 
> signal_fuzzer not ok 3 selftests: powerpc/signal: sigfuz # exit=1 # 
> timeout set to 0 # selftests: powerpc/signal: sigreturn_vdso # test: 
> sigreturn_vdso # tags: git_version:v6.14-rc7-69-g81e4f8d68c66 # VDSO 
> is at 0x7fffb1860000-0x7fffb186ffff (65536 bytes) # Signal delivered 
> OK with VDSO mapped # VDSO moved to 0x7fffb17f0000-0x7fffb17fffff 
> (65536 bytes) # Signal delivered OK with VDSO moved # Unmapped VDSO # 
> Remapped the stack executable # Signal delivered OK with VDSO unmapped 
> # success: sigreturn_vdso ok 4 selftests: powerpc/signal: 
> sigreturn_vdso # timeout set to 0 # selftests: powerpc/signal: 
> sig_sc_double_restart # test: sig sys restart # tags: 
> git_version:v6.14-rc7-69-g81e4f8d68c66 # success: sig sys restart ok 5 
> selftests: powerpc/signal: sig_sc_double_restart # timeout set to 0 # 
> selftests: powerpc/signal: sigreturn_kernel # test: sigreturn_kernel # 
> tags: git_version:v6.14-rc7-69-g81e4f8d68c66 # All children killed as 
> expected # success: sigreturn_kernel ok 6 selftests: powerpc/signal: 
> sigreturn_kernel # timeout set to 0 # selftests: powerpc/signal: 
> sigreturn_unaligned # test: sigreturn_unaligned # tags: 
> git_version:v6.14-rc7-69-g81e4f8d68c66 # success: sigreturn_unaligned 
> ok 7 selftests: powerpc/signal: sigreturn_unaligned make: Leaving 
> directory '/root/linux/tools/testing/selftests/powerpc/signal'
> # vi powerpc/signal/settings make -j 33 -C powerpc/signal/ run_tests 
> make: Entering directory 
> '/root/linux/tools/testing/selftests/powerpc/signal' TAP version 13 
> 1..7 # timeout set to 120 # selftests: powerpc/signal: signal # test: 
> signal # tags: git_version:v6.14-rc7-69-g81e4f8d68c66 # success: 
> signal ok 1 selftests: powerpc/signal: signal # timeout set to 120 # 
> selftests: powerpc/signal: signal_tm # test: signal_tm # tags: 
> git_version:v6.14-rc7-69-g81e4f8d68c66 # [SKIP] Test skipped on line 
> 58 # skip: signal_tm ok 2 selftests: powerpc/signal: signal_tm # 
> timeout set to 120 # selftests: powerpc/signal: sigfuz # test: 
> signal_fuzzer # tags: git_version:v6.14-rc7-69-g81e4f8d68c66 # not ok 
> 3 selftests: powerpc/signal: sigfuz # TIMEOUT 120 seconds # timeout 
> set to 120 # selftests: powerpc/signal: sigreturn_vdso # test: 
> sigreturn_vdso # tags: git_version:v6.14-rc7-69-g81e4f8d68c66 # VDSO 
> is at 0x7fff8b170000-0x7fff8b17ffff (65536 bytes) # Signal delivered 
> OK with VDSO mapped # VDSO moved to 0x7fff8b100000-0x7fff8b10ffff 
> (65536 bytes) # Signal delivered OK with VDSO moved # Unmapped VDSO # 
> Remapped the stack executable # Signal delivered OK with VDSO unmapped 
> # success: sigreturn_vdso ok 4 selftests: powerpc/signal: 
> sigreturn_vdso # timeout set to 120 # selftests: powerpc/signal: 
> sig_sc_double_restart # test: sig sys restart # tags: 
> git_version:v6.14-rc7-69-g81e4f8d68c66 # success: sig sys restart ok 5 
> selftests: powerpc/signal: sig_sc_double_restart # timeout set to 120 
> # selftests: powerpc/signal: sigreturn_kernel # test: sigreturn_kernel 
> # tags: git_version:v6.14-rc7-69-g81e4f8d68c66 # All children killed 
> as expected # success: sigreturn_kernel ok 6 selftests: 
> powerpc/signal: sigreturn_kernel # timeout set to 120 # selftests: 
> powerpc/signal: sigreturn_unaligned # test: sigreturn_unaligned # 
> tags: git_version:v6.14-rc7-69-g81e4f8d68c66 # success: 
> sigreturn_unaligned ok 7 selftests: powerpc/signal: 
> sigreturn_unaligned make: Leaving directory 
> '/root/linux/tools/testing/selftests/powerpc/signal' [root@ltcden8-lp3 
> selftests]# [root@ltcden8-lp3 selftests]# [root@ltcden8-lp3 
> selftests]# uname -r 6.14.0-rc7-00069-g81e4f8d68c66 [root@ltcden8-lp3 
> selftests]#


Regards,

Venkat.


