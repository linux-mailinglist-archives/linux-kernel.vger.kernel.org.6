Return-Path: <linux-kernel+bounces-311022-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 689D4968405
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 12:04:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B85CDB24610
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 10:04:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C4FA13C827;
	Mon,  2 Sep 2024 10:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZyHOS+O3"
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B70C913BC0C
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 10:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725271404; cv=none; b=sM8krAcVxce8/C/28uSoMdUAHL4zUe3atc3RhGQNzb+rRyM6/NRmRzHZc3rQsx5xWPQsaGKswb2ihlDvQmURRHROw63pKbcNFe3y61ClwVkNB/+s5eL5aqGH6zi19PlkYt6muko1NmBM9ucQR7WKWGpSjsRXbZ645apHm9SsP4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725271404; c=relaxed/simple;
	bh=sxp6gDEwc7775gQ4BwO4+7qZIRZGZLaauuhCLYPJonk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fyj79X2BJyMk02Bf9xWTkutZr7d+tzA6w8A4GNAj7CuOu5ZMcN368nntAxOY/fy4X4IY+IFZMQDeMPPSOLDlZBUwh6PgcP00f4cz7UWTRH103TbYzbxncTWh3lNdwHsEwBygasjAkK/noCUUueH4KnZJfI0XU7pzoyeHG284Okc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZyHOS+O3; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-7b0c9bbddb4so2751694a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2024 03:03:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725271402; x=1725876202; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BpCAyKk7PEsq1N0Kwy6IWo8ryAf22vSmQMzbgUPv+rI=;
        b=ZyHOS+O3hwGCxAqRipu8syjtOntQk4dmEcxVILgMbU9JfF3H7DLgiIMjHXt+CsYV1u
         gzsplzrWxhpaoEFuYAByBmSADZVuuf2IUJxZyUujMvuIJaWKoRIxqAbh6OPeI4Xtl5VL
         +ovfpRInFwcuGl1NM/907zcctTcOp9b5oUBR4EsTi9epG7DOJMMj4+axjQYrH2XbRg2z
         mOvLbLK6rMly1VNt3jlfhPUZ+QoGnJZbygS2vWdi2dInAvNpZEVtGNhij1Bpd1/VulEy
         b2+uEOUgxbx6G4HZQ3vCPj7ZhXWXCceCLRZ3opOR5axGPjiU7ZA+1Ovc49ERQ0hxxgF/
         qerA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725271402; x=1725876202;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BpCAyKk7PEsq1N0Kwy6IWo8ryAf22vSmQMzbgUPv+rI=;
        b=LRn0iJV/yJdbi397hjeUP8sJbUOvZOokGynid1wqSZNs3GVN6IP3f9onQITjIEnztC
         t+Crb6GXMD0bsI8EBecamHu6lmvr86ApsiVh4CjVlj0NxKo5TFkWGa2Fj+m73Xtc445Y
         rzKPF4xaWhzTnc7JizeE7+DHRD0ODScgt5ZAvMaAkMW9yCYNc5Nqgp08oSqhfUblzQur
         1Nn4yT7v3MasHM3L2TEv51AO/+5vdOoeHWpJC6oVcrPHYBnfNEhXRIAc9oDbtvvVSh4Z
         EI9SO24tbfuK83wn634LhLlN3lZHbxTnSC2H7vqlPahSl/BejTGHSjzZW6ZbWNjUCE2S
         ENBg==
X-Forwarded-Encrypted: i=1; AJvYcCUK5tDm7+k0U3P1GlPH2YG6CtULpeqFrgVXI8XPoXp1z0M9pMXmWEEeehr8TkUvKC47GCU+xm9/gRpOY2U=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkWF5+PNxHR/slnCMjr+Kg5LRZ6c9A77FG+V0nbSbH8khOtUFm
	5pk32XQKsX9ncc6gPZG8s1oRGXsHaOkwO3fIJc7jiRNo5asii3y5dxR8AENYDJI0HUU7i0c7CXd
	0jzpkWtQqgu1DOxsSFMMWq8/nUdEwD41EVAP1
