Return-Path: <linux-kernel+bounces-573009-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A67C1A6D16E
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Mar 2025 23:24:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 161893B4330
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Mar 2025 22:24:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EF411C7006;
	Sun, 23 Mar 2025 22:24:29 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AEC724B29
	for <linux-kernel@vger.kernel.org>; Sun, 23 Mar 2025 22:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742768668; cv=none; b=H3uzhmYbVBTwg8CTe5JqP94aPCGHrsTUg6I8DZUClr9Bllz35O1QaVJHZ03pJjFT9RLkojo3R0dpkIxfovNvXVeRU1k0wZhXQ/8BuCN/7cs4Dkd+rDtgwXVthLHd22qFsQCblI0VLIvkZaXUB2MinD7B/c9rMliW0/fcp2xlq1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742768668; c=relaxed/simple;
	bh=e93NaZcK5YQEteWySfSzqPEL6aqg0cgUQnOjoxtN6Tw=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=jnxii5wTYpaUCqBgOI1RAt+UaMvFAXavHFdOV7S+cWr/RH37qrXVu/SUPuK3IoSsgjGfOvNAPl3yZjgthqnxdEnm2tJ2Hdwk1pNG190pCb42Q9Nfcpznbvg41tOig44FxeHJxuVdKtaH8i8+EIQ2aZoZG7wMTTDxZDc3CEKn0eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3d05b1ae6e3so35364245ab.0
        for <linux-kernel@vger.kernel.org>; Sun, 23 Mar 2025 15:24:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742768666; x=1743373466;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=T5KlCy6Q8RD8sDEwc7MlxQAo++rAefTBGZtRiPfhOzo=;
        b=tLUad8FWQnAdivYrltZBLRUsVto4Te86xFf7GOpQwnXM7f9beDGGUISKydGYoJYFne
         tX0mbmBzfOSMQ5f94BiHkbc6881vIT1ytk68VG4eNnasE6zLfSnzT5Fj52aQkEpr55EE
         ePUizm/AIThaJzLbwl6xBdtxUqC2KdQa94bGJ/rKwy1o9a3b6MEEO7cr6ybsHoBnz1Kh
         UzVWBXccCrE12Cl7HExX2Nvlk8VH1KndqgiyyaFi/gPBs4AXerITHUKR2ags5S8rC+v6
         t0dnjuiTpasi1TN98RtpyCDufACRyUBsKDlNfCLs+epkjEdV4xrrCJOmUFZlQWfaVU8P
         NWRg==
X-Forwarded-Encrypted: i=1; AJvYcCV4LQBLlAQtUFAEFe9+Tkie1pBFqpQDJs1QO8y2m7EG9TIJOBuVO+W7DB1HfGH41VQ+TYQGzTD9B+IbwkU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yww/DXQV7YiDVxBTZhmzeAMmaX+PnSnhgVgOivR9d9dTue1ek3h
	6Xl6EH4NnO7ruaBlfC8HRpCTUUC3BGpaOUEL6kdmMM66DInD7+3vxzB4xX2XWtndmilHqmZaDww
	o0UCcsjhlolgpy9qGsL7H9YZYsYSdNfUn+9EN+we55YQhKdBz3amrcxg=
X-Google-Smtp-Source: AGHT+IEHtrbk1CRW9UDW9T6uDfYShMOVxVnjtCancFyNNOByM9MTHzx2i0riRFA6Exwj9Dt0JvxVFYE0YbuqxYcDSlGSxv63DWGJ
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:152e:b0:3d0:4e2b:9bbb with SMTP id
 e9e14a558f8ab-3d59617bef5mr121532135ab.21.1742768666679; Sun, 23 Mar 2025
 15:24:26 -0700 (PDT)
Date: Sun, 23 Mar 2025 15:24:26 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67e08a1a.050a0220.a7ebc.0005.GAE@google.com>
Subject: [syzbot] Monthly xfs report (Mar 2025)
From: syzbot <syzbot+list5cd62fbbe518216907d5@syzkaller.appspotmail.com>
To: cem@kernel.org, linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello xfs maintainers/developers,

This is a 31-day syzbot report for the xfs subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/xfs

During the period, 1 new issues were detected and 1 were fixed.
In total, 21 issues are still open and 27 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 184     Yes   KASAN: slab-use-after-free Read in xfs_inode_item_push
                  https://syzkaller.appspot.com/bug?extid=1a28995e12fd13faa44e
<2> 156     Yes   BUG: Bad page state in iomap_write_begin
                  https://syzkaller.appspot.com/bug?extid=c317c107c68f8bc257d9
<3> 94      Yes   INFO: task hung in xfs_buf_item_unpin (2)
                  https://syzkaller.appspot.com/bug?extid=837bcd54843dd6262f2f
<4> 21      No    possible deadlock in xfs_fs_dirty_inode (2)
                  https://syzkaller.appspot.com/bug?extid=1116a7b7b96b9c426a1a
<5> 15      No    possible deadlock in xfs_qm_dqrele
                  https://syzkaller.appspot.com/bug?extid=da63448ae44acf902d11
<6> 13      No    BUG: unable to handle kernel paging request in xfs_destroy_mount_workqueues
                  https://syzkaller.appspot.com/bug?extid=63340199267472536cf4
<7> 10      Yes   WARNING in __folio_rmap_sanity_checks (2)
                  https://syzkaller.appspot.com/bug?extid=c0673e1f1f054fac28c2
<8> 4       Yes   WARNING in xfs_bmapi_convert_delalloc (2)
                  https://syzkaller.appspot.com/bug?extid=1fcaeac63a6a5f2cc94d

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

