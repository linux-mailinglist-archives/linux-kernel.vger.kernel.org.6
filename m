Return-Path: <linux-kernel+bounces-236802-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E0A3391E747
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 20:16:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94EB21F24987
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 18:16:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7417016F0CE;
	Mon,  1 Jul 2024 18:16:22 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EECCD2BB04
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 18:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719857782; cv=none; b=TIAvbZON1rZSbaw8Xvc/j13uumJxQI9PhGm4Z+K+EGaKL97yUtqgiXtC6uOn7GFRqXYJ1zf5OQSeKr4AL1iR6/DmYgXNvsrl4xauzoBQWF/58LjtH7jZaNecovp0zzBwrQR/ai3vCACt4a1gd+5VxnevZ4pDfsqkppqWBxJG8Vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719857782; c=relaxed/simple;
	bh=CjrV1G+UT5rLgq5JX+wY9MYiWLCNZnmYa9ZJptEsTWQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EApEeDux0UeZiTsl/uBZoK/p6ET3qHxslez/11PCHvzovyEBDxfvHuM69CJdlIDcT6h0+s62qvZdy5uJxJSO/EsB9dZ4cljJCaXDob6BC1LSTvdI8Qfw5f11EPFrfLDaCmx5UuGcEypsWMwsIj1TeP6pcAREgN581Bcty3Zbg4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 484A1367;
	Mon,  1 Jul 2024 11:16:44 -0700 (PDT)
Received: from [10.1.196.28] (eglon.cambridge.arm.com [10.1.196.28])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1E2073F766;
	Mon,  1 Jul 2024 11:16:15 -0700 (PDT)
Message-ID: <010781f9-94d1-4f6d-868b-9197adb7f45e@arm.com>
Date: Mon, 1 Jul 2024 19:16:15 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 13/38] x86/resctrl: Move resctrl types to a separate
 header
Content-Language: en-GB
To: Reinette Chatre <reinette.chatre@intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Cc: Fenghua Yu <fenghua.yu@intel.com>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 H Peter Anvin <hpa@zytor.com>, Babu Moger <Babu.Moger@amd.com>,
 shameerali.kolothum.thodi@huawei.com,
 D Scott Phillips OS <scott@os.amperecomputing.com>,
 carl@os.amperecomputing.com, lcherian@marvell.com,
 bobo.shaobowang@huawei.com, tan.shaopeng@fujitsu.com,
 baolin.wang@linux.alibaba.com, Jamie Iles <quic_jiles@quicinc.com>,
 Xin Hao <xhao@linux.alibaba.com>, peternewman@google.com,
 dfustini@baylibre.com, amitsinght@marvell.com,
 David Hildenbrand <david@redhat.com>, Rex Nie <rex.nie@jaguarmicro.com>,
 Dave Martin <dave.martin@arm.com>, Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
References: <20240614150033.10454-1-james.morse@arm.com>
 <20240614150033.10454-14-james.morse@arm.com>
 <0b51606b-2799-4d31-815d-d5f6f5f35047@intel.com>
From: James Morse <james.morse@arm.com>
In-Reply-To: <0b51606b-2799-4d31-815d-d5f6f5f35047@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Reinette,

On 28/06/2024 17:45, Reinette Chatre wrote:
> On 6/14/24 8:00 AM, James Morse wrote:
>> When resctrl is fully factored into core and per-arch code, each arch
>> will need to use some resctrl common definitions in order to define its
>> own specializations and helpers.  Following conventional practice, it
>> would be desirable to put the dependent arch definitions in an
>> <asm/resctrl.h> header that is included by the common <linux/resctrl.h>
>> header.  However, this can make it awkward to avoid a circular
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
>> The definition of enum resctrl_event_id is need to allow the architecture
> 
> "is need" -> "is needed" ?


>> code to define resctrl_arch_event_is_free_running(),
> 
> Cannot find resctrl_arch_event_is_free_running()

Sorry - this will show up after the MPAM driver:
{
	MPAM has an additional piece of hardware that needs to be allocated to read the
	memory bandwidth counters. resctrl expects these things to be pre-allocated and
	free running from the start of time.
	I have some patches to explicitly tell resctrl this, so that the resctrl interface
	to these things can be used by perf to query the 'mbm' counters, even if the files
	are not exposed.
}

>> resctrl_arch_set_cdp_enabled(), resctrl_arch_mon_ctx_alloc() and
> 
> resctrl_arch_set_cdp_enabled() should not need enum resctrl_event_id

Sorry, wrong list.


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

>> ---
>>   MAINTAINERS                            |  1 +
>>   arch/x86/kernel/cpu/resctrl/internal.h | 24 ------------
>>   include/linux/resctrl.h                | 21 +---------
>>   include/linux/resctrl_types.h          | 54 ++++++++++++++++++++++++++
> 
> Considering the motivation I also expected to see a change in
> arch/x86/include/asm/resctrl.h that adds the #include of the new file.

It gets added in a later patch - but I'll move it here.


Thanks,

James

