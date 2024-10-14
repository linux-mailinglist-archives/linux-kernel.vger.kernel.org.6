Return-Path: <linux-kernel+bounces-363339-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E153399C0E9
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 09:15:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5DF32809CD
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 07:15:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72DA4147C86;
	Mon, 14 Oct 2024 07:15:33 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5FCE83CC1
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 07:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728890133; cv=none; b=jqWCuRTtVsggkM9vB89I220MfcJE0UTHLdypDroZRiU/fqXCAYnz9hFlN+mm3v9ACrr/nbQDwnFJb4t5mzN8aDjmlAM/QNS/Wt+a4VTCnE7unt4r4jy3OoXgfaeSLH7GFRx7Wn9ZahlhyA7AOt2vii4rm2v3ftkED0pvI9Dxtqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728890133; c=relaxed/simple;
	bh=rmqTKNE3CQ2Qgo8lS0qL8MYGdLeq9a0JDaea/S64Nto=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=liuop9VXRDhL1kGQoW3x1Huzgz/zqiH/kMO+CLa1N2/wxpKZF1022z2gO57HgkVXzfUTHdB4TSvvuItYzdXuV34+V/y5Lb0cxraGejPEMqsDJOYdVh8f9HijNsbOr5xH53mU0/WclQMFM3aR5Gf/covm8sVNzBvrPgt0vf6lXm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a3466d220dso39555275ab.3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 00:15:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728890131; x=1729494931;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VrAUuRqPsMn2YVWLeSUiBzZkrw+Pm6gR5I3+M7Woy/g=;
        b=XBX8lbviDnlN4ahZ/6B3ugBNl0s66n95HE3WBsgpskk4jxKWNKdBOt/QKb4iFipZOO
         94m0kILWF0WzEmAxO6Uw/+N/1XGdvsVaaiawwrDO2/oJTlx3Y4c+oXLAsgrvwG3guMtM
         Z1J2C3il/f2PIlx3NDgNS9JQG1AEkjxfNKIdR+kTUmERHUxiP7uwLAQ1aL40Be6eKwnv
         S2dReYW/nt4W9VGZU0Vv8LVr9DBh7nvIz3KubMWIGizHoOuu8jf/v7VrBUu1S4mBAk3B
         jl4D53YL4BKVR/Mh8CGvrX/LIIJdECnryw1RUsj0+7Tm2eddZ5EZ2pIC7mkQXir1nePe
         uuJQ==
X-Gm-Message-State: AOJu0Yxs8BUHfqhSDUo7p0dzHuX/NKVZhxzciJP3D5BHDCbEWBtoQGQB
	uHM8ur0icz8Ex0SPq4P6S60aw7g5UgqDFj/x3u1rg2SLJanVjXGX+mlRLjmDlIpvIuoRS7i1RLR
	2nKoHWSXDeC7xaMMN/I+kCnqZtoVsAbagKrcZWNuF8bjxb3MmrqUgzLM=
X-Google-Smtp-Source: AGHT+IF9A6QjWA23L9s/ioWJStNI8SjP8VOHWp0B3A+U9f9u2ynjRhrmA0ymijDb9J0hP3hQDjuKzUGz9UhROlcuPHQnedBxxRjI
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1548:b0:3a3:6045:f8bd with SMTP id
 e9e14a558f8ab-3a3b5f7845dmr96684315ab.5.1728890130818; Mon, 14 Oct 2024
 00:15:30 -0700 (PDT)
Date: Mon, 14 Oct 2024 00:15:30 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <670cc512.050a0220.4cbc0.0047.GAE@google.com>
Subject: [syzbot] Monthly wireless report (Oct 2024)
From: syzbot <syzbot+listafa8479e7289edf8e367@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org, 
	netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello wireless maintainers/developers,

This is a 31-day syzbot report for the wireless subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/wireless

During the period, 5 new issues were detected and 0 were fixed.
In total, 40 issues are still open and 144 have been fixed so far.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  31987   Yes   WARNING in __ieee80211_beacon_get
                   https://syzkaller.appspot.com/bug?extid=18c783c5cf6a781e3e2c
<2>  5861    Yes   WARNING in __cfg80211_ibss_joined (2)
                   https://syzkaller.appspot.com/bug?extid=7f064ba1704c2466e36d
<3>  2734    Yes   WARNING in ath6kl_bmi_get_target_info (2)
                   https://syzkaller.appspot.com/bug?extid=92c6dd14aaa230be6855
<4>  1468    Yes   WARNING in rate_control_rate_init (3)
                   https://syzkaller.appspot.com/bug?extid=9bdc0c5998ab45b05030
<5>  1144    Yes   WARNING in ieee80211_start_next_roc
                   https://syzkaller.appspot.com/bug?extid=c3a167b5615df4ccd7fb
<6>  905     Yes   WARNING in plfxlc_mac_release
                   https://syzkaller.appspot.com/bug?extid=51a42f7c2e399392ea82
<7>  383     Yes   INFO: task hung in rfkill_global_led_trigger_worker (3)
                   https://syzkaller.appspot.com/bug?extid=50499e163bfa302dfe7b
<8>  253     Yes   INFO: task hung in crda_timeout_work (8)
                   https://syzkaller.appspot.com/bug?extid=d41f74db64598e0b5016
<9>  233     Yes   INFO: rcu detected stall in ieee80211_handle_queued_frames
                   https://syzkaller.appspot.com/bug?extid=1c991592da3ef18957c0
<10> 209     Yes   INFO: task hung in reg_check_chans_work (7)
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

