Return-Path: <linux-kernel+bounces-205501-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47FEA8FFCD6
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 09:15:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B35C0B26972
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 07:14:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D97F5153578;
	Fri,  7 Jun 2024 07:14:51 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83B9B14F9CE
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 07:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717744491; cv=none; b=YP36oq0fB2Tza3mpBqmAyuzbtcdNutx/jHjVXdCmkGpBf3Cl+wWlftA4LadZxdcETXbcFNolzYzrhdichXFrox9xM4z4qf0P6JNCsjAQ0Z7+4NrbsLIaWOcQBHp7xMgN3FAdInOgoOBeHUTrWOxpBZM0ZKYzIwsQUiW0DcVmSKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717744491; c=relaxed/simple;
	bh=noukMO3+jRs+9c7owGXF7Wluq9C2LqsXKD62IPTB79w=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=gCBJXNNj9hXT6lWY2PQTTbg+fPcUMuLApQwPm6EkkIZYuzYhOsKnMJsCs9HP09szNAf5xpk5X1L+/uSRbenUxPAba8N9d7hng5wLiLkT15HoLdq+tmzKENC8H9B3d/0LApLc9GsEKpm/msteEu6XO5muM6iUJtW5ck3mjSFYID4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [111.9.175.10])
	by gateway (Coremail) with SMTP id _____8AxHutms2Jm8ogEAA--.19052S3;
	Fri, 07 Jun 2024 15:14:46 +0800 (CST)
Received: from [10.136.12.26] (unknown [111.9.175.10])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8Bxnsdhs2JmmOkXAA--.60131S3;
	Fri, 07 Jun 2024 15:14:44 +0800 (CST)
Subject: Re: [PATCH] loongarch: Only select HAVE_OBJTOOL and allow ORC
 unwinder if the inline assembler supports R_LARCH_{32,64}_PCREL
To: Xi Ruoyao <xry111@xry111.site>, Nathan Chancellor <nathan@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>
Cc: Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>,
 Tiezhu Yang <yangtiezhu@loongson.cn>,
 Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling
 <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 Youling Tang <tangyouling@kylinos.cn>, loongarch@lists.linux.dev,
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
 mengqinggang@loongson.cn, cailulu@loongson.cn, wanglei@loongson.cn,
 luweining@loongson.cn, Yujie Liu <yujie.liu@intel.com>,
 Heng Qi <hengqi@linux.alibaba.com>, Tejun Heo <tj@kernel.org>
References: <20240604150741.30252-1-xry111@xry111.site>
 <20240605054328.GA279426@thelio-3990X>
 <b55b8cb2c52f2c3701c83353586130b8dc237ee2.camel@xry111.site>
 <20240605062548.GF279426@thelio-3990X>
 <f8ef61773b0119b8573fc0fed9ad0a8b43061efd.camel@xry111.site>
 <444ec2031ef6ca016cbfa8dfedc51bddc8529ba7.camel@xry111.site>
 <ada035690e446909c3cdbf9a43a92def96020615.camel@xry111.site>
 <82b7e6ea-c2cb-6364-ebe9-bff928028408@loongson.cn>
 <1c132209a612e2e8953f0b458fc01853120db9a9.camel@xry111.site>
 <2bf11cd2-8449-acda-f5ad-659c38cb018e@loongson.cn>
 <96a2e8a80c06772b64fcbdba42e1dae2d68a53a7.camel@xry111.site>
