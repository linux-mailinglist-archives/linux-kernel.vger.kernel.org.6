Return-Path: <linux-kernel+bounces-440700-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 77D409EC30F
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 04:16:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DD421883771
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 03:16:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E39C19F471;
	Wed, 11 Dec 2024 03:16:40 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 050D8F9E6
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 03:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733887000; cv=none; b=q3bYtcKFqW59XJ1KhoR7PPUpb9J5wVrmn6Fdirxm2iz9rWyjaySqpeJgyvuJNrtyhj3JXeegINCZt0405/+8WI3Aca79eIhXg8YYOXAMT2E6KlroIcx4zCMjQlnJnErlEtHRgRY52Jd5cBFPREjXoNVHiW0YsOPxQWf6sLpQMM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733887000; c=relaxed/simple;
	bh=/QVN/Ksqlooakgo38yMMmQp/a7dwkEYb4pVTJAxm39M=;
	h=Subject:To:References:Cc:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=jayy+YeJI59zRujfVK0ICMUlNvqh0+Ucz5ccGOA7ONHJuHZ+v2jGThh1cgKPwqFr1CcIzzXoCKfv7ekGm2OfzADC1UJpPObzCyfUmqbaC3Fpayvcg0sJ8+9WZEv9NKkp942wHmADg/7mulg7JvhzTWuuglDxugO78nMz2z4aoEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8Ax6+ETBFlnT1VVAA--.34518S3;
	Wed, 11 Dec 2024 11:16:35 +0800 (CST)
Received: from [10.130.0.149] (unknown [113.200.148.30])
	by front1 (Coremail) with SMTP id qMiowMBxP+ERBFlnWSV_AA--.50233S3;
	Wed, 11 Dec 2024 11:16:34 +0800 (CST)
Subject: Re: [PATCH v5 03/10] objtool: Handle PC relative relocation type
To: Josh Poimboeuf <jpoimboe@kernel.org>
References: <20241207015915.1159-1-yangtiezhu@loongson.cn>
 <20241207015915.1159-4-yangtiezhu@loongson.cn>
 <20241209203544.axetpzva7vg3hsc5@jpoimboe>
Cc: Huacai Chen <chenhuacai@kernel.org>, Peter Zijlstra
 <peterz@infradead.org>, loongarch@lists.linux.dev,
 linux-kernel@vger.kernel.org
From: Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <9d14c8fa-d61d-bd12-efd7-5a17f4f8cb35@loongson.cn>
Date: Wed, 11 Dec 2024 11:16:33 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20241209203544.axetpzva7vg3hsc5@jpoimboe>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:qMiowMBxP+ERBFlnWSV_AA--.50233S3
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoW7uw1kKFyUWF1rtryDCw4Dtrc_yoW8Kw4rpF
	W29w43trsrJr1xGr42v3WkWF1fWw4kWr13JrWqyryFy3sYqr1rta47tw4Yga1UCr1qvFWI
	vFnIqa43C3WDAacCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUBYb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6r4UJVWxJr1ln4kS14v26r1Y6r17M2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12
	xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r12
	6r1DMcIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr4
	1lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWU
	JVW8JwCFI7km07C267AKxVWUXVWUAwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4
	vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IY
	x2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26c
	xKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAF
	wI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8q2NtUUUUU==

On 12/10/2024 04:35 AM, Josh Poimboeuf wrote:
> On Sat, Dec 07, 2024 at 09:59:08AM +0800, Tiezhu Yang wrote:
>> +unsigned long arch_adjust_offset(struct reloc *reloc, struct reloc *table)
>> +{
>> +	switch (reloc_type(reloc)) {
>> +	case R_LARCH_32_PCREL:
>> +	case R_LARCH_64_PCREL:
>> +		if (reloc->sym->type == STT_SECTION)
>> +			return reloc->sym->offset + reloc_addend(reloc) -
>> +			       (reloc_offset(reloc) - reloc_offset(table));
>
> How does this even work?  i.e., why does the reloc offset (basically the
> jump table index) have anything to do with calculating the location of
> the instruction it's referencing?

Let me try to explain it, this is related with the relocation type.

In short, the jump table index is not used to calculate the location of
the destination instruction for absolute relocation types, but it should
be used for PC relative relocation types.

For the most part, an absolute relocation type is used for rodata.
In the case of STT_SECTION, reloc->sym->offset is always zero, and
for the other symbol types, reloc_addend(reloc) is always zero, thus it
can use a simple statement "reloc->sym->offset + reloc_addend(reloc)"
to obtain the symbol offset for various symbol types.

When compiling on LoongArch, there are some PC relative relocation types
for rodata, it needs to calculate the symbol offset with "S + A - PC" in
this case according to the spec of "ELF for the LoongArch Architecture",
the "PC" is the index of each jump table which is equal with the value
of reloc_offset(reloc) - reloc_offset(table).

I will add the above description to the commit message to make it clear.

>
>> +		else
>> +			return reloc->sym->offset;
>
> This also seems odd.  Why is the addend being ignored?  Shouldn't it
> point to the instruction's offset?

Sorry for that, I forgot to calculate the table size if the symbol type
is local label generated by GCC on LoongArch, after doing that, no need
to check the symbol type, just check whether the reloc types are PC
relative, the final code should be something like this:

unsigned long arch_adjust_offset(struct reloc *reloc, struct reloc *table)
{
         switch (reloc_type(reloc)) {
         case R_LARCH_32_PCREL:
         case R_LARCH_64_PCREL:
                 return reloc->sym->offset + reloc_addend(reloc) -
                        (reloc_offset(reloc) - reloc_offset(table));
         default:
                 return reloc->sym->offset + reloc_addend(reloc);
         }
}

Thanks,
Tiezhu


