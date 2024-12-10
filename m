Return-Path: <linux-kernel+bounces-439477-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B1B829EAFCB
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 12:24:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA0F5165FFB
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 11:24:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A305F19D082;
	Tue, 10 Dec 2024 11:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SaA44fPL"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32F7523DE9E
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 11:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733829846; cv=none; b=kapITr19PxyYUPpvvgn+1tX/jCmi4CHPtGVFtk3dBWG5Mn4LYsjm5LGVaP1xnyGyabefG927pNp9kPE4UFQyu/VW8MOlx69SSr9xPTqE5QZ3kWXnhkxMuQnKt5OZjRitHHEw9B8k3U5QQg9EBAdyyWTgkA5eSvP8rDi+2feLQ5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733829846; c=relaxed/simple;
	bh=/IUaWZ0rGpCjDNdYKSki952oONJ0kwsGbQGF1xd+LLM=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=E3sW+cdG31GwkAJzuLtrDwHWkkh7Evc9+QbEWOOcGq1Gk//79Y2+Tx5euKZDy3DhSfZhVZJhZ6ZQssEmNA0d3URZhnhBsfKSz4PDfvm13+/eUfqG8Ca+bkw3ldZEC0eFwuF9UAVjUDrbRUwPxKdYovcfZSnoptTJxtCwM0/GgKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SaA44fPL; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-21628b3fe7dso29455595ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 03:24:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733829844; x=1734434644; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8UGoutpas92JsX8FcjC0qacdHEx/ZaXacQhRIVlDSN8=;
        b=SaA44fPL1g6+zJ+S3zTiBk4R6R10A7ooKebh5HnMN8kvYey+M/qTeae9XsQIsnLnqB
         nKJ9RDarGk8gv5HxSbfLu00GLM9/e7jeAowfJ2t2TYedjKbfuNN5WZaWY0Avl/8KntIn
         ldhw1QhXMYKooBLfJuc7x8jugobCCPMrwWtNz+qXNNNCOUxQX9ffY9JIoWYtS4X4ER8q
         sHJMj+a1cThsAEjdQW6DHEc5jxLX7reXB4bkGyd2zMvI6Nc9HucLD5S3q2o+Q+8hmexk
         iCuxoYFn9vlgiiIv20WxBdCA64n2AGEUsIgEpLv4r+UCof+L2aK3tdBapM+Y9jWHnOxt
         UlCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733829844; x=1734434644;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8UGoutpas92JsX8FcjC0qacdHEx/ZaXacQhRIVlDSN8=;
        b=M2IkDWw2+ZCNN7AnnSrqkmw0OOP8UEEkifd9VQX8X1douU15xb6DLbtksaRWfybTSr
         6uthdpuyU3l4eTn6EkHQQ+RiML8lb2wOkvCfDATLhX/w+eebuZNLPJmgW76n+nscNRi8
         zAydj9CN2SiQF9oQOcNQJwUk8N26CyWH4UgF3pjoKbjM/RDGE6RlnXVwaXZZJ4Tvgc8q
         SthwfWQLZo+U0XruFosBHKyOy0aJFsBmVfqscNbMpjWk/GHYd8yD1Zi9Tbt9ULDOX48f
         8zUDJhEaOLFE+pUf182MqZJ+jQoYq2XnXuET5GVr12P1RI7Y2J/ndYsoVOFsUhruUDho
         Jq4Q==
X-Forwarded-Encrypted: i=1; AJvYcCUh2HzEpA1lO1raQAP82fooP1GujVhd6bV8EDcezEbwc0KlOcpY+KpUFJPxHirgQckmBWoY37r01k5V3js=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw21qhT5kAlvnVZOczk/eNuZ0DGL6aVkkYTlerqw7k00rGzNlkT
	vUzlfOwy3x/3gf5I1S7AugjrbxRaKdkeTCvMBPCuHIrPX7vYonLUusoTPhaAXak=
