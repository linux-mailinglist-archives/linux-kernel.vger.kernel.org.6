Return-Path: <linux-kernel+bounces-539314-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 30647A4A32E
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 20:55:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 10F0B189BC89
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 19:55:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BD9327FE8A;
	Fri, 28 Feb 2025 19:54:24 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFBC727CCFA
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 19:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740772464; cv=none; b=PbqeLYZfYyR6zg/0fdCi+YwuYrw0GOz4TIS9FEXE3/AgTOgAq/fOdm+gqnQCsCRuhIdY+DtdBBh7Hfr+duH/GtQZq8h4hWR9kKiPXD8cufRo94a33ybbzlJQ5dfW9ghrr6K2sYrwFbTiXlgOo+mSWnZAqX7Q9ZaAOw/qZ60S7TI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740772464; c=relaxed/simple;
	bh=cQTD7AHJFzhpv6PTG4Mn9jzyhPbu8/ICaJ3ZeWRB2G0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cQmtp1y5zFjwZLzYNHWrJgiytb1qBm8wH0wwr9nOkRNGas5i0n5aEIRsC98OaCftxnQQT+p2KzY9wgLUBPVKMg2J+HYFQqgkA613Bro/MBagv3Eh+gkEItdcEM68Mramc8ThIfpMVywM+bpKKD8RKa/+XG0/YLHIpaqfUYJBhUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8B7611515;
	Fri, 28 Feb 2025 11:54:37 -0800 (PST)
Received: from [10.1.197.49] (eglon.cambridge.arm.com [10.1.197.49])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6B3053F5A1;
	Fri, 28 Feb 2025 11:54:14 -0800 (PST)
Message-ID: <9aeff0c8-d207-42e8-a678-e6d10356d189@arm.com>
Date: Fri, 28 Feb 2025 19:54:06 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 10/42] x86/resctrl: Remove rdtgroup from
 update_cpu_closid_rmid()
To: babu.moger@amd.com, x86@kernel.org, linux-kernel@vger.kernel.org
Cc: Reinette Chatre <reinette.chatre@intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, H Peter Anvin <hpa@zytor.com>,
 shameerali.kolothum.thodi@huawei.com,
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
 <20250207181823.6378-11-james.morse@arm.com>
 <08d74c2f-29d8-4fd4-8f03-48c093ef7b61@amd.com>
Content-Language: en-GB
From: James Morse <james.morse@arm.com>
In-Reply-To: <08d74c2f-29d8-4fd4-8f03-48c093ef7b61@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Babu,

On 27/02/2025 20:25, Moger, Babu wrote:
> On 2/7/25 12:17, James Morse wrote:
>> update_cpu_closid_rmid() takes a struct rdtgroup as an argument, which
>> it uses to update the local CPUs default pqr values. This is a problem
>> once the resctrl parts move out to /fs/, as the arch code cannot
>> poke around inside struct rdtgroup.
>>
>> Rename update_cpu_closid_rmid() as resctrl_arch_sync_cpus_defaults()
>> to be used as the target of an IPI, and pass the effective CLOSID
>> and RMID in a new struct.

>> diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
>> index a939c0cec7fe..da3b344d06d3 100644
>> --- a/include/linux/resctrl.h
>> +++ b/include/linux/resctrl.h
>> @@ -266,6 +266,28 @@ struct resctrl_schema {
>>  	u32				num_closid;
>>  };
>>  
>> +struct resctrl_cpu_defaults {
>> +	u32 closid;
>> +	u32 rmid;
>> +};
>> +
> 
> Can you please explain why this is part of resctrl.h?
> 
> Isn't this part of architecture specific definition?

update_closid_rmid() builds an on-stack copy of this, then IPIs each CPU to call
resctrl_arch_sync_cpu_closid_rmid(). Because of the IPI resctrl would need to invent an
identical structure.
If the filesystem and arch code use of this diverge it may be necessary to duplicate them,
(or declare one inside another), but its not needed today.


Thanks,

James

