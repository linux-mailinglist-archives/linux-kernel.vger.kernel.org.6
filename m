Return-Path: <linux-kernel+bounces-539332-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 82464A4A349
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 21:00:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 549B1189D5DF
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 20:00:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6B97280A28;
	Fri, 28 Feb 2025 19:57:51 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32867280A23
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 19:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740772671; cv=none; b=eCoZ/BTDTETaacRqYzZBe0cSf+9V/zJcWi+2g0J5HDaLe+HZx9kUT9KbTTfjr5BJgGxs56UMr46V6ujVXr3hrJVJ5ozfikSJnMzNroSn2u/RjY7QAR6HyrNJNTZg5lPjXFen7RI45tNlbc/9v6CNTl/5tFNCVdefmXTxB/54kXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740772671; c=relaxed/simple;
	bh=iXVqZMS1GLUClX1g5hN44gHC2ZgJOTI+JB3nSU38jQM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SzO4gqFoclD2M7w7xGFhIz+c6xUXLvST0EV7Rt1WQzZiSCxseBJTLdOqTPXCGhnAv7eB0lB4oo4sA+FcTG241qptGLU4sSbhrmilS0IcXFvCtSK7wwPHk1iGvyb7QZUMfEAu7e14AfSn68I1q/m9b68TCMome2PfW6FHjAvwrjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9C293176A;
	Fri, 28 Feb 2025 11:58:04 -0800 (PST)
Received: from [10.1.197.49] (eglon.cambridge.arm.com [10.1.197.49])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8CAA03F5A1;
	Fri, 28 Feb 2025 11:57:44 -0800 (PST)
Message-ID: <8b670ac8-af0f-4e38-a764-6790fa6956b0@arm.com>
Date: Fri, 28 Feb 2025 19:57:44 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 42/42] x86/resctrl: Add python script to move resctrl
 code to /fs/resctrl
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
 Shanker Donthineni <sdonthineni@nvidia.com>,
 Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>, Tony Luck <tony.luck@intel.com>
References: <20250207181823.6378-1-james.morse@arm.com>
 <20250207181823.6378-43-james.morse@arm.com>
 <c86d773c-75c4-4f7a-96e0-5f36768c3981@nvidia.com>
Content-Language: en-GB
From: James Morse <james.morse@arm.com>
In-Reply-To: <c86d773c-75c4-4f7a-96e0-5f36768c3981@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Fenghua,

On 25/02/2025 05:02, Fenghua Yu wrote:
> On 2/7/25 10:18, James Morse wrote:
>> To support more than one architecture resctrl needs to move from arch/x86
>> to live under fs. Moving all the code breaks any series on the mailing
>> list, so needs scheduling carefully.
>>
>> Maintaining the patch that moves all this code has proved labour intensive.
>> It's also near-impossible to review that no inadvertent changes have
>> crept in.
>>
>> To solve these problems, temporarily add a hacky python program that
>> lists all the functions that should move, and those that should stay.
>>
>> No attempt to parse C code is made, this thing tries to name 'blocks'
>> based on hueristics about the kernel coding style. It's fragile, but
>> good enough for its single use here.
>>
>> This only exists to show I have nothing up my sleeve.
>> I don't suggested this gets merged.
>>
>> The patch this script generaets has the following corner cases:
>> * The original files are regenerated, which will add newlines that are
>>    not present in the original file.
>> * An trace-point header file the only contains boiler-plate is created
>>    in the arch and filesystem code. The parser doesn't know how to remove
>>    the includes for these - but its easy to 'keep' the file contents on
>>    the correct side. A follow-up patch will remove these files and their
>>    includes.
> 
> Due to no trace event defined in the _trace.h files, compilation errors are reported when
> building kernel by W=1.
> 
> This patch seems the "follow-up" patch mentioned here? After this patch is applied, no
> more errors reported when W=1.

Yup, the follow up is here:
https://web.git.kernel.org/pub/scm/linux/kernel/git/morse/linux.git/commit/?h=mpam/snapshot/v6.14-rc1&id=3d0430324a0c7e7ad765140f9e78a9a312a13573

I thought this was harmless, but evidently kbuild doesn't like it.
I'll include all these in v7 - I suggest they get squashed into the generated patch once
they're reviewed.


Thanks,

James

