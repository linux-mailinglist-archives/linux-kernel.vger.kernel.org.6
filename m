Return-Path: <linux-kernel+bounces-422195-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8803E9D95B8
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 11:41:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02DBE1631D8
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 10:41:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5DB01C4A24;
	Tue, 26 Nov 2024 10:41:42 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D42861B6CE6
	for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 10:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732617702; cv=none; b=b46ISA84X83hJKFyVVALQAT3imqnUohzjwriII8JGelKzK2M3pjOcxv3+hcxrQN7p0OP5Q6tMu4xYZagsYZFtyIDnoBUXM31yRshGVOZmJaguTxh7qa3r9TSMkZCrgkVoSU0sYFjS5oyTZr1D1J+sf7siV/jHcNHAElebDeVSPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732617702; c=relaxed/simple;
	bh=rZgQ1Njr68VVfkq+9rHYrCubwJeIuwgzf6q8PwPHA+g=;
	h=Subject:To:References:Cc:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=J/ZZdq8/9CdAh026xp330nbXxBJq5fy2XBs2qTp/qsCDfnSn2LNoO2njj3MheCWnVGt6KM/DQgV8e9ueaJCGEUdzKuGFKRUgis+Fr1N1mwyahw6vruhHAgJ9ERpHcV0rGb5yihvLGrfzBnhyH4UnUOpE9sNw5f4fpgLJjS7f4cE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8DxQK_apUVn8g5JAA--.53087S3;
	Tue, 26 Nov 2024 18:41:30 +0800 (CST)
Received: from [10.130.0.149] (unknown [113.200.148.30])
	by front1 (Coremail) with SMTP id qMiowMAxTUfZpUVn4W1oAA--.42852S3;
	Tue, 26 Nov 2024 18:41:29 +0800 (CST)
Subject: Re: [PATCH v4 01/10] objtool: Handle various symbol types of rodata
To: Josh Poimboeuf <jpoimboe@kernel.org>
References: <20241122045005.14617-1-yangtiezhu@loongson.cn>
 <20241122045005.14617-2-yangtiezhu@loongson.cn>
 <20241126064458.7ugwqfx5vhnwzvbi@jpoimboe>
Cc: Huacai Chen <chenhuacai@kernel.org>, Peter Zijlstra
 <peterz@infradead.org>, loongarch@lists.linux.dev,
 linux-kernel@vger.kernel.org
From: Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <75f6e90b-4d04-5627-395e-58982a84d7c1@loongson.cn>
Date: Tue, 26 Nov 2024 18:41:29 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20241126064458.7ugwqfx5vhnwzvbi@jpoimboe>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:qMiowMAxTUfZpUVn4W1oAA--.42852S3
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoW7CFy7Kw1Uury5uryDJw1DJwc_yoW8CFWUpF
	sxtw45Kr4Fyr12gw4IqF4v9F93uws3WF17J3s8WrWrA3sFyF1rKayxGw43Ca4kJrn2vF47
	Ja1YkryfZrWkA3gCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
	1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv
	67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07
	AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02
	F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw
	1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7Cj
	xVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r
	1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8yr
	W7UUUUU==

On 11/26/2024 02:44 PM, Josh Poimboeuf wrote:
> On Fri, Nov 22, 2024 at 12:49:56PM +0800, Tiezhu Yang wrote:
>> @@ -2094,12 +2095,19 @@ static int add_jump_table(struct objtool_file *file, struct instruction *insn,
>>  		if (prev_offset && reloc_offset(reloc) != prev_offset + 8)
>>  			break;
>>
>> +		if (reloc->sym->type == STT_SECTION) {
>> +			/* Addend field in the relocation entry associated with the symbol */
>> +			offset = reloc_addend(reloc);
>> +		} else {
>> +			/* The address of the symbol in the relocation entry */
>> +			offset = reloc->sym->offset;
>
> The comments don't seem helpful.

Will remove it.

>
> In the case of STT_SECTION, sym->offset is always zero.  Therefore the
> if-else can be converted to a simple unconditional statement:
>
> 	offset = reloc->sym->offset + reloc_addend(reloc);

OK, let me test it.

>
> 'prev_offset' needs to be updated as well.

I am not sure I understand your comment correctly, I can not see
what should to do about 'prev_offset'.

>
>> @@ -2137,6 +2145,7 @@ static struct reloc *find_jump_table(struct objtool_file *file,
>>  {
>>  	struct reloc *table_reloc;
>>  	struct instruction *dest_insn, *orig_insn = insn;
>> +	unsigned long offset;
>>
>>  	/*
>>  	 * Backward search using the @first_jump_src links, these help avoid
>> @@ -2160,7 +2169,16 @@ static struct reloc *find_jump_table(struct objtool_file *file,
>>  		table_reloc = arch_find_switch_table(file, insn);
>>  		if (!table_reloc)
>>  			continue;
>> -		dest_insn = find_insn(file, table_reloc->sym->sec, reloc_addend(table_reloc));
>> +
>> +		if (table_reloc->sym->type == STT_SECTION) {
>> +			/* Addend field in the relocation entry associated with the symbol */
>> +			offset = reloc_addend(table_reloc);
>> +		} else {
>> +			/* The address of the symbol in the relocation entry */
>> +			offset = table_reloc->sym->offset;
>> +		}
>
> Same comment here.

OK, will do it.

Thanks,
Tiezhu


