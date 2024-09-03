Return-Path: <linux-kernel+bounces-313279-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 37EBE96A30B
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 17:41:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B810B1F2A177
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 15:40:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 406D9188592;
	Tue,  3 Sep 2024 15:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="E+wsw0YF"
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6E58188587
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 15:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725378013; cv=none; b=KXFKGNpEpgcrsGKGBCMtMlVsmAGb9qz6yL09YUOUFGB7kRA79VgxQu+bvZwqmF1XCyDOxzdDZHjVib3Lisk+E2yuZNgFdW/2MlHB2ZV3CUwEj2bKvTWyRfUmdsioUFjXdDyrFuwn2ktcGb8FyXPd+1GVbXJ2K/wEEpcxdG3v+fY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725378013; c=relaxed/simple;
	bh=BI1o8D5br3seFQmYf5/9GV+RcSnK6GEgOoNglmWVUG0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NdQtQzytVDt7YDYkJgLC0+HXTM7wk+Gw5Fils3Wxl2PdpoMzpiarFnS8h5n4MmTLCYokGje3Sepb9VxUwB3xr4Q143e2tV52dxAEJdVGuyfN1RsTJXh/ebOmTklwIdTUmeTl+DQFmyRDS+VTs9IZhGjkSLtZ3JwHzSh0KH1Z+U0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=E+wsw0YF; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6c34dd6c21aso18338196d6.2
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2024 08:40:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725378010; x=1725982810; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UzXSlxGfKWVyRi9Uw6NqDM+eL1Sfc+odIMySq3e0KgY=;
        b=E+wsw0YFEHEsinF05CYsKvG5kP85B7NazNqzP0e/Uvn/qHZCeY6v0XmZdOTVyT6e29
         W7ykJRdo+oHCYsbCUl0ykzoGvFJJOysNj6rkGrnL3jdFdO/lsFzvp6b/ITJhryuwv84l
         L/8CeMH3/ZzXedAhpyR+LmwEtC9oY5RpLoQJpuxiqeFvz5ZjjRNFGfhO0GNJ6i2Z3Cr5
         YwYvQ+EptinPKEDQxDpf0cB4AfrJxbTgn6sg1K55kwJhSE+2P3vSgmZX66ccqSROWmPg
         am6RFD7b60dTFK7G29wn+8z8pV4nsSC6nVgX+lTWVN8ErLKulUHCgewSRX7Nev63biFs
         IawA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725378010; x=1725982810;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UzXSlxGfKWVyRi9Uw6NqDM+eL1Sfc+odIMySq3e0KgY=;
        b=geXhj41hOwbscdFWO8tMVGSKG81FnOe9xj5OPquu89STCxmhoboT4tCn/GTww8B1MI
         tcmqzxsyxZLNuaA9FjTe+NGRVXP2kEzl36dpmLsxWsRk/GHu0ba9s0nNL80gE1nJHEW1
         AF8yFHENNkbpquUpocnvlFWX3n9t46IGTXXEE7xvqOZYJrD3p3GIb9SW48Gie4xg48P4
         vxtMxdsd9fyHe9P4b0UecOQwNfIOB6AtfLfHdebfbBS3PHhzwCrsXS+cU5OJQKt5sZ2J
         TZc7cQRBQ6YGTNqtLdEpaJW2X5a6jsvYI9GHIeDzZ9ZtixtTYrA2EsWUazSAS70F/Xff
         TLvA==
X-Forwarded-Encrypted: i=1; AJvYcCXbFfYJxrKBbW3bg4zecwF06xI5lWVJ/D1FQ/K5oVI3kPerVMvybskJOnov35n3Rtt3VtnTNUpgzVQPF7w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yztj6opcw02V4LfYso6eJwKloIj8EIAvxNDCpKCRKaiMbRAmKlu
	dQ0uZzuyHFxS4QhFB5D4DW6uEsz748dKx3Lfhrmj+LkcmF++HDOdMWG0XnKCO5wcUyfUF6Yvyj3
	85hYpe1wNwVw+Pmw2Fn8BjyM+zmL8aWJxfQ6R
