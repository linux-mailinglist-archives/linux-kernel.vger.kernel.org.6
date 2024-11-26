Return-Path: <linux-kernel+bounces-422352-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 295D99D988C
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 14:30:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A6AB8B235FF
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 13:28:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4871A1D5147;
	Tue, 26 Nov 2024 13:28:26 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4066522F
	for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 13:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732627705; cv=none; b=Qa7tmkSUOiRhlBi3bp7WghC+TMMi++z/cMFhiX8HgyDg7MMNlcSIG1hYZKIRykSKtTz7WDFwGBhzA7FywupJkqAuwEpZ8lzFZNTLiDMz4zWbWM8EEWHhNOqNKNB2lMqypjZL9UfNN7EE4wCGaplSspgKb/WCWEr2KFoEGeCzvZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732627705; c=relaxed/simple;
	bh=UUN3gOvLpf58dKTpbNxydZfnuewhbHmOk4miccwmw44=;
	h=Subject:To:References:Cc:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=JLeG3sH5bDh8jog019dBjkhM63iW8CKw9FQot0UiZ2lBMHQOGOYLZ6rTlSacHtr55iNkT7kTYWFO2g9DP+o7Lasjv+ok3l031+6O1N4uOInafqh8on2EZm5rjEVrjLpMiWDMGMG/J6sp/1+1lF7weGSjBPCn71b8xw5lEYkyuE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8AxEK_1zEVngyNJAA--.38337S3;
	Tue, 26 Nov 2024 21:28:21 +0800 (CST)
Received: from [10.130.0.149] (unknown [113.200.148.30])
	by front1 (Coremail) with SMTP id qMiowMCx98DzzEVnWJZoAA--.42998S3;
	Tue, 26 Nov 2024 21:28:20 +0800 (CST)
Subject: Re: [PATCH v4 06/10] objtool: Handle unsorted table offset of rodata
To: Huacai Chen <chenhuacai@kernel.org>, Josh Poimboeuf
 <jpoimboe@kernel.org>, Peter Zijlstra <peterz@infradead.org>
References: <20241122045005.14617-1-yangtiezhu@loongson.cn>
 <20241122045005.14617-7-yangtiezhu@loongson.cn>
Cc: loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
From: Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <8cb35ab7-56d0-8e8d-5e18-1bc2b94aeeeb@loongson.cn>
Date: Tue, 26 Nov 2024 21:28:19 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20241122045005.14617-7-yangtiezhu@loongson.cn>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:qMiowMCx98DzzEVnWJZoAA--.42998S3
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoW7KF1kWrWxur47Xr4Uur45Jwc_yoW8CF4xpF
	15CayUtrs0qryxK3Zrt3W0k343Gw47GryxJr4xtry8t34qvrnYqFW3Cay2kFyDWw4Y9a1I
	va98KFyxCF4kAFXCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUB2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
	AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
	tVWrXwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI4
	8JMxk0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_
	Jr0_Gr1l4IxYO2xFxVAFwI0_Jrv_JF1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8Gjc
	xK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0
	cI8IcVAFwI0_Gr0_Xr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8V
	AvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E
	14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU4AhLUUUUU

On 11/22/2024 12:50 PM, Tiezhu Yang wrote:
> When compling with Clang on LoongArch, there are unsorted table offset
> of rodata if there exist many jump tables, it will get the wrong table
> end and find the wrong jump destination instructions in add_jump_table(),
> so it needs to check the table size of rodata to break the process when
> parsing the relocation section of rodata.
>
> This is preparation for later patch on LoongArch, there is no effect for
> the other archs with this patch.
>
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> ---
>  tools/objtool/check.c                 | 7 +++++++
>  tools/objtool/include/objtool/check.h | 1 +
>  2 files changed, 8 insertions(+)
>
> diff --git a/tools/objtool/check.c b/tools/objtool/check.c
> index b21e47d8d3d1..3b2d94c90011 100644
> --- a/tools/objtool/check.c
> +++ b/tools/objtool/check.c
> @@ -2101,6 +2101,7 @@ static int add_jump_table(struct objtool_file *file, struct instruction *insn,
>  	struct alternative *alt;
>  	unsigned long offset;
>  	unsigned long rodata_entry_size;
> +	unsigned long rodata_table_size = insn->table_size;
>
>  	/*
>  	 * Each @reloc is a switch table relocation which points to the target
> @@ -2112,6 +2113,12 @@ static int add_jump_table(struct objtool_file *file, struct instruction *insn,
>  		if (reloc != table && reloc == next_table)
>  			break;
>
> +		/* Handle the special cases compiled with Clang on LoongArch */
> +		if (file->elf->ehdr.e_machine == EM_LOONGARCH &&
> +		    reloc->sym->type == STT_SECTION && reloc != table &&
> +		    reloc_offset(reloc) == reloc_offset(table) + rodata_table_size)
> +			break;

I think it can be generic, like this:

                 /* Check for the end of the table: */
                 if (reloc != table && reloc == next_table)
                         break;

                 if (reloc != table &&
                     reloc_offset(reloc) == reloc_offset(table) + 
rodata_table_size)
                         break;

What do you think?

Thanks,
Tiezhu


