Return-Path: <linux-kernel+bounces-240678-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 792049270E7
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 09:49:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 233B01F22E10
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 07:49:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 398511A38F2;
	Thu,  4 Jul 2024 07:49:28 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6753C1A0B07
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 07:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720079367; cv=none; b=EPRpOaPkvDwizjyYPLWwFoy91voQ3k0ddjfXdZ7SHamNaqjQl/gmZFagYRQu5UpFBkWsKrFn+3Ly0AoCrg1mTJdciCyV3XHDqcf0lh0qA5xjNsj6/TRlOPpAk9JZUkIcpLEZpOYeHZ8V3YMZZXcCwZs3ZKo/LXwvHs671+LDSYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720079367; c=relaxed/simple;
	bh=EnNRo7YyZ1xQ+CMWi0DEEDmZzM5z18k1m1vd/CI/CaE=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Fo7HNTdc3cKW/frvcurifCZAzYMrB47unN8867lhVI996rQuqi4IgfjPWWcHs3vTBfr6nQxwvYl2YMrWrX62IYjWi+4rXRLFGBEHnYMcF1L8NmJzD6OZ41iYUeNE8fgHq3Ctlv4LC7arzZMqEiTH7n4fvzC4ZKbb/hcO9GChcSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-377150fb943so4604005ab.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jul 2024 00:49:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720079365; x=1720684165;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CESjReMpw9UUZWiMl1S2EfqE+jINbArnlNEMrzlMIIQ=;
        b=mBXM9mk5mcHt9kwthsHsCv25BgsMTfbZZc25w7nE2GCbmPzlk2ZKeQcQk6XKUoHwgo
         VnKIcTlhNuAV5emoBit1eBeFOoPbl1c0QKq2s39cPG6yjUywXe/SlLoKxmfT2l6XAb11
         uh/vcDKUd0AyxmbFfesV09KKa8Fr4quaPRYJwZ9y2O7UMTxbgMbURMeJgrA8zbo/rCXE
         jyufXypPnlWeIi9KxCJy08W3o8x8VRFNwBqKA+kdde74SJPV/bnx+G43PCSyADhXby3X
         KsVm9rv5Sp3nbl93RZSlNAeyRCHxsTp0PXxqPyCrD5vHNdwZoeMHLRc8PDYalmGXyefd
         W/mg==
X-Forwarded-Encrypted: i=1; AJvYcCXNkK7XjKJDWntobCc8vVwtEYBx6vEf6WhEl8+IW1KO3skUla0wi8RiEwVj0BAAs6oRx9fdh6Ro0sTqmoXM4jwQq0Tujrj0PVAaWJ10
X-Gm-Message-State: AOJu0YyH6w7k1Orhrq4x0vyWcND15JJ1H+5ZmdkrHpVyiPGt/KRC9xV/
	W29/itZgXK+mNvFwPMQ6H6qS773esWpGxHzjqwc7QeMIM1Y3IBhYbPNW+G7Pc6v/uZMe0lZ9SxN
	RwBzr6oVEPeQ5u0uA3Q0AvSllTLq3dmiOkhjN8+SljBzxIu9K8MNjt7U=
X-Google-Smtp-Source: AGHT+IHslujarCjx8vMDA/mHyCkCzDO6dHYu/JDiYkgzwH7xDCwLMC/dgOQOzT7wGhZQf683n8H/R/Xfz7pc5ktVNhBXOJd8vTMX
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:10c4:b0:376:46d5:6583 with SMTP id
 e9e14a558f8ab-3839b37d8c7mr157225ab.5.1720079365458; Thu, 04 Jul 2024
 00:49:25 -0700 (PDT)
Date: Thu, 04 Jul 2024 00:49:25 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009059a6061c672f4d@google.com>
Subject: [syzbot] Monthly wireguard report (Jul 2024)
From: syzbot <syzbot+list3f44d498ace31a0c4fcf@syzkaller.appspotmail.com>
To: Jason@zx2c4.com, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, wireguard@lists.zx2c4.com
Content-Type: text/plain; charset="UTF-8"

Hello wireguard maintainers/developers,

This is a 31-day syzbot report for the wireguard subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/wireguard

During the period, 0 new issues were detected and 2 were fixed.
In total, 8 issues are still open and 18 have been fixed so far.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 1009    No    KCSAN: data-race in wg_packet_send_staged_packets / wg_packet_send_staged_packets (3)
                  https://syzkaller.appspot.com/bug?extid=6ba34f16b98fe40daef1
<2> 59      No    INFO: task hung in __tun_chr_ioctl (6)
                  https://syzkaller.appspot.com/bug?extid=26c7b4c3afe5450b3e15
<3> 14      No    WARNING in kthread_unpark (2)
                  https://syzkaller.appspot.com/bug?extid=943d34fa3cf2191e3068

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

