Return-Path: <linux-kernel+bounces-514286-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 70CD2A35519
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 03:57:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 13A771891488
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 02:57:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 086F314F104;
	Fri, 14 Feb 2025 02:57:33 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B1D086333
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 02:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739501852; cv=none; b=ncnMSu3BRQH/s+T4hdXYiTgNPLMxWELcMtLujysDDCwuN8dwX4zKP//HwR+dQrXtbM4zqvNGhaORHC04dTVmXoYSPpK94bmQRCctkxTK0GPyT+55dK6SLTFOY4zJqc1MqcG56xBj8AanqJ80JP+ZbUUl/i/nhWwa0jHO+jgV4Yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739501852; c=relaxed/simple;
	bh=rhHX4w2bIdIvNHq7mUIhz5glXrbsuF6i3nNgvvduuWM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=BKcdRbyaxOiaLJiZBY2CHAgQbI47qrxUkaqoilxbmto/GzO7/PmjdrNXRwKMjoB21p+QNwO2W0KKtgpQ/Iv8esfvPUIXQbrFL33eUW0QAqL7bxQHygtidcIdjaHw0JLa0wtYnyHaJc1RNV5gef9erKRS5DlqpL6SeQ4YPhSenE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4YvGpC5pGcz2FdSY;
	Fri, 14 Feb 2025 10:53:39 +0800 (CST)
Received: from kwepemk500005.china.huawei.com (unknown [7.202.194.90])
	by mail.maildlp.com (Postfix) with ESMTPS id CA35F180044;
	Fri, 14 Feb 2025 10:57:27 +0800 (CST)
Received: from [10.174.179.234] (10.174.179.234) by
 kwepemk500005.china.huawei.com (7.202.194.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 14 Feb 2025 10:57:25 +0800
Message-ID: <ed9cfe20-98a6-64de-66cf-43b536035ae3@huawei.com>
Date: Fri, 14 Feb 2025 10:57:24 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v13 5/5] arm64: introduce copy_mc_to_kernel()
 implementation
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
 <20241209024257.3618492-6-tongtiangen@huawei.com> <Z6zX3Ro60sMH7C13@arm.com>
From: Tong Tiangen <tongtiangen@huawei.com>
In-Reply-To: <Z6zX3Ro60sMH7C13@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemk500005.china.huawei.com (7.202.194.90)



在 2025/2/13 1:18, Catalin Marinas 写道:
> On Mon, Dec 09, 2024 at 10:42:57AM +0800, Tong Tiangen wrote:
>> The copy_mc_to_kernel() helper is memory copy implementation that handles
>> source exceptions. It can be used in memory copy scenarios that tolerate
>> hardware memory errors(e.g: pmem_read/dax_copy_to_iter).
>>
>> Currently, only x86 and ppc support this helper, Add this for ARM64 as
>> well, if ARCH_HAS_COPY_MC is defined, by implementing copy_mc_to_kernel()
>> and memcpy_mc() functions.
>>
>> Because there is no caller-saved GPR is available for saving "bytes not
>> copied" in memcpy(), the memcpy_mc() is referenced to the implementation
>> of copy_from_user(). In addition, the fixup of MOPS insn is not considered
>> at present.
> 
> Same question as on the previous patch, can we not avoid the memcpy()
> duplication if the only difference is entries in the exception table?
> IIUC in patch 2 fixup_exception() even ignores the new type. The error
> must come on the do_sea() path.

As I said in commit message, it is not normalized with the memcpy()
because of the lack of GPR. If there is no GPR shortage problem, we can
extract the common code of memcpy_mc() and memcpy()，The unextracted
code is using different exception table entries.

Thanks,
Tong.

> 

