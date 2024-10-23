Return-Path: <linux-kernel+bounces-378302-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A6879ACE0C
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 17:06:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF669281CB2
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 15:06:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F9631CBE8F;
	Wed, 23 Oct 2024 14:56:05 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F4851B85C0
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 14:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729695365; cv=none; b=Lmjt5NcoWq5X7zIYpyEUrYjWFSOR3+NxBGFIOvT/wc7r7wdE/fprwWTLJS3T9AelTacel2aVaINKb6qTJY2uHMNc8cQN3IWED5LyBLkWRt7FlHI8Cq13Cwa/KZyduIsP7tcDyP3KAgVVCzE4UfmuoKWVyQPIQMV1Z2xf8NJt/S0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729695365; c=relaxed/simple;
	bh=IdiltfG8435WSjaXORtvgsVcZGhVEMX0hpcaalSxNVU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=saOqxCQYN3Z89AhMIpbsTBeyna7jU4LQN7umsv/a0tXovCDz0tRkit6idyRpTMYC3xNWnJd9jRyeRd0XeZ4a1TxePbPCjZho5VQl1TBxC9SWfzZTBzD2n/njidKluznaWlkx4UNYS5MRu9Ntb3reUC5j4b5RxsZ9CeH5QysqEyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a3b45bfc94so66160805ab.2
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 07:56:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729695362; x=1730300162;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q+pzlpPTVrcaAEwNPAoTWxPAND7t2xQt/C1348MfH4c=;
        b=ddeYV+rytf80aZBo8Zctz4RC4hPbg+7pghzpG9yrglgK1TsUtyldpRVe0/05gsFd4v
         RPY7Cc+YbxxiooeIx23bixzQkmGFmXoKI9FJ8ZKLI9Bb6z9SpDtQpZEidDATHkz5wIHf
         YjijviPMpVWmgtWlVrSUAOGmQ9TuRSXYYkLxUxsB6SFvsVQBOqWrtBG6NDUdIFG0fXXJ
         JCplapZgSiwIUz2eimCngxreyTy/zTNnIyd0bMsGayECwUND4KAjRgE0chN7Eq0m6G6S
         iCWCvvhwSUrKPsPu4r6vOS3FhNuER1ohsqxecdyDh+FLTsW0TvMiL3eWC/jBm9deox24
         bXXA==
X-Forwarded-Encrypted: i=1; AJvYcCUqXHiyzKkgiI9BRa93GOwaTiz2DZJKm93SWyCHHxT2+b0jK5hNzc3f4BvtG44uguxohPKKpbHFv3WI160=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOocfoTh36QgQWkEKhXHpiqUC+vmxPI3k5QyoAcJcQEEtHU1N0
	SnYCDxZ43CoRcfvuX7PFWKPh+uZ6ECsUruOD6lMEB1niAhmh2NyscBCN2RgO/MJYeZFFPjOOAFN
	WY8PZqw2oODKY9dBdXUnwjjOPKtFwcpbY1U1vwCpYGBZPwuaWTLe+IbE=
X-Google-Smtp-Source: AGHT+IHYy3yW+6HP8hCc8HPYeMMubxPW9pXtzZATwe5FFZG93C3D1//z0YadJvPKNiUBQpDH5zq1TxhpUPTf7kQqgts60LBrnQW4
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a6d:b0:3a0:c820:c5f0 with SMTP id
 e9e14a558f8ab-3a4d59e4a51mr29677575ab.24.1729695362598; Wed, 23 Oct 2024
 07:56:02 -0700 (PDT)
Date: Wed, 23 Oct 2024 07:56:02 -0700
In-Reply-To: <20241023144129.39005-1-aha310510@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67190e82.050a0220.10f4f4.01ad.GAE@google.com>
Subject: Re: [syzbot] [bcachefs?] KASAN: null-ptr-deref Read in bch2_sb_set_upgrade_extra
From: syzbot <syzbot+b468b9fef56949c3b528@syzkaller.appspotmail.com>
To: aha310510@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
KASAN: null-ptr-deref Read in bch2_sb_set_upgrade_extra

bcachefs (loop0): flagging btree freespace lost data
error reading btree root freespace l=0: btree_node_read_error, fixing
==================================================================
BUG: KASAN: null-ptr-deref in instrument_atomic_read include/linux/instrumented.h:68 [inline]
BUG: KASAN: null-ptr-deref in _test_bit include/asm-generic/bitops/instrumented-non-atomic.h:141 [inline]
BUG: KASAN: null-ptr-deref in btree_node_fake fs/bcachefs/btree_types.h:622 [inline]
BUG: KASAN: null-ptr-deref in have_stripes fs/bcachefs/sb-downgrade.c:146 [inline]
BUG: KASAN: null-ptr-deref in bch2_sb_set_upgrade_extra+0x152/0x270 fs/bcachefs/sb-downgrade.c:161
Read of size 8 at addr 00000000000000b0 by task syz.0.15/5608

CPU: 0 UID: 0 PID: 5608 Comm: syz.0.15 Not tainted 6.12.0-rc4-syzkaller-00047-gc2ee9f594da8 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 print_report+0xe8/0x550 mm/kasan/report.c:491
 kasan_report+0x143/0x180 mm/kasan/report.c:601
 kasan_check_range+0x282/0x290 mm/kasan/generic.c:189
 instrument_atomic_read include/linux/instrumented.h:68 [inline]
 _test_bit include/asm-generic/bitops/instrumented-non-atomic.h:141 [inline]
 btree_node_fake fs/bcachefs/btree_types.h:622 [inline]
 have_stripes fs/bcachefs/sb-downgrade.c:146 [inline]
 bch2_sb_set_upgrade_extra+0x152/0x270 fs/bcachefs/sb-downgrade.c:161
 bch2_fs_recovery+0x25c4/0x39c0 fs/bcachefs/recovery.c:860
 bch2_fs_start+0x356/0x5b0 fs/bcachefs/super.c:1036
 bch2_fs_get_tree+0xd68/0x1710 fs/bcachefs/fs.c:2174
 vfs_get_tree+0x90/0x2b0 fs/super.c:1800
 do_new_mount+0x2be/0xb40 fs/namespace.c:3507
 do_mount fs/namespace.c:3847 [inline]
 __do_sys_mount fs/namespace.c:4057 [inline]
 __se_sys_mount+0x2d6/0x3c0 fs/namespace.c:4034
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f822957f79a
Code: d8 64 89 02 48 c7 c0 ff ff ff ff eb a6 e8 de 1a 00 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f822a311e68 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007f822a311ef0 RCX: 00007f822957f79a
RDX: 00000000200058c0 RSI: 0000000020000000 RDI: 00007f822a311eb0
RBP: 00000000200058c0 R08: 00007f822a311ef0 R09: 0000000000010000
R10: 0000000000010000 R11: 0000000000000246 R12: 0000000020000000
R13: 00007f822a311eb0 R14: 000000000000590f R15: 0000000020000140
 </TASK>
==================================================================


Tested on:

commit:         c2ee9f59 KVM: selftests: Fix build on on non-x86 archi..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/ master
console output: https://syzkaller.appspot.com/x/log.txt?x=17c588a7980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fc6f8ce8c5369043
dashboard link: https://syzkaller.appspot.com/bug?extid=b468b9fef56949c3b528
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.

