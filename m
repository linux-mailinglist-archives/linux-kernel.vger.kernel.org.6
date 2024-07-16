Return-Path: <linux-kernel+bounces-253972-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E760A932979
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 16:45:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9AE40282C6A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 14:45:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34AB51A01DE;
	Tue, 16 Jul 2024 14:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SwmMoGDK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48D1419FA9E
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 14:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721140606; cv=none; b=rujT3RCiYUVRWwoE7y/pRXKimedSvx7lVubOb+wgapjGil+CtDhGblj+mVisyzN/Fjf1LsXFdkIDLuebWjqgRZuqAuxK0xKjmCHyEfkyAX8a5F/o60N1q13y+FPaIBIkcqSLMpCXBv0yR4rNXUqO3qf0AVzfrsb1uP6fFexY3Uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721140606; c=relaxed/simple;
	bh=lr7MZBRMd/oIbF6gc3IKKOBclfJ43ES2oXaNTQ8yunQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=PQ5ycCU5F0vfxOkH3/LKuQKkUKn/LizTThB8PheRJjMy2JdBhqtY1V/pTM0GCW/0IUb398xRzP1x7UsbCT8aq1Cj/4KqTqC/JOHZgs1BH5MnEYvIH6Qb+fBT8M6FB6Un989SjuxtdRODJc9Qe0B4Ahf/nlx3wYdzQ65gxVC5gyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SwmMoGDK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A030CC4AF09;
	Tue, 16 Jul 2024 14:36:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721140605;
	bh=lr7MZBRMd/oIbF6gc3IKKOBclfJ43ES2oXaNTQ8yunQ=;
	h=Date:From:To:Cc:Subject:From;
	b=SwmMoGDK1QRCOwh2MinKnko6xbS2p9SbOFi5NqGrGhwntTlukvnK43Svcxi3sjuV/
	 9fckbwtTbrjIqSumFH7s13qbY4vESpNJUM7vhAqQibSdCeuaim5qG5ks4Q+Vu76dii
	 LITOaBaOXTh/uFGsUBNaaFD67fOU3eWbLR6u1UoHnankvgObv7SO8MC1cUHmiBFiTh
	 Ezj0jH6jDwtkiFiTJ1aoYOxkEpS3kqd15YCdGqZ/uF5zQNAcxD8up3iHrgKFanL3EZ
	 icbWb4heBwWFdupUeRofRcDhRBmCY8QSb7lh9p1VCnh3l73AeUrSS2cZXi/YqqZUov
	 Rd/Z82rgoIjsQ==
Date: Tue, 16 Jul 2024 07:36:44 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-um@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Crash when booting UML after e3c92e81711d14b46c3121d36bc8e152cb843923
Message-ID: <20240716143644.GA1827132@thelio-3990X>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

