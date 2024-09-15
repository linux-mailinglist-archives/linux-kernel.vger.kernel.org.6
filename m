Return-Path: <linux-kernel+bounces-329899-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AA19E979740
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Sep 2024 16:39:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7443B280A9D
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Sep 2024 14:39:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 265301C7B8D;
	Sun, 15 Sep 2024 14:39:25 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ED981C68A0
	for <linux-kernel@vger.kernel.org>; Sun, 15 Sep 2024 14:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726411164; cv=none; b=alSplmdGbZ0rqIOK0fnw0u/WVFj5eV7wYLXCpqcsR9nand5o3oPi8z7xukYMat2q2xWgrcHQ5/gCXL16RtAu7VMiPzO+ee7hyF6UebMhboxXein8ZwfM1llLs/56Lxy+3aLjRUr5xIZ7ttCMbMlWCQwdd9/MdYtRur0WvTjFzVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726411164; c=relaxed/simple;
	bh=ugIgT3P62YyJVUICzflGXO4+NPncChk5Efv/8bam+Lk=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=XVW7plBl6CLdzRFLLMmNQ8jHM0moG4zmNRs4XKoddTpy6tXudF0oogcTP2bjnVhkDQlVgyflc1vq181XTHzAHSNdF9lFGdVG1PJHgk3zVj3UHly6SG96IoNzy7kL+nw1muSM20mFTJ7t5yZq1qEJciHIiq+rq09TfNPtSwlCcMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a04af50632so76477415ab.2
        for <linux-kernel@vger.kernel.org>; Sun, 15 Sep 2024 07:39:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726411162; x=1727015962;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZCeSY0Tg+irvuLC3MHarMWgiDRbCnO96UywqFeUzQRo=;
        b=soL+PC6SZLhgaqs0OX7uvxXll+NDdLfJTRnXSYw/vp52zO0Z8lf9Q9HF8PbiVXzu6t
         eSK40+rZbmLqevT9OL6V+XdQU/FiePfFkRCdt3JGDSaWhVA332X47KtafisGGP9uS0Ku
         NepOquEmzRTbBoHlgkxsc4ePAp+KynDKb2jw1rFXJ29C1Zgq8qanQNiSEFs5pHChnP5y
         PcMrwdoHuCGi/Lz3mLvWJV+1RmcSxb7TuwKeEjxowivFeFDA1cDU+xY18cm8LsFGiwXx
         uecV7UR7usWi7AgBVLMlHjS2G6FKjpeXwx0WC9XQjOjLCbiTsD6w3Tkn8Gpn2SICm0nO
         MX4w==
X-Forwarded-Encrypted: i=1; AJvYcCU2hwhvJgdmYQJpYfveVcglSgcN0ciB0Qmf9mzmiGOjrVGvZbEXODM8EGHkJlby51ZOuI9n3dPRBcGuaDE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKIHUdT7y21TgQpdrSqUPFgS0u6uqcgAV+8aaq2qY3ULz9/QBj
	VCsX0McwE401NNhWqEQiN4TiBtokbvqy5DzzwNgXIJll+5JGUexs+ohUw4deKiZ40MjIKbcvsm+
	HnUU0TX6yAZ5xnY+ZKjwtgm+KIccz3DJJNmCw9MhojKJgIphQDuVynOg=
X-Google-Smtp-Source: AGHT+IFQCy/4x1+qIcUS78qlxaHEfbLJHaTgAyEWKHIOreX4S4vfwVxeiKiC7YC0stMLhACcVCG1HXNalqL/gA77UIQLT179hvEc
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:198b:b0:39e:68f8:43e5 with SMTP id
 e9e14a558f8ab-3a0848cb45cmr123293255ab.9.1726411162418; Sun, 15 Sep 2024
 07:39:22 -0700 (PDT)
Date: Sun, 15 Sep 2024 07:39:22 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000012905e0622296c1e@google.com>
Subject: [syzbot] Monthly xfs report (Sep 2024)
From: syzbot <syzbot+list09475edf415676cc6e2c@syzkaller.appspotmail.com>
To: chandan.babu@oracle.com, linux-kernel@vger.kernel.org, 
	linux-xfs@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello xfs maintainers/developers,

This is a 31-day syzbot report for the xfs subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/xfs

During the period, 1 new issues were detected and 0 were fixed.
In total, 13 issues are still open and 23 have been fixed so far.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 602     Yes   possible deadlock in xfs_ilock_attr_map_shared
                  https://syzkaller.appspot.com/bug?extid=069cc167ecbee6e3e91a
<2> 137     Yes   possible deadlock in xfs_icwalk_ag (2)
                  https://syzkaller.appspot.com/bug?extid=4248e91deb3db78358a2
<3> 78      No    KASAN: slab-use-after-free Read in xfs_inode_item_push
                  https://syzkaller.appspot.com/bug?extid=1a28995e12fd13faa44e
<4> 74      Yes   INFO: task hung in xfs_buf_item_unpin (2)
                  https://syzkaller.appspot.com/bug?extid=837bcd54843dd6262f2f
<5> 3       No    possible deadlock in xfs_fs_dirty_inode (2)
                  https://syzkaller.appspot.com/bug?extid=1116a7b7b96b9c426a1a

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