X-Google-Smtp-Source: AGHT+IHG7xXqQzkk7b1DX1Qz4yQWTI+xkjpykYZx90dfsjbx7MJoVigaXC/onBxJ6lFIKYVZDHLytJdOiXqGI/fbMRU=
X-Received: by 2002:a05:6214:3a89:b0:6c3:6315:f287 with SMTP id
 6a1803df08f44-6c36315f363mr91001986d6.3.1725378010342; Tue, 03 Sep 2024
 08:40:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <000000000000f362e80620e27859@google.com> <20240830095254.GA7769@willie-the-truck>
 <86wmjwvatn.wl-maz@kernel.org> <CANp29Y6EJXFTOy6Pd466r+RwzaGHe7JQMTaqMPSO2s7ubm-PKw@mail.gmail.com>
In-Reply-To: <CANp29Y6EJXFTOy6Pd466r+RwzaGHe7JQMTaqMPSO2s7ubm-PKw@mail.gmail.com>
From: Alexander Potapenko <glider@google.com>
Date: Tue, 3 Sep 2024 17:39:28 +0200
Message-ID: <CAG_fn=UbWvN=FiXjU_QZKm_qDhxU8dZQ4fgELXsRsPCj4YHp9A@mail.gmail.com>
Subject: Re: [syzbot] [arm?] upstream test error: KASAN: invalid-access Write
 in setup_arch
To: samuel.holland@sifive.com, Andrey Konovalov <andreyknvl@gmail.com>
Cc: Marc Zyngier <maz@kernel.org>, Aleksandr Nogikh <nogikh@google.com>, 
	kasan-dev <kasan-dev@googlegroups.com>, Will Deacon <will@kernel.org>, 
	syzbot <syzbot+908886656a02769af987@syzkaller.appspotmail.com>, 
	catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 2, 2024 at 12:03=E2=80=AFPM 'Aleksandr Nogikh' via kasan-dev
<kasan-dev@googlegroups.com> wrote:
>
> +kasan-dev
>
> On Sat, Aug 31, 2024 at 7:53=E2=80=AFPM 'Marc Zyngier' via syzkaller-bugs
> <syzkaller-bugs@googlegroups.com> wrote:
> >
> > On Fri, 30 Aug 2024 10:52:54 +0100,
> > Will Deacon <will@kernel.org> wrote:
> > >
> > > On Fri, Aug 30, 2024 at 01:35:24AM -0700, syzbot wrote:
> > > > Hello,
> > > >
> > > > syzbot found the following issue on:
> > > >
> > > > HEAD commit:    33faa93bc856 Merge branch kvmarm-master/next into k=
vmarm-m..
> > > > git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/kvmar=
m/kvmarm.git fuzzme
> > >
> > > +Marc, as this is his branch.
> > >
> > > > console output: https://syzkaller.appspot.com/x/log.txt?x=3D1398420=
b980000
> > > > kernel config:  https://syzkaller.appspot.com/x/.config?x=3D2b7b31c=
9aa1397ca
> > > > dashboard link: https://syzkaller.appspot.com/bug?extid=3D908886656=
a02769af987
> > > > compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils=
 for Debian) 2.40
