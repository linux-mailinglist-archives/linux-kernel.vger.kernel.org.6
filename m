Return-Path: <linux-kernel+bounces-252960-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E309E931A97
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 20:58:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2104E1C214A4
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 18:58:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39D5212D214;
	Mon, 15 Jul 2024 18:58:30 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 667F84EB37
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 18:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721069909; cv=none; b=FewclYhmduHTqZAEFtcTbSP0POdJlKTXj+O6a7Q+9HRZ23VJ2MJ3jbbPaHRN1iQ/4RPm+gGNVKMJ9/+Mn71w+LMWRzyIgtsCl3wRuFCwfoU+1dx76ONOIUQYgRrRFqxR55xjNN0hkxvCElOVj2yue5vhXiXmtnjQqqrnr9Yj39c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721069909; c=relaxed/simple;
	bh=CY6PWv8H3KhC110hyOjmpJmbBBZx4l8RXYjoZZsvS84=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=DH7BfjGMlNKo3eDaVp3rDgmAYpXr8ZdurTP5LzPZHy+VjKFgnoTPFJqRT2+Nxm5BQ9W72VgId0mTlO4Kjg3eTirOuNmJDKnWzov5TJvbkP7fwhflAfoFEfS2SpPF4mVMd2rUWAfh1S+UxIVi7ByE4oDIs+WnM0ufcgz6Oj8QrVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-8152f0c63c4so32942339f.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 11:58:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721069907; x=1721674707;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AvJYbgXXuIoKcXDaxUCAc8E+cIgjRwR+GgSHpz32uFg=;
        b=juCCJkQPiQTkr7CKvRrUDKw3VhOjEedgI9Dp1TanCZ05bCvnuWsl9Gjc+QHBMxXId6
         1vzM+/et/TP05G1QSgsUJiEdga5tdXiEWfU9/cJNPUdHDBHUJuYICulnVsjXy2O8Nw3S
         zq0eBsWPm/VzG5GHxyoOFYCnmd/DKJcqBKLgaruEP87ao9AdzMd2CODZvy3parP0zQCr
         sNdaVBSkLVzN2ScuQpgT+db9qnfFJs+aL1OrNcWZXTdD+xDCLb3AbIA/a+SC0y02FBwu
         U6k9BE1p8pss0vnFTN2Y7BhsX6/+H+eXLA6ArsK8/I3LrLjzUbM6bDg/XmpuANJZY16u
         YznQ==
X-Forwarded-Encrypted: i=1; AJvYcCXxpS5GaJw2uQbwsUnrP7imW18UW6RfY+NUaVmF59pT7r1tfQVTQvMh9C2Rg7m4XYNteVooN3yWoff8yDjquU85CCC4gLhJrJxn9kFe
X-Gm-Message-State: AOJu0Ywf8IFG3sIPJ8T7iJNqo/Zi7E4FgLjxfb2aNNNwe5Rwv5mKfLjk
	xzvkIwgo755O8WNGminn/b8U9HYc6/f4I09STdW0o0cwLhMEKt433GWA2aSgX++orNfu1O6mPbA
	BRBDRAOr+wtpIbaUh6VEBSoVxHv46PYX1+BOGEUdHxf+adPgl34iboO8=
X-Google-Smtp-Source: AGHT+IEAntkkKJQwYWJoP0APVlCWkx+EV5ZRAWX+U3l9yHH9TtkcZf52L1iVeKLmb6+BaKGHeKrmXQs3nNRewIIbedZcMFDmzJQr
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:13af:b0:381:37d6:e590 with SMTP id
 e9e14a558f8ab-39394c98e44mr500685ab.2.1721069907486; Mon, 15 Jul 2024
 11:58:27 -0700 (PDT)
Date: Mon, 15 Jul 2024 11:58:27 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000783846061d4dd043@google.com>
Subject: [syzbot] Monthly hfs report (Jul 2024)
From: syzbot <syzbot+list3ec8045314d28d24d911@syzkaller.appspotmail.com>
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello hfs maintainers/developers,

This is a 31-day syzbot report for the hfs subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/hfs

During the period, 0 new issues were detected and 0 were fixed.
In total, 42 issues are still open and 18 have been fixed so far.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  31308   Yes   possible deadlock in hfsplus_file_extend
                   https://syzkaller.appspot.com/bug?extid=325b61d3c9a17729454b
<2>  10825   Yes   possible deadlock in hfsplus_get_block
                   https://syzkaller.appspot.com/bug?extid=b7ef7c0c8d8098686ae2
<3>  10057   Yes   kernel BUG in hfs_write_inode
                   https://syzkaller.appspot.com/bug?extid=97e301b4b82ae803d21b
<4>  6645    Yes   kernel BUG in __hfsplus_setxattr
                   https://syzkaller.appspot.com/bug?extid=1107451c16b9eb9d29e6
<5>  2388    Yes   WARNING in drop_nlink (2)
                   https://syzkaller.appspot.com/bug?extid=651ca866e5e2b4b5095b
<6>  1446    Yes   WARNING in hfs_bnode_create
                   https://syzkaller.appspot.com/bug?extid=a19ca73b21fe8bc69101
<7>  1180    Yes   KASAN: slab-out-of-bounds Read in hfsplus_uni2asc
                   https://syzkaller.appspot.com/bug?extid=076d963e115823c4b9be
<8>  810     Yes   possible deadlock in hfs_find_init (2)
                   https://syzkaller.appspot.com/bug?extid=e390d66dda462b51fde1
<9>  767     Yes   general protection fault in hfs_find_init
                   https://syzkaller.appspot.com/bug?extid=7ca256d0da4af073b2e2
<10> 472     Yes   possible deadlock in hfsplus_find_init
                   https://syzkaller.appspot.com/bug?extid=f8ce6c197125ab9d72ce

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

