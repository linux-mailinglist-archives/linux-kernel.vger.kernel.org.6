Return-Path: <linux-kernel+bounces-250519-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 54F8292F8CC
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 12:19:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 053441F237B2
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 10:19:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 486AF154C1E;
	Fri, 12 Jul 2024 10:19:44 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DCD9149000
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 10:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720779583; cv=none; b=OQF+wvp7hak/KzoXNQIzWUAvFGGhDfzPUKkgZGBHQzyB+UYj/jnmqZxjFORGybeizm+nPv+vcF2WwlL6mr52/QowLTcLfmFcjIC20PK/L9VPV6eZj0GEmstuXhwHn0LaVMni/isSyYXFW0ywT7JmxJFJPlGhnjJgcOvwQe8E4/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720779583; c=relaxed/simple;
	bh=m8Fo37dbQHXF1VOFOJdFLjATgdftBN4o1j2llJWm8TU=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=ZCcjqi+d5iSexgAipDXRmhMaH3/qC6uPABwkGZstoOl+DdOpzXsvZm44Yp+08c8EZSrpKthRUByKdFRC0JcDxR6rObyxkJt/mVqj1XxL47MK/jz5LDAkTtdF8xeJwPFfFjpkcdsHhyR9ktqwEwR6LZqnoroSyKQYwn2SbzaN5tA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [111.9.175.10])
	by gateway (Coremail) with SMTP id _____8BxbPA5A5Fmz6YDAA--.10356S3;
	Fri, 12 Jul 2024 18:19:37 +0800 (CST)
Received: from [10.136.12.26] (unknown [111.9.175.10])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8AxBMU2A5FmC8JFAA--.17381S3;
	Fri, 12 Jul 2024 18:19:35 +0800 (CST)
Subject: Re: [RFC PATCH 0/4] Add jump table support for objtool on LoongArch
To: Tiezhu Yang <yangtiezhu@loongson.cn>, Josh Poimboeuf
 <jpoimboe@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Huacai Chen <chenhuacai@kernel.org>
Cc: Xi Ruoyao <xry111@xry111.site>, loongarch@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20240712091506.28140-1-yangtiezhu@loongson.cn>
From: Jinyang He <hejinyang@loongson.cn>
Message-ID: <307bcd3e-f4fe-8cc0-c557-4069c97c6072@loongson.cn>
Date: Fri, 12 Jul 2024 18:19:34 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240712091506.28140-1-yangtiezhu@loongson.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID:AQAAf8AxBMU2A5FmC8JFAA--.17381S3
X-CM-SenderInfo: pkhmx0p1dqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBj93XoW7KFyDAr4DGry7Kr45Gry8WFX_yoW8uFyfpF
	W7CrWfKFs8WFnaqwsxJw12gFy5Jr4fG34Utr43try09w4UXr1aqr4xtF9xZ3ZrW395W3y2
	qr1YgFy7KF4vkacCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
	1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv
	67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07
	AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02
	F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw
	1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7Cj
	xVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r
	1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8zw
	Z7UUUUU==

Are we always avoid our problems?

1, When text section not support "R_LARCH_32_PCREL", update compiler
    to add AS_HAS_THIN_ADD_SUB.
2, When not support jump-table, use "-fno-jump-tables" to avoid it,
    (and now update compiler to add CC_HAS_ANNOTATE_TABLEJUMP).
3, When not support relax, use "-mno-relax" to avoid it.
4, When some where in asm can be backtraced but generate warning,
    use STACK_FRAME_NON_STANDARD to avoid it.
5, When the goto-table cannot be handled (I guess the Ruoyao's
    patch cannot handle goto table), use CONFIG_BPF_JIT_ALWAYS_ON
    to avoid compile ___bpf_prog_run.
6, And other $fp warnings not be solved in clang. Do we only care gcc?

So how to do in the future if compilers have other changed? Do we
need update compilers (both gcc and clang) again and again? Why
not just update objtool codes to solves these problems? As many
RISC arch not support directly find jump table, can we support
more generic ways to find it?


On 2024-07-12 17:15, Tiezhu Yang wrote:
> This RFC version is based on Linux 6.10-rc7, there are no detailed
> commit messages for each patch for now and the code are relatively
> clear and simple.
>
> This series is tested with the latest upstream gcc applied with patch
> "LoongArch: Add support to annotate tablejump" [1] which adds a new
> section discard.tablejump_annotate to record the jump info, it makes
> life much easier, special thanks to Ruoyao.
>
> I will address all the review comments and update the commit messages
> after the merge window.
>
> [1] https://inbox.sourceware.org/gcc-patches/20240711114415.4420-1-xry111@xry111.site/
>
> Tiezhu Yang (4):
>    objtool: Check local label in find_jump_table()
>    objtool: Check various types in add_jump_table()
>    objtool/LoongArch: Add support for jump table
>    LoongArch: Remove -fno-jump-tables for objtool
>
>   arch/loongarch/Kconfig                 |  8 +++-
>   arch/loongarch/Makefile                |  6 +--
>   tools/objtool/arch/loongarch/special.c | 54 +++++++++++++++++++++++++-
>   tools/objtool/check.c                  | 36 +++++++++++++++--
>   4 files changed, 94 insertions(+), 10 deletions(-)
>


