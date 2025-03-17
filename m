Return-Path: <linux-kernel+bounces-563782-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C87AA6485A
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 10:57:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6AFB53AF135
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 09:56:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A6AB22ACE3;
	Mon, 17 Mar 2025 09:56:59 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FB1522A7F6
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 09:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742205419; cv=none; b=m/NDjzj95YW7LjE4fTvbWGilIwnB7cXjyL6p81eAtUz2wxv0gZuY9Obn+r85Wor014RUK2XozvvgZepWuJvwmn8P/aMSSEqByRjZ9a2+ELmV1k94+fqXyJRNpeRMMIbVCfOtvkydXHNX74109eAiXEFw+TrAxbMNC+pwlEx8UIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742205419; c=relaxed/simple;
	bh=eUlCUKwbGrEd9vqR6tSpiFv255TfkYQRVcmxg4Oowes=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NdIEIDKwxshBIdo5ThoyztgEBHE6hEHxIbij4ujYwsrE+48fcmVH/LOGUzUwqDQ15gTlCpvCzgdpbN8o3iq9bZgaoP5kFTLKPngEfUi48dkNXiPC7jUNgjKJoVJ/AibJWR01nfrmxwbrKWcni7KFXeDWS5sXdoMu1g4pLbAbC/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 34AF413D5;
	Mon, 17 Mar 2025 02:57:04 -0700 (PDT)
Received: from [172.18.154.215] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9AB1E3F673;
	Mon, 17 Mar 2025 02:56:48 -0700 (PDT)
Message-ID: <2bd3aa0a-d700-46bf-81d1-a5fb0364d1e0@arm.com>
Date: Mon, 17 Mar 2025 10:56:43 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 2/4] arch_topology: Support SMT control for OF based
 system
To: Yicong Yang <yangyicong@huawei.com>, catalin.marinas@arm.com,
 will@kernel.org, sudeep.holla@arm.com, tglx@linutronix.de,
 peterz@infradead.org, mpe@ellerman.id.au,
 linux-arm-kernel@lists.infradead.org, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, pierre.gondois@arm.com
Cc: linuxppc-dev@lists.ozlabs.org, x86@kernel.org,
 linux-kernel@vger.kernel.org, morten.rasmussen@arm.com, msuchanek@suse.de,
 gregkh@linuxfoundation.org, rafael@kernel.org, jonathan.cameron@huawei.com,
 prime.zeng@hisilicon.com, linuxarm@huawei.com, yangyicong@hisilicon.com,
 xuwei5@huawei.com, guohanjun@huawei.com, sshegde@linux.ibm.com
References: <20250311075143.61078-1-yangyicong@huawei.com>
 <20250311075143.61078-3-yangyicong@huawei.com>
From: Dietmar Eggemann <dietmar.eggemann@arm.com>
Content-Language: en-US
In-Reply-To: <20250311075143.61078-3-yangyicong@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/03/2025 08:51, Yicong Yang wrote:
> From: Yicong Yang <yangyicong@hisilicon.com>
> 
> On building the topology from the devicetree, we've already gotten the
> SMT thread number of each core. Update the largest SMT thread number
> and enable the SMT control by the end of topology parsing.
> 
> The framework's SMT control provides two interface to the users [1]
> through /sys/devices/system/cpu/smt/control:
> 1) enable SMT by writing "on" and disable by "off"
> 2) enable SMT by writing max_thread_number or disable by writing 1
> 
> Both method support to completely disable/enable the SMT cores so both
> work correctly for symmetric SMT platform and asymmetric platform with
> non-SMT and one type SMT cores like:
> core A: 1 thread
> core B: X (X!=1) threads
> 
> Note that for a theoretically possible multiple SMT-X (X>1) core
> platform the SMT control is also supported as expected but only
> by writing the "on/off" method.

Here we still have a little misunderstanding. IMHO, even on such a
system 2) would work too.

My qemu example with SMT-1, SMT-2 and SMT-4 in one system from your v11:

# cat /proc/schedstat | grep -v "^v\|^t" | awk '{print $1" "$2" "$3}'
cpu0 0 0
domain0 MC ff
cpu1 0 0
domain0 MC ff
cpu2 0 0
domain0 SMT 0c
domain1 MC ff
cpu3 0 0
domain0 SMT 0c
domain1 MC ff
cpu4 0 0
domain0 SMT f0
domain1 MC ff
cpu5 0 0
domain0 SMT f0
domain1 MC ff
cpu6 0 0
domain0 SMT f0
domain1 MC ff
cpu7 0 0
domain0 SMT f0
domain1 MC ff

# cat /proc/cpuinfo | grep ^processor
processor	: 0
processor	: 1
processor	: 2
processor	: 3
processor	: 4
processor	: 5
processor	: 6
processor	: 7

# echo 1 > /sys/devices/system/cpu/smt/control

# cat /proc/cpuinfo | grep ^processor
processor	: 0
processor	: 1
processor	: 2
processor	: 4

# echo 4 > /sys/devices/system/cpu/smt/control

# cat /proc/cpuinfo | grep ^processor
processor	: 0
processor	: 1
processor	: 2
processor	: 3
processor	: 4
processor	: 5
processor	: 6
processor	: 7

Whats doesn't work is to echoing a '2' but that's not
'max_thread_number' of the system.

[...]

