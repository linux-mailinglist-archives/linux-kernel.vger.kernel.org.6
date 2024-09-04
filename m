Return-Path: <linux-kernel+bounces-315737-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 075AF96C65B
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 20:27:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FC37282636
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 18:27:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7047D1E490F;
	Wed,  4 Sep 2024 18:26:49 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B7FB1E4130
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 18:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725474409; cv=none; b=ST9MPTYkCyF3I7GF+euz6C+sIrv9FAHvRawoCXxpNq6OaNaJp97dXQT3ZAbg8/xRag4Sni9o3kkxgOyvjYBA1NHcoZiC7JBhLNAasDc7qmWhOGGUN+73KI/lLcdRMxZpoaXnsZWDb5Is9oKfWAGODU/y772gOCl4cAuDxVwdQpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725474409; c=relaxed/simple;
	bh=n7dB2iGQZPd0Kcqe8QHkMeXAD3j+ojrhB9qPTtmpK0k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bLWSbOtU0C5F9UBewKKBVh1saGADc5+udHNTLMaPCYXPQKJqyR2mtdzhFK+kJVhbNdr80Qu3kBr9CCYfHEnbilRCFYdaqUavt/b5nAAQV2lKN1Cr+jMRBjgbum52vH36dMElUIpJLYAh+0z27WSqrOl9GBAbK13PStiW25td+o0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0EF75FEC;
	Wed,  4 Sep 2024 11:27:12 -0700 (PDT)
Received: from J2N7QTR9R3 (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 68F2E3F73F;
	Wed,  4 Sep 2024 11:26:44 -0700 (PDT)
Date: Wed, 4 Sep 2024 19:26:39 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Marc Zyngier <maz@kernel.org>
Cc: Will Deacon <will@kernel.org>,
	syzbot <syzbot+908886656a02769af987@syzkaller.appspotmail.com>,
	catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [arm?] upstream test error: KASAN: invalid-access Write
 in setup_arch
Message-ID: <ZtimX79kHiYI9vTK@J2N7QTR9R3>
References: <000000000000f362e80620e27859@google.com>
 <20240830095254.GA7769@willie-the-truck>
 <86wmjwvatn.wl-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86wmjwvatn.wl-maz@kernel.org>

On Sat, Aug 31, 2024 at 06:52:52PM +0100, Marc Zyngier wrote:
> On Fri, 30 Aug 2024 10:52:54 +0100,
> Will Deacon <will@kernel.org> wrote:
> > 
> > On Fri, Aug 30, 2024 at 01:35:24AM -0700, syzbot wrote:
> > > Hello,
> > > 
> > > syzbot found the following issue on:
> > > 
> > > HEAD commit:    33faa93bc856 Merge branch kvmarm-master/next into kvmarm-m..
> > > git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/kvmarm/kvmarm.git fuzzme
> > 
> > +Marc, as this is his branch.
> >
> > > console output: https://syzkaller.appspot.com/x/log.txt?x=1398420b980000
> > > kernel config:  https://syzkaller.appspot.com/x/.config?x=2b7b31c9aa1397ca
> > > dashboard link: https://syzkaller.appspot.com/bug?extid=908886656a02769af987
> > > compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
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
> > > disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/384ffdcca292/non_bootable_disk-33faa93b.raw.xz
> > > vmlinux: https://storage.googleapis.com/syzbot-assets/9093742fcee9/vmlinux-33faa93b.xz
> > > kernel image: https://storage.googleapis.com/syzbot-assets/b1f599907931/Image-33faa93b.gz.xz
> > > 
> > > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > > Reported-by: syzbot+908886656a02769af987@syzkaller.appspotmail.com
> > > 
> > > Booting Linux on physical CPU 0x0000000000 [0x000f0510]
> > > Linux version 6.11.0-rc5-syzkaller-g33faa93bc856 (syzkaller@syzkaller) (gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40) #0 SMP PREEMPT now
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
> > > ==================================================================
> > > BUG: KASAN: invalid-access in smp_build_mpidr_hash arch/arm64/kernel/setup.c:133 [inline]
> > > BUG: KASAN: invalid-access in setup_arch+0x984/0xd60 arch/arm64/kernel/setup.c:356
> > > Write of size 4 at addr 03ff800086867e00 by task swapper/0
> > > Pointer tag: [03], memory tag: [fe]
> > > 
> > > CPU: 0 UID: 0 PID: 0 Comm: swapper Not tainted 6.11.0-rc5-syzkaller-g33faa93bc856 #0
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
> > > ==================================================================
> > 
> > I can't spot the issue here. We have a couple of fixed-length
> > (4 element) arrays on the stack and they're indexed by a simple loop
> > counter that runs from 0-3.
> 
> Having trimmed the config to the extreme, I can only trigger the
> warning with CONFIG_KASAN_SW_TAGS (CONFIG_KASAN_GENERIC does not
> scream). Same thing if I use gcc 14.2.0.

Likewise.

> However, compiling with clang 14 (Debian clang version 14.0.6) does
> *not* result in a screaming kernel, even with KASAN_SW_TAGS.
> 
> So I can see two possibilities here:
> 
> - either gcc is incompatible with KASAN_SW_TAGS and the generic
>   version is the only one that works
> 
> - or we have a compiler bug on our hands.

Looking at this there seem to be a bunch of problems here. I'll try to
write this up better tomorrow, but as a holding reply for now, there's
definitely a compiler issue and mahybe a kernel issue.

Mark.

