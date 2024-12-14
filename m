Return-Path: <linux-kernel+bounces-445818-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AD3ED9F1BD9
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 02:17:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F032C188EE56
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 01:17:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C400D531;
	Sat, 14 Dec 2024 01:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OGCfjoTG"
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8E7CBE65
	for <linux-kernel@vger.kernel.org>; Sat, 14 Dec 2024 01:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734139055; cv=none; b=eW961m05aYXH2pbRhbrG7Cwh5s802UvL/JThkOitWcBOCXY4IN0fGimZTTdZNGItZz/kdSUfUSAC9P3DaNsMK7G1wRztZBStSdHc4RIbmYuQ9VWrLp8G6ijjVe5frZ8Luu7knqrN2osDin4RwH6as0mOdNHIPRQZBUwXbpR0/hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734139055; c=relaxed/simple;
	bh=zvV3fXC30TMrRYqMoz4v0+NC5nD3eorhFPR+zVu+2Mc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EjdorFgyDQVsElSSQPvac2znqeOg0RpiWs3sTUKBFqDA+uGyXmSp+qWQDbVXUsTLweHAkNdMZhYHSqALLnDxr1Vpt4NiaM+7f2ei6Q7vR6cB6FsITXAGC+j9M9Zi6XWEaCk/I4pLETUFinUKNrBmktXSVk4yKN2n4qiPBxcYvQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OGCfjoTG; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-6ef81222aaaso23604747b3.3
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 17:17:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734139053; x=1734743853; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vtKjar4asUPJ7u0+3XB0AYx0nZ2hIfbR5MHoHI1701o=;
        b=OGCfjoTGkFyWFU8w9IzM3NvstwbKcQYazY/BJxKf2Uh1qivFV2pT7PtAEJ4ril8vcc
         WBFZrwXMbOnZ0HW2xlUCUAlL3ek9aRa+58d6mjhIM+zSiwgvWwmgdDa4uAH7G/PBJe05
         V+sN8uKl5Q20YjnVGk7C+rdhDPqCjsVfLMxyUNhstdlp9WofVo1B7yQ0o3jFFUgmYpVK
         PQmyT7ZvaJaCqD1G54HQjOr32zde4TWFcVAef5ylZntb9uJF/qpoDAt7UrjqRL7RKJyZ
         9oqC0ZBtyIyqwHZg71wWbbXwggO9DGcrhUCr8V5QWBA9s3xP0KFUAmYnQjdJ3R/NiPYM
         NZzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734139053; x=1734743853;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vtKjar4asUPJ7u0+3XB0AYx0nZ2hIfbR5MHoHI1701o=;
        b=bsZFY5RSxvksJ16dtxhIRvaOd5NlJ1fxCGuO4M9H35VcxniU9+lWA8fZkQ87oiuyHE
         BiowhRiZwez98EU9QL+bE6jtUGuH4Yz+DmXg4CPo80WnuNyq72CFo4BvzePuAoZGK6nw
         l+G8191seCtieroEi2/O15a4F1XNMtIbH2H6jCraSzfkoiWYeQpWNL3ifnyDGlIOxtJp
         LDsx0mqDBkDnxvjMcEp0dsojJ53IePB2t5qd6M3nuvJcJYh4jzpyf3Z98docQkHzU/Z9
         G8R2TkEG6iV+5gq7pgur8rvlfqS8IalOAh6zMdX3SDWYmI/02MehaS5xvlnGnRBzakoq
         DqUQ==
X-Forwarded-Encrypted: i=1; AJvYcCVQD7Dd9h6i+Hn2UBxjU4z4Iv1S8abAtA8mlxZ3GbKdxjb6ygU35rC7ahWw2JtPx+JQ7BrlfTIKyftbJDs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4oVtgzeuGyInLRC3rXzqZzS4dxtRQCMHnjedC0lDGnLGel4gb
	VH38Av/LU2O+R3Tixm99C/eMKaS+jOITol+Md5U2d2sm0N8tYDkwDGz9bErSakZlK87ejoaE/N2
	CM+iThSPizLB2zRJe9ieoJz+20l8=
