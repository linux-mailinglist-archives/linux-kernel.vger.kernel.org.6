Return-Path: <linux-kernel+bounces-433815-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 804249E5D72
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 18:40:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6FFC9188467E
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 17:40:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AF70226ED4;
	Thu,  5 Dec 2024 17:40:29 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99CAD21CA1F
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 17:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733420429; cv=none; b=pXaaOIQvEqi84vv/2KKGjGerBapVINaW/7jQhqM8nqplg2l1gSYEdC+kWMMMUIXcRRISweJA8Qd1cG088+klLOMLk4BHQJmHDDn/TmXmg9q+92sIAQCrIJvUmL34M92ugACMTHsHXYRJucPN29oMjK4CQVQbCd5dIrV5f1LR0Xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733420429; c=relaxed/simple;
	bh=ckqNK1kFj0hOrtGRecbfTqUnXzQvUTv259nme0vqwJ0=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=dPAPXd8CxPrqjvjAKDUDEvXOWD0znUrWiKlNJv91Dz4YzwMdXOqLJNZZRl6XyWNMB1QaWVQHb2izOb1o5CBsY3XfhudeRtHDoWapDFNE0RQhtT76gV4R9aMQLv8iz1LqQMwqTpZOeEflBECTCUra+mCI0SrB7ZIaaNvRwdTu+8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-841896ec108so181808839f.1
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2024 09:40:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733420425; x=1734025225;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Nai+Q+yfGAvS8Ho7NPZXJwCDRmVEaZXI5r28mNwpuR8=;
        b=NXAABbw02zHTPeON3D05R7duxoRunHQVrPdgAvd3+wBDd8vAz+TjsVb75RtJV/bDD/
         nOGENGAIAiSzzqWcgZSu/hX3cGhnF4FWUVxp5mvtuttCkWatD+FRlbj8DGl3Xc6xwsN3
         //2p17zflrldRogfo0lOAzCBkK3RCh1C2ubZLQkA5tcvgUPXJO4kakw47U39gC+q7L+w
         29D/30wJ6kCQNURyJ1ebQbPYXNOz1wuLSAsbwCakkBCaJ4gOfER3Z8Qp+V6ra0idZ4qH
         KlXOZOuS7TvcbWHjC3bX24N/ljZze8UjokEPa+kFWO+L9ZvlOUu6Ky2zDuNTsdovwobi
         jvBg==
X-Forwarded-Encrypted: i=1; AJvYcCX1nvcecdUs+9JLlG6z2h8UGKLbwxTuoeU8SozmwtoKL4o9+B7+o5MWQ1TkQPJuOVDStSPnZgn+E+Dt8CE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWVDAoCS9xrnMpDOaPXJwe9AeZiLgj9i1TfJKE/bbAFpjURl84
	xmHUiJz8Nn81YbjR49acn+EAqSKzuy18SCWwYdYn5ihjtM7tAy5RQpeMeapporiMIltKTn5nf9P
	XF+FsrTWHaplgqQg4aTYZXm/M2IDEplNdjNpTu0XdCftpPG9dLryk0sI=
X-Google-Smtp-Source: AGHT+IFNSNJODWIXbQ394i760sPr6Swl9ckSzqmuHfxCrUVLJz0zVWAEEbVAdJHq/dCMhu2HIigm8ONaBH4FXzvnb8+lzMbUAPaK
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1448:b0:3a7:e0e6:65a5 with SMTP id
 e9e14a558f8ab-3a811d94896mr2864845ab.6.1733420425764; Thu, 05 Dec 2024
 09:40:25 -0800 (PST)
Date: Thu, 05 Dec 2024 09:40:25 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6751e589.050a0220.b4160.01de.GAE@google.com>
Subject: [syzbot] Monthly can report (Dec 2024)
From: syzbot <syzbot+listef3aa534c94f9b108626@syzkaller.appspotmail.com>
To: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
	mkl@pengutronix.de, netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello can maintainers/developers,

This is a 31-day syzbot report for the can subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/can

During the period, 0 new issues were detected and 0 were fixed.
In total, 5 issues are still open and 53 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 11504   Yes   WARNING: refcount bug in j1939_session_put
                  https://syzkaller.appspot.com/bug?extid=ad601904231505ad6617
<2> 3437    Yes   WARNING: refcount bug in j1939_xtp_rx_cts
                  https://syzkaller.appspot.com/bug?extid=5a1281566cc25c9881e0
<3> 671     Yes   WARNING: refcount bug in get_taint (2)
                  https://syzkaller.appspot.com/bug?extid=72d3b151aacf9fa74455

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

