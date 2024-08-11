Return-Path: <linux-kernel+bounces-282239-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7E8594E13C
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2024 14:38:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0A2C1C20CD8
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2024 12:38:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0EE250A63;
	Sun, 11 Aug 2024 12:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b="Shom1PNI"
Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2F4322626
	for <linux-kernel@vger.kernel.org>; Sun, 11 Aug 2024 12:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723379878; cv=none; b=U2C4baVEvB8ScmQqKYul7yQ2XMfQdjdBI+3BeUxMHedSCl6r4dmG5YdaCIPq07lQbd7CPjSCT0EfBc9RKE8iSYYESR/zHNDiVCtOJw0bQX13q69N8qljVz/XDqA1Q/a/TsVoCQ1VmZe4X5SiEwMJQdjSj+j4ALw8w6Cg9e8ptws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723379878; c=relaxed/simple;
	bh=BZiEmO+drNyyD0910lopvWAZ3HQP062AaxNvgB3f5ks=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bObpVBkLwZ2IimvQJIxk6O67COc+eb120LY0WA2/p6m5FZktA40LEE5KxHGyeBHAp8ulhquKDPSF5eNI7bT9z55fpxuNHZWdxz7izX4tbNY/SXlj9Ehah8q622zRe1eGjhVFz/LDCd0f6XlJ7kGCPeGLOkJYv1xsc0Gm/04oUW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b=Shom1PNI; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1723379804; x=1723984604; i=spasswolf@web.de;
	bh=NL/dL5WZaVqidh+N07WaWhwxgtkClb8ERdoRyARMfRk=;
	h=X-UI-Sender-Class:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Content-Type:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=Shom1PNIY+UweFQfNoLMOylXcvcJ1mjYW0siJPYtfmakgenCh6uq5REEpaolW4hR
	 axl11iZSkrgvFSWbm6I/DWx1xcZQPUtW6GSMTMXMStACmydOB3rttOV29kSBoBqib
	 y41INtQhcFiuctURpimFjNSGB7ESQ3XENmRqKDTqIF4Cj8X6KNVhLRD3SNJaTBiqp
	 VCRuyA4vaoskz5yq/sl4pD1sLpMWC4K7IvXaId5vgwd5iNfw4dp+pLI3e5XZjDxGc
	 Q2xTCmh0HZ8AwGVXX5LWknffYP3DBzzDBHnu32hpQwQapdO0XAQL/HOmHWckSwtTq
	 /8zxtcWyTcUkVLzIjQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.0.101] ([84.119.92.193]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Mr7eu-1rsCDK0uv8-00q3uX; Sun, 11
 Aug 2024 14:36:44 +0200
Message-ID: <4dd284e111924c197be2d6682e3fde6f7a9b375c.camel@web.de>
Subject: Re: commit 81106b7e0b13 can break asm_int80_emulation on x86_64
From: Bert Karwatzki <spasswolf@web.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: mingo@kernel.org, akpm@linux-foundation.org, Oleg Nesterov
 <oleg@redhat.com>,  Andy Lutomirski	 <luto@kernel.org>, Borislav Petkov
 <bp@alien8.de>, Fenghua Yu	 <fenghua.yu@intel.com>, "H . Peter Anvin"
 <hpa@zytor.com>, Dave Hansen	 <dave.hansen@linux.intel.com>, Thomas
 Gleixner <tglx@linutronix.de>, Uros Bizjak <ubizjak@gmail.com>,
 linux-kernel@vger.kernel.org, peterz@infradead.org, spasswolf@web.de
Date: Sun, 11 Aug 2024 14:36:29 +0200
In-Reply-To: <8559e4f66f1e6f1d7e938cc7a833528f232872d2.camel@web.de>
References: <20240809145320.77100-1-spasswolf@web.de>
						 <CAHk-=wi=M1MT8TT8oMsXcUTyNi+zgV56b6wNmhYZ5c=vaXiCOQ@mail.gmail.com>
					 <8559e4f66f1e6f1d7e938cc7a833528f232872d2.camel@web.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.53.2-1 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:DqhFYjBXPeTUfEzaVc7mM3NQOMnkQbzgXVXUrrWrYxiT8qQNzNU
 LI8U5BCXUoKSANTUb2a5kvpoPsbCpanBF43d0mYYskzlRgbjNoKrkJQDTZKDs/cUvaccaF1
 XEH//UuHUTL86Y+Hk+D0RNhG53EZ4lk9tpjauRa5d/EI7QQJlogPjm2yW/VHp1tQwUAGutp
 8x6M8phkI8OKA04ZdCyzg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:rEUIEIRdHDs=;9qduKmxnTxtGJ6uu9lQJBkKmDUg
 FSTrchgw81vE0dZRKc069NB73Znl7odbv6/vcGnapNA9uoD/T9K39RduLvTW6i33TTEYl1DCH
 oAMVmF6xFwrK5taillQQyGUbvaKEqGYSiyoPv0GSA75vy/AhJOKQQu9SHi0ziyzleRAXtWcQg
 NFLsmQib1L9+hBGv16VESiTP2DA2z8AZCk6Qq3UTWkXSfjoatuRU6hV8WHT0KBDDhHDka8w/v
 TpxHEbP3zWjiXB3yRwWpVWcZ7psO2OszD4y35XGJLFZYI1v+Y8Brv2AmWkOZGze3vkjYrrP4l
 gDqFUofQAGca+RNEc3Yb4jfz7FC2li5p4fkQRbU7QIicz49soBKP1jIJnMB7Nls2vcb2wrukX
 D6BoyR3aIh6/fCRknzmZTdmh+cLpnsEdSkPKBkGJx8xeNSMPeNCBK72XMpV1Ep3demB+UBs3m
 3rSM1g7lUMpYFcAx+C2k5r4eijiG2YzuBofX905DHrupE/fUpLBDMP3O50gKShydEpeaU0amf
 WR+7NjhsTI5DBnIQ4xwVhZSL+gxgcAgK/YVsbwjmF5MnN3KbM+mOpM8KnZzY6rpOQG4Bpx4Lr
 CfelUp1WdL1HR/zOhazZQ4IboJ4JKH1o4oBSzHS7IgJy2riWNA8Q2VWfRzmhRLZkXBLZEfwIX
 5k7RFE8ObBmbrY5fLTicPQDW8rvObHa6DZs/YbMcu4NTc5TCGi071zIFjjvxB/H8hf9C+HwMz
 yRWme6grSJIfkj9FZwgrR8ITj/BMMNINg4yCOigW1dCR6zYDAed5Yhr0Fs1iru5HsmDfnpoe3
 4WO5fPdafC++36hx+SSd3TbA==

Am Samstag, dem 10.08.2024 um 01:04 +0200 schrieb Bert Karwatzki:
> Am Freitag, dem 09.08.2024 um 11:17 -0700 schrieb Linus Torvalds:
> > On Fri, 9 Aug 2024 at 07:53, Bert Karwatzki <spasswolf@web.de> wrote:
> > >
> > > So the problem seems to be that the kmem_cache object *s has usersiz=
e 0. This
> > > should be impossible in theory as kmem_cache_create_usercopy() shoul=
d print
> > > a warning in case of (!usersize && useroffset).
> >
> > Following along from your original report:
> >
> >   usercopy: Kernel memory overwrite attempt detected to SLUB object
> > 'task_struct' (offset 3072, size 160)!
> >
> > IOW, the user copy code is unhappy about copying data from user mode
> > into the task_struct allocation.
> >
> > Anyway, on x86-64 with that commit we now just do
> >
> >   arch_thread_struct_whitelist(unsigned long *offset, unsigned long *s=
ize)
> >    {
> >         *offset =3D 0;
> >         *size =3D 0;
> >   }
> >
> > and that seems to be the bug.
> >
> > It's still allocated together with that 'struct task_struct', even if
> > it's no longer inside the 'struct thread_struct'.
> >
> > Ingo? I think it needs to be something like
> >
> >         *offset =3D sizeof(struct task_struct)
> >                 - offsetof(struct task_struct, thread)
> >                 + offsetof(struct fpu, __fpstate.regs);
> >         *size =3D fpu_kernel_cfg.default_size;
> >
> > and the commit message of
> >
> >     The fpu_thread_struct_whitelist() quirk to hardened usercopy can b=
e removed,
> >     now that the FPU structure is not embedded in the task struct anym=
ore, which
> >     reduces text footprint a bit.
> >
> > is clearly not true. No, it's not embedded in 'struct task_struct',
> > but it *is* still allocated together with it in the same slab if I
> > read the code correctly (ie this part
> >
> >   static void __init fpu__init_task_struct_size(void)
> >   {
> >         int task_size =3D sizeof(struct task_struct);
> >
> >         task_size +=3D sizeof(struct fpu);
> >         ..
> >         arch_task_struct_size =3D task_size;
> >
> >
> > is because it's still all one single slab allocation.
> >
> >                Linus
>
> Yes, this seems to be the problem. As the old code (from linux-5.16-rc1 =
to
> linux-6.11-rc2) used this
>
> void fpu_thread_struct_whitelist(unsigned long *offset, unsigned long *s=
ize)
> {
> 	*offset =3D offsetof(struct thread_struct, fpu.__fpstate.regs);
> 	*size =3D fpu_kernel_cfg.default_size;
> }
>
> I tried this as a potential solution:
>
> diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/pro=
cessor.h
> index bd0621210f63..f1d713de6dba 100644
> --- a/arch/x86/include/asm/processor.h
> +++ b/arch/x86/include/asm/processor.h
> @@ -516,8 +516,9 @@ extern struct fpu *x86_task_fpu(struct task_struct *=
task);
>  static inline void
>  arch_thread_struct_whitelist(unsigned long *offset, unsigned long *size=
)
>  {
> -       *offset =3D 0;
> -       *size =3D 0;
> +       *offset =3D sizeof(struct thread_struct)
> +               + offsetof(struct fpu, __fpstate.regs);
> +       *size =3D fpu_kernel_cfg.default_size;
>  }
>
>  static inline void
>
> and it seems to solve the problem (debug output from my previous printk =
patch):
>
> [  T57380] copy_uabi_to_xstate 1261: calling copy_from buffer with offse=
t =3D
> 0x200, size =3D 0x40
> [  T57380] copy_from_buffer: calling copy_from_user with to =3D ffffadf4=
95127d58
> from =3D 000000003ffef840, n =3D 0x40
> [  T57380] copy_uabi_to_xstate 1275: calling copy_from buffer with offse=
t =3D
> 0x18, size =3D 0x8
> [  T57380] copy_from_buffer: calling copy_from_user with to =3D ffffadf4=
95127d50
> from =3D 000000003ffef658, n =3D 0x8
> [  T57380] copy_uabi_to_xstate 1300: calling copy_from buffer 0 with off=
set =3D
> 0x0, size =3D 0xa0, dst =3D ffff90d285ec7880, kbuf =3D 0000000000000000,=
 ubuf =3D
> 000000003ffef640
> [  T57380] copy_from_buffer: calling copy_from_user with to =3D ffff90d2=
85ec7880
> from =3D 000000003ffef640, n =3D 0xa0
>
> Here the bug would happen in linux-next-20240806 which seems to be avoid=
ed by
> the patch.
>
> [  T57380] copy_uabi_to_xstate 1300: calling copy_from buffer 1 with off=
set =3D
> 0xa0, size =3D 0x100, dst =3D ffff90d285ec7920, kbuf =3D 000000000000000=
0, ubuf =3D
> 000000003ffef640
> [  T57380] copy_from_buffer: calling copy_from_user with to =3D ffff90d2=
85ec7920
> from =3D 000000003ffef6e0, n =3D 0x100
>
> Bert Karwatzki
>

After taking a closer look at the code I realized that my solution only wo=
rks if
task_struct and thread_struct are not randomized while your solution

        *offset =3D sizeof(struct task_struct)
                - offsetof(struct task_struct, thread)
                + offsetof(struct fpu, __fpstate.regs);
        *size =3D fpu_kernel_cfg.default_size;

works in those cases, too. Here's a way to introdce this fix using
fpu_thread_struct_whitelist in arch/x86/kernel/fpu/init.c where we can use
sizeof(task_struct) without including additional headers:

diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/proce=
ssor.h
index bd0621210f63..87472bdce053 100644
=2D-- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -510,14 +510,12 @@ extern struct fpu *x86_task_fpu(struct task_struct *=
task);
 # define x86_task_fpu(task)    ((struct fpu *)((void *)(task) +
sizeof(*(task))))
 #endif

-/*
- * X86 doesn't need any embedded-FPU-struct quirks:
- */
+extern void fpu_thread_struct_whitelist(unsigned long *offset, unsigned l=
ong
*size);
+
 static inline void
 arch_thread_struct_whitelist(unsigned long *offset, unsigned long *size)
 {
-       *offset =3D 0;
-       *size =3D 0;
+       fpu_thread_struct_whitelist(offset, size);
 }

 static inline void
diff --git a/arch/x86/kernel/fpu/init.c b/arch/x86/kernel/fpu/init.c
index 16b6611634c3..173670891f69 100644
=2D-- a/arch/x86/kernel/fpu/init.c
+++ b/arch/x86/kernel/fpu/init.c
@@ -179,6 +179,18 @@ static void __init fpu__init_task_struct_size(void)
        arch_task_struct_size =3D task_size;
 }

+/*
+ * Whitelist the FPU register state embedded into task_struct for hardene=
d
+ * usercopy.
+ */
+void fpu_thread_struct_whitelist(unsigned long *offset, unsigned long *si=
ze)
+{
+       *offset =3D sizeof(struct task_struct)
+               - offsetof(struct task_struct, thread)
+               + offsetof(struct fpu, __fpstate.regs);
+       *size =3D fpu_kernel_cfg.default_size;
+}
+
 /*
  * Set up the user and kernel xstate sizes based on the legacy FPU contex=
t
size.
  *


Bert Karwatzki

