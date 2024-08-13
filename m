Return-Path: <linux-kernel+bounces-284392-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AA20950077
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 10:54:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6EF2C1C22973
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 08:54:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3C8313C691;
	Tue, 13 Aug 2024 08:54:23 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E71C313B797
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 08:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723539263; cv=none; b=MS2DU33soKNKFgi+rQ2KSdqkblXd+ohJFY5W0ENg/Hs0Ro4xYRYqC/DIJlo73wRtn3j/xpSqyJp0ODFkKwuM8ZCPZi5prUabBU6y6UT4vGUB80+jSCA98gyT8j1rPynWyKR+EuEMJ5lsRFHMzdBIfd4hQVBL1AYVcZQOgKeipPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723539263; c=relaxed/simple;
	bh=b6ctvZpMJddksZPB7WMp2yIhszoe9iN61VPbkmf/8k0=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=QeOZ7zlpIAYiEf4bSjUNpQkqQA6zHz0MqvjV3Hlt32ODiHpnt2dE7rcbexd0vmH00Y4JmPpCDL6S81t8JIl1oTs8OhBl/qO9M1wQywwdOob8r4+HV/aX9bATKRmzee7xzkefh2qmwpS3kNqF+UESpBzOwrTCgwq+HOeu8fsT1hE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-39b3d98c318so64673915ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 01:54:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723539261; x=1724144061;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dAxbN1m+qrrYaydpluRURuMPUeyFoEAPwBIfFSMAoGE=;
        b=nGg6oGzqrypkBRARh2TTmlj54Db+qW4avbiGCG71mYUuheAClPTVN7npMZoKuHpgvg
         3oRmYQkwVtTQscABiVopRNsH3kvj2z+g94ZDF8am/Jjcg0ekm4EH9z7ijiVtbK7ZAm6f
         KI+FUa1zCQZOeM1sgwRwlY0KcpWZv2CWjg5BsVHNYyJJywq6dp2KDSh5orziXtnHHrMG
         2NV+mkhOizOBjRdfzAGsTZ8/EmARmNwc199GxUp3L1IzVN17v8wq4uivIlPMewASnz7m
         gXjytBqi0w12JYKPx1rVYiUbVx6WJ4bqpjYSgnvL49Y4GGwz7cAxEYZHy2zsj5O3Qey3
         H+Jg==
X-Forwarded-Encrypted: i=1; AJvYcCXc4Kjlf1tZNzZfY66MfQORfVUFcGFqvo3paKfmK/0aeCnPqesK7HHqBdizkw4iFT++7EW/MCw7Bvjmme0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFf7DQ8m0Nxl4i0paBGNC1CcsqO7FXpnwUzQmYt/RZ9MIOe0vi
	I3MaM8+Q4I0ZS37zkLEkJfcAt33oQLDi2SemdHXovRt34HIrTJFCYEDUf+J68T3YO0WE/+nHCjY
	Jn7UQ+HSDB7L1LWn182S93zIiuzNS/onS2FP4PS1kG2AnrOQ0f0QTpy0=
X-Google-Smtp-Source: AGHT+IHRB+W04vQzvsPWqVVv7EV3OItsE/6eBloETDq10TMR1K6kXF70ZrOlxaLZnz+A88+3erQUXk5vNjQA0Zz3xVpCRv2qVj4m
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:12e2:b0:380:9233:96e6 with SMTP id
 e9e14a558f8ab-39c47932654mr2220175ab.4.1723539261076; Tue, 13 Aug 2024
 01:54:21 -0700 (PDT)
Date: Tue, 13 Aug 2024 01:54:21 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000069c3d0061f8cc1ec@google.com>
Subject: [syzbot] Monthly dri report (Aug 2024)
From: syzbot <syzbot+list6275d5acf154b011ca52@syzkaller.appspotmail.com>
To: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello dri maintainers/developers,

This is a 31-day syzbot report for the dri subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/dri

During the period, 1 new issues were detected and 0 were fixed.
In total, 21 issues are still open and 31 have been fixed so far.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 480     Yes   WARNING in drm_syncobj_array_find
                  https://syzkaller.appspot.com/bug?extid=95416f957d84e858b377
<2> 288     Yes   WARNING in vkms_get_vblank_timestamp (2)
                  https://syzkaller.appspot.com/bug?extid=93bd128a383695391534
<3> 64      Yes   WARNING in drm_mode_create_lease_ioctl
                  https://syzkaller.appspot.com/bug?extid=6754751ad05524dae739
<4> 17      Yes   WARNING in drm_gem_prime_fd_to_handle
                  https://syzkaller.appspot.com/bug?extid=268d319a7bfd92f4ae01
<5> 4       Yes   divide error in drm_mode_debug_printmodeline
                  https://syzkaller.appspot.com/bug?extid=2e93e6fb36e6fdc56574
<6> 3       Yes   WARNING in drm_prime_fd_to_handle_ioctl
                  https://syzkaller.appspot.com/bug?extid=0da81ccba2345eeb7f48
<7> 3       No    WARNING in drm_wait_one_vblank (2)
                  https://syzkaller.appspot.com/bug?extid=147ba789658184f0ce04
<8> 2       Yes   WARNING in drm_prime_destroy_file_private (2)
                  https://syzkaller.appspot.com/bug?extid=59dcc2e7283a6f5f5ba1

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

