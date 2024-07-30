Return-Path: <linux-kernel+bounces-267920-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83D40941C3B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 19:04:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 59B6AB244A8
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 17:04:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FCE81898EC;
	Tue, 30 Jul 2024 17:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mbh7PYdp"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77D081A6192
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 17:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722359084; cv=none; b=fWYQJT/d101VJHe0w1EeeE2uPwP7lQ8OEHzKvqtpeHxNyEq93SSpHpsjf9bQ8LrEfTSkYimovofesi5Pp+SB0/06d+8K+A5EVxEmj6DqHBWinJGYd2HtmKw/m9/g80KNjvwnPz8ygE9sNb1z9yO4tycFfTLhRQ01XQnkrgYwTmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722359084; c=relaxed/simple;
	bh=oUHNPADGB1VsFnGRRXASHQ6nufQZp6LG1+HoAKJs5Sw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dZYC10lNszmpZRVcnnDscUKxDWc3tVrdnVRwKTd60AX50wngIuf6gniiHJ7SZG1QPcxVV5QnXWEal7rGYZy1LEPoUzYj2xpal72H2SNSDIc6aZ+kEPQ+QaQ4j2eVhJeYuvpBstz8i8O0oL8svrBBrAGVz6KndVW8q54GoRoaegY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mbh7PYdp; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1fd640a6454so34838315ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 10:04:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722359082; x=1722963882; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=efGg+H+Dyc09mQ6EZ2KVHmrqUdwS64qZazlxDd2oNdA=;
        b=mbh7PYdpHYnFVjNGYE8P63Eiuami6cH/0oL1dXFPGqfseBmziEbkNf4BaU8c72Ziey
         1ZbqBT/CDxMEe0NnagcrG/ew0josdB0cZ+PkbPPJcWw8UDw6ig4woe5GISwiJEv9wKAk
         tjRCpN/MLc7qRfDIYLw+bpqm9MfXTByuM7+BkZK8EKBUjMOMkVgxhpMTI1z7kZnXfiNx
         7WHomZReSCltvovvSPWJ1yjKdpLS+PXvP6pdkYGh8LG5GFKOlqUx07lVJe5cxPWCIpE9
         tThGxuX9XbF9g04ORqAYXxfmuPpd5xHgKr11DvKrMQgrdm2T4yKya+5MEEqsCviBItGi
         hd9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722359082; x=1722963882;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=efGg+H+Dyc09mQ6EZ2KVHmrqUdwS64qZazlxDd2oNdA=;
        b=bWEnarA4S4KSuFXOyE0x5av04dHVWVPtVCd51uwR30u9pL00DyETzAMW4eBqqufg52
         rzkhB6pC9/2OGEdIhm+j7odMQ09WLwrsT5N45dJXPz3f7Nt/qUwu2TZQRUjd6Hp5e/Ej
         LCIgcC7RXcJ6LJlZAFkg8GAn2z/CS06owO2kEf3JS9CNah/O9CSSbj0C/DqWlL/X+Edz
         v7G4c44wwEfldTse4YYCTbx/4KDoeE+m3v+roLCS8Qkx0Cl5invjg61QWkjrXKYQxzJl
         SjGmfVaZmUDt+Rpdh4WtWlnWi4jopr5HqADH4A1KEhGVq1XOABJvvkJAqzoGICX2Olqp
         zM6g==
X-Gm-Message-State: AOJu0Yy84wNv5g9IHw78bJrzvjiDGQpKuYJg1ywCf7kv5r1j6XXymUr5
	dcp96YMK8MDpFNNbpVQcLT5KkKBjYYS9J5J3dWx4RPBny36fWei9ioGwwQ==
X-Google-Smtp-Source: AGHT+IG/kjBy22BPGEtCyHrg4GZwJ4P+Ddt7DClSm2xm+HR1kG/UOTL1qATvBhbHISfEWyDlNUVMnA==
X-Received: by 2002:a17:903:2593:b0:1fd:6655:e732 with SMTP id d9443c01a7336-1ff049310cbmr87334155ad.54.1722359081489;
        Tue, 30 Jul 2024 10:04:41 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fed7ee5734sm104221505ad.135.2024.07.30.10.04.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jul 2024 10:04:40 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Tue, 30 Jul 2024 10:04:39 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Jens Axboe <axboe@kernel.dk>
