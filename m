Return-Path: <linux-kernel+bounces-538392-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E493A49817
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 12:10:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 285D31896A79
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 11:10:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8713261382;
	Fri, 28 Feb 2025 11:10:24 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3A52260A55
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 11:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740741024; cv=none; b=cjDGg0W9VxiSiy7vpgIw5KClLm+tcyRo70yXsN3G5GCTcVeC3GDIo7ln3At0OAbLpmyPlunr7mQkoUhZiS6uquFLOwnWGDkhpSxsxeTycBt6zEIJnTUT+20Saly5ZPkSH+FwgO6qzc9L0KxUW3eHwf8YjcdNqPAte7CkchBc1BY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740741024; c=relaxed/simple;
	bh=EwHq+liUc3GAcqGRVW5cVIrAlTjCC21CqW+WmjvVcJY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cseMxXqlnS9NUGn7CkpKFTQQUuR3SSreFGlOIiso8hOd+jsgHmjYtw13xreRzjdNVJ2Xti1mag8nEbsljUoKYF4U5tUOVs/ZyisZRzqcbsk0V4q7vtfWOKxwq9dNHniKfSvYiQJsmZLLs7Zv7ryeJw7iZpMr4diqQ+8SXS+fKSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5E20E1063;
	Fri, 28 Feb 2025 03:10:37 -0800 (PST)
Received: from [192.168.178.115] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9CC1F3F673;
	Fri, 28 Feb 2025 03:10:17 -0800 (PST)
Message-ID: <e3607ed0-bdf5-4fef-8731-b81fae649312@arm.com>
Date: Fri, 28 Feb 2025 12:10:15 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 1/4] cpu/SMT: Provide a default
 topology_is_primary_thread()
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
 <20250218141018.18082-2-yangyicong@huawei.com>
From: Dietmar Eggemann <dietmar.eggemann@arm.com>
Content-Language: en-US
In-Reply-To: <20250218141018.18082-2-yangyicong@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 18/02/2025 15:10, Yicong Yang wrote:
> From: Yicong Yang <yangyicong@hisilicon.com>

[...]

> diff --git a/include/linux/topology.h b/include/linux/topology.h
> index 52f5850730b3..b3aba443c4eb 100644
> --- a/include/linux/topology.h
> +++ b/include/linux/topology.h
> @@ -240,6 +240,28 @@ static inline const struct cpumask *cpu_smt_mask(int cpu)
>  }
>  #endif
>  
> +#ifndef topology_is_primary_thread
> +
> +#define topology_is_primary_thread topology_is_primary_thread
> +
> +static inline bool topology_is_primary_thread(unsigned int cpu)
> +{
> +	/*
> +	 * On SMT hotplug the primary thread of the SMT won't be disabled.
> +	 * Architectures do have a special primary thread (e.g. x86) need
> +	 * to override this function. Otherwise just make the first thread
> +	 * in the SMT as the primary thread.
> +	 *
> +	 * The sibling cpumask of an offline CPU contains always the CPU
> +	 * itself for architectures using CONFIG_GENERIC_ARCH_TOPOLOGY.
> +	 * Other architectures should use this depend on their own
> +	 * situation.

This sentence is hard to get. Do you want to say that other
architectures (CONFIG_GENERIC_ARCH_TOPOLOGY or
!CONFIG_GENERIC_ARCH_TOPOLOGY) have to check whether they can use this
default implementation or have to override it?

[...]

