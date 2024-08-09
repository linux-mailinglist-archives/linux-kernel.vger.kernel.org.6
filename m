Return-Path: <linux-kernel+bounces-281626-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DA54E94D8F5
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Aug 2024 01:05:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A0351F227A4
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 23:05:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C38516C686;
	Fri,  9 Aug 2024 23:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b="M+giBGZ9"
Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8B0716B3AB
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 23:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723244722; cv=none; b=XAYW7Z8V+gV69BL+Dj9TGOkcAbjVCBAw9BJ5eP5d0UFTV+MBTnFFhRChdJd71jHho/BfM6d9zSbBbB5gSb3bfC6Ke4A6kGEdxUYhz6u+0JJY3RIcYKItAbtvSbEn9LBwRmuiwarx2/JXPSf6YVo+Ljvj2AiEK2nlwdeirx7ytBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723244722; c=relaxed/simple;
	bh=vWkSxykn1cvJmCP36LasKH/Tbo44KivDmwGTYeyWhCU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Sk4tuJkX9UrpwGIBYhPqjWddmqOTAmjYZhbDNaqjj27WjpE2VFHvWn0SSuWDGhvmrFWK+sc3dM7i3rk60DPeQ5w+enZdKg2YJ2P79mlrl7VnH19pyCOzyTxX/J0oQ8Jrbk35eCA2EPHV87A1ixlZdVZf2Rr33e3/7GLs3YW1Mfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b=M+giBGZ9; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1723244655; x=1723849455; i=spasswolf@web.de;
	bh=amghjiPmBdNDjZ+QdNP/jp2SmgB4Kt9zFVs1Mtm8BNk=;
	h=X-UI-Sender-Class:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Content-Type:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=M+giBGZ94Iev8emMHqP0Tm1TlQf0f/2PjFAq/NVCfhH/rhBEDelFusBvv6DyTeQY
	 NA6l58okSX3kcfISxnRTbJfEjR1nPoA4/WZ2NshOYb9V7WpNW2/rgfKAU+o+TYK6G
	 utNAJObYNpHNQHE/Zx2YTs1gxU9bJxesEuqEJ0j0hDUT4V1zjJKWXCXz1Romde+hI
	 rSx/4kjlJm6TTCvbWaQ+F6S7aiFFoK53XoBJvbylAEvk2q5KqbVnUjAJ0t0Fi9bge
	 9zmbhBm2sdexejclrlG6VYRV74cvJ6KCV9NfqNJM5OpP6FWYucs45ZGDjf0QOn7VN
	 R03gBGDLSJoQOtDOMg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.0.101] ([84.119.92.193]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MrOdp-1rodho1tvL-00pmq9; Sat, 10
 Aug 2024 01:04:15 +0200
Message-ID: <8559e4f66f1e6f1d7e938cc7a833528f232872d2.camel@web.de>
Subject: Re: commit 81106b7e0b13 can break asm_int80_emulation on x86_64
From: Bert Karwatzki <spasswolf@web.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: mingo@kernel.org, akpm@linux-foundation.org, Oleg Nesterov
 <oleg@redhat.com>,  Andy Lutomirski	 <luto@kernel.org>, Borislav Petkov
 <bp@alien8.de>, Fenghua Yu	 <fenghua.yu@intel.com>, "H . Peter Anvin"
 <hpa@zytor.com>, Dave Hansen	 <dave.hansen@linux.intel.com>, Thomas
 Gleixner <tglx@linutronix.de>, Uros Bizjak <ubizjak@gmail.com>,
 linux-kernel@vger.kernel.org, peterz@infradead.org, spasswolf@web.de
Date: Sat, 10 Aug 2024 01:04:10 +0200
In-Reply-To: <CAHk-=wi=M1MT8TT8oMsXcUTyNi+zgV56b6wNmhYZ5c=vaXiCOQ@mail.gmail.com>
References: <20240809145320.77100-1-spasswolf@web.de>
	 <CAHk-=wi=M1MT8TT8oMsXcUTyNi+zgV56b6wNmhYZ5c=vaXiCOQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.53.2-1 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:E8Xdx6B7LgAsJUzz0sDGmCxBAVynMFh4/ZAjds4Ox3fdMhZWH6T
 9KJ2sT8z2gNXgAMimWrirqkfvghD3osj3HFWtK7iwVwKKs+/A4ocj8qW8DOKb60kK5v40Qd
 9ZYZ1IDlmXCp2eWfOjwMxC0cozhj3mCwAWZxtLhcL+DO64mIFVrpFKlarAojJsWQqhSr0DU
 iZrbJ3QtFGKyJtqG9djGA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:ucmnhs72Vl0=;Ka9d4MFHSG1A0YpBpBLekuCVsEt
 q2iLQjpJugyIQ5oc61RV1BuOyhVdFieyLgYZC0OEe4ryaJus0OE0jJ1SjGB1lKAQli0VWN709
 OOi1yqaprpc17ZGRZDBDBLOBkvD3HpWZgSM+Edxt3VpDXyCPb75zquDoAwvxdumfuezqvaRF7
 UAa9TMFcxkOyzV96nhNO1CDLFmig0H9i4xoZnfkXTTVxbo8HJwBKvaKTbRUD4rS6fhELo8EgY
 2+GDLDE8pxELX9Fl9BBgF63SpArOEW4uFBSqpV78eI76awhJuernuIHsGK2B+pRAGb91pyNBO
 odatUiCkK7Yk8yznt15teq6bFLsnZ/ITRvDgMzZ13Y+6ZKP4wdmDvxlbAK6FyT1pFiv9rdqC4
 lYj6TTEm3nMGCynyfI+UoMOXLDiIuIxKFBD3T/sb9AIoZwEdhfVGEqX6EghOXIENhR/bAXtrV
 X4P9Iu/WXQOZ5eoZUTSNczw0R4K7IWA74GeyIUoDzn6oEISq2O6eckUoECuHQGfgd/kGlfw7A
 +m3S9QBXjqTBpyqlbjFLWTvLBg9xiMwlw0Pq/+t7I4lwFNkfPhZjYomhbs4ERf1JyT7SAyduW
 y1N/kkTf5fUF+UjYK+9rscNqxr42HB3TOriG89bdIXRtYC+rc0NWNtx34b6c5fPX3adhM0qv7
 yOCIhG1i+VfrHTd/EySey/KfX6rI06HQhppfQgC/A50RU2LH8ECYPz0lqyGDo2oYXAIQ0q7nx
 WRlRMp26OcCntrNXOwGkyGZCts+A3hGaHQr6UvjF7uos6h1cgl68/bIkU38EwBgZ6rf/P0bi6
 2CBQu06os535mumQluGvgAbw==

Am Freitag, dem 09.08.2024 um 11:17 -0700 schrieb Linus Torvalds:
> On Fri, 9 Aug 2024 at 07:53, Bert Karwatzki <spasswolf@web.de> wrote:
> >
> > So the problem seems to be that the kmem_cache object *s has usersize =
0. This
> > should be impossible in theory as kmem_cache_create_usercopy() should =
print
> > a warning in case of (!usersize && useroffset).
>
> Following along from your original report:
>
>   usercopy: Kernel memory overwrite attempt detected to SLUB object
> 'task_struct' (offset 3072, size 160)!
>
> IOW, the user copy code is unhappy about copying data from user mode
> into the task_struct allocation.
>
> Anyway, on x86-64 with that commit we now just do
>
>   arch_thread_struct_whitelist(unsigned long *offset, unsigned long *siz=
e)
>    {
>         *offset =3D 0;
>         *size =3D 0;
>   }
>
> and that seems to be the bug.
>
> It's still allocated together with that 'struct task_struct', even if
> it's no longer inside the 'struct thread_struct'.
>
> Ingo? I think it needs to be something like
>
>         *offset =3D sizeof(struct task_struct)
>                 - offsetof(struct task_struct, thread)
>                 + offsetof(struct fpu, __fpstate.regs);
>         *size =3D fpu_kernel_cfg.default_size;
>
> and the commit message of
>
>     The fpu_thread_struct_whitelist() quirk to hardened usercopy can be =
removed,
>     now that the FPU structure is not embedded in the task struct anymor=
e, which
>     reduces text footprint a bit.
>
> is clearly not true. No, it's not embedded in 'struct task_struct',
> but it *is* still allocated together with it in the same slab if I
> read the code correctly (ie this part
>
>   static void __init fpu__init_task_struct_size(void)
>   {
>         int task_size =3D sizeof(struct task_struct);
>
>         task_size +=3D sizeof(struct fpu);
>         ..
>         arch_task_struct_size =3D task_size;
>
>
> is because it's still all one single slab allocation.
>
>                Linus

Yes, this seems to be the problem. As the old code (from linux-5.16-rc1 to
linux-6.11-rc2) used this

void fpu_thread_struct_whitelist(unsigned long *offset, unsigned long *siz=
e)
{
	*offset =3D offsetof(struct thread_struct, fpu.__fpstate.regs);
	*size =3D fpu_kernel_cfg.default_size;
}

I tried this as a potential solution:

diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/proce=
ssor.h
index bd0621210f63..f1d713de6dba 100644
=2D-- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -516,8 +516,9 @@ extern struct fpu *x86_task_fpu(struct task_struct *ta=
sk);
 static inline void
 arch_thread_struct_whitelist(unsigned long *offset, unsigned long *size)
 {
-       *offset =3D 0;
-       *size =3D 0;
+       *offset =3D sizeof(struct thread_struct)
+               + offsetof(struct fpu, __fpstate.regs);
+       *size =3D fpu_kernel_cfg.default_size;
 }

 static inline void

and it seems to solve the problem (debug output from my previous printk pa=
tch):

[  T57380] copy_uabi_to_xstate 1261: calling copy_from buffer with offset =
=3D
0x200, size =3D 0x40
[  T57380] copy_from_buffer: calling copy_from_user with to =3D ffffadf495=
127d58
from =3D 000000003ffef840, n =3D 0x40
[  T57380] copy_uabi_to_xstate 1275: calling copy_from buffer with offset =
=3D
0x18, size =3D 0x8
[  T57380] copy_from_buffer: calling copy_from_user with to =3D ffffadf495=
127d50
from =3D 000000003ffef658, n =3D 0x8
[  T57380] copy_uabi_to_xstate 1300: calling copy_from buffer 0 with offse=
t =3D
0x0, size =3D 0xa0, dst =3D ffff90d285ec7880, kbuf =3D 0000000000000000, u=
buf =3D
000000003ffef640
[  T57380] copy_from_buffer: calling copy_from_user with to =3D ffff90d285=
ec7880
from =3D 000000003ffef640, n =3D 0xa0

Here the bug would happen in linux-next-20240806 which seems to be avoided=
 by
the patch.

[  T57380] copy_uabi_to_xstate 1300: calling copy_from buffer 1 with offse=
t =3D
0xa0, size =3D 0x100, dst =3D ffff90d285ec7920, kbuf =3D 0000000000000000,=
 ubuf =3D
000000003ffef640
[  T57380] copy_from_buffer: calling copy_from_user with to =3D ffff90d285=
ec7920
from =3D 000000003ffef6e0, n =3D 0x100

Bert Karwatzki


