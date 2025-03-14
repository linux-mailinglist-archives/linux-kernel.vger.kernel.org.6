Return-Path: <linux-kernel+bounces-561370-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49355A61086
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 13:01:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D61F63AC8D3
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 12:01:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0B9B1FE467;
	Fri, 14 Mar 2025 12:01:05 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA6961FCFF4
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 12:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741953665; cv=none; b=p76N2/lq4gisWQKoukDOAm++NBSEAAXo0GeUnC6o95kxD/j/P8NqGsyBvq+vbAb1bTic0d58N0K+O7Pj0Z1ZrFImnTAivo+a85BVdSkwfsdsqOaIkJnY/NLQdXtST8iDt0wbDUpJcDwYdy2m7Rey4GdS/TnsYg/rp2xT7GPw8hA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741953665; c=relaxed/simple;
	bh=EriYMQyagqRVE0tpAeUCN5fug2JU7fMKoYvIaUDaQKs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iaFTGDsP82a07CEuplW/Ue1ybNDzNB8U1ReiHcUWOZnvkosDPj+Zkpxl0twCui1Ay4rtPjgYingxElUYPeZSDM4Ta/tGGA5kAU/3suz7Q9I4jONCyjPtE0iCzL2azXQT5i+S1stGdq1XelmwObh4zMwTIKDxjDwHjkVGqC4LPVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 09CD913D5;
	Fri, 14 Mar 2025 05:01:12 -0700 (PDT)
Received: from [10.1.197.49] (eglon.cambridge.arm.com [10.1.197.49])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 08BB33F5A1;
	Fri, 14 Mar 2025 05:00:53 -0700 (PDT)
Message-ID: <03b02d77-a9c6-4f36-9471-06713d8eec07@arm.com>
Date: Fri, 14 Mar 2025 12:00:50 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 44/49] x86/resctrl: Relax some asm #includes
To: Fenghua Yu <fenghuay@nvidia.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Cc: Reinette Chatre <reinette.chatre@intel.com>,
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
 Dave Martin <dave.martin@arm.com>, Koba Ko <kobak@nvidia.com>,
 Shanker Donthineni <sdonthineni@nvidia.com>
References: <20250228195913.24895-1-james.morse@arm.com>
 <20250228195913.24895-45-james.morse@arm.com>
 <d4bba1b8-2faa-4d9b-becf-f10011351652@nvidia.com>
Content-Language: en-GB
From: James Morse <james.morse@arm.com>
In-Reply-To: <d4bba1b8-2faa-4d9b-becf-f10011351652@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Fenghua,

On 07/03/2025 02:30, Fenghua Yu wrote:
> On 2/28/25 11:59, James Morse wrote:
>> From: Dave Martin<Dave.Martin@arm.com>
>>
>> checkpatch.pl identifies some direct #includes of asm headers that
>> can be satisfied by including the corresponding <linux/...> header
>> instead.
>>
>> Fix them.
>>
>> No intentional functional change.

> The commit message doesn't mention the rid initialization code changes?

That looks like another patch has been squashed in here - this was something Tony
identified as rid would be un-initialised if the rdt resource array grows behind x86's back.

[...]

> Other than that,
> 
> Reviewed-by: Fenghua Yu<fenghuay@nvidia.com>


Thanks,

James

