Return-Path: <linux-kernel+bounces-516828-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58165A377E9
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Feb 2025 22:54:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1121316C391
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Feb 2025 21:54:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6EEEC8E0;
	Sun, 16 Feb 2025 21:54:26 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB39F186615
	for <linux-kernel@vger.kernel.org>; Sun, 16 Feb 2025 21:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739742866; cv=none; b=GddNL5ma3TRnQCsz+zr0AC5VbK19hFDQpgudK43WzaP1/OZ4AP9HsdCxUvlT+WZfdkC2GB2XypisX2h9BJq9QIQqfP/RTjrBN00kPHMEHibWKtt/SHXt8YqnWoV7fz9y4jjOieqFvdUq93BQcT6KswR2QFPQ5y9LrbfMl/yy4z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739742866; c=relaxed/simple;
	bh=xVDCXXcspN54ObCOA7TlaRlKfcwYiDr1XHehL0iDPNw=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=qvR8QMaNkrE/aRaWrDoU93qQRpNkMF2YMUUZFOOqZ/R8WGzWpgBDqA1R/Do5iRCysFg+c+9B80xqz5OdqsdxE53Et5PtCLSSh5/4fUWY0dEBZt36y1BUTEtiMD6nuuq3zOBjAYXMdGd/n9ulDBxX1n7rAJ14W8/UjA2NJNEWkFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3d145b7ba54so25487675ab.2
        for <linux-kernel@vger.kernel.org>; Sun, 16 Feb 2025 13:54:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739742864; x=1740347664;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cAfc/Bqjj1W01z/JmTwGR17l7AbYfdp7RR3w4otaT1I=;
        b=OgoNnyHT5XKidwV2l7Do6imVYRfnFCdGfEeWXaaV5WGUCtwIiWhxJlX1q99ukZoMfv
         vrUVYE+x2lhTj28pOKgD9I4PkUVUDZUChlz4BbGCx8gh9lbbg4oJ5O9IU8rP0Jrz23uF
         Lh6nj2Kk0Zt0yJKQsXctco1lzxAMU66EAlxjgcPDyb/x0hSDAmSPV4m1pcFULxhxvCrJ
         Z2jg+3GDN+Emct1iuE8MreiahZKSd+8+ls5JQM1Mcz9Iyj8OErHh7M33hReK+gtpfMWj
         FLiOucQoL1rNddcI9or1v5Vw+rV+K9gNMllhTaA1De2A12SV7uZ5T9BtNOGLYAhaUzJl
         p6Hg==
X-Forwarded-Encrypted: i=1; AJvYcCWONWYdjVJnN3tJhRkH+NpJBAqDboxttuBsPwY7lsk0+zL/KWiS2nwogd6/fEECKFEHNqhUWPXweObtRCU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhLFjI4aS1j8WlZPRakkA2XrTeG1yJOtefoyZExDfaEdoQx9OB
	RVUL2tiv7BeqG0qkkW76LhgfL9jYv2o1F5d9rAWclsZhbYRAdrsnzmr1J488S/4FJnaRZQKEYtF
	n0TYPDrd7e3fbDrodKKFzQpUHyypigfurKxI/S/UOvs52XHN8RSl9qBM=
X-Google-Smtp-Source: AGHT+IH8yHRrPTRqWGjNBj77ogFuzDmITqcRlQtqilX35p027C/cnkKZZTo5Qo3tQFU1Zkv5BH7tkCLauuG4xkWLQRh6r2/ZIJo7
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a4d:b0:3d1:a34b:4d01 with SMTP id
 e9e14a558f8ab-3d28078f2e5mr62249145ab.8.1739742863818; Sun, 16 Feb 2025
 13:54:23 -0800 (PST)
Date: Sun, 16 Feb 2025 13:54:23 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67b25e8f.050a0220.173698.0017.GAE@google.com>
Subject: [syzbot] Monthly bcachefs report (Feb 2025)
From: syzbot <syzbot+list57e38899ff0c2990791e@syzkaller.appspotmail.com>
To: kent.overstreet@linux.dev, linux-bcachefs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello bcachefs maintainers/developers,

This is a 31-day syzbot report for the bcachefs subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/bcachefs

During the period, 27 new issues were detected and 0 were fixed.
In total, 147 issues are still open and 135 have already been fixed.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  29252   Yes   INFO: task hung in bch2_copygc_stop
                   https://syzkaller.appspot.com/bug?extid=c6fd966ebbdea1e8ff08
<2>  7250    Yes   INFO: task hung in __closure_sync
                   https://syzkaller.appspot.com/bug?extid=7bf808f7fe4a6549f36e
<3>  3473    Yes   WARNING in bch2_trans_srcu_unlock
                   https://syzkaller.appspot.com/bug?extid=1e515cab343dbe5aa38a
<4>  2458    Yes   KASAN: slab-use-after-free Read in percpu_ref_put (2)
                   https://syzkaller.appspot.com/bug?extid=905d719acdbd213bf67e
<5>  2231    Yes   KMSAN: uninit-value in rw_aux_tree_set (2)
                   https://syzkaller.appspot.com/bug?extid=ed52fb987e4b52cbfad9
<6>  1644    Yes   KMSAN: uninit-value in bch2_write_inode
                   https://syzkaller.appspot.com/bug?extid=c17ad4b4367b72a853cb
<7>  1245    Yes   kernel BUG in bch2_btree_path_peek_slot
                   https://syzkaller.appspot.com/bug?extid=3ebaf90b49bd97e920ee
<8>  1156    Yes   INFO: task hung in bch2_journal_reclaim_thread (2)
                   https://syzkaller.appspot.com/bug?extid=820dc3b465c69f766a57
<9>  939     Yes   possible deadlock in bch2_symlink
                   https://syzkaller.appspot.com/bug?extid=7836a68852a10ec3d790
<10> 484     Yes   KMSAN: uninit-value in bch2_alloc_v4_validate (2)
                   https://syzkaller.appspot.com/bug?extid=8dd95f470e7cd0ff4b66

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

