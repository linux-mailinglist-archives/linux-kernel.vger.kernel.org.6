Return-Path: <linux-kernel+bounces-422197-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC5D19D95C2
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 11:42:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AC666B24458
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 10:42:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82DD01C8FB5;
	Tue, 26 Nov 2024 10:42:21 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13ED31B21AD
	for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 10:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732617741; cv=none; b=kBzd+ni4ecLJeUqxAtRvlzVAx8Fz7HaZcYbLGNKr1qfibNJae17glfQ7KvEq0jKH3IhOdqynTlyIMb5HG/Y7HkL7efbShzf3fcsz5/o58L8Jlf52EUrnACM8mk1WCfgwOvk8Fb694wdgrN8EF9MChUPuktR1SPY9o8qPlirihcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732617741; c=relaxed/simple;
	bh=GY571ipN4IC/7DIKMKZTGzIvBiV4jFXyz1rcN9yqAeQ=;
	h=Subject:To:References:Cc:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=BZ3BUG5Zb5ebuUrV0PHXx637knOSlfESCOGB1vrC7SR7fmtALtw4FyGME098Z0Ju7c2fzlkEC70wUrUx8pkiFnxQ5C6Wj5raEvnE0BUlH+OteV6ren+JajphfBruw1S5uDI0oRS+i5dojPxs7riARq3XQs5/ZcLHinKpNGRFt5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8AxaeEIpkVnKQ9JAA--.10964S3;
	Tue, 26 Nov 2024 18:42:16 +0800 (CST)
Received: from [10.130.0.149] (unknown [113.200.148.30])
	by front1 (Coremail) with SMTP id qMiowMBxXUcHpkVnA25oAA--.42495S3;
	Tue, 26 Nov 2024 18:42:15 +0800 (CST)
Subject: Re: [PATCH v4 02/10] objtool: Handle special cases of dead end insn
To: Josh Poimboeuf <jpoimboe@kernel.org>
References: <20241122045005.14617-1-yangtiezhu@loongson.cn>
 <20241122045005.14617-3-yangtiezhu@loongson.cn>
 <20241126064513.bf6yq56eklyo4xvt@jpoimboe>
Cc: Huacai Chen <chenhuacai@kernel.org>, Peter Zijlstra
 <peterz@infradead.org>, loongarch@lists.linux.dev,
 linux-kernel@vger.kernel.org
From: Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <bb36374e-aca2-92e1-209d-1524e31147ab@loongson.cn>
Date: Tue, 26 Nov 2024 18:42:15 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20241126064513.bf6yq56eklyo4xvt@jpoimboe>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:qMiowMBxXUcHpkVnA25oAA--.42495S3
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoW7CF4fCrW5Wr17uF4DGFWxuFX_yoW8XryxpF
	ZxAay5AF4qvrWkWF17Zr48Zryftw4fJw4UXFn5J34fK3yUJwn3tF1kta1jyasxCr4S9F1a
	qF1Sg34DWFy5A3XCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
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

On 11/26/2024 02:45 PM, Josh Poimboeuf wrote:
> On Fri, Nov 22, 2024 at 12:49:57PM +0800, Tiezhu Yang wrote:
>> There are some "unreachable instruction" objtool warnings when compling
>> with Clang on LoongArch, this is because the "break" instruction is set
>> as dead end due to its type is INSN_BUG in decode_instructions() at the
>> beginning, and it does not set insn->dead_end of the "break" instruction
>> as false after checking ".rela.discard.reachable" in add_dead_ends(), so
>> the next instruction of "break" is marked as unreachable.
>>
>> Actually, it can find the reachable instruction after parsing the section
>> ".rela.discard.reachable", in some cases, the "break" instruction may not
>> be the first previous instruction with scheduling by Machine Instruction
>> Scheduler of LLVM, it should find more times and then set insn->dead_end
>> of the "break" instruction as false.
>>
>> This is preparation for later patch on LoongArch, there is no effect for
>> the other archs with this patch.
>>
>> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
>
> I'm having trouble understanding this commit log, is the problem that
> the compiler is sometimes inserting code between 'break' and the
> unreachable() inline asm?
>
> If so, this sounds like a problem that was already solved for x86 with:
>
>   bfb1a7c91fb7 ("x86/bug: Merge annotate_reachable() into _BUG_FLAGS() asm")
>
> Can you check if that fixes it?

I will try, thank you.


