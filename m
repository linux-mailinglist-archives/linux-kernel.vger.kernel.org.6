Return-Path: <linux-kernel+bounces-544361-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A6AA3A4E05B
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 15:13:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5F1F188A255
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 14:11:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9A19204F78;
	Tue,  4 Mar 2025 14:11:02 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63C572046BD
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 14:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741097462; cv=none; b=R/OAacNYYWt+oRwtOiklwQYMRXrb3W/ik+ODYfCePH+/2AlkztQVoavjexaCm6oJrEAAxMra/f1059/6EI76ezNWwOYiKNVHK8X4vzGo8RJR9ZExHHR80r2E3jE0ffF9f2QpvowhOqXhDTseoNN+VvRLlgg1JDZT8ScEzRQPtH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741097462; c=relaxed/simple;
	bh=pdr2yxsFeONcEXQOLnAHfLtWh/hwVBDKivxBC4jE8Ow=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=uZqUXwQHHls+g07gVP6OYI/r+r+ysB3mMTEUQuMlX0d/sChXeqyP5M9HeCkA8wkacxiotCpKzm8XL4OQXxyA/7CHbeNB9ai0UgRBMWVro3NqYQuaM8L0AN/yHqnG3+oeyNcrOGYeFZfMLasgl2e3DEkt1VpQut13KhtfE6nsE1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Z6ctR2c3Gz1ltZw;
	Tue,  4 Mar 2025 22:06:39 +0800 (CST)
Received: from kwepemk500005.china.huawei.com (unknown [7.202.194.90])
	by mail.maildlp.com (Postfix) with ESMTPS id B226C1A0188;
	Tue,  4 Mar 2025 22:10:50 +0800 (CST)
Received: from [10.174.179.234] (10.174.179.234) by
 kwepemk500005.china.huawei.com (7.202.194.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 4 Mar 2025 22:10:48 +0800
Message-ID: <2c1fa758-c292-aefb-f6e2-cab41f592568@huawei.com>
Date: Tue, 4 Mar 2025 22:10:47 +0800
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
 <e1d2affb-5c6b-00b5-8209-34bbca36f96b@huawei.com> <Z7NN5Pa-c5PtIbcF@arm.com>
 <3b181285-2ff3-b77a-867b-725f38ea86d3@huawei.com> <Z7TisqB5qCIF5nYI@arm.com>
From: Tong Tiangen <tongtiangen@huawei.com>
In-Reply-To: <Z7TisqB5qCIF5nYI@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemk500005.china.huawei.com (7.202.194.90)

Hi,Catalin:

Kindly ping ...

Thanks.:)

在 2025/2/19 3:42, Catalin Marinas 写道:
> On Tue, Feb 18, 2025 at 07:51:10PM +0800, Tong Tiangen wrote:
>>>>>> 在 2025/2/13 1:11, Catalin Marinas 写道:
>>>>>>> On Mon, Dec 09, 2024 at 10:42:56AM +0800, Tong Tiangen wrote:
>>>>>>>> Currently, many scenarios that can tolerate memory errors when copying page
>>>>>>>> have been supported in the kernel[1~5], all of which are implemented by
>>>>>>>> copy_mc_[user]_highpage(). arm64 should also support this mechanism.
>>>>>>>>
>>>>>>>> Due to mte, arm64 needs to have its own copy_mc_[user]_highpage()
>>>>>>>> architecture implementation, macros __HAVE_ARCH_COPY_MC_HIGHPAGE and
>>>>>>>> __HAVE_ARCH_COPY_MC_USER_HIGHPAGE have been added to control it.
>>>>>>>>
>>>>>>>> Add new helper copy_mc_page() which provide a page copy implementation with
>>>>>>>> hardware memory error safe. The code logic of copy_mc_page() is the same as
>>>>>>>> copy_page(), the main difference is that the ldp insn of copy_mc_page()
>>>>>>>> contains the fixup type EX_TYPE_KACCESS_ERR_ZERO_MEM_ERR, therefore, the
>>>>>>>> main logic is extracted to copy_page_template.S. In addition, the fixup of
>>>>>>>> MOPS insn is not considered at present.
>>>>>>>
>>>>>>> Could we not add the exception table entry permanently but ignore the
>>>>>>> exception table entry if it's not on the do_sea() path? That would save
>>>>>>> some code duplication.
> [...]
>> So we need another way to distinguish the different processing of the
>> same exception type on SEA and non-SEA path.
> 
> Distinguishing whether the fault is SEA or non-SEA is already done by
> the exception handling you are adding. What we don't have though is
> information about whether the caller invoked copy_highpage() or
> copy_mc_highpage(). That's where the code duplication comes in handy.
> 
> It's a shame we need to duplicate identical functions just to have
> different addresses to look up in the exception table. We are also short
> of caller saved registers to track this information (e.g. an extra
> argument to those functions that the exception handler interprets).
> 
> I need to think a bit more, we could in theory get the arm64 memcpy_mc()
> to return an error code depending on what type of fault it got (e.g.
> -EHWPOISON for SEA, -EFAULT for non-SEA). copy_mc_highpage() would
> interpret this one and panic if -EFAULT. But we lose some fault details
> we normally get on a faulty access like some of the registers.
> 
> Well, maybe the simples is still to keep the function duplication. I'll
> have another look at the series tomorrow.
> 

