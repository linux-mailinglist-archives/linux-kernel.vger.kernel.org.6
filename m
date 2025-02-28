Return-Path: <linux-kernel+bounces-539328-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 01FAEA4A344
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 20:59:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0ED8C178F29
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 19:58:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F173627CCEB;
	Fri, 28 Feb 2025 19:57:17 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42885276044
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 19:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740772637; cv=none; b=rfJIYNQH1yMIt9YdBDmLGHliMpybFCwtCA5Y1gIywI4uWiHbjhy4A28ABujiag0R8/bzvb/jnBuQGV9RsQ0yOsnEj7+GIh2oLC+GqrkIqr1rmt7quusxbMjIG2ePoMsMIZHuB/d9LjhUfbc3bjWNEA0Cs+Kq0hmQuYKR5mf0V3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740772637; c=relaxed/simple;
	bh=btJbuDni26MIH0FoucvlP3QJeAkilzIT3P9E1Yas0KU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tpWrK3FgUE3p0Xm+cgNjSDJuPbNjQHOP+GnoXOllQe+UPPhDsmodSvDeaxQRt0q7b9JufUWNapHmYuGWHuUEAJEHXgg19WE6cegw6DQBHqZV7KKCtTKObkiu5gtayy31qUfgzKs7W4VPX6DMZRulnfwHImqXMk0pndy1hKZtsRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A4C47176A;
	Fri, 28 Feb 2025 11:57:30 -0800 (PST)
Received: from [10.1.197.49] (eglon.cambridge.arm.com [10.1.197.49])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9526B3F5A1;
	Fri, 28 Feb 2025 11:57:10 -0800 (PST)
Message-ID: <cc14a8a5-e2d0-4c10-b3b3-d44e061e1a7d@arm.com>
Date: Fri, 28 Feb 2025 19:56:21 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 19/42] x86/resctrl: Add
 resctrl_arch_is_evt_configurable() to abstract BMEC
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
 <20250207181823.6378-20-james.morse@arm.com>
 <bbbfd020-ee0d-42db-b055-f4056d63977e@intel.com>
Content-Language: en-GB
From: James Morse <james.morse@arm.com>
In-Reply-To: <bbbfd020-ee0d-42db-b055-f4056d63977e@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Reinette,

On 20/02/2025 00:13, Reinette Chatre wrote:
> On 2/7/25 10:18 AM, James Morse wrote:
>> When BMEC is supported the resctrl event can be configured in a number
>> of ways. This depends on architecture support. rdt_get_mon_l3_config()
>> modifies the struct mon_evt and calls mbm_config_rftype_init() to create
>> the files that allow the configuration.
>>
>> Splitting this into separate architecture and filesystem parts would
>> require the struct mon_evt and mbm_config_rftype_init() to be exposed.
>>
>> Instead, add resctrl_arch_is_evt_configurable(), and use this from
>> resctrl_mon_resource_init() to initialise struct mon_evt and call
>> mbm_config_rftype_init().
>> resctrl_arch_is_evt_configurable() calls rdt_cpu_has() so it doesn't
>> obviously benefit from being inlined. Putting it in core.c will allow
>> rdt_cpu_has() to eventually become static.

> Please replace all instances of mbm_config_rftype_init() with 
> resctrl_file_fflags_init().

Fixed, sorry I didn't spot that.


>> diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
>> index 7d14d80b3f94..43a9291988d3 100644
>> --- a/arch/x86/kernel/cpu/resctrl/core.c
>> +++ b/arch/x86/kernel/cpu/resctrl/core.c
>> @@ -831,6 +831,21 @@ bool __init rdt_cpu_has(int flag)
>>  	return ret;
>>  }
>>  
>> +bool __init resctrl_arch_is_evt_configurable(enum resctrl_event_id evt)

> I know resctrl is not consistent in this regard but I think that it would improve
> resctrl quality if new additions follow guidance from Documentation/process/coding-style.rst
> (see section 6.1) Function prototypes) to place storage class attribute
> (__init) before return type.

Done.


Thanks,

James

