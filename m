Return-Path: <linux-kernel+bounces-347996-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C28D98E148
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 18:58:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42C891F24790
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 16:58:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBA4C1D12E5;
	Wed,  2 Oct 2024 16:58:33 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19A221D0F73
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 16:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727888313; cv=none; b=capflpPoPtDdNzIxKMaI3v80QQvaCxIogWeTvsBS8+BajOW4B1AQi1G1l1lf940NQfZjPw2xOvR5otlrChpM39Ekif2T3Gt5C9RVUdBiLK/L02wUoZOJcRvL0wE2+jMwZ3Y1ZLwMOWj5psoZ1gFQLUbTJ3i5BjYTnUNsh34HJHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727888313; c=relaxed/simple;
	bh=CB0AbXpGl1WHZ7ACTIN/lUMgskP6tMtNgrlabTmHG0Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N3Y6D827A1uKPQ2OMyJziCZjbeyylZT3Cy4Kixa36i/TuNwIPMGu0qoX/XoF0kL6FtIpiiBFizNFpPFbXXXbK2ngKRXo3kjIbAWEs7nyjcMi2cVhTIqmXk2b0eFZ23tzxkXyBHqC+XYSCMxyomHw/FuU8P4kjneBZa284tZ4ijQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E8420339;
	Wed,  2 Oct 2024 09:58:59 -0700 (PDT)
Received: from [10.1.196.28] (eglon.cambridge.arm.com [10.1.196.28])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A48493F64C;
	Wed,  2 Oct 2024 09:58:26 -0700 (PDT)
Message-ID: <08375d83-623d-4baf-a0d9-10f7d31675cc@arm.com>
Date: Wed, 2 Oct 2024 17:58:26 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 20/39] x86/resctrl: Change
 mon_event_config_{read,write}() to be arch helpers
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
 Dave Martin <dave.martin@arm.com>
References: <20240802172853.22529-1-james.morse@arm.com>
 <20240802172853.22529-21-james.morse@arm.com>
 <3e85512d-2639-4713-93c3-212b94838938@intel.com>
From: James Morse <james.morse@arm.com>
In-Reply-To: <3e85512d-2639-4713-93c3-212b94838938@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Reinette,

On 14/08/2024 05:02, Reinette Chatre wrote:
> On 8/2/24 10:28 AM, James Morse wrote:
>> @@ -1617,14 +1612,15 @@ static void mon_event_config_read(void *info)
>>       mon_info->mon_config = msrval & MAX_EVT_CONFIG_BITS;
>>   }
>>   -static void mondata_config_read(struct rdt_mon_domain *d, struct mon_config_info
>> *mon_info)
>> +static void mondata_config_read(struct resctrl_mon_config_info *mon_info)
>>   {
>> -    smp_call_function_any(&d->hdr.cpu_mask, mon_event_config_read, mon_info, 1);
>> +    smp_call_function_any(&mon_info->d->hdr.cpu_mask,
>> +                  resctrl_arch_mon_event_config_read, mon_info, 1);
>>   }
>>     static int mbm_config_show(struct seq_file *s, struct rdt_resource *r, u32 evtid)
>>   {
>> -    struct mon_config_info mon_info = {0};
>> +    struct resctrl_mon_config_info mon_info = {0};
>>       struct rdt_mon_domain *dom;
>>       bool sep = false;
>>   
> 
> Patch looks good, just a fyi:
> https://lore.kernel.org/lkml/b2ebc809c8b6c6440d17b12ccf7c2d29aaafd488.1720868538.git.christophe.jaillet@wanadoo.fr

Right - I'll pick that as prerequisite so that it rebases out neatly.


Thanks,

James

