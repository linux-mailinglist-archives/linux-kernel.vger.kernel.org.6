Return-Path: <linux-kernel+bounces-565816-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C907CA66FB0
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 10:26:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C24B1895AE9
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 09:26:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66F59206F3A;
	Tue, 18 Mar 2025 09:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="MMoAoL35"
Received: from out162-62-58-216.mail.qq.com (out162-62-58-216.mail.qq.com [162.62.58.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24D01207640
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 09:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.58.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742289978; cv=none; b=GzD0AtzdG5h345ap1BVYtfHhMHKhaPJkbDmHk6NEizPobH/M1rWy+kojzITBQpwhU+ALYU0IfUkIamkFlIg7vlXt5Nf/9mmccii3yE5vbtNn4cHnH15f+INAvXgXpl4SHXXayRczZWrZvUYEEoEv9VSI0AK1qdQssUoJpbPhEoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742289978; c=relaxed/simple;
	bh=vNzrRBUHriuBuz5jLfMQ0CQNoYeMKQntm/HJVs/+BwI=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=J04dQVZfHbalEh0zQvE9tqGaxgywHDiyhTdBUB0hX6lvGNdlAzbNaiifdmPdLwN3cZaWC19HK6BgUr4M8zzxp49rBFupKI6tpAvwAgfoLtJG6w+IHv22hOIV11fuvEEFJSQMplZKuprrWppEWcvMTI/DsN5K/uyHRUiKmF8muQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=MMoAoL35; arc=none smtp.client-ip=162.62.58.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1742289971; bh=QiiFICBQ5lfeBsjVgJ42aJxak/5Y/X17Vm6iDDnct2o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MMoAoL35TukOrRZS+1hTY3R7yTVKv87IQJ5jtu0yZNB2XsJscRhBsBecp1yQPRR33
	 XQx1tOAIH5LqvIKXJ53lJPXaqdFZ3OV5WTntcjXr+wki/kFDJyRosjSZtD0FNHLk/D
	 cyh8f44g7l64dFTipFm1hmODFQ/cGdHt8zgaj9Eo=
Received: from pek-lxu-l1.wrs.com ([114.244.57.157])
	by newxmesmtplogicsvrszb20-0.qq.com (NewEsmtp) with SMTP
	id 68897C4C; Tue, 18 Mar 2025 17:26:08 +0800
X-QQ-mid: xmsmtpt1742289968tep9of9wx
Message-ID: <tencent_8CA5671E3C533638973237484A0874917609@qq.com>
X-QQ-XMAILINFO: NVWg0TDWOKpePpPtRn7l30jnTQv4tRgX256L6SbDAA3STnP7HpmUiHbdRzy2WD
	 5Manoy04p+oXL1eelgxZMa11KZlsbt/UV4j0gsx7AmbDMQhDuZh4m9PFhWZ/2ILVhm7l1Am9vhCf
	 8Nh7MG+hhLA8Vh+OO5blNZkXWleJPDCKnqEGcG/Dj8t/CbLIPv1QmAHFGqzpsG2dHWVYPHf11PIa
	 +mksgfrRxGKYtRnqCz5unTh+1JuL/3fLOt6+gtgmslSTqfl5D0D2ZC+CFU2FZ6CSev13rXUH+zXR
	 RjiKvZqbhzg5JsWBbNu7VrfdOZroB3DvSxDI3wtpC2EWryGyU7qh+H3pMpccVF3CbfYfO1qVUGDi
	 RSEZNzApGUc7rDsjQr5XBgsJWnRy22XusyO6V+GLO3MYXBdoo5QedW7d+5A+6ZSXbQsvqU6FBThX
	 n+T1U5SQdVSuTv1a9EClF2sNJpI4bHaMju9MZtnLdPvAYRicDGlNgxxWo6skkf9Ce9tJVQ9jn9O4
	 fgOpHrl/OVIow4wTE88EAIWPdz9BkmGYRchSMwucO7q8QG4JZpkCzBvgB7yTR7l6235UsBPOVF7t
	 X1WxroqEKFOHB3hBe2FufnO7C5EUBnmrl7QmhsVf5m+wDg9ICqqkNOUL8Rh3Glf4adoLWoFhcVJr
	 Aa9/UfKIstLhjBP/7MCbWqjkZzhHlI8VnvJzxhKgLRYLonUF6CUU/EzdYtTRgC05r0nlDMXpFne5
	 8S9esk+z1o1iiDy3mvlAy8t/NfnQ9yxluA+syhpgFC6AdOY6lmgQJIihJ/7BYo5zW0KWGJ8ET+Fi
	 9uCYVX9pygHikuPJ1hp6V0pVHzV1CX0wQHxsxcHWunAjr17imc8wmwV04KFULtpxhJGRVVO461uT
	 hwqvF1I24ZDoyfGZs+lV1Yug1jI+EGZ3scyZqVnjLfEQS0uyMCK1U=
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+76a6f18e3af82e84f264@syzkaller.appspotmail.com
Cc: dhowells@redhat.com,
	linux-afs@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	marc.dionne@auristor.com,
	syzkaller-bugs@googlegroups.com
Subject: [PATCH] afs: Fix a null-ptr-deref in afs_atcell_get_link
Date: Tue, 18 Mar 2025 17:26:09 +0800
X-OQ-MSGID: <20250318092608.3480264-2-eadavis@qq.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <67d92a74.050a0220.2ca2c6.014f.GAE@google.com>
References: <67d92a74.050a0220.2ca2c6.014f.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

syzbot report a null-ptr-deref in afs_atcell_get_link. [1]

Before accessing ws_cell, we need to confirm that it is valid.

[1]
KASAN: null-ptr-deref in range [0x00000000000002b0-0x00000000000002b7]
CPU: 2 UID: 0 PID: 5932 Comm: syz-executor998 Not tainted 6.14.0-rc6-syzkaller-00189-gb35233e7bfa0 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:afs_atcell_get_link+0x33e/0x480 fs/afs/dynroot.c:321
Code: 89 c3 89 c6 e8 53 af 3b fe 85 db 75 64 e8 4a b4 3b fe 48 8d bd b0 02 00 00 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f 85 1f 01 00 00 4c 89 f6 bf 03 00 00 00 4c 8b a5 b0
RSP: 0018:ffffc90004c3f988 EFLAGS: 00010206
RAX: dffffc0000000000 RBX: 0000000000000001 RCX: ffffffff837e3e8a
RDX: 0000000000000056 RSI: ffffffff837e3e16 RDI: 00000000000002b0
RBP: 0000000000000000 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000001 R12: 0000000000000000
R13: ffff8881082b6000 R14: 0000000000000003 R15: ffff8880345a1480
FS:  000055559399f380(0000) GS:ffff88806a800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00005555939b0738 CR3: 000000002712e000 CR4: 0000000000352ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 pick_link fs/namei.c:1914 [inline]
 step_into+0x1982/0x2220 fs/namei.c:1984
 open_last_lookups fs/namei.c:3777 [inline]
 path_openat+0x74c/0x2d80 fs/namei.c:3986
 do_filp_open+0x20c/0x470 fs/namei.c:4016
 do_sys_openat2+0x17a/0x1e0 fs/open.c:1428
 do_sys_open fs/open.c:1443 [inline]
 __do_sys_openat fs/open.c:1459 [inline]
 __se_sys_openat fs/open.c:1454 [inline]
 __x64_sys_openat+0x175/0x210 fs/open.c:1454
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83

Fixes: 823869e1e616 ("afs: Fix afs_atcell_get_link() to handle RCU pathwalk")
Reported-by: syzbot+76a6f18e3af82e84f264@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=76a6f18e3af82e84f264
Signed-off-by: Edward Adam Davis <eadavis@qq.com>
---
 fs/afs/dynroot.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/afs/dynroot.c b/fs/afs/dynroot.c
index 008698d706ca..7d997f7a8028 100644
--- a/fs/afs/dynroot.c
+++ b/fs/afs/dynroot.c
@@ -314,6 +314,9 @@ static const char *afs_atcell_get_link(struct dentry *dentry, struct inode *inod
 	const char *name;
 	bool dotted = vnode->fid.vnode == 3;
 
+	if (!rcu_access_pointer(net->ws_cell))
+		return ERR_PTR(-ENOENT);
+
 	if (!dentry) {
 		/* We're in RCU-pathwalk. */
 		cell = rcu_dereference(net->ws_cell);
@@ -325,9 +328,6 @@ static const char *afs_atcell_get_link(struct dentry *dentry, struct inode *inod
 		return name;
 	}
 
-	if (!rcu_access_pointer(net->ws_cell))
-		return ERR_PTR(-ENOENT);
-
 	down_read(&net->cells_lock);
 
 	cell = rcu_dereference_protected(net->ws_cell, lockdep_is_held(&net->cells_lock));
-- 
2.43.0


