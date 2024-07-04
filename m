Return-Path: <linux-kernel+bounces-241428-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B446927B55
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 18:41:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25DD51F219B9
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 16:41:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F9EB1B3736;
	Thu,  4 Jul 2024 16:41:05 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 080671B29CF
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 16:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720111265; cv=none; b=tSf+BVo1QKIpu7Jbg8jG6Drugf/4fVUR8aG9kbId89lg25iXsgVlevo27eH166eUJLQmxKoTscFLf0SgJF9IH3HsJr1weEKnK93OqsgX88SasjBNKrGwZfQ55rYgknCVAESxqs3xnVCd6x55RdYhkNaiEWSr7rD0rPXzGh9M2bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720111265; c=relaxed/simple;
	bh=x0mYPNp3O6kl9zaCWmIZSSnuNSBtzwjBEKvI6Q1r1wA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=abcSw49sW778n79stxmHLb7rLFvWLYsVm/beV49dpXav3JFGkWC5YhLreMYT6LTBMhk8H5ouacgiSVLf6i49uVPo4sOZNm1w5UUfpBCFfYt8Cpd0Ans67M9W47RuaiABp55SDVas8jAxwYV4az6bYii+k21gZSAT3MWwfB4zyiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 318A2367;
	Thu,  4 Jul 2024 09:41:27 -0700 (PDT)
Received: from [10.1.196.28] (eglon.cambridge.arm.com [10.1.196.28])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9E3E63F762;
	Thu,  4 Jul 2024 09:40:58 -0700 (PDT)
Message-ID: <a7122237-969d-4757-8c93-af261a8d69d1@arm.com>
Date: Thu, 4 Jul 2024 17:40:56 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 36/38] fs/resctrl: Add boiler plate for external
 resctrl code
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
 <20240614150033.10454-37-james.morse@arm.com>
 <d7aa590e-7ad5-4eaa-9ea0-94322b802dd5@intel.com>
From: James Morse <james.morse@arm.com>
In-Reply-To: <d7aa590e-7ad5-4eaa-9ea0-94322b802dd5@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Reinette,

On 28/06/2024 17:54, Reinette Chatre wrote:
> On 6/14/24 8:00 AM, James Morse wrote:
>> Add Makefile and Kconfig for fs/resctrl. Add ARCH_HAS_CPU_RESCTRL
>> for the common parts of the resctrl interface and make X86_CPU_RESCTRL
>> depend on this.
>>
>> Adding an include of asm/resctrl.h to linux/resctrl.h allows some
>> of the files to switch over to using this header instead.


>> diff --git a/fs/resctrl/Kconfig b/fs/resctrl/Kconfig
>> new file mode 100644
>> index 000000000000..a5fbda54d32f
>> --- /dev/null
>> +++ b/fs/resctrl/Kconfig
>> @@ -0,0 +1,36 @@
>> +config RESCTRL_FS
>> +    bool "CPU Resource Control Filesystem (resctrl)"
>> +    depends on ARCH_HAS_CPU_RESCTRL
>> +    select KERNFS
>> +    select PROC_CPU_RESCTRL if PROC_FS
>> +    help
>> +      Some architectures provide hardware facilities to group tasks and
>> +      monitor and control their usage of memory system resources such as
>> +      caches and memory bandwidth.  Examples of such facilities include
>> +      Intel's Resource Director Technology (Intel(R) RDT) and AMD's
>> +      Platform Quality of Service (AMD QoS).
>> +
>> +      If your system has the necessary support and you want to be able to
>> +      assign tasks to groups and manipulate the associated resource
>> +      monitors and controls from userspace, say Y here to get a mountable
>> +      'resctrl' filesystem that lets you do just that.
>> +
>> +      If nothing mounts or prods the 'resctrl' filesystem, resource
>> +      controls and monitors are left in a quiescent, permissive state.
>> +
>> +      If unsure, it is safe to say N.
>> +
> 
> Will user ever get opportunity to say "Y" or "N"?
> It looks to me that
> RESCTRL_FS will be "forced" on user as it is selected by the arch specific
> config X86_CPU_RESCTRL and be invisble otherwise because of the dependency
> on ARCH_HAS_CPU_RESCTRL.

I did it like this so that this change is invisible for x86 config files on the principle
of 'least noise'. Users can't enable RDT but disable resctrl today.
It isn't actually possible to enable RDT and disable resctrl until after the code has been
split from the architecture code.

I have ended up supporting this for MPAM - you can enable the architecture's MPAM code and
the driver, but not resctrl. This will eventually be for in-kernel users of resources that
resctrl doesn't understand.


> The text about when to select "Y" or "N" thus does
> not look practical to me and it may be helpful to instead provide
> information about when it is selected? I do not know the customs for this
> text and if it is intended to document any future usages also.

I think Dave wrote this text because its traditional for Kconfig options to say this.

Describing when it is selected gets messy as this varies by architecture, and Kconfig can
already tell you this:
| Selected by [y]:
│   - X86_CPU_RESCTRL [=y] && X86 [=y] && (CPU_SUP_INTEL [=y] || CPU_SUP_AMD [=y]) &&
MISC_FILESYSTEMS [=y]

I don't think it makes sense for resctrl to be enabled/disabled independently on x86.
If you want to support this, we need a few more IS_ENABLED() checks and stubs to make it
build. The only reason I can see to do it is to ensure the architecture code is self
contained.

I'll reword this as "On architectures where this can be disabled independently, it is safe
to say N".


Thanks,

James

