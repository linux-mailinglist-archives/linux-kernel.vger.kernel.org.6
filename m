Return-Path: <linux-kernel+bounces-566153-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D999A673F9
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 13:35:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D15642181B
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 12:35:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7FFB20C015;
	Tue, 18 Mar 2025 12:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aISYJlYF"
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A82CC1714B2
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 12:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742301344; cv=none; b=TQkz97JxqX3iGT/v7Bg37wCPlVhZNuBwgbIPO2e607cXqNM52Px/yOK+gYonaGw9JsObEScq+awNmexCr45WoEY01Egkx4gQrQ9JHCTkb9RWxqtjfa52JHdMp6u9+HzI/7WTVIB8SwEX/PgCErw/Bz7qpQBVdG+K90Mrstq7pe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742301344; c=relaxed/simple;
	bh=usWzQaO8PHBkm1OdlB45bKfs+k8hRXYyxwXZNa9AzKg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZviwIfxQemIkH2SUZRIxZS9OAYuI18887b0y116Q7PXdnvSLlcvA5R7lMXzahZgSpsLTSjfpBXvmQ0Ebjmj/OGl4Lpy6aLrLWSsLY9yWf9iBzCPkMNmzl0hs/a7pAkAMkoEZZ1AW6WRqpBN1SGJAMmdslytsYKFXoOf5DTp/vUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aISYJlYF; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-307c13298eeso63521851fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 05:35:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742301340; x=1742906140; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HPKxNwVUlphbHZXCf6BNgjXG5yYtdP5VAcLw9XeCJSc=;
        b=aISYJlYFioSfOyAoQl78AiH5axRF3KXrBOS88HEwX+uZT4kkv/ERrNCed1xNPmX2BH
         I1ALTueF1EKL7Ape7Ki0k3TkcSAJFaukq+VjmlMR38gxUe/Q2n8NSrDohi3WIsLa/x1x
         mBUN+DrI7Fv88UsU7ssZvzOUldjF37krcBo6bu5m5Nk43I0kMe2TT17tRvGFuSFjK/Ki
         euXQfHfyyQy9FFF0Zg1tIHQwS0qTuJ4bh/24RHZqC2JBM9mpzf3CMeDSrGnb9h2qdSth
         gfvdLqcEjZV+duPdcCDOGBH5IIFYjUO7rOhvfps7nCaEm7rF+3GOFIqoDZjRzXWi9CXn
         iPRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742301340; x=1742906140;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HPKxNwVUlphbHZXCf6BNgjXG5yYtdP5VAcLw9XeCJSc=;
        b=NtgIgY4ueiUc4IjCFJ9gs/OPOhOo8quboYDLJr5eIKf/oGOQjF1b+PJ26CJH+pqsys
         51YlUWgwN0oeqmK2jYncJ+4O9hXrEFZm7T9phNdmOGC6yoCsVmLCvZtTjCu1orAShca0
         eP4WOY8Ccwqa09xnBw3KI6BYVl+bSkH9UFGz4pkeyIX/N1fByqJpUq1Lw1p/7wr6q2it
         C/xul1EKU4FjjWe8nu0nq53BifZPIpBNq0sjWDPT8gAHF9OlqO7rUfQBlr2C1rkkJ2eY
         5624ZR2cOBphjLhxCEAZm9o3ovsXIZnfrzeKeFh6QiKJjsqvXj4IZYWA0G05xApU/YSz
         APNg==
X-Forwarded-Encrypted: i=1; AJvYcCW7v72ULb60Uoh/tZ7Geo6lrjXkdQTD0iO+xIpRCgMmk7v6Blhc/UmS+dUX8CLhHrHFMWFkwjM8kIm2UGs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwClw+QUOCbdJl9dmRUN96SeVQ4HdiHF968P0gQvxvpxLYzFOD
	Ug6dANG7zwT0A17rxKtKqACTuA0VcVkYz/uOCSQ+cR6H2rqlirh16umSqCMyTmPqpyXv23rCBg2
	fVGwSfREJoUNh2UKbbL0vS/gTL7yFwWJsRrM=
X-Gm-Gg: ASbGnctTbhqnCEKPoQrYlUPznC/46ebS3oeXyC1lxDPjszE4r5qimgT9fy8//Plgsx9
	Cvw3ynXdOjnzwkM/Kl6YPPgxzTOZs2j+CnpsOYukm2beirFbs27RahLXw6mJAt0OlTxiNvBiXso
	S7yvUQWeLwbR3pGYkSKbMJ9SYGHg==
