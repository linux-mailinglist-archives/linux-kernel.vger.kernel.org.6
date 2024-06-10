Return-Path: <linux-kernel+bounces-208162-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 61A5A9021C0
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 14:41:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 16BCF1F21B93
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 12:41:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A3D180635;
	Mon, 10 Jun 2024 12:41:34 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 361A0335A7
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 12:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718023293; cv=none; b=efTHf6bei2ihWXjmaTTLLQkKVYp2gHg4X5s42PWLIupw4zL+eKZJlM0muT4m4uibhfq2BDF5YHCcDaWjOMWxaNWMh8hm94mYgGHKGkXsUZe8+BFoEaL31oCJ2+1gMhbRhXbbSN6OtwPi5Qa417d/8p0hIXp2zpX4q9heyR5g8U8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718023293; c=relaxed/simple;
	bh=JKbuw7H95NRbTlC5bfeeeL2RtSCFi1rLLto23fHGowA=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=OnkG+RUQHrKu0QRPlKu4zOjKTq/caP9Zl/+Ke8J+6KwR8YEZqTUtRrc9Wo41rnh/N2BHb3k//4hVEJ+3wVrT/+ElzOIzekQHMDSxDxbr/GH21WYbZSZbFZ+aU88/Ae7rCeKl1AS1JLO/7mGXb1prUzaNAv0gG3xOYYsiSS+weQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7eb80de5e7dso126311239f.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 05:41:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718023291; x=1718628091;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WA7CbT2GeS+VoIChUYRDpZPjnEpS9X9+0FDiSdP3wow=;
        b=SuAFSggpaVp7b3AC/0zc3JdF1tGEWGvn+sh43k+JEAfh7QYwfBSYK6Cq7ZhqP0SjSW
         Yafiz1DmvDmmT7cNKewQJCUDetN4FTDvEPoYZilsyuDA8V5C8Cq7M6SlVLm0dtgbB0yy
         Ch1ahOfbJ+BtNCDq35G1VO9y7TWL3Iq0Vjwf5X2rYtNIcJw3sSObh74/dKeIF+9qI9WB
         qc8i7T6RoO6vGD44Q/qsK7TLecjNLvP0gmHPbrqM80gVUPSVDPi0QhHMRkQHp/Jk0yGB
         C+rAY5rTBVHJiZ2HWyOjSnpNYzsc25Pr0qxxyGijjY4ocufdvJLitKB53cnXKvDEJ8dh
         IwDg==
X-Forwarded-Encrypted: i=1; AJvYcCWfQaBlvgLpHV2io/hoSfE+seuAJW8gy8UnMnLUKKfBqVmnmujkXHlpxBFvddnkR9tMrxSU8+cFdrtWW+8kzqa/utPGW3W/TtxAdpCi
X-Gm-Message-State: AOJu0YzCaoPFgDmt6IczKViaGlAZDxvHnqKbSU/f0dEXdmbFC39UWYed
	6rXPmn1JPmFOLzGPK/9USrBnwS/3G0s1KlVE+36/35wwd/E+Y++L7VqBeQnr1EMHSUJduVBoH1I
	5xo48ikcn6xIU+Sqh3PD140eZWHtK4Z5Kq3ddnTi96bccyG7e6Uemkfk=
X-Google-Smtp-Source: AGHT+IE/szJDvjRFoP+iOxRSIYxsZAy/fRvJRJ8zV9zkfPmRib5LLKkFoNrFfgfYcCabm5kWrMhbFsf+KU/cuk5dz5IfSAvsSMV4
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:8527:b0:4b9:fb0:fd43 with SMTP id
 8926c6da1cb9f-4b90fb1070emr219303173.3.1718023291348; Mon, 10 Jun 2024
 05:41:31 -0700 (PDT)
Date: Mon, 10 Jun 2024 05:41:31 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ff3857061a8877b7@google.com>
Subject: [syzbot] Monthly dri report (Jun 2024)
From: syzbot <syzbot+list9e784dfd03fd1005cfe1@syzkaller.appspotmail.com>
To: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello dri maintainers/developers,

This is a 31-day syzbot report for the dri subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/dri

During the period, 2 new issues were detected and 0 were fixed.
In total, 18 issues are still open and 31 have been fixed so far.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 462     Yes   WARNING in drm_syncobj_array_find
                  https://syzkaller.appspot.com/bug?extid=95416f957d84e858b377
<2> 335     Yes   inconsistent lock state in sync_timeline_debug_remove
                  https://syzkaller.appspot.com/bug?extid=7dcd254b8987a29f6450
<3> 277     Yes   inconsistent lock state in sync_info_debugfs_show
                  https://syzkaller.appspot.com/bug?extid=007bfe0f3330f6e1e7d1
<4> 265     Yes   WARNING in vkms_get_vblank_timestamp (2)
                  https://syzkaller.appspot.com/bug?extid=93bd128a383695391534
<5> 17      Yes   WARNING in drm_gem_prime_fd_to_handle
                  https://syzkaller.appspot.com/bug?extid=268d319a7bfd92f4ae01
<6> 10      Yes   divide error in drm_mode_vrefresh
                  https://syzkaller.appspot.com/bug?extid=622bba18029bcde672e1
<7> 9       Yes   general protection fault in udmabuf_create (2)
                  https://syzkaller.appspot.com/bug?extid=40c7dad27267f61839d4
<8> 6       No    WARNING in drm_atomic_helper_wait_for_vblanks (3)
                  https://syzkaller.appspot.com/bug?extid=0ac28002caff799b9e57
<9> 3       Yes   divide error in drm_mode_convert_to_umode
                  https://syzkaller.appspot.com/bug?extid=0d7a3627fb6a42cf0863

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

