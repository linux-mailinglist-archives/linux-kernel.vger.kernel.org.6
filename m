Return-Path: <linux-kernel+bounces-514196-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 88747A353DD
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 02:44:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E35C16B443
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 01:44:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C1F578F41;
	Fri, 14 Feb 2025 01:44:17 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD89F7081C
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 01:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739497456; cv=none; b=qT4je7nJbZYRyt97w9qHIspr+0dONmkCnPR/y4cJbCiFKMZYc9VrE086BcaQG4GrzD0I2dHWdkGVoApviZSgTeM47NX55Ri8iglEULYG5YS2IcEbdAOIkwUMp2/UCqoZZbHtc491inzh+uBH+CYwWe5C8KY4vXD8NQDhWgUN0wA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739497456; c=relaxed/simple;
	bh=VR8vf/6dRANMYWHPwjOzYoHrgJpSIHn8Q8bbBWTN2Ms=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=KTXwp2VpX6eFM3nFswbvu1lv0z3pRXpkhqus+tqhZ0Ut5nLK2xh7ORTRM5aXz/DHbbQkncYV/g15CSFOPZT3r5bG2YlNCkMAFRVjoFJeWglTIt63lMfzxlbmiuRjJekf0enffdJ0ZyvAqdyXOmA3eRhZ2SW8uz0eynnWjBPETmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4YvF8m1vkrz11PdJ;
	Fri, 14 Feb 2025 09:39:36 +0800 (CST)
Received: from kwepemk500005.china.huawei.com (unknown [7.202.194.90])
	by mail.maildlp.com (Postfix) with ESMTPS id 9BD7F1800EA;
	Fri, 14 Feb 2025 09:44:05 +0800 (CST)
Received: from [10.174.179.234] (10.174.179.234) by
 kwepemk500005.china.huawei.com (7.202.194.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 14 Feb 2025 09:44:03 +0800
Message-ID: <df40840d-e860-397d-60bd-02f4b2d0b433@huawei.com>
Date: Fri, 14 Feb 2025 09:44:02 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v13 2/5] arm64: add support for ARCH_HAS_COPY_MC
To: Catalin Marinas <catalin.marinas@arm.com>
CC: Mark Rutland <mark.rutland@arm.com>, Jonathan Cameron
	<Jonathan.Cameron@huawei.com>, Mauro Carvalho Chehab
	<mchehab+huawei@kernel.org>, Will Deacon <will@kernel.org>, Andrew Morton
	<akpm@linux-foundation.org>, James Morse <james.morse@arm.com>, Robin Murphy
	<robin.murphy@arm.com>, Andrey Konovalov <andreyknvl@gmail.com>, Dmitry
 Vyukov <dvyukov@google.com>, Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>, Alexander Potapenko
	<glider@google.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, Aneesh
 Kumar K.V <aneesh.kumar@kernel.org>, "Naveen N. Rao"
	<naveen.n.rao@linux.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo
 Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
	<dave.hansen@linux.intel.com>, <x86@kernel.org>, "H. Peter Anvin"
	<hpa@zytor.com>, Madhavan Srinivasan <maddy@linux.ibm.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mm@kvack.org>,
	<linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
	<kasan-dev@googlegroups.com>, <wangkefeng.wang@huawei.com>, Guohanjun
	<guohanjun@huawei.com>
References: <20241209024257.3618492-1-tongtiangen@huawei.com>
 <20241209024257.3618492-3-tongtiangen@huawei.com> <Z6zKfvxKnRlyNzkX@arm.com>
From: Tong Tiangen <tongtiangen@huawei.com>
In-Reply-To: <Z6zKfvxKnRlyNzkX@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemk500005.china.huawei.com (7.202.194.90)



在 2025/2/13 0:21, Catalin Marinas 写道:
> (catching up with old threads)
> 
> On Mon, Dec 09, 2024 at 10:42:54AM +0800, Tong Tiangen wrote:
>> For the arm64 kernel, when it processes hardware memory errors for
>> synchronize notifications(do_sea()), if the errors is consumed within the
>> kernel, the current processing is panic. However, it is not optimal.
>>
>> Take copy_from/to_user for example, If ld* triggers a memory error, even in
>> kernel mode, only the associated process is affected. Killing the user
>> process and isolating the corrupt page is a better choice.
> 
> I agree that killing the user process and isolating the page is a better
> choice but I don't see how the latter happens after this patch. Which
> page would be isolated?

The SEA is triggered when the page with hardware error is read. After
that, the page is isolated in memory_failure() (mf). The processing of
mf is mentioned in the comments of do_sea().

/*
  * APEI claimed this as a firmware-first notification.
  * Some processing deferred to task_work before ret_to_user().
  */

Some processing include mf.

> 
>> Add new fixup type EX_TYPE_KACCESS_ERR_ZERO_MEM_ERR to identify insn
>> that can recover from memory errors triggered by access to kernel memory,
>> and this fixup type is used in __arch_copy_to_user(), This make the regular
>> copy_to_user() will handle kernel memory errors.
> 
> Is the assumption that the error on accessing kernel memory is
> transient? There's no way to isolate the kernel page and also no point
> in isolating the destination page either.

Yes, it's transient, the kernel page in mf can't be isolated, the
transient access (ld) of this kernel page is currently expected to kill
the user-mode process to avoid error spread.


The SEA processes synchronization errors. Only hardware errors on the
source page can be detected (Through synchronous ld insn) and processed.
The destination page cannot be processed.

> 

