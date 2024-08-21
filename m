Return-Path: <linux-kernel+bounces-295647-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29961959F95
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 16:20:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F2F61C21990
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 14:20:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 335FB1B1D59;
	Wed, 21 Aug 2024 14:20:17 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E27B1AF4ED
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 14:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724250016; cv=none; b=ilmz2N6yvAfi2qxvwFc2yHhmwckDe46pDzjnw4ZNBpgTcSwa1eNwiD7khYiSTpCC0uEF3xAvTirChpqQAQB7WT+USnwn4dD6dCa+SNjor4qlc5WMfBCQcPalc7MteW2wpi4GJL3Ep+JAMkRKq7P29S8UCpI8S6uPlZN4fZBjs5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724250016; c=relaxed/simple;
	bh=TlWvDYAusBiAmhPijDutAGNIxG7e35XShG6hDxIwGho=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=gAnU9sinwSK9wF7xWoP7dq5xPmYL+AMGxmfrQHvKhhu3zDlqXr2aENzb0xpwQ37xSJWMBmH6Xguppj8ucA3Gpb54W8QBViM5BejO/rIZOaf98od2uByclWL64Qr/Jr4TxpP5HgknQ08Qfo3fnQLzF1ubwMZTJ5pvCxXVeZfH2WU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4WppPW1s7qzcdVM;
	Wed, 21 Aug 2024 22:19:43 +0800 (CST)
Received: from kwepemm600017.china.huawei.com (unknown [7.193.23.234])
	by mail.maildlp.com (Postfix) with ESMTPS id 0C36E18009B;
	Wed, 21 Aug 2024 22:20:06 +0800 (CST)
Received: from [10.174.179.234] (10.174.179.234) by
 kwepemm600017.china.huawei.com (7.193.23.234) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 21 Aug 2024 22:20:03 +0800
Message-ID: <030ac65e-29cb-ea29-6728-e820bc188203@huawei.com>
Date: Wed, 21 Aug 2024 22:20:03 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v12 4/6] arm64: support copy_mc_[user]_highpage()
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
CC: Mark Rutland <mark.rutland@arm.com>, Catalin Marinas
	<catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Andrew Morton
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
	<hpa@zytor.com>, <linux-arm-kernel@lists.infradead.org>,
	<linux-mm@kvack.org>, <linuxppc-dev@lists.ozlabs.org>,
	<linux-kernel@vger.kernel.org>, <wangkefeng.wang@huawei.com>, Guohanjun
	<guohanjun@huawei.com>
References: <20240528085915.1955987-1-tongtiangen@huawei.com>
 <20240528085915.1955987-5-tongtiangen@huawei.com>
 <20240819125601.0000687b@Huawei.com>
 <8257d76b-c700-89a6-0e29-f194d2e1cd61@huawei.com>
 <20240821122848.00004047@Huawei.com>
From: Tong Tiangen <tongtiangen@huawei.com>
In-Reply-To: <20240821122848.00004047@Huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm600017.china.huawei.com (7.193.23.234)



在 2024/8/21 19:28, Jonathan Cameron 写道:
> On Tue, 20 Aug 2024 11:02:05 +0800
> Tong Tiangen <tongtiangen@huawei.com> wrote:
> 
>> 在 2024/8/19 19:56, Jonathan Cameron 写道:
>>> On Tue, 28 May 2024 16:59:13 +0800
>>> Tong Tiangen <tongtiangen@huawei.com> wrote:
>>>    
>>>> Currently, many scenarios that can tolerate memory errors when copying page
>>>> have been supported in the kernel[1~5], all of which are implemented by
>>>> copy_mc_[user]_highpage(). arm64 should also support this mechanism.
>>>>
>>>> Due to mte, arm64 needs to have its own copy_mc_[user]_highpage()
>>>> architecture implementation, macros __HAVE_ARCH_COPY_MC_HIGHPAGE and
>>>> __HAVE_ARCH_COPY_MC_USER_HIGHPAGE have been added to control it.
>>>>
>>>> Add new helper copy_mc_page() which provide a page copy implementation with
>>>> hardware memory error safe. The code logic of copy_mc_page() is the same as
>>>> copy_page(), the main difference is that the ldp insn of copy_mc_page()
>>>> contains the fixup type EX_TYPE_KACCESS_ERR_ZERO_ME_SAFE, therefore, the
>>>> main logic is extracted to copy_page_template.S.
>>>>
>>>> [1] commit d302c2398ba2 ("mm, hwpoison: when copy-on-write hits poison, take page offline")
>>>> [2] commit 1cb9dc4b475c ("mm: hwpoison: support recovery from HugePage copy-on-write faults")
>>>> [3] commit 6b970599e807 ("mm: hwpoison: support recovery from ksm_might_need_to_copy()")
>>>> [4] commit 98c76c9f1ef7 ("mm/khugepaged: recover from poisoned anonymous memory")
>>>> [5] commit 12904d953364 ("mm/khugepaged: recover from poisoned file-backed memory")
>>>>
>>>> Signed-off-by: Tong Tiangen <tongtiangen@huawei.com>
>>> Trivial stuff inline.
>>>
>>> Jonathan
>>
>> I'm sorry, I may not have understood what you meant. Where is the better
>> place to do inline? :)
> Oops. All I meant was:
> 
> My comments are inline - as in within the patch later in the email.
> 

OK, It's my fault for not getting your point :)

Thanks Jonathan.

> 
> 
> .

