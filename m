Return-Path: <linux-kernel+bounces-408943-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 94BBF9C8566
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 09:58:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 43D4D1F22A6D
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 08:58:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36E491F76CE;
	Thu, 14 Nov 2024 08:58:25 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D8FC1F757F
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 08:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731574704; cv=none; b=hqHbVPIgg9aqS7GFfl+RN+f0q8XUQEUq6E/LD/uNwqPS+MiUMn4Qk7dvapeAoDGnJbirM7HVHsCYH3tc0TZ5Rl1o3TWddtcuQ1wc+HofxoQQBnXQliTVz57vFJprJVHxD0bsYLRAmE1c4oUUBTsoNXhbN3DLw3lxPFi+JHzT13A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731574704; c=relaxed/simple;
	bh=arb5ev8D1gkREW3LGy4zcItfQnrfzM8oO7P/fIyEGH0=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=tjgoA+qBjDsg86oXX/XNw4FL49r23YqXfPnofUO4MDQo96xMVbWVfIQDkAWq5DYOlhyjfsCm72I6gjHnZs1WrxruzY6DyQnJGtGAIoRmB+MwTa3Y4UAcDPCzlRF++lKQ00CR8WPlBaixHSg8Ea5dyW1cPeZngsgcHyIgNtcbv78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a6f3a08573so4558595ab.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 00:58:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731574702; x=1732179502;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NkslEva3xH+202UFk1N4Z5nFB7hQ9vtTqIsb5mgRVjc=;
        b=Drs6QuRFkJKZQ172g9zq25L86t4xsVDG6Oxu6hjkmKJR04VKoq5kq9GWjaZ6d+xHXa
         +goy4LvT0f6uiF/I9YUzThI5Cy2aKPegknh40HigHbDID5/E6MpwbSEmqr3Z9FU/15y3
         ju41zWDkQ2PhxFmtm6qZ/3dy7upS7tL+1xHOtyge+RdWCOXpt5NHCfFo7cOlxTV3NqY5
         GsXmxECnNUA0dq0qciWOq8E1WLoYBWMSQKsLz173v1pT1qILuNpxdVvssWuafxKmWX0F
         zNEjU0nPWHjfYvixI2DGSvXn5CQ7qQ1Wl5U9K+asEW2AS0UxBU0Nhefr4XV/Y6eXuhYT
         W3YQ==
X-Gm-Message-State: AOJu0YzD7CKWKFaz3qJgi2gqCtp92+RhLNghpUvz+t6YLZryg2f4BGUE
	kywiaatAcjT6alJ562BZQld23bY+ICoN7P4sKS7pj8nKYmrQFru5bhit7PjE1T622ljeaKVSOPJ
	/FgRnugQejYV0bSvQX3xd877GjXYoO+927ZXJ7y67+yE7BWa0Gr79SCM=
X-Google-Smtp-Source: AGHT+IEIkCC8N1t3g1bFzgXedY1Bkr0mma44mi/1bc5v4Jq5iS0Rq6K9BCAIGlp4mxA4h010nK3uHM+G6TudeUGpnR10/ajX8bi1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:194a:b0:3a7:1a65:2fbc with SMTP id
 e9e14a558f8ab-3a71a653086mr51886145ab.23.1731574702355; Thu, 14 Nov 2024
 00:58:22 -0800 (PST)
Date: Thu, 14 Nov 2024 00:58:22 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6735bbae.050a0220.1324f8.0094.GAE@google.com>
Subject: [syzbot] Monthly wireless report (Nov 2024)
From: syzbot <syzbot+lista52bb331ee700442ac9c@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org, 
	netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello wireless maintainers/developers,

This is a 31-day syzbot report for the wireless subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/wireless

During the period, 10 new issues were detected and 1 were fixed.
In total, 48 issues are still open and 145 have already been fixed.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  40995   Yes   WARNING in __ieee80211_beacon_get
                   https://syzkaller.appspot.com/bug?extid=18c783c5cf6a781e3e2c
<2>  5954    Yes   WARNING in __cfg80211_ibss_joined (2)
                   https://syzkaller.appspot.com/bug?extid=7f064ba1704c2466e36d
<3>  3744    Yes   WARNING in ath6kl_bmi_get_target_info (2)
                   https://syzkaller.appspot.com/bug?extid=92c6dd14aaa230be6855
<4>  2962    Yes   WARNING in rate_control_rate_init (3)
                   https://syzkaller.appspot.com/bug?extid=9bdc0c5998ab45b05030
<5>  1415    Yes   WARNING in plfxlc_mac_release
                   https://syzkaller.appspot.com/bug?extid=51a42f7c2e399392ea82
<6>  1167    Yes   WARNING in ieee80211_start_next_roc
                   https://syzkaller.appspot.com/bug?extid=c3a167b5615df4ccd7fb
<7>  812     Yes   WARNING in __rate_control_send_low (3)
                   https://syzkaller.appspot.com/bug?extid=34463a129786910405dd
<8>  516     Yes   INFO: task hung in rfkill_global_led_trigger_worker (3)
                   https://syzkaller.appspot.com/bug?extid=50499e163bfa302dfe7b
<9>  364     Yes   INFO: task hung in crda_timeout_work (8)
                   https://syzkaller.appspot.com/bug?extid=d41f74db64598e0b5016
<10> 286     Yes   INFO: task hung in reg_check_chans_work (7)
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

