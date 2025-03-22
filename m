Return-Path: <linux-kernel+bounces-572444-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EEA07A6CA5A
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Mar 2025 14:36:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0279C1B6326C
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Mar 2025 13:36:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ADC41EB184;
	Sat, 22 Mar 2025 13:36:04 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA8C1800
	for <linux-kernel@vger.kernel.org>; Sat, 22 Mar 2025 13:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742650564; cv=none; b=FJ68E0+McIuJuuhtrvyMSxVAAGgOvLrvXotbI9GfWNe91vc2tvpleUn8DLNRIGwBD+JnbIDo1sU+1OOh6w2AqWLxx4MUGYA0E0ErPBkSxCVm/V9uONL1kCR5ARJi/NoDt53rBqm9L5I2MOBp2B2/okO5CTkePcsu+MrXuYZZHMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742650564; c=relaxed/simple;
	bh=i1gHoTTxU0n5f6aPMeFVOr+3QdH96mrlIrGEywrsRKw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=b4n5GhV1XiYLyZFna2ODGo8DWDc4B0gq3H0fmqEuTY4usBjdK+2r0MmVEQCXHoNv5Gvn7eKnp0COgZN3v/vEqIWxpNKBNan+YYvuOXzJrStpHWgaAZhMlzfmKPcpbRff2aZh06LrB0XwAXkvlnMsxXK1sCuEnOIvZgzC+wra1Fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3ce8dadfb67so30167445ab.1
        for <linux-kernel@vger.kernel.org>; Sat, 22 Mar 2025 06:36:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742650562; x=1743255362;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3VCs3rYR1RXuALBtHU1ly+1tslqdrRFfmevHbIa5hCw=;
        b=bNrduOpvoH0mO+5mLEKIBvXoPSiJBIR822uJ3c7cWBRAgI1S84vGsAs9dy68Wv6uk1
         EjOTKBuI9POUASWZUCjLn5WM7IKLV0UZKu4aMjR9XlOo4gCS1DF9xyCdhzT/RsEB0Jfb
         YL37+dXBc+jNPE0tyW2MrxLu/aqKRcgGjC9OpJhbnEd16eHhxttybXQkmUXbKPz0xwfv
         KFIeb1SFCOX37hl0suP3Y4GnulAM7Ju6dTKkDZm7qi95BdgQgiTBZN6DpKQg3NHxZts+
         lMwT4mrr3/OWfQbIsXv8xagVSW86TqYo4/tN/pvlS2uaYgd0vms+bekN04l3NX1mNGT6
         hg8A==
X-Forwarded-Encrypted: i=1; AJvYcCW0rGWQwRiIwEg0hEnfPzAoMPmc0X0H9Rguk5h6px4cBouTbd7heTZvphAMvt1GX5gzXGt+a7mMbdBkSyU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzY2tVJMwYnCJ6slJlR1BN9nJqMsBRl5eg3cjrsrkeUaMqBDS7m
	/nmj3Gy7WJYb8+VRyKA2m2DgoKsvD1C5+KaG/LalfkiMUnQ8XQN7FcyWGl+KaZN6jA2NVovF0mZ
	wqOtUtJDS5PXVwi12crUarUfWBMnZu/gc3R3pORYfB5jt9DQp+9szJWo=
X-Google-Smtp-Source: AGHT+IGQ+n/ImAHnW7kHW2+2kxgz9xjMfSmeDNJfVxY2gojDkg7zTSpFly6eLNFM6zKl0/Wu7MzOKLag5retUIQAC6wnLZJsf+zo
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1646:b0:3d5:890b:8db with SMTP id
 e9e14a558f8ab-3d5960f4df6mr77522235ab.8.1742650561674; Sat, 22 Mar 2025
 06:36:01 -0700 (PDT)
Date: Sat, 22 Mar 2025 06:36:01 -0700
In-Reply-To: <20250322130257.227256-1-duttaditya18@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67debcc1.050a0220.31a16b.003c.GAE@google.com>
Subject: Re: [syzbot] [jfs?] UBSAN: array-index-out-of-bounds in add_missing_indices
From: syzbot <syzbot+b974bd41515f770c608b@syzkaller.appspotmail.com>
To: duttaditya18@gmail.com, jfs-discussion@lists.sourceforge.net, 
	linux-kernel@vger.kernel.org, shaggy@kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