From: Jinyang He <hejinyang@loongson.cn>
Message-ID: <2bd6ae20-ec56-c1a2-c5dd-e8c978a376d3@loongson.cn>
Date: Fri, 7 Jun 2024 15:14:41 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <96a2e8a80c06772b64fcbdba42e1dae2d68a53a7.camel@xry111.site>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID:AQAAf8Bxnsdhs2JmmOkXAA--.60131S3
X-CM-SenderInfo: pkhmx0p1dqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBj93XoWxZrWDZF1xWFy3GF15AF15Jrc_yoW5uF4rpr
	4rGr4UJryUJr18Ar1Utr1UWryUJr1UJw1UJr4DJFyUJr1UGryjqF1UXr4j9r18Jr4kJw1j
	vr1UJryUZFyDJFcCm3ZEXasCq-sJn29KB7ZKAUJUUUU3529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUPIb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2kKe7AKxVWUAVWUtwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
	AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
	AVWUtwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI4
	8JMxk0xIA0c2IEe2xFo4CEbIxvr21lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vI
	r41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAFwI0_JF0_Jw1lx2IqxVAqx4xG67
	AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIY
	rxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14
	v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8
	JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07j0mhrUUU
	UU=


On 2024-06-07 13:42, Xi Ruoyao wrote:
> On Thu, 2024-06-06 at 10:10 +0800, Jinyang He wrote:
>> What I just confused is that there is no ".cfi_*"
>> in the eplogue by clang, which may cause wrong backtrace if gdb set
>>
>> breakpoint there and backtrace. (But this is out of this topic.)
> I don't think it'll cause wrong backtrace.  The real assemble code has
> restored the registers and missing .cfi_restore will just make unwinder
> restore them again.  There are redundant works but not breakages.

$ cat hello.c:
extern void __attribute__((noinline)) foo() {}
int main() {
   foo();
   return (int)(long)__builtin_frame_address(0);
}
$ clang hello.c -S -g -o hello.s -O0 -fPIC
$ cat hello.s:
[...]
         addi.d  $sp, $sp, -32
         .cfi_def_cfa_offset 32
         st.d    $ra, $sp, 24                    # 8-byte Folded Spill
         st.d    $fp, $sp, 16                    # 8-byte Folded Spill
         .cfi_offset 1, -8
         .cfi_offset 22, -16
         addi.d  $fp, $sp, 32
         .cfi_def_cfa 22, 0
         move    $a0, $zero
         st.w    $a0, $fp, -20
.Ltmp2:
         .loc    0 3 3 prologue_end              # hello.c:3:3
         bl      %plt(foo)
         .loc    0 4 21                          # hello.c:4:21
         move    $a0, $fp
         .loc    0 4 3 is_stmt 0                 # hello.c:4:3
         addi.w  $a0, $a0, 0
         ld.d    $fp, $sp, 16                    # 8-byte Folded Reload
<use gdb and set break ponint there>
         ld.d    $ra, $sp, 24                    # 8-byte Folded Reload
         .loc    0 4 3 epilogue_begin            # hello.c:4:3
         addi.d  $sp, $sp, 32
         ret
[...]

So how unwinder do if we <use gdb and set break ponint there>? I think
if we not give ".cfi_restore 22" or others info, it will consider
   1) the $ra is in cfa-8
   2) the cfa is $fp
So it will get $ra by $ra = *(long*)($fp-8). So it may unwind failed
because $fp has been restored and not the CFA now.

> For objtool the main difference seems a thing explained in
> https://maskray.me/blog/2020-11-08-stack-unwinding by Fangrui:
>
>     Note: on RISC-V and LoongArch, the stack slot for the previous frame
>     pointer is stored at fp[-2] instead of fp[0]. See [Consider
>     standardising which stack slot fp points
>     to](https://github.com/riscv-non-isa/riscv-elf-psabi-doc/issues/18)
>     for the RISC-V discussion.

In most cases the $fp is saved at cfa-16. But for va args, something
becomes different at LoongArch (I do not know the case of riscv), the
$fp isn't saved at cfa-16. (e.g. printk?)

> So perhaps we just need to code a constant named "PREV_BP_OFFSET"
Can you give some detail?
>   or
> something in arch/ and use it in update_cfi_state() instead of fully re-
> implement the entire function?

I feel that the update_cfi_state should be arch specific. I believe
that some logic can be reused, but each arch may have its own logic.


Thanks,
Jinyang