> > > > userspace arch: arm64
> >
> > As it turns out, this isn't specific to this branch. I can reproduce
> > it with this config on a vanilla 6.10 as a KVM guest. Even worse,
> > compiling with clang results in an unbootable kernel (without any
> > output at all).
> >
> > Mind you, the binary is absolutely massive (130MB with gcc, 156MB with
> > clang), and I wouldn't be surprised if we were hitting some kind of
> > odd limit.
> >
> > > >
> > > > Downloadable assets:
> > > > disk image (non-bootable): https://storage.googleapis.com/syzbot-as=
sets/384ffdcca292/non_bootable_disk-33faa93b.raw.xz
> > > > vmlinux: https://storage.googleapis.com/syzbot-assets/9093742fcee9/=
vmlinux-33faa93b.xz
> > > > kernel image: https://storage.googleapis.com/syzbot-assets/b1f59990=
7931/Image-33faa93b.gz.xz
> > > >
> > > > IMPORTANT: if you fix the issue, please add the following tag to th=
e commit:
> > > > Reported-by: syzbot+908886656a02769af987@syzkaller.appspotmail.com
> > > >
> > > > Booting Linux on physical CPU 0x0000000000 [0x000f0510]
> > > > Linux version 6.11.0-rc5-syzkaller-g33faa93bc856 (syzkaller@syzkall=
er) (gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40) =
#0 SMP PREEMPT now
> > > > random: crng init done
> > > > Machine model: linux,dummy-virt
> > > > efi: UEFI not found.
> > > > NUMA: No NUMA configuration found
> > > > NUMA: Faking a node at [mem 0x0000000040000000-0x00000000bfffffff]
> > > > NUMA: NODE_DATA [mem 0xbfc1d340-0xbfc20fff]
> > > > Zone ranges:
> > > >   DMA      [mem 0x0000000040000000-0x00000000bfffffff]
> > > >   DMA32    empty
> > > >   Normal   empty
> > > >   Device   empty
> > > > Movable zone start for each node
> > > > Early memory node ranges
> > > >   node   0: [mem 0x0000000040000000-0x00000000bfffffff]
> > > > Initmem setup node 0 [mem 0x0000000040000000-0x00000000bfffffff]
> > > > cma: Reserved 32 MiB at 0x00000000bba00000 on node -1
> > > > psci: probing for conduit method from DT.
> > > > psci: PSCIv1.1 detected in firmware.
> > > > psci: Using standard PSCI v0.2 function IDs
> > > > psci: Trusted OS migration not required
> > > > psci: SMC Calling Convention v1.0
> > > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > > BUG: KASAN: invalid-access in smp_build_mpidr_hash arch/arm64/kerne=
l/setup.c:133 [inline]
> > > > BUG: KASAN: invalid-access in setup_arch+0x984/0xd60 arch/arm64/ker=
nel/setup.c:356
> > > > Write of size 4 at addr 03ff800086867e00 by task swapper/0
> > > > Pointer tag: [03], memory tag: [fe]
> > > >
> > > > CPU: 0 UID: 0 PID: 0 Comm: swapper Not tainted 6.11.0-rc5-syzkaller=
-g33faa93bc856 #0
> > > > Hardware name: linux,dummy-virt (DT)
> > > > Call trace:
> > > >  dump_backtrace+0x204/0x3b8 arch/arm64/kernel/stacktrace.c:317
> > > >  show_stack+0x2c/0x3c arch/arm64/kernel/stacktrace.c:324
> > > >  __dump_stack lib/dump_stack.c:93 [inline]
> > > >  dump_stack_lvl+0x260/0x3b4 lib/dump_stack.c:119
> > > >  print_address_description mm/kasan/report.c:377 [inline]
> > > >  print_report+0x118/0x5ac mm/kasan/report.c:488
> > > >  kasan_report+0xc8/0x108 mm/kasan/report.c:601
> > > >  kasan_check_range+0x94/0xb8 mm/kasan/sw_tags.c:84
> > > >  __hwasan_store4_noabort+0x20/0x2c mm/kasan/sw_tags.c:149
> > > >  smp_build_mpidr_hash arch/arm64/kernel/setup.c:133 [inline]
> > > >  setup_arch+0x984/0xd60 arch/arm64/kernel/setup.c:356
> > > >  start_kernel+0xe0/0xff0 init/main.c:926
> > > >  __primary_switched+0x84/0x8c arch/arm64/kernel/head.S:243
> > > >
> > > > The buggy address belongs to stack of task swapper/0
> > > >
> > > > Memory state around the buggy address:
> > > >  ffff800086867c00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> > > >  ffff800086867d00: 00 fe fe 00 00 00 fe fe fe fe fe fe fe fe fe fe
> > > > >ffff800086867e00: fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe
> > > >                    ^
> > > >  ffff800086867f00: fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe
> > > >  ffff800086868000: fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe
> > > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > >
> > > I can't spot the issue here. We have a couple of fixed-length
> > > (4 element) arrays on the stack and they're indexed by a simple loop
> > > counter that runs from 0-3.
> >
> > Having trimmed the config to the extreme, I can only trigger the
> > warning with CONFIG_KASAN_SW_TAGS (CONFIG_KASAN_GENERIC does not
> > scream). Same thing if I use gcc 14.2.0.
> >
> > However, compiling with clang 14 (Debian clang version 14.0.6) does
> > *not* result in a screaming kernel, even with KASAN_SW_TAGS.
> >
> > So I can see two possibilities here:
> >
> > - either gcc is incompatible with KASAN_SW_TAGS and the generic
> >   version is the only one that works
> >
> > - or we have a compiler bug on our hands.
> >
> > Frankly, I can't believe the later, as the code is so daft that I
> > can't imagine gcc getting it *that* wrong.
> >
> > Who knows enough about KASAN to dig into this?

This looks related to Samuel's "arm64: Fix KASAN random tag seed
initialization" patch that landed in August.

I am a bit surprised the bug is reported before the
"KernelAddressSanitizer initialized" banner is printed - I thought we
shouldn't be reporting anything until the tool is fully initialized.