Subject: Re: Linux 6.11-rc1
Message-ID: <b7ecddb7-4486-4b2d-9179-82250cf830e7@roeck-us.net>
References: <CAHk-=wiyNokz0d3b=GRORij=mGvwoYHy=+bv6m2Hu_VqNdg66g@mail.gmail.com>
 <f8677c93-a76d-473c-8abc-8dc7b4403691@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f8677c93-a76d-473c-8abc-8dc7b4403691@roeck-us.net>

On Mon, Jul 29, 2024 at 08:29:20AM -0700, Guenter Roeck wrote:
> On Sun, Jul 28, 2024 at 02:40:01PM -0700, Linus Torvalds wrote:
> > The merge window felt pretty normal, and the stats all look pretty
> > normal too. I was expecting things to be quieter because of summer
> > vacations, but that (still) doesn't actually seem to have been the
> > case.
> > 
> > There's 12k+ regular commits (and another 850 merge commits), so as
> > always the summary of this all is just my merge log. The diffstats are
> > also (once again) dominated by some big hardware descriptions (another
> > AMD GPU register dump accounts for ~45% of the lines in the diff, and
> > some more perf event JSON descriptor files account for another 5%).
> > 
> > But if you ignore those HW dumps, the diff too looks perfectly
> > regular: drivers account for a bit over half (even when not counting
> > the AMD register description noise). The rest is roughly one third
> > architecture updates (lots of it is dts files, so I guess I could have
> > lumped that in with "more hw descriptor tables"), one third tooling
> > and documentation, and one third "core kernel" (filesystems,
> > networking, VM and kernel). Very roughly.
> > 
> > If you want more details, you should get the git tree, and then narrow
> > things down based on interests.
> > 
> 
> Build results:
> 	total: 158 pass: 139 fail: 19
> Failed builds:
...
> 	i386:q35:pentium3:defconfig:pae:nosmp:net=ne2k_pci:initrd

