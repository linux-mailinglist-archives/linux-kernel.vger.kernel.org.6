Return-Path: <linux-kernel+bounces-243427-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BB48929610
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jul 2024 02:21:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E568B1F219F8
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jul 2024 00:21:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05D5F17F8;
	Sun,  7 Jul 2024 00:21:07 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B90CA55
	for <linux-kernel@vger.kernel.org>; Sun,  7 Jul 2024 00:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720311666; cv=none; b=MnTUKhO/joMfvNI1/CYVdag/EiRoclXu95uS6LPM4pCbnhPSN/vZQyuSNYZlzNXJGxK/L7SERa2dYR+5L7DMh/xGXr4GjsUgSV5Z1h+kQ2zcuJtu6jrufC+cNGAgKSfGvEtV2Zi4pviIcZ7KHfBPApzHORmj1Kdn4zoxZ04HYhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720311666; c=relaxed/simple;
	bh=rD8K9HjUfQ01sXIhAkd7xbjXW2g7o+CU8pJOsLHhX44=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=N5HiUyf0e4ummLzQ1uf+0uGpn184Kxt81Q6LK3eu+FT5fn7A3AZgylQSyEqxkCq9D43Z+LNW1Ss10PJcEQwqkIjMWCc3te2nZDTRmUUlBGaQZxw9afTWBQKZ9IPB559pcyzfV+1siMkTv0JUj+bw37DG2Eb83Lw+5h5ysPkSHB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7ec0802fd0dso344066439f.0
        for <linux-kernel@vger.kernel.org>; Sat, 06 Jul 2024 17:21:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720311664; x=1720916464;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0RAnPOsIq/QJy+u/k3LH2tH1DUHYGcXiXo7dKKlvWq8=;
        b=RE9DTO1ukIhaGxR7F/X7iaPY+dmyWEpzMr9PPQvNdIAdo556AL3Zb4UhrEy9IFGaMd
         mRl4T4DcfWsU5rlwrYTaYt2/oCh68f8SU6UD2Ul0/JZrLbeLq3lYs8PSncQsXQTUEdAa
         kIzkK3lAnEGEAR6sRBxBx1NrMQevzfn4e4RVRTWf3h9NcVGbQLDgNfq6SVrCYrpems3F
         eTdB6LcUqchsMoGkCoqj26+iEy/QjhhjumtewUNzkX3wPw3lf97y6daMCysRaIbkNLZt
         QGxL8jUqMNnbvjSdoSlLzMlKGn4Ib0SA6efL6pLM9yBpEYw4BMYB4UwsRWWzlPo0fCrn
         rU4Q==
X-Forwarded-Encrypted: i=1; AJvYcCXm3YilVCFKIKkqk27idlelKddlqF+hk6Kw1x5Exm0qhQJRjEf2BsIGGAA82pRs3paQ+VvSnPVP9Q9gsB9NYvPDmswhGufWx9ysVld5
X-Gm-Message-State: AOJu0YywwZ0dDwgg3Ff4OI66CaOMA3OowbEFw9+0d5aSaNuBExLnPssq
	oq05QHbTKMHjG+GQMKvuelIZcwRwk6g5ScFlOWunX/ZQY4+oFoFeirT4VRPfiY6YG64w6n1DgOD
	nHX2+sao0BLya2cw+4GVr6SosWovkfgUXzp3a9xWtCI1ux8LOQ4FOBSo=
X-Google-Smtp-Source: AGHT+IHwZLmghQb6i9rodsRh23Lrkjxzsltm9rMjTb23083qS4ZdZXhF1kt6p99sCdNgF+6cU2PWgmMBDnSVgzJAROLj1Y+X2UII
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:35ac:b0:4c0:7f51:c3aa with SMTP id
 8926c6da1cb9f-4c07f51d9b6mr399707173.2.1720311664085; Sat, 06 Jul 2024
 17:21:04 -0700 (PDT)
Date: Sat, 06 Jul 2024 17:21:04 -0700
In-Reply-To: <20240706231332.3261-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a42289061c9d452e@google.com>
Subject: Re: [syzbot] [netfilter?] KASAN: slab-use-after-free Read in nf_tables_trans_destroy_work
From: syzbot <syzbot+4fd66a69358fc15ae2ad@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
WARNING in nft_rcv_nl_event

------------[ cut here ]------------
WARNING: CPU: 0 PID: 6134 at net/netfilter/nf_tables_api.c:11557 nft_rcv_nl_event+0x1e2/0x730 net/netfilter/nf_tables_api.c:11557
Modules linked in:
CPU: 0 PID: 6134 Comm: syz.2.44 Not tainted 6.10.0-rc5-syzkaller-01137-g1c5fc27bc48a-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/07/2024
RIP: 0010:nft_rcv_nl_event+0x1e2/0x730 net/netfilter/nf_tables_api.c:11557
Code: 6c 24 40 4c 89 7c 24 60 48 8b 44 24 78 42 80 3c 20 00 74 08 4c 89 ff e8 9c dc 46 f8 49 8b 07 4c 39 f8 74 0b e8 6f 0e e1 f7 90 <0f> 0b 90 eb 1c 48 8b 05 a2 34 b2 05 48 c7 c1 40 4d 67 8f 48 39 c8
RSP: 0018:ffffc90003eb79e0 EFLAGS: 00010293
RAX: ffffffff89b51c9f RBX: ffff88807abfac00 RCX: ffff888029719e00
RDX: 0000000000000000 RSI: ffffffff8bcabb40 RDI: ffffffff8c1fee00
RBP: ffffc90003eb7b28 R08: ffffffff92fbc657 R09: 1ffffffff25f78ca
R10: dffffc0000000000 R11: fffffbfff25f78cb R12: dffffc0000000000
R13: ffff888023bbd700 R14: ffff88807abfac00 R15: ffff88807abfac10
FS:  00005555803a6500(0000) GS:ffff8880b9400000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020000200 CR3: 000000007a250000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 notifier_call_chain+0x19f/0x3e0 kernel/notifier.c:93
 blocking_notifier_call_chain+0x69/0x90 kernel/notifier.c:388
 netlink_release+0x11a6/0x1b10 net/netlink/af_netlink.c:787
 __sock_release net/socket.c:659 [inline]
 sock_close+0xbc/0x240 net/socket.c:1421
 __fput+0x406/0x8b0 fs/file_table.c:422
 task_work_run+0x24f/0x310 kernel/task_work.c:180
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:114 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0x168/0x370 kernel/entry/common.c:218
 do_syscall_64+0x100/0x230 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f48f9d75b99
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffecf0981a8 EFLAGS: 00000246 ORIG_RAX: 00000000000001b4
RAX: 0000000000000000 RBX: 000000000001d197 RCX: 00007f48f9d75b99
RDX: 0000000000000000 RSI: 000000000000001e RDI: 0000000000000003
RBP: ffffffffffffffff R08: 0000000000000001 R09: 00000004cf0984bf
R10: 00007f48f9c00000 R11: 0000000000000246 R12: 00007f48f9f03fac
R13: 0000000000000032 R14: 00007f48f9f05aa0 R15: 00007f48f9f03fa0
 </TASK>


Tested on:

commit:         1c5fc27b Merge tag 'nf-next-24-06-28' of git://git.ker..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git
console output: https://syzkaller.appspot.com/x/log.txt?x=16077369980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5264b58fdff6e881
dashboard link: https://syzkaller.appspot.com/bug?extid=4fd66a69358fc15ae2ad
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=112dca6e980000