X-Google-Smtp-Source: AGHT+IG/IW/n8isTqqAEbQzbEezSkE9pwOPGSiRX4Z+NIpxExPNrigafYV8dc7Pi0eyzuig0lNBP42YSz0Vy9P33S20=
X-Received: by 2002:a2e:9495:0:b0:30b:fc16:d482 with SMTP id
 38308e7fff4ca-30cd95874bemr25794451fa.3.1742301339346; Tue, 18 Mar 2025
 05:35:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250317113013.182359-1-ubizjak@gmail.com> <Z9iuYk-3YNKLAJip@gmail.com>
In-Reply-To: <Z9iuYk-3YNKLAJip@gmail.com>
From: Uros Bizjak <ubizjak@gmail.com>
Date: Tue, 18 Mar 2025 13:35:28 +0100
X-Gm-Features: AQ5f1JrXN4NXCuW4pCCh45LUztUkrBOTZE7ieJUbmO7afPOe2vlyGtN3vjNLp5c
Message-ID: <CAFULd4ZvQkHzvaa_cpbt1x_RAj_7FHb1FyPJxacVOrsK_55=xw@mail.gmail.com>
Subject: Re: [PATCH v2] x86/asm: Use asm_inline() instead of asm() in __untagged_addr()
To: Ingo Molnar <mingo@kernel.org>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, 
	Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 18, 2025 at 12:21=E2=80=AFAM Ingo Molnar <mingo@kernel.org> wro=
te:
>
>
> * Uros Bizjak <ubizjak@gmail.com> wrote:
>
> > Use asm_inline() to instruct the compiler that the size of asm()
> > is the minimum size of one instruction, ignoring how many instructions
> > the compiler thinks it is. ALTERNATIVE macro that expands to several
> > pseudo directives causes instruction length estimate to count
> > more than 20 instructions.
> >
> > bloat-o-meter reports minimal code size increase
> > (x86_64 defconfig with CONFIG_ADDRESS_MASKING, gcc-14.2.1):
> >
> >   add/remove: 2/2 grow/shrink: 5/1 up/down: 2365/-1995 (370)
> >
> >       Function                          old     new   delta
> >       -----------------------------------------------------
> >       do_get_mempolicy                    -    1449   +1449
> >       copy_nodes_to_user                  -     226    +226
> >       __x64_sys_get_mempolicy            35     213    +178
> >       syscall_user_dispatch_set_config  157     332    +175
> >       __ia32_sys_get_mempolicy           31     206    +175
> >       set_syscall_user_dispatch          29     181    +152
> >       __do_sys_mremap                  2073    2083     +10
> >       sp_insert                         133     117     -16
> >       task_set_syscall_user_dispatch    172       -    -172
> >       kernel_get_mempolicy             1807       -   -1807
> >
> >   Total: Before=3D21423151, After=3D21423521, chg +0.00%
> >
> > The code size increase is due to the compiler inlining
> > more functions that inline untagged_addr(), e.g:
> >
> > task_set_syscall_user_dispatch() is now fully inlined in
> > set_syscall_user_dispatch():
> >
> >       000000000010b7e0 <set_syscall_user_dispatch>:
> >         10b7e0:       f3 0f 1e fa             endbr64
> >         10b7e4:       49 89 c8                mov    %rcx,%r8
> >         10b7e7:       48 89 d1                mov    %rdx,%rcx
> >         10b7ea:       48 89 f2                mov    %rsi,%rdx
> >         10b7ed:       48 89 fe                mov    %rdi,%rsi
> >         10b7f0:       65 48 8b 3d 00 00 00    mov    %gs:0x0(%rip),%rdi
> >         10b7f7:       00
> >         10b7f8:       e9 03 fe ff ff          jmp    10b600 <task_set_s=
yscall_user_dispatch>
>
> So this was a tail-call optimization that jumped to a standalone
> <task_set_syscall_user_dispatch>, right? So now we'll avoid the
> tail-jump and maybe a bit of the register parameter shuffling? Which
> would explain the bloatometer delta of -172 for
> task_set_syscall_user_dispatch?

Yes, this is correct. Register shuffling is part of the call setup
(because parameters have to be passed to the called function in
certain registers according to the ps-ABI). Inlining avoids this
because parameters can now be freely allocated to any register of the
required class.

> Could you also cite the first relevant bits of <task_set_syscall_user_dis=
patch>?

000000000010b600 <task_set_syscall_user_dispatch>:
  10b600:    48 89 f8                 mov    %rdi,%rax
  10b603:    48 85 f6                 test   %rsi,%rsi
  10b606:    74 54                    je     10b65c
<task_set_syscall_user_dispatch+0x5c>
  10b608:    48 83 fe 01              cmp    $0x1,%rsi
  10b60c:    74 06                    je     10b614
<task_set_syscall_user_dispatch+0x14>
  10b60e:    b8 ea ff ff ff           mov    $0xffffffea,%eax
  10b613:    c3                       ret
  10b614:    48 85 d2                 test   %rdx,%rdx
  10b617:    75 7b                    jne    10b694
