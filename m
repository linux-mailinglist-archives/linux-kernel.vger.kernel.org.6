Return-Path: <linux-kernel+bounces-182838-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E34A8C90B9
	for <lists+linux-kernel@lfdr.de>; Sat, 18 May 2024 14:01:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22B06282BEC
	for <lists+linux-kernel@lfdr.de>; Sat, 18 May 2024 12:01:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE0972E403;
	Sat, 18 May 2024 12:01:08 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02CFA1094E
	for <linux-kernel@vger.kernel.org>; Sat, 18 May 2024 12:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716033668; cv=none; b=gJLaTE3GGnks7Sogc66lyGed7ZfyenSW5uwHuKF6pHc6Kv1KFwRnJdJt/M4Edw/sUIXaPzpGkl0tZtI/HL5Fn/W+Q6/byIdooytYmgv/PRffuQNPehlIdq7nTC4Y+cHtBvxooEdIW51x7VDaZcSKyfiE/8aXLGCpHDx7EMbsmMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716033668; c=relaxed/simple;
	bh=dKrJaV6gbOCzHKBWIUYAYzB7KpVw5etsFxymJ9jotiE=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=HKHZQS7nNMnVDYulbq8nenEhBjMm93zDi885nmUIhVyuw4A1y9g0Yds5/ArP04erlnuShwL7dVxoNV4uwgmpcbQURDzGSoHeoNcfdwA8cuteTHrSVU99G1P9QeouoYL9PfKpKDs7B7O86rjtMiu8ksKZmYgf8E3XUftq0aW0+I4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7e1e409d1f4so718987939f.0
        for <linux-kernel@vger.kernel.org>; Sat, 18 May 2024 05:01:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716033666; x=1716638466;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GJvL1e3OjAFXUtLSZjVUXp1QmY/llqJUAXj06cEtHMg=;
        b=S9/P1hR6bbiBnmqMlW+8S2Ng22iSM3ELY8mCpXMNRjUgI2coLLpeU7qm7IwdzzOVXG
         Z/jSKjVg5EBj+diIPhb8KUcgIkC5Xey7FQvgK8M86ZD2grBSmdaF2Dq/0E3sEg10d/Na
         fB9hDXZNVdolSAXmLg3FhBZNB+XYku/A7IGWVh2D1ms0Qn4TTCUZCM9VHhcJW/MAxiVW
         SGZ0m9IkU++ImuZNaZ6UBH6a7hFvjel+TcAgKcSKN+grBO+ard03pBWjHhsTjynQl4bO
         E48LrkPK0+Tk29nQgVTINTjMF8EksaK8gKYekgTwvwvUf9uiJX0SEYM6WHji6yuan4yF
         /PEA==
X-Forwarded-Encrypted: i=1; AJvYcCW28CAVVI0YSPunJOUL9j7EAt+V0kkGRhWwvtsBblYaYGptpvSzkIq3LtgyBMej0ofi+dvlJD6081jEuCMK+U0P1r978mLAawQ0wmrG
X-Gm-Message-State: AOJu0Yyw+4Tr8o2fNvxN+nnHWLFBV6dd2hh54usXnWabobNQ2GGsvUJz
	ScwhJ1VtgMAhu8LBddb3YvXWtR5dz9BXu4xpocwlAhkzRfxw4n7aNFRsNj+wMB+HmWzXvFF9GL6
	BXST6XcMvB9rSfOmLMR4erFAnsD2czkWjFX+o2X51SvL2Be4FJ7ey/3E=
X-Google-Smtp-Source: AGHT+IEX1cNuWyHriZPQgCOyoxvFsqhnY5VZxdIrz9+bzN0iLOFN2QWmI7IBLLrJjrrMzlCv5aOL8WLIcqJ56In9ayybTxiuNZ+m
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:872a:b0:488:7a00:9343 with SMTP id
 8926c6da1cb9f-489589c27b6mr1738189173.0.1716033664720; Sat, 18 May 2024
 05:01:04 -0700 (PDT)
Date: Sat, 18 May 2024 05:01:04 -0700
In-Reply-To: <20240518114105.1730-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000022f9c0618b9391e@google.com>
Subject: Re: [syzbot] [v9fs?] KASAN: slab-use-after-free Read in p9_fid_destroy
From: syzbot <syzbot+d7c7a495a5e466c031b6@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
WARNING: refcount bug in p9_req_put

------------[ cut here ]------------
refcount_t: underflow; use-after-free.
WARNING: CPU: 1 PID: 90 at lib/refcount.c:28 refcount_warn_saturate+0x14a/0x210 lib/refcount.c:28
Modules linked in:
CPU: 1 PID: 90 Comm: kworker/u32:4 Not tainted 6.9.0-syzkaller-08284-gea5f6ad9ad96-dirty #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
Workqueue: events_unbound netfs_write_collection_worker
RIP: 0010:refcount_warn_saturate+0x14a/0x210 lib/refcount.c:28
Code: ff 89 de e8 98 2d 0d fd 84 db 0f 85 66 ff ff ff e8 0b 33 0d fd c6 05 97 cc 4c 0b 01 90 48 c7 c7 00 24 8f 8b e8 f7 47 cf fc 90 <0f> 0b 90 90 e9 43 ff ff ff e8 e8 32 0d fd 0f b6 1d 72 cc 4c 0b 31
RSP: 0018:ffffc9000163f830 EFLAGS: 00010282
RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffffffff814ff319
RDX: ffff88801c180000 RSI: ffffffff814ff326 RDI: 0000000000000001
RBP: ffff8880127f4bb8 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000002 R12: ffff8880127f4bb0
R13: ffff8880127f4bb8 R14: ffff88802ad24400 R15: 00000000ffffffea
FS:  0000000000000000(0000) GS:ffff88806b100000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020001000 CR3: 000000002c226000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __refcount_sub_and_test include/linux/refcount.h:275 [inline]
 __refcount_dec_and_test include/linux/refcount.h:307 [inline]
 refcount_dec_and_test include/linux/refcount.h:325 [inline]
 p9_req_put+0x1f4/0x250 net/9p/client.c:402
 p9_client_rpc+0x591/0xc10 net/9p/client.c:759
 p9_client_clunk+0x93/0x170 net/9p/client.c:1450
 p9_fid_put include/net/9p/client.h:280 [inline]
 v9fs_free_request+0xdc/0x110 fs/9p/vfs_addr.c:138
 netfs_free_request+0x22c/0x690 fs/netfs/objects.c:133
 netfs_put_request+0x19b/0x1f0 fs/netfs/objects.c:165
 netfs_write_collection_worker+0x19d0/0x59e0 fs/netfs/write_collect.c:701
 process_one_work+0x9fb/0x1b60 kernel/workqueue.c:3231
 process_scheduled_works kernel/workqueue.c:3312 [inline]
 worker_thread+0x6c8/0xf70 kernel/workqueue.c:3393
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>


Tested on:

commit:         ea5f6ad9 Merge tag 'platform-drivers-x86-v6.10-1' of g..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=16c7da34980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f1cd4092753f97c5
dashboard link: https://syzkaller.appspot.com/bug?extid=d7c7a495a5e466c031b6
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1097adf0980000


