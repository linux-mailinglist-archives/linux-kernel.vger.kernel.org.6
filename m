Return-Path: <linux-kernel+bounces-214975-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83C1A908CD5
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 15:58:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1CD1428B11B
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 13:58:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63EE18F6A;
	Fri, 14 Jun 2024 13:58:21 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5709F1CAAC
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 13:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718373500; cv=none; b=ftlv44ZRPGAHPIG6HOMvZMx+I0+YF8fIcqw8XsB//D0D05UDDoldaJk0TPQXyAQFU98mlXur6lI6i3rWnps2SPd3laWylqhrbP++yVt3Z33Sf7VPmox2d7g1CzuqZuAFFQ5I34YDMlPCTo5BF+q78qy3ohkUhUujjBNrhCuCHdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718373500; c=relaxed/simple;
	bh=TPzSN2V5iRobz2v//rjtERo2shqj+YEzRbBKLVukUE4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L7WYIJ7mbU9lXWBIMlMp6wwL2i+BKb0UKZiMc1gXSUbIIT3Eq0vLx9cI+L1NHuQ2aB5u6lmIOEuKoEJGdNjWud/VGgOJceX6bMg1APbATrKXPgbCx9NwHz5OnFstIgEVwgshyqm6tBBxRD89bhhkjgvihWH9cgMAr8rIdWlGh04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7B39A1480;
	Fri, 14 Jun 2024 06:58:43 -0700 (PDT)
Received: from [10.1.196.28] (eglon.cambridge.arm.com [10.1.196.28])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 39DC83F5A1;
	Fri, 14 Jun 2024 06:58:15 -0700 (PDT)
Message-ID: <3b31aab6-a264-4ccb-aca3-f75be21741b8@arm.com>
Date: Fri, 14 Jun 2024 14:58:14 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 24/31] x86/resctrl: Move get_config_index() to a header
Content-Language: en-GB
To: Reinette Chatre <reinette.chatre@intel.com>,
 Dave Martin <Dave.Martin@arm.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org,
 Fenghua Yu <fenghua.yu@intel.com>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 H Peter Anvin <hpa@zytor.com>, Babu Moger <Babu.Moger@amd.com>,
 shameerali.kolothum.thodi@huawei.com,
 D Scott Phillips OS <scott@os.amperecomputing.com>,
 carl@os.amperecomputing.com, lcherian@marvell.com,
 bobo.shaobowang@huawei.com, tan.shaopeng@fujitsu.com,
 baolin.wang@linux.alibaba.com, Jamie Iles <quic_jiles@quicinc.com>,
 Xin Hao <xhao@linux.alibaba.com>, peternewman@google.com,
 dfustini@baylibre.com, amitsinght@marvell.com,
 David Hildenbrand <david@redhat.com>, Rex Nie <rex.nie@jaguarmicro.com>
References: <20240321165106.31602-1-james.morse@arm.com>
 <20240321165106.31602-25-james.morse@arm.com>
 <bfc39b79-b3bf-4187-ba63-56db1ed6d565@intel.com>
 <Zhfy3goUX8kWM5Hn@e133380.arm.com>
 <e3304a27-0c2c-4981-ae4c-01540c180628@intel.com>
From: James Morse <james.morse@arm.com>
In-Reply-To: <e3304a27-0c2c-4981-ae4c-01540c180628@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi guys,

On 11/04/2024 18:41, Reinette Chatre wrote:
> On 4/11/2024 7:25 AM, Dave Martin wrote:
>> On Mon, Apr 08, 2024 at 08:25:26PM -0700, Reinette Chatre wrote:
>>> On 3/21/2024 9:50 AM, James Morse wrote:
>>>> get_config_index() is used by the architecture specific code to map a
>>>> CLOSID+type pair to an index in the configuration arrays.
>>>>
>>>> MPAM needs to do this too to preserve the ABI to user-space, there is
>>>> no reason to do it differently.
>>>>
>>>> Move the helper to a header file.

>>>> diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
>>>> index 3de5bc63ace0..73c111963433 100644
>>>> --- a/include/linux/resctrl.h
>>>> +++ b/include/linux/resctrl.h
>>>> @@ -258,6 +258,21 @@ bool resctrl_arch_is_evt_configurable(enum resctrl_event_id evt);
>>>>  void resctrl_arch_mon_event_config_write(void *info);
>>>>  void resctrl_arch_mon_event_config_read(void *info);
>>>>  
>>>> +/* For use by arch code to remap resctrl's smaller CDP CLOSID range */
>>>> +static inline u32 resctrl_get_config_index(u32 closid,
>>>> +					   enum resctrl_conf_type type)
>>>> +{
>>>> +	switch (type) {
>>>> +	default:
>>>> +	case CDP_NONE:
>>>> +		return closid;
>>>> +	case CDP_CODE:
>>>> +			return (closid * 2) + 1;
>>>> +	case CDP_DATA:
>>>> +			return (closid * 2);
>>>> +	}
>>>> +}
>>>
>>> (please check the tabs)
>>
>> Noted.  I also see that redundant parentheses seem spuriously added
>> compared with the original version of this moved code.  I can make a
>> note to drop them if you prefer.
>>
>>> This change is unexpected to me. Could you please elaborate how
>>> MPAM's variant of CDP works?
>>>
>>> Thank you very much.
>>>
>>> Reinette
>>
>> Note: I haven't discussed this specifically with James, so the following
>> is my best guess at the rationale...  With that in mind:
>>
>> For MPAM, CDP isn't a special mode; instead, the PARTIDs for
>> instructions and data are always configured independently in the CPU.
>> If resctrl is not configured for CDP, we simply program the same PARTID
>> value both for instructions and data on task switch.
>>
>> For a given resctrl control group we could pick two random unrelated
>> PARTIDs, but there seems to be no advantage in doing that since resctrl
>> enables cdp globally or not, and we would require more effort to
>> translate resctrl closids to PARTIDs if we didn't pair the IDs up
>> systematically.
>>
>> (See [1], [2] in James' snapshot, which illustrate how he proposes
>> to do it.)
>>
>>
>> So, we may as well stick with the same scheme already established for
>> x86: nothing forces us to do that, but it looks simpler than the
>> alternatives.  I think that's the idea, anyway.
>>
>> Then, if the same scheme is used by multiple arches (and 100% of the
>> arches currently known to resctrl), it probably makes sense to share the
>> definition of the mapping at least as a default for arches that don't
>> have their own different ways of doing it.
>>
>> Does this make sense?
> 
> It does, thank you very much.

Thanks for the summary Dave - spot on!

There are some additional headaches for MPAM to provide the counters when CDP emulation is
enabled: because two CLOSID/PARTID are in use, two counters have to be allocated and read,
and their counters summed. This is all done behind the scenes in the MPAM driver.

MBA gets even more fun - as there is no MBA_CODE/MBA_DATA - but whatever MPAM is using to
back the MBA resource sees two CLOSID/PARTID. The result is the MPAM driver has to replay
configuration changes to the second CLOSID/PARTID. Again, this is done behind the scenes
in the MPAM driver.


(and as we're on this topic: I've had requests to make the counters available for code and
data separately - I don't intend to do this in resctrl as it wouldn't be portable to x86.
I'm looking at doing this with the perf pmu stuff)


Thanks,

James

