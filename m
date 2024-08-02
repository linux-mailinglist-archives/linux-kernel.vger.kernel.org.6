Return-Path: <linux-kernel+bounces-272210-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37D279458AE
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 09:27:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A1D96B21B69
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 07:27:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03CB51BF329;
	Fri,  2 Aug 2024 07:26:30 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17D2F1BF316
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 07:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722583589; cv=none; b=GNZYxHxCDUThZ9MpJfsUkNj7IccxznFwwqPoBnTLOar9I89j7mIPVzJ6BbINHECS0Ewe74TelsOz8Z3I8aZA7L4WbEj52ZRFJDeQXANw0adot7mNhiuPOODPFX25wwqoXeyLi02FkPatf7pGiG1R63FXbt5pMe3RfW+w0QMBye4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722583589; c=relaxed/simple;
	bh=Q7isDA4cLD+NJOp6yTaUe+JZ4Vy9np6f6rMW0uX2Zyo=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=ejyk3gRbp8PgKkBcSCBGOG38TDUluOYLyYN0AQTkkqtxMbcqo5xkA7jqjBxVw7QwRgFhsgcUq/zAjl91qp5Ft+SYsy+Er4AT+OUC/EjRC1MdEAZjIJMHdeLYx9ymGMyM4QrCgmGE03Vrk4NMtvAXyLUDx5R2ubl7TS3oqCyPyLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-81f9612b44fso1078136539f.2
        for <linux-kernel@vger.kernel.org>; Fri, 02 Aug 2024 00:26:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722583587; x=1723188387;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qU4YHEI5FOJW3hx872vK4nm0dqI+dc1npOneKYtbxQA=;
        b=ti9AyXt1MWxhQDeQX4ss6crWZfKQmvv1ArgwfyGy56J3+XZkfg/ZpGTVl6pJLj3CDe
         BmxO9kbXBCJ3lM5sI+Fu9ukUT3RWGQmm1HWJ4PxFz6xsZIKUu9ymCGMhioe4ZBB7XsBc
         ltAOuRB1uShRAt6OrC5mEC4TG1rMfE1FrvVtE94Ify/jTsCMwgLiiDdSw/yMuCrBOii7
         +7zg6cOlX5LO523ce3sfy1MytabJOKctjoKUlpwsGbOgM8Y2wRllbtx00WpUgKz9K9T+
         7Jq/YXWEiHRGsUQqcLcVROvGTbOBiqp3Y6cQrc/DD5SynLtcONZqWHNIX6Q1VoSJN+dR
         7gTw==
X-Forwarded-Encrypted: i=1; AJvYcCXdgF2ptAZOWlN/VwMH6t1+NTrcn/pnDfLkpCPvaRzv46yh1N+5parBTBlYP4rbo3BWpTgZSo35Hm65xnW/Uoh0p58P/DGLUasMbsDh
X-Gm-Message-State: AOJu0YwRAQniFzCUANikJEhlmD+VfRWi/W5i/SAMEnOzzMwwu84Thvkx
	As/N5UkBb+Eo7ERZanD3H2JrWDSLxXiY1lLs3g50apXNOtXc9BMWR+1PaiwyMUFbdraz7IDrcWa
	Mb/0O4t+XmYsF93nOB6BaJIYrw9n/vO1cpDQ8CZC4zsFMgrU08dC7SrM=
X-Google-Smtp-Source: AGHT+IFgoLsJ3Olpb4xM+WKgxtJtmrUqo6TemLUxZj1WQUH10l9PFtOsHjCb8QuKZfPmmc/KlMZx2Jb/kJnwPReKukIOTmKYVRgf
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d0e:b0:39a:e800:eec9 with SMTP id
 e9e14a558f8ab-39b1fc58ef4mr1859095ab.4.1722583587180; Fri, 02 Aug 2024
 00:26:27 -0700 (PDT)
Date: Fri, 02 Aug 2024 00:26:27 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000cf67e9061eae3e91@google.com>
Subject: [syzbot] Monthly gfs2 report (Aug 2024)
From: syzbot <syzbot+listb61a1d58ae517f6982e4@syzkaller.appspotmail.com>
To: gfs2@lists.linux.dev, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello gfs2 maintainers/developers,

This is a 31-day syzbot report for the gfs2 subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/gfs2

During the period, 1 new issues were detected and 0 were fixed.
In total, 14 issues are still open and 31 have been fixed so far.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 378206  Yes   WARNING in __folio_mark_dirty (2)
                  https://syzkaller.appspot.com/bug?extid=e14d6cd6ec241f507ba7
<2> 6347    Yes   WARNING: locking bug in gfs2_fill_super
                  https://syzkaller.appspot.com/bug?extid=ee157488ade46c021ef4
<3> 1305    Yes   kernel BUG in gfs2_glock_nq (2)
                  https://syzkaller.appspot.com/bug?extid=70f4e455dee59ab40c80
<4> 729     No    possible deadlock in do_qc
                  https://syzkaller.appspot.com/bug?extid=8ef337b733667f9a7ec8
<5> 115     Yes   INFO: task hung in __gfs2_lookup
                  https://syzkaller.appspot.com/bug?extid=8a86bdd8c524e46ff97a
<6> 102     Yes   KASAN: stack-out-of-bounds Read in gfs2_dump_glock
                  https://syzkaller.appspot.com/bug?extid=7efd59a5a532c57037e6
<7> 24      Yes   INFO: task hung in gfs2_glock_nq
                  https://syzkaller.appspot.com/bug?extid=dbb72d38131e90dc1f66
<8> 14      Yes   WARNING in gfs2_check_blk_type (2)
                  https://syzkaller.appspot.com/bug?extid=26e96d7e92eed8a21405

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

