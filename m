Return-Path: <linux-kernel+bounces-294752-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCA97959211
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 03:12:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 836BE2830E0
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 01:12:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17E051E504;
	Wed, 21 Aug 2024 01:12:50 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 805881803E
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 01:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724202769; cv=none; b=QW8j4PGJn8JZXxpqKKWNLSbiaAx1AQOaj9zUiORx7o5AhKaEobkvp3AQ+/TOlh16zHOlM2tUDO8gKtRrWKvYXg3rtPtvP4PWASe+6M8XHK96lqCd7F3rDjJY2DyfKDDv+2Uvx0Q+Pf0MZqe6HS0A1MhuXSYwoyDi0Ua2+qvkv10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724202769; c=relaxed/simple;
	bh=93ucYNzm6rjFAJLlmlDLDdpg7flXKMWTpnKPf5+hKCg=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=jyCHS9d3HhV2h4c2t1gMmHVaHXPJjKM1uqGfDUPJVHx5KYZVV64RYhr9sW6GUefsb6GqDar0JGrx2xvrGR/P1zBjyyJylkkTEa6UUWWqm2r6hZ57F3tbKtkCz7rRL4b3RuRR7wztorfBImhwUo7k/vlSVrRw2PYOkbUSC1/RrHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.20.42.62])
	by gateway (Coremail) with SMTP id _____8AxGuoGP8VmzLsaAA--.58021S3;
	Wed, 21 Aug 2024 09:12:38 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
	by front1 (Coremail) with SMTP id qMiowMAxVOAEP8VmLB8cAA--.59112S3;
	Wed, 21 Aug 2024 09:12:36 +0800 (CST)
Subject: Re: [PATCH v1 2/2] LoongArch: Add ifdefs to fix LSX and LASX related
 issues
To: Tiezhu Yang <yangtiezhu@loongson.cn>, Huacai Chen <chenhuacai@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, loongarch@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20240820123731.31568-1-yangtiezhu@loongson.cn>
 <20240820123731.31568-3-yangtiezhu@loongson.cn>
From: maobibo <maobibo@loongson.cn>
Message-ID: <1d23bbfe-dd36-b2ff-c4b3-cf69396ea53f@loongson.cn>
Date: Wed, 21 Aug 2024 09:12:34 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240820123731.31568-3-yangtiezhu@loongson.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowMAxVOAEP8VmLB8cAA--.59112S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxXr4kKrWkAw17Xr48CF47WrX_yoW5Kw1kpr
	9rArs5tr4ruFnFy3ykAw1kWFZ09397Gr4agF4DtryrCr4qgrnxJr18tF1DXFyjga1xJa1F
	gFZ5Wr4YqayUtwbCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I
	8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AK
	xVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzV
	AYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
	14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIx
	kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAF
	wI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r
	4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8zwZ7UU
	UUU==



On 2024/8/20 下午8:37, Tiezhu Yang wrote:
> There exist some issues when building kernel if CONFIG_CPU_HAS_LBT is set
> but CONFIG_CPU_HAS_LSX and CONFIG_CPU_HAS_LASX are not set. In this case,
> there are no definitions of _restore_lsx and _restore_lasx and there are
> also no definitions of kvm_restore_lsx and kvm_restore_lasx in fpu.S and
> switch.S respectively, just add some ifdefs to fix the issues.
> 
>    AS      arch/loongarch/kernel/fpu.o
> arch/loongarch/kernel/fpu.o: warning: objtool: unexpected relocation symbol type in .rela.discard.func_stack_frame_non_standard: 0
> arch/loongarch/kernel/fpu.o: warning: objtool: unexpected relocation symbol type in .rela.discard.func_stack_frame_non_standard: 0
> 
>    AS [M]  arch/loongarch/kvm/switch.o
> arch/loongarch/kvm/switch.o: warning: objtool: unexpected relocation symbol type in .rela.discard.func_stack_frame_non_standard: 0
> arch/loongarch/kvm/switch.o: warning: objtool: unexpected relocation symbol type in .rela.discard.func_stack_frame_non_standard: 0
> 
>    MODPOST Module.symvers
> ERROR: modpost: "kvm_restore_lsx" [arch/loongarch/kvm/kvm.ko] undefined!
> ERROR: modpost: "kvm_restore_lasx" [arch/loongarch/kvm/kvm.ko] undefined!
> 
> Cc: stable@vger.kernel.org # 6.9+
> Fixes: cb8a2ef0848c ("LoongArch: Add ORC stack unwinder support")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202408120955.qls5oNQY-lkp@intel.com/
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> ---
>   arch/loongarch/kernel/fpu.S | 4 ++++
>   arch/loongarch/kvm/switch.S | 4 ++++
>   2 files changed, 8 insertions(+)
> 
> diff --git a/arch/loongarch/kernel/fpu.S b/arch/loongarch/kernel/fpu.S
> index 69a85f2479fb..6ab640101457 100644
> --- a/arch/loongarch/kernel/fpu.S
> +++ b/arch/loongarch/kernel/fpu.S
> @@ -530,6 +530,10 @@ SYM_FUNC_END(_restore_lasx_context)
>   
>   #ifdef CONFIG_CPU_HAS_LBT
>   STACK_FRAME_NON_STANDARD _restore_fp
> +#ifdef CONFIG_CPU_HAS_LSX
>   STACK_FRAME_NON_STANDARD _restore_lsx
> +#endif
> +#ifdef CONFIG_CPU_HAS_LASX
>   STACK_FRAME_NON_STANDARD _restore_lasx
>   #endif
> +#endif
> diff --git a/arch/loongarch/kvm/switch.S b/arch/loongarch/kvm/switch.S
> index 80e988985a6a..0c292f818492 100644
> --- a/arch/loongarch/kvm/switch.S
> +++ b/arch/loongarch/kvm/switch.S
> @@ -277,6 +277,10 @@ SYM_DATA(kvm_enter_guest_size, .quad kvm_enter_guest_end - kvm_enter_guest)
>   
>   #ifdef CONFIG_CPU_HAS_LBT
>   STACK_FRAME_NON_STANDARD kvm_restore_fpu
> +#ifdef CONFIG_CPU_HAS_LSX
>   STACK_FRAME_NON_STANDARD kvm_restore_lsx
> +#endif
> +#ifdef CONFIG_CPU_HAS_LASX
>   STACK_FRAME_NON_STANDARD kvm_restore_lasx
>   #endif
> +#endif
> 
It is hard to understand to put CONFIG_CPU_HAS_LASX inside 
CONFIG_CPU_HAS_LBT, in general option CONFIG_CPU_HAS_LBT has nothing 
with CONFIG_CPU_HAS_LASX.

Would you like to add parameter func in macro fpu_restore_csr like this?

--- a/arch/loongarch/include/asm/asmmacro.h
+++ b/arch/loongarch/include/asm/asmmacro.h
@@ -55,10 +55,11 @@
  #endif
         .endm

-       .macro fpu_restore_csr thread tmp0 tmp1
+       .macro fpu_restore_csr thread tmp0 tmp1 func
         ldptr.w         \tmp0, \thread, THREAD_FCSR
         movgr2fcsr      fcsr0, \tmp0
  #ifdef CONFIG_CPU_HAS_LBT
+       STACK_FRAME_NON_STANDARD        \func
         /* TM bit is always 0 if LBT not supported */
         andi            \tmp0, \tmp0, FPU_CSR_TM
         beqz            \tmp0, 2f
@@ -282,10 +283,10 @@
         lsx_save_data           \thread, \tmp0
         .endm

Regards
Bibo Mao


