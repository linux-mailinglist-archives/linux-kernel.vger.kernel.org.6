Return-Path: <linux-kernel+bounces-232080-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6CE491A2D7
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 11:43:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BFA52852BF
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 09:43:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93F8613AD04;
	Thu, 27 Jun 2024 09:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="fH3Ff0H1"
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com [209.85.222.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54C154D5BD
	for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 09:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719481398; cv=none; b=gK9Lgeajtp5U4LfTLxoGzOF2C63TV3fAy9o6pAOWy6Vn17ARb3Nvlm8xEktZYbDYaRX54McvPymOUp8Z7p5gFKd45R+IS5qdmqV3q7zJo7nTaIDe85kHvUStBVJl1AULaZ+TU701QEhPaFgFoCZgi5ruDaK3aeYlbMdsV62SEwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719481398; c=relaxed/simple;
	bh=WzPYmct1ZG1yRejRLp1lcKsz6ysxvbbDlhXp+x24VOo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JzRVX09HhKL/34+c7C8Anc3n4sNepAOydiatkMrXkgsa5F+dnUKtWz8lGuXEzk1HfovLtNsjWB2G5xfK8rO3rH9IUQzyLYWIXGgebMO7DBxkcoOZ2pBvnmjPlR2gxIk42nyOxRtCoqh+rtmyGzJrAx63fDg/QARZZoLQl7PyWzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=fH3Ff0H1; arc=none smtp.client-ip=209.85.222.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-80fbf874128so684149241.2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 02:43:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1719481395; x=1720086195; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7ds3uXyhOspb83UzynorfT4bxuHOUyg4DsTQJ3YvqP8=;
        b=fH3Ff0H1TwjbpyjUrrWjU1lua1JYAksY10889QT3w/FbqeaXdaQJAqIRvMnVOqM7oq
         O4pnGKvKxr9ENlMuGaQXIS36Vp/X9Grm9ML32cGxShW4FO+C8NOXc0blEST1Z2xgKatI
         JSZDgh3X0Wlwwe4ev9FFdGQx0ZGoBa853mezBwnzyY665Oc162L9NOSPZEjEDjR0UCvI
         zynQZG8wisOFe7P0T4uPcnGz062xj1QRD5xUKoxgRHEfQBAwJ+aDcySoePPovazYQwGv
         V/AZ5AkiuD+a8xkMRrpZp0rbl4PvBI6ivaQyJAEvKxSDvbDvqpSou9BFPQh4BAZbalZA
         8iiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719481395; x=1720086195;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7ds3uXyhOspb83UzynorfT4bxuHOUyg4DsTQJ3YvqP8=;
        b=xRwMnyoI+FBWHk39LeOWj1IgfiR5qZoSsqs92zHRtu2WaYbjc0t3gGESAo1CAige3x
         rbam8SQTkVv0H+A2bgenWwh7R3fxVr36QqBWa8OoFNFgFEnr8trtmH99PPdM75EpWylL
         bjhGuYB4XvroTo5VAUi89A9EwKp3MsSojPR1IbaEISbft/dkIxIPJE2YKySY4C1C2prK
         Mbvr/2nHWMoAgLXe3yCBRjFbh5X0p3BXqVxt4qd2Mll7bMZznn5Vd74xBN+NIl99CQzx
         1ebBJUtkLsv7Dj7+4Hts+emh5sZIbEXJQ8kQ1VtVCrP9MMEcjh7YbZXdV6daIR6B5T+n
         oJUQ==
X-Forwarded-Encrypted: i=1; AJvYcCUUf9+tJrhmKw9xmJ7wUeWKA2SJ1KwcAVLYZ1zqhn4Yo1Ko9AqP0Rux8Nl0l84uiWme6sSNviPqrTLb0fdvMkT5lNHifKjovtEOJgYS
X-Gm-Message-State: AOJu0YxbB4PBzL49rzyTIJwKwnqXX02eNFqB0nSNAd5x9rfnN2N6+3Bj
	UU2FyvwDAM3CTI/UBY63eD1vJGXMTpSABRQoYTjjS85jeR+bPUYUtB43spqdBvq5lBkd72Fpt+q
	YAYtDt7GWobdB1zXpoMpQopefKDYHdoL3FNcx
X-Google-Smtp-Source: AGHT+IGBv4Bbs/pbeMHJtmkvCt7f3IJTYs0gdhLR2HxVvY14nRCrzCgTvdwfbnoRZj4htMw/nyBIq9PpMl3hVx/x6jo=
X-Received: by 2002:a05:6102:361:b0:48f:508b:d3ec with SMTP id
 ada2fe7eead31-48f52946e34mr10434786137.4.1719481394805; Thu, 27 Jun 2024
 02:43:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230801141607.435192-1-CoelacanthusHex@gmail.com>
 <20240627071422.GA2626@altlinux.org> <9c102328-6bb3-46b6-bc2f-d011a284d5b0@gmail.com>
In-Reply-To: <9c102328-6bb3-46b6-bc2f-d011a284d5b0@gmail.com>
From: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>
Date: Thu, 27 Jun 2024 11:43:03 +0200
Message-ID: <CA+FstbVf7TJx==WsY5fBoFrdeY8php5ETn8kMq5s6YScy-2O=A@mail.gmail.com>
Subject: Re: [PATCH v5] riscv: entry: set a0 = -ENOSYS only when syscall != -1
To: Celeste Liu <coelacanthushex@gmail.com>
Cc: "Dmitry V. Levin" <ldv@strace.io>, Palmer Dabbelt <palmer@rivosinc.com>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Guo Ren <guoren@kernel.org>, Conor Dooley <conor.dooley@microchip.com>, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Andreas Schwab <schwab@suse.de>, David Laight <David.Laight@aculab.com>, 
	Felix Yan <felixonmars@archlinux.org>, Ruizhe Pan <c141028@gmail.com>, 
	Shiqi Zhang <shiqi@isrc.iscas.ac.cn>, 
	Emil Renner Berthing <emil.renner.berthing@canonical.com>, "Ivan A. Melnikov" <iv@altlinux.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 27, 2024 at 9:47=E2=80=AFAM Celeste Liu <coelacanthushex@gmail.=
com> wrote:
>
> On 2024-06-27 15:14, Dmitry V. Levin wrote:
>
> > Hi,
> >
> > On Tue, Aug 01, 2023 at 10:15:16PM +0800, Celeste Liu wrote:
> >> When we test seccomp with 6.4 kernel, we found errno has wrong value.
> >> If we deny NETLINK_AUDIT with EAFNOSUPPORT, after f0bddf50586d, we wil=
l
> >> get ENOSYS instead. We got same result with commit 9c2598d43510 ("risc=
v:
> >> entry: Save a0 prior syscall_enter_from_user_mode()").
> >>
> >> After analysing code, we think that regs->a0 =3D -ENOSYS should only b=
e
> >> executed when syscall !=3D -1. In __seccomp_filter, when seccomp rejec=
ted
> >> this syscall with specified errno, they will set a0 to return number a=
s
> >> syscall ABI, and then return -1. This return number is finally pass as
> >> return number of syscall_enter_from_user_mode, and then is compared wi=
th
> >> NR_syscalls after converted to ulong (so it will be ULONG_MAX). The
> >> condition syscall < NR_syscalls will always be false, so regs->a0 =3D =
-ENOSYS
> >> is always executed. It covered a0 set by seccomp, so we always get
> >> ENOSYS when match seccomp RET_ERRNO rule.
> >>
> >> Fixes: f0bddf50586d ("riscv: entry: Convert to generic entry")
> >> Reported-by: Felix Yan <felixonmars@archlinux.org>
> >> Co-developed-by: Ruizhe Pan <c141028@gmail.com>
> >> Signed-off-by: Ruizhe Pan <c141028@gmail.com>
> >> Co-developed-by: Shiqi Zhang <shiqi@isrc.iscas.ac.cn>
> >> Signed-off-by: Shiqi Zhang <shiqi@isrc.iscas.ac.cn>
> >> Signed-off-by: Celeste Liu <CoelacanthusHex@gmail.com>
> >> Tested-by: Felix Yan <felixonmars@archlinux.org>
> >> Tested-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>
> >> Reviewed-by: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>
> >> Reviewed-by: Guo Ren <guoren@kernel.org>
> >> ---
> >>
> >> v4 -> v5: add Tested-by Emil Renner Berthing <emil.renner.berthing@can=
onical.com>
> >> v3 -> v4: use long instead of ulong to reduce type cast and avoid
> >>           implementation-defined behavior, and make the judgment of sy=
scall
> >>           invalid more explicit
> >> v2 -> v3: use if-statement instead of set default value,
> >>           clarify the type of syscall
> >> v1 -> v2: added explanation on why always got ENOSYS
> >>
> >>  arch/riscv/kernel/traps.c | 6 +++---
> >>  1 file changed, 3 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
> >> index f910dfccbf5d2..729f79c97e2bf 100644
> >> --- a/arch/riscv/kernel/traps.c
> >> +++ b/arch/riscv/kernel/traps.c
> >> @@ -297,7 +297,7 @@ asmlinkage __visible __trap_section void do_trap_b=
reak(struct pt_regs *regs)
> >>  asmlinkage __visible __trap_section void do_trap_ecall_u(struct pt_re=
gs *regs)
> >>  {
> >>      if (user_mode(regs)) {
> >> -            ulong syscall =3D regs->a7;
> >> +            long syscall =3D regs->a7;
> >>
> >>              regs->epc +=3D 4;
> >>              regs->orig_a0 =3D regs->a0;
> >> @@ -306,9 +306,9 @@ asmlinkage __visible __trap_section void do_trap_e=
call_u(struct pt_regs *regs)
> >>
> >>              syscall =3D syscall_enter_from_user_mode(regs, syscall);
> >>
> >> -            if (syscall < NR_syscalls)
> >> +            if (syscall >=3D 0 && syscall < NR_syscalls)
> >>                      syscall_handler(regs, syscall);
> >> -            else
> >> +            else if (syscall !=3D -1)
> >>                      regs->a0 =3D -ENOSYS;
> >>
> >>              syscall_exit_to_user_mode(regs);
> >
> > Unfortunately, this change introduced a regression: it broke strace
> > syscall tampering on riscv.  When the tracer changes syscall number to =
-1,
> > the kernel fails to initialize a0 with -ENOSYS and subsequently fails t=
o
> > return the error code of the failed syscall to userspace.
>
> In the patch v2, we actually do the right thing. But as Bj=C3=B6rn T=C3=
=B6pel's
> suggestion and we found cast long to ulong is implementation-defined
> behavior in C, so we change it to current form. So revert this patch and
> apply patch v2 should fix this issue. Patch v2 uses ths same way with
> other architectures.
>
> [1]: https://lore.kernel.org/all/20230718162940.226118-1-CoelacanthusHex@=
gmail.com/

Not reverting, but a fix to make sure that a0 is initialized to -ENOSYS, e.=
g.:

--8<--
diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
index 05a16b1f0aee..51ebfd23e007 100644
--- a/arch/riscv/kernel/traps.c
+++ b/arch/riscv/kernel/traps.c
@@ -319,6 +319,7 @@ void do_trap_ecall_u(struct pt_regs *regs)

  regs->epc +=3D 4;
  regs->orig_a0 =3D regs->a0;
+ regs->a0 =3D -ENOSYS;

  riscv_v_vstate_discard(regs);

@@ -328,8 +329,7 @@ void do_trap_ecall_u(struct pt_regs *regs)

  if (syscall >=3D 0 && syscall < NR_syscalls)
  syscall_handler(regs, syscall);
- else if (syscall !=3D -1)
- regs->a0 =3D -ENOSYS;
+
  /*
  * Ultimately, this value will get limited by KSTACK_OFFSET_MAX(),
  * so the maximum stack offset is 1k bytes (10 bits).
--8<--

Celeste, do you want to cook that fix properly?


Bj=C3=B6rn

