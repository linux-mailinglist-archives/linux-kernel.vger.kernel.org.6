Return-Path: <linux-kernel+bounces-252336-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A060F9311C6
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 11:56:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1DDDDB20D5D
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 09:56:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6030E187335;
	Mon, 15 Jul 2024 09:56:12 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68ABE1862AB
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 09:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721037372; cv=none; b=od0bNvCaMyzgB3Th5si4vAVNhy+pkUH42O8dWgE+V5vlmCcRmrc2mtSpP2wN5SjXrmNUQwxiqXRv8oFEaUXQora0DZ9wfiE9gmMh8Bqb5bDKZC0h7/b4dMAulp4kXmJviJrWbvVqE1ATalfXq1401F5NdlyJVBGWVyhKXEfZ2EA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721037372; c=relaxed/simple;
	bh=1LT6bGdap7nmLMQbwo1fJ5WrO61MDan0T38QyFzr18E=;
	h=Subject:To:References:Cc:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=UWP0qz+wgqcTqZf/2fQ8nP2MdY3ocPzNalOpK8UW+NZ9WCDcxn1xp5E1exB+PAEgM3I4FmFvXYhaj/XHrNX7GZino+tKo0g58dtInu6bQ3JfEolbDrRPK7Q9yhZJVcSaQDqo3rM/p7ucFh8sRGxnUbgGyceGXxFLb2967u/gEeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8BxrfA38pRmMpAEAA--.12035S3;
	Mon, 15 Jul 2024 17:56:07 +0800 (CST)
Received: from [10.130.0.149] (unknown [113.200.148.30])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8Bx08Q18pRmP6dJAA--.24803S3;
	Mon, 15 Jul 2024 17:56:05 +0800 (CST)
Subject: Re: [RFC PATCH 0/4] Add jump table support for objtool on LoongArch
To: Jinyang He <hejinyang@loongson.cn>, Josh Poimboeuf <jpoimboe@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Huacai Chen <chenhuacai@kernel.org>
References: <20240712091506.28140-1-yangtiezhu@loongson.cn>
 <307bcd3e-f4fe-8cc0-c557-4069c97c6072@loongson.cn>
Cc: Xi Ruoyao <xry111@xry111.site>, loongarch@lists.linux.dev,
 linux-kernel@vger.kernel.org
From: Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <bad4a7fd-e487-498d-f6ab-b9a17e049dd7@loongson.cn>
Date: Mon, 15 Jul 2024 17:56:03 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <307bcd3e-f4fe-8cc0-c557-4069c97c6072@loongson.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:AQAAf8Bx08Q18pRmP6dJAA--.24803S3
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoW7KFyDAw17Jr1kZr45WrWfZwc_yoW8Kry8pF
	WUu34ftFs8JanagwnrXr129ay3CayDG3yDtr45G348uw4aqr1IvF4vkF9IvanrArs3ZrWa
	vF17K3srKa1vyacCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUBFb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
	AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
	XVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI4
	8JMxk0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_
	Jr0_Gr1l4IxYO2xFxVAFwI0_Jrv_JF1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8Gjc
	xK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0
	cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8V
	AvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E
	14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07je0PfUUUUU=

On 07/12/2024 06:19 PM, Jinyang He wrote:
> Are we always avoid our problems?
>
> 1, When text section not support "R_LARCH_32_PCREL", update compiler
>    to add AS_HAS_THIN_ADD_SUB.
> 2, When not support jump-table, use "-fno-jump-tables" to avoid it,
>    (and now update compiler to add CC_HAS_ANNOTATE_TABLEJUMP).
> 3, When not support relax, use "-mno-relax" to avoid it.
> 4, When some where in asm can be backtraced but generate warning,
>    use STACK_FRAME_NON_STANDARD to avoid it.
> 5, When the goto-table cannot be handled (I guess the Ruoyao's
>    patch cannot handle goto table), use CONFIG_BPF_JIT_ALWAYS_ON
>    to avoid compile ___bpf_prog_run.
> 6, And other $fp warnings not be solved in clang. Do we only care gcc?
>
> So how to do in the future if compilers have other changed? Do we
> need update compilers (both gcc and clang) again and again? Why
> not just update objtool codes to solves these problems? As many
> RISC arch not support directly find jump table, can we support
> more generic ways to find it?

This is a choose and balance. In principle, I want to make the kernel
code clear and simple to enhance the readability and maintainability,
I do not want to modify too much architecture independent code of the
objtool framework, I just want to implement the architecture specific
function.

As the gcc patch "LoongArch: Add support to annotate tablejump" said,
the objtool program needs to analysis the control flow of each .o file
generated by compiler toolchain, if a jump table is used, objtool has
to correlate the jump instruction with the table, on x86 it's simple:
a relocation entry natrually correlates them because one instruction is
used for table-based jump, but on an RISC machine objtool would have to
reconstruct the data flow if it must find out the correlation on its own,
so emit an additional section to store the correlation info as pairs of
addresses, each pair contains the address of a jump instruction (jr) and
the address of the jump table. This is very trivial to implement in GCC.

For jump table support of objtool on LoongArch, it makes life much easier
with the gcc changes. As far as I can see, the remain issues (goto table
in ___bpf_prog_run() and jump table in assemble code) are only related
with kernel and can be solved with kernel changes.

Thanks,
Tiezhu


