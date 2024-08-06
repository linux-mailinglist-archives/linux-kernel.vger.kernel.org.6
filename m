Return-Path: <linux-kernel+bounces-275625-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D18A69487B3
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 04:46:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96A0D285D60
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 02:46:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18DACF9DF;
	Tue,  6 Aug 2024 02:46:09 +0000 (UTC)
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E7D115C3
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 02:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722912368; cv=none; b=q8XmnohbWDNkV1TKcKSm1Jnsg5rMMtZe9T5q9XWMZkzqROJ5Bnf2jlT5LgJ29W/7eUcyu2l/iessr3wBQJuXSjcEChclu/vvbK4F3VNfR90JnEYw4nGmNwy4Lu47D93dcg/OrmpykV9GSf8linPIuptUIJUgmEpxlS/scwNLnZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722912368; c=relaxed/simple;
	bh=ZWUMU+GP/fiCBh1hl7IAEHeQ/2X55SjxTrADVU5DJt8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=UW2+Bo6/C2HRripVcPJqoY45Q46/zm8AIb36oen1f281MTgFRR1txA7R2hJ8Z86FauMmFtA3FEfnFhM6jpyAKleF2oqEpcl4nRJDoghVRWjub2qppr2UAZ8kwxVZjNBqqXg2vfW7FvL1un6wjbqn/jdA/NX/PurfnSp+WaPlolc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4WdHcc44m2z1S721;
	Tue,  6 Aug 2024 10:41:20 +0800 (CST)
Received: from kwepemi100008.china.huawei.com (unknown [7.221.188.57])
	by mail.maildlp.com (Postfix) with ESMTPS id 2AFE51A016C;
	Tue,  6 Aug 2024 10:46:02 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 kwepemi100008.china.huawei.com (7.221.188.57) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 6 Aug 2024 10:46:01 +0800
Message-ID: <8f051483-46be-87b6-03bb-5e0d145a2ac3@huawei.com>
Date: Tue, 6 Aug 2024 10:46:00 +0800
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
To: Baoquan He <bhe@redhat.com>
CC: "Russell King (Oracle)" <linux@armlinux.org.uk>,
	<akpm@linux-foundation.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
References: <20240802092510.3915986-1-ruanjinjie@huawei.com>
 <Zqy8lwZM2Z6RlV5H@shell.armlinux.org.uk>
 <6c0a45c3-08a2-f889-9e66-ab8aff66ae8c@huawei.com>
 <ZrA/QWAy2iXl/Oc4@MiWiFi-R3L-srv>
From: Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <ZrA/QWAy2iXl/Oc4@MiWiFi-R3L-srv>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemi100008.china.huawei.com (7.221.188.57)



On 2024/8/5 10:56, Baoquan He wrote:
> On 08/05/24 at 09:23am, Jinjie Ruan wrote:
>>
>>
>> On 2024/8/2 19:01, Russell King (Oracle) wrote:
>>> On Fri, Aug 02, 2024 at 05:25:10PM +0800, Jinjie Ruan wrote:
>>>> As ARM LPAE feature support accessing memory beyond the 4G limit, define
>>>> HAVE_ARCH_CRASHKERNEL_RESERVATION_HIGH macro to support reserving crash
>>>> memory above 4G for ARM32 LPAE.
>>>>
>>>> No test because there is no LPAE ARM32 hardware.
>>>
>>> Why are you submitting patches for features you can't test?
>>>
>>> I'm not going to apply this without it being properly tested, because I
>>> don't believe that this will work in the generic case.
>>>
>>> If the crash kernel is located in memory outside of the lower 4GiB of
>>> address space, and there is no alias within physical address space
>>> for that memory, then there is *no* *way* for such a kernel to boot.
>>
>> I'm sorry that I released this patch without testing it. I actually
>> intended to bring up this issue for discussion. If anyone has the
>> environment to test it, that would be great. In the meantime, we could
>> have a discussion on the significance and relevance of this approach.
> 
> I don't know arm32 and its LPAE. I know a little about x86_32 where
> crashkernel can only be reserved below 896M because of the virtual
> memory layout, and all memory above that is high memory which can't be
> used as kernel memory directly. So from this patch, arm32 is different
> than x86_32.

Hi，Baoquan

Does the following code make sense? Now parse_crashkernel() use
HAVE_ARCH_CRASHKERNEL_RESERVATION_HIGH macro to parse "high", but use
CONFIG_64BIT when reserving "low" memory in reserve_crashkernel_low().

And when LPAE is enabled in ARM32, and "high" is reserved,
reserve_crashkernel_low() need also function ok.

--- a/kernel/crash_reserve.c
+++ b/kernel/crash_reserve.c
@@ -354,7 +354,7 @@ early_param("crashkernel", parse_crashkernel_dummy);
 #ifdef CONFIG_ARCH_HAS_GENERIC_CRASHKERNEL_RESERVATION
 static int __init reserve_crashkernel_low(unsigned long long low_size)
 {
-#ifdef CONFIG_64BIT
+#ifdef HAVE_ARCH_CRASHKERNEL_RESERVATION_HIGH
        unsigned long long low_base;


> 
>>
>>>
>>> So, right now I believe this patch to be *fundamentally* wrong.
>>>
>>
> 
> 

