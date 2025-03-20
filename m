Return-Path: <linux-kernel+bounces-570537-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A1758A6B1C7
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 00:45:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E921A1892A52
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 23:45:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACD3922CBC6;
	Thu, 20 Mar 2025 23:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="j6iccm/B"
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A529B22B59C
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 23:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742514260; cv=none; b=qGFBeJEnXceDXnRtsnR00TN2fmcapfHqADC3BIEAX6mhCbvY/OuosZQjFD27JsyAE3LfFE/r4hOOytQ/oF4uwpscu2Z19RQO4gmrtFYf5M5jObUUWdOkUnKxsEBOnNedg+9gopSUPu4aOE2ys+dwMZ74ZXyYvjgsFBuyr5zBI+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742514260; c=relaxed/simple;
	bh=J7aAh5AR1kzWqeBM6kAqTkZ3MI/BnDmNbKrsdudZgWM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nJO2h6lDSNzdBjVsDEukFd7P1Ej1UOtaqHKOag6cqZ3xq7FuIBTP3jIfFT4H4Q0iHprJAeswqzzC0bokyGVYkvp/vD5YZH3KvGo683RmWFSuXwnd0V3i98Mti33dJietcPYKbf6HiWbzaLHA8Zby+xxd7Dogp9h3Wwbxce+BTe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=j6iccm/B; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-301c4850194so2025528a91.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 16:44:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1742514257; x=1743119057; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sx9RFbFhV18UVxcJVn2E8kE6xVU3d+kjpx4dubf4KQY=;
        b=j6iccm/BIVapr3vzZH/+V/2eelwmQZuI2IE3ubPWPlxs+e2L6Mr6BBBVW/0lzS3+hT
         xfkkOxjERj4TbLF0uxX968SEbZGhKDo4EHNvpYMrbOCQ6TjXsyG4I0rOSggDk4h9W+LS
         l+BJ0tdjwYsCvu5GQkdlBeza4LuWVHnqOTPPSgupvYru1AuHErQmrgx0cFlwNCOodV7l
         7rLk8vOdAnux7x7lph8mSiZt+nSRUQcBVSd6tzwLXYS/rLkgBXbRK02TmONmTK1mwRvs
         EIJTXchJoi4w8yxUWRYYSZ/KYllmPRJyhoItIVY9R18Bk+bq9rH3Gb2BT3+PLaMjYTYY
         l2CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742514257; x=1743119057;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sx9RFbFhV18UVxcJVn2E8kE6xVU3d+kjpx4dubf4KQY=;
        b=S9c+pMQKqQrk78W3wi0FE2dWivIf2+2ijKqwzVpht0ZX4i3O5RyZy/sxdkyPt0pvm1
         xAE50KsTo9BG59zmPSbeC5rQOksimkOeIbuhAaT3Kqu5EYVOXlyJY0crtrBtXYJuWw/X
         sccyqCT7vPhSbtKurJHOeOuD1jngEq7C/hhuRRrXRpevrMrUewV6lmkkmozMFTUVSJZo
         9XYBXWD5dGekXIawoTAfQE+FDEo4Ybng/2zuSRbYMbjbUjFnrMVg2SK1nx2Yn9L9XUlP
         lZmnkAerEsIHmW8Id2DkkJimkFCw35KkjlpKBPrgjjSnqkpxGf/buKlcWqms+cptKWeS
         DNbQ==
X-Forwarded-Encrypted: i=1; AJvYcCUgUvO82fGDhi8RglSJYdEAQm+hBHvwIKYu1jzsW1ykpE9h7RyFXCDkubyR12j8AqeXp7ATw+U37RN7oQs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzA+juQzY3HX8zAW6zeQdyNHz0lvr/hhTxffbXCJmys2FWwFnaW
	zazL/DwbgoFGCQsNU0mEQltGLxrmYrs/8FIh0sMXuUiyc2+kNHSl8YbcHjMCvbxe4oCxZVuk8/N
	ce/jRF9ZIErQo8GUltpMlVwuJZdaSYzL0Ry9OMg==
