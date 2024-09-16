Return-Path: <linux-kernel+bounces-330652-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 295F297A250
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 14:28:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58D6D1C237EE
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 12:28:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 528F515747D;
	Mon, 16 Sep 2024 12:28:32 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C018156F20
	for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 12:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726489712; cv=none; b=p/xQ5XqN48jy2YRFeKqXEcsng/IYkLYhwZTssW3DGw3eRvJAkdKVAsXaLbjBwth+G9GYTUTdrm2MDMDUujnq8pztwMHMei/NBNhqChruj7oX2ppaAHxf2SPYnq0Tqxr823jm6bVk4D3ou0RNrjwbbK2uQdkeYmkVPiUzYOpkpe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726489712; c=relaxed/simple;
	bh=HUQ/oaooT1uutHmy2PBayAzikmIrgs3Dh6odPcWpgV0=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=SrLzL1rLz7eM2XptWYIYadevcG0sUfoHRtU5J/1CgzSq/oM2tWb0bGIlLcwOFRrbum7kvV2uT94clqWE4LrHricBD87XbTTQ0ZZIqfjvaYsYAVArQTzWRMuASv23dgfKZWHCI60oTrpFLsEdZSghi7dZcsaGB+2YhPi/Y9OnW2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a0987c35f2so42803345ab.2
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 05:28:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726489709; x=1727094509;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ud8circs9NHEw7Sd104SuPa7vZkeJylkTkKnEC5Z6rA=;
        b=RBLbZgrLYWfXH6qBdqdj7oAvsabvRhA5o0a8sJ8YLyMKzR43G6d5VMxPa53DAUofEd
         TNJacmEm8lJMAjyPYF1OrMGWMcpYhQPR8Jv9jmbcORb9AEItoU2ItUdy57jRhXKfAPV7
         EJGS2L2OsYEVjtqDV3L/34H/FoSrVEiLwYg9rNheIpZ1lruHG+Na+AL+8O5Xy6J1l/Fg
         2q+ow15E128l8NrMjfrpjYM7FL7Vvz80ic8EgnTrETK6o7z1j/k4Dy9gPaP8oKMdq2rC
         st7CiImeiWp2gjieGyPfbd2ZkMNVVsUeWIbvIQNx6gp629my1AbW/xJj6xtDWK9nzu5d
         X12A==
X-Gm-Message-State: AOJu0YwEPCQQAoUZdOtTDNfiY7lhQQ1ei4bGAq9WnmN0DQ96/2trgbg4
	SpukONxpoWTNdlY6pAbR60IBxC4+30oTeSkXntR9u5wjog5z+NkUzqphMQeMK/dBWVxiBz7A0RI
	XZgSARbwzQ6qO1iFMRH9a+XLjPWUiERfDWH0YX6TgKt/5plZTvnrKrIg=
X-Google-Smtp-Source: AGHT+IGA5tV7O+DipJTb6tgN4VX6mK8hIi2m7drczS0Bx/JR7m2jb4qjrrI9smnv3RTNMFZDAsFghI2h391CWMYZRm2zVzyjxwFL
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:12e7:b0:3a0:8eb3:5160 with SMTP id
 e9e14a558f8ab-3a08eb35230mr74124375ab.11.1726489709658; Mon, 16 Sep 2024
 05:28:29 -0700 (PDT)
Date: Mon, 16 Sep 2024 05:28:29 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000da65ef06223bb50b@google.com>
Subject: [syzbot] Monthly media report (Sep 2024)
From: syzbot <syzbot+list30593f6a47f0ceae7cd4@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello media maintainers/developers,

This is a 31-day syzbot report for the media subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/media

During the period, 2 new issues were detected and 0 were fixed.
In total, 17 issues are still open and 85 have been fixed so far.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  874     Yes   general protection fault in ir_raw_event_store_with_filter
                   https://syzkaller.appspot.com/bug?extid=34008406ee9a31b13c73
<2>  435     Yes   KASAN: use-after-free Read in v4l2_fh_init
                   https://syzkaller.appspot.com/bug?extid=c025d34b8eaa54c571b8
<3>  168     Yes   KASAN: use-after-free Read in v4l2_fh_open
                   https://syzkaller.appspot.com/bug?extid=b2391895514ed9ef4a8e
<4>  116     Yes   WARNING in usb_free_urb
                   https://syzkaller.appspot.com/bug?extid=b466336413a1fba398a5
<5>  114     No    INFO: rcu detected stall in dvb_usb_read_remote_control (2)
                   https://syzkaller.appspot.com/bug?extid=01926e7756f51c12b6a3
<6>  94      Yes   WARNING in smsusb_start_streaming/usb_submit_urb
                   https://syzkaller.appspot.com/bug?extid=12002a39b8c60510f8fb
<7>  51      Yes   KASAN: use-after-free Read in em28xx_init_extension (2)
                   https://syzkaller.appspot.com/bug?extid=99d6c66dbbc484f50e1c
<8>  47      Yes   WARNING in smsusb_init_device/usb_submit_urb
                   https://syzkaller.appspot.com/bug?extid=85e3ddbf0ddbfbc85f1e
<9>  30      No    WARNING in call_s_stream
                   https://syzkaller.appspot.com/bug?extid=5bcd7c809d365e14c4df
<10> 4       No    KASAN: slab-use-after-free Read in em28xx_release_resources
                   https://syzkaller.appspot.com/bug?extid=16062f26c6480975e5ed

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

