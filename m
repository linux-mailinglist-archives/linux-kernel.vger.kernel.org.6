Return-Path: <linux-kernel+bounces-216067-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E71DE909AB4
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jun 2024 02:31:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8A399B2184A
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jun 2024 00:31:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 866BE4C80;
	Sun, 16 Jun 2024 00:31:25 +0000 (UTC)
Received: from mail-io1-f77.google.com (mail-io1-f77.google.com [209.85.166.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A89AA1849
	for <linux-kernel@vger.kernel.org>; Sun, 16 Jun 2024 00:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718497885; cv=none; b=aS20y4/zWTejIec2x9BzIci0GvqFFHvpate/m2I5K81yoexvlSc5EJv/3pZjUdIBF9wsIwfeJO6sK8e2S2uobktkdh131K2TR/BDB0TUkJxODcu+6+KUHx1mI0j9HLzt6u/8qHw+yDiI8Rw+L6a7Abs16HoBx2qgjU/1fKCnwIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718497885; c=relaxed/simple;
	bh=FkzN0BqVrHSTuDdE0t0nsz9RNvi0s+mZffu17msKZHc=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=W24B/q+BG5PAc0UNVzWrzJUsL3QAqD9QjiyM7zdlk4mnMzF0O+EaOLdFQjUDZUrt3vkRcZH+Sk8X39lf0OVD3qVjRJnMRtnOiINMw8QiVoEimee6BItwRdvH0mOKYLwXOSotCSUsqACU05lbMV2w7Xx84AdCtRdjfvEOlqtJoTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f77.google.com with SMTP id ca18e2360f4ac-7ebcbef22c8so385390639f.2
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jun 2024 17:31:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718497883; x=1719102683;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=le1gjHBXrg1Zm5ieyOK1u+06R6DnR9L8091ao80Sprs=;
        b=VrUBky08ASZm/TfyrjwPvmAYFLltVrqIGGNJKOAy0GGZLjV3NMP/nJ3B7M2Aox9x/N
         0qv87tWbhtoXt9sb48wIGQF3Wj9upueLvOB6uMZHB/tH9k8pX0o08wshyr9Ss6AeD7qr
         sfMIj4NABy5pkaIKsqGZ13YCd+1a+DjzvFgj7CzGlHROQ3e3x1nMGLRSJfLUS6MMs2RG
         e4jnp2YfTT7wbDgTn/vKjREDfurB78w5ita7tTH0mNUfZ/fsCbMB2K1ldwn5GH+EeCdq
         Kpbvpd60E1CpvFy7kfa2+K9LFwfgxfVdnBhzWzPL/xYaWK9gFEKnmkwPn/35+PbS59Ip
         2NJA==
X-Forwarded-Encrypted: i=1; AJvYcCUxdf8fErmHLS9fvJ8CZ8lR6YpaKT0t1SaBWhqV+KYzVaMB4/R9AlMnZJffQ92XTMPgy/wx7lJjImUf1gt5B4FKuZqDoHWRN3IC9aM/
X-Gm-Message-State: AOJu0Ywj5U0L60QwuqeM7/ps1EBOJ01NWitdZEtKC4cys3UPtM+/JP3I
	mht7wy+ImjdPxiYCbvohX8p/tXRKAU17JOFdBw/W9tsTzD4r3STfugqKlA//MPFeXKXpN7St5+w
	G5PbfeSxdJOKkLqrLHGd3UKdawIzgATVcf5Zo0Ioc3IA4U1IrBMBfn/c=
X-Google-Smtp-Source: AGHT+IEndy9ZipBcZrmVrn7iuNAbyY1XpiXb79kYRn1iMtgKXEGLcp6dIvvfHNN2Rb2R1veuMSLKRxGn4vUbMtky0goHD4c5Rk/A
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:831e:b0:4b9:7944:1d24 with SMTP id
 8926c6da1cb9f-4b979441efbmr79190173.1.1718497882752; Sat, 15 Jun 2024
 17:31:22 -0700 (PDT)
Date: Sat, 15 Jun 2024 17:31:22 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d95c65061af6f71c@google.com>
Subject: [syzbot] [bpf?] KMSAN: uninit-value in trie_lookup_elem (2)
From: syzbot <syzbot+3ac129054f077c7d7ca2@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, eddyz87@gmail.com, haoluo@google.com, 
	john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org, 
	linux-kernel@vger.kernel.org, martin.lau@linux.dev, sdf@google.com, 
	song@kernel.org, syzkaller-bugs@googlegroups.com, yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    614da38e2f7a Merge tag 'hid-for-linus-2024051401' of git:/..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14d2697e980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f5d2cbf33633f507
dashboard link: https://syzkaller.appspot.com/bug?extid=3ac129054f077c7d7ca2
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/89eafb874b71/disk-614da38e.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/356000512ad9/vmlinux-614da38e.xz
kernel image: https://storage.googleapis.com/syzbot-assets/839c73939115/bzImage-614da38e.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+3ac129054f077c7d7ca2@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: uninit-value in trie_lookup_elem+0x4b9/0x510 kernel/bpf/lpm_trie.c:234
 trie_lookup_elem+0x4b9/0x510 kernel/bpf/lpm_trie.c:234
 ____bpf_map_lookup_elem kernel/bpf/helpers.c:42 [inline]
 bpf_map_lookup_elem+0x5c/0x80 kernel/bpf/helpers.c:38
 ___bpf_prog_run+0x13fe/0xe0f0 kernel/bpf/core.c:1997
 __bpf_prog_run128+0xb5/0xe0 kernel/bpf/core.c:2236
 bpf_dispatcher_nop_func include/linux/bpf.h:1234 [inline]
 __bpf_prog_run include/linux/filter.h:657 [inline]
 bpf_prog_run include/linux/filter.h:664 [inline]
 __bpf_trace_run kernel/trace/bpf_trace.c:2381 [inline]
 bpf_trace_run2+0x116/0x300 kernel/trace/bpf_trace.c:2420
 __bpf_trace_kfree+0x29/0x40 include/trace/events/kmem.h:94
 trace_kfree include/trace/events/kmem.h:94 [inline]
 kfree+0x69e/0xa60 mm/slub.c:4450
 prog_array_map_alloc+0x233/0x430 kernel/bpf/arraymap.c:1107
 map_create+0x1185/0x1e10 kernel/bpf/syscall.c:1320
 __sys_bpf+0xa65/0xd90 kernel/bpf/syscall.c:5642
 __do_sys_bpf kernel/bpf/syscall.c:5767 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:5765 [inline]
 __x64_sys_bpf+0xa0/0xe0 kernel/bpf/syscall.c:5765
 x64_sys_call+0x96b/0x3b50 arch/x86/include/generated/asm/syscalls_64.h:322
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcf/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Local variable stack created at:
 __bpf_prog_run128+0x45/0xe0 kernel/bpf/core.c:2236
 bpf_dispatcher_nop_func include/linux/bpf.h:1234 [inline]
 __bpf_prog_run include/linux/filter.h:657 [inline]
 bpf_prog_run include/linux/filter.h:664 [inline]
 __bpf_trace_run kernel/trace/bpf_trace.c:2381 [inline]
 bpf_trace_run2+0x116/0x300 kernel/trace/bpf_trace.c:2420

CPU: 0 PID: 8814 Comm: syz-executor.0 Not tainted 6.9.0-syzkaller-02707-g614da38e2f7a #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/02/2024
=====================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

