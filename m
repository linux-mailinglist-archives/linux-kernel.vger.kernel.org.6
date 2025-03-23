Return-Path: <linux-kernel+bounces-572710-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0943EA6CDA7
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Mar 2025 03:21:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E5C8174B32
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Mar 2025 02:21:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDEFA1FFC52;
	Sun, 23 Mar 2025 02:21:25 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AAF32E337D
	for <linux-kernel@vger.kernel.org>; Sun, 23 Mar 2025 02:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742696485; cv=none; b=r9UAepaScaDaSDOs1UXh/c0r+LNETi/k4CKYnNqS23bfr7dZufprLonV73YnZX4GosZhiA3XGH9H7ik70uu4lyUqGtV487y8VafAsia03NHAxBf4mCzfp+3Eie6q/MH8hxBHRwj8ngy2TOlp6yQkEHxpSXBlkv7ujQfyjHwgYrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742696485; c=relaxed/simple;
	bh=payBoODu4Z+o5BOpV7vJRgvDVpOxM6iRaCtViVXojxw=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=XxtMTOoZx1pkTA3BEq7uHChs+RqbpEf96iTkST974q0lmgK5pjKk4q6iAN7/JXn0/bhpep2lXAdCruvXpnvpj/3mI7a2gt6kB1AoECPij9DhmA5BNtT3K7Q2RuFlDQZcSPobBrjFCNN/9gejpqsJZEd+axdOyc/THK1z+oD2bPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-85e0c6b90e0so609767739f.0
        for <linux-kernel@vger.kernel.org>; Sat, 22 Mar 2025 19:21:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742696483; x=1743301283;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=r6WPg3K1iaPQvdeNdYQI5xrA6e7Il6kAh/rOAOSzPKY=;
        b=OZlSrYQ+Qp9OZ5AxIvA/KNll8Wgxk+hqaIO1fNuE/FFr+F6um+X1xcE7JDy+j0SASi
         yGUeVQsD7JEBDco+hu5dzKzWe3V3xVFL/MmXcGK6Cp/QZ7sS4XRx44A/IUWF9fUKWPQn
         hzRgyJ5bA7Tk5O/RpTEuW7Nvo5UrEGcOTU2RTRxNHLbDZaIcoKsgdtuQzPGGxo3+R02P
         29ZsMbLRERqEFazgoAT3JDhJUP793EnHwgXZw2twLUGHz1R0S1jWu0RNhNlZZAk6OmCH
         lVCJAz1+QdQFqzYX6mrSm9hxMNmEjoX+bQLb34v8BFWZnElXk4LH22cVA6DTPv0HEuM/
         4keA==
X-Gm-Message-State: AOJu0Yyy4TWmRHgjeRdPzJ8fwqloRiO2jv1MgOiqDfLsVW/7lVcNLwuC
	bw5jhySDXTuBvKFKxNw3Y9oi18ySKBE4S+ZlfnjL4xTI8MNKQIzkfIXu0ijJGeYtUUcyb4+HE0E
	nw8to5CKbfvx+aRBGnayVPvO2I7COWEmY8kUdgJkutYhznVpDATe+Mpk=
X-Google-Smtp-Source: AGHT+IFJn47ZO5WuVvZHcuSqL2Kv6zkedQfOwcy1K6a8DcQdcjMMKyBMmGwvtDiosR0r6plB7xKL9enIh9eekZ05QZP6bZwRwjpK
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a48:b0:3d4:3c21:ba71 with SMTP id
 e9e14a558f8ab-3d5961b1bbdmr100778675ab.18.1742696483257; Sat, 22 Mar 2025
 19:21:23 -0700 (PDT)
Date: Sat, 22 Mar 2025 19:21:23 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67df7023.050a0220.31a16b.0050.GAE@google.com>
Subject: [syzbot] Monthly media report (Mar 2025)
From: syzbot <syzbot+list284630d0b66c5609feb3@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello media maintainers/developers,

This is a 31-day syzbot report for the media subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/media

During the period, 2 new issues were detected and 0 were fixed.
In total, 23 issues are still open and 91 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 611     Yes   WARNING in usb_free_urb
                  https://syzkaller.appspot.com/bug?extid=b466336413a1fba398a5
<2> 246     No    KASAN: slab-use-after-free Read in em28xx_release_resources
                  https://syzkaller.appspot.com/bug?extid=16062f26c6480975e5ed
<3> 220     Yes   WARNING in smsusb_init_device/usb_submit_urb
                  https://syzkaller.appspot.com/bug?extid=85e3ddbf0ddbfbc85f1e
<4> 127     Yes   WARNING in smsusb_start_streaming/usb_submit_urb
                  https://syzkaller.appspot.com/bug?extid=12002a39b8c60510f8fb
<5> 100     Yes   KASAN: vmalloc-out-of-bounds Write in tpg_fill_plane_buffer (3)
                  https://syzkaller.appspot.com/bug?extid=365005005522b70a36f2
<6> 35      Yes   KASAN: slab-use-after-free Read in dvb_device_open
                  https://syzkaller.appspot.com/bug?extid=1eb177ecc3943b883f0a
<7> 4       Yes   WARNING in media_create_pad_link (2)
                  https://syzkaller.appspot.com/bug?extid=701fc9cc0cb44e2b0fe9

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

