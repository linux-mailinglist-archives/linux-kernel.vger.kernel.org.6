Return-Path: <linux-kernel+bounces-414155-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D1009D23C6
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 11:47:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BABEE1F226E2
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 10:47:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2FBB1C4606;
	Tue, 19 Nov 2024 10:47:30 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 452C81C4A0E
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 10:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732013250; cv=none; b=i5FdErsiM15Zl+N2vKbrtqrkEdyZ0KyxNb4F5aQuaqs7FKVK1RneiPLP+8aAv2O44d79m/mPpS9rLeNPxNFE3TNUPdHv5o1qUcLTwhaBPNJQJBm4IX0Vv5QoH5WX+mNqsFQjycMk06J280OvoZHQWxXduY0saxN7C5cWWNBBIC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732013250; c=relaxed/simple;
	bh=5rpcXBUkk0hH95ce7Mwc1Odxo5W+XfECRy//P/4gLjE=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=Fg3gyU+iZHQMs9hPLUArbCVbQ8wHVxuvDO+zXW4WVPXy4+W3CwGmHJZ5YtQZTK1dg00pcvQgx6pVqiu6lxbPrn3aF9ld7iKbB+T8mQsQS9GNt9QJ6ysRB4PffEglGIi+RNm2axYOb895POYO9pYenSenAw5QDsey+O9IqYyn2iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [111.9.175.10])
	by gateway (Coremail) with SMTP id _____8Bx3669bDxndWhCAA--.25545S3;
	Tue, 19 Nov 2024 18:47:25 +0800 (CST)
Received: from [10.136.12.26] (unknown [111.9.175.10])
	by front1 (Coremail) with SMTP id qMiowMBx30e7bDxnYD5dAA--.28277S3;
	Tue, 19 Nov 2024 18:47:24 +0800 (CST)
Subject: Re: [PATCH v3 03/10] objtool: Handle different entry size of rodata
To: Tiezhu Yang <yangtiezhu@loongson.cn>, Huacai Chen
 <chenhuacai@kernel.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>
Cc: loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20241119065655.21123-1-yangtiezhu@loongson.cn>
 <20241119065655.21123-4-yangtiezhu@loongson.cn>
From: Jinyang He <hejinyang@loongson.cn>
Message-ID: <ede02c68-9a1b-8cd1-ae05-a1106b435e93@loongson.cn>
Date: Tue, 19 Nov 2024 18:47:23 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20241119065655.21123-4-yangtiezhu@loongson.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-CM-TRANSID:qMiowMBx30e7bDxnYD5dAA--.28277S3
X-CM-SenderInfo: pkhmx0p1dqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBj93XoW7ur13tF1kXw4Uur4UJry7urX_yoW8CFy5pF
	13G348trsYqry7WanrK3Z8uryru3yIgry8GFZ7Kry0ywnIqrn5JFWSk34YkFWUZ3sYg3Wx
	Za98KFy8CF4qy3gCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
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


On 2024-11-19 14:56, Tiezhu Yang wrote:
> In the most cases, the entry size of rodata is 8 bytes because the
> relocation type is 64 bit, but when compling with Clang on LoongArch,
> there exists 32 bit relocation type, the entry size of rodata should
> be 4 bytes in this case.
>
> This is preparation for later patch on LoongArch, there is no effect
> for the other archs with this patch.
>
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> ---
>   tools/objtool/check.c | 10 +++++++++-
>   1 file changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/tools/objtool/check.c b/tools/objtool/check.c
> index 6607cd56459b..af824bfd0973 100644
> --- a/tools/objtool/check.c
> +++ b/tools/objtool/check.c
> @@ -2092,6 +2092,7 @@ static int add_jump_table(struct objtool_file *file, struct instruction *insn,
>   	struct reloc *reloc = table;
>   	struct alternative *alt;
>   	unsigned long offset;
> +	unsigned long rodata_entry_size;
>   
>   	/*
>   	 * Each @reloc is a switch table relocation which points to the target
> @@ -2103,8 +2104,15 @@ static int add_jump_table(struct objtool_file *file, struct instruction *insn,
>   		if (reloc != table && reloc == next_table)
>   			break;
>   
> +		/* Handle the special cases compiled with Clang on LoongArch */
> +		if (file->elf->ehdr.e_machine == EM_LOONGARCH &&
> +		    reloc_type(reloc) == R_LARCH_32_PCREL)
It is arch-specific. I'd prefer to rewrite an interface in arch directory
to get the entry size in rodata by arch different relocation types.
And I think this patch should merge to other patches e.g. [07/10].
> +			rodata_entry_size = 4;
> +		else
> +			rodata_entry_size = 8;
> +
>   		/* Make sure the table entries are consecutive: */
> -		if (prev_offset && reloc_offset(reloc) != prev_offset + 8)
> +		if (prev_offset && reloc_offset(reloc) != prev_offset + rodata_entry_size)
>   			break;
>   
>   		if (reloc->sym->type == STT_SECTION) {


