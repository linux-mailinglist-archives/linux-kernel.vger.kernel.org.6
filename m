Return-Path: <linux-kernel+bounces-541400-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E7B4A4BC8E
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 11:39:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 530DD3A46D2
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 10:39:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 076221F30C3;
	Mon,  3 Mar 2025 10:39:31 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D3231F1300
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 10:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740998370; cv=none; b=QNqsUDjIrgaw/9fRY0MPvlDlgg8l1qhS/wxfg9IQhb64btoEe/5wweRUnNwsQq7tSeuz2MAiJHte7Nbj/MY4KUyWUnild4UYz8t1p3kfCdWpFJfb1P+jURZt1EGxKTzP3wzTpMuQbLCRcjyGpxiyGBoUm4nhjfuFmmOYTg1qYcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740998370; c=relaxed/simple;
	bh=90NedZ4Khg1tX2c3RBe9hmd9ZkT5kxT+0JlDT5i+PDM=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=jdsY3udx++maAA0LSFLWZxMsP+KjFLxtmCOmwNYNXX4bKp4ZpH3M6y8aUG1XiwPt7rqveJL0nAX+Gt5YqKoDArZ9O5P8Q+Kr2DRPpmrO/Tj2UF5lrIpZX1ZXtayIALirQPTkFLrtdUwuUA4gt+yuYIszUF4Z8eC2sThNGgRGSZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3cf64584097so48941055ab.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 02:39:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740998368; x=1741603168;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yx2X3YMfRhmckUUpY5mpeveL25sIpLwo96OtO/Bfk+U=;
        b=q5/iYrzA9kgmNBDsvOp9NehKk3/mG5l26ovWhIlcdJXhJn6HeBeUu6dR+jRoy1CxBP
         KnsiUtVDmAoVyvnn7wcTHj+NUKkC+ySANP38DpBJhU3eW2B2h3h/syfxlceow29XnlmS
         wdXAyzRbD3Vd46siCCm6DqLffKble3OSz0BC/eDhBm1lbPcqsPs4mTr/KkL1c/cdAT4b
         cFFfPxaTrIEG10gOXzyi68xbQFBJFQTv+TO19Bx78i5aGYHJ/kaAmOrexI6KLD0Quu1V
         mNoO44Wb44RI5zCM8FHD6EjtDvhRUAmjsfHZmmLmzBBkjEX8BI09YKOv7Uabdx4fD/RJ
         LEOg==
X-Forwarded-Encrypted: i=1; AJvYcCUBFtjhEmBDBsVloOR2tbmZrWUDs4Q8lvwRG8uj2VjhL2KUHMGAIdAOpd5hcEF2CJ9mt3ggELGCP4X8vPI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyObH+rQC8CPnjJT6qi3UPS5qV7Xcwm1tuEBUh8BQ69SvMLNSJR
	LL1Fi5H5zLKzA0BG92nvZq6xtNGjDIyQnhT/C0UN8GtPe+n+AnYKTxuXrWb7qz8OiARnSMVJdsp
	spF/bDfQzgH+qlhHqmnVN5Fs0PPH+HBzI55kDLoeTtoHDnIgIaCC32VI=
X-Google-Smtp-Source: AGHT+IFiTwFGAjNBROqwDLCtVMeqyIEGryfGDay6c8a6zPiDcT2KKOpnWLTTDcnMd1J12jZaozpL/pUxD2mLRyQBsScqPn06sVE5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:12c4:b0:3d0:4700:db0f with SMTP id
 e9e14a558f8ab-3d3e6e6d719mr129288035ab.12.1740998368321; Mon, 03 Mar 2025
 02:39:28 -0800 (PST)
Date: Mon, 03 Mar 2025 02:39:28 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67c586e0.050a0220.1dee4d.0125.GAE@google.com>
Subject: [syzbot] Monthly nilfs report (Mar 2025)
From: syzbot <syzbot+list2c89da5b557d9a067af8@syzkaller.appspotmail.com>
To: konishi.ryusuke@gmail.com, linux-kernel@vger.kernel.org, 
	linux-nilfs@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello nilfs maintainers/developers,

This is a 31-day syzbot report for the nilfs subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/nilfs

During the period, 2 new issues were detected and 1 were fixed.
In total, 6 issues are still open and 61 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 4       Yes   WARNING in nilfs_btree_assign (3)
                  https://syzkaller.appspot.com/bug?extid=158be45e4d99232e1900
<2> 2       Yes   INFO: task hung in find_inode (2)
                  https://syzkaller.appspot.com/bug?extid=6646318bbcf419411bc5
<3> 2       No    possible deadlock in nilfs_bmap_clear (2)
                  https://syzkaller.appspot.com/bug?extid=4d7417d6eb8b36554c0d

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