X-Gm-Gg: ASbGncuXmdQFOtvxorHBAj9yyw8csGNoXz+RfQpTvKKustWIrKnUx/TcFCGYtkV5+SN
	HkZ8g+dUg/Of/waYvcLuWkF0aZPi/c90FsALkihg+z8iAuprN6TDjFDa7bjbWIMUra416BYomYq
	NVfaEsb9XYyNOr7sdJ68PGrYnpyY70osmsNzjPsZ2/EbCy//aW8EMmC8LYmlSax1R8jUTNiULvx
	cr3hLS5+fy3Sl4HDNIsodrNCAizftlTXWhDCCfp5hzxrVRuEXgj0nnMTt1yYw+bNZXl4absOAUB
	JF2gVlSmkzW1wTNi3A==
X-Google-Smtp-Source: AGHT+IGiz/D9najtT9t/UixnDdA6unMcIi6JYedk03ywVeQ4usrtQBzvEIe8806CC2ZVdG7YA0HiDQ==
X-Received: by 2002:a17:903:1787:b0:211:e812:3948 with SMTP id d9443c01a7336-2161393ebe6mr251699985ad.0.1733829844336;
        Tue, 10 Dec 2024 03:24:04 -0800 (PST)
Received: from [10.172.23.24] ([206.237.119.150])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21659e7b7eesm28202085ad.9.2024.12.10.03.24.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 03:24:03 -0800 (PST)
Message-ID: <a1ef0b7bd9d2491ad346fb2a55b4279c4bd2f1fe.camel@gmail.com>
Subject: Re: [syzbot] [ocfs2?] KASAN: use-after-free Read in
 ocfs2_search_extent_list
From: Julian Sun <sunjunchao2870@gmail.com>
To: syzbot <syzbot+2313dda4dc4885c93578@syzkaller.appspotmail.com>, 
 jlbec@evilplan.org, joseph.qi@linux.alibaba.com,
 linux-kernel@vger.kernel.org,  mark@fasheh.com,
 ocfs2-devel@lists.linux.dev, syzkaller-bugs@googlegroups.com
Date: Tue, 10 Dec 2024 19:23:59 +0800
In-Reply-To: <67577778.050a0220.a30f1.01bc.GAE@google.com>
References: <67577778.050a0220.a30f1.01bc.GAE@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-12-09 at 15:04 -0800, syzbot wrote:

Add a sanity check for corrupted file system images.

#syz test: upstream 5076001689e4

diff --git a/fs/ocfs2/inode.c b/fs/ocfs2/inode.c
index 2cc5c99fe941..60c84049f3e4 100644
--- a/fs/ocfs2/inode.c
+++ b/fs/ocfs2/inode.c
@@ -1358,6 +1358,21 @@ void ocfs2_refresh_inode(struct inode *inode,
 	spin_unlock(&OCFS2_I(inode)->ip_lock);
 }