X-Google-Smtp-Source: AGHT+IFUhmZZpuL59LSs8qQVxHJeG7dvTX9F8C+kRjermxiDjCvwlIo8lm5ZSSGE3ex2/e/7yAkDvKL8R9MPPZ9cqyk=
X-Received: by 2002:a05:6a21:9214:b0:1c6:ae03:670b with SMTP id
 adf61e73a8af0-1cce0ff25e9mr15098292637.9.1725271401586; Mon, 02 Sep 2024
 03:03:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <000000000000f362e80620e27859@google.com> <20240830095254.GA7769@willie-the-truck>
 <86wmjwvatn.wl-maz@kernel.org>
In-Reply-To: <86wmjwvatn.wl-maz@kernel.org>
From: Aleksandr Nogikh <nogikh@google.com>
Date: Mon, 2 Sep 2024 12:03:10 +0200
Message-ID: <CANp29Y6EJXFTOy6Pd466r+RwzaGHe7JQMTaqMPSO2s7ubm-PKw@mail.gmail.com>
Subject: Re: [syzbot] [arm?] upstream test error: KASAN: invalid-access Write
 in setup_arch
To: Marc Zyngier <maz@kernel.org>, kasan-dev <kasan-dev@googlegroups.com>
Cc: Will Deacon <will@kernel.org>, 
	syzbot <syzbot+908886656a02769af987@syzkaller.appspotmail.com>, 
	catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

+kasan-dev

On Sat, Aug 31, 2024 at 7:53=E2=80=AFPM 'Marc Zyngier' via syzkaller-bugs
<syzkaller-bugs@googlegroups.com> wrote:
>
> On Fri, 30 Aug 2024 10:52:54 +0100,
> Will Deacon <will@kernel.org> wrote:
> >
> > On Fri, Aug 30, 2024 at 01:35:24AM -0700, syzbot wrote:
> > > Hello,
> > >
> > > syzbot found the following issue on:
> > >
> > > HEAD commit:    33faa93bc856 Merge branch kvmarm-master/next into kvm=
arm-m..
> > > git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/kvmarm/=
kvmarm.git fuzzme
> >
> > +Marc, as this is his branch.
> >
> > > console output: https://syzkaller.appspot.com/x/log.txt?x=3D1398420b9=
80000
> > > kernel config:  https://syzkaller.appspot.com/x/.config?x=3D2b7b31c9a=
a1397ca
> > > dashboard link: https://syzkaller.appspot.com/bug?extid=3D908886656a0=
2769af987
> > > compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils f=
or Debian) 2.40
> > > userspace arch: arm64
>
> As it turns out, this isn't specific to this branch. I can reproduce
> it with this config on a vanilla 6.10 as a KVM guest. Even worse,
> compiling with clang results in an unbootable kernel (without any
> output at all).
>
> Mind you, the binary is absolutely massive (130MB with gcc, 156MB with
> clang), and I wouldn't be surprised if we were hitting some kind of
> odd limit.
>
> > >
> > > Downloadable assets:
> > > disk image (non-bootable): https://storage.googleapis.com/syzbot-asse=
ts/384ffdcca292/non_bootable_disk-33faa93b.raw.xz
> > > vmlinux: https://storage.googleapis.com/syzbot-assets/9093742fcee9/vm=
linux-33faa93b.xz
> > > kernel image: https://storage.googleapis.com/syzbot-assets/b1f5999079=
31/Image-33faa93b.gz.xz
> > >
> > > IMPORTANT: if you fix the issue, please add the following tag to the =
commit:
> > > Reported-by: syzbot+908886656a02769af987@syzkaller.appspotmail.com
> > >
> > > Booting Linux on physical CPU 0x0000000000 [0x000f0510]
> > > Linux version 6.11.0-rc5-syzkaller-g33faa93bc856 (syzkaller@syzkaller=
) (gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40) #0=
 SMP PREEMPT now
