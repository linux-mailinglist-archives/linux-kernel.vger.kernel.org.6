Return-Path: <linux-kernel+bounces-267110-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C4CAD940CAB
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 10:59:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01F831C24246
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 08:59:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13267194099;
	Tue, 30 Jul 2024 08:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NkNLVaYn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44B69187844
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 08:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722329980; cv=none; b=YCojnMS1ekYIbaHWgJiKFn4g0nNeGwNjOulG9qB2eEoWtMi6TicCP65YWKTAWpvZ7qFZvRmPbwOu381U3jLjCXU5dEibvafNPNA16F61sZMH9lAz6DWwDSOGQ7RJ1jDSTDkQAHSoZLz3HJhzvQGfO1TgF5/zDRxwIa8s6v1047w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722329980; c=relaxed/simple;
	bh=0m92rbqqV1wbyBHDUCU0Tuxn5HObrChxFv4veJmNHOo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bBieT0D71iGet2g9FQrouuUE4DOEWUMAd5FE3fnGWrJ7KOKaC9UJevw0CMebtfdXl2JkqjEW2YVDQViTu0+15olW8WdntqJLXfXIPZTqszVQRDdBZ/ZCOWE0g6hSxRb44UvVoV6JQUCDO+wR0kSZVHwPBTXWVmeTYnAeJdNoPwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NkNLVaYn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16740C4AF0E
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 08:59:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722329980;
	bh=0m92rbqqV1wbyBHDUCU0Tuxn5HObrChxFv4veJmNHOo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=NkNLVaYn3X7hONkzruko0JXwy6WcBVT77FQ/G2Rpm5GX/E+Ex11YzZRqddbF7XUA/
	 MouLl0ltBQGkmiJUCEiC6dhDqOVMmVPSEJK0ZSvusKpxaafFb4a4y1PzgvKu1oYkuu
	 uwCdfU7ZFmNnUt1U95oVwYFwTSrO4UwTzJvyOg+Zw7Hb1ETYSP13Pf61cinwT8zV26
	 1GYFQfnfLlJ+3p8YBKb1XlnRxZCKWP0b2aheEZUqIWobdU7suuXfqYqxEoJ50lDWef
	 Kr/XMt6bDxBbqa/s4QdJOBMwRsNGu3S/Xm1wXMknIJJluxXLn4U/MoC/1Y/UngefEV
	 mco7Z9ZiF+HhQ==
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2ef2cce8be8so56420251fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 01:59:39 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVI3GrvM2cLan3/A23hC6k2EnPdUGtiv5kBjBZlx1XjoguAOKcH+M1J4XXg7RYR/UiauLcUTOMeGBK/TMLsY5yB6UI8ezZeBSdbRUse
X-Gm-Message-State: AOJu0Yy1bJBXywUpteFPHrYRg0ddyevHYVQn4VRG4l4CN6LQz6oQNa1p
	IGPBfjt52mDQPqM6saL54bsg+ek3hFKHwDoDNMyMf8zqGzCIL+J1boA4NXM4L608uPOfcOFiSdc
	EPQvcWlMw/0huMit/nX5Fy2wvffA=
X-Google-Smtp-Source: AGHT+IE/uFtYHG0S8qOMMrEZXh7KCDFla1LpQPizabpxGRy4b5Wskk1sf8GzVNzM2XUTW6eEcwT82Mh8nfzYsWapEkg=
X-Received: by 2002:a05:651c:a10:b0:2ef:2e8f:73e7 with SMTP id
 38308e7fff4ca-2f12ee2fcdfmr80359841fa.47.1722329978378; Tue, 30 Jul 2024
 01:59:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240730061901.21485-1-yangtiezhu@loongson.cn> <20240730061901.21485-2-yangtiezhu@loongson.cn>
In-Reply-To: <20240730061901.21485-2-yangtiezhu@loongson.cn>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Tue, 30 Jul 2024 16:59:25 +0800
X-Gmail-Original-Message-ID: <CAAhV-H5qoaBwJe929+GnYzbrbmcMgTXy5zL8smXDmOSCtAQntw@mail.gmail.com>
Message-ID: <CAAhV-H5qoaBwJe929+GnYzbrbmcMgTXy5zL8smXDmOSCtAQntw@mail.gmail.com>
Subject: Re: [PATCH 1/2] objtool/LoongArch: Restrict stack operation instruction
To: Tiezhu Yang <yangtiezhu@loongson.cn>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>, Peter Zijlstra <peterz@infradead.org>, loongarch@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Tiezhu,

Can this patch also fix the warnings of ClangBuiltLinux?

Huacai

On Tue, Jul 30, 2024 at 2:19=E2=80=AFPM Tiezhu Yang <yangtiezhu@loongson.cn=
> wrote:
>
> After commit a0f7085f6a63 ("LoongArch: Add RANDOMIZE_KSTACK_OFFSET
> support"), the code flow of do_syscall() was changed when compiled
> with GCC due to the secondary stack of add_random_kstack_offset(),
> something like this:
>
>   addi.d          $sp, $sp, -32
>   st.d            $fp, $sp, 16
>   st.d            $ra, $sp, 24
>   addi.d          $fp, $sp, 32
>   ...
>   sub.d           $sp, $sp, $t1
>   ...
>   addi.d          $sp, $fp, -32
>   ld.d            $ra, $sp, 24
>   ld.d            $fp, $sp, 16
>   addi.d          $sp, $sp, 32
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
> Closes: https://lore.kernel.org/oe-kbuild-all/202407201336.mW8dj1VB-lkp@i=
ntel.com/
> Fixes: b2d23158e6c8 ("objtool/LoongArch: Implement instruction decoder")
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> ---
>  tools/objtool/arch/loongarch/decode.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/tools/objtool/arch/loongarch/decode.c b/tools/objtool/arch/l=
oongarch/decode.c
> index aee479d2191c..6a34af675cee 100644
> --- a/tools/objtool/arch/loongarch/decode.c
> +++ b/tools/objtool/arch/loongarch/decode.c
> @@ -121,8 +121,8 @@ static bool decode_insn_reg2i12_fomat(union loongarch=
_instruction inst,
>  {
>         switch (inst.reg2i12_format.opcode) {
>         case addid_op:
> -               if ((inst.reg2i12_format.rd =3D=3D CFI_SP) || (inst.reg2i=
12_format.rj =3D=3D CFI_SP)) {
> -                       /* addi.d sp,sp,si12 or addi.d fp,sp,si12 */
> +               if ((inst.reg2i12_format.rd =3D=3D CFI_SP) && (inst.reg2i=
12_format.rj =3D=3D CFI_SP)) {
> +                       /* addi.d sp,sp,si12 */
>                         insn->immediate =3D sign_extend64(inst.reg2i12_fo=
rmat.immediate, 11);
>                         ADD_OP(op) {
>                                 op->src.type =3D OP_SRC_ADD;
> --
> 2.42.0
>
>

