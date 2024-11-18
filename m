Return-Path: <linux-kernel+bounces-412886-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 37E5E9D10AD
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 13:39:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B9461B23B1D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 12:39:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 734FC1993BD;
	Mon, 18 Nov 2024 12:39:25 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1DFD13A86A
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 12:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731933565; cv=none; b=Cr0m+aHyhKSZlFA0TCgMegFK4R4phhB/FSMT0yGLstw4fhSYcxmXTxKkCzPm1p7nvmRoGocZJnP7kl/ptHnpPf6NdbCO6YsUL0Fjq2oeZWOFn+5EXjt7RfSXoPi8SBeHWnYCBEVlAfIlkGLbj98qnlwESBKbrYBPNjETqAijiQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731933565; c=relaxed/simple;
	bh=KUJYBhG01UQlZh3Dd02MxaH9pV5dWECzvNzW5QV/e5I=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=h5xjYHAiEbbtro5Z/1O2qHn3on+ve+wk2TqlRkzEICQvjPLVnGVXAF0hNdQIhUidtfukoOkB/NKY9AIG+xKgsQT+wT8IAfva8sYWxI4Vks/W4BEtZYrjr+855r4pfnslWRViTwQW6/Sp10rtZtz5bxvlVn62DfxebGIHu7tj77E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-83aba93c01bso456397239f.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 04:39:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731933563; x=1732538363;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JoqvCgtdU4lMJOv2UffTj7/ARJEytxGntBglXk5Ifig=;
        b=mREBJfO73hCtVHGz77a5zHDHbHm5in7CI4a2ZPi+CGmcnKwRJ9BRV8OyWUtmCmFNby
         NJDdmbgGN1XmfdlcN2hFdyhyVeBjQjDNkFkt+3yKQqxQ9SFKupuRsm1H79pT058IkKvT
         ePB0/n23T9dqT0HLeA60FY7y5uzULaObLQYvl24nR5vhtFmyRXAnhi56su3CnSiq3/EL
         aVASmQSKAKdplaS28cnlJhRE8UE+in+Gew7SgOFfxMISyblNH0fB/jdsHd0ztJt1pTOd
         /7lkPwzJyow7QlNouXWr5bEe20uNo6PLnTCExa6tlTc5efGqDVWxen/gFmE0ayQS+cVL
         U7Fw==
X-Forwarded-Encrypted: i=1; AJvYcCURf7CVwCwhGke4RyFDs4lE55Qu6kkQLTU9Gy6BbiZ1mZcIX5RtFi8RFZCrU222oYS7wu68+ncLYg1Gy44=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHFnQABFlU/mO1YWBL6az6b4LMGUpGIf2ihHS0/5a67hVGXkbw
	Yf+TuL187KjAUJyzTCAVGj+81kc1Gkpk7516g+LmHgaZTqmigEiuTUPRjmaY/Z5PG0T5MYgJiCr
	dXEEbIsBvHceHgGf8/LWivrZaI9/aPbMivryqsQQRYGgcWSu5bWwZMn0=
X-Google-Smtp-Source: AGHT+IF9mcBCCC9GPfOHSylucVBFguajg0Mg0J0fl5nAp/fpCTpCUXZ8MqkHvUNsT32nxmJyXSVkb35ODLRRyU28ZknoHd3/PNYu
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1522:b0:3a7:6721:7adb with SMTP id
 e9e14a558f8ab-3a767217ba0mr32243355ab.2.1731933562939; Mon, 18 Nov 2024
 04:39:22 -0800 (PST)
Date: Mon, 18 Nov 2024 04:39:22 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <673b357a.050a0220.87769.003c.GAE@google.com>
Subject: [syzbot] Monthly f2fs report (Nov 2024)
From: syzbot <syzbot+list9deb5e64e2106995cbb1@syzkaller.appspotmail.com>
To: chao@kernel.org, jaegeuk@kernel.org, 
	linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello f2fs maintainers/developers,

This is a 31-day syzbot report for the f2fs subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/f2fs

During the period, 1 new issues were detected and 0 were fixed.
In total, 6 issues are still open and 47 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 1182    Yes   INFO: task hung in f2fs_balance_fs
                  https://syzkaller.appspot.com/bug?extid=8b85865808c8908a0d8c
<2> 72      No    INFO: task hung in vfs_rename
                  https://syzkaller.appspot.com/bug?extid=6165bc9800cd6e1fe958
<3> 4       No    WARNING: locking bug in f2fs_getxattr (2)
                  https://syzkaller.appspot.com/bug?extid=44090b62afaabafe828a

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