<task_set_syscall_user_dispatch+0x94>
  10b619:    4d 85 c0                 test   %r8,%r8
  10b61c:    74 1a                    je     10b638
<task_set_syscall_user_dispatch+0x38>
  10b61e:    4c 89 c6                 mov    %r8,%rsi
  10b621:    48 bf ef cd ab 89 67     movabs $0x123456789abcdef,%rdi
  10b628:    45 23 01
  10b62b:    90                       nop
  10b62c:    90                       nop
  10b62d:    90                       nop
  10b62e:    90                       nop
  10b62f:    90                       nop
  10b630:    90                       nop
  10b631:    90                       nop
  10b632:    90                       nop
  10b633:    48 39 f7                 cmp    %rsi,%rdi
  10b636:    72 6e                    jb     10b6a6
<task_set_syscall_user_dispatch+0xa6>
  10b638:    4c 89 80 48 08 00 00     mov    %r8,0x848(%rax)
  10b63f:    48 89 90 50 08 00 00     mov    %rdx,0x850(%rax)
  10b646:    48 89 88 58 08 00 00     mov    %rcx,0x858(%rax)
  10b64d:    c6 80 60 08 00 00 00     movb   $0x0,0x860(%rax)
  10b654:    f0 80 48 08 20           lock orb $0x20,0x8(%rax)
  10b659:    31 c0                    xor    %eax,%eax
  10b65b:    c3                       ret
  10b65c:    49 09 c8                 or     %rcx,%r8
  10b65f:    49 09 d0                 or     %rdx,%r8
  10b662:    75 aa                    jne    10b60e
<task_set_syscall_user_dispatch+0xe>
  10b664:    48 c7 87 48 08 00 00     movq   $0x0,0x848(%rdi)
  10b66b:    00 00 00 00
  10b66f:    48 c7 87 50 08 00 00     movq   $0x0,0x850(%rdi)
  10b676:    00 00 00 00
  10b67a:    48 c7 87 58 08 00 00     movq   $0x0,0x858(%rdi)
  10b681:    00 00 00 00
  10b685:    c6 87 60 08 00 00 00     movb   $0x0,0x860(%rdi)
  10b68c:    f0 80 67 08 df           lock andb $0xdf,0x8(%rdi)
  10b691:    31 c0                    xor    %eax,%eax
  10b693:    c3                       ret
  10b694:    48 8d 34 0a              lea    (%rdx,%rcx,1),%rsi
  10b698:    48 39 f2                 cmp    %rsi,%rdx
  10b69b:    0f 82 78 ff ff ff        jb     10b619
<task_set_syscall_user_dispatch+0x19>
  10b6a1:    e9 68 ff ff ff           jmp    10b60e
<task_set_syscall_user_dispatch+0xe>
  10b6a6:    b8 f2 ff ff ff           mov    $0xfffffff2,%eax
  10b6ab:    c3                       ret

> I don't seem to be able to reproduce this inlining decision, my version
> of GCC is:
>
>   gcc version 14.2.0 (Ubuntu 14.2.0-4ubuntu2)
>
> which is one patch version older than your 14.2.1.
>
> I tried GCC 11, 12, 13 as well, but none did this tail optimization,
> all appear to be inlining <task_set_syscall_user_dispatch> into
> <set_syscall_user_dispatch>. What am I missing?

CONFIG_ADDRESS_MASKING in current -tip depends on:

  Depends on: X86_64 [=3Dy] && (COMPILE_TEST [=3Dn] || !CPU_MITIGATIONS [=
=3Dy])

and I chose to disable CPU_MITIGATIONS (this is the reason no __pfx
functions are reported and the compiler is able to do sibling call
optimization).

BTW: I found the cited functions a representation of how the compiler
inlines bigger functions into smaller ones (one would expect the
opposite) depending on and respecting the code size growth factor
criteria for combined function.

> Another question, where do the size increases in these functions come
> from:
>
> >       __x64_sys_get_mempolicy            35     213    +178

This one now inlines kernel_get_mempolicy().

> >       syscall_user_dispatch_set_config  157     332    +175

This one now inlines task_set_syscall_user_dispatch().

> >       __ia32_sys_get_mempolicy           31     206    +175

This one now inlines kernel_get_mempolicy().

> >       set_syscall_user_dispatch          29     181    +152

This one now inlines task_set_syscall_user_dispatch().

> (I have to ask, because I have trouble reproducing with my toolchain so
> I cannot look at this myself.)

BTW: the indication of inline changes w.r.t. __untagged_addr() is the
number of references to the tlbstate_untag_mask variable in the
.altinstr_replacement section. If these go up, more inlining happens.
Also, bloat-o-meter indicates which function changes, and looking for
a string of 8 NOPs in the function will show where the AND instruction
is to be patched in.

Uros.

