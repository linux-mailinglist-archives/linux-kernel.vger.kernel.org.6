Return-Path: <linux-kernel+bounces-215964-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 581FB909965
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jun 2024 19:49:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA3962833D1
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jun 2024 17:49:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B2E856477;
	Sat, 15 Jun 2024 17:49:23 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 821F5481B3
	for <linux-kernel@vger.kernel.org>; Sat, 15 Jun 2024 17:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718473762; cv=none; b=B/HRcPLNZHSDLPE1VJv7Ij19rKkv4kFBhLKyEi7dUDO2ZFSWInVCfruFtPoIA0yrt1T+rs/rp+xHaq0bHqN6//dUQ7DL6ucoWhI4et3jD9yFVoQprO/J4VM0BiLtJfTbl0LYkjUytqpiDZ6JmsX4dlTvxqFSJdAqMLEvg2X0VSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718473762; c=relaxed/simple;
	bh=+EDhRoHldebgF04yZiWglRG5ZuFrvxC4n0OrNzbw40Q=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=RwGptT97azhSz2bhF22oAd4I3+JU9ZMT/e5AUN69Rtkh8eC1Zm4b5Pm+9EMhdao74RAtKYAl5uQAIJ/wKy/+UDrBLlO3ZBKvlMeC0eqdcP3+zDckGlZsm/mwOWMhhRVl3+fj1C4g4BrpF6um0LETsVHH2Q7xmYVDtZRa0ui2nlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7eb1d659c76so355980239f.0
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jun 2024 10:49:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718473760; x=1719078560;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FwOOogUZEuVQbzS+0Id+QcOLQ91uBLpbIjT5+M9mmDk=;
        b=Uo6HeWmLiuGaomnVnxM8fMlRYXBQlTtHzkFxvHuDFNctbMnT3VzWHPo9JpB8C0k708
         b1rBmH5wJbnZVXR9veCDhCDXGVp6ee7SYIsHSdUvbveWP89+Dg2GEtT4XByRmVN8ZZlW
         Y0xb/dqLZYUJuBCZE26hiNhdPJObwBiQGw1TdjmvAA9PPMSNnij2WfPUACdLPfpEM7tr
         XXAyC6d2G7UmgU9Ye3rNIVSPl9eh/BUm5ZWxI1ETrmgEDANCPW9lHF7MfqRMI3wY2pSK
         BQ4jhhHMZXgcqG4MBxD3+2I3DHlbAUMEXuLueXDa7LKjDAUeqSe04Y1PfyOKTDHar/Gd
         72ng==
X-Gm-Message-State: AOJu0YzQtZlu/WBr9GY+eenx4tXCb+K00d3kRCsguJPVXPaMMRoYnfnm
	JVeA5LIS7KxbipzKVpSxcE1S+JH5bT38ggpHcgrAErfON5nz8ktcTtMqU2GFJ/JZC+ZPr3wm1rY
	dgH1m2DCQyz5y4z/W78XdtzyLKSKzVDZRBfoCx9wEolQk7I77bYzSZUs=
X-Google-Smtp-Source: AGHT+IFIfdRZMz0USZWNV6GrPfYHmI0ZNh2U6k8AqImUk/kToYKXeEWBtyJmKjojm+OiOXITBkyDqnOiBBMp52nxyYH/x3odMnV2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1389:b0:375:a535:f7bc with SMTP id
 e9e14a558f8ab-375e0c75f5amr3742155ab.0.1718473760571; Sat, 15 Jun 2024
 10:49:20 -0700 (PDT)
Date: Sat, 15 Jun 2024 10:49:20 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000e160b061af15af0@google.com>
Subject: [syzbot] Monthly media report (Jun 2024)
From: syzbot <syzbot+list6ccbddee1ddb6eec879b@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello media maintainers/developers,

This is a 31-day syzbot report for the media subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/media

During the period, 2 new issues were detected and 0 were fixed.
In total, 19 issues are still open and 85 have been fixed so far.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 13428   Yes   possible deadlock in v4l2_ctrl_handler_log_status
                  https://syzkaller.appspot.com/bug?extid=9948f8e188482c5d1a3e
<2> 870     Yes   general protection fault in ir_raw_event_store_with_filter
                  https://syzkaller.appspot.com/bug?extid=34008406ee9a31b13c73
<3> 335     Yes   inconsistent lock state in sync_timeline_debug_remove
                  https://syzkaller.appspot.com/bug?extid=7dcd254b8987a29f6450
<4> 101     Yes   WARNING in media_create_pad_link
                  https://syzkaller.appspot.com/bug?extid=dd320d114deb3f5bb79b
<5> 90      Yes   WARNING in smsusb_start_streaming/usb_submit_urb
                  https://syzkaller.appspot.com/bug?extid=12002a39b8c60510f8fb
<6> 17      No    WARNING in call_s_stream
                  https://syzkaller.appspot.com/bug?extid=5bcd7c809d365e14c4df
<7> 5       Yes   INFO: rcu detected stall in __run_timer_base
                  https://syzkaller.appspot.com/bug?extid=1acbadd9f48eeeacda29
<8> 3       Yes   KASAN: use-after-free Read in em28xx_init_extension (2)
                  https://syzkaller.appspot.com/bug?extid=99d6c66dbbc484f50e1c

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

