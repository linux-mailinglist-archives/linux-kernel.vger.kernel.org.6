Return-Path: <linux-kernel+bounces-284395-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B5B695007D
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 10:55:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0129D1F23838
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 08:55:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD6F013BC3D;
	Tue, 13 Aug 2024 08:54:24 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 721D613D50E
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 08:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723539264; cv=none; b=MEWEaeYLZ9uRrq0CvnPLzC4spDrdm5QVS4meQOcmoybhlERPspemwrF1ZPx5UDZzA9j99OY9l8HuDPCP8F7fZbAWKdKBIWD85lwfhWKuXi0vFKxVWNgBAelahr/rWrBOzLQ4aIYZnWGXbUk8lzVNEvDHQVFPatc9qvXWDyFy0+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723539264; c=relaxed/simple;
	bh=k0shcI/BoAeYWt+T0ifvIPuvkga1yLWLrKbiwGgzjG4=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=TF1BpFXmQgrNAGEs8TYFsU0GpjPr6AHZjafrJ1f4swIwO2uA4uO5/jobHJgz+NEO381IArkprndPV7O0sJaGt4cCXz9Fp5tj4Wm4bb26OZIHR0hvApM1rrZ5Fq/YPFyFcOJ8AWtlZXCbrUxHk+zk5i9c0OUYRVdVQbe1TLhOgoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-39aeccc6479so72742875ab.3
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 01:54:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723539261; x=1724144061;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Gy8PBSrZR3R5gVjezhebrzxpwUbu8usFV9+V+9UvaII=;
        b=BdHI4J/clcOaYRriioZzo2QNjjemo2N6yrLdXUqDsunuhTRjtSFTB0EB0FBGwl3xsF
         tdZ6PHBgVo+YSzRWgoECrQBFoHYwffyAszey23JQEdTvyKf9vJyuhXf8ItTxEE1dHrKe
         3vNOrlpG0vwtAWuKzA9yzp2Jazq1X5kW6hhm+XZyOcXdmEePEft/sqzzuX86yogMxZ8E
         nmViI73YZ6rLwyX7U+8s12gxX3bMUDOIjjyfJpEwn1fnN++/ddVP3Lh2+vMHN9Z9dVyF
         0G8PKSaShAa7x1xF8R3ykydKMWF145dn9ekso1Fmqx6VHAVhalnLs+6IqpQ+sT/1peV+
         s2/g==
X-Gm-Message-State: AOJu0Yz4mGxgFDNtjh8P/bLrlIk76iUekR2dQZNwn7LbqU6DzFmpBiyK
	b7biw/7gEUqHwT/xoWUbk3XRlXXsgr0nCumFYVZV4MJMlv66ZYRM5mvcGzX3TuWsYp3yyP1he+g
	+i0ohBkTSIXjGDHfgH/Gj6b/G9aOYj6v4vhjrQe+5Hej9LoyQG1cmyUM=
X-Google-Smtp-Source: AGHT+IGC4oUj0T374enusPKUw9DiaTHoaPvUs+S7hma00bub2ycNW/nt3Wrs3H3YfsEUmcTHSxlqHFTv/jVoNyJjdtKqmiOOG9YO
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a4e:b0:374:9a34:a16 with SMTP id
 e9e14a558f8ab-39c4791694emr2049445ab.5.1723539261571; Tue, 13 Aug 2024
 01:54:21 -0700 (PDT)
Date: Tue, 13 Aug 2024 01:54:21 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007154d7061f8cc1c8@google.com>
Subject: [syzbot] Monthly wireless report (Aug 2024)
From: syzbot <syzbot+list8aab4226317d7ca90415@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org, 
	netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello wireless maintainers/developers,

This is a 31-day syzbot report for the wireless subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/wireless

During the period, 5 new issues were detected and 1 were fixed.
In total, 34 issues are still open and 140 have been fixed so far.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  23665   Yes   WARNING in __ieee80211_beacon_get
                   https://syzkaller.appspot.com/bug?extid=18c783c5cf6a781e3e2c
<2>  5497    Yes   WARNING in __cfg80211_ibss_joined (2)
                   https://syzkaller.appspot.com/bug?extid=7f064ba1704c2466e36d
<3>  1109    Yes   WARNING in ieee80211_start_next_roc
                   https://syzkaller.appspot.com/bug?extid=c3a167b5615df4ccd7fb
<4>  748     Yes   WARNING in rate_control_rate_init (3)
                   https://syzkaller.appspot.com/bug?extid=9bdc0c5998ab45b05030
<5>  580     Yes   WARNING in ath6kl_bmi_get_target_info (2)
                   https://syzkaller.appspot.com/bug?extid=92c6dd14aaa230be6855
<6>  214     Yes   INFO: rcu detected stall in ieee80211_handle_queued_frames
                   https://syzkaller.appspot.com/bug?extid=1c991592da3ef18957c0
<7>  125     No    INFO: task hung in rfkill_global_led_trigger_worker (3)
                   https://syzkaller.appspot.com/bug?extid=50499e163bfa302dfe7b
<8>  103     Yes   WARNING in ieee80211_free_ack_frame (2)
                   https://syzkaller.appspot.com/bug?extid=ac648b0525be1feba506
<9>  60      No    INFO: task hung in wiphy_unregister (2)
                   https://syzkaller.appspot.com/bug?extid=abba31ed4fc4178349e9
<10> 44      Yes   WARNING in minstrel_ht_update_caps
                   https://syzkaller.appspot.com/bug?extid=d805aca692aded25f888

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

