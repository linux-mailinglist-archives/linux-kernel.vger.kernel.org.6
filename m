Return-Path: <linux-kernel+bounces-412766-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 594F69D0EBE
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 11:39:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1429228249E
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 10:39:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9932194A63;
	Mon, 18 Nov 2024 10:39:28 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 270AA19413C
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 10:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731926368; cv=none; b=tYUC7s7IShQYWvxa/NhX7B9ZtVygf2tOhNkhv49xR01Nbo4nq1iXLk1vovk+A/lJHJKdPCi2FJiCo8ASfT4am8AlLGuWH0CBwPCdwwC3QCecCI6atqLTOkkrugMFKri9ZrwVhSyvTjtgn/ClLHxe+jpjsDk7/6F6wGc+U+ULbaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731926368; c=relaxed/simple;
	bh=sTY3rxlQlY7YJPCIsi9efDDUlBqdfBx94TxnCEBIHqE=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=nNYmI3jpcEa0RpC2dY+glYDbNHqOIjt2q0J/qW0TMG/MOvxppS58B5/Erz7EEq903/BaoSIDrhLPMZbwURhM7ZLYvhF/qBJW/PbFJDFSiBEZT5KQOgTtchRgH/QU57lHMolOgiHkfJhhxvG7SLp1WFnxN8F4LTCACFyGnXOAW20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a76acda477so6975945ab.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 02:39:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731926366; x=1732531166;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mVn2u5oUPr66sOA25SXRkEEpzy3n/y25I2a4J8SaNg4=;
        b=Ytt5Jj2GvTcmTwF+7QROu5X6wxuhP2+QqxooGAe7Ey9vFmT+8Cqyj2NgmAWOynB17Y
         zKoBq4z2sZFJsNKIBC4DK4yMpTcu7p5YxoRctSKEGedm0JSbmI705dwQoqZDO0HG1C4y
         L9CWTTGmK1LeCtv08JydX5Gic8cA5Of/hUyLyrgwe/KouaaZ49rJ9IXie+JRFt74QPcQ
         db48F2EKU0zu6XHSTIY39mgA8DxFKaf5wt0s/3yN/+e9cq6ejQ84QtC1pVUJr7yQcxa1
         h9eie+MROROPo5HZsRchnC1K5KXfmb9jEPob1SryRR8TEhskKvX6elsgLfseauPAUr4D
         5Kbw==
X-Forwarded-Encrypted: i=1; AJvYcCXb1bVC8JjaZ4wukj8u8eVrDfDxPlE4rhP/XiZ0U4L4nfK0D4oSpm81jex5ZAdjJnkJ4+QT5nUaGLd2hDc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqpRSo1O7fifj9S1O2awERrM9UdiX4IMHJ0hZ2QstvY8Slo0qf
	EQN9/fL/VYi4i+ug4pVbBuUFm8pRuXSH5EYXW1TcC1ysmdZEIXRt/xMyAlKnFPTESyjYi51KK1Q
	d233cJ7JCiihZ3yLj622KusPxukKZCDqxxIQIikmja8KbAs5L8JNdME0=
X-Google-Smtp-Source: AGHT+IFKz2kcQ2GMYbmeuChfai54VBlDRj0Vhy1RWbTJmdGt/msX3TPP/fTcoVlSEoFKtBqNrwQzZYcm8ITqkmBZmehDGn9zQL7u
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:cda3:0:b0:3a4:ec4b:92f0 with SMTP id
 e9e14a558f8ab-3a748077de2mr110799425ab.19.1731926366325; Mon, 18 Nov 2024
 02:39:26 -0800 (PST)
Date: Mon, 18 Nov 2024 02:39:26 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <673b195e.050a0220.87769.002f.GAE@google.com>
Subject: [syzbot] Monthly ext4 report (Nov 2024)
From: syzbot <syzbot+listd65c4312778884cf560a@syzkaller.appspotmail.com>
To: linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello ext4 maintainers/developers,

This is a 31-day syzbot report for the ext4 subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/ext4

During the period, 5 new issues were detected and 0 were fixed.
In total, 42 issues are still open and 147 have already been fixed.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  9746    Yes   possible deadlock in dqget
                   https://syzkaller.appspot.com/bug?extid=6e493c165d26d6fcbf72
<2>  1883    Yes   INFO: task hung in sync_inodes_sb (5)
                   https://syzkaller.appspot.com/bug?extid=30476ec1b6dc84471133
<3>  1574    Yes   kernel BUG in ext4_do_writepages
                   https://syzkaller.appspot.com/bug?extid=d1da16f03614058fdc48
<4>  1549    Yes   INFO: task hung in jbd2_journal_commit_transaction (5)
                   https://syzkaller.appspot.com/bug?extid=3071bdd0a9953bc0d177
<5>  910     Yes   WARNING: locking bug in ext4_ioctl
                   https://syzkaller.appspot.com/bug?extid=a3c8e9ac9f9d77240afd
<6>  845     Yes   WARNING: locking bug in __ext4_ioctl
                   https://syzkaller.appspot.com/bug?extid=a537ff48a9cb940d314c
<7>  306     Yes   KASAN: out-of-bounds Read in ext4_xattr_set_entry
                   https://syzkaller.appspot.com/bug?extid=f792df426ff0f5ceb8d1
<8>  109     Yes   KMSAN: uninit-value in aes_encrypt (5)
                   https://syzkaller.appspot.com/bug?extid=aeb14e2539ffb6d21130
<9>  70      No    KCSAN: data-race in generic_buffers_fsync_noflush / writeback_single_inode (3)
                   https://syzkaller.appspot.com/bug?extid=35257a2200785ea628f5
<10> 54      Yes   INFO: rcu detected stall in sys_pselect6 (2)
                   https://syzkaller.appspot.com/bug?extid=310c88228172bcf54bef

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

