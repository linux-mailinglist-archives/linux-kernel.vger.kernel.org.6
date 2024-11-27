Return-Path: <linux-kernel+bounces-423040-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CCC019DA1CE
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 06:46:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 918E02844EA
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 05:46:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0AA413D245;
	Wed, 27 Nov 2024 05:46:09 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEA093FB9C
	for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 05:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732686369; cv=none; b=LlL016NcSbpswuc33hkzlZC7Dj0veL1nPr1+XnrEw7m7HXkrjWwdrC+MxaE2BgEL24Z/rrUBlo4xKXwmhx9UlFBP2OTIIgUPVAaDXJ/2oZNrupL0YYW5vya0bZLwHsGSzU1/Phcn3Ffq6b+5rZNVqsFQmbnyNzpQGoWx+0YNoyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732686369; c=relaxed/simple;
	bh=8fv1MB373KyTosRdU+u2ouvKsd0zalAEc8ZFd1eAENI=;
	h=Subject:To:References:Cc:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=Ey6lU9SkkPd7r42yMNbNsmKryzziP2FAoLLTq1h6LRLeHf6qcdXOse1BGcycfhKsZloAcyD7smBTXUvvbZNNx4c0zTksw17V93pUZPQvMXwRsynsvWVe3agPuAw2dpJnJ8YFuVvhirsD344c4+kM+dllqLR1W94ZImYW3u2xmCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8CxC+IXskZnQ51JAA--.12405S3;
	Wed, 27 Nov 2024 13:45:59 +0800 (CST)
Received: from [10.130.0.149] (unknown [113.200.148.30])
	by front1 (Coremail) with SMTP id qMiowMCxS+AUskZny4BpAA--.23652S3;
	Wed, 27 Nov 2024 13:45:57 +0800 (CST)
Subject: Re: [PATCH v4 02/10] objtool: Handle special cases of dead end insn
To: Peter Zijlstra <peterz@infradead.org>
References: <20241122045005.14617-1-yangtiezhu@loongson.cn>
 <20241122045005.14617-3-yangtiezhu@loongson.cn>
 <20241126064513.bf6yq56eklyo4xvt@jpoimboe>
 <bb36374e-aca2-92e1-209d-1524e31147ab@loongson.cn>
 <20241126143243.GN38837@noisy.programming.kicks-ass.net>
 <20241126152207.GR38972@noisy.programming.kicks-ass.net>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>, Huacai Chen
 <chenhuacai@kernel.org>, loongarch@lists.linux.dev,
 linux-kernel@vger.kernel.org
From: Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <e05c2f25-c378-be47-1138-a1a86b03fad6@loongson.cn>
Date: Wed, 27 Nov 2024 13:45:56 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20241126152207.GR38972@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowMCxS+AUskZny4BpAA--.23652S3
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoW7CFy8KFW3XFy7XF1ruw45Arc_yoW8Xw48pF
	Z7C3WkAF48WrW0y3ZFyryxWFW7Jr4xGr12ga48WrykA3WjqFnaqrsagws0kFy8WwnaqFy0
	qFyFg3s0qFyjy3XCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUvFb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27w
	Aqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE
	14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1c
	AE67vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8C
	rVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtw
	CIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x02
	67AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr
	0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxU7_Ma
	UUUUU

On 11/26/2024 11:22 PM, Peter Zijlstra wrote:
>
>> I was poking at the reachable annotations and ended up with this:
>
> Also see here:
>
>   https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git/log/?h=objtool/core
>
> Once the robots agree it all compiles, I'll post.

There are many changes of tools/objtool/check.c in your tree,
I assume the patches in objtool/core tree is to target 6.13-rc1,
it failed when compiling on LoongArch:

   arch/loongarch/include/asm/bug.h:49:60: error: expected ‘:’ or ‘)’ 
before ‘;’ token
   {standard input}:682: Error: no match insn: break	1.pushsection 
.discard.annotate_insn,"M",@progbits,8

I think it needs to do the following changes, please squash them to
your original commit if possible, thanks.

diff --git a/arch/loongarch/include/asm/bug.h 
b/arch/loongarch/include/asm/bug.h
index dfb0cfccf36e..e5d888cb738f 100644
--- a/arch/loongarch/include/asm/bug.h
+++ b/arch/loongarch/include/asm/bug.h
@@ -40,13 +40,14 @@

  #define __BUG_FLAGS(flags, extra)                                      \
         asm_inline volatile (__stringify(ASM_BUG_FLAGS(flags))          \
+                            "\n"                                       \
                              extra);

  #define __WARN_FLAGS(flags)                                    \
  do {                                                           \
         instrumentation_begin();                                \
         __BUG_FLAGS(BUGFLAG_WARNING|(flags),                    \
-                   __ANNOTATE_REACHABLE(__ASM_BREF(10001));    \
+                   __ANNOTATE_REACHABLE(__ASM_BREF(10001)));   \
         instrumentation_end();                                  \
  } while (0)

By the way, there are a lot of new objtool warnings

   Unkonwn annotation type: 8

on LoongArch when compiling the code of your tree.

Thanks,
Tiezhu


