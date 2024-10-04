Return-Path: <linux-kernel+bounces-349935-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DC30898FD8E
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 08:54:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 40E541F23853
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 06:54:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC94785260;
	Fri,  4 Oct 2024 06:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gk7KDoGE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E958026281
	for <linux-kernel@vger.kernel.org>; Fri,  4 Oct 2024 06:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728024872; cv=none; b=gK6NBrLYRueVUERkWiXw1FgIniB5sBpLXkqYY9rNRzNT8wBYUMh4OlMwLYHWM01YqcHbiUKYwff3hTRGlri/lLPLBV/nSAKSOHPP6ht2EbxbaKvitP3571AzV2m+kDdJkJeLi71/3yfO1YBp8ZP+SjMzXkCUtpknjWCWuQJmZM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728024872; c=relaxed/simple;
	bh=ouq+tMObfOhhwFeZ7U1REMfL8wkLg2xCuRIcFneHI7U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Yd7Ld0qVhdeNlZ763hCgzo92zRsvGGcaJ5G3sPviywHhf0RZjvrJj7c6MW3rwkkFGAnT/ehf3Okilz9x6M/9h3lLHlxEw+S63+NTz2s0O97zXoDKqPW/6HvbX5sk1C8jDUiyBH2BxLM+OxvPNVoiHTYDuNROBvLTVGNvaksHlHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gk7KDoGE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A1D8C4CECC
	for <linux-kernel@vger.kernel.org>; Fri,  4 Oct 2024 06:54:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728024870;
	bh=ouq+tMObfOhhwFeZ7U1REMfL8wkLg2xCuRIcFneHI7U=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Gk7KDoGEPjRNyAvt61JOlUUPDEwPifBycUL1jPT0uv5K/wlfj4ZA9lXvptLqHd1JR
	 RuW+r4Em2VQArn7pUD4L38AUBOqwKgnFG9ow5IZ6kNTb8vw0xDLUNFMVXXsz/nuFXq
	 Nk9TQP+m1r81olBmDXk9pP60nXFArdvj0Atz+EVMCaJVC6KEwPq+xfffLZIpvVrI3f
	 SDQ/MdFBOlePSxLLYggWy8xZ2rlYQ4t1VbDzPRY75NKZnADf1UIJhmH4TXcVQoCAEe
	 mEVdme4lfAMqazJQUxcA/73UnlNKbm5ErcE9Ws0it9yaz6lUqI0LEN3VMrHR6NkTm3
	 /JGWALp/vSCdw==
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5366fd6fdf1so2529143e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2024 23:54:30 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWx1SdW+s+BSexUBbVHPJvLy5wUau7W3ZhsGtcHFhOdXuQZfD2RsOWKfcjp0o/5kDjAUOUIP2FE2d5a1fA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9Bm36yD22Xyn9dtoeR/Xdmh5Qoz96PKZZAYmt90PpyOoJncgf
	NoObIg8bFcfYaa/eMGKO42o7hBitk0beWdINy3qIDZ1wsMsxaZ8OZ4n35c7yTW1Gy6g2CL4oj3h
	JjBYW5kaPN2t3trBkMemMd21DNNc=
X-Google-Smtp-Source: AGHT+IHh2RYq/S6blclmQ1j/ohwHNA9GgunR03DjrQVI+Vano+50osuzBxYJJbqWD8M5R4vV8vMrqbVxLGQB7wxxu1I=
X-Received: by 2002:a05:6512:12c3:b0:530:ab86:3 with SMTP id
 2adb3069b0e04-539ab84a49bmr939775e87.1.1728024868467; Thu, 03 Oct 2024
 23:54:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <05fd690797ea4e1ee798b7fa497857519ae840d4.1728001850.git.jpoimboe@kernel.org>
In-Reply-To: <05fd690797ea4e1ee798b7fa497857519ae840d4.1728001850.git.jpoimboe@kernel.org>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Fri, 4 Oct 2024 08:54:16 +0200
X-Gmail-Original-Message-ID: <CAMj1kXHt3GTVx-Ow0OZaP4WW7k=RVc+jgtC-4qOSZM3js4jo0g@mail.gmail.com>
Message-ID: <CAMj1kXHt3GTVx-Ow0OZaP4WW7k=RVc+jgtC-4qOSZM3js4jo0g@mail.gmail.com>
Subject: Re: [PATCH] objtool: Detect non-relocated text references
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, 
	Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"

Hi Josh,

On Fri, 4 Oct 2024 at 02:31, Josh Poimboeuf <jpoimboe@kernel.org> wrote:
>
> When kernel IBT is enabled, objtool detects all text references in order
> to determine which functions can be indirectly branched to.
>
> In text, such references look like one of the following:
>
>    mov    $0x0,%rax        R_X86_64_32S     .init.text+0x7e0a0
>    lea    0x0(%rip),%rax   R_X86_64_PC32    autoremove_wake_function-0x4
>
> Either way the function pointer is denoted by a relocation, so objtool
> just reads that.
>
> However there are some "lea xxx(%rip)" cases which don't use relocations
> because they're referencing code in the same translation unit.

input section

