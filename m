Return-Path: <linux-kernel+bounces-422211-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9145D9D95EA
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 12:00:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56194283128
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 11:00:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 261961CBE8B;
	Tue, 26 Nov 2024 11:00:31 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E848E1CB527
	for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 11:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732618830; cv=none; b=ne4O5Lm6V8phXcecVERN5LocCbMo3HbFmfnexaSDnKQGFbrqp9jKUj5vR2pCVGuz+0fTFzktSd40c8RovSJOqXzWAGaX86WXvQNMcr6SnmaMvH4NW3bnhY0G9vE/TNDl13p8rq60NF7S3421IIOG4OlcFpJ6K7Kow6hawSq5ttw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732618830; c=relaxed/simple;
	bh=mB6qv9SaMnC7ZRWUJFw8JXa956LhH4qs4ldYN+4ZTbA=;
	h=Subject:To:References:Cc:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=Glea88JdhrVv4hKQLD+4c1s1JqTj+LMeh3qoA89zqE/b4tC6tqrRV/DekqAb+YLlUOLEoRRX1wTrboTJ55BL9OIGGqi+Tq/UIeTklRACay4XZJtuIrt+qGSYWjtEPiPU6/8+61EhP+8x6u1d8/TePwCofY/CiPZaE6iIxoguoVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8DxmeFLqkVnSRFJAA--.14537S3;
	Tue, 26 Nov 2024 19:00:27 +0800 (CST)
Received: from [10.130.0.149] (unknown [113.200.148.30])
	by front1 (Coremail) with SMTP id qMiowMCxS+BJqkVn+nFoAA--.22213S3;
	Tue, 26 Nov 2024 19:00:26 +0800 (CST)
Subject: Re: [PATCH v4 04/10] objtool: Handle PC relative relocation type
To: Josh Poimboeuf <jpoimboe@kernel.org>
References: <20241122045005.14617-1-yangtiezhu@loongson.cn>
 <20241122045005.14617-5-yangtiezhu@loongson.cn>
 <20241126071935.2vmsna54zsa5cdho@jpoimboe>
Cc: Huacai Chen <chenhuacai@kernel.org>, Peter Zijlstra
 <peterz@infradead.org>, loongarch@lists.linux.dev,
 linux-kernel@vger.kernel.org
From: Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <aebad82f-3979-f7e4-a17b-5f943cd0f18b@loongson.cn>
Date: Tue, 26 Nov 2024 19:00:25 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20241126071935.2vmsna54zsa5cdho@jpoimboe>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:qMiowMCxS+BJqkVn+nFoAA--.22213S3
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoW7WryDJrW8tF17JryftFWkAFc_yoW8WF1xpF
	15ua15KrsI9r17WwsrK3WkWry5Gw4xWryfXryIkry0kFnrZFn5trWIk3W5ua1UZw1FgayI
	va9xKFyxAa1qyagCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUB2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
	AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
	AVWUtwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI4
	8JMxk0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_
	Jr0_Gr1l4IxYO2xFxVAFwI0_Jrv_JF1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8Gjc
	xK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0
	cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8V
	AvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E
	14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU466zUUUUU

On 11/26/2024 03:19 PM, Josh Poimboeuf wrote:
> On Fri, Nov 22, 2024 at 12:49:59PM +0800, Tiezhu Yang wrote:
>> When compling with Clang on LoongArch, there exists 32 bit PC relative
>> relocation type, it needs to get the offset with "S + A - PC" according
>> to the spec of "ELF for the LoongArch Architecture".
>>
>> This is preparation for later patch on LoongArch, there is no effect for
>> the other archs with this patch.
>>
>> Link: https://github.com/loongson/la-abi-specs/blob/release/laelf.adoc
>> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
>> ---
>>  tools/objtool/check.c | 5 +++++
>>  1 file changed, 5 insertions(+)
>>
>> diff --git a/tools/objtool/check.c b/tools/objtool/check.c
>> index 19d1263e64e4..8733ca620cca 100644
>> --- a/tools/objtool/check.c
>> +++ b/tools/objtool/check.c
>> @@ -2126,6 +2126,11 @@ static int add_jump_table(struct objtool_file *file, struct instruction *insn,
>>  		if (reloc->sym->type == STT_SECTION) {
>>  			/* Addend field in the relocation entry associated with the symbol */
>>  			offset = reloc_addend(reloc);
>> +			/* Handle the special cases compiled with Clang on LoongArch */
>> +			if (file->elf->ehdr.e_machine == EM_LOONGARCH &&
>> +			    reloc_type(reloc) == R_LARCH_32_PCREL)
>> +				offset = reloc->sym->offset + reloc_addend(reloc) -
>> +					 (reloc_offset(reloc) - reloc_offset(table));
>
> Please, no more "special cases".  It makes the common code unreadable.
> We should avoid checking 'elf->ehdr.e_machine' in check.c.

OK.

>
> Maybe there should be an arch-specific function arch_adjusted_addend().
>

Will do it.