X-Gm-Gg: ASbGnctC7oJovcP4B9YMZM1HBdG+qCascAZWyUscz8rVMkvMj971GvoIzKzRinrazyT
	PUklzW+a7QWj+7KSM9w67FzedOeqj+mGxEMbeVo6NE3tRGBULLoTSKRIP/FOKh/7yau3gvCW1L6
	vG6JeChgnpbM8pWEs5hLKAyK8f
X-Google-Smtp-Source: AGHT+IHZLYL66qJW18COX6JZ7o2M448VXcpFC9tv/3ygvfrm/plvo7x5Xd4P6IHJW/2EPCNgKPKtCGWglcvBlvp8pYg=
X-Received: by 2002:a17:90b:28c4:b0:2fe:a742:51b0 with SMTP id
 98e67ed59e1d1-3031002af0fmr1663139a91.31.1742514256837; Thu, 20 Mar 2025
 16:44:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250317-kvm_exit_fix-v1-1-aa5240c5dbd2@rivosinc.com> <Z9hI5vEHngcKvvRa@google.com>
In-Reply-To: <Z9hI5vEHngcKvvRa@google.com>
From: Atish Kumar Patra <atishp@rivosinc.com>
Date: Thu, 20 Mar 2025 16:44:05 -0700
X-Gm-Features: AQ5f1JqRewenHnUHTLoLyUK3jy666k2pQWgIEFEkTaIpT0EXNn1CrZi3jTO1WxM
Message-ID: <CAHBxVyFLeZFwEnJYa-oUbAKVimdVsr=Ct76Jf=TyWeoAkHe8yQ@mail.gmail.com>
Subject: Re: [PATCH] RISC-V: KVM: Teardown riscv specific bits after kvm_exit
To: Sean Christopherson <seanjc@google.com>
Cc: Anup Patel <anup@brainfault.org>, Atish Patra <atishp@atishpatra.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Alexandre Ghiti <alex@ghiti.fr>, Andrew Jones <ajones@ventanamicro.com>, 
	Anup Patel <apatel@ventanamicro.com>, kvm@vger.kernel.org, 
	kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 17, 2025 at 9:08=E2=80=AFAM Sean Christopherson <seanjc@google.=