X-Gm-Gg: ASbGncsRNdAyOmW5nbRHZ6v2Lkk0qJbLJOouRhOEsF3RvgKIeVID70sVxLR18fuD0fK
	LK6Oh8J+vVvp7/MhmcHpv/wbBRJArKOytch5zBQ==
X-Google-Smtp-Source: AGHT+IGx8LC/CRCgIe9q+/ZxjZymN2o97o+UNsMzjLLpw6srLNsZFkW9pEfsMxc4DKEJUcLF51XcuKt8zs1aVa5Z0/0=
X-Received: by 2002:a05:690c:c08:b0:6ef:5ca3:d109 with SMTP id
 00721157ae682-6f279b05346mr45683107b3.10.1734139052657; Fri, 13 Dec 2024
 17:17:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241213190119.3449103-1-matt@readmodwrite.com>
In-Reply-To: <20241213190119.3449103-1-matt@readmodwrite.com>
From: Uros Bizjak <ubizjak@gmail.com>
Date: Sat, 14 Dec 2024 02:17:07 +0100
Message-ID: <CAFULd4Zrnn=1=1AP329Qw23b0Ume2A5Z-U2q-M62L1gcpJD4pg@mail.gmail.com>
Subject: Re: CONFIG_KASAN triggers ASAN bug in GCC 13.3.0 and 14.1.0
To: Matt Fleming <matt@readmodwrite.com>
Cc: Ingo Molnar <mingo@kernel.org>, Jakub Jelinek <jakub@redhat.com>, linux-kernel@vger.kernel.org, 
	kernel-team@cloudflare.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 13, 2024 at 8:01=E2=80=AFPM Matt Fleming <matt@readmodwrite.com=
