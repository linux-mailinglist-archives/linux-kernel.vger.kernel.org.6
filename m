Return-Path: <linux-kernel+bounces-329339-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F1F8A97902C
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Sep 2024 12:59:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9D51285EB2
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Sep 2024 10:59:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3D8F1CF7AC;
	Sat, 14 Sep 2024 10:58:28 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD9D41CEEB1
	for <linux-kernel@vger.kernel.org>; Sat, 14 Sep 2024 10:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726311508; cv=none; b=Ey/6uQu5AE2M0q0PmL4J9yjpxK27v2ilkQrfQvbNzZw9S0ZRD50di5SZdIzEreLv7C76yx0HfNrkwLKtMhJL3TfIKX6pIcBGnW4EnXCTNfm6/nmW8ob3I+9htuhmk/VdT6j8kZG2Vzid/V3fK1eHaIiVTrSQ8URvPN1JtAwY3Bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726311508; c=relaxed/simple;
	bh=DTkYzvnHqco9rQOUXz2XRQZxajWtuXqCK8oXSvONs04=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=egEqBi7wLdWsJZrppLOB1aDMK9uo2zK9ZbS9HhdnFnjV/RWJT0Fcna/BnSeoDBs3egF4kl9l0csZ9WmNz12Ekh4jft9W94PRpxrQfGTLF2LIcDDCQDSEoxWo3axTWRy/STs6FCMVUZG6HtqXPfps/gvah0btpQKBYxs2SWEjIRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a0541f519dso67974115ab.1
        for <linux-kernel@vger.kernel.org>; Sat, 14 Sep 2024 03:58:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726311505; x=1726916305;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2C5K8uZnWh3ulLYjAusOjWaZCIxeifUvq8qtQntTFUc=;
        b=vO84PPVpf68pfdYLcjQqOC2156j67ZQA0HuQ/67grSGOKrmciv01YvxKe+5mtMQPmp
         SOyuxeo097VGS9+usg/sqwtV6JRLNYWMTobar4fO61G7WqolIwS2Dwu6/wjfZTN4K5Cq
         JKQekeU6Goi9DAchcpWWGT4Qije+wDETmyney0Xhg39cONn3TAuE/2t+kpj+DdclPIad
         pXBEuqbKeDE80DH1vxlvv7EgeBmMfFdzYI0VyPJUxOcCOFzYp28zpEUCd39YwU2dgPpq
         70xhKNxvvqlhgQ4XQXt59OL2+0/4rL93/CfC45jam//fIK8+s5OkLst0HJDhYL1gWYNW
         YfyQ==
X-Forwarded-Encrypted: i=1; AJvYcCVQC/4F01fP11Nm47ZlnRxqbeV5anWoCAgNWQtDPIAfP0DbcWORv0Ujy3WVXRU9Ng6KRz2xJfA5/ovI5Mk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAGBGL327muX051cDrqPbbzLB7d4TgQIRFfVvvEI1hsro7MnVI
	nqevNXDRwJJaujtruxHvG0PPokv5cPI41qEuj6JG3r3PzFb2Wu2QMiNimCio0gr0LPS1oyiPq7u
	n51ypgF2m5Tq1HpiNlKyPu60ddnLMilcnJvIZpL05Jff7Tn/HH8iAkxo=
X-Google-Smtp-Source: AGHT+IEAoNsD7xvfNYkaJsheQNi8xbPTqVG/fWGMbXTWNHBLQFfoUb1IyPFWBeXqy831rozWSVd3KLyeDuj56yOniPfNygW/Px+e
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1aae:b0:3a0:455a:3884 with SMTP id
 e9e14a558f8ab-3a08494a886mr101566885ab.22.1726311505547; Sat, 14 Sep 2024
 03:58:25 -0700 (PDT)
Date: Sat, 14 Sep 2024 03:58:25 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66e56c51.050a0220.3a9b1.002e.GAE@google.com>
Subject: [syzbot] Monthly bluetooth report (Sep 2024)
From: syzbot <syzbot+list5fb7cac78e857facc2f9@syzkaller.appspotmail.com>
To: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	luiz.dentz@gmail.com, marcel@holtmann.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello bluetooth maintainers/developers,

This is a 31-day syzbot report for the bluetooth subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/bluetooth

During the period, 0 new issues were detected and 0 were fixed.
In total, 51 issues are still open and 70 have been fixed so far.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  22304   Yes   possible deadlock in rfcomm_sk_state_change
                   https://syzkaller.appspot.com/bug?extid=d7ce59b06b3eb14fd218
<2>  13307   Yes   possible deadlock in rfcomm_dlc_exists
                   https://syzkaller.appspot.com/bug?extid=b69a625d06e8ece26415
<3>  5704    Yes   WARNING in hci_conn_timeout
                   https://syzkaller.appspot.com/bug?extid=2446dd3cb07277388db6
<4>  3906    Yes   WARNING in call_timer_fn
                   https://syzkaller.appspot.com/bug?extid=6fb78d577e89e69602f9
<5>  291     Yes   general protection fault in lock_sock_nested
                   https://syzkaller.appspot.com/bug?extid=d3ccfb78a0dc16ffebe3
<6>  268     Yes   KASAN: slab-use-after-free Write in sco_sock_timeout
                   https://syzkaller.appspot.com/bug?extid=4c0d0c4cde787116d465
<7>  135     Yes   KASAN: slab-use-after-free Read in skb_release_head_state
                   https://syzkaller.appspot.com/bug?extid=d863bc2d28ef7ff42984
<8>  134     Yes   BUG: sleeping function called from invalid context in hci_le_create_big_complete_evt
                   https://syzkaller.appspot.com/bug?extid=2fb0835e0c9cefc34614
<9>  50      Yes   BUG: sleeping function called from invalid context in lock_sock_nested (3)
                   https://syzkaller.appspot.com/bug?extid=55cd5225f71c5cff7f6f
<10> 45      Yes   KASAN: slab-use-after-free Read in set_powered_sync
                   https://syzkaller.appspot.com/bug?extid=03d6270b6425df1605bf

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