com> wrote:
>
> On Mon, Mar 17, 2025, Atish Patra wrote:
> > During a module removal, kvm_exit invokes arch specific disable
> > call which disables AIA. However, we invoke aia_exit before kvm_exit
> > resulting in the following warning. KVM kernel module can't be inserted
> > afterwards due to inconsistent state of IRQ.
> >
> > [25469.031389] percpu IRQ 31 still enabled on CPU0!
> > [25469.031732] WARNING: CPU: 3 PID: 943 at kernel/irq/manage.c:2476 __f=
ree_percpu_irq+0xa2/0x150
> > [25469.031804] Modules linked in: kvm(-)
> > [25469.031848] CPU: 3 UID: 0 PID: 943 Comm: rmmod Not tainted 6.14.0-rc=
5-06947-g91c763118f47-dirty #2
> > [25469.031905] Hardware name: riscv-virtio,qemu (DT)
> > [25469.031928] epc : __free_percpu_irq+0xa2/0x150
> > [25469.031976]  ra : __free_percpu_irq+0xa2/0x150
> > [25469.032197] epc : ffffffff8007db1e ra : ffffffff8007db1e sp : ff2000=
000088bd50
> > [25469.032241]  gp : ffffffff8131cef8 tp : ff60000080b96400 t0 : ff2000=
000088baf8
> > [25469.032285]  t1 : fffffffffffffffc t2 : 5249207570637265 s0 : ff2000=
000088bd90
> > [25469.032329]  s1 : ff60000098b21080 a0 : 037d527a15eb4f00 a1 : 037d52=
7a15eb4f00
> > [25469.032372]  a2 : 0000000000000023 a3 : 0000000000000001 a4 : ffffff=
ff8122dbf8
> > [25469.032410]  a5 : 0000000000000fff a6 : 0000000000000000 a7 : ffffff=
ff8122dc10
> > [25469.032448]  s2 : ff60000080c22eb0 s3 : 0000000200000022 s4 : 000000=
000000001f
> > [25469.032488]  s5 : ff60000080c22e00 s6 : ffffffff80c351c0 s7 : 000000=
0000000000
> > [25469.032582]  s8 : 0000000000000003 s9 : 000055556b7fb490 s10: 00007f=
fff0e12fa0
> > [25469.032621]  s11: 00007ffff0e13e9a t3 : ffffffff81354ac7 t4 : ffffff=
ff81354ac7
> > [25469.032664]  t5 : ffffffff81354ac8 t6 : ffffffff81354ac7
> > [25469.032698] status: 0000000200000100 badaddr: ffffffff8007db1e cause=
: 0000000000000003
> > [25469.032738] [<ffffffff8007db1e>] __free_percpu_irq+0xa2/0x150
> > [25469.032797] [<ffffffff8007dbfc>] free_percpu_irq+0x30/0x5e
> > [25469.032856] [<ffffffff013a57dc>] kvm_riscv_aia_exit+0x40/0x42 [kvm]
> > [25469.033947] [<ffffffff013b4e82>] cleanup_module+0x10/0x32 [kvm]
> > [25469.035300] [<ffffffff8009b150>] __riscv_sys_delete_module+0x18e/0x1=
fc
> > [25469.035374] [<ffffffff8000c1ca>] syscall_handler+0x3a/0x46
> > [25469.035456] [<ffffffff809ec9a4>] do_trap_ecall_u+0x72/0x134
> > [25469.035536] [<ffffffff809f5e18>] handle_exception+0x148/0x156
> >
> > Invoke aia_exit and other arch specific cleanup functions after kvm_exi=
t
> > so that disable gets a chance to be called first before exit.
> >
> > Fixes: 54e43320c2ba ("RISC-V: KVM: Initial skeletal support for AIA")
> >
> > Signed-off-by: Atish Patra <atishp@rivosinc.com>
> > ---
>
> FWIW,
>
> Reviewed-by: Sean Christopherson <seanjc@google.com>
>
> >  arch/riscv/kvm/main.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/riscv/kvm/main.c b/arch/riscv/kvm/main.c
> > index 1fa8be5ee509..4b24705dc63a 100644
> > --- a/arch/riscv/kvm/main.c
> > +++ b/arch/riscv/kvm/main.c
> > @@ -172,8 +172,8 @@ module_init(riscv_kvm_init);
> >
> >  static void __exit riscv_kvm_exit(void)
> >  {
> > -     kvm_riscv_teardown();
> > -
> >       kvm_exit();
> > +
> > +     kvm_riscv_teardown();
>
> I wonder if there's a way we can guard against kvm_init()/kvm_exit() bein=
g called
> too early/late.  x86 had similar bugs for a very long time, e.g. see comm=
it
> e32b120071ea ("KVM: VMX: Do _all_ initialization before exposing /dev/kvm=
 to userspace").
>
> E.g. maybe we do something like create+destroy a VM at the end of kvm_ini=
t() and
> the beginning of kvm_exit()?  Not sure if that would work for kvm_exit(),=
 but it
> should definitely be fine for kvm_init().
>
Yes. That would be super useful. I am not sure about the exact
mechanism to achieve that though.
Do you just test code guarded within a new config that just
creates/destroys a dummy VM ?

May be kunit test for KVM fits here in some way ?

> It wouldn't prevent bugs, but maybe it would help detect them during deve=
lopment?

