Return-Path: <linux-kernel+bounces-539303-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 29A87A4A314
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 20:51:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0EE537AB1F3
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 19:50:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A43F230BE8;
	Fri, 28 Feb 2025 19:51:22 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79506230BF2
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 19:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740772282; cv=none; b=Jmpc3bu8MgXko8lNfvy1RkpLXeBMUhFfsX3jlpfxtOVYUCHSgsbHIOCC+G1M8jkFL4nopu2dFCdtId1EzZvMvnLEgVbBILqkeZQPNm07UyQKgp6wM0dHdi0OOth9S0YyNmhgPOm8SC9y4jbwNsZkYJzTyfSc5ZaQB3k4As5Pi9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740772282; c=relaxed/simple;
	bh=Fqhvk8ccwibMgl+QYB+mBj3Dt4JWxA+pcsAwJKDSwPY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XCwmrCnpnGjwOIdvv3XQHV7aYM9HD+2xXY4lLnvD8ai/GIXXFxlyt10ypEjTij6PqhkkImYatLdpV4nYJoATa4+E6J8WGjVjJSUNSQtUfz0K79VLRv6NF7SzWJ32NHfCL6k7jFQSF9rYHZDTIhdXyrgsLtcgiudcIZ/F1dKfe3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DD9D7176A;
	Fri, 28 Feb 2025 11:51:34 -0800 (PST)
Received: from [10.1.197.49] (eglon.cambridge.arm.com [10.1.197.49])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D86D53F5A1;
	Fri, 28 Feb 2025 11:51:14 -0800 (PST)
Message-ID: <60a1043d-014e-408c-a9a6-690f610ac609@arm.com>
Date: Fri, 28 Feb 2025 19:51:14 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 13/42] x86/resctrl: Move resctrl types to a separate
 header
To: Reinette Chatre <reinette.chatre@intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, H Peter Anvin <hpa@zytor.com>,
 Babu Moger <Babu.Moger@amd.com>, shameerali.kolothum.thodi@huawei.com,
 D Scott Phillips OS <scott@os.amperecomputing.com>,
 carl@os.amperecomputing.com, lcherian@marvell.com,
 bobo.shaobowang@huawei.com, tan.shaopeng@fujitsu.com,
 baolin.wang@linux.alibaba.com, Jamie Iles <quic_jiles@quicinc.com>,
 Xin Hao <xhao@linux.alibaba.com>, peternewman@google.com,
 dfustini@baylibre.com, amitsinght@marvell.com,
 David Hildenbrand <david@redhat.com>, Rex Nie <rex.nie@jaguarmicro.com>,
 Dave Martin <dave.martin@arm.com>, Koba Ko <kobak@nvidia.com>,
 Shanker Donthineni <sdonthineni@nvidia.com>,
 Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>, Tony Luck <tony.luck@intel.com>
References: <20250207181823.6378-1-james.morse@arm.com>
 <20250207181823.6378-14-james.morse@arm.com>
 <8ff43700-25f4-4606-ba99-3ed71721d9fe@intel.com>
Content-Language: en-GB
From: James Morse <james.morse@arm.com>
In-Reply-To: <8ff43700-25f4-4606-ba99-3ed71721d9fe@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Reinette,

On 19/02/2025 23:29, Reinette Chatre wrote:
> On 2/7/25 10:17 AM, James Morse wrote:
>> When resctrl is fully factored into core and per-arch code, each arch
>> will need to use some resctrl common definitions in order to define its
>> own specializations and helpers.  Following conventional practice, it
>> would be desirable to put the dependent arch definitions in an
>> <asm/resctrl.h> header that is included by the common <linux/resctrl.h>
>> header.  However, this can make it awkward to avoid a circular
>> dependency between <linux/resctrl.h> and the arch header.
>>
>> To avoid such dependencies, move the affected common types and
>> constants into a new header that does not need to depend on
>> <linux/resctrl.h> or on the arch headers.
>>
>> The same logic applies to the monitor-configuration defines, move these
>> too.
>>
>> Some kind of enumeration for events is needed between the filesystem
>> and architecture code. Take the x86 definition as its convenient for
>> x86.
>>
>> The definition of enum resctrl_event_id is needed to allow the
>> architecture code to define resctrl_arch_mon_ctx_alloc() and
>> resctrl_arch_mon_ctx_free().
>>
>> The definition of enum resctrl_res_level is needed to allow the
>> architecture code to define resctrl_arch_set_cdp_enabled() and
>> resctrl_arch_get_cdp_enabled().
>>
>> The bits for mbm_local_bytes_config et al are ABI, and must be the same
>> on all architectures. These are documented in
>> Documentation/arch/x86/resctrl.rst
>>
>> The maintainers entry for these headers was missed when resctrl.h was
>> created. Add a wildcard entry to match both resctrl.h and
>> resctrl_types.h.

>> diff --git a/include/linux/resctrl_types.h b/include/linux/resctrl_types.h
>> new file mode 100644
>> index 000000000000..51c51a1aabfb
>> --- /dev/null
>> +++ b/include/linux/resctrl_types.h
>> @@ -0,0 +1,54 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +/*
>> + * Copyright (C) 2024 Arm Ltd.
> 
> Please note year.

I've changed it.


[...]

> Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>


Thanks!

James

