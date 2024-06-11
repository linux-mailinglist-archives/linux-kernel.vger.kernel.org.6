Return-Path: <linux-kernel+bounces-209471-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BF863903661
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 10:27:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 684361F2803B
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 08:27:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D544C174EE4;
	Tue, 11 Jun 2024 08:27:28 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CF5C16F8EC
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 08:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718094448; cv=none; b=VaqsekrO0cGmJXvwhTor5THU6q1qyK5nZrSyWaKGijhOhYjtSbRIdC4EEZv/PuseasF/L/5i2Ml2cdtIKLkA/vHJIOq1OSeQCA8ReOdluwSJ4wtA453LHDYrEYPDPVcYUQE/TkmnW+ne2vB7CulSkEHA69Nz+T0xMg5y3uV3+zQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718094448; c=relaxed/simple;
	bh=8TKl4byl/TZqU5svFESKSIBLf746Pq2tKxP5Geq3cu8=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=mfozTOx/rDDTzN+OcudsCCQANcbQE5BzAkB1TzRK0QJ+wgPifBbsI4UFEQ6ytYe8l4ZEX3VaBmbF5Zg6G4054AeAID86/YqgPFqZg3qg/frbYeKSxeRbrsOYZbaGl2aKzAHSVhrHW+6vOvzwDkXjMpiAzKOKFnejiQYxKfthXCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7eb50e42c6aso586830739f.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 01:27:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718094446; x=1718699246;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=e1uBULGiq/dLBXfkwxWBRdkcw0uIjnak6allGPE5n/g=;
        b=gHlUJOfhkCrdTOWim9wyikdkvl4MOt/dG/ycp1zUPGkwE7hfwSE3UtXivlKD5FB5TV
         Tb51t/f3su1KgabwkS+7rMvfib0u2ERwJ9+KKAG0uwJEeSmCXmC4RtzBHFOqW8Wld4gP
         jBKQwTZRhZ/Z7D8kWKMUx1aE0PpMdJA9j1/lwHIxSb/y7ZL3G2PlNqSLnuiQlq1p77EF
         mefvweFAtsRGZUnNajJxVu6ZRKvYTnyriDS1wWMhQB2cGM8+EUL7NhQyGIkFC2GxHKOV
         VrdydGXgRvth8hC4Dw1hR/eH3uMmMosxosW3X1ApAiZrliRDedbRNWkJ9zPZ7HnnbQT/
         31jA==
X-Forwarded-Encrypted: i=1; AJvYcCWJxai8A6Yqabfi2xRVIejLYeNCsQk49Kb8IzKQcXKHdvQ6vWMyUeuAbt5U20B71zK630LlccJeRL3HZsBjyAt3m0DdhlxpWGdBmyQn
X-Gm-Message-State: AOJu0YxXXjT7vMRv/jRzpdohlUYUFRaTrkI8ckfLq/xV+j1J1YR7lyPm
	8Xbn9h2Iv58K+L2bbeD4WfWo02JzOM5MGYwSw95CTvpfT0CcTVQc54nvJ628nWdy+yuz4omp71n
	eg5CFfVvBcv6/aGq8vNtfe2D/JVWwm7wPtKqSP490nq2Ox5D1lQIn9Ps=
X-Google-Smtp-Source: AGHT+IG99Gmf8lLMHXk6xxQi08jlUfn70kvOE408p88hIuXZfC+rG/hLfY4mqmHu2rNwoMzE8jqDPyiGGzEOalcgzjFux/h5u3Ac
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:6c10:b0:7eb:99c1:372d with SMTP id
 ca18e2360f4ac-7eb99c13c48mr9734039f.0.1718094446256; Tue, 11 Jun 2024
 01:27:26 -0700 (PDT)
Date: Tue, 11 Jun 2024 01:27:26 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000028f310061a990905@google.com>
Subject: [syzbot] Monthly jfs report (Jun 2024)
From: syzbot <syzbot+list5d6661b816d5f1356109@syzkaller.appspotmail.com>
To: jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
	shaggy@kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello jfs maintainers/developers,

This is a 31-day syzbot report for the jfs subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/jfs

During the period, 5 new issues were detected and 0 were fixed.
In total, 42 issues are still open and 39 have been fixed so far.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  7179    Yes   kernel BUG in jfs_evict_inode
                   https://syzkaller.appspot.com/bug?extid=9c0c58ea2e4887ab502e
<2>  3896    Yes   kernel BUG in txUnlock
                   https://syzkaller.appspot.com/bug?extid=a63afa301d1258d09267
<3>  2955    Yes   general protection fault in lmLogSync (2)
                   https://syzkaller.appspot.com/bug?extid=e14b1036481911ae4d77
<4>  2307    Yes   WARNING in dbAdjTree
                   https://syzkaller.appspot.com/bug?extid=ab18fa9c959320611727
<5>  2043    Yes   general protection fault in write_special_inodes
                   https://syzkaller.appspot.com/bug?extid=c732e285f8fc38d15916
<6>  1185    Yes   INFO: task hung in lock_metapage
                   https://syzkaller.appspot.com/bug?extid=1d84a1682e4673d5c4fb
<7>  1029    Yes   kernel BUG in dbFindLeaf
                   https://syzkaller.appspot.com/bug?extid=dcea2548c903300a400e
<8>  796     Yes   KASAN: user-memory-access Write in __destroy_inode
                   https://syzkaller.appspot.com/bug?extid=dcc068159182a4c31ca3
<9>  664     Yes   general protection fault in jfs_flush_journal
                   https://syzkaller.appspot.com/bug?extid=194bfe3476f96782c0b6
<10> 386     Yes   UBSAN: shift-out-of-bounds in dbSplit (2)
                   https://syzkaller.appspot.com/bug?extid=b5ca8a249162c4b9a7d0

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

