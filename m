Return-Path: <linux-kernel+bounces-564043-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D0EBBA64C87
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 12:29:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A0B9170416
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 11:29:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9228C236A72;
	Mon, 17 Mar 2025 11:29:33 +0000 (UTC)
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE05521A436
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 11:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742210973; cv=none; b=jyOETaF7venew5PWqV5sZEby0uxCpmdAthQR2w/UMVIE5rnAJg4vlcDu1u77tkc2mAor0pTVHCYbMP0UZXQyJjuAlsg8nI/NccHmw3SzmDyX7jexXIBF3Iv4bguhY5KIPg6Rk7gbjXNkvVEAXka7yk/lWMnebbw04lwTBAtgiP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742210973; c=relaxed/simple;
	bh=QmnJHaV/LvlWfyKBjbtHXfHA6grqklwLxNxyUXyeNU0=;
	h=CC:Subject:To:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=tcSDLLw8bYEcmjXRYbNekbyjhuoMrmG9+dCNuU506ZRW/krxIHEIiGzE5aQjgBYtLmOhvOj+TonPpZtPPwdkuf1D5+AKIwmKdSVWiKaVLTjb/llJihhLlEQAAjbfu4E5TIy5kEYQBUIt83/aB2Iq9wDQ2vWRJky33n91dBzcMKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4ZGXmj58Ndz1d0LT;
	Mon, 17 Mar 2025 19:29:09 +0800 (CST)
Received: from kwepemd200014.china.huawei.com (unknown [7.221.188.8])
	by mail.maildlp.com (Postfix) with ESMTPS id B3002140360;
	Mon, 17 Mar 2025 19:29:20 +0800 (CST)
Received: from [10.67.121.177] (10.67.121.177) by
 kwepemd200014.china.huawei.com (7.221.188.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Mon, 17 Mar 2025 19:29:19 +0800
CC: <catalin.marinas@arm.com>, <will@kernel.org>, <sudeep.holla@arm.com>,
	<tglx@linutronix.de>, <peterz@infradead.org>, <mpe@ellerman.id.au>,
	<linux-arm-kernel@lists.infradead.org>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <pierre.gondois@arm.com>,
	<yangyicong@hisilicon.com>, <linuxppc-dev@lists.ozlabs.org>,
	<x86@kernel.org>, <linux-kernel@vger.kernel.org>, <morten.rasmussen@arm.com>,
	<msuchanek@suse.de>, <gregkh@linuxfoundation.org>, <rafael@kernel.org>,
	<jonathan.cameron@huawei.com>, <prime.zeng@hisilicon.com>,
	<linuxarm@huawei.com>, <xuwei5@huawei.com>, <guohanjun@huawei.com>,
	<sshegde@linux.ibm.com>
Subject: Re: [PATCH v12 2/4] arch_topology: Support SMT control for OF based
 system
To: Dietmar Eggemann <dietmar.eggemann@arm.com>
References: <20250311075143.61078-1-yangyicong@huawei.com>
 <20250311075143.61078-3-yangyicong@huawei.com>
 <2bd3aa0a-d700-46bf-81d1-a5fb0364d1e0@arm.com>
From: Yicong Yang <yangyicong@huawei.com>
Message-ID: <c88e5b78-37b7-3023-7842-56a93fe119d2@huawei.com>
Date: Mon, 17 Mar 2025 19:29:19 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <2bd3aa0a-d700-46bf-81d1-a5fb0364d1e0@arm.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemd200014.china.huawei.com (7.221.188.8)

On 2025/3/17 17:56, Dietmar Eggemann wrote:
> On 11/03/2025 08:51, Yicong Yang wrote:
>> From: Yicong Yang <yangyicong@hisilicon.com>
>>
>> On building the topology from the devicetree, we've already gotten the
>> SMT thread number of each core. Update the largest SMT thread number
>> and enable the SMT control by the end of topology parsing.
>>
>> The framework's SMT control provides two interface to the users [1]
>> through /sys/devices/system/cpu/smt/control:
>> 1) enable SMT by writing "on" and disable by "off"
>> 2) enable SMT by writing max_thread_number or disable by writing 1
>>
>> Both method support to completely disable/enable the SMT cores so both
>> work correctly for symmetric SMT platform and asymmetric platform with
>> non-SMT and one type SMT cores like:
>> core A: 1 thread
>> core B: X (X!=1) threads
>>
>> Note that for a theoretically possible multiple SMT-X (X>1) core
>> platform the SMT control is also supported as expected but only
>> by writing the "on/off" method.
> 
> Here we still have a little misunderstanding. IMHO, even on such a
> system 2) would work too.
> 


yes but only by writing the max_thread_number. e.g. a system with SMT number
of 1 (no SMT core), X, Y (Y > X), 1 works same as "off" and Y works same as
"on", as you shown below. write X will be blocked by the CPU framework:
estuary:/sys/devices/system/cpu/smt$ cat control
off
# emulated CPU 0-7,16-22 as SMT-2, CPU 8-11,24-27 as SMT-4
estuary:/sys/devices/system/cpu/smt$ cat ../online
0,2,4,6,8,12-16,18,20,22,24,28-31
estuary:/sys/devices/system/cpu/smt$ echo 2 > control
bash: echo: write error: Invalid argument
estuary:/sys/devices/system/cpu/smt$ echo 4 > control
estuary:/sys/devices/system/cpu/smt$ cat ../online
0-31

so method 1) will always match the expectation to fully enable/disable the
SMT on all cores, that's I mean here. But 2) won't work if user expected
to write 2 to enable SMT-2 (I think it'll will work if we support
CONFIG_SMT_NUM_THREADS_DYNAMIC on arm64 later).

Thanks.

> My qemu example with SMT-1, SMT-2 and SMT-4 in one system from your v11:
> 
> # cat /proc/schedstat | grep -v "^v\|^t" | awk '{print $1" "$2" "$3}'
> cpu0 0 0
> domain0 MC ff
> cpu1 0 0
> domain0 MC ff
> cpu2 0 0
> domain0 SMT 0c
> domain1 MC ff
> cpu3 0 0
> domain0 SMT 0c
> domain1 MC ff
> cpu4 0 0
> domain0 SMT f0
> domain1 MC ff
> cpu5 0 0
> domain0 SMT f0
> domain1 MC ff
> cpu6 0 0
> domain0 SMT f0
> domain1 MC ff
> cpu7 0 0
> domain0 SMT f0
> domain1 MC ff
> 
> # cat /proc/cpuinfo | grep ^processor
> processor	: 0
> processor	: 1
> processor	: 2
> processor	: 3
> processor	: 4
> processor	: 5
> processor	: 6
> processor	: 7
> 
> # echo 1 > /sys/devices/system/cpu/smt/control
> 
> # cat /proc/cpuinfo | grep ^processor
> processor	: 0
> processor	: 1
> processor	: 2
> processor	: 4
> 
> # echo 4 > /sys/devices/system/cpu/smt/control
> 
> # cat /proc/cpuinfo | grep ^processor
> processor	: 0
> processor	: 1
> processor	: 2
> processor	: 3
> processor	: 4
> processor	: 5
> processor	: 6
> processor	: 7
> 
> Whats doesn't work is to echoing a '2' but that's not
> 'max_thread_number' of the system.
> 
> [...]
> 
> .
> 

