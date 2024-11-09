Return-Path: <linux-kernel+bounces-402794-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E9C9E9C2C3B
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2024 12:39:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B230C282AF9
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2024 11:39:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4914F16F826;
	Sat,  9 Nov 2024 11:39:20 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD1EB158D7B
	for <linux-kernel@vger.kernel.org>; Sat,  9 Nov 2024 11:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731152359; cv=none; b=dMm6MuEVX26XvvM+ZPrS+s5GJDqxYoyHnQ+IGrI3izbvyVT9MTqMxeboLE/N4xzwDLN2btzVU7vfkrIryRCGefr6WRDeKHz01+q71EObw2eP6HCF7USKjuavY4TLbrR5fTnE2B6sKHQVToTsSc85w/MxPFE0sKsdASBZDlRNMNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731152359; c=relaxed/simple;
	bh=5aG2rHaiUlmEMLqw7F0FWU/6kg4QDeBn3HBJV3++824=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=tXkvj7Nlshyzypir/EdT1qvVnGfHQr25uYJH+OB10ZmVtDHFuwwXkYIPb1M3E63KIuoiGViaB87A34IK/uuKicrqk220PHFbtqU07SyL+UDDVNADaq1WkuE+le06qP4CURRBgup5KbuyEhLsqKM6u8ois0WPOgnBEdMQ1o6k5EI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-83aecd993faso350136539f.0
        for <linux-kernel@vger.kernel.org>; Sat, 09 Nov 2024 03:39:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731152357; x=1731757157;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=++6lAujwxk4eo89jMCrCm5z/M4+u+BlohDEPWMbpIq0=;
        b=FMpTkKUKzbvNJiW4mtK9mAFGGS+jXwNneBlQWtZGbwpKKxaCsBFfVc0DfOGKzb4Pox
         6O0oVMDtfADKALNb7XSvmvItkr4Z3fK0flSdhG4dts1mlDMAALaKM+xwRhuaUKN31P5c
         y6RISjuPr811NdQy+WekHlzbtgy/c5mlZM0FQ6vwTb2+aJ51NjqoQwrKXKs4M2Ta97bf
         +wfsjICjoICP/5aqqR4vhwYtl7MruwGekGMTv0Qa3c3SrMCM1p63PuRtH5JAZdwTZeYv
         kIwIPX6qiZbCqVM4ljJW1IzK7PH962h7sQijuD3PYZAza/Z/Wva6q34ReY4YREyjG4jV
         SbNg==
X-Gm-Message-State: AOJu0YxWwdD9VSoU0mpeY01vHayV1inLH/yP2+zV2DBptwGyvQVTbKzV
	glCA5ibanZhQ2+YBT60rhsrEc4547pHjzzloAMb3xEMbGf02kXPZ1kdaVa8RDHmlm/t3DlAa01q
	gESaTZMzwP7dVPqksafs46ZW26/KF1k8e750o2khAKP+MqF9SV+qFotg=
X-Google-Smtp-Source: AGHT+IEPos8vMO3QdtPU7ZSXlfcjizsCzml+OVgRr8Fg6lCIq+cQKvbvh8egc7Hi0AJFczKMA5Op0Oca0a+j6TUHn+9UyXP3wdH8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:ca49:0:b0:3a6:c000:4490 with SMTP id
 e9e14a558f8ab-3a6f249dc6cmr52965215ab.1.1731152356906; Sat, 09 Nov 2024
 03:39:16 -0800 (PST)
Date: Sat, 09 Nov 2024 03:39:16 -0800
In-Reply-To: <672ecc13.050a0220.138bd5.0038.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <672f49e4.050a0220.138bd5.003d.GAE@google.com>
Subject: Re: [syzbot] Re: [syzbot] [bcachefs?] KMSAN: uninit-value in bch2_copygc
From: syzbot <syzbot+8689d10f1894eedf774d@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: Re: [syzbot] [bcachefs?] KMSAN: uninit-value in bch2_copygc
Author: surajsonawane0215@gmail.com

#syz test

On Sat, Nov 9, 2024 at 8:12=E2=80=AFAM syzbot <
syzbot+8689d10f1894eedf774d@syzkaller.appspotmail.com> wrote:

> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    2e1b3cc9d7f7 Merge tag 'arm-fixes-6.12-2' of
> git://git.ker..
> git tree:       upstream
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=3D11361d5f98000=
0
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3D6fdf74cce3772=
23b
> dashboard link:
> https://syzkaller.appspot.com/bug?extid=3D8689d10f1894eedf774d
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for
> Debian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D12348f40580=
000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D11e7b58798000=
0
>
> Downloadable assets:
> disk image:
> https://storage.googleapis.com/syzbot-assets/08456e37db58/disk-2e1b3cc9.r=
aw.xz
> vmlinux:
> https://storage.googleapis.com/syzbot-assets/cc957f7ba80b/vmlinux-2e1b3cc=
9.xz
> kernel image:
> https://storage.googleapis.com/syzbot-assets/7579fe72ed89/bzImage-2e1b3cc=
9.xz
> mounted in repro:
> https://storage.googleapis.com/syzbot-assets/5903d7d7fe58/mount_4.gz
>
> IMPORTANT: if you fix the issue, please add the following tag to the
> commit:
> Reported-by: syzbot+8689d10f1894eedf774d@syzkaller.appspotmail.com
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
> BUG: KMSAN: uninit-value in rht_ptr_rcu include/linux/rhashtable.h:376
> [inline]
> BUG: KMSAN: uninit-value in __rhashtable_lookup
> include/linux/rhashtable.h:607 [inline]
> BUG: KMSAN: uninit-value in rhashtable_lookup
> include/linux/rhashtable.h:646 [inline]
> BUG: KMSAN: uninit-value in rhashtable_lookup_fast
> include/linux/rhashtable.h:672 [inline]
> BUG: KMSAN: uninit-value in bucket_in_flight fs/bcachefs/movinggc.c:144
> [inline]
> BUG: KMSAN: uninit-value in bch2_copygc_get_buckets
> fs/bcachefs/movinggc.c:170 [inline]
> BUG: KMSAN: uninit-value in bch2_copygc+0x1d3f/0x58f0
> fs/bcachefs/movinggc.c:221
>  rht_ptr_rcu include/linux/rhashtable.h:376 [inline]
>  __rhashtable_lookup include/linux/rhashtable.h:607 [inline]
>  rhashtable_lookup include/linux/rhashtable.h:646 [inline]
>  rhashtable_lookup_fast include/linux/rhashtable.h:672 [inline]
>  bucket_in_flight fs/bcachefs/movinggc.c:144 [inline]
>  bch2_copygc_get_buckets fs/bcachefs/movinggc.c:170 [inline]
>  bch2_copygc+0x1d3f/0x58f0 fs/bcachefs/movinggc.c:221
>  bch2_copygc_thread+0x7f7/0xfa0 fs/bcachefs/movinggc.c:381
>  kthread+0x3e2/0x540 kernel/kthread.c:389
>  ret_from_fork+0x6d/0x90 arch/x86/kernel/process.c:147
>  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
>
> Local variable b205.i created at:
>  bch2_copygc_get_buckets fs/bcachefs/movinggc.c:170 [inline]
>  bch2_copygc+0x15b3/0x58f0 fs/bcachefs/movinggc.c:221
>  bch2_copygc_thread+0x7f7/0xfa0 fs/bcachefs/movinggc.c:381
>
> CPU: 0 UID: 0 PID: 5796 Comm: bch-copygc/loop Not tainted
> 6.12.0-rc6-syzkaller-00077-g2e1b3cc9d7f7 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 09/13/2024
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
> Kernel panic - not syncing: kmsan.panic set ...
> CPU: 0 UID: 0 PID: 5796 Comm: bch-copygc/loop Tainted: G    B
> 6.12.0-rc6-syzkaller-00077-g2e1b3cc9d7f7 #0
> Tainted: [B]=3DBAD_PAGE
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 09/13/2024
> Call Trace:
>  <TASK>
>  __dump_stack lib/dump_stack.c:94 [inline]
>  dump_stack_lvl+0x216/0x2d0 lib/dump_stack.c:120
>  dump_stack+0x1e/0x30 lib/dump_stack.c:129
>  panic+0x4e2/0xcf0 kernel/panic.c:354
>  kmsan_report+0x2c7/0x2d0 mm/kmsan/report.c:218
>  __msan_warning+0x95/0x120 mm/kmsan/instrumentation.c:318
>  rht_ptr_rcu include/linux/rhashtable.h:376 [inline]
>  __rhashtable_lookup include/linux/rhashtable.h:607 [inline]
>  rhashtable_lookup include/linux/rhashtable.h:646 [inline]
>  rhashtable_lookup_fast include/linux/rhashtable.h:672 [inline]
>  bucket_in_flight fs/bcachefs/movinggc.c:144 [inline]
>  bch2_copygc_get_buckets fs/bcachefs/movinggc.c:170 [inline]
>  bch2_copygc+0x1d3f/0x58f0 fs/bcachefs/movinggc.c:221
>  bch2_copygc_thread+0x7f7/0xfa0 fs/bcachefs/movinggc.c:381
>  kthread+0x3e2/0x540 kernel/kthread.c:389
>  ret_from_fork+0x6d/0x90 arch/x86/kernel/process.c:147
>  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
>  </TASK>
> Kernel Offset: disabled
> Rebooting in 86400 seconds..
>
>
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
>
> If the report is already addressed, let syzbot know by replying with:
> #syz fix: exact-commit-title
>
> If you want syzbot to run the reproducer, reply with:
> #syz test: git://repo/address.git branch-or-commit-hash
> If you attach or paste a git patch, syzbot will apply it before testing.
>
> If you want to overwrite report's subsystems, reply with:
> #syz set subsystems: new-subsystem
> (See the list of subsystem names on the web dashboard)
>
> If the report is a duplicate of another one, reply with:
> #syz dup: exact-subject-of-another-report
>
> If you want to undo deduplication, reply with:
> #syz undup
>
> --
> You received this message because you are subscribed to the Google Groups
> "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an
> email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion visit
> https://groups.google.com/d/msgid/syzkaller-bugs/672ecc13.050a0220.138bd5=
.0038.GAE%40google.com
> .
>