This failure bisects to commit 0256994887d7 ("Merge tag
'for-6.11/block-post-20240722' of git://git.kernel.dk/linux"). I have no
idea why that would be the case, but it is easy to reproduce. Maybe it is
coincidental. Either case, copying Jens in case he has an idea.

From the crash log:

[    3.605247] sr 2:0:0:0: Attached scsi generic sg0 type 5
[    3.764508] sched_clock: Marking stable (3740032902, 23766486)->(3766853760, -3054372)
[    3.768164] registered taskstats version 1
[    3.768271] Loading compiled-in X.509 certificates
[    3.990683] Btrfs loaded, zoned=no, fsverity=no
[    4.005012] cryptomgr_test (68) used greatest stack depth: 6136 bytes left
[    4.029889] traps: PANIC: double fault, error_code: 0x0
[    4.030257] Oops: double fault: 0000 [#1] PREEMPT PTI
[    4.030456] CPU: 0 UID: 0 PID: 70 Comm: modprobe Not tainted 6.11.0-rc1-00043-g94ede2a3e913 #1
[    4.030523] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
[    4.030613] EIP: asm_exc_page_fault+0x0/0x10
[    4.030886] Code: bf 3e c8 e9 23 06 00 00 66 90 8d 76 00 fc 6a 00 68 f0 bd 3e c8 e9 11 06 00 00 8d 76 00 fc 6a 00 68 54 c5 3e c8 e9 01 06 00 00 <8d> 76 00 fc 68 b0 e9 3e c8 e9 f3 05 00 00 66 90 8d 76 00 fc 6a 00
[    4.030949] EAX: 028af000 EBX: ffa03fbc ECX: 00000000 EDX: 00000000
[    4.030963] ESI: c2b51ff8 EDI: ffa04000 EBP: 42b51fb4 ESP: ffa0300c
[    4.030980] DS: 007b ES: 007b FS: 0000 GS: 0000 SS: 0068 EFLAGS: 00000006
[    4.031007] CR0: 80050033 CR2: ffa02ffc CR3: 08dc6000 CR4: 000006f0
[    4.031064] Call Trace:
[    4.031187]  <#DF>
[    4.031249]  ? show_regs+0x50/0x58
[    4.031296]  ? die+0x2f/0x90
[    4.031302]  ? vprintk+0x25/0x38
[    4.031315]  ? exc_double_fault+0x6d/0x7c
[    4.031327]  ? doublefault_shim+0x10a/0x118
[    4.031342]  ? asm_exc_int3+0x10/0x10
[    4.031353]  ? asm_exc_double_fault+0xa/0x10
[    4.031370]  </#DF>
[    4.031389]  <ENTRY_TRAMPOLINE>
[    4.031392]  ? asm_exc_int3+0x10/0x10
...
[    4.033360]  ? asm_exc_int3+0x10/0x10
[    4.033368]  ? restore_all_switch_stack+0x65/0xe6
[    4.033386]  </ENTRY_TRAMPOLINE>
[    4.033415] Modules linked in:
[    4.033685] ---[ end trace 0000000000000000 ]---
[    4.033741] EIP: asm_exc_page_fault+0x0/0x10
[    4.033750] Code: bf 3e c8 e9 23 06 00 00 66 90 8d 76 00 fc 6a 00 68 f0 bd 3e c8 e9 11 06 00 00 8d 76 00 fc 6a 00 68 54 c5 3e c8 e9 01 06 00 00 <8d> 76 00 fc 68 b0 e9 3e c8 e9 f3 05 00 00 66 90 8d 76 00 fc 6a 00
[    4.033757] EAX: 028af000 EBX: ffa03fbc ECX: 00000000 EDX: 00000000
[    4.033762] ESI: c2b51ff8 EDI: ffa04000 EBP: 42b51fb4 ESP: ffa0300c
[    4.033767] DS: 007b ES: 007b FS: 0000 GS: 0000 SS: 0068 EFLAGS: 00000006
[    4.033772] CR0: 80050033 CR2: ffa02ffc CR3: 08dc6000 CR4: 000006f0
[    4.033838] Kernel panic - not syncing: Fatal exception in interrupt
[    4.033980] Kernel Offset: disabled

Guenter

---
Bisect log:

# bad: [8400291e289ee6b2bf9779ff1c83a291501f017b] Linux 6.11-rc1
# good: [2c9b3512402ed192d1f43f4531fb5da947e72bd0] Merge tag 'for-linus' of git://git.kernel.org/pub/scm/virt/kvm/kvm
git bisect start 'v6.11-rc1' '2c9b3512402e'
# bad: [6dc2e98d5f1de162d1777aee97e59d75d70d07c5] s390: Remove protvirt and kvm config guards for uv code
git bisect bad 6dc2e98d5f1de162d1777aee97e59d75d70d07c5
# good: [30d77b7eef019fa4422980806e8b7cdc8674493e] mm/mglru: fix ineffective protection calculation
git bisect good 30d77b7eef019fa4422980806e8b7cdc8674493e
# good: [527eff227d4321c6ea453db1083bc4fdd4d3a3e8] Merge tag 'mm-nonmm-stable-2024-07-21-15-07' of git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
git bisect good 527eff227d4321c6ea453db1083bc4fdd4d3a3e8
# bad: [a362ade892e3e4de69296cddb1a23a1efe701428] Merge tag 'loongarch-6.11' of git://git.kernel.org/pub/scm/linux/kernel/git/chenhuacai/linux-loongson
git bisect bad a362ade892e3e4de69296cddb1a23a1efe701428
# good: [dd018c238b8489b6dd8c06f6b962ea75d79115ff] Merge tag 'bcachefs-2024-07-22' of https://evilpiepirate.org/git/bcachefs
git bisect good dd018c238b8489b6dd8c06f6b962ea75d79115ff
# good: [89ed6c9ac69ec398ccb648f5f675b43e8ca679ca] blk-cgroup: move congestion_count to struct blkcg
git bisect good 89ed6c9ac69ec398ccb648f5f675b43e8ca679ca
# good: [3892b11eac5aaaeefbf717f1953288b77759d9e2] LoongArch: Check TIF_LOAD_WATCH to enable user space watchpoint
git bisect good 3892b11eac5aaaeefbf717f1953288b77759d9e2
# bad: [0256994887d7c89c2a41d872aac67605bda8f115] Merge tag 'for-6.11/block-post-20240722' of git://git.kernel.dk/linux
git bisect bad 0256994887d7c89c2a41d872aac67605bda8f115
# good: [bf4c89fc8797f5c0964a0c3d561fbe7e8483b62f] block: don't call bio_uninit from bio_endio
git bisect good bf4c89fc8797f5c0964a0c3d561fbe7e8483b62f
# good: [85253bac4d02b1f95d6109c221aeccd7a262ec4d] block: don't free submitter owned integrity payload on I/O completion
git bisect good 85253bac4d02b1f95d6109c221aeccd7a262ec4d
# good: [74cc150282e41c6c0704cd305c9a4392dc64ef4d] block: don't free the integrity payload in bio_integrity_unmap_free_user
git bisect good 74cc150282e41c6c0704cd305c9a4392dc64ef4d
# first bad commit: [0256994887d7c89c2a41d872aac67605bda8f115] Merge tag 'for-6.11/block-post-20240722' of git://git.kernel.dk/linux

