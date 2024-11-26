Return-Path: <linux-kernel+bounces-422208-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DE4999D95E4
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 11:59:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9769A28406B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 10:59:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7494B1CCB4A;
	Tue, 26 Nov 2024 10:59:49 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3AD0366
	for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 10:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732618789; cv=none; b=caWKjalO2ak1E1KqVaELK1RQCnYYRV247wLOThElumCzYFN7IJRnUvKgcG3UB94Jg2TuQw3qVPvoPzSiEYXBNeHKHrZQ/S4/Hx/FWDWkYBRLV0YMAsqWqzCaem3GAvnT0hCqKElwD5KsskKd+0fPWZTijQtz6Z940JftRqiQ6Fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732618789; c=relaxed/simple;
	bh=pn3hshJJuW2AeozIfKZHO8qigP7wcHwajqEgpMjFrWo=;
	h=Subject:To:References:Cc:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=rcjWviLjboOXZXpxwThL5YRpXS9Qx8sId7ahjAvQ0cGSwYbu1Zuydw9AGtRD8oYp5Ai7fkQ465PhMKRZAG4S/kvwVunQPLUP8v5InAU6OOyfwQZgTZp5fBJR+oyr0IYtwEpRvZ19YiFMTOigHVJNdWenm9fh1F0Ho/6zidV7Xeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8CxC+IdqkVnHBFJAA--.11359S3;
	Tue, 26 Nov 2024 18:59:41 +0800 (CST)
Received: from [10.130.0.149] (unknown [113.200.148.30])
	by front1 (Coremail) with SMTP id qMiowMAxlsAaqkVn13FoAA--.43199S3;
	Tue, 26 Nov 2024 18:59:38 +0800 (CST)
Subject: Re: [PATCH v4 03/10] objtool: Handle different entry size of rodata
To: Josh Poimboeuf <jpoimboe@kernel.org>
References: <20241122045005.14617-1-yangtiezhu@loongson.cn>
 <20241122045005.14617-4-yangtiezhu@loongson.cn>
 <20241126070214.26gj5fnsjx5b5vp3@jpoimboe>
Cc: Huacai Chen <chenhuacai@kernel.org>, Peter Zijlstra
 <peterz@infradead.org>, loongarch@lists.linux.dev,
 linux-kernel@vger.kernel.org
From: Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <e56d48c6-172d-5b31-86de-98384fe58e98@loongson.cn>
Date: Tue, 26 Nov 2024 18:59:38 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20241126070214.26gj5fnsjx5b5vp3@jpoimboe>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:qMiowMAxlsAaqkVn13FoAA--.43199S3
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoW7KryxJFWrGF1rXF4UKrWkKrX_yoW8XFy5pF
	4UCw4Iqrn5XrW7K3ZFyr1UWa4fXw42qryxJr95CFy8tFnxXrnYqF4fCas0yFyjgrn09ayI
	vw4qqr1rCayDZFXCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUvIb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
	1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv
	67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07
	AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02
	F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw
	1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7Cj
	xVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r
	4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jY
	SoJUUUUU=

On 11/26/2024 03:02 PM, Josh Poimboeuf wrote:
> On Fri, Nov 22, 2024 at 12:49:58PM +0800, Tiezhu Yang wrote:
>> @@ -2107,8 +2112,15 @@ static int add_jump_table(struct objtool_file *file, struct instruction *insn,
>>  		if (reloc != table && reloc == next_table)
>>  			break;
>>
>> +		/* Handle the special cases compiled with Clang on LoongArch */
>
> This comment is not helpful at all.  A comment is only needed if the
> code is not already obvious.  In that case it should describe what is
> being done and why.

Will remove it.

>> +		if (file->elf->ehdr.e_machine == EM_LOONGARCH &&
>> +		    reloc_type(reloc) == R_LARCH_32_PCREL)
>> +			rodata_entry_size = 4;
>> +		else
>> +			rodata_entry_size = 8;
>
> Is this really loongarch-specific or is it only related to the size of
> the reloc?

This is related with the reloc type, but it may be wrong to only
check the reloc type to assign the value of rodata_entry_size,
becasue the value of reloc type for different archs may be same,
so it needs to check ehdr.e_machine and relocation type.

> Can this be abstracted out to a reloc_size() function like
> so?
>
>   https://git.kernel.org/pub/scm/linux/kernel/git/jpoimboe/linux.git/tree/tools/objtool/klp-diff.c?h=objtool-diff#n834
>
> maybe it could live in elf.h.

OK, if I understand your comment correctly, this should be an
arch-specific function defined in 
tools/objtool/arch/*/include/arch/elf.h, otherwise it also needs to 
check ehdr.e_machine
in tools/objtool/include/objtool/elf.h.

Thanks,
Tiezhu


