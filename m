Return-Path: <linux-kernel+bounces-275599-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F64A94877C
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 04:22:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C9A771F266D4
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 02:22:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A0EE4174C;
	Tue,  6 Aug 2024 02:19:29 +0000 (UTC)
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42FF3757EB
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 02:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722910769; cv=none; b=dOwlhMR/Z6QNw278TcNuYLgIYlu6ZCa1ERtzINPMZOg22XPo6IW1BYaApCms3TWXWOAdH7sxjDKxz04QJNbGdfh7ExGYAAkd7w0Y14+wL3Gky8jNoPIj5L3LHNjDdLSeJUANRrs3zuMrx004vk8X/k4K/R5rfeaY2ZTwm1UHAZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722910769; c=relaxed/simple;
	bh=SgCaGlYNwtKWWvSGFawFuAHR/Xo3DceOjircE0tpmyY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=jtWAYrZA6G4bT5mTb7Zk0j0B8satt0Tb+eyjYAx3q0CWYTGM+FmweKsHfzYGlUKNaYWOBRHLyVyhhEb6kwDvhUoljcz+hVtRp52UH0f9d3mPml4YYo2Sfu6XQV2Ag3gfo6Kp8E78cVE9AJYb9YT7Iv7BSaTKuW2/JUFI58HNAlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4WdH1k5m0mz1S75v;
	Tue,  6 Aug 2024 10:14:34 +0800 (CST)
Received: from kwepemi100008.china.huawei.com (unknown [7.221.188.57])
	by mail.maildlp.com (Postfix) with ESMTPS id 5E3911402CF;
	Tue,  6 Aug 2024 10:19:16 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 kwepemi100008.china.huawei.com (7.221.188.57) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 6 Aug 2024 10:19:15 +0800
Message-ID: <93bbedcd-2f6b-3124-6b54-01080efeb515@huawei.com>
Date: Tue, 6 Aug 2024 10:19:14 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [RFC PATCH] ARM: Support allocating crashkernel above 4G for LPAE
Content-Language: en-US
To: Catalin Marinas <catalin.marinas@arm.com>, "Russell King (Oracle)"
	<linux@armlinux.org.uk>
CC: <bhe@redhat.com>, <akpm@linux-foundation.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20240802092510.3915986-1-ruanjinjie@huawei.com>
 <Zqy8lwZM2Z6RlV5H@shell.armlinux.org.uk> <ZrDRCP9tyvXLfAYs@arm.com>
From: Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <ZrDRCP9tyvXLfAYs@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemi100008.china.huawei.com (7.221.188.57)



On 2024/8/5 21:18, Catalin Marinas wrote:
> On Fri, Aug 02, 2024 at 12:01:43PM +0100, Russell King wrote:
>> On Fri, Aug 02, 2024 at 05:25:10PM +0800, Jinjie Ruan wrote:
>>> As ARM LPAE feature support accessing memory beyond the 4G limit, define
>>> HAVE_ARCH_CRASHKERNEL_RESERVATION_HIGH macro to support reserving crash
> 
> At least in 6.11-rc1, there's no trace of such macro anywhere. So not
> sure this patch has any effect (I haven't checked linux-next though).

Sorry, this macro is introduced in linux-next, the -next subject has
been missed.

> 
>>> memory above 4G for ARM32 LPAE.
>>>
>>> No test because there is no LPAE ARM32 hardware.
>>
>> Why are you submitting patches for features you can't test?
>>
>> I'm not going to apply this without it being properly tested, because I
>> don't believe that this will work in the generic case.
>>
>> If the crash kernel is located in memory outside of the lower 4GiB of
>> address space, and there is no alias within physical address space
>> for that memory, then there is *no* *way* for such a kernel to boot.
>>
>> So, right now I believe this patch to be *fundamentally* wrong.
> 
> Indeed. Even on arm64, we keep some crashkernel reservations in the
> lower parts of the memory for ZONE_DMA allocations.

Indeed, it is.

> 
> On arch/arm with LPAE, we could do something similar like forcing some
> lowmem reservation and allowing explicit allocation in the higher ranges
> with crashkernel=<size>,high. We should, of course, force the kdump

In linux-next, with the HAVE_ARCH_CRASHKERNEL_RESERVATION_HIGH macro
defined, it is ok.

> image placement in the lower memory. The user kexec tools must be taught
> to interpret this information and provide a DT accordingly to the crash
> kernel.
> 