Our continuous integration notices a crash when booting User Mode Linux
after commit e3c92e81711d ("runtime constants: add x86 architecture
support"), which I've distilled down to:

$ make -skj"$(nproc)" ARCH=um CROSS_COMPILE=x86_64-linux- defconfig linux

$ curl -LSs https://github.com/ClangBuiltLinux/boot-utils/releases/download/20230707-182910/x86_64-rootfs.ext4.zst | zstd -d >/tmp/rootfs.ext4

$ ./linux ubd0=/tmp/rootfs.ext4
Core dump limits :
        soft - NONE
        hard - NONE
Checking that ptrace can change system call numbers...OK
Checking syscall emulation for ptrace...OK
Checking environment variables for a tempdir...none found
Checking if /dev/shm is on tmpfs...OK
Checking PROT_EXEC mmap in /dev/shm...OK
Adding 945225728 bytes to physical memory to account for exec-shield gap
kmsg_dump:
<5>Linux version 6.10.0-rc4-00003-ge3c92e81711d (nathan@thelio-3990X) (x86_64-linux-gcc (GCC) 14.1.0, GNU ld (GNU Binutils) 2.42) #1 Tue Jul 16 07:14:46 MST 2024
<6>Zone ranges:
<6>  Normal   [mem 0x0000000000000000-0x000000009c56ffff]
<6>Movable zone start for each node
<6>Early memory node ranges
<6>  node   0: [mem 0x0000000000000000-0x000000003c56ffff]
<6>Initmem setup node 0 [mem 0x0000000000000000-0x000000003c56ffff]
<5>random: crng init done
<7>pcpu-alloc: s0 r0 d32768 u32768 alloc=1*32768
<7>pcpu-alloc: [0] 0
<5>Kernel command line: ubd0=/tmp/rootfs.ext4 root=98:0 console=tty0
<6>Dentry cache hash table entries: 8192 (order: 4, 65536 bytes, linear)
<4>
<4>Modules linked in:
<6>Pid: 0, comm: swapper Not tainted 6.10.0-rc4-00003-ge3c92e81711d
<6>RIP: 0033:vfs_caches_init_early+0xa9/0xe4
<6>RSP: 00000000604ebf10  EFLAGS: 00010206
<6>RAX: 000000009b817000 RBX: 00000000605e3d68 RCX: 0000000000000013
<6>RDX: 00000000604a2d78 RSI: 00000000604a2d84 RDI: ffffffffffc6543b
<6>RBP: 00000000604ebf10 R08: 0000000000000001 R09: 0000000000000001
<6>R10: 000000009b817000 R11: 0000000000000001 R12: 00000000604f0468
<6>R13: 0000000000000000 R14: 00000000600571bd R15: 00000000605d6000
<0>Kernel panic - not syncing: Segfault with no mm
<4>CPU: 0 PID: 0 Comm: swapper Not tainted 6.10.0-rc4-00003-ge3c92e81711d #1
<4>Stack:
<4> 604ebf80 60001ba4 00000000 6003328d
<4> 0000002d 00000000 00000000 604e00c0
<4> 00000000 604ebfb8 604d71c8 00000000
<4>Call Trace:
<4> [<60001ba4>] start_kernel+0x4de/0x79c
<4> [<6003328d>] ? block_signals+0x0/0xf
<4> [<60003c68>] start_kernel_proc+0x37/0x3b
<4> [<60020847>] new_thread_handler+0x7f/0xb1
<4> [<600233ae>] uml_finishsetup+0x54/0x59

At commit e78298556ee5 ("runtime constants: add default dummy
infrastructure"), everything starts up fine:

$ ./linux ubd0=/tmp/rootfs.ext4
Core dump limits :
        soft - NONE
        hard - NONE
Checking that ptrace can change system call numbers...OK
Checking syscall emulation for ptrace...OK
Checking environment variables for a tempdir...none found
Checking if /dev/shm is on tmpfs...OK
Checking PROT_EXEC mmap in /dev/shm...OK
Adding 808370176 bytes to physical memory to account for exec-shield gap
Linux version 6.10.0-rc4-00002-ge78298556ee5 (nathan@thelio-3990X) (x86_64-linux-gcc (GCC) 14.1.0, GNU ld (GNU Binutils) 2.42) #1 Tue Jul 16 07:29:04 MST 2024
Zone ranges:
  Normal   [mem 0x0000000000000000-0x00000000942ebfff]
Movable zone start for each node
Early memory node ranges
  node   0: [mem 0x0000000000000000-0x00000000342ebfff]
Initmem setup node 0 [mem 0x0000000000000000-0x00000000342ebfff]
random: crng init done
Kernel command line: ubd0=/tmp/rootfs.ext4 root=98:0 console=tty0
Dentry cache hash table entries: 8192 (order: 4, 65536 bytes, linear)
Inode-cache hash table entries: 4096 (order: 3, 32768 bytes, linear)
Sorting __ex_table...
Built 1 zonelists, mobility grouping on.  Total pages: 213740
mem auto-init: stack:all(zero), heap alloc:off, heap free:off, mlocked free:off
Memory: 47476K/854960K available (3575K kernel code, 974K rwdata, 1252K rodata, 153K init, 233K bss, 807484K reserved, 0K cma-reserved)
...

If there is any other information I can provide or patches I can test, I
am more than happy to do so.

Cheers,
Nathan

# bad: [d67978318827d06f1c0fa4c31343a279e9df6fde] Merge tag 'x86_cpu_for_v6.11_rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
# good: [0c3836482481200ead7b416ca80c68a29cfdaabd] Linux 6.10
git bisect start 'd67978318827d06f1c0fa4c31343a279e9df6fde' 'v6.10'
# bad: [bbb3556c014dc8ed1645b725ad84477603553743] Merge tag 'keys-next-6.11-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd
git bisect bad bbb3556c014dc8ed1645b725ad84477603553743
# good: [3c1743a685b19bc17cf65af4a2eb149fd3b15c50] floppy: add missing MODULE_DESCRIPTION() macro
git bisect good 3c1743a685b19bc17cf65af4a2eb149fd3b15c50
# bad: [4f5e249ec0ea8872e1644df23cffffbe28007188] Merge tag 'vfs-6.11.iomap' of git://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs
git bisect bad 4f5e249ec0ea8872e1644df23cffffbe28007188
# bad: [aff31330e037f75de7820bc7deb494eeaeaadd35] Merge tag 'vfs-6.11.pg_error' of git://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs
git bisect bad aff31330e037f75de7820bc7deb494eeaeaadd35
# bad: [2ffd45da0b06b26f30480584de7c660d84b2d7dc] Merge tag 'drm-fixes-2024-07-12' of https://gitlab.freedesktop.org/drm/kernel
git bisect bad 2ffd45da0b06b26f30480584de7c660d84b2d7dc
# bad: [5e0497553643b6c6acd16c389afb9cec210f4ea9] Merge branch 'link_path_walk'
git bisect bad 5e0497553643b6c6acd16c389afb9cec210f4ea9
# bad: [6a31ffdfed10dc48e6fd1775d50c22429382ab98] Merge branch 'word-at-a-time'
git bisect bad 6a31ffdfed10dc48e6fd1775d50c22429382ab98
# bad: [94a2bc0f611cd9fa4d26e4679bf7ea4b01b12d56] arm64: add 'runtime constant' support
git bisect bad 94a2bc0f611cd9fa4d26e4679bf7ea4b01b12d56
# good: [e78298556ee5d881f6679effb2a6743969ea6e2d] runtime constants: add default dummy infrastructure
git bisect good e78298556ee5d881f6679effb2a6743969ea6e2d
# bad: [e3c92e81711d14b46c3121d36bc8e152cb843923] runtime constants: add x86 architecture support
git bisect bad e3c92e81711d14b46c3121d36bc8e152cb843923
# first bad commit: [e3c92e81711d14b46c3121d36bc8e152cb843923] runtime constants: add x86 architecture support

