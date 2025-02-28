Return-Path: <linux-kernel+bounces-539302-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F2E7A4A313
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 20:51:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C807189415F
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 19:51:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58357230BE8;
	Fri, 28 Feb 2025 19:51:15 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42CE61EF395
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 19:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740772275; cv=none; b=HykqU8iRIySoI7QFv3SyiMoaSXWpgJBYAE7kaHoJz4FKeqcv9Qi870vwR5XW5Y8nx2M8KuucmsNR5Ern4meoOQiIcAvHVSx8EONPdUxnHcaV1XUKaJpJmUyMZb2wTMA4P3WGx+bVi4+VJCXufDBW51Bw84/P3ifwZq6WXq7iO8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740772275; c=relaxed/simple;
	bh=86HXAhtgWKW39kGCVqxCQEoCVTo64On54IjCyala9o4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pdG2AuKz8tzlJzkHKW58NFAckB/zpMZyXVG2jAcwkDQp6ns60Gqsa8lTMqjmZCtgiUZsNIZc/hettRFz2FcpEayhJFtCS4Q2ny8Y4S+q5yH0EQwDWmW8SsiJM8SAG9A1gUUlCoXjNbcT6QzIXHU9MN9B+OITbA0qXheaVHFYEts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9F9591515;
	Fri, 28 Feb 2025 11:51:27 -0800 (PST)
Received: from [10.1.197.49] (eglon.cambridge.arm.com [10.1.197.49])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 069F93F5A1;
	Fri, 28 Feb 2025 11:51:07 -0800 (PST)
Message-ID: <44cf4fb5-fa3f-42bc-ba16-46645495d669@arm.com>
Date: Fri, 28 Feb 2025 19:51:06 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 29/42] x86/resctrl: Move get_config_index() to a header
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
 <20250207181823.6378-30-james.morse@arm.com>
 <3749ab92-6f6e-43b4-8147-22775e31d21b@intel.com>
Content-Language: en-GB
From: James Morse <james.morse@arm.com>
In-Reply-To: <3749ab92-6f6e-43b4-8147-22775e31d21b@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Reinette,

On 20/02/2025 01:27, Reinette Chatre wrote:
> On 2/7/25 10:18 AM, James Morse wrote:
>> get_config_index() is used by the architecture specific code to map a
>> CLOSID+type pair to an index in the configuration arrays.
>>
>> MPAM needs to do this too to preserve the ABI to user-space, there is
>> no reason to do it differently.
>>
>> Move the helper to a header file.

>> --- a/include/linux/resctrl.h
>> +++ b/include/linux/resctrl.h
>> @@ -384,6 +384,21 @@ void resctrl_arch_mon_event_config_write(void *config_info);
>>   */
>>  void resctrl_arch_mon_event_config_read(void *config_info);
>>  
>> +/* For use by arch code to remap resctrl's smaller CDP CLOSID range */
>> +static inline u32 resctrl_get_config_index(u32 closid,
>> +					   enum resctrl_conf_type type)
>> +{
>> +	switch (type) {
>> +	default:
>> +	case CDP_NONE:
>> +		return closid;
>> +	case CDP_CODE:
>> +		return closid * 2 + 1;
>> +	case CDP_DATA:
>> +		return closid * 2;
>> +	}
>> +}
>> +

> Could you please add the motivation for the use of an inline function?

Putting this in the header file means it isn't duplicated, so its behaviour can't become
different. If its in a header file, it has to be marked inline otherwise every C file that
includes it gets a copy that probably isn't used, and upsets the linker.

Calling from the arch code into the filesystem prevents the arch code from being
standalone. This is a useful direction of travel because it allows fs/resctrl to one
day become a module

Today, the compiler is choosing to inline this:
| x86_64-linux-objdump -d ctrlmondata.o | grep resctrl_get_config_index | wc -l
| 0

This kind of arithmetic for an array lookup is the kind of thing its good to give the
compiler full visibility of as its good fodder for constant folding.

For so few call sites, I don't think this is really worth thinking about.
Forcing this call out of line makes the kernel text bigger, but only by 32 bytes.


I've expanded the last paragraph of the commit message to read:
| Move the helper to a header file to allow all architectures that either
| use or emulate CDP to use the same pattern of CLOSID values. Moving
| this to a header file means it must be marked inline, which matches
| the existing compiler choice for this static function.


Thanks,

James

