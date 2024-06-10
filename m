Return-Path: <linux-kernel+bounces-207617-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 89A059019C6
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 06:33:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 16E4C1F21C56
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 04:33:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03994BA2F;
	Mon, 10 Jun 2024 04:33:28 +0000 (UTC)
Received: from mail-io1-f79.google.com (mail-io1-f79.google.com [209.85.166.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1156B79E0
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 04:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717994007; cv=none; b=QWmcEx0RizMyGI81l6Slhdea/xtkeUnP4KsSIpHiWZfopkyzG38FNiWf9OzWBe4PwQysEXqWt9Kxt3spD0ZiJws/gb2rBTWt+a1pz6F695xTFbD8DMkOCMizVVvZV460GtS7ufzNOpMt2os4wQln+pWVrgpvcXkfryANUtjzO+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717994007; c=relaxed/simple;
	bh=ydLD1RkOwCZsbhlGLNEeTBvUpzcZYu5noepJpwCPjIA=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=lOjIMD1nQUh7M9yV9VDYU2yMavB0X2AOx1SwrPOvOZyzwZvgr8hc5LLQ67qUn8d6zLThV1L4pfVU3hc+zqcgU4lthXGNdeK0LOmEBAdbdhHXAkmGblMLZC6iRIHiN0eo6LHOuTx+3AXmbuD/AviARCIrhto4h6zUp+uDwjtvKkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f79.google.com with SMTP id ca18e2360f4ac-7e8e2ea7b4bso516035139f.0
        for <linux-kernel@vger.kernel.org>; Sun, 09 Jun 2024 21:33:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717994005; x=1718598805;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ORD44ilzook8vUdEHyndML1wyFlOK8tGkaPhI+ZRn60=;
        b=qfesrVjdK0B16dsmGQKV2pCz7DA3RNNTTM4bgUEMHub8JocQFWl0jUr50t2juUVQUJ
         pwIwBv/Er9VotqvcCikatRwgBomz0fM2PnleFLP42TGMEGxRV6NCn8tjEj4Tqo0yKkN/
         Gd+Ut2a6X9IFtLZIJ4S2XxDMYVno0EqQ4vIt3G2UZb/2JXR/qmov/+Xh1MmBK5rnRUS5
         ZX5NLi+go5VJCPzsViSHN4IM6f6AGB8Xy7pmC2WlJBjXsNpWu9JjNM7ItPWUZAH9y5G5
         qV9w+5Paa92HIU07EabfjwL6aMlhEBTptMWSdUu0nd7jmKo29CO2dnAmTrFx23ZaPZME
         fsJg==
X-Forwarded-Encrypted: i=1; AJvYcCVi8RnjIV66FMq1tTGewyKViEE8drBRTqmobH0DIZZReTudDOAuYtBHcO8YSCmefDMuvnjAS9TVkreJ1OeBWnFhmmMK9mTiYfdH7BVu
X-Gm-Message-State: AOJu0Yz+WmcZlOvhZSAdhhv/rjYwlnO3rq+R6wmO1VHaBH6rQkIko6S0
	59O1VWfwKpA9acjoFa50MG9ab3QUNhvEeOCc9zbcY0c0u2xikNw4aiEPWgLsI5Yp75k90EWUw7D
	jIrEIM+Qfy7JLu/tX0RML/f2wFMkjgfC0AgaDINL0ulHcYQZG88huPwY=
X-Google-Smtp-Source: AGHT+IHiwvUPMlpn+db2P4VFXW9vT8YPMtjrIpq8Ael5vJuZlWQCjzgq9F30pCYy6vaKjUPVhEMcoN3ksjYUbkAiTdlS7pjJZKXT
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:1585:b0:7da:5250:5bf8 with SMTP id
 ca18e2360f4ac-7eb57270623mr22029139f.4.1717994005201; Sun, 09 Jun 2024
 21:33:25 -0700 (PDT)
Date: Sun, 09 Jun 2024 21:33:25 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000681a20061a81a6c3@google.com>
Subject: [syzbot] [bpf?] KMSAN: uninit-value in strnchr (2)
From: syzbot <syzbot+33bce7b14333572224b2@syzkaller.appspotmail.com>
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
console+strace: https://syzkaller.appspot.com/x/log.txt?x=1106eaba980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f5d2cbf33633f507
dashboard link: https://syzkaller.appspot.com/bug?extid=33bce7b14333572224b2
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11604222980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14adcdba980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/89eafb874b71/disk-614da38e.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/356000512ad9/vmlinux-614da38e.xz
kernel image: https://storage.googleapis.com/syzbot-assets/839c73939115/bzImage-614da38e.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+33bce7b14333572224b2@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: uninit-value in strnchr+0x90/0xd0 lib/string.c:387
 strnchr+0x90/0xd0 lib/string.c:387
 bpf_bprintf_prepare+0x1c2/0x23c0 kernel/bpf/helpers.c:829
 ____bpf_trace_printk kernel/trace/bpf_trace.c:385 [inline]
 bpf_trace_printk+0xec/0x3e0 kernel/trace/bpf_trace.c:375
 ___bpf_prog_run+0x13fe/0xe0f0 kernel/bpf/core.c:1997
 __bpf_prog_run32+0xb2/0xe0 kernel/bpf/core.c:2236
 bpf_dispatcher_nop_func include/linux/bpf.h:1234 [inline]
 __bpf_prog_run include/linux/filter.h:657 [inline]
 bpf_prog_run include/linux/filter.h:664 [inline]
 __bpf_trace_run kernel/trace/bpf_trace.c:2381 [inline]
 bpf_trace_run2+0x116/0x300 kernel/trace/bpf_trace.c:2420
 __bpf_trace_tlb_flush+0x2c/0x40 include/trace/events/tlb.h:38
 trace_tlb_flush include/trace/events/tlb.h:38 [inline]
 switch_mm_irqs_off+0x9d2/0x1010 arch/x86/mm/tlb.c:642
 unuse_temporary_mm arch/x86/kernel/alternative.c:1815 [inline]
 __text_poke+0xb4e/0xfb0 arch/x86/kernel/alternative.c:1925
 text_poke arch/x86/kernel/alternative.c:1968 [inline]
 text_poke_bp_batch+0x17f/0x960 arch/x86/kernel/alternative.c:2276
 text_poke_flush arch/x86/kernel/alternative.c:2470 [inline]
 text_poke_finish+0x7d/0xd0 arch/x86/kernel/alternative.c:2477
 arch_jump_label_transform_apply+0x23/0x40 arch/x86/kernel/jump_label.c:146
 __jump_label_update+0x6af/0x6d0 kernel/jump_label.c:483
 jump_label_update+0x6a0/0x7a0 kernel/jump_label.c:882
 static_key_enable_cpuslocked+0x229/0x260 kernel/jump_label.c:205
 static_key_enable+0x23/0x30 kernel/jump_label.c:218
 tracepoint_add_func+0x1084/0x1280 kernel/tracepoint.c:361
 tracepoint_probe_register_prio_may_exist+0xa8/0xf0 kernel/tracepoint.c:482
 tracepoint_probe_register_may_exist include/linux/tracepoint.h:52 [inline]
 __bpf_probe_register kernel/trace/bpf_trace.c:2446 [inline]
 bpf_probe_register+0x201/0x250 kernel/trace/bpf_trace.c:2452
 bpf_raw_tp_link_attach+0x627/0x8a0 kernel/bpf/syscall.c:3865
 bpf_raw_tracepoint_open+0x485/0x8a0 kernel/bpf/syscall.c:3892
 __sys_bpf+0x5a6/0xd90 kernel/bpf/syscall.c:5702
 __do_sys_bpf kernel/bpf/syscall.c:5767 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:5765 [inline]
 __x64_sys_bpf+0xa0/0xe0 kernel/bpf/syscall.c:5765
 x64_sys_call+0x96b/0x3b50 arch/x86/include/generated/asm/syscalls_64.h:322
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcf/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Local variable stack created at:
 __bpf_prog_run32+0x43/0xe0 kernel/bpf/core.c:2236
 bpf_dispatcher_nop_func include/linux/bpf.h:1234 [inline]
 __bpf_prog_run include/linux/filter.h:657 [inline]
 bpf_prog_run include/linux/filter.h:664 [inline]
 __bpf_trace_run kernel/trace/bpf_trace.c:2381 [inline]
 bpf_trace_run2+0x116/0x300 kernel/trace/bpf_trace.c:2420

CPU: 1 PID: 5048 Comm: syz-executor406 Not tainted 6.9.0-syzkaller-02707-g614da38e2f7a #0
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

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

