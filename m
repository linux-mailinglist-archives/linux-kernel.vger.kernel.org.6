Return-Path: <linux-kernel+bounces-236911-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ADDF91E889
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 21:23:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8DEAE1C21BB8
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 19:23:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9938116F831;
	Mon,  1 Jul 2024 19:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V4zL0wr+"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6BD616F830
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 19:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719861780; cv=none; b=hEySwNAkbpFDhjFdFKKqwb2dNjSvCJ2LVvIgY931geHrTeZCIrUNYkAgVz8D4sQl5o9e/BHVZUrZEHwvY5aMgTl+qn8dyyfsNL30OfidUAl5ohHOFn8SxmzrvPiJn5/7KOUIV9Y2QkqWatd+TQj3vEy+NOI9Aqf/sv9nz0rBy+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719861780; c=relaxed/simple;
	bh=JD+5hKf7n7sZ/VmdILjFX64IOBcqd5WysqGq+vOvRJg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VRGI4iYZAj+RYPaPoSdxuEOCv5yTTPBIJBAHAPkC9spgNzO9Xlyub3raa+zkahWrcD8saQowYJBF41rTDMMNXswhJn0YI/KKB7EEgrsHnUOpWeCl73VEXixfQ7l45otFKe0J4sukImK+klx2p8OkFPSeqjaHNZA8MMCG258J/yE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V4zL0wr+; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2ec5fad1984so47088961fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2024 12:22:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719861777; x=1720466577; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lbh8hX0qzUHdhIgTM8xIxkZogBqLi1y5Q8ypfEhDMeA=;
        b=V4zL0wr+jPI1bWgbcjjJfoOCcud0ATHp/Fdru/3qM9+gT+Eq3iPW/3Jt5th5DueJdR
         BxSdBuZPbJGbAcisEaEly+O8DkoU3/PbaDq8givRfgQ36HQIrIGLTWPhO8sr93uYrV8E
         t8C8quj1ZLgHLPYeRzgbNpd9CveAr37p1GGziK4wpNWDKWDIk+rLPREItgYkO1ZcjGi/
         JNLWwMCVeA/bqUSMWZIExFS7j2JkXU/0zEkjsGGQhavAsDh3jYD4mrcWknq/JROyBYZ0
         VfgKTLdCrB+NnGjCj57FQEaGwZ+f63lS92wuJNVPgUQD1MMAWfxKgsoKaENmNhncb8Xd
         h6VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719861777; x=1720466577;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lbh8hX0qzUHdhIgTM8xIxkZogBqLi1y5Q8ypfEhDMeA=;
        b=OAqJBiKjcwuTkVv63OumRshmzYivud897tSnJ8wsn/C/ZysMZAsI88hRRc0nsPNEc8
         i7Pmx8lJTUjMKIOMfKjNZKNLlChgu86Djar8ojHG0GeX73dZldEBORIjMeeuunNhHHvU
         0lirMYKdt6r7h0nSlUzItqTqqcamTZeDra2/QprVhFV+Pueea++ASje9TQ3Nk7kZQSzq
         34EgHSe6fTbKr8gAzoZJmuET9+F6zB8iZRmWJrgWRzZEvWpCLuV9fi9BF0gOqqDLHuT6
         Yu0kQELFCdP9C9aCewnXojvBqTT1Xhi49rO1+qToL5RpicmnLygc32T7GloFPbUljmd9
         X2iQ==
X-Forwarded-Encrypted: i=1; AJvYcCX9p0bQoTaP6pONuD7zbqzsGeHHMubEQFZA88hnTYK9gjtCm3gIjGTq9y04vynnA7aBI/m6XhqH4Oh+XUZjnFvsScc49r1l7W/i9kp7
X-Gm-Message-State: AOJu0YxZ5jO+9MCRwn0RbcWy0bWc3qoEvbAqiazJUn3bGbgEBlyMdU7f
	H+xbOzT8Qxe3jIfRf60Qn4wPkVSZceT0k7sLUerXZY3i4zjImMz3e+gaIoStwH3tyc8uESXcIuv
	BWVIMdxHr6QaRWaryOaaqhI2BRw==
X-Google-Smtp-Source: AGHT+IF8qmZQbtsjtdGnink3F1yfIi0aSlVCfTC5WxWolMkswxMb7qCmAmD2I+dWHcyBcf1YGMmQHTLX/GrrXiPaE+I=
X-Received: by 2002:a05:6512:4013:b0:52e:7f18:176b with SMTP id
 2adb3069b0e04-52e8264dacbmr5917462e87.11.1719861776592; Mon, 01 Jul 2024
 12:22:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240701-fix-dosemu-vm86-v3-1-b1969532c75a@linux.intel.com>
