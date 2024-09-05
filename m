Return-Path: <linux-kernel+bounces-317268-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E45396DBB7
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 16:26:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 52D1B1C2115A
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 14:26:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC22928684;
	Thu,  5 Sep 2024 14:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PRm4Nw4m"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 328DEDDA8
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 14:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725546371; cv=none; b=J2BT5r91qwVvpAMo4stDUHo7161A4UWpp8DRw6T6o9Md+PxQci+ScAtjEC5/RFQMCLGQBu5g3xN5wo4Qxhncm/zdP9wTElfAlVctm5heq9wg3icyP18RoHeNwbG2bkBb8cgbHo8Tgvq9XlNkhhsHtktmhbZbQ10M5LCVrfioepE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725546371; c=relaxed/simple;
	bh=pFH8B6Eyf4uGgkFSU3xZXQdjxDBp6B88hGYmPC/svtE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OYPNbpEx/9+6IwaGp7y5Y/KGJJdieOhteYs/7C6RBKwySK0GXakCDLzi6HuWlFkjo/3KsBWLYyAoI7aVcNaC6e+lRp8aeBH5S5jTpXKpUsLdv2aghJoYQraSlwU56iHF0Fi5oUY0OZseiInnqBJVvKsyr35TddlXOakbfWxmQr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PRm4Nw4m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05B64C4CEC3
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 14:26:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725546371;
	bh=pFH8B6Eyf4uGgkFSU3xZXQdjxDBp6B88hGYmPC/svtE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=PRm4Nw4m9cUAk0ZvR5/ckkU5ZYSeTp/QO6V5cRgyLBmRyhnwPcIGhWLkq+/aK9UKf
	 n8l1VZZshiecP1TmlkFawhU/rJq8qU5/+JGpBA+ut5IlmfViH0fOHumLn7WSZhwAhM
	 O5NnN4err7XcUGIzJzKQMTzsVSSDESUSbCUtDRQRmmbZA88C7FRJQoLhmU5vyT2ANQ
	 FA4jg8Q6a0MkR3dEcz9bKqHbUEoTZfqkULrWdRrqT2xh+wIaBywnhGPAbF+Zg33LHy
	 lou8k4fg2Co6IXwbIL8FL3P1K9Ddou7nZQiQuciZwzNX4Jm9sTmbAw1sqGl//oGJwd
	 Pvpd9Tp9hujsw==
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2f4f24263acso15680131fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2024 07:26:10 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVu0kIvnY8P4545nKV5JuT75a2YcNo2LZgr4j3xDULihMVMoXhN74iyfxnjAgfPcCSruL+Y1YyQYRwAffo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuuQpM9rQZ+uvvXVxpESVK0u6a4nhMYM2G45N9vjjECJRE8oZ+
	wBo4ARIOsk7jDVMg3h78ezQpc2F83rz9WpcR7ks+mnRsND2XgXDEJdNSFkpsT/MNqIk0Fmuoecm
	PezyQ7Gv4Q8CrXJl2Ft0T95580Cg=
X-Google-Smtp-Source: AGHT+IG4JKd1xgY42FHyNL2vm6tXNqQPMZqby2e/GfgppD2lmUS+bKBFUqF0GnVg8VA1AcCO0jVF4/XoWML+d6KaUv0=
X-Received: by 2002:a05:651c:1a0c:b0:2f7:4de4:2632 with SMTP id
 38308e7fff4ca-2f74de4276amr10501601fa.49.1725546369331; Thu, 05 Sep 2024
 07:26:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <000000000000f362e80620e27859@google.com> <20240830095254.GA7769@willie-the-truck>
 <86wmjwvatn.wl-maz@kernel.org> <Ztm56ZxiqlTL6ntA@J2N7QTR9R3.cambridge.arm.com>
In-Reply-To: <Ztm56ZxiqlTL6ntA@J2N7QTR9R3.cambridge.arm.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Thu, 5 Sep 2024 16:25:57 +0200
X-Gmail-Original-Message-ID: <CAMj1kXHHRvWBPOoxOU=S0BY6fkEhs1j1qBvrygBH7pKwnbcJXA@mail.gmail.com>
Message-ID: <CAMj1kXHHRvWBPOoxOU=S0BY6fkEhs1j1qBvrygBH7pKwnbcJXA@mail.gmail.com>
Subject: Re: [syzbot] [arm?] upstream test error: KASAN: invalid-access Write
 in setup_arch
