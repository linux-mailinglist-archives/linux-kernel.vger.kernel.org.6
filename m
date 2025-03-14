Return-Path: <linux-kernel+bounces-561372-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DA6DA61092
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 13:02:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4DED46329C
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 12:02:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E09AD1FE47E;
	Fri, 14 Mar 2025 12:01:22 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5CAC1F3B91
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 12:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741953682; cv=none; b=I6wcGpGuCQoGbsgPYAAKW+K0BaQ3F3ogL2nvMWeFgexknHbkyWE8IWuIdEbZLShx+xF4G7g7rdQ+4uPnBg2r4VRDDqEJ7O7Tv3t+vbId/IbzCp/N/IzWucykPbKz6Rxvm70iJ7kSzoPu+bLGXDf0Pxk5fkCHPr9zRjA27b1m1qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741953682; c=relaxed/simple;
	bh=vh5a+YITSE8CjY5awHsxyLKxNRGb06M7J9kdU3XRHTI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lGnSsU0STM5IpWENzZaqaay+RDzD3CuN/48G/emV7jBvYJiCRH9LgYqeYTPAPrSRGyGJAd6yBXLVn+WQdqvMRAXpETyrEm9quDRpdU5rbKLSQcCDgT4lwVACRBwJL2jQgoSVbx29bhxrNcxt9KKQRKqpEu1b7wZGpQYKSXF6llY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1F5F21756;
	Fri, 14 Mar 2025 05:01:30 -0700 (PDT)
Received: from [10.1.197.49] (eglon.cambridge.arm.com [10.1.197.49])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3F5753F5A1;
	Fri, 14 Mar 2025 05:01:15 -0700 (PDT)
Message-ID: <d6e9881b-8c29-468f-8d58-a81240cbdc27@arm.com>
Date: Fri, 14 Mar 2025 12:01:13 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 40/49] fs/resctrl: Add boiler plate for external
 resctrl code
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
References: <20250228195913.24895-1-james.morse@arm.com>
 <20250228195913.24895-41-james.morse@arm.com>
 <8cd265e2-fa14-46f4-a018-edfcf73f8a92@nvidia.com>
Content-Language: en-GB
From: James Morse <james.morse@arm.com>
In-Reply-To: <8cd265e2-fa14-46f4-a018-edfcf73f8a92@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Fenghua,

On 07/03/2025 02:16, Fenghua Yu wrote:
> On 2/28/25 11:59, James Morse wrote:
>> Add Makefile and Kconfig for fs/resctrl. Add ARCH_HAS_CPU_RESCTRL
>> for the common parts of the resctrl interface and make X86_CPU_RESCTRL
>> select this.
>>
>> Adding an include of asm/resctrl.h to linux/resctrl.h allows the
>> /fs/resctrl files to switch over to using this header instead.

>> diff --git a/fs/resctrl/pseudo_lock_trace.h b/fs/resctrl/pseudo_lock_trace.h
>> new file mode 100644
>> index 000000000000..e69de29bb2d1
> 
> If merge patch 45 and 46 together to fix the pseudo_lock_trace.h compilation fatal issue,
> it's unnecessary to create pseudo_lock_trace.h here (and then the empty
> pseudo_lock_trace.h file will be deleted later in merged patch 45).

Sure, I 'll try and remember to note that on the cover letter for whoever choses to squash
those patches together.


[..]

> Other than that,
> 
> Reviewed-by: Fenghua Yu <fenghua.yu@intel.com>


Thanks,

James