=20
+static int has_extents(struct ocfs2_dinode *di)
+{
+	/* inodes flagged with other stuff in id2 */
+	if (di->i_flags & (OCFS2_SUPER_BLOCK_FL | OCFS2_LOCAL_ALLOC_FL |
+			   OCFS2_CHAIN_FL | OCFS2_DEALLOC_FL))
+		return 0;
+	/* i_flags doesn't indicate when id2 is a fast symlink */
+	if (S_ISLNK(di->i_mode) && di->i_size && di->i_clusters =3D=3D 0)
+		return 0;
+	if (di->i_dyn_features & OCFS2_INLINE_DATA_FL)
+		return 0;
+
+	return 1;
+}
+
 int ocfs2_validate_inode_block(struct super_block *sb,
 			       struct buffer_head *bh)
 {
@@ -1386,6 +1401,15 @@ int ocfs2_validate_inode_block(struct super_block *s=
b,
=20
 	rc =3D -EINVAL;
=20
+	if (has_extents(di) &&
+	    le16_to_cpu(di->id2.i_list.l_next_free_rec) > le16_to_cpu(di->id2.i_l=
ist.l_count)) {
+		rc =3D ocfs2_error(sb, "corrupted dinode #%llu: next_free_rec is %u, cou=
nt is %u\n",
+				 (unsigned long long)bh->b_blocknr,
+				 le16_to_cpu(di->id2.i_list.l_next_free_rec),
+				 le16_to_cpu(di->id2.i_list.l_count));
+		goto bail;
+	}
+
 	if (!OCFS2_IS_VALID_DINODE(di)) {
 		rc =3D ocfs2_error(sb, "Invalid dinode #%llu: signature =3D %.*s\n",
 				 (unsigned long long)bh->b_blocknr, 7,



> Hello,
>=20
> syzbot found the following issue on:
>=20
> HEAD commit:=C2=A0=C2=A0=C2=A0 5076001689e4 Merge tag 'loongarch-fixes-6.=
13-1' of git://g..
> git tree:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D120f68df98000=
0
> kernel config:=C2=A0 https://syzkaller.appspot.com/x/.config?x=3D50c7a614=
69ce77e7
> dashboard link: https://syzkaller.appspot.com/bug?extid=3D2313dda4dc4885c=
93578
> compiler:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Debian clang version 15.0.6=
, GNU ld (GNU Binutils for Debian) 2.40
> syz repro:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 https://syzkaller.appspot.com/x/=
repro.syz?x=3D13b29330580000
> C reproducer:=C2=A0=C2=A0 https://syzkaller.appspot.com/x/repro.c?x=3D17b=
29330580000
>=20
> Downloadable assets:
> disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7=
feb34a89c2a/non_bootable_disk-50760016.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/76ef343a98c8/vmlinu=
x-50760016.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/e42b3235bcc3/b=
zImage-50760016.xz
> mounted in repro: https://storage.googleapis.com/syzbot-assets/893e4e85ff=
3d/mount_0.gz
>=20
> IMPORTANT: if you fix the issue, please add the following tag to the comm=
it:
> Reported-by: syzbot+2313dda4dc4885c93578@syzkaller.appspotmail.com
>=20
> loop0: detected capacity change from 0 to 32768
> JBD2: Ignoring recovery information on journal
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> BUG: KASAN: use-after-free in ocfs2_search_extent_list+0x155/0x200 fs/ocf=
s2/alloc.c:776
> Read of size 4 at addr ffff888049800000 by task syz-executor307/5410
>=20
> CPU: 0 UID: 0 PID: 5410 Comm: syz-executor307 Not tainted 6.13.0-rc1-syzk=
aller-00036-g5076001689e4 #0
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.=
16.3-2~bpo12+1 04/01/2014
> Call Trace:
> =C2=A0<TASK>
> =C2=A0__dump_stack lib/dump_stack.c:94 [inline]
> =C2=A0dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
> =C2=A0print_address_description mm/kasan/report.c:378 [inline]
> =C2=A0print_report+0x169/0x550 mm/kasan/report.c:489
> =C2=A0kasan_report+0x143/0x180 mm/kasan/report.c:602
> =C2=A0ocfs2_search_extent_list+0x155/0x200 fs/ocfs2/alloc.c:776
> =C2=A0ocfs2_get_clusters_nocache+0x21a/0xbf0 fs/ocfs2/extent_map.c:438
> =C2=A0ocfs2_get_clusters+0x5bd/0xbd0 fs/ocfs2/extent_map.c:621
> =C2=A0ocfs2_extent_map_get_blocks+0x24c/0x7d0 fs/ocfs2/extent_map.c:668
> =C2=A0ocfs2_bmap+0x2b7/0x780 fs/ocfs2/aops.c:474
> =C2=A0bmap+0xa8/0xe0 fs/inode.c:1997
> =C2=A0jbd2_journal_bmap+0x12d/0x2b0 fs/jbd2/journal.c:926
> =C2=A0do_readahead fs/jbd2/recovery.c:88 [inline]
> =C2=A0jread+0x435/0xc80 fs/jbd2/recovery.c:165
> =C2=A0do_one_pass+0x3cd/0x3aa0 fs/jbd2/recovery.c:646
> =C2=A0jbd2_journal_skip_recovery+0x95/0x240 fs/jbd2/recovery.c:366
> =C2=A0jbd2_journal_wipe+0xc9/0x110 fs/jbd2/journal.c:2517
> =C2=A0ocfs2_journal_wipe+0xab/0x2a0 fs/ocfs2/journal.c:1192
> =C2=A0ocfs2_check_volume fs/ocfs2/super.c:2413 [inline]
> =C2=A0ocfs2_mount_volume+0xb86/0x1940 fs/ocfs2/super.c:1817
> =C2=A0ocfs2_fill_super+0x476e/0x5760 fs/ocfs2/super.c:1084
> =C2=A0mount_bdev+0x20a/0x2d0 fs/super.c:1693
> =C2=A0legacy_get_tree+0xee/0x190 fs/fs_context.c:662
> =C2=A0vfs_get_tree+0x90/0x2b0 fs/super.c:1814
> =C2=A0do_new_mount+0x2be/0xb40 fs/namespace.c:3507
> =C2=A0do_mount fs/namespace.c:3847 [inline]
> =C2=A0__do_sys_mount fs/namespace.c:4057 [inline]
> =C2=A0__se_sys_mount+0x2d6/0x3c0 fs/namespace.c:4034
> =C2=A0do_syscall_x64 arch/x86/entry/common.c:52 [inline]
> =C2=A0do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
> =C2=A0entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7fdc66ec71aa
> Code: d8 64 89 02 48 c7 c0 ff ff ff ff eb a6 e8 5e 04 00 00 66 2e 0f 1f 8=
4 00 00 00 00 00 0f 1f 40 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff=
 ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01
> 48
> RSP: 002b:00007ffee9a2de18 EFLAGS: 00000282 ORIG_RAX: 00000000000000a5
> RAX: ffffffffffffffda RBX: 00007ffee9a2de30 RCX: 00007fdc66ec71aa
> RDX: 0000000020004440 RSI: 0000000020000040 RDI: 00007ffee9a2de30
> RBP: 0000000000000004 R08: 00007ffee9a2de70 R09: 0000000000004431
> R10: 00000000000008c0 R11: 0000000000000282 R12: 00000000000008c0
> R13: 00007ffee9a2de70 R14: 0000000000000003 R15: 0000000001000000
> =C2=A0</TASK>
>=20
> The buggy address belongs to the physical page:
> page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x4980=
0
> flags: 0x4fff00000000000(node=3D1|zone=3D1|lastcpupid=3D0x7ff)
> page_type: f0(buddy)
> raw: 04fff00000000000 ffff88805ffd7230 ffff88805ffd7230 0000000000000000
> raw: 0000000000000000 000000000000000a 00000000f0000000 0000000000000000
> page dumped because: kasan: bad access detected
> page_owner info is not present (never set?)
>=20
> Memory state around the buggy address:
> =C2=A0ffff8880497fff00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> =C2=A0ffff8880497fff80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> > ffff888049800000: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ^
> =C2=A0ffff888049800080: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> =C2=A0ffff888049800100: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
>=20
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ=C2=A0for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>=20
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status=C2=A0for how to communicate with syzbot.
>=20
> If the report is already addressed, let syzbot know by replying with:
> #syz fix: exact-commit-title
>=20
> If you want syzbot to run the reproducer, reply with:
> #syz test: git://repo/address.git branch-or-commit-hash
> If you attach or paste a git patch, syzbot will apply it before testing.
>=20
> If you want to overwrite report's subsystems, reply with:
> #syz set subsystems: new-subsystem
> (See the list of subsystem names on the web dashboard)
>=20
> If the report is a duplicate of another one, reply with:
> #syz dup: exact-subject-of-another-report
>=20
> If you want to undo deduplication, reply with:
> #syz undup

--=20
Julian Sun <sunjunchao2870@gmail.com>

