Return-Path: <linux-kernel+bounces-269113-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E209942DC8
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 14:08:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 334701F25B09
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 12:08:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D2551AE868;
	Wed, 31 Jul 2024 12:08:27 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 381C81AD9F4
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 12:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722427706; cv=none; b=nhl/L0yYyuW2M3JF+O6kN8mJhKqlZkQMNBD5UZw98F9rZ0bEYK4XfszBWwaTNFWxN9kcBZ3n+c0WAF9Z30jJI5KTiebHozbGFD+uO6WUzfIdOIYkVmbjo7YTPAWPe8LEKaxV5zoKjLUN9e2+439hrJdz40FMsZ9tQMGshuh0tek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722427706; c=relaxed/simple;
	bh=ZjOPHSczPrvYFyZb3tCZMG+cJtrgUrCWgkRL/V+3Oj0=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=YVqETICrWRxMNik8YNMB1ZOkKav2T+0mmjrUELN8RAz148ODIH6I8xr1WiVbLnJ9O3BS8fMxbMGTxN6Dg1rJqjCDquAIeCKyDZaqI8j2fRMRNkRDUW++VEcwVPwArfHkyFHvEenH7ogpRkrI3okspMsQyUf7t22pWHx/M/kaCnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-81f8c780fe7so848423439f.1
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 05:08:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722427704; x=1723032504;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Vxjvtl5PoCgXOddMN1XFRhhD3GMwICmVd4yxgIy4uq8=;
        b=fCMpb4QniR++oJG6R970aSRQ2piSgWWjpTdIg5heHaCmOVVHoXkQWnnVIZK8f13ycn
         ngoh4yYvjPrzFq7lmizMI3sO0Er7BZ0qf7MCCvOOhFQ5WLHMgDLN5ysSsv4kOlb33w9e
         PSOiDP0BWreurtjT92OjwJbLPxUKzePu5MdyuJNMJN+VOTNyud6qc683jX2MaRqRRtNb
         VCD3ACLbWzmU6LASsWugho2OFu6awqzlXAMymjfVfAm/bUjWVWr2QvACk42TQ8DiMKme
         xzAPLm/sPgTr8d3yzPhqxjcZuYoEXLMxntANSLODa0/71CnW8vxvi0puf3AQUUUZu1oo
         X0yQ==
X-Forwarded-Encrypted: i=1; AJvYcCVOrPloDwP4oXHVqN+pjJMd0YLPRxoMZJ+punc0cI7OcdPq06pr/pXBTwn+rqDm8dME7C4vZd6AT9X0mMoR6EHOsxaZ1y3/wE5Ec3WS
X-Gm-Message-State: AOJu0YzrJl9Y041iVuHqgBn187pxpmgs0KUttN21TZ7xYwwESCsF1zus
	xonh46xyQZaPLbkbqOwZE4Ns5Rq+Y8eF3GET5rj+UB3FwVpXK4gH1d/Ow8yM4dey2mQJS5wmujr
	nYkQcSL5GF0IQhVhe423zIbEFKEVQKYRaVrEpmh7xEvCc1t4znAtJ3oI=
X-Google-Smtp-Source: AGHT+IHyhbFFxucIpfDr1JiI5gxe87mQYwYkHz8KjoQDnrbF7FH0TiMB/jLdPHWzoMKX9lp1iHaBHnFgX+3GgsxiLnQfZp8SaoWi
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:6406:b0:81f:c103:3e7c with SMTP id
 ca18e2360f4ac-81fc10340e3mr5392539f.4.1722427704345; Wed, 31 Jul 2024
 05:08:24 -0700 (PDT)
Date: Wed, 31 Jul 2024 05:08:24 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000781a1e061e89f3be@google.com>
Subject: [syzbot] [perf?] KCSAN: data-race in _free_event / perf_pending_task
From: syzbot <syzbot+ef3b1bb7dd78b4e9109c@syzkaller.appspotmail.com>
To: acme@kernel.org, adrian.hunter@intel.com, 
	alexander.shishkin@linux.intel.com, irogers@google.com, jolsa@kernel.org, 
	kan.liang@linux.intel.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mark.rutland@arm.com, mingo@redhat.com, 
	namhyung@kernel.org, peterz@infradead.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    94ede2a3e913 profiling: remove stale percpu flip buffer va..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1277094b980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=bc4a9b665a33d32c
dashboard link: https://syzkaller.appspot.com/bug?extid=ef3b1bb7dd78b4e9109c
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/44ee867c2428/disk-94ede2a3.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/94d1e02bfdfd/vmlinux-94ede2a3.xz
kernel image: https://storage.googleapis.com/syzbot-assets/954c62ebb0b0/bzImage-94ede2a3.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+ef3b1bb7dd78b4e9109c@syzkaller.appspotmail.com

==================================================================
BUG: KCSAN: data-race in _free_event / perf_pending_task

write to 0xffff88812715a1e8 of 4 bytes by task 22781 on cpu 1:
 perf_pending_task+0xe8/0x220 kernel/events/core.c:6869
 task_work_run+0x13a/0x1a0 kernel/task_work.c:228
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:114 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0xbe/0x130 kernel/entry/common.c:218
 do_syscall_64+0xd6/0x1c0 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

read to 0xffff88812715a1e8 of 4 bytes by task 22780 on cpu 0:
 perf_pending_task_sync kernel/events/core.c:5199 [inline]
 _free_event+0x3d/0xa10 kernel/events/core.c:5223
 put_event kernel/events/core.c:5351 [inline]
 perf_event_release_kernel+0x61a/0x670 kernel/events/core.c:5476
 perf_release+0x25/0x30 kernel/events/core.c:5486
 __fput+0x192/0x6f0 fs/file_table.c:422
 ____fput+0x15/0x20 fs/file_table.c:450
 task_work_run+0x13a/0x1a0 kernel/task_work.c:228
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:114 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0xbe/0x130 kernel/entry/common.c:218
 do_syscall_64+0xd6/0x1c0 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

value changed: 0x7ad5cf52 -> 0x00000000

Reported by Kernel Concurrency Sanitizer on:
CPU: 0 UID: 0 PID: 22780 Comm: syz.3.5885 Not tainted 6.11.0-rc1-syzkaller-00043-g94ede2a3e913 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/27/2024
==================================================================


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

