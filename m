Return-Path: <linux-kernel+bounces-568826-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFCEAA69AD8
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 22:29:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6DA91887D86
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 21:29:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D55E92163BD;
	Wed, 19 Mar 2025 21:29:27 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 160B84683
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 21:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742419767; cv=none; b=DqJ41i9gfKdo5MMqozEpihJ5mn2fhkisxOW0CXnx3fPAB8qxCwrVZvboAM6eh+dETi4cib3cK/BNc4RCGZsFveKyYSZfKWgstKR+Unhx7TxnHk1B550d55mVN/zQD/Z4N+cYbBiLv30P+zGwcnbElqx9TBILnEJY083f0B5CfFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742419767; c=relaxed/simple;
	bh=fPnbNObDotL649FEnfff/h/52LjX/j0sEYkkC7QUKU4=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=JC6EQ6xYZ4t9EJz72+4yizJow9ghffNfwL3+IZe+1K3UcQgsAQ9vM8ydqbUwyc6U5d4N8y25e3cvOhTD22Pi6+v/R98LjxlGmcU59F8McNoCg2TTXwrFxKx5W/QAJRAx7RTm817MxrFSCEqsM+7dIcSjIDg+ekSTHERIbDCvu1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3d2a40e470fso1018735ab.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 14:29:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742419765; x=1743024565;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Vz21S4qNzzAqyrIxen6zEuuSUBt6BYGIWgbvRziLXiQ=;
        b=aURhzD3vJvoBb6bcHeq5TwQ4afbY9g8pXjGqN/Lbs4fmNg9kIR6URHzqMIL9mBMayP
         a7oJdzizlSWfcad6/F3rJuzHmy2qMNglzv/Zjcjirni0rj7//7aKfaxou8s8nJv/pfF5
         8gw+bDj6poelU5AHGnYvd3BF4HoS6ttNZE9SGB1R6Nx4lxUBtR2nZcU+MN20fL7bI8nE
         qLcGUMRZyv0Lp9dC7k4ECML60eQJyAScOdEn52KDec10+KAI1IO/rbswnwrqioVrShCx
         yk1pegm7LBUsvyvvQY87yKzl4PUHIgOpPe3RjVd0cpoveuQiA0NVUAvo+jIYyY3hv8Bl
         A/kg==
X-Forwarded-Encrypted: i=1; AJvYcCXpJ4zBpuTkDO/YfgdvZy+feNe9l2vdsWAlVFFo7EzYzX3Zxav1vChHm8gbnsdU0rxy7iAbxl6+E3iSSpY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTx6f8WblVOD+H2iuPylfHX5mvsBww4FyKxob/5WjyKTX5lIGs
	j41o67i3tcbLMt79lzaeCK+yZgfJmDTz7HtmIM8HcPDRCcmzIm+pjvn3RucP2zWTZNjeWrDICZ9
	FCASD+mb0VczWpwj3t2AAgN5YkHQHWIvxHswuS1apTOwS0XA/Deue9Po=
X-Google-Smtp-Source: AGHT+IGLpopHz8Pnsq75sZ4L0GsNzyxAHMn2y9QHI8TV1NTIKZTGzA1Xyq57Y2G5S70H9lX5DC9sj9B7EuJFN/NQ06SY+E8vTIxq
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3d43:b0:3d5:891c:13fb with SMTP id
 e9e14a558f8ab-3d58ebaa572mr11341875ab.4.1742419765275; Wed, 19 Mar 2025
 14:29:25 -0700 (PDT)
Date: Wed, 19 Mar 2025 14:29:25 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67db3735.050a0220.3657bb.0145.GAE@google.com>
Subject: [syzbot] Monthly bcachefs report (Mar 2025)
From: syzbot <syzbot+list1844da6a324b378d2182@syzkaller.appspotmail.com>
To: kent.overstreet@linux.dev, linux-bcachefs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello bcachefs maintainers/developers,

This is a 31-day syzbot report for the bcachefs subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/bcachefs

During the period, 17 new issues were detected and 3 were fixed.
In total, 160 issues are still open and 138 have already been fixed.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  29679   Yes   INFO: task hung in bch2_copygc_stop
                   https://syzkaller.appspot.com/bug?extid=c6fd966ebbdea1e8ff08
<2>  7346    Yes   INFO: task hung in __closure_sync
                   https://syzkaller.appspot.com/bug?extid=7bf808f7fe4a6549f36e
<3>  5807    Yes   KMSAN: uninit-value in bch2_inode_v3_validate
                   https://syzkaller.appspot.com/bug?extid=3cd97352d16f0e6066d9
<4>  3541    Yes   WARNING in bch2_trans_srcu_unlock
                   https://syzkaller.appspot.com/bug?extid=1e515cab343dbe5aa38a
<5>  3442    Yes   KASAN: slab-use-after-free Read in percpu_ref_put (2)
                   https://syzkaller.appspot.com/bug?extid=905d719acdbd213bf67e
<6>  2491    Yes   WARNING in bch2_fs_release
                   https://syzkaller.appspot.com/bug?extid=08d08d52c3a09bfc70f7
<7>  2333    Yes   KMSAN: uninit-value in rw_aux_tree_set (2)
                   https://syzkaller.appspot.com/bug?extid=ed52fb987e4b52cbfad9
<8>  1166    Yes   INFO: task hung in bch2_journal_reclaim_thread (2)
                   https://syzkaller.appspot.com/bug?extid=820dc3b465c69f766a57
<9>  983     Yes   possible deadlock in bch2_symlink
                   https://syzkaller.appspot.com/bug?extid=7836a68852a10ec3d790
<10> 821     Yes   KMSAN: uninit-value in bch2_trans_start_alloc_update
                   https://syzkaller.appspot.com/bug?extid=f02ee424846cc4e04e04

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

