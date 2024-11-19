Return-Path: <linux-kernel+bounces-414153-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 018029D23C4
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 11:47:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6C622B242CD
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 10:47:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5E9A1C2457;
	Tue, 19 Nov 2024 10:47:21 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C057819D890
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 10:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732013241; cv=none; b=PzSN4fm+IU2R/vy50Hwlu0ipSFZT0Fl4hWM8U4T2gs8ZFz6oY1VhIJabBgh1Sx6xiHEPNlUdNUf638rquYVSZvr0WkfI13AghKyI5426ifKXTGkXRk7EWRzUm0Wq/GxwYfpfSHKjJFZdY0f3BD9SWD4dnmzbGtdY0b1eyqxFDP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732013241; c=relaxed/simple;
	bh=47CuFmL36ppnQMnsOSBXOOrZcjhESTvVwEe0aPdrfdE=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=ivKJxaFp3w6dE07339hKIVCczqNOi1IjczXxUt7VZGKmTqUtU1+nT3gwkhnB0BLAbezd7fS3o1Caf1t22kVEZ8Z5C2Yfpw35taD+IMYeaJdDu9iByoaUXvb2e4fXtWEFjmfXiHw32DQVdtz5Xx0O2nBV0YmpCC20NOWyWsSwvv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [111.9.175.10])
	by gateway (Coremail) with SMTP id _____8AxquC0bDxnaGhCAA--.65223S3;
	Tue, 19 Nov 2024 18:47:16 +0800 (CST)
Received: from [10.136.12.26] (unknown [111.9.175.10])
	by front1 (Coremail) with SMTP id qMiowMCxDuGxbDxnWj5dAA--.5765S3;
	Tue, 19 Nov 2024 18:47:15 +0800 (CST)
Subject: Re: [PATCH v3 01/10] objtool: Handle various symbol types of rodata
To: Tiezhu Yang <yangtiezhu@loongson.cn>, Huacai Chen
 <chenhuacai@kernel.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>
Cc: loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20241119065655.21123-1-yangtiezhu@loongson.cn>
 <20241119065655.21123-2-yangtiezhu@loongson.cn>
From: Jinyang He <hejinyang@loongson.cn>
Message-ID: <63446b99-84f6-a51b-bee0-2f3158ecb033@loongson.cn>
Date: Tue, 19 Nov 2024 18:47:13 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20241119065655.21123-2-yangtiezhu@loongson.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-CM-TRANSID:qMiowMCxDuGxbDxnWj5dAA--.5765S3
X-CM-SenderInfo: pkhmx0p1dqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBj93XoWxJFWDKF45Gr47ZrykWw1fXwc_yoW5Zw4DpF
	43Gw45Kr4Yqr17WwnrtF40gF9xGws2gr17JwsrKrWrA3sIvFn5KFW3Kw1ay3WDGrnYvw47
	XF45Kry7uF4qy3gCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
	1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv
	67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07
	AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02
	F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw
	1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7Cj
	xVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r
	1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8zw
	Z7UUUUU==

On 2024-11-19 14:56, Tiezhu Yang wrote:

> In the relocation section ".rela.rodata" of each .o file compiled with
> LoongArch toolchain, there are various symbol types such as STT_NOTYPE,
> STT_OBJECT, STT_FUNC in addition to the usual STT_SECTION, it needs to
> use reloc symbol offset instead of reloc addend to find the destination
> instruction in find_jump_table() and add_jump_table().
>
> This is preparation for later patch on LoongArch, there is no effect for
> the other archs with this patch.
Which patch it prepares for? Please merge some patches if it is not
independent. Otherwise I cannot find what problem it solves.
According to the commit message I think it solve some problems independent?
>
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> ---
>   tools/objtool/check.c | 26 ++++++++++++++++++++++----
>   1 file changed, 22 insertions(+), 4 deletions(-)
>
> diff --git a/tools/objtool/check.c b/tools/objtool/check.c
> index 6604f5d038aa..9601235e908d 100644
> --- a/tools/objtool/check.c
> +++ b/tools/objtool/check.c
> @@ -2079,6 +2079,7 @@ static int add_jump_table(struct objtool_file *file, struct instruction *insn,
>   	unsigned int prev_offset = 0;
>   	struct reloc *reloc = table;
>   	struct alternative *alt;
> +	unsigned long offset;
>   
>   	/*
>   	 * Each @reloc is a switch table relocation which points to the target
> @@ -2094,12 +2095,19 @@ static int add_jump_table(struct objtool_file *file, struct instruction *insn,
>   		if (prev_offset && reloc_offset(reloc) != prev_offset + 8)
>   			break;
>   
> +		if (reloc->sym->type == STT_SECTION) {
> +			/* Addend field in the relocation entry associated with the symbol */
> +			offset = reloc_addend(reloc);
> +		} else {
> +			/* The address of the symbol in the relocation entry */
> +			offset = reloc->sym->offset;
> +		}
Generally rela relocations use S + A.
> +
>   		/* Detect function pointers from contiguous objects: */
> -		if (reloc->sym->sec == pfunc->sec &&
> -		    reloc_addend(reloc) == pfunc->offset)
> +		if (reloc->sym->sec == pfunc->sec && offset == pfunc->offset)
>   			break;
>   
> -		dest_insn = find_insn(file, reloc->sym->sec, reloc_addend(reloc));
> +		dest_insn = find_insn(file, reloc->sym->sec, offset);
>   		if (!dest_insn)
>   			break;
>   
> @@ -2137,6 +2145,7 @@ static struct reloc *find_jump_table(struct objtool_file *file,
>   {
>   	struct reloc *table_reloc;
>   	struct instruction *dest_insn, *orig_insn = insn;
> +	unsigned long offset;
>   
>   	/*
>   	 * Backward search using the @first_jump_src links, these help avoid
> @@ -2160,7 +2169,16 @@ static struct reloc *find_jump_table(struct objtool_file *file,
>   		table_reloc = arch_find_switch_table(file, insn);
>   		if (!table_reloc)
>   			continue;
> -		dest_insn = find_insn(file, table_reloc->sym->sec, reloc_addend(table_reloc));
> +
> +		if (table_reloc->sym->type == STT_SECTION) {
> +			/* Addend field in the relocation entry associated with the symbol */
> +			offset = reloc_addend(table_reloc);
> +		} else {
> +			/* The address of the symbol in the relocation entry */
> +			offset = table_reloc->sym->offset;
> +		}
> +
> +		dest_insn = find_insn(file, table_reloc->sym->sec, offset);
>   		if (!dest_insn || !insn_func(dest_insn) || insn_func(dest_insn)->pfunc != func)
>   			continue;
>   