In-Reply-To: <20240701-fix-dosemu-vm86-v3-1-b1969532c75a@linux.intel.com>
From: Brian Gerst <brgerst@gmail.com>
Date: Mon, 1 Jul 2024 15:22:44 -0400
Message-ID: <CAMzpN2iJHO01499VsarF1a3ZyjCLUn36FpNqEZeAaXuCoc9GwA@mail.gmail.com>
Subject: Re: [PATCH v3] x86/entry_32: Move CLEAR_CPU_BUFFERS before restoring segments
To: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Cc: Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
	linux-kernel@vger.kernel.org, x86@kernel.org, 
	Robert Gill <rtgill82@gmail.com>, Jari Ruusu <jariruusu@protonmail.com>, 
	"Linux regression tracking (Thorsten Leemhuis)" <regressions@leemhuis.info>, antonio.gomez.iglesias@linux.intel.com, 
	daniel.sneddon@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 1, 2024 at 2:34=E2=80=AFPM Pawan Gupta
<pawan.kumar.gupta@linux.intel.com> wrote:
>
> Robert Gill reported below #GP when dosemu software was executing vm86()
> system call:
>
>   general protection fault: 0000 [#1] PREEMPT SMP
>   CPU: 4 PID: 4610 Comm: dosemu.bin Not tainted 6.6.21-gentoo-x86 #1
>   Hardware name: Dell Inc. PowerEdge 1950/0H723K, BIOS 2.7.0 10/30/2010
>   EIP: restore_all_switch_stack+0xbe/0xcf
>   EAX: 00000000 EBX: 00000000 ECX: 00000000 EDX: 00000000
>   ESI: 00000000 EDI: 00000000 EBP: 00000000 ESP: ff8affdc
>   DS: 0000 ES: 0000 FS: 0000 GS: 0033 SS: 0068 EFLAGS: 00010046
>   CR0: 80050033 CR2: 00c2101c CR3: 04b6d000 CR4: 000406d0
>   Call Trace:
>    show_regs+0x70/0x78
>    die_addr+0x29/0x70
>    exc_general_protection+0x13c/0x348
>    exc_bounds+0x98/0x98
>    handle_exception+0x14d/0x14d
>    exc_bounds+0x98/0x98
>    restore_all_switch_stack+0xbe/0xcf
>    exc_bounds+0x98/0x98
>    restore_all_switch_stack+0xbe/0xcf
>
> This only happens when VERW based mitigations like MDS, RFDS are enabled.
> This is because segment registers with an arbitrary user value can result
> in #GP when executing VERW. Intel SDM vol. 2C documents the following
> behavior for VERW instruction:
>
>   #GP(0) - If a memory operand effective address is outside the CS, DS, E=
S,
>            FS, or GS segment limit.
>
> CLEAR_CPU_BUFFERS macro executes VERW instruction before returning to use=
r
> space. Move CLEAR_CPU_BUFFERS to the macro RESTORE_REGS such that VERW is
> executed before user segments are restored. In the opportunistic SYSEXIT
> path use CLEAR_CPU_BUFFERS_SAFE that uses %ss instead.
>
> Below are the locations where CLEAR_CPU_BUFFERS* is currently being used:
>
> * entry_INT80_32(), entry_SYSENTER_32() and interrupts (via
>   handle_exception_return) do:
>
> restore_all_switch_stack:
>   [...]
>   RESTORE_REGS pop=3D4 clear_cpu_buf=3D1
>    pop    %ebx
>    pop    %ecx
>    pop    %edx
>    pop    %esi
>    pop    %edi
>    pop    %ebp
>    pop    %eax
>    verw   0xc0fc92c0       <-------------
>    pop    %ds
>    pop    %es
>    pop    %fs
>
> * Opportunistic SYSEXIT explicitly does CLEAR_CPU_BUFFERS_SAFE:
>
>    [...]
>    verw   %ss:0xc0fc92c0  <-------------
>    btrl   $0x9,(%esp)
>    popf
>    pop    %eax
>    sti
>    sysexit
>
> * NMIs use RESTORE_ALL_NMI -> RESTORE_REGS:
>
>    nmi_return:
>    [...]
>    RESTORE_ALL_NMI cr3_reg=3D%edi
>    jmp    0xc0fb22e0 <asm_exc_nmi+612>
>    test   $0x1000,%edi
>    je     0xc0fb22e0 <asm_exc_nmi+612>
>    mov    %edi,%cr3
>    pop    %ebx
>    pop    %ecx
>    pop    %edx
>    pop    %esi
>    pop    %edi
>    pop    %ebp
>    pop    %eax
>    verw   0xc0fc92c0      <-------------
>    pop    %ds
>    pop    %es
>    pop    %fs
>
> Fixes: a0e2dab44d22 ("x86/entry_32: Add VERW just before userspace transi=
tion")
> Cc: stable@vger.kernel.org # 5.10+
> Reported-by: Robert Gill <rtgill82@gmail.com>
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D218707
> Closes: https://lore.kernel.org/all/8c77ccfd-d561-45a1-8ed5-6b75212c7a58@=
leemhuis.info/
> Suggested-by: Dave Hansen <dave.hansen@linux.intel.com>
> Suggested-by: Brian Gerst <brgerst@gmail.com> # Use %ss
> Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
> ---
> v3:
> - Simplify CLEAR_CPU_BUFFERS_SAFE by using %ss instead of %ds (Brian).
> - Do verw before popf in SYSEXIT path (Jari).
>
> v2: https://lore.kernel.org/r/20240627-fix-dosemu-vm86-v2-1-d5579f698e77@=
linux.intel.com
> - Safe guard against any other system calls like vm86() that might change=
 %ds (Dave).
>
> v1: https://lore.kernel.org/r/20240426-fix-dosemu-vm86-v1-1-88c826a3f378@=
linux.intel.com
> ---
>  arch/x86/entry/entry_32.S | 28 ++++++++++++++++++++++------
>  1 file changed, 22 insertions(+), 6 deletions(-)
>
> diff --git a/arch/x86/entry/entry_32.S b/arch/x86/entry/entry_32.S
> index d3a814efbff6..6a135478dc2e 100644
> --- a/arch/x86/entry/entry_32.S
> +++ b/arch/x86/entry/entry_32.S
> @@ -253,6 +253,17 @@
>  .Lend_\@:
>  .endm
>
> +/*
> + * Safer version of CLEAR_CPU_BUFFERS that uses %ss to reference VERW op=
erand
> + * mds_verw_sel. This ensures VERW will not #GP for an arbitrary user %d=
s
> + * value.
> + */
> +.macro CLEAR_CPU_BUFFERS_SAFE
> +       ALTERNATIVE "jmp .Lskip_verw\@", "", X86_FEATURE_CLEAR_CPU_BUF
> +       verw    %ss:_ASM_RIP(mds_verw_sel)
> +.Lskip_verw\@:
> +.endm
> +
>  .macro RESTORE_INT_REGS
>         popl    %ebx
>         popl    %ecx
> @@ -263,8 +274,15 @@
>         popl    %eax
>  .endm
>
> -.macro RESTORE_REGS pop=3D0
> +.macro RESTORE_REGS pop=3D0 clear_cpu_buf=3D0
>         RESTORE_INT_REGS
> +       /*
> +        * CLEAR_CPU_BUFFERS must be done before restoring segment
> +        * registers to avoid #GP when executing VERW with user %ds.
> +        */
> +       .if \clear_cpu_buf
> +       CLEAR_CPU_BUFFERS
> +       .endif
>  1:     popl    %ds
>  2:     popl    %es
>  3:     popl    %fs
> @@ -299,7 +317,7 @@
>
>         BUG_IF_WRONG_CR3
>
> -       RESTORE_REGS pop=3D\pop
> +       RESTORE_REGS pop=3D\pop clear_cpu_buf=3D1
>  .endm
>
>  .macro CHECK_AND_APPLY_ESPFIX
> @@ -871,6 +889,7 @@ SYM_FUNC_START(entry_SYSENTER_32)
>
>         /* Now ready to switch the cr3 */
>         SWITCH_TO_USER_CR3 scratch_reg=3D%eax
> +       CLEAR_CPU_BUFFERS_SAFE
>
>         /*
>          * Restore all flags except IF. (We restore IF separately because
> @@ -881,7 +900,6 @@ SYM_FUNC_START(entry_SYSENTER_32)
>         BUG_IF_WRONG_CR3 no_user_check=3D1
>         popfl
>         popl    %eax
> -       CLEAR_CPU_BUFFERS
>
>         /*
>          * Return back to the vDSO, which will pop ecx and edx.
> @@ -950,8 +968,7 @@ restore_all_switch_stack:
>         BUG_IF_WRONG_CR3
>
>         /* Restore user state */
> -       RESTORE_REGS pop=3D4                      # skip orig_eax/error_c=
ode
> -       CLEAR_CPU_BUFFERS
> +       RESTORE_REGS pop=3D4 clear_cpu_buf=3D1      # skip orig_eax/error=
_code
>  .Lirq_return:
>         /*
>          * ARCH_HAS_MEMBARRIER_SYNC_CORE rely on IRET core serialization
> @@ -1144,7 +1161,6 @@ SYM_CODE_START(asm_exc_nmi)
>
>         /* Not on SYSENTER stack. */
>         call    exc_nmi
> -       CLEAR_CPU_BUFFERS
>         jmp     .Lnmi_return
>
>  .Lnmi_from_sysenter_stack:
>
> ---
> base-commit: f2661062f16b2de5d7b6a5c42a9a5c96326b8454
> change-id: 20240426-fix-dosemu-vm86-dd111a01737e
>
> Best regards,
> --
> Thanks,
> Pawan
>
>

Perhaps I should have been a bit clearer, but I meant adding the SS
override to the VERW instructions in their present locations, instead
of moving it into RESTORE_REGS.  IIRC we don't want data reads
(including stack pops) between the VERW instruction and IRET/SYSEXIT.

Brian Gerst

