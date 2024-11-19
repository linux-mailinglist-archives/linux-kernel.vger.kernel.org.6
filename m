Return-Path: <linux-kernel+bounces-414156-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70CB19D23C7
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 11:48:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EE135B24B7E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 10:48:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD5AF1C4A3B;
	Tue, 19 Nov 2024 10:47:33 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E1791C4A27
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 10:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732013253; cv=none; b=L2GGjhwXlKKz4mcZEsOb/G34KYHXK3FGjr4FlCdz4XeXyR9yQCjBFDZVonGp1TSUrBlehgapfe0MRWkGBPm1JmazwI5MbDoGOS/kuCGx7t9vTDZet0UaQ0ODvJf0F99w2g0lCCU0ixw7cSB7U1o9W7tfX5bXMYiIO1WyOFFsAv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732013253; c=relaxed/simple;
	bh=2nKuvgRDrDFXUCzp1HNp0gUXhesy/NrFnYjPYtvTG1o=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=nEYJP3uwe5ui3RVdGMMyh/Jo/FzYOnK0k/ifDWoy+f6hhiSGV3f5AV+byh4SlRCFozoeU7WkipKoViZO4jSHvGM2zDFI4cbAbnft+zgjC+gm+m9dikqO+wAwB/P9hWoHw/zQZt4OzK6lW92dyA+x5Ct7qfAJSMtdQFpk5J/WgGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [111.9.175.10])
	by gateway (Coremail) with SMTP id _____8CxPuPBbDxnemhCAA--.64302S3;
	Tue, 19 Nov 2024 18:47:29 +0800 (CST)
Received: from [10.136.12.26] (unknown [111.9.175.10])
	by front1 (Coremail) with SMTP id qMiowMBx58C_bDxnYj5dAA--.27181S3;
	Tue, 19 Nov 2024 18:47:29 +0800 (CST)
Subject: Re: [PATCH v3 05/10] objtool: Handle unreachable entry of rodata
To: Tiezhu Yang <yangtiezhu@loongson.cn>, Huacai Chen
 <chenhuacai@kernel.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>
Cc: loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20241119065655.21123-1-yangtiezhu@loongson.cn>
 <20241119065655.21123-6-yangtiezhu@loongson.cn>
From: Jinyang He <hejinyang@loongson.cn>
Message-ID: <c21f145f-c63d-ca37-b13b-2599d91492e8@loongson.cn>
Date: Tue, 19 Nov 2024 18:47:27 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20241119065655.21123-6-yangtiezhu@loongson.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-CM-TRANSID:qMiowMBx58C_bDxnYj5dAA--.27181S3
X-CM-SenderInfo: pkhmx0p1dqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBj93XoW7uw4xtFW8WrWxZw1xGw1xJFc_yoW8XF43pF
	45Kw1jkr4qgrWxu3ZrGa1Ygry3Ww4xGrWkGr97trW8t3sFqrnYqFWSka1av3WUWw4ru3WI
	qFWYgFy8uF4qyagCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUB2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
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
	14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU4miiDUUUU

On 2024-11-19 14:56, Tiezhu Yang wrote:

> When compling with Clang on LoongArch, there exists unreachable entry
> of rodata which points to a nop instruction after the function return
> instruction, this is generated by compiler to fill the non-existent
> switch case, just skip the entry when parsing the relocation section
> of rodata.
>
> This is preparation for later patch on LoongArch, there is no effect
> for the other archs with this patch.
>
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> ---
>   tools/objtool/check.c | 8 ++++++++
>   1 file changed, 8 insertions(+)
>
> diff --git a/tools/objtool/check.c b/tools/objtool/check.c
> index eb4c89501493..17df3738e087 100644
> --- a/tools/objtool/check.c
> +++ b/tools/objtool/check.c
> @@ -2136,6 +2136,14 @@ static int add_jump_table(struct objtool_file *file, struct instruction *insn,
>   		if (!dest_insn)
>   			break;
>   
> +		/* Handle the special cases compiled with Clang on LoongArch */
> +		if (file->elf->ehdr.e_machine == EM_LOONGARCH &&
> +		    reloc->sym->type == STT_SECTION && dest_insn->type == INSN_NOP &&
Why it points to NOP, and whether it could be some other instruction 
(e.g. break)?
It seems fragile. I think it should fix in Clang.
> +		    (!insn_func(dest_insn) || insn_func(dest_insn)->pfunc != pfunc)) {
> +			prev_offset = reloc_offset(reloc);
> +			continue;
> +		}
> +
>   		/* Make sure the destination is in the same function: */
>   		if (!insn_func(dest_insn) || insn_func(dest_insn)->pfunc != pfunc)
>   			break;


