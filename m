Return-Path: <linux-kernel+bounces-521509-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6615A3BE48
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 13:37:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D52C3B8DFC
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 12:35:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC7201E32A0;
	Wed, 19 Feb 2025 12:35:24 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA7AF1DF974
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 12:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739968524; cv=none; b=GKNw0OcMnMqrjyh9MsR7b/DIIAxchpGswPFTQG3NO9FB8CSunnDHk1m1cK4Pmy9MTNaw9acsEO5zSY79GzIdeC/GADppWoffFddlRR1/F1w9eEwdH3LGJwvIzfiRHJ1mgqYJYQcWx+9kC3bDXciO1VnHT3gY64mE4K0RmnBDS+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739968524; c=relaxed/simple;
	bh=H8WSfdMhCzODixO0N46zNE3HNQO4o5GqoPy3m9Dy6IE=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=hBjw2l6IKzYOqQ0SWrvGuUHO6M6NzedO+bgtJMa5mJbyp+KWhRyjd5DkVMakNeRryyogLpnYfOoQmOMbLLjSoDFIJ8ETeOGSGHKR0G92ESlzNZzKx842+m7PDppp/bO5Yv2nJvBsRXLXPkV5wIDrxzj0PDbWzxXW1JRNTZa0yLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3ce7a0ec1easo45041605ab.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 04:35:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739968522; x=1740573322;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=W3h9YooYDexOFP94Bc3VihIouRy9Jayl7zYY5ED2IeU=;
        b=WF/lgWk5kUOcYLSlZLvDgH+srAco7Tzee3Qq3LCMPNSHs8EQU+R3HAvfnJ4b7I7jJS
         wKaAopt28rmKkTrJJICP+P3oJ37h+LxgKguwlpPvcML9r6DIgZ2pH71ouiCF1Kl/xm27
         I25M+KUIMNfUdMvPgvlllMLFCggH264adAbAVJgWHIu7yz8DylVwR678b+SQeuzDwijw
         h5gMeOiuHpQpMRfVzqfz8bsniMQSRKpjg/zUZVZHP1IH3rM7EmVd6aSjs695iRN78lM9
         CbZGO1tMBvwbg5+k0oUuQvZo8CWg6/bqRuXftXXOZR+DV8+RrKWoNRgYfpRiuVZLWqXu
         xL7Q==
X-Forwarded-Encrypted: i=1; AJvYcCXVhoXlS5hnBSmRe4vrilS67Pd4Sh7m9ZXKBJe2LRnmobspdpjtCPCqAYQYK7cTSpJiwXxSSljiBnY2Y5Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+RfgovSm3uIurVygP926GFvvIlq/D8PLqp11ADoNWcgoEy8rs
	9uKWMYfc6s9iqJe/F+ofKPMahrS94UXnYECNQSWtgVR6l5CzWc+166fRWzBGXmIjHmluzIxjr/w
	xnfhDva3B4S4J3wHcrWCDk2BrTrgUyRdfNgiGXIO/lm43IGLCy0jSHHI=
X-Google-Smtp-Source: AGHT+IHimSMAcs9ES8NnkWh433r8l65BzaQeou83CmrUP1d4GC9JuL33cc/XrPFpgmOEudJ7wNtrAlJlHvtoLl8Zzc7lf+PVq/X0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a03:b0:3cf:bbb4:f1e with SMTP id
 e9e14a558f8ab-3d28079040bmr162268515ab.7.1739968522035; Wed, 19 Feb 2025
 04:35:22 -0800 (PST)
Date: Wed, 19 Feb 2025 04:35:22 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67b5d00a.050a0220.14d86d.00e5.GAE@google.com>
Subject: [syzbot] Monthly udf report (Feb 2025)
From: syzbot <syzbot+listdfa7b5c14341dccb5f72@syzkaller.appspotmail.com>
To: jack@suse.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello udf maintainers/developers,

This is a 31-day syzbot report for the udf subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/udf

During the period, 2 new issues were detected and 0 were fixed.
In total, 8 issues are still open and 34 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 8481    Yes   WARNING in udf_truncate_extents
                  https://syzkaller.appspot.com/bug?extid=43fc5ba6dcb33e3261ca
<2> 929     Yes   WARNING in __udf_add_aext (3)
                  https://syzkaller.appspot.com/bug?extid=799a0e744ac47f928024
<3> 201     Yes   possible deadlock in udf_free_blocks
                  https://syzkaller.appspot.com/bug?extid=d472c32c5dd4cd2fb5c5
<4> 31      Yes   WARNING in udf_setsize (2)
                  https://syzkaller.appspot.com/bug?extid=db6df8c0f578bc11e50e

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

