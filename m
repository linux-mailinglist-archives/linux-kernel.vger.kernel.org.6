Return-Path: <linux-kernel+bounces-554192-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CA1ABA5945D
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 13:28:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6B043A90B4
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 12:27:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B854122759B;
	Mon, 10 Mar 2025 12:26:56 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 955BD226CE0
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 12:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741609616; cv=none; b=VNTCAf0vpTdLHpUAgt9zL0rysZrgNsSkHlE2Ne0qYSWUx4/gDDSaW8nwjciNCTcWsWQwAv/b3+VcDm/eXMp+bwsX8r+hNtzRQbM15YqMljTX9ejAFNi99biR4xivYjdOL7/lzzHbZ/Y5aRlxZLzGe3kCkHZZHeDSe59rn5PThXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741609616; c=relaxed/simple;
	bh=nNO62uba7Yc7GT4yXog5i2t6Pc1CFBWDADhe8JkdihE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DB9YB+gCdmxlxet4nom/ISAIrdWP4U8AaI/HQG/0pfukbu6WVJGofuT/QNYBg6cb4igHbYIi5KpXlgowMd00YlkYsPtL4+fIqHMrX2YSnBr9hEn7e/4AMEOLX5kfXdHdq5Qe/Ktxqe7eX0edUkH2m9+f+Z1wLgNOFKXJAOF+uHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 470D8153B;
	Mon, 10 Mar 2025 05:27:05 -0700 (PDT)
Received: from [10.1.197.49] (eglon.cambridge.arm.com [10.1.197.49])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9CD213F5A1;
	Mon, 10 Mar 2025 05:26:49 -0700 (PDT)
Message-ID: <0fe8b8be-d52b-4873-a4c5-a3b070190f2c@arm.com>
Date: Mon, 10 Mar 2025 12:26:46 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 19/49] x86/resctrl: Add
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
 Shanker Donthineni <sdonthineni@nvidia.com>, fenghuay@nvidia.com,
 Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>, Tony Luck <tony.luck@intel.com>
References: <20250228195913.24895-1-james.morse@arm.com>
 <20250228195913.24895-20-james.morse@arm.com>
 <cd48b81d-43df-4d46-9fff-caf0565f6a7e@intel.com>
Content-Language: en-GB
From: James Morse <james.morse@arm.com>
In-Reply-To: <cd48b81d-43df-4d46-9fff-caf0565f6a7e@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Reinette,

On 07/03/2025 04:37, Reinette Chatre wrote:
> On 2/28/25 11:58 AM, James Morse wrote:
>> When BMEC is supported the resctrl event can be configured in a number
>> of ways. This depends on architecture support. rdt_get_mon_l3_config()
>> modifies the struct mon_evt and calls mbm_config_rftype_init() to create
>> the files that allow the configuration.
>>
>> Splitting this into separate architecture and filesystem parts would
>> require the struct mon_evt and mbm_config_rftype_init() to be exposed.
> 
> Same comment as for v6 [1]:
> "Please replace all instances of mbm_config_rftype_init() with 
> resctrl_file_fflags_init()."

Ah - I didn't spot there was more than on in the commit message.
(and git-grep didn't bring it back either!)

Fixed.

>> Instead, add resctrl_arch_is_evt_configurable(), and use this from
>> resctrl_mon_resource_init() to initialise struct mon_evt and call
>> resctrl_file_fflags_init()
>> resctrl_arch_is_evt_configurable() calls rdt_cpu_has() so it doesn't
>> obviously benefit from being inlined. Putting it in core.c will allow
>> rdt_cpu_has() to eventually become static.
>>
>> Signed-off-by: James Morse <james.morse@arm.com>
>> Tested-by: Carl Worth <carl@os.amperecomputing.com> # arm64
>> Tested-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
>> Reviewed-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
>> Reviewed-by: Tony Luck <tony.luck@intel.com>
>> ---
>> Changes since v6:
>>  * Fixed stale function name in the commit message.
> Fixes seem to have been lost.
> 
> With changelog fixed:
> | Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>


Thanks!

James