> > > random: crng init done
> > > Machine model: linux,dummy-virt
> > > efi: UEFI not found.
> > > NUMA: No NUMA configuration found
> > > NUMA: Faking a node at [mem 0x0000000040000000-0x00000000bfffffff]
> > > NUMA: NODE_DATA [mem 0xbfc1d340-0xbfc20fff]
> > > Zone ranges:
> > >   DMA      [mem 0x0000000040000000-0x00000000bfffffff]
> > >   DMA32    empty
> > >   Normal   empty
> > >   Device   empty
> > > Movable zone start for each node
> > > Early memory node ranges
> > >   node   0: [mem 0x0000000040000000-0x00000000bfffffff]
> > > Initmem setup node 0 [mem 0x0000000040000000-0x00000000bfffffff]
> > > cma: Reserved 32 MiB at 0x00000000bba00000 on node -1
> > > psci: probing for conduit method from DT.
> > > psci: PSCIv1.1 detected in firmware.
> > > psci: Using standard PSCI v0.2 function IDs
> > > psci: Trusted OS migration not required
> > > psci: SMC Calling Convention v1.0
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > BUG: KASAN: invalid-access in smp_build_mpidr_hash arch/arm64/kernel/=
setup.c:133 [inline]
> > > BUG: KASAN: invalid-access in setup_arch+0x984/0xd60 arch/arm64/kerne=
l/setup.c:356
> > > Write of size 4 at addr 03ff800086867e00 by task swapper/0
> > > Pointer tag: [03], memory tag: [fe]
> > >
> > > CPU: 0 UID: 0 PID: 0 Comm: swapper Not tainted 6.11.0-rc5-syzkaller-g=
33faa93bc856 #0
> > > Hardware name: linux,dummy-virt (DT)
> > > Call trace:
> > >  dump_backtrace+0x204/0x3b8 arch/arm64/kernel/stacktrace.c:317
> > >  show_stack+0x2c/0x3c arch/arm64/kernel/stacktrace.c:324
> > >  __dump_stack lib/dump_stack.c:93 [inline]
> > >  dump_stack_lvl+0x260/0x3b4 lib/dump_stack.c:119
> > >  print_address_description mm/kasan/report.c:377 [inline]
> > >  print_report+0x118/0x5ac mm/kasan/report.c:488
> > >  kasan_report+0xc8/0x108 mm/kasan/report.c:601
> > >  kasan_check_range+0x94/0xb8 mm/kasan/sw_tags.c:84
> > >  __hwasan_store4_noabort+0x20/0x2c mm/kasan/sw_tags.c:149
> > >  smp_build_mpidr_hash arch/arm64/kernel/setup.c:133 [inline]
> > >  setup_arch+0x984/0xd60 arch/arm64/kernel/setup.c:356
> > >  start_kernel+0xe0/0xff0 init/main.c:926
> > >  __primary_switched+0x84/0x8c arch/arm64/kernel/head.S:243
> > >
> > > The buggy address belongs to stack of task swapper/0
> > >
> > > Memory state around the buggy address:
> > >  ffff800086867c00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> > >  ffff800086867d00: 00 fe fe 00 00 00 fe fe fe fe fe fe fe fe fe fe
> > > >ffff800086867e00: fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe
> > >                    ^
> > >  ffff800086867f00: fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe
> > >  ffff800086868000: fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> > I can't spot the issue here. We have a couple of fixed-length
> > (4 element) arrays on the stack and they're indexed by a simple loop
> > counter that runs from 0-3.
>
> Having trimmed the config to the extreme, I can only trigger the
> warning with CONFIG_KASAN_SW_TAGS (CONFIG_KASAN_GENERIC does not
> scream). Same thing if I use gcc 14.2.0.
>
> However, compiling with clang 14 (Debian clang version 14.0.6) does
> *not* result in a screaming kernel, even with KASAN_SW_TAGS.
>
> So I can see two possibilities here:
>
> - either gcc is incompatible with KASAN_SW_TAGS and the generic
>   version is the only one that works
>
> - or we have a compiler bug on our hands.
>
> Frankly, I can't believe the later, as the code is so daft that I
> can't imagine gcc getting it *that* wrong.
>
> Who knows enough about KASAN to dig into this?
>
>         M.
>
> --
> Without deviation from the norm, progress is not possible.
>

