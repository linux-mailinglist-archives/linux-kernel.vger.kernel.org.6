Return-Path: <linux-kernel+bounces-248703-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CE8BE92E0DE
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 09:31:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D6BE1F22339
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 07:31:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18760148FE8;
	Thu, 11 Jul 2024 07:31:29 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ED454EB55
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 07:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720683088; cv=none; b=s53XwmCh/v7NU5h10BzoQa1AD/XeL4Lqq/GDieWT0YwIBbdwiiUIaPI7Z6SsV5+K8KUczoopSFBUJaN5iDxcDK5qC6+oz7xFaG8YqUhC4JOVLvrpgoAhsMZjP8el3+3fN3MIpg0oUlMlkcXmuOSNJv6dyVfTrplNB5/Em5cCU9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720683088; c=relaxed/simple;
	bh=2ykrV+db0A9oXfPwOZSh0YWS78FhI0FWtnZN5Z6XYCg=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Spr0H6g5u6v5tbff9HIUvVyYbGMEkbukaNMArhMPe6vBT6QkTB8zbRJQYM6fdJRJPuUw4jwICuPrL1edWYViP53+zFz85vxlSf6Atj8zWuKRzrY+0X2O+T1LUWC+8NGuffOiOArhedQLaQJ/pAhrFZqres9+8tJkLhIqq6uNJRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-80627fd1a81so45340539f.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 00:31:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720683085; x=1721287885;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IxiJdl4VtQvTNmrKCocRbqkV0SinbYelbc+wAZLmHNQ=;
        b=gI1gdO5Bba718qExaWqQAD9pq88iKZDOSQr/1JOqkoEjxJDaczaf1J0oRucFgSKFKi
         YSgnHTtjK6pxJ3w+LebZoWW0gjV1M4Xjk02Ebozdxo+Jchnyl+5z02LmCLwokjV6dVU/
         fvtLv/aHfewpNaEnb4wcaPOCqkrGwPG4slHCsPlIt3fCdz0f0X2/NBs+DrZLUiYUXod3
         +gMxcg/wXvlCbViq5dg9jr/IhHsQukUiDqoHqAjuksKJcfoN9HfV8gvDAbjtdkptbvJH
         oFFqn+2vX4pNIwt8IfMMSTjA7n0cPPFcPnlRYZlrHL1vtDGSO6Knvl7s/V0xZCZf7sTs
         s22A==
X-Forwarded-Encrypted: i=1; AJvYcCVZ34pyavk5/hnUCFlgOO2Y33gDEb1t3iD4+bjOTV4AQNSeEgUBQRSfnM+xdO/MUonr2v88dGX33tayyAKTk4BtbmfzFZdibld0LPA6
X-Gm-Message-State: AOJu0Yy7mgv5kG3LDdO12hWYqQ7U/cVyA8K7uiCLrmRs8+UQ6fD4LH3G
	3jto94un/alsRQ2k8pQRoXfeZC5GB7JaDWc0vhkYm1U/zzmdCGORwnL8Dm9Mh+r3xUPxTVoy9kU
	x+YbiF6irrk7kuh9sAe9GBhqh/ts5nCADz/JzEYrdYWddNBIpzdadIwQ=
X-Google-Smtp-Source: AGHT+IFWckUCxHgwYGtn24fWh3b9Aa1oJyYIW3pH83j2rqWMToR0Qm4RcwrF2vzeHHitwxBvKQan6wwAGETGzhd46Y1AOmGtVRh0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:34a4:b0:4ba:f3bd:3523 with SMTP id
 8926c6da1cb9f-4c1bdedeac6mr126608173.2.1720683085409; Thu, 11 Jul 2024
 00:31:25 -0700 (PDT)
Date: Thu, 11 Jul 2024 00:31:25 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000013c187061cf3c09c@google.com>
Subject: [syzbot] Monthly bluetooth report (Jul 2024)
From: syzbot <syzbot+listf73783798eb5d74d411e@syzkaller.appspotmail.com>
To: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	luiz.dentz@gmail.com, marcel@holtmann.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello bluetooth maintainers/developers,

This is a 31-day syzbot report for the bluetooth subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/bluetooth

During the period, 10 new issues were detected and 1 were fixed.
In total, 53 issues are still open and 64 have been fixed so far.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  21879   Yes   possible deadlock in rfcomm_sk_state_change
                   https://syzkaller.appspot.com/bug?extid=d7ce59b06b3eb14fd218
<2>  13079   Yes   possible deadlock in rfcomm_dlc_exists
                   https://syzkaller.appspot.com/bug?extid=b69a625d06e8ece26415
<3>  5305    Yes   WARNING in hci_conn_timeout
                   https://syzkaller.appspot.com/bug?extid=2446dd3cb07277388db6
<4>  3382    Yes   KASAN: slab-use-after-free Read in __hci_req_sync
                   https://syzkaller.appspot.com/bug?extid=27209997e4015fb4702e
<5>  3246    Yes   WARNING in call_timer_fn
                   https://syzkaller.appspot.com/bug?extid=6fb78d577e89e69602f9
<6>  680     Yes   general protection fault in skb_release_data (2)
                   https://syzkaller.appspot.com/bug?extid=ccfa5775bc1bda21ddd1
<7>  411     Yes   KASAN: slab-use-after-free Read in sk_skb_reason_drop
                   https://syzkaller.appspot.com/bug?extid=f115fcf7e49b2ebc902d
<8>  250     Yes   general protection fault in lock_sock_nested
                   https://syzkaller.appspot.com/bug?extid=d3ccfb78a0dc16ffebe3
<9>  249     Yes   KASAN: slab-use-after-free Write in sco_sock_timeout
                   https://syzkaller.appspot.com/bug?extid=4c0d0c4cde787116d465
<10> 120     Yes   KASAN: slab-use-after-free Read in skb_release_head_state
                   https://syzkaller.appspot.com/bug?extid=d863bc2d28ef7ff42984

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

