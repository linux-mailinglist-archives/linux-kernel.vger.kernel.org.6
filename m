Return-Path: <linux-kernel+bounces-539308-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 555BAA4A31C
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 20:54:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29A48189B740
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 19:54:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2566F230BE5;
	Fri, 28 Feb 2025 19:53:56 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B42D230BE3
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 19:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740772435; cv=none; b=LZdQ6sVwZxzKV6xlbQln2bz67+2Gp5G1scCFSZcTitTenTcYRIjQUUn2BaJMwi9S6DgErpgfZcpfCIAiKG32LrQGtG8WemeGuj65lCKvk9AfDNwJwqXoVkTjbEyVwNzVoN661Mh3f0cnoHfB9XwFy5a+SO91hiM1r3dFG2r9WQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740772435; c=relaxed/simple;
	bh=PT0CmNxTbwbN9/3CMG9XiWj5rQf9P9Dxk7rLquoAwLQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TbP63re8Cd4JGlMtOAMw4dwa3Ehip0Ooq3WKmTTYgy4X1P48FsawZ8VdCSM1QhWfJZ0OgKW32HPXQDb8fM9Nvw4+mkMyZrCXGywC7/Q7PFkCOcyDduG9ZotceL1OXo3/+GztXmGpZe5EAGfbqe5TIl1oX2mTKrPcDNnPylRf0Y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DD58E1515;
	Fri, 28 Feb 2025 11:54:08 -0800 (PST)
Received: from [10.1.197.49] (eglon.cambridge.arm.com [10.1.197.49])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 964313F5A1;
	Fri, 28 Feb 2025 11:53:47 -0800 (PST)
Message-ID: <17f0c99a-3e9b-487a-8f32-b3ce0ecbbfff@arm.com>
Date: Fri, 28 Feb 2025 19:53:43 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 02/42] x86/resctrl: Add a helper to avoid reaching into
 the arch code resource list
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
 <20250207181823.6378-3-james.morse@arm.com>
 <ecec8891-1228-4f03-841c-60fb4484c4d6@amd.com>
Content-Language: en-GB
From: James Morse <james.morse@arm.com>
In-Reply-To: <ecec8891-1228-4f03-841c-60fb4484c4d6@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Babu,

(please don't top post!)

On 27/02/2025 20:24, Moger, Babu wrote:
> On 2/7/25 12:17, James Morse wrote:
>> Resctrl occasionally wants to know something about a specific resource,
>> in these cases it reaches into the arch code's rdt_resources_all[]
>> array.
>>
>> Once the filesystem parts of resctrl are moved to /fs/, this means it
>> will need visibility of the architecture specific struct
>> rdt_hw_resource definition, and the array of all resources.  All
>> architectures would also need a r_resctrl member in this struct.
>>
>> Instead, abstract this via a helper to allow architectures to do
>> different things here. Move the level enum to the resctrl header and
>> add a helper to retrieve the struct rdt_resource by 'rid'.
>>
>> resctrl_arch_get_resource() should not return NULL for any value in
>> the enum, it may instead return a dummy resource that is
>> !alloc_enabled && !mon_enabled.


>  You probably missed few cases here.
>
> static int logical_rmid_to_physical_rmid(int cpu, int lrmid)
> {
>   struct rdt_resource *r = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
> --
>
> }
>
> Any reason not use the new call resctrl_arch_get_resource() here?

Simply there is no need to! That code doesn't get moved to /fs/, so it doesn't need to use
a helper. Taken to its extreme - after the code is moved to /fs/, there are no callers of
resctrl_arch_get_resource() in the arch code, because whatever they do today is sufficent.


Thanks,

James

