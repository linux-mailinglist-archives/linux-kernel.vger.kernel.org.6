Return-Path: <linux-kernel+bounces-539316-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FA3BA4A330
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 20:56:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 024CD189BF95
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 19:56:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37258230BDC;
	Fri, 28 Feb 2025 19:54:50 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74350230BF4
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 19:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740772489; cv=none; b=hBjFhKe5fDi4K3j44nhfTANIwGfIXb60BSRIb6urBZ0yXsvsN1B5wBCT9Y4yBQGIUGn2zJxec4ULyo4PRP73YsLTNkMKurALfKvmcZrMxxYPw/6eY2SFLM5c80YqPcDFaAo3PPZd3kZzZDo9+6wZKSN/jBQnfxxbsOQFUoYXipA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740772489; c=relaxed/simple;
	bh=k4oqHMt7bhQSo8lhZ/xMq5viiijBC28oKrfRRI+3wSw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SBRMcaCO/h+yM/SEtFv8lu6MVCsv0dhGzfnjdGvJ3eb4UM+TBB2TTMukWzhg9hPUBd0A+tdyorulxcaJjceQacYW/z1GQUf0wcpP64vnMQDrmbhEVBaSJbDNQhvAMF6QFjxXnI73NVLpy9KxG5Y58h/w75ueTlZas8/FvOiijzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 305BB1515;
	Fri, 28 Feb 2025 11:55:03 -0800 (PST)
Received: from [10.1.197.49] (eglon.cambridge.arm.com [10.1.197.49])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 907A33F5A1;
	Fri, 28 Feb 2025 11:54:43 -0800 (PST)
Message-ID: <31660de2-ac72-4513-9146-ff98acf132f1@arm.com>
Date: Fri, 28 Feb 2025 19:54:41 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 20/42] x86/resctrl: Change
 mon_event_config_{read,write}() to be arch helpers
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
 <20250207181823.6378-21-james.morse@arm.com>
 <5ecfe64b-d455-4291-b956-db5a47f83f4a@amd.com>
Content-Language: en-GB
From: James Morse <james.morse@arm.com>
In-Reply-To: <5ecfe64b-d455-4291-b956-db5a47f83f4a@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Babu,

On 27/02/2025 20:26, Moger, Babu wrote:
> On 2/7/25 12:18, James Morse wrote:
>> mon_event_config_{read,write}() are called via IPI and access model
>> specific registers to do their work.
>>
>> To support another architecture, this needs abstracting.
>>
>> Rename mon_event_config_{read,write}() to have a "resctrl_arch_"
>> prefix, and move their struct mon_config_info parameter into
>> <linux/resctrl.h>.  This allows another architecture to supply an
>> implementation of these.
>>
>> As struct mon_config_info is now exposed globally, give it a 'resctrl_'
>> prefix. MPAM systems need access to the domain to do this work, add
>> the resource and domain to struct resctrl_mon_config_info.

>> diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
>> index 5c7b9760b63a..59d944e139f8 100644
>> --- a/include/linux/resctrl.h
>> +++ b/include/linux/resctrl.h
>> @@ -270,6 +270,13 @@ struct resctrl_cpu_defaults {
>>  	u32 rmid;
>>  };
>>  
>> +struct resctrl_mon_config_info {
>> +	struct rdt_resource	*r;
>> +	struct rdt_mon_domain	*d;
>> +	u32			evtid;
>> +	u32			mon_config;
>> +};

> Isn't this architecture specific definition?  Why is this in common
> resctrl.h file.

Because mbm_config_write_domain() and mbm_config_show() need to pass this set of
information via IPI to another CPU to call resctrl_arch_mon_event_config_read() or
resctrl_arch_mon_event_config_write().

The definition can't belong to the arch code - otherwise it would have to be duplicated
across all architecture, and need the same members.

As much of the IPI-ing as possible is in the resctrl filesystem code, so that if we can
reduce them for one architecture, every architecture benefits.


Thanks,

James

