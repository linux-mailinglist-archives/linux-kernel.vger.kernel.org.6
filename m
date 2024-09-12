Return-Path: <linux-kernel+bounces-326159-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C4F1976411
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 10:11:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DFAD02868A0
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 08:11:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D3B719047C;
	Thu, 12 Sep 2024 08:11:24 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BCDA18FDC9
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 08:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726128683; cv=none; b=mbPLOGvPIVV+h2hdm4Vo038uIxAYPt4IViPjK3dbNL5Vsu9Rb9JEfh6otCBdvmk0Kq18IzFa9IfARx4LBlp6N3M7ezWdYnN/iKUAojESjAAN4X7e9PCC6x6LvJmKgSlA4yNxJGtA2veWPR+BsWtGQPHfger9rJMvZIR2IF1VfIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726128683; c=relaxed/simple;
	bh=+FjPOjsC90nGSQ6SyM2El4O7afIWk4e2DSPjQIXmi6c=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=pY0TItQhokLBUvFogTJLsQZhzTErXd6xAWucw4Ksi+y45rXzUUteTGd7vrmCjkz98Rtlh1Br03ry/MnJDUhujslnHpH78rKwMi+Rndp22zjSpGY4qMJn4nwCeP8Ek6x1L33TktfXiwY3WX1pSexiGWkyXd7cTaMPGiwsQO9m2sA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-82b930cd6b2so122027239f.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 01:11:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726128681; x=1726733481;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=p6URRhafhkSYWjZNhALlJLM/SfWa/5qmQZKFuhu6WB8=;
        b=i66zG+6ZLbRjbEmHoLm9l4MAbkjhW28pxLcUEYDL5Do9O5HfiT2JAIqo6ZboVivWsf
         5phfVhcvmBtKCoEPvg9m9yfWzLIpA9sAYTo0i/QgofYzgnn9HpGbiPlp/JErLCVKQQlI
         12EU7j3MkU9/66eT29Uod+18lHd40BPvVJ/xG7zl2rOo9Tdj10gCYfkiBtd8Ci7u2oCQ
         MIFKYhEFfJqFiiZUz2EilgDhaKld6ZEBTwAj6FSC3vTcOJljRgk1bo5SDg6KRKLoaR43
         I9/4d34HLEaeuHnE6AYesfnlWNuGnwtKcnId08VeVVe8yXE8ZHaxDeT70YT0jgfhoyzA
         n3kA==
X-Forwarded-Encrypted: i=1; AJvYcCUAzc1peMKiAB5CYYs6IGxrV070SJaW8jDOz82K4/JwQ1groawuMkNIxy/xX/NnaMnrxyQTE+G60O48lbs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwStz4dLjFVKr3yqcY3koHEYpHwC91fM8tbXN2ru4wc1ZXICw4g
	oAt2S+3SUiTH5VeFjKfg3XMPQZgeeZQC/LOGP9n+cTJLS4hkaKByVNSpWL5XdrhziZqaSZNYxb0
	x7CQGJg/Zlhg5kPKk5zlU0vxKhDrhuyvdB8XLcGcNhd4xiggbVl+/4M8=
X-Google-Smtp-Source: AGHT+IH9PefFzA7QiLpOatAAZXNdwSgRcv509nYPOUBPbCuMPlwum216H1nu9GMdnHtOhvrwl6/I2VauZokki3C6SgdxpXrxhNu7
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:148c:b0:39d:1694:d261 with SMTP id
 e9e14a558f8ab-3a084907d29mr19004285ab.12.1726128681656; Thu, 12 Sep 2024
 01:11:21 -0700 (PDT)
Date: Thu, 12 Sep 2024 01:11:21 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e831e90621e7a6b5@google.com>
Subject: [syzbot] Monthly ntfs3 report (Sep 2024)
From: syzbot <syzbot+list6ec5971c0fd039e92cbd@syzkaller.appspotmail.com>
To: almaz.alexandrovich@paragon-software.com, linux-kernel@vger.kernel.org, 
	ntfs3@lists.linux.dev, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello ntfs3 maintainers/developers,

This is a 31-day syzbot report for the ntfs3 subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/ntfs3

During the period, 12 new issues were detected and 0 were fixed.
In total, 38 issues are still open and 50 have been fixed so far.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  12022   Yes   VFS: Busy inodes after unmount (use-after-free)
                   https://syzkaller.appspot.com/bug?extid=0af00f6a2cba2058b5db
<2>  8882    Yes   possible deadlock in mi_read
                   https://syzkaller.appspot.com/bug?extid=bc7ca0ae4591cb2550f9
<3>  6470    Yes   kernel BUG in dnotify_free_mark
                   https://syzkaller.appspot.com/bug?extid=06cc05ddc896f12b7ec5
<4>  3596    Yes   KASAN: out-of-bounds Write in end_buffer_read_sync
                   https://syzkaller.appspot.com/bug?extid=3f7f291a3d327486073c
<5>  1828    Yes   possible deadlock in ntfs_fiemap
                   https://syzkaller.appspot.com/bug?extid=96cee7d33ca3f87eee86
<6>  864     Yes   possible deadlock in ntfs_file_mmap
                   https://syzkaller.appspot.com/bug?extid=c1751b6739d83d70bb75
<7>  491     Yes   possible deadlock in attr_data_get_block (2)
                   https://syzkaller.appspot.com/bug?extid=262a71e9d2faf8747085
<8>  179     Yes   possible deadlock in ntfs_fallocate
                   https://syzkaller.appspot.com/bug?extid=adacb2b0c896bc427962
<9>  83      Yes   possible deadlock in ntfs_mark_rec_free (2)
                   https://syzkaller.appspot.com/bug?extid=016b09736213e65d106e
<10> 56      Yes   KMSAN: uninit-value in ntfs_read_bh
                   https://syzkaller.appspot.com/bug?extid=7a2ba6b7b66340cff225

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

