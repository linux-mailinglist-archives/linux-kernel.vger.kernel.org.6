Return-Path: <linux-kernel+bounces-517151-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F51EA37CC6
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 09:08:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 62DEF1889E84
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 08:08:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B3FC192D68;
	Mon, 17 Feb 2025 08:07:59 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E342136349
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 08:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739779678; cv=none; b=MKW9T9SggdPCllaK/9VFmBhGI9TRvHy0o6L8d91pYdbD7onUUKmyxiWUyRvTLV0DqfyX9PHNXIhTN3EK2jW+F7PpMMk9tlxCMLSNO10Z90zIB7b9XUSGrma0Q6xnO9LNrdI3Xkp/W7LUkoVDIys422rl7kvYoJNsHSEe0ff6Y8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739779678; c=relaxed/simple;
	bh=EQaw+cJURb/KBsY9Tf8T8aOUrILzNG++0oOiRHgT/JU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=RVo44f9AhSKuatav/M1gUkl88YNcXWdpIjC1hyPn0bv2Hp06OsvHRDRWt0Ux+AxuXH15u9fgIIE+YTAz9+voX2N1HGd0vbPcoZ3AOhx/o1jCSi74ubsXuCCdVEP6Gj/um5zGt9mEgNZyegMuAmfw42X3aqBRAKZR7pxEf8ouga8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4YxFXw2mFXz2JYY6;
	Mon, 17 Feb 2025 16:04:00 +0800 (CST)
Received: from kwepemk500005.china.huawei.com (unknown [7.202.194.90])
	by mail.maildlp.com (Postfix) with ESMTPS id 765EE1A0188;
	Mon, 17 Feb 2025 16:07:52 +0800 (CST)
Received: from [10.174.179.234] (10.174.179.234) by
 kwepemk500005.china.huawei.com (7.202.194.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 17 Feb 2025 16:07:50 +0800
Message-ID: <e1d2affb-5c6b-00b5-8209-34bbca36f96b@huawei.com>
Date: Mon, 17 Feb 2025 16:07:49 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v13 4/5] arm64: support copy_mc_[user]_highpage()
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
 <20241209024257.3618492-5-tongtiangen@huawei.com> <Z6zWSXzKctkpyH7-@arm.com>
 <69955002-c3b1-459d-9b42-8d07475c3fd3@huawei.com> <Z698SFVqHjpGeGC0@arm.com>
From: Tong Tiangen <tongtiangen@huawei.com>
In-Reply-To: <Z698SFVqHjpGeGC0@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemk500005.china.huawei.com (7.202.194.90)



在 2025/2/15 1:24, Catalin Marinas 写道:
> On Fri, Feb 14, 2025 at 10:49:01AM +0800, Tong Tiangen wrote:
>> 在 2025/2/13 1:11, Catalin Marinas 写道:
>>> On Mon, Dec 09, 2024 at 10:42:56AM +0800, Tong Tiangen wrote:
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
>>>> contains the fixup type EX_TYPE_KACCESS_ERR_ZERO_MEM_ERR, therefore, the
>>>> main logic is extracted to copy_page_template.S. In addition, the fixup of
>>>> MOPS insn is not considered at present.
>>>
>>> Could we not add the exception table entry permanently but ignore the
>>> exception table entry if it's not on the do_sea() path? That would save
>>> some code duplication.
>>
>> I'm sorry, I didn't catch your point, that the do_sea() and non do_sea()
>> paths use different exception tables?
> 
> No, they would have the same exception table, only that we'd interpret
> it differently depending on whether it's a SEA error or not. Or rather
> ignore the exception table altogether for non-SEA errors.

You mean to use the same exception type (EX_TYPE_KACCESS_ERR_ZERO) and
then do different processing on SEA errors and non-SEA errors, right?

If so, some instructions of copy_page() did not add to the exception
table will be added to the exception table, and the original logic will
be affected.

For example, if an instruction is not added to the exception table, the
instruction will panic when it triggers a non-SEA error. If this
instruction is added to the exception table because of SEA processing,
and then a non-SEA error is triggered, should we fix it?

Thanks,
Tong.

> 
>> My understanding is that the
>> exception table entry problem is fine. After all, the search is
>> performed only after a fault trigger. Code duplication can be solved by
>> extracting repeated logic to a public file.
> 
> If the new exception table entries are only taken into account for SEA
> errors, why do we need a duplicate copy_mc_page() function generated?
> Isn't the copy_page() and copy_mc_page() code identical (except for the
> additional labels to jump to for the exception)?
> 