BUG: unable to handle kernel paging request in lmLogSync

Unable to handle kernel paging request at virtual address dfff800000000006
KASAN: null-ptr-deref in range [0x0000000000000030-0x0000000000000037]
Mem abort info:
  ESR = 0x0000000096000005
  EC = 0x25: DABT (current EL), IL = 32 bits
  SET = 0, FnV = 0
  EA = 0, S1PTW = 0
  FSC = 0x05: level 1 translation fault
Data abort info:
  ISV = 0, ISS = 0x00000005, ISS2 = 0x00000000
  CM = 0, WnR = 0, TnD = 0, TagAccess = 0
  GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
[dfff800000000006] address between user and kernel address ranges
Internal error: Oops: 0000000096000005 [#1] PREEMPT SMP
Modules linked in:
CPU: 0 UID: 0 PID: 102 Comm: jfsCommit Not tainted 6.14.0-rc7-syzkaller-ga2392f333575-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/12/2025
pstate: 20400005 (nzCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : write_special_inodes fs/jfs/jfs_logmgr.c:207 [inline]
pc : lmLogSync+0xec/0x978 fs/jfs/jfs_logmgr.c:935
lr : lmLogSync+0xa4/0x978 fs/jfs/jfs_logmgr.c:934
sp : ffff80009ba17aa0
x29: ffff80009ba17b70 x28: ffff80009b359000 x27: dfff800000000000
x26: dfff800000000000 x25: ffff80009ba17ac0 x24: 1ffff0001202ba48
x23: 0000000000000002 x22: 0000000000000006 x21: 0000000000000030
x20: ffff0000edad3838 x19: ffff0000e80de000 x18: 1fffe000366f8886
x17: ffff80008fb6d000 x16: ffff80008b74b408 x15: ffff700013742f60
x14: 1ffff00013742f5d x13: 0000000000000004 x12: ffffffffffffffff
x11: ffff700013742f60 x10: 0000000000ff0100 x9 : 0000000000000000
x8 : 0000000000000006 x7 : 0000000000000000 x6 : 0000000000000000
x5 : 0000000000000001 x4 : 0000000000000004 x3 : 0000000000000010
x2 : 0000000000000004 x1 : 0000000000000001 x0 : 0000000000000000
Call trace:
 write_special_inodes fs/jfs/jfs_logmgr.c:207 [inline] (P)
 lmLogSync+0xec/0x978 fs/jfs/jfs_logmgr.c:935 (P)
 jfs_syncpt+0x74/0x98 fs/jfs/jfs_logmgr.c:1041
 txEnd+0x2ec/0x558 fs/jfs/jfs_txnmgr.c:549
 txLazyCommit fs/jfs/jfs_txnmgr.c:2684 [inline]
 jfs_lazycommit+0x4e0/0x9a8 fs/jfs/jfs_txnmgr.c:2733
 kthread+0x65c/0x7b0 kernel/kthread.c:464
 ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:862
Code: 97bd83a8 f94002a8 9100c115 d343fea8 (387b6908) 
---[ end trace 0000000000000000 ]---
----------------
Code disassembly (best guess):
   0:	97bd83a8 	bl	0xfffffffffef60ea0
   4:	f94002a8 	ldr	x8, [x21]
   8:	9100c115 	add	x21, x8, #0x30
   c:	d343fea8 	lsr	x8, x21, #3
* 10:	387b6908 	ldrb	w8, [x8, x27] <-- trapping instruction


Tested on:

commit:         a2392f33 drm/panthor: Clean up FW version information ..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=12ae95e4580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5f4c5deae8cc60fe
dashboard link: https://syzkaller.appspot.com/bug?extid=b974bd41515f770c608b
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64
patch:          https://syzkaller.appspot.com/x/patch.diff?x=11c7043f980000


