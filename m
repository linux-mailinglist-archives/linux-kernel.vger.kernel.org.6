Return-Path: <linux-kernel+bounces-538395-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49C07A4981B
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 12:11:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E401173B85
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 11:11:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6A4C261571;
	Fri, 28 Feb 2025 11:11:40 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6017260A4B
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 11:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740741100; cv=none; b=LwmIwZhJgu6GKI7BQf1Vha+0HLym9NAx5jnYOq8x0Xd3U6jRCGfsE9/XV/0FQwH7fQNiyswLvH4jJau3hZM8YT9N8QkFenTo/YRl+STE2vDz1nLM6S7LO4RoWAv+RA7Kf/JCa4fZX3h5U/fJz3zUtDf8VuGEF6k41vIFC09aPRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740741100; c=relaxed/simple;
	bh=LwghInIiJv3rUCQoPyhDvX8M3lJOzIpKsT5j2vezUgo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tl3XZxbG/HaLTJ/fTO1bVxhh/F5Ah5TftgIgzerAf70dKtaplb7q3uFP0JFODHvqFYQXcOGIwCYSnvJk5sK9a7sq5LZrLJdemB2rGhYjMq1zWnT2UGnO9wFowwC9lDBtVt/OT6lyA3K1amL2Aj3FKVzAHt073oTLFudlvVvDRfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5C0951692;
	Fri, 28 Feb 2025 03:11:53 -0800 (PST)
Received: from [192.168.178.115] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A727A3F673;
	Fri, 28 Feb 2025 03:11:33 -0800 (PST)
Message-ID: <c8719fca-21a4-438e-8b9d-cd0418f135aa@arm.com>
Date: Fri, 28 Feb 2025 12:11:31 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 3/4] arm64: topology: Support SMT control on ACPI
 based system
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
 <20250218141018.18082-4-yangyicong@huawei.com>
From: Dietmar Eggemann <dietmar.eggemann@arm.com>
Content-Language: en-US
In-Reply-To: <20250218141018.18082-4-yangyicong@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 18/02/2025 15:10, Yicong Yang wrote:
> From: Yicong Yang <yangyicong@hisilicon.com>

[...]

> @@ -67,6 +108,31 @@ int __init parse_acpi_topology(void)
>  		cpu_topology[cpu].package_id = topology_id;
>  	}
>  
> +	/*
> +	 * This should be a short loop depending on the number of heterogeneous
                ^^^^^^

This _is_ a short loop since the number of xArray elements is the number
of heterogeneous CPU clusters.

> +	 * CPU clusters. Typically on a homogeneous system there's only one
                         ^^^^^^^^^

I would remove 'Typically' here.

[...]


