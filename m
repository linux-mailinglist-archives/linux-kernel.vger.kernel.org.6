Return-Path: <linux-kernel+bounces-289427-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2D9895461C
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 11:48:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4DD97B23318
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 09:48:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA62B1714BB;
	Fri, 16 Aug 2024 09:48:22 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F158216C6A7
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 09:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723801702; cv=none; b=IiSp40YNaSnXBaM922KSx26Z8QXFz8OZwYgGOtHmieIUk8V4aWau+JGO7GDEKViSGgpKbAYYwoVcYXnyYtj29G6nyJzAKVrlV9Kaq1Phavas3ETlDOP6XCZjIAao+AvvHvud4UsOJCqqRuoJ+7lKsjv2X1K9+KVsIp4X6lXD0Gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723801702; c=relaxed/simple;
	bh=fHd2H6G8r0OkMiDyBcNxaNMNzQBskTZKqe6GWug0Ek4=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=hNnNFzy7m44IOZ3eW7SBXvShGvVChzvvGe0fAzfcKa6gbqEw8V6cPf5igZmRCQq7S/m3XXDuUz1IYxDFpyH2xQFvNE+l2cKQZm4oxI2I0oNN2wu9ExR/ky2ZEANRVr9IybxFrtBY3VOVtofUJX4AHD6Lt/0CPESo0p+q4JeVOKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-81f7fb0103fso260857439f.0
        for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 02:48:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723801700; x=1724406500;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6H0K+T8JmGoiCujE8WWSsp4Gdtnp7htEs+6zPlS+74k=;
        b=c05IXfTc3dk2ZLZi5AptuemgrAoY4wgdcvIypryDD9xMDUYSqaGxebgL9WXHd7E5+u
         DY3CyDB0MceJ6zqQGLg5grx8p1O499F2bV8ddKVMwlx4nInUOEzcRmHqREw3NcP1T5Jg
         vlMaQjsCen31SG2VFXWtE2zzKDsy2TwIkHk6VI2x2jfrEIIr5hCN3w4M/Ro49EDutX2v
         7ua5b0vX0d5tTOizge6IyUyGW/w2//BHbM/SEGODMzzqG/DzrOl9UxjUtG6D/iBP4TBA
         NROF1E+M8oxS0IVEtw03K/KMcORTR3X1lTjQmKPzKisDwWbjry+sbGClIA2g5+KR92pr
         TTSw==
X-Forwarded-Encrypted: i=1; AJvYcCWEdW6TpJL3kqGsqjFMq2NDpqo1gHyFS+mmjQUboD2WQ4ozoWSdYHbkwW4P128wJjzD8d7Qbrsd81sWSASweZZ45dZhmgMJCNTo60T2
X-Gm-Message-State: AOJu0Yz1kRT3WiLu21SfpM8udtPA1RDUpej2197MiHuv+HZ7TZpjc35y
	tC9Loh0yas6oVoJK+hKY1MrjhY2gHgErsX9zNGDwirA/pZ+K+MMHtsf5xdDxIwYRWW/au+pTt6f
	Hpt2NgkWvvFEZZLu8YLUNH3Ed/rL5KbOUwpkJpztyBHmcyP4dyCglZfY=
X-Google-Smtp-Source: AGHT+IHAuUZdL/oCUSW45SYTGXofedcY2Fs6PIcJXnVaJr7IF9ecdc2xoy7Gwrx2fZmpnui5PIvo023Q2IapmAVRqDG8isyTvO1D
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:2711:b0:4cc:d5e0:a114 with SMTP id
 8926c6da1cb9f-4cce1389aeemr75817173.2.1723801700142; Fri, 16 Aug 2024
 02:48:20 -0700 (PDT)
Date: Fri, 16 Aug 2024 02:48:20 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000002325061fc9dc44@google.com>
Subject: [syzbot] Monthly hfs report (Aug 2024)
From: syzbot <syzbot+listef5adb95de3cde4707ca@syzkaller.appspotmail.com>
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello hfs maintainers/developers,

This is a 31-day syzbot report for the hfs subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/hfs

During the period, 0 new issues were detected and 0 were fixed.
In total, 43 issues are still open and 20 have been fixed so far.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  31655   Yes   possible deadlock in hfsplus_file_extend
                   https://syzkaller.appspot.com/bug?extid=325b61d3c9a17729454b
<2>  12078   Yes   kernel BUG in hfs_write_inode
                   https://syzkaller.appspot.com/bug?extid=97e301b4b82ae803d21b
<3>  10932   Yes   possible deadlock in hfsplus_get_block
                   https://syzkaller.appspot.com/bug?extid=b7ef7c0c8d8098686ae2
<4>  7266    Yes   kernel BUG in __hfsplus_setxattr
                   https://syzkaller.appspot.com/bug?extid=1107451c16b9eb9d29e6
<5>  3004    Yes   KMSAN: kernel-infoleak in filemap_read
                   https://syzkaller.appspot.com/bug?extid=905d785c4923bea2c1db
<6>  2922    Yes   WARNING in drop_nlink (2)
                   https://syzkaller.appspot.com/bug?extid=651ca866e5e2b4b5095b
<7>  1551    Yes   KMSAN: uninit-value in hfs_find_set_zero_bits
                   https://syzkaller.appspot.com/bug?extid=773fa9d79b29bd8b6831
<8>  1470    Yes   WARNING in hfs_bnode_create
                   https://syzkaller.appspot.com/bug?extid=a19ca73b21fe8bc69101
<9>  1370    Yes   KASAN: slab-out-of-bounds Read in hfsplus_uni2asc
                   https://syzkaller.appspot.com/bug?extid=076d963e115823c4b9be
<10> 1217    Yes   KMSAN: uninit-value in hfsplus_delete_cat
                   https://syzkaller.appspot.com/bug?extid=fdedff847a0e5e84c39f

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

