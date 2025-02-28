Return-Path: <linux-kernel+bounces-539330-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D63CA4A348
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 20:59:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C9360189D7B1
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 19:59:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67326230BFC;
	Fri, 28 Feb 2025 19:57:36 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8344230BF1
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 19:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740772656; cv=none; b=K+kIaSLaOsKXqJUM6DRirO3fr53FYsu62zHo2uSGL6aQZm7iSW4Iyhj/MYitnlQtuPtvkUXMtjV4o95HWexAaK7Hyh3o6xe+ZJBgx8DpG76cAPl8DK/3XxRYAVzHylBNXOd3kEKzU5tm2uDya71O07hF8H6W6mvbUxEvxxgZ9qI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740772656; c=relaxed/simple;
	bh=1d7dLm9lvOeTfheTIPgrr5OtAUKSbtdDXtylxiWsR/Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Jk4axknGZfC+WUV+JWmD8e9RzWkh3n5U5zqtd6OEaaH9mDSRVogGeQ5dSjDuG6DulAnAVdwXnvWJBw79nHVBHTdpwcgzNgk0h6ViQv+pHigjwsbojP+5IQb0LaPLgf/rdrbqQt9CGjrx2SM5BR5LnMhDMjv0JtEoIL2zmvBRXDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 73C681515;
	Fri, 28 Feb 2025 11:57:49 -0800 (PST)
Received: from [10.1.197.49] (eglon.cambridge.arm.com [10.1.197.49])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8AEA33F5A1;
	Fri, 28 Feb 2025 11:57:28 -0800 (PST)
Message-ID: <e0ac8b22-ba7e-4a99-8cc7-9a324f05ebcd@arm.com>
Date: Fri, 28 Feb 2025 19:57:26 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 41/42] x86/resctrl: Move the filesystem bits to headers
 visible to fs/resctrl
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
 <20250207181823.6378-42-james.morse@arm.com>
 <44fc5a31-43d8-413d-b938-638294a1e096@intel.com>
Content-Language: en-GB
From: James Morse <james.morse@arm.com>
In-Reply-To: <44fc5a31-43d8-413d-b938-638294a1e096@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Reinette,

On 20/02/2025 06:00, Reinette Chatre wrote:
> On 2/7/25 10:18 AM, James Morse wrote:
>> Once the filesystem parts of resctrl move to fs/resctrl, it cannot rely
>> on definitions in x86's internal.h.
>>
>> Move definitions in internal.h that need to be shared between the
>> filesystem and architecture code to header files that fs/resctrl can
>> include.
>>
>> Doing this separately means the filesystem code only moves between files
>> of the same name, instead of having these changes mixed in too.

>> diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
>> index 6303c0ee0ae2..f2cd7ba39fcc 100644
>> --- a/arch/x86/kernel/cpu/resctrl/core.c
>> +++ b/arch/x86/kernel/cpu/resctrl/core.c
>> @@ -288,6 +288,11 @@ static void rdt_get_cdp_l2_config(void)
>>  	rdt_get_cdp_config(RDT_RESOURCE_L2);
>>  }
>>  
>> +bool resctrl_arch_get_cdp_enabled(enum resctrl_res_level l)
>> +{
>> +	return rdt_resources_all[l].cdp_enabled;
>> +}
>> +
> 
> This moves resctrl_arch_get_cdp_enabled() to arch/x86/kernel/cpu/resctrl/core.c
> while resctrl_arch_set_cdp_enabled() is already in arch/x86/kernel/cpu/resctrl/rdtgroup.c.
> Most of resctrl_arch_get_cdp_enabled()'s callers are 
> in arch/x86/kernel/cpu/resctrl/rdtgroup.c so it seems appropriate to keep it with
> its partner resctrl_arch_set_cdp_enabled()?

Yup - that would make more sense.
(This will date back to when I was moving the code around by hand every release!)


Thanks,

James