To: Mark Rutland <mark.rutland@arm.com>
Cc: Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>, 
	syzbot <syzbot+908886656a02769af987@syzkaller.appspotmail.com>, 
	catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 5 Sept 2024 at 16:03, Mark Rutland <mark.rutland@arm.com> wrote:
>
> [adding Ard and LLVM folk; there's a question right at the end after
> some context]
>
> On Sat, Aug 31, 2024 at 06:52:52PM +0100, Marc Zyngier wrote:
> > On Fri, 30 Aug 2024 10:52:54 +0100,
> > Will Deacon <will@kernel.org> wrote:
> > >
> > > On Fri, Aug 30, 2024 at 01:35:24AM -0700, syzbot wrote:
> > > > Hello,
> > > >
> > > > syzbot found the following issue on:
> > > >
> > > > HEAD commit:    33faa93bc856 Merge branch kvmarm-master/next into kvmarm-m..
> > > > git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/kvmarm/kvmarm.git fuzzme
> > >
> > > +Marc, as this is his branch.
> > >
> > > > console output: https://syzkaller.appspot.com/x/log.txt?x=1398420b980000
> > > > kernel config:  https://syzkaller.appspot.com/x/.config?x=2b7b31c9aa1397ca
> > > > dashboard link: https://syzkaller.appspot.com/bug?extid=908886656a02769af987
> > > > compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
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
>
> Putting the KASAN issue aside (which I'll handle in a separate thread),
> I think there is a real issue here with LLVM.
>
> What's going on here is that .idmap.text ends up more than 128M away
> from .head.text, so the 'b primary_entry' at the start of the Image
> isn't in range:
>
> | [mark@lakrids:~/src/linux]% usekorg 14.1.0 aarch64-linux-objdump -t vmlinux | grep -w _text
> | ffff800080000000 g       .head.text     0000000000000000 _text
> | [mark@lakrids:~/src/linux]% usekorg 14.1.0 aarch64-linux-objdump -t vmlinux | grep -w primary_entry
> | ffff8000889df0e0 g       .rodata.text   000000000000006c primary_entry
>
> ... as those are ~128MiB apart.
>
> When building with GCC those end up ~101MiB apart:
>
> | [mark@lakrids:~/src/linux]% usekorg 14.1.0 aarch64-linux-objdump -t vmlinux | grep -w _text
> | ffff800080000000 g       .head.text     0000000000000000 _text
> | [mark@lakrids:~/src/linux]% usekorg 14.1.0 aarch64-linux-objdump -t vmlinux | grep -w primary_entry
> | ffff8000865ae0e0 g       .rodata.text   000000000000006c primary_entry
>
> When that happens, LLD makes the header branch to a veneer/thunk:
>
> | ffff800080000000 <_text>:
> | ffff800080000000:       fa405a4d        ccmp    x18, #0x0, #0xd, pl     // pl = nfrst
> | ffff800080000004:       14003fff        b       ffff800080010000 <__AArch64AbsLongThunk_primary_entry>
>
> ... and unfortunately, that veneer/thunk uses a literal with the
> statically-linked TTBR1 address of primary_entry:
>
> | ffff800080010000 <__AArch64AbsLongThunk_primary_entry>:
> | ffff800080010000:       58000050        ldr     x16, ffff800080010008 <__AArch64AbsLongThunk_primary_entry+0x8>
> | ffff800080010004:       d61f0200        br      x16
> | ffff800080010008:       889df0e0        .word   0x889df0e0
> | ffff80008001000c:       ffff8000        .word   0xffff8000
>
...
> LLVM folk, is there any existing option to ask LLD to use ADRP+ADD for
> the veneer/thunk? ... and if not, would it be possible to add an option
> for that?
>

ld.lld takes --pic-veneer, which (from looking at the llvm sources)
appears to do what we need here.

