Return-Path: <linux-kernel+bounces-369331-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 60F249A1BDD
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 09:42:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 17DA91F22E1A
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 07:42:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8163B1CF297;
	Thu, 17 Oct 2024 07:42:31 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E54539FE5
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 07:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729150951; cv=none; b=EaiYqXehIcNTtfdGoZxZ1J2C27ubAWmsGYzakTFoIwZT0t3jUTXP+K8MAlGhTeh53yHa7D67453J/sUP3nNr+wHVSf6trTxaPPcpynDXpon5INWgULeYp3pGS3iLffINuTj1G9+j0Hj+NbVtyU3w57jlGxeNUCePx55MtxDelqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729150951; c=relaxed/simple;
	bh=BuLD5+x5cbfPYKBV0CyeM3VPh5IxCkZ8CyRxJBKEA3Y=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=coxAFBUPifCeg2ew1ShqyvhPawcVJjUQ504eq9HXehxk+FbWAIeTYOEYGzbPW6tM0yEUUgQp0qDX0OnzGev2rwRcA3dOHFjQ8AqLFjlJlp+yO4LkUm9mqxoZRYFXfkYgtQlf+hl6S4YZhcbTudafA+m3K5zrzQgGuc2xvVQmcMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-835470703c9so62740039f.1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 00:42:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729150947; x=1729755747;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5BzJ2W3lFQm5FDwVXLvrOI3VN1AWvCrkY1Q3HXDhIBY=;
        b=QfJO5lYj5d1wW7hvCOCmL4a/QVxdLr8F2WKeEKOrPhYoU84RS6Hb7aFxyP13O8ahVD
         hV+zOmjJaBxKBagILyrhCv6twesfpsN2gNYGCA6r9sLVQVX9ZEyxe2uU5QbhzPP7ewAQ
         AgiIATg4T1rG58zDdAERgegL+RUwdiEZQJ5/NWelDNQ7ganC1GrVW9FXotgwH2aXO2eK
         8dFWbqRi0ShHV/1ImEoX4J2Au7KiOBMEru03VT54ucD7gziFxjj/5kiSY8J2xkPrp+Cj
         GHrEX7LQ37+HXEXa4hc6c2J5FL5ge8lHDWgV+GIMyEsmzA6vrqz1IDBYA6O5DvmXiCW5
         L/Xw==
X-Forwarded-Encrypted: i=1; AJvYcCU6M7TAGLyMJP8nVlEexP5pFWYHlhywe3xsTsZpL0/YiJ2MTneTSUu2MiIg8OpQdJzbI922JKuu+41jBcg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5SjeJCnnvQ+qVcePCX7+7BjyZa5bs4Xi+lVWTExYy/y1hM+7v
	sutW2CU1/jioLnw6Hyy5VvVgEHzAm/oNb2AINds+jyKO8Apjj6oeKH4EbR1IgNs1yVJSpzacrB2
	xzcVBnIl2USxOUGUJ5COppahUh7PnxKcWrINACDgvcWfxLYlYGs+DNXA=
X-Google-Smtp-Source: AGHT+IGAaAAdvjOgJ/FeOgagqORvoc2aHAdnrSHjMDAL8KpAjBfVkhP2U9FD3RtlRdicmRb0w/3FX3qBqdaRQLKqos/FFjDfTZPo
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:154e:b0:835:3ffe:fe31 with SMTP id
 ca18e2360f4ac-83a9468dd86mr714049739f.8.1729150947412; Thu, 17 Oct 2024
 00:42:27 -0700 (PDT)
Date: Thu, 17 Oct 2024 00:42:27 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6710bfe3.050a0220.d5849.0024.GAE@google.com>
Subject: [syzbot] Monthly ext4 report (Oct 2024)
From: syzbot <syzbot+list7024578d089e5b0fc702@syzkaller.appspotmail.com>
To: linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello ext4 maintainers/developers,

This is a 31-day syzbot report for the ext4 subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/ext4

During the period, 8 new issues were detected and 0 were fixed.
In total, 39 issues are still open and 145 have been fixed so far.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  11585   Yes   WARNING: locking bug in ext4_move_extents
                   https://syzkaller.appspot.com/bug?extid=7f4a6f7f7051474e40ad
<2>  3767    Yes   possible deadlock in dqget
                   https://syzkaller.appspot.com/bug?extid=6e493c165d26d6fcbf72
<3>  1711    Yes   INFO: task hung in sync_inodes_sb (5)
                   https://syzkaller.appspot.com/bug?extid=30476ec1b6dc84471133
<4>  1444    Yes   kernel BUG in ext4_do_writepages
                   https://syzkaller.appspot.com/bug?extid=d1da16f03614058fdc48
<5>  1354    Yes   INFO: task hung in jbd2_journal_commit_transaction (5)
                   https://syzkaller.appspot.com/bug?extid=3071bdd0a9953bc0d177
<6>  847     Yes   WARNING: locking bug in ext4_ioctl
                   https://syzkaller.appspot.com/bug?extid=a3c8e9ac9f9d77240afd
<7>  816     Yes   WARNING: locking bug in __ext4_ioctl
                   https://syzkaller.appspot.com/bug?extid=a537ff48a9cb940d314c
<8>  516     No    INFO: task hung in sb_start_write
                   https://syzkaller.appspot.com/bug?extid=fb3ada58a6c0a3208821
<9>  128     No    WARNING in ext4_write_inode (2)
                   https://syzkaller.appspot.com/bug?extid=748cc361874fca7d33cc
<10> 102     Yes   INFO: rcu detected stall in sys_clock_adjtime
                   https://syzkaller.appspot.com/bug?extid=25b7addb06e92c482190

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

