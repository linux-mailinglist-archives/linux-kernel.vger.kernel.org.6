Return-Path: <linux-kernel+bounces-372086-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C7029A444F
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 19:07:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8ECAAB212D3
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 17:07:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96C9620402F;
	Fri, 18 Oct 2024 17:07:29 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74AD1204008
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 17:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729271249; cv=none; b=fjDAVDvkxyKXCeZsyUrR33twkd8d+OJoVJlTYhXVinpJRjz0f1tqJ1erDHSRTzcULhaUMiFxzmyCtkW9E78ZnO4cqjBFpoyLIjRLlUdQk+sjHc5XgxwhHbxdPUlORMV2x3p1C/bDuNnkn1MvOAc9EXXNlYceWx//7Qx0X7K+x8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729271249; c=relaxed/simple;
	bh=5AEdJkkdu7f7YcyRjgxgJ2/+GJhnxxrfLe0FK7Sgw0k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lXtXhN86S7VfPVFR5VKKts2PtLMDviGbGHKlHp257xVmQTS3WJuVlgKphIYg8o0AGIFAKLvhxYywM92ReBsmYBf9ZCF8MtHgwTUbIoIMfHWSXkyHJ0pHuJiOZz0xdexUeluHEjAa3trvJSrQyf8yynbMDamFpsBy1x89dE1zAgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 72A8C1477;
	Fri, 18 Oct 2024 10:07:56 -0700 (PDT)
Received: from [10.1.196.28] (eglon.cambridge.arm.com [10.1.196.28])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1080B3F917;
	Fri, 18 Oct 2024 10:07:21 -0700 (PDT)
Message-ID: <94cfdf5c-cd52-41c1-b5c3-7ac6b2f84f23@arm.com>
Date: Fri, 18 Oct 2024 18:07:18 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 02/40] x86/resctrl: Add a helper to avoid reaching into
 the arch code resource list
Content-Language: en-GB
To: Tony Luck <tony.luck@intel.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org,
 Fenghua Yu <fenghua.yu@intel.com>,
 Reinette Chatre <reinette.chatre@intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, H Peter Anvin <hpa@zytor.com>,
 Babu Moger <Babu.Moger@amd.com>, shameerali.kolothum.thodi@huawei.com,
 D Scott Phillips OS <scott@os.amperecomputing.com>,
 carl@os.amperecomputing.com, lcherian@marvell.com,
 bobo.shaobowang@huawei.com, tan.shaopeng@fujitsu.com,
 baolin.wang@linux.alibaba.com, Jamie Iles <quic_jiles@quicinc.com>,
 Xin Hao <xhao@linux.alibaba.com>, peternewman@google.com,
 dfustini@baylibre.com, amitsinght@marvell.com,
 David Hildenbrand <david@redhat.com>, Rex Nie <rex.nie@jaguarmicro.com>,
 Dave Martin <dave.martin@arm.com>, Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
References: <20241004180347.19985-1-james.morse@arm.com>
 <20241004180347.19985-3-james.morse@arm.com>
 <Zw7za0Cp0oH6v5w6@agluck-desk3.sc.intel.com>
From: James Morse <james.morse@arm.com>
In-Reply-To: <Zw7za0Cp0oH6v5w6@agluck-desk3.sc.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Tony,

On 15/10/2024 23:57, Tony Luck wrote:
> On Fri, Oct 04, 2024 at 06:03:09PM +0000, James Morse wrote:
>> +struct rdt_resource *resctrl_arch_get_resource(enum resctrl_res_level l)
>> +{
>> +	if (l >= RDT_NUM_RESOURCES)
>> +		return NULL;
>> +
>> +	return &rdt_resources_all[l].r_resctrl;
>> +}
> 
> Is this a bit fragile if someone adds a new item in enum resctrl_res_level
> but doesn't add a new entry to struct rdt_hw_resource rdt_resources_all[]
> in arch/x86/kernel/cpu/resctrl/core.c
> 
> Any caller of resctrl_arch_get_resource(new item name) will get past
> the check "if (l >= RDT_NUM_RESOURCES)" and then return a pointer past
> the end of the rdt_resources_all[] array.
> 
> Maybe make sure the array is padded out to the right size?
> 
> struct rdt_hw_resource rdt_resources_all[RDT_NUM_RESOURCES - 1] = {
> 	...
> };

Sure.

I was planning to do away with the 'must not return NULL' behaviour before extra resources
start appearing. It's done like this to avoid the churn when x86 supports 'all' the
resources anyway, buy you're right it can be less-churn and safer at the same time!


Thanks,

James

