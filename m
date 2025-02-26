Return-Path: <linux-kernel+bounces-534869-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 356FAA46C0A
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 21:09:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E71A67A49B6
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 20:08:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DC41257429;
	Wed, 26 Feb 2025 20:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hIsCK2HE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA065256C8A;
	Wed, 26 Feb 2025 20:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740600513; cv=none; b=qTOp5xn4N14fXwlL2hAOeUsTERrg48xEZS90pxdGYsX0Wd8t+9Ljp8O6pPkePmOy50BpLvdSv56LxHETo+FBIYKXNVrJnkb8HTcQzHxsMMAw3VaeQNnfafLaMGOmpDv3caN+Gy4DJOWbCQ2PYnze73BoiDjOhP5KgX6+SSCvVNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740600513; c=relaxed/simple;
	bh=eyjq2Ww0jb1bZoJZAm8Lti1Xqu4cmFY5VmjvlWk4yqA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=W2SHQoSETQ36QvTAE79yIBsRebzVfO7jcWuh8xexfBcg0v0EKPfhOrZYzinC/b5uqWGBazjkFlVaWEpAm5Xc/Hf5avp1X3hXcUpN1IYQ7yr+benwoDVw01JfJLipO3pJmZFkROyn3vvgAIGpp0ETwBmH6TaH3lLqI/1tHfVEeQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hIsCK2HE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4686FC4CED6;
	Wed, 26 Feb 2025 20:08:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740600513;
	bh=eyjq2Ww0jb1bZoJZAm8Lti1Xqu4cmFY5VmjvlWk4yqA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=hIsCK2HEyhp8nnDLJ+Ekvog5QghvhFW4Cl+KDfi0CZGOJKkMDEC9CaRuDg/XDA1fC
	 qVqjjzFJyeQkF0X5bHt6W0Q7BuiacZqYGew1xs6zh8qQFVvmDVywAdlAO4gdvGBQhA
	 3394HsxFSmco+PRk6EEbmQDrCd0V+MGYMIWXPw5/uxsNmLRZAbI3PJJy7EZeZ4N8US
	 ykjC/ZKl/0ceKcYQtfp5CzccSnJO3mMsJ8D/wzkYmtl7zDlfLyIcljMsUqeUnTndqq
	 ydBaPiAoBMBdxvWMy52tcsFQBFOkIEe/3go+jCHkQNSrWKTxzoT6woIf2uu2euVfT6
	 J7GWf8+UFCESQ==
From: Pratyush Yadav <pratyush@kernel.org>
To: Mike Rapoport <rppt@kernel.org>
Cc: linux-kernel@vger.kernel.org,  Alexander Graf <graf@amazon.com>,  Andrew
 Morton <akpm@linux-foundation.org>,  Andy Lutomirski <luto@kernel.org>,
  Anthony Yznaga <anthony.yznaga@oracle.com>,  Arnd Bergmann
 <arnd@arndb.de>,  Ashish Kalra <ashish.kalra@amd.com>,  Benjamin
 Herrenschmidt <benh@kernel.crashing.org>,  Borislav Petkov <bp@alien8.de>,
  Catalin Marinas <catalin.marinas@arm.com>,  Dave Hansen
 <dave.hansen@linux.intel.com>,  David Woodhouse <dwmw2@infradead.org>,
  Eric Biederman <ebiederm@xmission.com>,  Ingo Molnar <mingo@redhat.com>,
  James Gowans <jgowans@amazon.com>,  Jonathan Corbet <corbet@lwn.net>,
  Krzysztof Kozlowski <krzk@kernel.org>,  Mark Rutland
 <mark.rutland@arm.com>,  Paolo Bonzini <pbonzini@redhat.com>,  Pasha
 Tatashin <pasha.tatashin@soleen.com>,  "H. Peter Anvin" <hpa@zytor.com>,
  Peter Zijlstra <peterz@infradead.org>,  Rob Herring <robh+dt@kernel.org>,
  Rob Herring <robh@kernel.org>,  Saravana Kannan <saravanak@google.com>,
  Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>,  Steven Rostedt
 <rostedt@goodmis.org>,  Thomas Gleixner <tglx@linutronix.de>,  Tom
 Lendacky <thomas.lendacky@amd.com>,  Usama Arif
 <usama.arif@bytedance.com>,  Will Deacon <will@kernel.org>,
  devicetree@vger.kernel.org,  kexec@lists.infradead.org,
  linux-arm-kernel@lists.infradead.org,  linux-doc@vger.kernel.org,
  linux-mm@kvack.org,  x86@kernel.org
