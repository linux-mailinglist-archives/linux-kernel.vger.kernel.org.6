Return-Path: <linux-kernel+bounces-538397-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B3FDA49821
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 12:12:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2DA391896789
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 11:12:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A9B425D209;
	Fri, 28 Feb 2025 11:12:19 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCDE826038A
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 11:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740741139; cv=none; b=HnlY4vU3wqYRS9WSmftuD+iqkZgt5SI3dujUeej0+xnBFdFlZkwyaQv9fMm1Y1vs4VBM4H2xNqCpKByyfn+GWLx/oEgf+HpW58XuFbwDMbXaFqjsjfCNKfMxeDcvXuWvjBWznlszO32kqVSRhkKV4a0a9UrR43tcfgxyIj1KosU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740741139; c=relaxed/simple;
	bh=9lQ103/GC3slcRVO1G6NpdTptAg8raUxv7XB6+kJ7bE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fuf/guWDVlas4ESiLgvUEoOsevmOLvqdVGSXkkdjkAEo9JGo8vG6z0S1nq5Ge5H/zi2ZwzGMVZPpIchmuLx+y2H07s1hr6Ub7bzPc+3DIjGy9PeMEJySZTtYoFdXWXmi8mnN13YQDL1Bmk3vYI095m5u+7Ax9hGuG/dCkp9iFn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4566D1063;
	Fri, 28 Feb 2025 03:12:32 -0800 (PST)
Received: from [192.168.178.115] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 92FD63F673;
	Fri, 28 Feb 2025 03:12:12 -0800 (PST)
Message-ID: <df9784c3-c2ea-4bac-839a-2b7de0a81aac@arm.com>
Date: Fri, 28 Feb 2025 12:12:02 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 0/4] Support SMT control on arm64
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
References: <20250218141018.18082-1-yangyicong@huawei.com>
From: Dietmar Eggemann <dietmar.eggemann@arm.com>
Content-Language: en-US
In-Reply-To: <20250218141018.18082-1-yangyicong@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 18/02/2025 15:10, Yicong Yang wrote:
> From: Yicong Yang <yangyicong@hisilicon.com>
> 
> The core CPU control framework supports runtime SMT control which
> is not yet supported on arm64. Besides the general vulnerabilities
> concerns we want this runtime control on our arm64 server for:
> 
> - better single CPU performance in some cases
> - saving overall power consumption
> 
> This patchset implements it in the following aspects:
> 
> - Provides a default topology_is_primary_thread()
> - support retrieve SMT thread number on OF based system
> - support retrieve SMT thread number on ACPI based system
> - select HOTPLUG_SMT for arm64
> 
> Tests has been done on our ACPI based arm64 server and on ACPI/OF
> based QEMU VMs.

[...]

> Yicong Yang (4):
>   cpu/SMT: Provide a default topology_is_primary_thread()
>   arch_topology: Support SMT control for OF based system
>   arm64: topology: Support SMT control on ACPI based system
>   arm64: Kconfig: Enable HOTPLUG_SMT
> 
>  arch/arm64/Kconfig                  |  1 +
>  arch/arm64/kernel/topology.c        | 66 +++++++++++++++++++++++++++++
>  arch/powerpc/include/asm/topology.h |  1 +
>  arch/x86/include/asm/topology.h     |  2 +-
>  drivers/base/arch_topology.c        | 27 ++++++++++++
>  include/linux/topology.h            | 22 ++++++++++
>  6 files changed, 118 insertions(+), 1 deletion(-)

With the review comments on the individual patches [0-3]/4:

Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>


