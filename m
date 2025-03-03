Return-Path: <linux-kernel+bounces-541944-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F7F0A4C3AD
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 15:43:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FC613A94F7
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 14:41:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21DE3212D66;
	Mon,  3 Mar 2025 14:41:54 +0000 (UTC)
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23FA62135B1
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 14:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741012913; cv=none; b=M/aWRM7N+kP81ijfjjCza+hEFZtO+h1zv0PyXFfSGUkeQ6XebMCOCKshy2UyJTJFATrSsvWDXOu4PkhwcwA8DPYu+bnF7L8ghe3fnYFhn/UxLqgBMPSWUSF1LmkvUQwDlXihowLoWE2EqRN6NPLLfznxD6DqNmABIQI1tVrtpp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741012913; c=relaxed/simple;
	bh=AAvWWqEDr0WGH+999KK83o05gjU61W8GibO8qYBWrME=;
	h=CC:Subject:To:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=VA1XdEvqKCYVVO3WgrUWTJyHj3+gWniQUdB2NPh6SihU5O3io7NajxTiJKvYBwFPKiYXovaDvgxIZAH8bKmv9Ep50mfalHSOTIp92mv9ATL3AWHTau8wfNI56MevBRfl/96MvB36YEzjU5XhLuTdM9+hINZu+eDCRkZWl48oSkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Z61bk3JkQz1GDnG;
	Mon,  3 Mar 2025 22:36:50 +0800 (CST)
Received: from kwepemd200014.china.huawei.com (unknown [7.221.188.8])
	by mail.maildlp.com (Postfix) with ESMTPS id 3EEF7180216;
	Mon,  3 Mar 2025 22:41:42 +0800 (CST)
Received: from [10.67.121.177] (10.67.121.177) by
 kwepemd200014.china.huawei.com (7.221.188.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Mon, 3 Mar 2025 22:41:41 +0800
CC: <yangyicong@hisilicon.com>, <linuxppc-dev@lists.ozlabs.org>,
	<x86@kernel.org>, <linux-kernel@vger.kernel.org>, <morten.rasmussen@arm.com>,
	<msuchanek@suse.de>, <gregkh@linuxfoundation.org>, <rafael@kernel.org>,
	<jonathan.cameron@huawei.com>, <prime.zeng@hisilicon.com>,
	<linuxarm@huawei.com>, <xuwei5@huawei.com>, <guohanjun@huawei.com>,
	<sshegde@linux.ibm.com>
Subject: Re: [PATCH v11 0/4] Support SMT control on arm64
To: Dietmar Eggemann <dietmar.eggemann@arm.com>, <catalin.marinas@arm.com>,
	<will@kernel.org>, <sudeep.holla@arm.com>, <tglx@linutronix.de>,
	<peterz@infradead.org>, <mpe@ellerman.id.au>,
	<linux-arm-kernel@lists.infradead.org>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <pierre.gondois@arm.com>
References: <20250218141018.18082-1-yangyicong@huawei.com>
 <df9784c3-c2ea-4bac-839a-2b7de0a81aac@arm.com>
From: Yicong Yang <yangyicong@huawei.com>
Message-ID: <6d83cc41-7759-c0a2-6695-01f98923ed5d@huawei.com>
Date: Mon, 3 Mar 2025 22:41:40 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <df9784c3-c2ea-4bac-839a-2b7de0a81aac@arm.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemd200014.china.huawei.com (7.221.188.8)

On 2025/2/28 19:12, Dietmar Eggemann wrote:
> On 18/02/2025 15:10, Yicong Yang wrote:
>> From: Yicong Yang <yangyicong@hisilicon.com>
>>
>> The core CPU control framework supports runtime SMT control which
>> is not yet supported on arm64. Besides the general vulnerabilities
>> concerns we want this runtime control on our arm64 server for:
>>
>> - better single CPU performance in some cases
>> - saving overall power consumption
>>
>> This patchset implements it in the following aspects:
>>
>> - Provides a default topology_is_primary_thread()
>> - support retrieve SMT thread number on OF based system
>> - support retrieve SMT thread number on ACPI based system
>> - select HOTPLUG_SMT for arm64
>>
>> Tests has been done on our ACPI based arm64 server and on ACPI/OF
>> based QEMU VMs.
> 
> [...]
> 
>> Yicong Yang (4):
>>   cpu/SMT: Provide a default topology_is_primary_thread()
>>   arch_topology: Support SMT control for OF based system
>>   arm64: topology: Support SMT control on ACPI based system
>>   arm64: Kconfig: Enable HOTPLUG_SMT
>>
>>  arch/arm64/Kconfig                  |  1 +
>>  arch/arm64/kernel/topology.c        | 66 +++++++++++++++++++++++++++++
>>  arch/powerpc/include/asm/topology.h |  1 +
>>  arch/x86/include/asm/topology.h     |  2 +-
>>  drivers/base/arch_topology.c        | 27 ++++++++++++
>>  include/linux/topology.h            | 22 ++++++++++
>>  6 files changed, 118 insertions(+), 1 deletion(-)
> 
> With the review comments on the individual patches [0-3]/4:

will fix.

> 
> Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
> 

Thanks.


