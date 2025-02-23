Return-Path: <linux-kernel+bounces-527986-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56387A41205
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 23:20:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6DE4C7A9069
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 22:19:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB20186330;
	Sun, 23 Feb 2025 22:20:30 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB63513635E
	for <linux-kernel@vger.kernel.org>; Sun, 23 Feb 2025 22:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740349230; cv=none; b=dVUwuE/9ZR5mOke80X5haBGZDJ1SF0voXJYMgsuDg4ibGVWsRYXg0mX0Qpgy8QhplI+MngS9h/Vs2mb9Q+kwBk0hzJKOFXnZSopViqhIpCiCGP83u7xddktd9xH6IeLRFqad75tx+1Mb5OODfzBM1jj7iUTv2nsnGsFS8m65PBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740349230; c=relaxed/simple;
	bh=4q+jpYig8+lGmn0wOK0GfqUH3CgPPbw/JiQVIVEvhEE=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=NSDTMQG7RloOeJzCXnI6QwU5mgG3lHDIQGiO2z7YfH0hM6oEyzE4UcrpcRka4UfaS3ByPWDGi3sC4ji1QqEztn2T6vHefiKfQe7j4rqS8QkLUDl2qoWHoNhL3MZZb5D2dot5Uv410/cqaINovnPagM1xWR8JuwLlINRHHgwznRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3d2a40e470fso29977195ab.3
        for <linux-kernel@vger.kernel.org>; Sun, 23 Feb 2025 14:20:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740349228; x=1740954028;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mS1ypvNRaPahBWxFrx6PlbD10RNfGLusDYKckKCNbJQ=;
        b=paUhOQBMa/iBDrRYixwg9C2DQgFGwgjprk40IcB7ZH0DWH7lsrMcj4yOrlwzTzFiCu
         QB4eCa4eBLxc3+qru+4jEcKS4Npm5Ahl0CovRa1AlO1ILQT35tcO9sevAl2ZS1qVcD/Z
         j8OOE8uvmjeHVyBILBwOudqeA+PPE/BrQ/v1ALa34sMquGnupfcaSJSSObng59LPL12w
         0iWwyS6vi3vlE3FGkyQCElz4BrMDK6SPRUWfuhPuVkk+af8rBklSnGZ1Decm4gqimTn/
         vgt0QxDw7b5/wJv4kCpOn3TdhD0VbqCuXYFC8LxTcBUcbCbcS60gteNIHIvnHUrM4cx4
         TqaQ==
X-Gm-Message-State: AOJu0YyyGCvhQ79ygM35vBEganCUJz6JU1SJKlK4vsn/4BpaTHzLi9+T
	a+6C176rf2+Rdcm+ia9g0ZYR9UOHppTfNDDvW63BzhuFnQ2cOH9zoU6MhoqHcAceNlH0nghyYFC
	Z2SEVYzELFhc9jfUphvfjEjeX9dhrMLEjY0s8EpvywLnFuJHMJbmmiWE=
X-Google-Smtp-Source: AGHT+IGQqcaW4Hu1YQC7Fp50SrwGoWLTurWsEPiiey8K4lpKcyZU6Y9+fHhmn5Tx372K/FSdOrLJ2IIN5VP0GgJ7mHenujBZqrTq
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1448:b0:3d0:10a6:99b9 with SMTP id
 e9e14a558f8ab-3d2cae474a7mr93378615ab.3.1740349228258; Sun, 23 Feb 2025
 14:20:28 -0800 (PST)
Date: Sun, 23 Feb 2025 14:20:28 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67bb9f2c.050a0220.bbfd1.003e.GAE@google.com>
Subject: [syzbot] Monthly netfs report (Feb 2025)
From: syzbot <syzbot+list734458d14554b90e6367@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, netfs@lists.linux.dev, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello netfs maintainers/developers,

This is a 31-day syzbot report for the netfs subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/netfs

During the period, 4 new issues were detected and 0 were fixed.
In total, 8 issues are still open and 3 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 49      Yes   INFO: task hung in netfs_retry_writes
                  https://syzkaller.appspot.com/bug?extid=666a9cb4c41986207cdf
<2> 10      Yes   WARNING in netfs_writepages
                  https://syzkaller.appspot.com/bug?extid=06023121b0153752a3d3
<3> 4       Yes   INFO: task hung in pipe_write (6)
                  https://syzkaller.appspot.com/bug?extid=5984e31a805252b3b40a

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

