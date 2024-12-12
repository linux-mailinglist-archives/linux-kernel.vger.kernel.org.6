Return-Path: <linux-kernel+bounces-442459-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0687A9EDD1B
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 02:34:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5116C28322A
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 01:34:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B08081ADA;
	Thu, 12 Dec 2024 01:34:34 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D69C57CBE
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 01:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733967273; cv=none; b=IndBl4A28N75hQRkW7S3NKv5Alq2QuNP6w8C9a3RhmNrwYfAtrNWNz8Mu1YBlLCHVnFHuPwzPuyf6IcyOtzyw/xmj6nL5nu2dYSigYgzNwfrWP1Y/fVkqXmUWfI+6hHzVOS8P0CtmdlOTLIbNThVTGU60iMDoYctAFogSHidDm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733967273; c=relaxed/simple;
	bh=HKMGL1rl+Cnji1XVOHgCwdmVL0KJzhUvbGKxYFcBkwQ=;
	h=Subject:To:References:Cc:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=LAyzMeNu1xVv2z3JvWTn4oHOny0yIntdqDXuAf/VQEmss792Tk8CickX+/XbG5hdqSYriZM/DpESeEfGYmcoCcKCE0Tjl2Sy87yVWtu0PO5mkegBGxqiQ6q33gTKylp3+376U4dV7J2TVzSqPnFRH+0YEgdoII88VQfqdE6n80U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8CxMK+jPVpnrehVAA--.11962S3;
	Thu, 12 Dec 2024 09:34:27 +0800 (CST)
Received: from [10.130.0.149] (unknown [113.200.148.30])
	by front1 (Coremail) with SMTP id qMiowMCxbUegPVpnyx2AAA--.8551S3;
	Thu, 12 Dec 2024 09:34:24 +0800 (CST)
Subject: Re: [PATCH v5 03/10] objtool: Handle PC relative relocation type
To: Josh Poimboeuf <jpoimboe@kernel.org>
References: <20241207015915.1159-1-yangtiezhu@loongson.cn>
 <20241207015915.1159-4-yangtiezhu@loongson.cn>
 <20241209203544.axetpzva7vg3hsc5@jpoimboe>
 <9d14c8fa-d61d-bd12-efd7-5a17f4f8cb35@loongson.cn>
 <20241212003526.2kutif7m2svtbp6l@jpoimboe>
Cc: Huacai Chen <chenhuacai@kernel.org>, Peter Zijlstra
 <peterz@infradead.org>, loongarch@lists.linux.dev,
 linux-kernel@vger.kernel.org
From: Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <91b079a1-4f0f-8017-cdae-f6e2729d72a3@loongson.cn>
Date: Thu, 12 Dec 2024 09:34:24 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20241212003526.2kutif7m2svtbp6l@jpoimboe>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:qMiowMCxbUegPVpnyx2AAA--.8551S3
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoW7Kw17WryUWFWUJF17tr1DurX_yoW8XF43pF
	WqgrZrtFs8Jas2gwsFqw4vqFyru3ykJas8Gr90kr1xAw15Xw1rKaykK3y5Ka4UGr10yw1I
	va1Igw1UGF4DJ3cCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUBjb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	Gr0_Gr1UM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYI
	kI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUXVWU
	AwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMx
	k0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_
	Gr1l4IxYO2xFxVAFwI0_JF0_Jw1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67
	AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8I
	cVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI
	8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v2
	6r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07jepB-UUUUU=

On 12/12/2024 08:35 AM, Josh Poimboeuf wrote:
> On Wed, Dec 11, 2024 at 11:16:33AM +0800, Tiezhu Yang wrote:
>> When compiling on LoongArch, there are some PC relative relocation types
>> for rodata, it needs to calculate the symbol offset with "S + A - PC" in
>> this case according to the spec of "ELF for the LoongArch Architecture",
>> the "PC" is the index of each jump table which is equal with the value
>> of reloc_offset(reloc) - reloc_offset(table).
>>
>> I will add the above description to the commit message to make it clear.
>
> I understand how PC-relative addressing works.
>
> The oddity here is that "PC" is the jump table's base address rather
> than the entry address.

If there is only one jump table in the rodata, the "PC" is the entry
address which is equal with the value of reloc_offset(reloc), at this
time, reloc_offset(table) is 0.

If there are many jump tables in the rodata, the "PC" is the offset
of the jump table's base address which is equal with the value of 
reloc_offset(reloc) - reloc_offset(table).

> That has nothing to do with the ELF spec or
> even how R_LARCH_32_PCREL is implemented.  Rather it seems to be a quirk
> related to how loongarch jump table code expects the entries to be.
>
> So the arch_adjust_offset() name seems wrong, as this is specific to
> the jump table implementation, rather than relocs in general.
>
> Instead call it arch_jump_table_sym_offset()?

OK, will modify it and add the above description to the commit message
to make it clear.

Thanks,
Tiezhu


