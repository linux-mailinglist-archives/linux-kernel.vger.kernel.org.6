Return-Path: <linux-kernel+bounces-521507-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78AA9A3BE46
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 13:37:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50D553A42A4
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 12:35:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 594281E1A17;
	Wed, 19 Feb 2025 12:35:24 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 731981DED62
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 12:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739968524; cv=none; b=qbGE3xsrODgZ6jNuIyOqNbkuAixUmrPCh5CnAdiDrMQ2aq0tfQRUfQCHd+Zgey3zV4bQ6Tf6DICBqpSZNy0MW0lJ1fW468nKNfw6khJj20pW8lis6DBYbMWadir1GIWUST5oZxlBU0vMwXlyu44CQ6pGNc60rO/SnqXHpQiXyxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739968524; c=relaxed/simple;
	bh=j/dc1VpWzAYMng4cMhn0zh4R4rf3LGP1QYSyVP4Dl5Q=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=iJeLrAUv3v7pj5KYJusKDu8FTWTTcYWnGfG6RVoFz7ZGNTtCKd1Qj5+rvyHrDZY9B9mXJ17dwhaMVmFXZRJWFJ+tQobVPup8drO2rCc5e0qsbIUPYUY5Gi8i7O72x5ovFjZRXRffhbl/2/rirbgzek4yxCNrI+87liJlt+N6Y7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3d060cfe752so45502885ab.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 04:35:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739968521; x=1740573321;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bkwiZ0yOIfJpjcP0g90Xxcuz3evpjUpvvJsCWnN10IA=;
        b=crvHGJJuC2VAtPg0NHJQ7mBh+MXpPDKbq5Us+70sWJ5B9KkKg42cHWEZkUlG5tfXCo
         2BS+QBJv6wMwSPPpx7r3CGJyZZ+bXG2Y5xB27ffyxdXcLQYDE+mnhq/IlV+4kMOK27LZ
         En2MGBRtgF8JWvaHn9Hex3T/B4ZXAuVlUN+O2d7+0Qg/nS2EonCcTBWUkmZ9bj0k/krp
         IVLt+HSg0bupwKjVVfN7P0SILFOqD1Z+cL3tctZDjzTUtXqmWHxe7Re/Gxz36aYiyAaR
         VUgkqu5pbXPiL8PGe1krkjOXijiNOoZOW9icuhEpmv5f3DSICuU3B5dKJuiYzV2ts6O2
         GqdA==
X-Forwarded-Encrypted: i=1; AJvYcCWzAI/STltV3KzMKDhjNwrUOFu1QisIEyXloMjdDFWp0Q7TyWjvPDazBwqyYXfjEb3KuQhB2ISPMaztkFI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzC9zBYOkBBizcuIsVi305OgU1xRm2Qh8K0ufcgDKkZdRqGT4gz
	dunsP5pJ3e6sF3zLkvunLVlDX22AKXJhhI2Qiq640MNfkmK6NoMTy3IxKRH01BHyo24zpdG4ybm
	p3kunkh85clUU3/UzkWzyrNBsti1hgvESJa5NxIaqeIR5jkpY5O+huns=
X-Google-Smtp-Source: AGHT+IG69LGDutTU11/v/OdTOcXCteXA3LgdwC79Z9Ktipmm6KW2i65mTGy2RJOLEYuFyiVuvYS65W9Cvh6r+DgxZtMYRzl1aori
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2181:b0:3d1:4b97:4f2d with SMTP id
 e9e14a558f8ab-3d280763f51mr132538045ab.5.1739968521525; Wed, 19 Feb 2025
 04:35:21 -0800 (PST)
Date: Wed, 19 Feb 2025 04:35:21 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67b5d009.050a0220.14d86d.00e3.GAE@google.com>
Subject: [syzbot] Monthly hfs report (Feb 2025)
From: syzbot <syzbot+list3025ad65a9369424c0f5@syzkaller.appspotmail.com>
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello hfs maintainers/developers,

This is a 31-day syzbot report for the hfs subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/hfs

During the period, 0 new issues were detected and 0 were fixed.
In total, 43 issues are still open and 22 have already been fixed.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  58216   Yes   kernel BUG in hfs_write_inode
                   https://syzkaller.appspot.com/bug?extid=97e301b4b82ae803d21b
<2>  13879   Yes   kernel BUG in __hfsplus_setxattr
                   https://syzkaller.appspot.com/bug?extid=1107451c16b9eb9d29e6
<3>  12134   Yes   possible deadlock in hfsplus_get_block
                   https://syzkaller.appspot.com/bug?extid=b7ef7c0c8d8098686ae2
<4>  4961    Yes   KMSAN: uninit-value in hfsplus_cat_case_cmp_key
                   https://syzkaller.appspot.com/bug?extid=50d8672fea106e5387bb
<5>  3014    Yes   KMSAN: uninit-value in hfsplus_delete_cat
                   https://syzkaller.appspot.com/bug?extid=fdedff847a0e5e84c39f
<6>  2963    Yes   possible deadlock in hfs_find_init (2)
                   https://syzkaller.appspot.com/bug?extid=e390d66dda462b51fde1
<7>  2775    Yes   KMSAN: uninit-value in hfsplus_attr_bin_cmp_key
                   https://syzkaller.appspot.com/bug?extid=c6d8e1bffb0970780d5c
<8>  2732    Yes   KMSAN: uninit-value in hfs_find_set_zero_bits
                   https://syzkaller.appspot.com/bug?extid=773fa9d79b29bd8b6831
<9>  2560    Yes   KASAN: slab-out-of-bounds Read in hfsplus_uni2asc
                   https://syzkaller.appspot.com/bug?extid=076d963e115823c4b9be
<10> 2430    Yes   KMSAN: uninit-value in hfsplus_lookup
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

