Return-Path: <linux-kernel+bounces-572713-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E89CA6CDAC
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Mar 2025 03:26:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D53FC189EB82
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Mar 2025 02:26:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 640871FF60E;
	Sun, 23 Mar 2025 02:26:28 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D7FC54654
	for <linux-kernel@vger.kernel.org>; Sun, 23 Mar 2025 02:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742696788; cv=none; b=ZWqG/j7ISUL0QZB2ZrOdtNVeYNZ6BHpCIp6VDqivvps5Cfw+Fnff/cgyeUUq8M0P4sr/LVWZptHcleGdyLLDk0P2y1b9FojGxVbYspqHrbl2UjaNWhdrMEnPRFCze1UBoWc5tR/H7BhAXJS/8IDSKyFSZWGQeenebenFhU9/Hto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742696788; c=relaxed/simple;
	bh=1znEn54SpjVwESBzz8ZgrauIMPp71KeAbulYDcHkTwo=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=rTa2MZYQ7zrqd1TFHwu55SM7N+QtZaNyn5eZ10Gw/rFaV9l78n6yAri/SS1gdOMvIwZBQSMZQ30tgmORNZVjbuvfblCPQZUnTFFGw/3EiJhYzjgVxXiC6RIXo6DyXjUcYis69me2GO/09tkzLqDrsuamEaOfO9w6C+WeNhEfvuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-85c552b10b9so278148039f.1
        for <linux-kernel@vger.kernel.org>; Sat, 22 Mar 2025 19:26:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742696786; x=1743301586;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bt6nNOeG/ihuc2+/rQ9fKTtM0YTkTdK7aiV+J8tx6as=;
        b=u2ETsUrj2pUNV4VmoOKkBJGNa/8Fthiil/3pVqfFmCm9hsrAlwtnxuXXNR6lfFlyMr
         gXtuP1qbYoXxgMjuXFfngbn4Fwyv/Qug0qWnTOEXu6DbBTu7Ie9FHd/xpXh3b92WhBoe
         J3NdCjglP/I5ouHWhk7t9EPbgHzDKh5n4RDpSaKi2EiMGSgGJ9GwWRI0MW8jLi/22DND
         zO7me/vTzQUZ4RZkBNHUJbw5MZ11ISckeSW2XcdSbUUMYodHNR1b/7PfZOy/iH/6p/cD
         yDto8Up8k5+Eb3lLhDfWhuEQ9i0o9iM08ajtQUz5fbt4D4s/11AVbppucPFSO76CMgud
         w0yQ==
X-Forwarded-Encrypted: i=1; AJvYcCXmkz+AVn5cTqZqNNUemjqqyuOnYcqJK+l1jbV6oudNTVgkih4FBXqGJ12+MA97cCQrY+T7foXgLUlKABU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz71vAeo6NuwNMu3qUMF+uE+JNjyUczsv5SyFObgQCA4zozUfj9
	9xoWWc/Vy0X55IyEcn75EkIhGCiunvvAzlG2s7U35hxoja25n7bbI+cgxAa5adoBXEgzCahonZf
	IFIeRiBdMVywiKbBtN1kSuUPF+4g/LC14NpVQPbjjU1xdbxN3K7KkqHY=
X-Google-Smtp-Source: AGHT+IHLGFurgr25sE8UaUFJ9+Y8JkqUrXkC7xhkSz+96KU8P9xA0yLmpu1LhNzFHns7OFE7vObW/Uc9mhd2pchqZ0+ba7kHpIYX
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2783:b0:3d4:700f:67e2 with SMTP id
 e9e14a558f8ab-3d5960f2e60mr70426115ab.10.1742696785806; Sat, 22 Mar 2025
 19:26:25 -0700 (PDT)
Date: Sat, 22 Mar 2025 19:26:25 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67df7151.050a0220.31a16b.0051.GAE@google.com>
Subject: [syzbot] Monthly hfs report (Mar 2025)
From: syzbot <syzbot+list4a51901a62e101b7080a@syzkaller.appspotmail.com>
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello hfs maintainers/developers,

This is a 31-day syzbot report for the hfs subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/hfs

During the period, 1 new issues were detected and 0 were fixed.
In total, 42 issues are still open and 22 have already been fixed.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  66111   Yes   kernel BUG in hfs_write_inode
                   https://syzkaller.appspot.com/bug?extid=97e301b4b82ae803d21b
<2>  14870   Yes   kernel BUG in __hfsplus_setxattr
                   https://syzkaller.appspot.com/bug?extid=1107451c16b9eb9d29e6
<3>  12324   Yes   possible deadlock in hfsplus_get_block
                   https://syzkaller.appspot.com/bug?extid=b7ef7c0c8d8098686ae2
<4>  5833    Yes   KMSAN: uninit-value in hfsplus_cat_case_cmp_key
                   https://syzkaller.appspot.com/bug?extid=50d8672fea106e5387bb
<5>  3458    Yes   KMSAN: uninit-value in hfsplus_delete_cat
                   https://syzkaller.appspot.com/bug?extid=fdedff847a0e5e84c39f
<6>  3282    Yes   KMSAN: uninit-value in hfsplus_attr_bin_cmp_key
                   https://syzkaller.appspot.com/bug?extid=c6d8e1bffb0970780d5c
<7>  3186    Yes   possible deadlock in hfs_find_init (2)
                   https://syzkaller.appspot.com/bug?extid=e390d66dda462b51fde1
<8>  3083    Yes   KMSAN: uninit-value in hfs_find_set_zero_bits
                   https://syzkaller.appspot.com/bug?extid=773fa9d79b29bd8b6831
<9>  2698    Yes   KASAN: slab-out-of-bounds Read in hfsplus_uni2asc
                   https://syzkaller.appspot.com/bug?extid=076d963e115823c4b9be
<10> 2606    Yes   KMSAN: uninit-value in hfsplus_lookup
                   https://syzkaller.appspot.com/bug?extid=91db973302e7b18c7653

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

