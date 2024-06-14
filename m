Return-Path: <linux-kernel+bounces-214521-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 27D279085EA
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 10:15:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5F871F22748
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 08:15:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E710D184135;
	Fri, 14 Jun 2024 08:14:22 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 160AF1822F8
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 08:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718352862; cv=none; b=c+iNeN04beWpffgw1Xs2WLbZxYWC3EwuJungpDZvXK0+OnJpo+/QdusJaMXK81aCb6HazzCEc6oJGDiIL/c5zVEzpv4HZFj9Hrjqt2Uynk7J4zjKEExgui1ZRGZgRBuBWzMLI79XggLcWNHryhOQyHg+46H57H56mgpNPb7vwd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718352862; c=relaxed/simple;
	bh=yLqAfftgtIHGKZn0iE5v48D5mADBsgNfgWxlFY1CiL0=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=qqbZJm5w9BLYY5TPkzTpplHVtlA+Ufh/GRUipKSUvWWAo+o8LtVNsTVwgYr8cZVHtMZMDOcDImQdo6cwDS9q6/Z/kufAN8H7uimLOuEWyZ/pSBAsYErbaIF9817TfSn4mTEWNEltra1LMeXWGM/FprOMH9Z1PUxjx8TJXqT3sSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-37586a82295so17859615ab.3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 01:14:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718352860; x=1718957660;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=adMNGI81LfgdnwJM9zYhmP2IG5H/7LSnDJYwFF5kkRI=;
        b=CsaiseW91ag0EUzHY3R7Anm2YTgBymrRUne1hkgPpiu5pJ2ZTL2ngL17FflUIxBkrr
         MZl16kvjS6sLHEFw3FgTXHWDF6MioBuERheOr5ffkzjXB9sUE5jCx2gOu9dAQkPnddxA
         +GPJ/OaYdhGyi+gbx3NAtnMdXO5snBXQQxuGoSwTerlzXhUzO2OCKX2rghlsldtGFsv6
         WL50tEoXhiRhqWIkdQwj+qoqUVdvRDUYyBZtr0bVQ7x3Ek7GbzQ7GArJB4+6xMY4x9tn
         DGZ6Xd8WPParg6yZLOObSi9W5gSDCXbqG6NTn541W+UZ8ROQLor1k7qR1NHs79JPsnGV
         M6Gg==
X-Forwarded-Encrypted: i=1; AJvYcCVo9Ea/jANIFr4Xfc044cLSYRPL6BM/J8LnHI09h7/BQiTzg55jg4UZiI4EuKa5VI6FlW0/2of3LUQJD6DgWhh18K19GsSE6bfaQpeK
X-Gm-Message-State: AOJu0Yx1lowEi/ppG8uKoidJKXbxYicF2OD2Low9gd4VOO5o5E75/3L3
	WcHlHpJAhtRijQ/Oma7n6iWf59J7wx3MM6oSpXWNPI8yBZpWGoVeRMsIpyCOlONw/G2KKEhKCRv
	XUW0NXDbtl1/5mp3drJJsxeTe4Ox6/J6Sw94rh3OXYonqs+TR247cWuw=
X-Google-Smtp-Source: AGHT+IHbO4SJ4CladRVzwUwIWOBRY0asH+KlStwnD45lqOeoOzdgMkj/jdrOgL81L8pRX+dUYkIdMPK40jNAei0KmS3aKEJA/C1Y
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c85:b0:374:64df:681c with SMTP id
 e9e14a558f8ab-375e1053484mr1184695ab.4.1718352860205; Fri, 14 Jun 2024
 01:14:20 -0700 (PDT)
Date: Fri, 14 Jun 2024 01:14:20 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d4e4a1061ad53398@google.com>
Subject: [syzbot] Monthly ext4 report (Jun 2024)
From: syzbot <syzbot+list89334176c7333521aa2c@syzkaller.appspotmail.com>
To: linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello ext4 maintainers/developers,

This is a 31-day syzbot report for the ext4 subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/ext4

During the period, 8 new issues were detected and 0 were fixed.
In total, 38 issues are still open and 134 have been fixed so far.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  9744    Yes   WARNING: locking bug in ext4_move_extents
                   https://syzkaller.appspot.com/bug?extid=7f4a6f7f7051474e40ad
<2>  767     Yes   WARNING: locking bug in __ext4_ioctl
                   https://syzkaller.appspot.com/bug?extid=a537ff48a9cb940d314c
<3>  547     Yes   WARNING: locking bug in ext4_ioctl
                   https://syzkaller.appspot.com/bug?extid=a3c8e9ac9f9d77240afd
<4>  491     Yes   INFO: task hung in sync_inodes_sb (5)
                   https://syzkaller.appspot.com/bug?extid=30476ec1b6dc84471133
<5>  452     No    possible deadlock in evict (3)
                   https://syzkaller.appspot.com/bug?extid=dd426ae4af71f1e74729
<6>  265     Yes   KMSAN: uninit-value in ext4_inlinedir_to_tree
                   https://syzkaller.appspot.com/bug?extid=eaba5abe296837a640c0
<7>  248     Yes   WARNING in __fortify_report
                   https://syzkaller.appspot.com/bug?extid=50835f73143cc2905b9e
<8>  226     No    possible deadlock in __ext4_mark_inode_dirty (3)
                   https://syzkaller.appspot.com/bug?extid=72c7e5a0d9f5901e864e
<9>  155     Yes   INFO: task hung in jbd2_journal_commit_transaction (5)
                   https://syzkaller.appspot.com/bug?extid=3071bdd0a9953bc0d177
<10> 32      Yes   kernel BUG in ext4_write_inline_data_end (2)
                   https://syzkaller.appspot.com/bug?extid=0c89d865531d053abb2d

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

