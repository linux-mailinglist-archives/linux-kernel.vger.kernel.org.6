Return-Path: <linux-kernel+bounces-284785-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A82FA95051C
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 14:35:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA8441C229C1
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 12:35:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8596D19B3FF;
	Tue, 13 Aug 2024 12:33:28 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A94261993A3
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 12:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723552408; cv=none; b=YdIIBx1piXLCm+pmL3/2TytlbM85VKGAguQMjF1IlXwP7Vqa3a5boYOv1nOk7ewhQKldeKdWBviAGWglXUV/FdzXI0A9WdwH1Gjvy+YpCoMjTBQauhTkN1Riq9wcHY427z/RGZ0boVGEBZXakhUoEvokfN43ZW1jf4YNLV465Bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723552408; c=relaxed/simple;
	bh=/oWso4dP3JPRs61+PohQEWF2wq6iHo+TIScLnTuhTRk=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=R7QbzJR6XfZFmnohF2745kiy5Z8xRhJICW0mc3MFxB1OFrpYgVUdFVFLfGBZvW+/L1i6vjeEYosdamn3HYwPVXH3h4gYO4bsP+NkCXr2SmewTMTfwSdZG6P9xpKoUBx6h0MniBdNUfmGZT6+8Cm0UFFNMPfIvwx6n6uKff8juFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-39b3cd1813aso66572195ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 05:33:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723552406; x=1724157206;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zumTife/MYtH/oqkk+FIrK9WbXDIWeEdMMGqqJjzQyg=;
        b=DC6J0YW3NbpzzZFAPbwtbDVgoWBeKpDIg0tGli1ILYGPvtEUFC7SGsJbAf1cTCc3SN
         KWJWratDvipCCgBT0mLovRmbRSdnl0mxurthrDxp9szPHnbvbnTi47BxDkrIvDMPisGK
         dwpvRNIymNVPZ4O2jDY0mkDmgGblspfUbUpyqh7GvDSZcKq798PHD3rD0qI+puKSiQWr
         L0s9IeCODJ2bFqqGt08MDNQbgU3T0Zi65r0XfYiBecFktpqzTaY9acITImk87fqveAFx
         2T65NDNharJUiAng8f8Z0hY8OcM63+ZCU02AsRAz4/2vgILn6kiyts+27uinaKP1ZfdW
         JY3g==
X-Forwarded-Encrypted: i=1; AJvYcCVOXXczOO2ywNi2Kd8B8til4yVEvlfXOQtflVOy74PzdFzy+9CBg4xE/g8YyWUOsv4Fg7eysmhJfsGFh52VwwnIzm4cjx6BavB0QCJC
X-Gm-Message-State: AOJu0Ywxnd7h1GBz8VMn6TT2E4wV+rrQwkCHDWg5GSrrUWBno9RkNV4e
	+PYPhnSQJ1yppXHumX0/ILYQoJRBKN4Md2yF7gly4ShxZ30HLcsAFYqWZEAAq09ijpidNLPvemX
	42NxRnWBQasqc3mpHGKMwKTE7Ksg/muUnlvbYgCWZ7EoakcnwNVpf4NU=
X-Google-Smtp-Source: AGHT+IGwX6UpUOoK1LFNQCpjSnGHTGqn2HfJRGcBsGmcaQC/efFUpfBpULnKFPn2kRf9jGMsQNV4F2t8o7xFjACcxUODgCc3VGY1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:340d:b0:39d:1144:e784 with SMTP id
 e9e14a558f8ab-39d1144e879mr165395ab.4.1723552405894; Tue, 13 Aug 2024
 05:33:25 -0700 (PDT)
Date: Tue, 13 Aug 2024 05:33:25 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e7ca54061f8fd04a@google.com>
Subject: [syzbot] Monthly bluetooth report (Aug 2024)
From: syzbot <syzbot+list4ec0f2690ef1e1e5b1e4@syzkaller.appspotmail.com>
To: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	luiz.dentz@gmail.com, marcel@holtmann.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello bluetooth maintainers/developers,

This is a 31-day syzbot report for the bluetooth subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/bluetooth

During the period, 5 new issues were detected and 0 were fixed.
In total, 53 issues are still open and 69 have been fixed so far.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  22077   Yes   possible deadlock in rfcomm_sk_state_change
                   https://syzkaller.appspot.com/bug?extid=d7ce59b06b3eb14fd218
<2>  13222   Yes   possible deadlock in rfcomm_dlc_exists
                   https://syzkaller.appspot.com/bug?extid=b69a625d06e8ece26415
<3>  5615    Yes   WARNING in hci_conn_timeout
                   https://syzkaller.appspot.com/bug?extid=2446dd3cb07277388db6
<4>  3578    Yes   WARNING in call_timer_fn
                   https://syzkaller.appspot.com/bug?extid=6fb78d577e89e69602f9
<5>  276     Yes   general protection fault in lock_sock_nested
                   https://syzkaller.appspot.com/bug?extid=d3ccfb78a0dc16ffebe3
<6>  259     Yes   KASAN: slab-use-after-free Write in sco_sock_timeout
                   https://syzkaller.appspot.com/bug?extid=4c0d0c4cde787116d465
<7>  130     Yes   KASAN: slab-use-after-free Read in skb_release_head_state
                   https://syzkaller.appspot.com/bug?extid=d863bc2d28ef7ff42984
<8>  100     Yes   BUG: sleeping function called from invalid context in hci_le_create_big_complete_evt
                   https://syzkaller.appspot.com/bug?extid=2fb0835e0c9cefc34614
<9>  76      Yes   KASAN: slab-use-after-free Write in sco_conn_del
                   https://syzkaller.appspot.com/bug?extid=6b9277cad941daf126a2
<10> 72      Yes   KASAN: slab-use-after-free Read in l2cap_recv_frame
                   https://syzkaller.appspot.com/bug?extid=5c915dc5dd417b83b348

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

