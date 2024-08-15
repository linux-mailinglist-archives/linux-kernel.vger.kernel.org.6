Return-Path: <linux-kernel+bounces-287810-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 59738952CD1
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 12:49:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADE1A28466D
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 10:49:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5088319D885;
	Thu, 15 Aug 2024 10:40:29 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 759F61AC883
	for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 10:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723718428; cv=none; b=s4NcXW1zWM/cn0Lkb77lfPdvnOaZGLtrq4mqS3C+QL52rii3YPTGYYA3YmJBh4253vzfgru9FaH9Brh0e8xvFmNBrnBEguHVtDjhBxvRiOKMahHxaNHgYiBnEQtHPaIK3FNpOUHiAI0oLTc1xGeXJz13HvXd6LwVSLwt0Wp0gNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723718428; c=relaxed/simple;
	bh=z1ba+5EJVDOkslQ+E/z3CgpEv67HZzOhoQigUq+k5cQ=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=eDWJuMns4AYVPZ7AV7vfUP/w1rNGLNYWMKIN0mM1p/jm9s2M0NW2HUQSmQCdJcvopmi9lUyUdlImprcysiMqWA6kOPJpc29yweBcIla6qOKW9AzOHUMEyP2/i2+D8GaZFCgmPyJlmfNOcuL4ALa+yeIWjPVi+q/cNX3MrRgXj18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-397e0efded3so9191725ab.2
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 03:40:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723718425; x=1724323225;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=opiCOyLB/xPeMdw+vyiT2OWRVsp382tiiE0i299tivY=;
        b=IajH5E0EbS6vqWYZ2yiu/bD/Hq+0x23YA5I5JnosePfojL5FwbGHtrgrtXeCT8OQZz
         wYL1OvgcFhV4fwLFg2nErqyXwX8TDOnPOMJpCTUSAMlhpeqgw8sHsFgibxfJsNDGM34H
         k1S4ReSJGdXluBoHgN708Uwy68b5pspb7PyPr4ecGYkAqviTm7zr+G1WeayjdcuGoCOo
         abM9ZNEJc1BuhpdCxWOuvcQJ1z7HqhoPXl/4Sn1XdVxbqsObisqVZuZ5H1FeJ6eTASm+
         N43GyjDAcQHtIlzJaG2getmZ0a/pQxNjGYy7tK7QPj8MlvtjxM00OiUNlZe9In/ejmu/
         +qKw==
X-Forwarded-Encrypted: i=1; AJvYcCWUCYBks6wdvBMyPs7KTJ/ZIGn6ddM9r5vMMfL7XjeG5mYWXbEUzw0hANOwLdA48HMI8PwoMW/wo5qCHa28KuHNstLnuPEhCOh+s9O3
X-Gm-Message-State: AOJu0YwfWs2LAQ6bV5Op3eYngTgsgKYY2gOjb+3HB4bxSLA4NtxiQisD
	CYExx6upq++ik5TDYgSYMIUSIlLmAPUxPqGkzXvXsNvttCfa/s2sq6MILhsyb0aRKcVK2q9deZu
	75pxC5n9O+sLsnJ1dozKV1TDlfuzLekaqGcqBQcAwCQWFvOL8xGX+u9M=
X-Google-Smtp-Source: AGHT+IHwFK/7Fi1D4ndezxiB63QY2Su/S65+td2Lvy/Y8aP12/SaksBUdM8x7drT5SN13mffR4o50rRGTKkU4SCvPTX7wNuZem2M
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:12c1:b0:396:ec3b:df63 with SMTP id
 e9e14a558f8ab-39d124f3e2cmr3864035ab.4.1723718425574; Thu, 15 Aug 2024
 03:40:25 -0700 (PDT)
Date: Thu, 15 Aug 2024 03:40:25 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000731785061fb678d5@google.com>
Subject: [syzbot] Monthly xfs report (Aug 2024)
From: syzbot <syzbot+list4f8957ccf166d2563804@syzkaller.appspotmail.com>
To: chandan.babu@oracle.com, linux-kernel@vger.kernel.org, 
	linux-xfs@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello xfs maintainers/developers,

This is a 31-day syzbot report for the xfs subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/xfs

During the period, 1 new issues were detected and 0 were fixed.
In total, 12 issues are still open and 23 have been fixed so far.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 74      Yes   possible deadlock in xfs_icwalk_ag (2)
                  https://syzkaller.appspot.com/bug?extid=4248e91deb3db78358a2
<2> 69      No    KASAN: slab-use-after-free Read in xfs_inode_item_push
                  https://syzkaller.appspot.com/bug?extid=1a28995e12fd13faa44e
<3> 22      No    possible deadlock in xfs_ilock_attr_map_shared
                  https://syzkaller.appspot.com/bug?extid=069cc167ecbee6e3e91a

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