Subject: Re: [PATCH v4 00/14] kexec: introduce Kexec HandOver (KHO)
In-Reply-To: <20250206132754.2596694-1-rppt@kernel.org> (Mike Rapoport's
	message of "Thu, 6 Feb 2025 15:27:40 +0200")
References: <20250206132754.2596694-1-rppt@kernel.org>
Date: Wed, 26 Feb 2025 20:08:27 +0000
Message-ID: <mafs0cyf4ii4k.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi Mike,

On Thu, Feb 06 2025, Mike Rapoport wrote:

> From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
>
> Hi,
>
> This a next version of Alex's "kexec: Allow preservation of ftrace buffers"
> series (https://lore.kernel.org/all/20240117144704.602-1-graf@amazon.com),
> just to make things simpler instead of ftrace we decided to preserve
> "reserve_mem" regions.
[...]

I applied the patches on top of v6.14-rc1 and tried them out on an x86
qemu machine . When I do a plain KHO activate and kexec, I get the below
errors on boot. This causes networking to fail on the VM. The errors are
consistent and happen every kexec-reboot, though fairly late in boot
after systemd tries to bring up network. The same setup has worked fine
with Alex's v3 of KHO patches.

Do you see anything obvious that might cause this? I can try to debug
this tomorrow, but if it rings any loud bells it would be nice to know.

    [    1.665225] ------------[ cut here ]------------
    [    1.665606] e1000 0000:00:03.0: DMA addr 0x0000000107978040+1522 overflow (mask ffffffff, bus limit 0).
    [    1.666364] WARNING: CPU: 6 PID: 2033 at kernel/dma/direct.h:103 dma_direct_map_page+0x271/0x280
    [    1.667074] Modules linked in:
    [    1.667335] CPU: 6 UID: 980 PID: 2033 Comm: systemd-network Not tainted 6.14.0-rc1+ #70
    [    1.668004] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Arch Linux 1.16.3-1-1 04/01/2014
    [    1.668760] RIP: 0010:dma_direct_map_page+0x271/0x280
    [    1.669166] Code: 04 48 8b 5d 00 48 89 ef e8 7c 5f 7a 00 4d 89 e9 4d 89 e0 48 89 da 48 89 e1 41 56 48 89 c6 48 c7 c7 58 a9 4f 82 e8 3f 09 f4 ff <0f> 0b 58 eb 88 e8 05 b7 b9 00 0f 1f 44 00 00 90 90 90 90 90 90 90
    [    1.670624] RSP: 0018:ffffc90002baf628 EFLAGS: 00010282
    [    1.671035] RAX: 0000000000000000 RBX: ffff888100dd2e00 RCX: 0000000000000027
    [    1.671607] RDX: ffff88842d920a88 RSI: 0000000000000001 RDI: ffff88842d920a80
    [    1.672177] RBP: ffff8881015530c0 R08: 0000000000000000 R09: ffffc90002baf4b0
    [    1.672757] R10: ffffffff82deeec8 R11: 0000000000000003 R12: 00000000000005f2
    [    1.673320] R13: 00000000ffffffff R14: 0000000000000000 R15: 0000000000000040
    [    1.673882] FS:  00007f15c3edb880(0000) GS:ffff88842d900000(0000) knlGS:0000000000000000
    [    1.674516] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
    [    1.674977] CR2: 00007f15c430cb50 CR3: 0000000102d28000 CR4: 00000000000006f0
    [    1.675554] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
    [    1.676117] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
    [    1.676698] Call Trace:
    [    1.676914]  <TASK>
    [    1.677097]  ? show_trace_log_lvl+0x1a7/0x2f0
    [    1.677458]  ? show_trace_log_lvl+0x1a7/0x2f0
    [    1.677811]  ? dma_map_page_attrs+0x6e/0x1f0
    [    1.678158]  ? dma_direct_map_page+0x271/0x280
    [    1.678510]  ? __warn.cold+0x93/0xf1
    [    1.678802]  ? dma_direct_map_page+0x271/0x280
    [    1.679158]  ? report_bug+0xff/0x140
    [    1.679461]  ? handle_bug+0x53/0x90
    [    1.679768]  ? exc_invalid_op+0x17/0x70
    [    1.680077]  ? asm_exc_invalid_op+0x1a/0x20
    [    1.680428]  ? dma_direct_map_page+0x271/0x280
    [    1.680789]  ? dma_direct_map_page+0x271/0x280
    [    1.681149]  dma_map_page_attrs+0x6e/0x1f0
    [    1.681483]  e1000_alloc_rx_buffers+0x140/0x340
    [    1.681852]  e1000_configure+0xf9/0x110
    [    1.682163]  e1000_open+0xc5/0x200
    [    1.682441]  __dev_open+0xff/0x1d0
    [    1.682728]  __dev_change_flags+0x1f8/0x240
    [    1.683066]  ? __nla_put+0x10/0x30
    [    1.683345]  dev_change_flags+0x26/0x70
    [    1.683668]  do_setlink.isra.0+0x2ca/0xbe0
    [    1.684002]  ? cred_has_capability.isra.0+0x6a/0x110
    [    1.684411]  ? blk_mq_get_tags+0x33/0x70
    [    1.684731]  ? virtqueue_add_split+0xa4/0x6b0
    [    1.685086]  ? security_capable+0x70/0xc0
    [    1.685409]  rtnl_setlink+0x184/0x220
    [    1.685712]  ? cred_has_capability.isra.0+0x6a/0x110
    [    1.686110]  ? xa_load+0x7a/0xb0
    [    1.686374]  ? __pfx_rtnl_setlink+0x10/0x10
    [    1.686710]  rtnetlink_rcv_msg+0x354/0x3f0
    [    1.687039]  ? folio_wait_bit_common+0x28b/0x300
    [    1.687407]  ? ___pte_offset_map+0x1b/0x140
    [    1.687757]  ? __pfx_rtnetlink_rcv_msg+0x10/0x10
    [    1.688123]  netlink_rcv_skb+0x53/0x100
    [    1.688451]  netlink_unicast+0x245/0x390
    [    1.688772]  netlink_sendmsg+0x21b/0x470
    [    1.689085]  ? __check_object_size.part.0+0x39/0xd0
    [    1.689481]  __sys_sendto+0x1d4/0x1e0
    [    1.689788]  __x64_sys_sendto+0x24/0x30
    [    1.690108]  do_syscall_64+0x4b/0x110
    [    1.690414]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
    [    1.690820] RIP: 0033:0x7f15c40fc897
    [    1.691114] Code: c7 c0 ff ff ff ff eb be 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 80 3d d5 37 0d 00 00 41 89 ca 74 10 b8 2c 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 69 c3 55 48 89 e5 53 48 83 ec 38 44 89 4d d0
    [    1.692589] RSP: 002b:00007ffc3c3080b8 EFLAGS: 00000202 ORIG_RAX: 000000000000002c
    [    1.693191] RAX: ffffffffffffffda RBX: 000055eda6a76a70 RCX: 00007f15c40fc897
    [    1.693752] RDX: 0000000000000020 RSI: 000055eda6a93260 RDI: 0000000000000003
    [    1.694308] RBP: 00007ffc3c308150 R08: 00007ffc3c3080c0 R09: 0000000000000080
    [    1.694867] R10: 0000000000000000 R11: 0000000000000202 R12: 000055eda6a93bc0
    [    1.695423] R13: 000055eda6a8c748 R14: 0000000000000000 R15: 000055eda6a8c700
    [    1.695998]  </TASK>
    [    1.696183] ---[ end trace 0000000000000000 ]---
    [    1.707952] e1000: ens3 NIC Link is Up 1000 Mbps Full Duplex, Flow Control: RX
    [...]
    [    3.071312] e1000 0000:00:03.0: TX DMA map failed
    [    3.263302] e1000 0000:00:03.0: TX DMA map failed
    [    3.388180] e1000 0000:00:03.0: TX DMA map failed
    [many more times]

Qemu version:

    QEMU emulator version 9.2.0
    Copyright (c) 2003-2024 Fabrice Bellard and the QEMU Project developers

Command to run qemu:

    qemu-system-x86_64 \
            -m 16G \
            -smp 10 \
            -kernel arch/x86/boot/bzImage \
            -append "console=ttyS0 root=/dev/vda rw earlyprintk=serial net.ifnames=0 kho=1 kho_scratch=200M,200M nokaslr" \
            -drive file=/local/home/ptyadav/qemu/drive.ext4,format=raw,if=virtio \
            -nic user,hostfwd=tcp::10022-:22 \
            -gdb tcp::1234 \
            -nographic

Steps used to kexec:

    $ echo 1 > /sys/kernel/kho/active
    $ kexec -l bzImage -s --initrd /boot/initramfs-linux.img --reuse-cmdline

DT after KHO activate:

    /dts-v1/;

    / {
            compatible = "kho-v1";
    };

-- 
Regards,
Pratyush Yadav

