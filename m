Return-Path: <linux-kernel+bounces-543695-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F23CFA4D8B2
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 10:38:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA1B61783C6
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 09:36:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D89561FECAB;
	Tue,  4 Mar 2025 09:32:23 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DD061FE476
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 09:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741080743; cv=none; b=mSaYVbd47o9laC6s1SAiczubvWMEInBKEVW/9aHescTdLy1KCsPXuxE3DrE2SlyOs98+hO1KiuCmuiiFssxzIRaZ9JhMvJxG06ecc10RW04eLT0gfMbkcFb5A8OGT6bNUuDEVrzUKY83xHVXJBTsW9fdRYqAjr+K2ZQzLVL+yng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741080743; c=relaxed/simple;
	bh=k+0h5dWOOQAv81QboClgzsSj9ftKZm5LSxf1fJK/uvg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OQQjlMi9Mhv4pBWoShs0Hp/x6tsQaCi2VI/ljpSixc0rjO7+0886IwKgggANPvZiuQOUy4NGIEuMy4QLBgwoMPuYcJa0zBJPoJgt9j1h9Yg+Bv06g5hQh2IpdY+xzouF1FIdFhMav6sF9XSoFOPpVaKDBYYiwOU/w/r9M/rNv1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 59B18FEC;
	Tue,  4 Mar 2025 01:32:32 -0800 (PST)
Received: from [192.168.178.71] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E86613F66E;
	Tue,  4 Mar 2025 01:32:14 -0800 (PST)
Message-ID: <5435fd87-6209-4896-84cc-27a35ef3cea4@arm.com>
Date: Tue, 4 Mar 2025 10:32:13 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 2/4] arch_topology: Support SMT control for OF based
 system
To: Yicong Yang <yangyicong@huawei.com>, sudeep.holla@arm.com,
 pierre.gondois@arm.com
Cc: dave.hansen@linux.intel.com, bp@alien8.de, mingo@redhat.com,
 linux-arm-kernel@lists.infradead.org, mpe@ellerman.id.au,
 peterz@infradead.org, tglx@linutronix.de, will@kernel.org,
 catalin.marinas@arm.com, yangyicong@hisilicon.com,
 linuxppc-dev@lists.ozlabs.org, x86@kernel.org, linux-kernel@vger.kernel.org,
 morten.rasmussen@arm.com, msuchanek@suse.de, gregkh@linuxfoundation.org,
 rafael@kernel.org, jonathan.cameron@huawei.com, prime.zeng@hisilicon.com,
 linuxarm@huawei.com, xuwei5@huawei.com, guohanjun@huawei.com,
 sshegde@linux.ibm.com
References: <20250218141018.18082-1-yangyicong@huawei.com>
 <20250218141018.18082-3-yangyicong@huawei.com>
 <8a9aedef-08d7-445f-9b67-85e74ec6bd50@arm.com>
 <21e74021-fb68-0003-f0f4-7f54dd674b9d@huawei.com>
From: Dietmar Eggemann <dietmar.eggemann@arm.com>
Content-Language: en-US
In-Reply-To: <21e74021-fb68-0003-f0f4-7f54dd674b9d@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 03/03/2025 15:03, Yicong Yang wrote:
> On 2025/2/28 19:11, Dietmar Eggemann wrote:
>> On 18/02/2025 15:10, Yicong Yang wrote:
>>> From: Yicong Yang <yangyicong@hisilicon.com>

[...]

>>> If a system have more than one SMT thread number the 2) may
>>
>> s/have/has
>>
>>> not handle it well, since there're multiple thread numbers in the
>>
>> multiple thread numbers other than 1, right?
> 
> according to the pr_warn_once() we implemented below it also includes the case
> where the system have one type of SMT cores and non-SMT cores (the thread number is 1):
> - 1 thread
> - X (!= 1) threads
> 
> Discussion made in [1] and I thought we have agreement (hope I understood correctly)
> that all the asymmetric cases need to notify. Do you and Sudeep think we should not
> warn in such case?

Systems with non-SMT and SMT-2 cores are IMHO a special case since for
them the '/sys/devices/system/cpu/smt' interface still works correctly.
And on X86 those systems do exist today.

IMHO, it would be awkward to see the message 'Heterogeneous SMT topology
is partly supported by SMT control' on arm64 but not on x86 on such a
system.

I do understand that this message is more tailored to theoretically
possible 'multiple SMT-X (X>1) core' systems (e.g. 1,2,4).

And here we cannot issue a '2 > ./control' since
cpu_smt_num_threads_valid() only returns true for 1 or 4.

IMHO, I would remove the warning and state clearly in the patch that for
systems with multiple SMT-X (X>1) cores, this interface only support SMT
completely on or off.

Example Arm64 DT:

cpu-map {
        cluster0 {
                core0 {
                        thread0 {
                                cpu = <&A53_0>;
                        };
                };
                core1 {
                        thread0 {
                                cpu = <&A53_1>;
                        };
                };
                core2 {
                        thread0 {
                                cpu = <&A53_2>;
                        };
                        thread1 {
                                cpu = <&A53_3>;
                        };
                };
                core3 {
                        thread0 {
                                cpu = <&A53_4>;
                        };
                        thread1 {
                                cpu = <&A53_5>;
                        };
                        thread2 {
                                cpu = <&A53_6>;
                        };
                        thread3 {
                                cpu = <&A53_7>;
                        };
                };
        };
};

# cat /proc/cpuinfo | grep ^processor
processor	: 0
processor	: 1
processor	: 2
processor	: 3
processor	: 4
processor	: 5
processor	: 6
processor	: 7

/sys/devices/system/cpu/smt# echo 1 >control

# cat /proc/cpuinfo | grep ^processor
processor	: 0
processor	: 1
processor	: 2
processor	: 4

/sys/devices/system/cpu/smt# echo 2 >control
-bash: echo: write error: Invalid argument

[...]

