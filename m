Return-Path: <linux-kernel+bounces-440695-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BDDB9EC2FE
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 04:12:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 257791654EE
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 03:11:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16887205E1B;
	Wed, 11 Dec 2024 03:11:44 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65ACE204F79
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 03:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733886703; cv=none; b=ZSajOAdw9+Q5KJT2UGXcLvZdWRCIoKM5sy4rfzVKvqMKcLKHhhQQAHajJpBXMNBUmBWNqu0MA+UpXGEUSzb4j15pAV/NHgbLOVeh7DdKIcqv+6ioZz8hijn1lKWxZysJFTqlCj++MaQN8kSlpiaI/I6oYCblVGK2zSb1tqCVr/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733886703; c=relaxed/simple;
	bh=6W5RauuKLBrSjrnL5ZB2tDgtaDo7iuFyuWsIW6M9Z44=;
	h=Subject:To:References:Cc:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=TLITBUnyf+8Yud7Em3w+QE+r1IwyMhrcDuMnwDuF5zI4cR8FlrpsoGg5eq+9qBOUjq+9f3LntssHY6xNCdUqbqFsmwaCUAecK5KgzkE2/tnfBZaer0OXPA2PVag4Q8eFtmnckgZrWb8O2T+/btrVmf4dYrLLn6o1OcxSwd9+Iz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8DxG+LiAllnj1RVAA--.34388S3;
	Wed, 11 Dec 2024 11:11:30 +0800 (CST)
Received: from [10.130.0.149] (unknown [113.200.148.30])
	by front1 (Coremail) with SMTP id qMiowMAxreDgAllnRCR_AA--.52312S3;
	Wed, 11 Dec 2024 11:11:30 +0800 (CST)
Subject: Re: [PATCH v5 02/10] objtool: Handle different entry size of rodata
To: Josh Poimboeuf <jpoimboe@kernel.org>
References: <20241207015915.1159-1-yangtiezhu@loongson.cn>
 <20241207015915.1159-3-yangtiezhu@loongson.cn>
 <20241209195413.gpq7t3nacsnx3xo3@jpoimboe>
Cc: Huacai Chen <chenhuacai@kernel.org>, Peter Zijlstra
 <peterz@infradead.org>, loongarch@lists.linux.dev,
 linux-kernel@vger.kernel.org
From: Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <832fe56f-1688-d128-50dd-3f668815a248@loongson.cn>
Date: Wed, 11 Dec 2024 11:11:28 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20241209195413.gpq7t3nacsnx3xo3@jpoimboe>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:qMiowMAxreDgAllnRCR_AA--.52312S3
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoW7Zr4xWryUXFWrZr48GF17urX_yoW8Xry3pF
	srC3yrGrn5tr42g3sFva1ku3Z3Gw4kXF17ZFZrK3s7Ar1Dtr1ftFy8AF4xKa45Gryv9r4f
	AayqqFn8uFW5A3gCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUvFb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27w
	Aqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE
	14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1c
	AE67vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8C
	rVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtw
	CIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x02
	67AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr
	0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxU7_Ma
	UUUUU

On 12/10/2024 03:54 AM, Josh Poimboeuf wrote:
> On Sat, Dec 07, 2024 at 09:59:07AM +0800, Tiezhu Yang wrote:
>> +__weak unsigned int arch_reloc_size(struct reloc *reloc)
>> +{
>> +	return 8;
>> +}
>
> Instead of making a weak function, each arch should have an explicit
> definition of this function, as it's not always 8:
>
> - x86 has R_X86_64_PC32 and R_X86_64_PLT32 which are 4 bytes.
>
> - 32-bit powerpc
>
> - 64-bit powerpc has R_PPC64_REL32

For x86, like this, I am not sure "case R_X86_64_32" is necessary,
leave it as is if no objections, please let me know if it should be
removed.

unsigned int arch_reloc_size(struct reloc *reloc)
{
         switch (reloc_type(reloc)) {
         case R_X86_64_32:
         case R_X86_64_PC32:
         case R_X86_64_PLT32:
                 return 4;
         default:
                 return 8;
         }
}

For ppc, like this:

unsigned int arch_reloc_size(struct reloc *reloc)
{
         switch (reloc_type(reloc)) {
         case R_PPC_REL32:
         case R_PPC64_REL32:
                 return 4;
         default:
                 return 8;
         }
}

>
>> @@ -1967,8 +1973,10 @@ static int add_jump_table(struct objtool_file *file, struct instruction *insn,
>>  		if (reloc != table && reloc == next_table)
>>  			break;
>>
>> +		entry_size = arch_reloc_size(reloc);
>> +
>>  		/* Make sure the table entries are consecutive: */
>> -		if (prev_offset && reloc_offset(reloc) != prev_offset + 8)
>> +		if (prev_offset && reloc_offset(reloc) != prev_offset + entry_size)
>>  			break;
>
> No need to use a variable here, just call arch_reloc_size() directly.

OK, will do it.

Thanks,
Tiezhu


