Return-Path: <linux-kernel+bounces-267152-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A7C12940D9E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 11:30:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5AC65285FA8
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 09:30:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2760119B3C4;
	Tue, 30 Jul 2024 09:28:57 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B628196D8E
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 09:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722331736; cv=none; b=iVpWdB3yS7hw8dG4MlD0Y1RHcAuWHM9h81J1dg8zJxUJvtxjnCTVV1VypS3N1WmOQFH4qCApx8PP5C4yuiu/R6J5c71MvJQii+E43WuKimPnID7sxGKyixh7qTrCSs3W/Fiil/eSHDKW6QszsKgbfTxQUIQWjxx2igzHrHN20Lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722331736; c=relaxed/simple;
	bh=jJ30hZ+t26XjjD5MEcchEPJQEVCFRjcLsT+FDXAQC0w=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=sDGGjdNY7G47e9c45leQ11OmGiHKl1xFhopxJK/+xnbPw+oE27wKi67ri6NFqMgT6PgwIJNmORLns7Yps3JR/800Hqd+Ouj7S/zDZtTfD8A5UXiWgMmbFjM6lijOSutti3dvx9r1N4Ro5mpY3phaIFrDlg46CY9yF+0zp2nHqFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [111.9.175.10])
	by gateway (Coremail) with SMTP id _____8Cxd+lTsqhmBWEEAA--.13754S3;
	Tue, 30 Jul 2024 17:28:51 +0800 (CST)
Received: from [10.136.12.26] (unknown [111.9.175.10])
	by front1 (Coremail) with SMTP id qMiowMCxPsdQsqhmQVYGAA--.31918S3;
	Tue, 30 Jul 2024 17:28:49 +0800 (CST)
Subject: Re: [PATCH 1/2] objtool/LoongArch: Restrict stack operation
 instruction
To: Tiezhu Yang <yangtiezhu@loongson.cn>, Josh Poimboeuf
 <jpoimboe@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Huacai Chen <chenhuacai@kernel.org>
Cc: loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20240730061901.21485-1-yangtiezhu@loongson.cn>
 <20240730061901.21485-2-yangtiezhu@loongson.cn>
From: Jinyang He <hejinyang@loongson.cn>
Message-ID: <4ac60afc-de6b-acf6-c9e6-1f45c0680dbe@loongson.cn>
Date: Tue, 30 Jul 2024 17:28:48 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240730061901.21485-2-yangtiezhu@loongson.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-CM-TRANSID:qMiowMCxPsdQsqhmQVYGAA--.31918S3
X-CM-SenderInfo: pkhmx0p1dqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBj93XoWxXr13Cr1fZr4DXw1kWr4kAFc_yoW5Xw1Upr
	Zru3ZrGFWUWr97uw10qayUWrZ8Grs3XryFgFyftF13Cr13Xrn7Xr1Ig3WjkF1vqws3K3y0
	grWfZF9rJF4qvagCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
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

On 2024-07-30 14:19, Tiezhu Yang wrote:

> After commit a0f7085f6a63 ("LoongArch: Add RANDOMIZE_KSTACK_OFFSET
> support"), the code flow of do_syscall() was changed when compiled
> with GCC due to the secondary stack of add_random_kstack_offset(),
> something like this:
>
>    addi.d          $sp, $sp, -32
>    st.d            $fp, $sp, 16
>    st.d            $ra, $sp, 24
>    addi.d          $fp, $sp, 32
>    ...
>    sub.d           $sp, $sp, $t1
Have you checked the ORC info whether is right or tried backtrace which
passed do_syscall? The "sub.d $sp, $sp, $t1" has modified the $sp so the
$sp cannot express CFA here. This patch just clear the warning but ignore
the validity of ORC info. The wrong ORC info may cause illegally access
memory when backtrace.


Thanks,
Jinyang
>    ...
>    addi.d          $sp, $fp, -32
>    ld.d            $ra, $sp, 24
>    ld.d            $fp, $sp, 16
>    addi.d          $sp, $sp, 32
>
> fp points to the stack top, it is only used to save and restore the
> original sp and is not used as cfa base for arch_callee_saved_reg().
> In the case OP_SRC_ADD of update_cfi_state(), the above rare case is
> not handled so that lead to a wrong stack size, then there exists a
> objtool warning "do_syscall+0x11c: return with modified stack frame".
>
> Because the fp related instructions do not modify the stack frame,
> no need to decode them, just restrict stack operation instruction
> only with the single case "addi.d sp,sp,si12".
>
> By the way, if fp is used as cfa base for arch_callee_saved_reg()
> (there is no this behavior on LoongArch at present), then it needs
> to decode the related instructions and modify update_cfi_state().
>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202407201336.mW8dj1VB-lkp@intel.com/
> Fixes: b2d23158e6c8 ("objtool/LoongArch: Implement instruction decoder")
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> ---
>   tools/objtool/arch/loongarch/decode.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/tools/objtool/arch/loongarch/decode.c b/tools/objtool/arch/loongarch/decode.c
> index aee479d2191c..6a34af675cee 100644
> --- a/tools/objtool/arch/loongarch/decode.c
> +++ b/tools/objtool/arch/loongarch/decode.c
> @@ -121,8 +121,8 @@ static bool decode_insn_reg2i12_fomat(union loongarch_instruction inst,
>   {
>   	switch (inst.reg2i12_format.opcode) {
>   	case addid_op:
> -		if ((inst.reg2i12_format.rd == CFI_SP) || (inst.reg2i12_format.rj == CFI_SP)) {
> -			/* addi.d sp,sp,si12 or addi.d fp,sp,si12 */
> +		if ((inst.reg2i12_format.rd == CFI_SP) && (inst.reg2i12_format.rj == CFI_SP)) {
> +			/* addi.d sp,sp,si12 */
>   			insn->immediate = sign_extend64(inst.reg2i12_format.immediate, 11);
>   			ADD_OP(op) {
>   				op->src.type = OP_SRC_ADD;