> Objtool
> doesn't have visibility to those.
>
> The only currently known instances of that are a few hand-coded asm text
> references which don't actually need ENDBR.  So it's not actually a
> problem at the moment.
>
> However if we enable -fpie, the compiler would start generating them and
> there would definitely be bugs in the IBT sealing.
>

-fpie is guaranteed to break things, but even without it, Clang may
issue RIP-relative LEA instructions (or LLD when it performs
relaxations), so this is definitely worth addressing even if we don't
enable -fpie.

> Detect non-relocated text references and handle them appropriately.
>
> [ Note: I removed the manual static_call_tramp check -- that should
>   already be handled by the noendbr check. ]
>
> Reported-by: Ard Biesheuvel <ardb@kernel.org>
> Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>

Thanks for the quick fix. This addresses the issue I ran into, so

Tested-by: Ard Biesheuvel <ardb@kernel.org>

> ---
>  arch/x86/kernel/acpi/wakeup_64.S     |   1 +
>  arch/x86/kernel/head_64.S            |   1 +
>  tools/objtool/arch/x86/decode.c      |  15 ++--
>  tools/objtool/check.c                | 112 +++++++++++++++------------
>  tools/objtool/include/objtool/arch.h |   1 +
>  5 files changed, 77 insertions(+), 53 deletions(-)
>
> diff --git a/arch/x86/kernel/acpi/wakeup_64.S b/arch/x86/kernel/acpi/wakeup_64.S
> index af2f2ed57658..5e4472f788b3 100644
> --- a/arch/x86/kernel/acpi/wakeup_64.S
> +++ b/arch/x86/kernel/acpi/wakeup_64.S
> @@ -85,6 +85,7 @@ SYM_FUNC_START(do_suspend_lowlevel)
>
>         .align 4
>  .Lresume_point:
> +       ANNOTATE_NOENDBR
>         /* We don't restore %rax, it must be 0 anyway */
>         leaq    saved_context(%rip), %rax
>         movq    saved_context_cr4(%rax), %rbx
> diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
> index 88cdc5a0c7a3..9e95599b58cf 100644
> --- a/arch/x86/kernel/head_64.S
> +++ b/arch/x86/kernel/head_64.S
> @@ -88,6 +88,7 @@ SYM_CODE_START_NOALIGN(startup_64)
>         lretq
>
>  .Lon_kernel_cs:
> +       ANNOTATE_NOENDBR
>         UNWIND_HINT_END_OF_STACK
>
>  #ifdef CONFIG_AMD_MEM_ENCRYPT
> diff --git a/tools/objtool/arch/x86/decode.c b/tools/objtool/arch/x86/decode.c
> index ed6bff0e01dc..fe1362c34564 100644
> --- a/tools/objtool/arch/x86/decode.c
> +++ b/tools/objtool/arch/x86/decode.c
> @@ -456,10 +456,6 @@ int arch_decode_instruction(struct objtool_file *file, const struct section *sec
>                 if (!rex_w)
>                         break;
>
> -               /* skip RIP relative displacement */
> -               if (is_RIP())
> -                       break;
> -
>                 /* skip nontrivial SIB */
>                 if (have_SIB()) {
>                         modrm_rm = sib_base;
> @@ -467,6 +463,12 @@ int arch_decode_instruction(struct objtool_file *file, const struct section *sec
>                                 break;
>                 }
>
> +               /* lea disp(%rip), %dst */
> +               if (is_RIP()) {
> +                       insn->type = INSN_LEA_RIP;
> +                       break;
> +               }
> +
>                 /* lea disp(%src), %dst */
>                 ADD_OP(op) {
>                         op->src.offset = ins.displacement.value;
> @@ -737,7 +739,10 @@ int arch_decode_instruction(struct objtool_file *file, const struct section *sec
>                 break;
>         }
>
> -       insn->immediate = ins.immediate.nbytes ? ins.immediate.value : 0;
> +       if (ins.immediate.nbytes)
> +               insn->immediate = ins.immediate.value;
> +       else if (ins.displacement.nbytes)
> +               insn->immediate = ins.displacement.value;
>
>         return 0;
>  }
> diff --git a/tools/objtool/check.c b/tools/objtool/check.c
> index 94a56099e22d..d33bf36d36a3 100644
> --- a/tools/objtool/check.c
> +++ b/tools/objtool/check.c
> @@ -4354,6 +4354,51 @@ static bool noendbr_range(struct objtool_file *file, struct instruction *insn)
>         return insn->offset == sym->offset + sym->len;
>  }
>
> +static int __validate_ibt_insn(struct objtool_file *file, struct instruction *insn,
> +                              struct instruction *dest)
> +{
> +       if (dest->type == INSN_ENDBR) {
> +               mark_endbr_used(dest);
> +               return 0;
> +       }
> +
> +       if (insn_func(dest) && insn_func(insn) &&
> +           insn_func(dest)->pfunc == insn_func(insn)->pfunc) {
> +               /*
> +                * Anything from->to self is either _THIS_IP_ or
> +                * IRET-to-self.
> +                *
> +                * There is no sane way to annotate _THIS_IP_ since the
> +                * compiler treats the relocation as a constant and is
> +                * happy to fold in offsets, skewing any annotation we
> +                * do, leading to vast amounts of false-positives.
> +                *
> +                * There's also compiler generated _THIS_IP_ through
> +                * KCOV and such which we have no hope of annotating.
> +                *
> +                * As such, blanket accept self-references without
> +                * issue.
> +                */
> +               return 0;
> +       }
> +
> +       /*
> +        * Accept anything ANNOTATE_NOENDBR.
> +        */
> +       if (dest->noendbr)
> +               return 0;
> +
> +       /*
> +        * Accept if this is the instruction after a symbol
> +        * that is (no)endbr -- typical code-range usage.
> +        */
> +       if (noendbr_range(file, dest))
> +               return 0;
> +
> +       WARN_INSN(insn, "relocation to !ENDBR: %s", offstr(dest->sec, dest->offset));
> +       return 1;
> +}
> +
>  static int validate_ibt_insn(struct objtool_file *file, struct instruction *insn)
>  {
>         struct instruction *dest;
> @@ -4366,6 +4411,7 @@ static int validate_ibt_insn(struct objtool_file *file, struct instruction *insn
>          * direct/indirect branches:
>          */
>         switch (insn->type) {
> +
>         case INSN_CALL:
>         case INSN_CALL_DYNAMIC:
>         case INSN_JUMP_CONDITIONAL:
> @@ -4375,6 +4421,23 @@ static int validate_ibt_insn(struct objtool_file *file, struct instruction *insn
>         case INSN_RETURN:
>         case INSN_NOP:
>                 return 0;
> +
> +       case INSN_LEA_RIP:
> +               if (!insn_reloc(file, insn)) {
> +                       /* local function pointer reference without reloc */
> +
> +                       off = arch_jump_destination(insn);
> +
> +                       dest = find_insn(file, insn->sec, off);
> +                       if (!dest) {
> +                               WARN_INSN(insn, "corrupt function pointer reference");
> +                               return 1;
> +                       }
> +
> +                       return __validate_ibt_insn(file, insn, dest);
> +               }
> +               break;
> +
>         default:
>                 break;
>         }
> @@ -4385,13 +4448,6 @@ static int validate_ibt_insn(struct objtool_file *file, struct instruction *insn
>                                               reloc_offset(reloc) + 1,
>                                               (insn->offset + insn->len) - (reloc_offset(reloc) + 1))) {
>
> -               /*
> -                * static_call_update() references the trampoline, which
> -                * doesn't have (or need) ENDBR.  Skip warning in that case.
> -                */
> -               if (reloc->sym->static_call_tramp)
> -                       continue;
> -
>                 off = reloc->sym->offset;
>                 if (reloc_type(reloc) == R_X86_64_PC32 ||
>                     reloc_type(reloc) == R_X86_64_PLT32)
> @@ -4403,47 +4459,7 @@ static int validate_ibt_insn(struct objtool_file *file, struct instruction *insn
>                 if (!dest)
>                         continue;
>
> -               if (dest->type == INSN_ENDBR) {
> -                       mark_endbr_used(dest);
> -                       continue;
> -               }
> -
> -               if (insn_func(dest) && insn_func(insn) &&
> -                   insn_func(dest)->pfunc == insn_func(insn)->pfunc) {
> -                       /*
> -                        * Anything from->to self is either _THIS_IP_ or
> -                        * IRET-to-self.
> -                        *
> -                        * There is no sane way to annotate _THIS_IP_ since the
> -                        * compiler treats the relocation as a constant and is
> -                        * happy to fold in offsets, skewing any annotation we
> -                        * do, leading to vast amounts of false-positives.
> -                        *
> -                        * There's also compiler generated _THIS_IP_ through
> -                        * KCOV and such which we have no hope of annotating.
> -                        *
> -                        * As such, blanket accept self-references without
> -                        * issue.
> -                        */
> -                       continue;
> -               }
> -
> -               /*
> -                * Accept anything ANNOTATE_NOENDBR.
> -                */
> -               if (dest->noendbr)
> -                       continue;
> -
> -               /*
> -                * Accept if this is the instruction after a symbol
> -                * that is (no)endbr -- typical code-range usage.
> -                */
> -               if (noendbr_range(file, dest))
> -                       continue;
> -
> -               WARN_INSN(insn, "relocation to !ENDBR: %s", offstr(dest->sec, dest->offset));
> -
> -               warnings++;
> +               warnings += __validate_ibt_insn(file, insn, dest);
>         }
>
>         return warnings;
> diff --git a/tools/objtool/include/objtool/arch.h b/tools/objtool/include/objtool/arch.h
> index 0b303eba660e..d63b46a19f39 100644
> --- a/tools/objtool/include/objtool/arch.h
> +++ b/tools/objtool/include/objtool/arch.h
> @@ -28,6 +28,7 @@ enum insn_type {
>         INSN_CLD,
>         INSN_TRAP,
>         INSN_ENDBR,
> +       INSN_LEA_RIP,
>         INSN_OTHER,
>  };
>
> --
> 2.46.0
>