> wrote:
>
> Hi everyone,
>
> I've run into following Oops when running with KASAN enabled:
>
>   [   22.938710][    T0] Oops: general protection fault, probably for non=
-canonical address 0xdffffc00000087c8: 0000 [#1] PREEMPT SMP KASAN NOPTI
>   [   22.939369][    T0] KASAN: probably user-memory-access in range [0x0=
000000000043e40-0x0000000000043e47]
>   [   22.939369][    T0] CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Not tainted=
 6.12.1-cloudflare-kasan-2024.11.20 #1
>   [   22.939369][    T0] Hardware name: MACHINE, BIOS VERSION 09/04/2024
>   [   22.939369][    T0] RIP: 0010:switch_mm_irqs_off+0x43/0xd70
>   [   22.939369][    T0] Code: 48 83 ec 20 48 c7 c0 40 3e 04 00 65 48 8b =
1d 14 41 91 77 48 ba 00 00 00 00 00 fc ff df 65 44 0f b7 25 11 41 91 77 48 =
c1 e8 03 <0f> b6 04 10 84 c0 74 06 0f 8e be 09 00 00 65 44 0f b6 2d a6 41 9=
1
>   [   22.939369][    T0] RSP: 0000:ffffffff8ce07e00 EFLAGS: 00010012
>   [   22.939369][    T0] RAX: 00000000000087c8 RBX: ffffffff8d20a740 RCX:=
 0000001850076000
>   [   22.939369][    T0] RDX: dffffc0000000000 RSI: ffffffff8d7a28c0 RDI:=
 0000000000000000
>   [   22.939369][    T0] RBP: ffffffff8d7a28c0 R08: 00000000aa299018 R09:=
 e4977f26b7bc541a
>   [   22.939369][    T0] R10: ffffffff8ce07e00 R11: 8000000000000063 R12:=
 0000000000000000
>   [   22.939369][    T0] R13: 0000001850076000 R14: 0000000000000000 R15:=
 ffff889850076000
>   [   22.939369][    T0] FS:  0000000000000000(0000) GS:ffff8887efa00000(=
0000) knlGS:0000000000000000
>   [   22.939369][    T0] CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003=
3
>   [   22.939369][    T0] CR2: ffff88c04f1ff000 CR3: 00000037f4852001 CR4:=
 0000000000770ef0
>   [   22.939369][    T0] PKRU: 55555554
>   [   22.939369][    T0] Call Trace:
>   [   22.939369][    T0]  <TASK>
>   [   22.939369][    T0]  ? __die_body.cold+0x19/0x21
>   [   22.939369][    T0]  ? die_addr+0x46/0x70
>   [   22.939369][    T0]  ? exc_general_protection+0x119/0x210
>   [   22.939369][    T0]  ? asm_exc_general_protection+0x26/0x30
>   [   22.939369][    T0]  ? switch_mm_irqs_off+0x43/0xd70
>   [   22.939369][    T0]  ? __pfx_efi_memmap_init_late+0x10/0x10
>   [   22.939369][    T0]  switch_mm+0x14/0x20
>   [   22.939369][    T0]  efi_set_virtual_address_map+0x75/0x180
>   [   22.939369][    T0]  ? srso_alias_return_thunk+0x5/0xfbef5
>   [   22.939369][    T0]  efi_enter_virtual_mode+0x6fb/0x7c0
>   [   22.939369][    T0]  ? alt_reloc_selftest+0x1f/0x50
>   [   22.939369][    T0]  start_kernel+0x323/0x3a0
>   [   22.939369][    T0]  x86_64_start_reservations+0x24/0x30
>   [   22.939369][    T0]  x86_64_start_kernel+0x7f/0x80
>   [   22.939369][    T0]  common_startup_64+0x13e/0x141
>   [   22.939369][    T0]  </TASK>
>
> This was supposed to be fixed by the compiler version check in
> f61f02d1ff78 ("x86/percpu: Re-enable named address spaces with KASAN for
> GCC 13.3+"), but I'm still able to trigger this problem with both GCC
> 14.1.0 and GCC 13.3.0 which include fixes for PR sanitizer/111736.
> (Reverting f61f02d1ff78 obviously prevents the oops)
>
> Here's the assembly that shows the ASAN protection kicking in for the
> per-CPU addresses (cpu_tlbstate):
>
>   ffffffff8112fc40 <switch_mm_irqs_off>:
>   ffffffff8112fc40:       f3 0f 1e fa             endbr64
>   ffffffff8112fc44:       e8 e7 79 fd ff          call   ffffffff81107630=
 <__fentry__>
>   ffffffff8112fc49:       41 57                   push   %r15
>   ffffffff8112fc4b:       41 56                   push   %r14
>   ffffffff8112fc4d:       49 89 d6                mov    %rdx,%r14
>   ffffffff8112fc50:       41 55                   push   %r13
>   ffffffff8112fc52:       41 54                   push   %r12
>   ffffffff8112fc54:       55                      push   %rbp
>   ffffffff8112fc55:       48 89 f5                mov    %rsi,%rbp
>   ffffffff8112fc58:       53                      push   %rbx
>   ffffffff8112fc59:       48 83 ec 20             sub    $0x20,%rsp
>   ffffffff8112fc5d:       48 c7 c0 40 3e 04 00    mov    $0x43e40,%rax
>   ffffffff8112fc64:       65 48 8b 1d 14 41 f1    mov    %gs:0x7ef14114(%=
rip),%rbx        # 43d80 <cpu_tlbstate>
>   ffffffff8112fc6b:       7e
>   ffffffff8112fc6c:       48 ba 00 00 00 00 00    movabs $0xdffffc0000000=
000,%rdx
>   ffffffff8112fc73:       fc ff df
>   ffffffff8112fc76:       65 44 0f b7 25 11 41    movzwl %gs:0x7ef14111(%=
rip),%r12d        # 43d90 <cpu_tlbstate+0x10>
>   ffffffff8112fc7d:       f1 7e
>   ffffffff8112fc7f:       48 c1 e8 03             shr    $0x3,%rax
>   ffffffff8112fc83:       0f b6 04 10             movzbl (%rax,%rdx,1),%e=
ax
>
>          Fault occurs here due to ASAN -----------^
>
>
> Anyone got any ideas how to debug this further?

Does your config include CONFIG_UBSAN_BOOL=3Dy ?

There is a rare interaction between CONFIG_KASAN and CONFIG_UBSAN_BOOL
(aka -fsanitize=3Dbool), reported in [1] and fixed for gcc-14.2 in [2].

[1] https://gcc.gnu.org/bugzilla/show_bug.cgi?id=3D111736#c42

[2] https://gcc.gnu.org/bugzilla/show_bug.cgi?id=3D115172

Otherwise, please attach your .config, and I'll look into this issue.

Thanks,
Uros.

