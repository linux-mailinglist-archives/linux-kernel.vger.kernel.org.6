Return-Path: <linux-kernel+bounces-565989-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B534EA671CD
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 11:51:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B5793A7FEB
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 10:50:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5476020896B;
	Tue, 18 Mar 2025 10:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="OzsfEh7n"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 762B72045BF
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 10:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742295054; cv=none; b=po32bRwTt3CSdjrRJYq2Z3MPBtiJWtvb5Qj7m66RBzcXsDXYV5sWEv78mPvT5ay2bOx27i1feFlWbF0fb/IgwusrfrSnXetOAk3mvjaszJRYByhMsdEOaQ2PaU8BpnVoedgx0u94UsT+6z3FwC35ri2PeBTDS5guUo2hX6rpo4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742295054; c=relaxed/simple;
	bh=ikNBLqMrh3B4peT7FeG0Bjw4KNJyTdRkw/x4vB8tzGM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=BJ1+Vi09ETi6GWB5IzxaR2qjaNERptVuQcxO5jgl6iLSJJqGBYfMUoJi0qraiCSfd8DaiKL4FjRcuwPYRCFm/eKX3J42IR8trppLRMrwvVAaDkPFLrsKLCvKGmEOUswt7ILg0X9dNU4Qer9AJltRdT8IEWEnD0VzaMZ6piCd01M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=OzsfEh7n; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52I0t2cj001900;
	Tue, 18 Mar 2025 10:50:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=JdcrM+
	kp2CJukLPoc4xXByltSeAyBW01QEJvG70JYZs=; b=OzsfEh7ncSQBRhRAusYzru
	fmjK+CLnhVqnjNBCgQehVr/TA2jAeXQjiQm+++080PyqfvX9yNLhdGXW+YTYnv0f
	hK0jlfKIxv1Op/BzZdldYLLf2keIXJoTnGefnL3/OqIii9iR1JnAUsxcIabBiSnb
	8Mf8k1obKe3JXyJxgne7AzKsDNF7b4Xl7KiPQ8OE3tYUcJDa4oKjdIJTuAoDbmEc
	HWYzvo5C5ZK6ag3pwJA+ZfuhEyOlXH4u24E6FnWBfTtQOzYJ9KpAJ1tDL2vKrcx9
	hxPtB/ouOOKqwtISHsEoqH//92cHD+ha+ujgaweM1ZPDiQL06CP3bHJAp/XOS29A
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45en5pw3nt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Mar 2025 10:50:38 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52I8IJhi001092;
	Tue, 18 Mar 2025 10:50:37 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 45dp3kk5vh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Mar 2025 10:50:37 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 52IAoaIF26149124
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Mar 2025 10:50:37 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D5BC55803F;
	Tue, 18 Mar 2025 10:50:36 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AB79F58056;
	Tue, 18 Mar 2025 10:50:34 +0000 (GMT)
Received: from [9.66.75.14] (unknown [9.66.75.14])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 18 Mar 2025 10:50:34 +0000 (GMT)
Message-ID: <8efb89d6-cae0-441c-909c-3de5574e9058@linux.ibm.com>
Date: Tue, 18 Mar 2025 16:20:32 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [main-line][PowerPC]selftests/powerpc/signal: sigfuz fails
To: Michael Ellerman <mpe@ellerman.id.au>,
        Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
        linuxppc-dev@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>
References: <5f88a95b-1c8d-4a74-9753-9cdb2e64daf4@linux.ibm.com>
 <87v7s7di56.fsf@mpe.ellerman.id.au>
Content-Language: en-US
From: Madhavan Srinivasan <maddy@linux.ibm.com>
In-Reply-To: <87v7s7di56.fsf@mpe.ellerman.id.au>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: iRyMS8QvC--bfaSdjYppW7zC6AJkgN4b
X-Proofpoint-ORIG-GUID: iRyMS8QvC--bfaSdjYppW7zC6AJkgN4b
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-18_05,2025-03-17_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 adultscore=0
 suspectscore=0 mlxlogscore=999 clxscore=1015 lowpriorityscore=0
 impostorscore=0 mlxscore=0 bulkscore=0 phishscore=0 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2503180076



On 3/17/25 4:43 PM, Michael Ellerman wrote:
> Venkat Rao Bagalkote <venkat88@linux.ibm.com> writes:
>> Greetings!!
>>
>> I am observing selftests/powerpc/signal:sigfuz test fails on linux 
>> mainline repo on IBM Power10 systems.
>>
>> The test passes on the kernel with commit head: 
>> 619f0b6fad524f08d493a98d55bac9ab8895e3a6 and fails on the kernel with 
>> commit head: ce69b4019001407f9cd738dd2ba217b3a8ab831b on the main line.
>>
>>
>> Repo: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>>
>> I tried to do git bisect and the bisect tool pointed first bad commit 
>> to: 16ebb6f5b6295c9688749862a39a4889c56227f8.
>>
>> But upon reverting the first bad commit issue is still seen. So please 
>> ignore, if the bisection dosent help.
>>
>>
>> Error:
>>
>> # selftests: powerpc/signal: sigfuz
>> # test: signal_fuzzer
>> # tags: git_version:v6.14-rc7-1-g49c747976afa
>> # !! killing signal_fuzzer
>> # !! child died by signal 15
>> # failure: signal_fuzzer
>> not ok 3 selftests: powerpc/signal: sigfuz # exit=1
> 
> That error means the test is timing out and being killed by the test
> harness.
> 

I tired multiple times with the config shared by Venkat in my P10 LPAR
and it always passes for me with default timeout as 0.


ok 2 selftests: powerpc/signal: signal_tm                                                                                   
# timeout set to 0                                                                                                          
# selftests: powerpc/signal: sigfuz                                                                                         
# test: signal_fuzzer                                                                                                       
# tags: git_version:v6.14-rc2-61-g861efb8a48ee                                                                              
# success: signal_fuzzer                                                                                                    
ok 3 selftests: powerpc/signal: sigfuz                                                                                      
# timeout set to 0                                                                                                          
# selftests: powerpc/signal: sigreturn_vdso                                                                                 
# test: sigreturn_vdso                                                                                                      
# tags: git_version:v6.14-rc2-61-g861efb8a48ee                                                                              
# VDSO is at 0x7fff9aac0000-0x7fff9aacffff (65536 bytes)                                                                    
# Signal delivered OK with VDSO mapped                                                                                      
# VDSO moved to 0x7fff9aa50000-0x7fff9aa5ffff (65536 bytes)                                                                 
# Signal delivered OK with VDSO moved                                                                                       
# Unmapped VDSO                                                                                                             
# Remapped the stack executable                                                                                             
# Signal delivered OK with VDSO unmapped                                                                                    
# success: sigreturn_vdso                                                                                                   


Setup: P10 LPAR with 16CPUs, LPAR running only the selftest
Kernel: powerpc/next (861efb8a48ee), config shared by venkat 

Maddy

> That could be due to a bug, but it could just be that your system is
> overloaded or something. You can increase the timeout in the code by
> adding a call to test_harness_timeout().
> 
> The test also includes lots of randomisation, so if you actually need to
> bisect it you'd want to change the code to use a consistent random seed
> in the calls to srand().
> 
> cheers


