Return-Path: <linux-kernel+bounces-397619-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D2E29BDE21
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 06:03:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E7A91F24460
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 05:03:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F891190493;
	Wed,  6 Nov 2024 05:03:41 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 762F517BB1C
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 05:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730869421; cv=none; b=g/AnXCXwV17W2FTy7FwAP6HIemkl/sSuL9vet10PWX80aph2Thll/FDSMPYTI7Nz3dcRurm+/JbgyrruoLQ03t8rSkY3rGjttz4ikkM8tzVW1OZys/amPSNQ17j4LH4zAHRJGEprGK7169kGKw/G2NWo7Ff1y9wY8FVzqRYvKhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730869421; c=relaxed/simple;
	bh=bq1za7JtQZ4gRMhjsjBaZQE1Z4KeDoExvNUwrU5CbWk=;
	h=Subject:To:References:Cc:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=fF+6UpJzVme1gnExKQJRRE9pD2cEH3L78uk6z1rHLU/Uv+965oKuGM0ffG23RSQTHbnGTDBTcXiLhmrEDJVXINcieIEjYTqiLuOx183ipucI1XXiJGiGEO3bEZ72YS1icgy92QXwEwAQJCm6rmPJQK70yPeT844puSmcer7WsLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8AxbeKo+CpnU5IzAA--.37583S3;
	Wed, 06 Nov 2024 13:03:36 +0800 (CST)
Received: from [10.130.0.149] (unknown [113.200.148.30])
	by front1 (Coremail) with SMTP id qMiowMDxvken+Cpn0N1EAA--.59848S3;
	Wed, 06 Nov 2024 13:03:35 +0800 (CST)
Subject: Re: [PATCH v2 5/5] LoongArch: Enable jump table with GCC for objtool
To: Peter Zijlstra <peterz@infradead.org>
References: <20241105123906.26072-1-yangtiezhu@loongson.cn>
 <20241105123906.26072-6-yangtiezhu@loongson.cn>
 <20241105141530.GE10375@noisy.programming.kicks-ass.net>
Cc: Huacai Chen <chenhuacai@kernel.org>, Josh Poimboeuf
 <jpoimboe@kernel.org>, loongarch@lists.linux.dev,
 linux-kernel@vger.kernel.org
From: Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <62df4c24-68ed-fbfc-ed98-2df796697d89@loongson.cn>
Date: Wed, 6 Nov 2024 13:03:34 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20241105141530.GE10375@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:qMiowMDxvken+Cpn0N1EAA--.59848S3
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoW7Aw17AFyxKFWfXrWfWr4DGFX_yoW8WFWxpF
	yDGrZ7Kan5XFn7KrZrJw4Ikas0yrZ7Jr48WrsrKr1kAw4rZw42qa1IkanF9a4Duw13JF4I
	yFWxKr9xCw12yacCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUvFb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27w
	Aqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE
	14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1c
	AE67vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8C
	rVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtw
	CIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x02
	67AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr
	0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxU7_Ma
	UUUUU

On 11/05/2024 10:15 PM, Peter Zijlstra wrote:
> On Tue, Nov 05, 2024 at 08:39:06PM +0800, Tiezhu Yang wrote:
>> For now, it is time to remove the compiler option -fno-jump-tables
>> to enable jump table for objtool if the compiler is GCC and it has
>> the compiler option -mannotate-tablejump, otherwise still keep the
>> compiler option -fno-jump-tables to maintain compatibility with the
>> older compilers.

...

>>
>>  ifdef CONFIG_OBJTOOL
>> +ifdef CONFIG_CC_IS_GCC
>> +ifdef CONFIG_CC_HAS_ANNOTATE_TABLEJUMP
>> +KBUILD_CFLAGS			+= $(call cc-option,-mannotate-tablejump)
>> +else
>>  KBUILD_CFLAGS			+= -fno-jump-tables
>>  endif
>> +endif
>> +ifdef CONFIG_CC_IS_CLANG
>> +KBUILD_CFLAGS			+= -fno-jump-tables
>> +endif
>> +endif
>
> This seems excessive. Why split between GCC and Clang, isn't
> CC_HAS_ANNOTATE_JUMPTABLE sufficient?

Thanks for your reply.

In theory, it is sufficient to only check CC_HAS_ANNOTATE_JUMPTABLE
to use -fno-jump-tables or not, and also this is my initial aim.

In fact, when compling with Clang on LoongArch, if the compiler has
the option -mannotate-tablejump and config CC_HAS_ANNOTATE_TABLEJUMP
is set, there still exists some objtool warnings if remove the option
-fno-jump-tables, this is because there are some special cases such
as different rodata relocation type and rodata entry size generated
by Clang, I am working in progress to address the corner issues, and
the final code looks something like this:

ifdef CONFIG_CC_HAS_ANNOTATE_TABLEJUMP
KBUILD_CFLAGS                   += $(call cc-option,-mannotate-tablejump)
else
KBUILD_CFLAGS                   += -fno-jump-tables
endif

Thanks,
Tiezhu


