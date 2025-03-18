Return-Path: <linux-kernel+bounces-566357-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A8A82A676D6
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 15:51:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED1C219A4493
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 14:50:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D803120E334;
	Tue, 18 Mar 2025 14:49:53 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2EC020E016
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 14:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742309393; cv=none; b=kxTtyqBVUn5+FEP4R9Ar3EwxKJxTU5KPYr5hXrV3dSbrhuHpV8ELSo5cm/Bz5BEQKCK0XMw0d3L0Pc9OHbkXvIS+9XqEIPB8NBjTZSsMopwWLoxPWQ/GfZMjyWZSUtDVB/caAsU2u0vJQo4JPX4hZyOOCjqI6IJ8u+l/iO3t2Zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742309393; c=relaxed/simple;
	bh=6odYDy/WzoLJB1dmBWgEDOpufGqtMVPdGIhz8jVMsEw=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=GXGBKOk3eEj/45msAMhnBZYpQNH6k0sWYPHRDnTE1axluWuJPk/NPTynrQqvPzOPXRE4lHDxYqW1WxHJ/kJ/3Y3AHjPfQDg1vUgXPVFSoY1KDuR405hsbVzKcn4/TPqVbBtw15KfNaJLQATYQpFCItdIraCwnNLzmySNAvgcXxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3d44ba1c2b5so55869395ab.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 07:49:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742309391; x=1742914191;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Svpb8PP6bZBAtbgaSvAJuXTALbR5zT82p2qdsD8Izlk=;
        b=kr9IkIWRVreqhBGQAQzqp4Il4gkd8ATlmMyCYBgIbzB3Fyecpe8/D5YcDHTwvvt+p1
         sEGD6SozyesiHYGJ1QyIQ2VpXE+eQCp7ZBNIvVgyvO8ZMQQVvO3S/3B2+FGGkISXwYBP
         LcdIF6Zn3nrAGXJtmKvaRi8EYPmeHcfOu7Swb/p8hMTx/iaPY1gSjNGMX2HYRwAGDzSL
         /1GCubihMT5SeKuBSWUtnfPJ4K1tpSLPAx+pylbhzvRryu+HbtVu2tdg8iE/V/zgVACW
         zSUlRA3k8tNiJT9REfpdmfFDZgixMtujWCv5n0EBlUIETmsFimC9rmAOxwXnDhuA38O3
         j+Jw==
X-Gm-Message-State: AOJu0Yw5/o9wDl8w9meePFmwbsLrMJyVJVmjfZQdQ76zENWDmDBuhV61
	rknqROa7RtIRk0geRnLcXc5O3FJeYwBnWf5JCYCoTwL+SSK4sYAOpElZZH7geNfe5JozRI2/h4y
	NwI3wZw7eO0pVrH0IG9AhBPdKL7Srkxs8r+1lajBgaM/yUcUl9OdUrtY=
X-Google-Smtp-Source: AGHT+IFDs/o3eedmzhMw6Yzzrqxh3GBYltN/cYObP4ptRO7nE4JJcEBYePc11P3ivmib9uw7EuNw2I5rm4LmA7fqY6U6BjJvn8OJ
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1648:b0:3d3:f19c:77c7 with SMTP id
 e9e14a558f8ab-3d483a79cc6mr169890705ab.16.1742309391155; Tue, 18 Mar 2025
 07:49:51 -0700 (PDT)
Date: Tue, 18 Mar 2025 07:49:51 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67d9880f.050a0220.2ca2c6.018b.GAE@google.com>
Subject: [syzbot] Monthly wireless report (Mar 2025)
From: syzbot <syzbot+list454c6e9dbba22fe541cf@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org, 
	netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello wireless maintainers/developers,

This is a 31-day syzbot report for the wireless subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/wireless

During the period, 4 new issues were detected and 1 were fixed.
In total, 58 issues are still open and 156 have already been fixed.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  101957  Yes   WARNING in __ieee80211_beacon_get
                   https://syzkaller.appspot.com/bug?extid=18c783c5cf6a781e3e2c
<2>  8431    Yes   WARNING in rate_control_rate_init (3)
                   https://syzkaller.appspot.com/bug?extid=9bdc0c5998ab45b05030
<3>  7317    Yes   WARNING in ath6kl_bmi_get_target_info (2)
                   https://syzkaller.appspot.com/bug?extid=92c6dd14aaa230be6855
<4>  6350    Yes   WARNING in __cfg80211_ibss_joined (2)
                   https://syzkaller.appspot.com/bug?extid=7f064ba1704c2466e36d
<5>  5147    Yes   WARNING in __rate_control_send_low (3)
                   https://syzkaller.appspot.com/bug?extid=34463a129786910405dd
<6>  2991    Yes   WARNING in plfxlc_mac_release
                   https://syzkaller.appspot.com/bug?extid=51a42f7c2e399392ea82
<7>  1205    Yes   WARNING in ieee80211_start_next_roc
                   https://syzkaller.appspot.com/bug?extid=c3a167b5615df4ccd7fb
<8>  899     Yes   INFO: task hung in rfkill_global_led_trigger_worker (3)
                   https://syzkaller.appspot.com/bug?extid=50499e163bfa302dfe7b
<9>  558     Yes   INFO: task hung in crda_timeout_work (8)
                   https://syzkaller.appspot.com/bug?extid=d41f74db64598e0b5016
<10> 428     Yes   INFO: task hung in reg_check_chans_work (7)
                   https://syzkaller.appspot.com/bug?extid=a2de4763f84f61499210

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

