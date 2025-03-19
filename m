Return-Path: <linux-kernel+bounces-568828-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 529D7A69ADB
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 22:29:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3BBA8880D8
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 21:29:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 585AA219A7E;
	Wed, 19 Mar 2025 21:29:28 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 934CD215F46
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 21:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742419768; cv=none; b=SZ+cSI8o2te5F2QDzBe+U+h5ntno1CnJi7UFRK5d0Q+6ZC5dxWIY03MuQ9mGN1gCDHNJYnKOIE7p6jb9Z7cF7WiGFaH7zbOo26dcWIvu0BT3KpEpknDVKO4qSGl28Pa+Yg0DsXdipfg/a078O+vJB3a+/b46hUbAPhhDH9qZyvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742419768; c=relaxed/simple;
	bh=iWBF4zmzjQjvl14K7XNTc4FTgmkoLZmFQ+CFAuI9VIQ=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=IXZ+wA89i6/LgiJao8jwM9UmdNDPer40WT3KZG1mxWQ9NtTGRBfqPPbdf82GvDt0+9fIAZMYm1XvdPmsHPqzh8hE3C/2hF9YbWGhAYKq2Vsfi6VclR5gVmR5HbC7w+6XwG6hAerERoPEax3IWcqQOp9Fvr+LZ0m2/R/vQqq9Afo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3d451ad5b2dso13965585ab.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 14:29:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742419765; x=1743024565;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ev0dtg3l5FTpdjGnaT9KtFezlvpUL/u1eiqX69Cbdps=;
        b=hR9bT2YD9Qz+Tcw7JQ6dsZw1VhY4n8qKh3O4MlhATGb61KAuMf6N6Q3ZbDfGsUrlTO
         OJw33WP6TqIYfw2yTMl7Ou84iaKI9hnI6bX9CpZVXrNJER2bF6+Fq4rWsIUM7Xm5FW04
         m5myFnyUmsQMk1v3AHlz/+knGs47fwHZQeZPYgHeTkSnjc3CJI0hLFHPP0LZdGNwzQCn
         cNxrJxgDXzzrDDraQU+CQh9gs24NO0wcZYwDNMt1MxSYhjzdoYPdMjHapn5PK5lAqNW+
         pQx6cDFnngjzS7NS73Mq8KCMVSjgh7s3ZtJ4DE9XdxDrO0IANSg07qcpOD3DFfaLorFo
         BoxA==
X-Forwarded-Encrypted: i=1; AJvYcCUYuY9w41oEFsQu+Azv/xSeMeeLA3v3ZY5Vpz49oZRT170O13Z5YoUSaSzUPvL///a8BNO/EiHlVS/NTEs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYNojj0d/4FZpBGefZJpGpCBPEZyzF3ymtrLFb3SU6/w2U7epn
	v7Z+Syup2Z2jVGgX3axYqiOWBvvWG9GzR/ENtkOPZj0CBv8M6hv/c4xhe+1IqTXRdwAdrpEaXfV
	a5blWw8emHjxznZQmRotV2uEb9feHIHgKdi8k3W7/A3qVOpiTaUH62v4=
X-Google-Smtp-Source: AGHT+IFJhYZjmgQhvHFnZrl7m3kFKwggLSw9Sii0iV1q7YlFPad0Tqut2OgP3QAMIoStSv6KbnVpA4ldPOMNDbEtTII9BdjCI+Gd
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1f07:b0:3d3:f72c:8fd8 with SMTP id
 e9e14a558f8ab-3d58e8596b8mr13409885ab.6.1742419765741; Wed, 19 Mar 2025
 14:29:25 -0700 (PDT)
Date: Wed, 19 Mar 2025 14:29:25 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67db3735.050a0220.3657bb.0147.GAE@google.com>
Subject: [syzbot] Monthly kernfs report (Mar 2025)
From: syzbot <syzbot+list0424b4e796c772801c75@syzkaller.appspotmail.com>
To: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, tj@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello kernfs maintainers/developers,

This is a 31-day syzbot report for the kernfs subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/kernfs

During the period, 1 new issues were detected and 0 were fixed.
In total, 24 issues are still open and 21 have already been fixed.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  3800    Yes   possible deadlock in __kernfs_remove (2)
                   https://syzkaller.appspot.com/bug?extid=aa419d82b68e6a7e96c5
<2>  391     Yes   INFO: task hung in evict (2)
                   https://syzkaller.appspot.com/bug?extid=65b1e2d8f2d618a93e96
<3>  357     Yes   WARNING in kernfs_remove_by_name_ns (3)
                   https://syzkaller.appspot.com/bug?extid=93cbdd0ab421adc5275d
<4>  343     No    possible deadlock in lookup_slow (3)
                   https://syzkaller.appspot.com/bug?extid=65459fd3b61877d717a3
<5>  303     Yes   WARNING in kernfs_get (5)
                   https://syzkaller.appspot.com/bug?extid=2f44671e54488d20f0e6
<6>  97      Yes   INFO: task hung in kernfs_dop_revalidate (4)
                   https://syzkaller.appspot.com/bug?extid=da20d108162166514db6
<7>  36      Yes   INFO: task hung in do_rmdir (6)
                   https://syzkaller.appspot.com/bug?extid=4128a26fb0f85ec9e76c
<8>  28      No    possible deadlock in kernfs_fop_write_iter (2)
                   https://syzkaller.appspot.com/bug?extid=1cfd86253864f61b533e
<9>  22      Yes   WARNING in kernfs_new_node (3)
                   https://syzkaller.appspot.com/bug?extid=306212936b13e520679d
<10> 17      Yes   possible deadlock in walk_component (4)
                   https://syzkaller.appspot.com/bug?extid=b4567a8b2d2ad5f9dd06

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

