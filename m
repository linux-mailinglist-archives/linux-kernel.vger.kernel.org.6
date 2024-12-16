Return-Path: <linux-kernel+bounces-447089-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 803CB9F2D33
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 10:44:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AAAD518808C8
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 09:44:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29178202C51;
	Mon, 16 Dec 2024 09:44:24 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4306C201264
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 09:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734342263; cv=none; b=ca+dVnZM6576A0ZwOS82cx8pU1TG1jQATyvztDxAx+/uVP0PHa0/+q5AArEk2sn5GM9YoSeKRkxY+lv9BgYvJ7akjJMW0eeJZHXVWS4UJQUPJXJgGT4ImxjJvpFbZ5K0hU4gdwAWx3E2T1pe3T2ORBrtMVgfsgldNnFs+A3eLU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734342263; c=relaxed/simple;
	bh=N+i6koqxsa9OsolxCDCw/9LqETbhTH2+AbyTZQ2MAuE=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=i37JNBN0lVIEj3abojc4OpFWuNGa7eKJGjfZQRkCMrWP05v+aA7JTg8Q8Lr9Dla47MmBc2lxLgbDu3sU40h6cau60YMNTOmfk7zXogjTrXzg5/PJK87OykNdU1uoeWOG3yJ45wK9WUrf22T2AhAGk28AefuBZJfDdfmVfLHBvEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3ae31bb8ee3so77377975ab.3
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 01:44:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734342261; x=1734947061;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=J6ybKlMfc9DGIqtIcKjpUrlCF2YX0mHvs0j+RXlXccU=;
        b=j0xjumWxQJ74ixSBu4COqM2My9RJ6yoA6H79meTe75WKDKh2J0SMmkvVJcsHJYPNZ+
         bA+tFUZD8k1i+Qzf9NDAHlkJ4ksE7lFt7LFZEbgmJY8ucdzDwnDTdbXpGOc8dNn7WqWF
         xJOESrhyFWKxwMY3vKPygdAnXmg+pZR0FMYgj5gLM0RXXzsYiZtuyV8TosjhUbzxGHel
         0BDXYZep/CUsgiI7d7HhKByiC0SLCSDNxxmCl7rgzDD/EAr9xa3RHFacqs9HMDOOenHh
         ts1YsPGkfgPuajDXVm+76k83xjzzju8mPbKo86qLV6voVhizMH53jMBJJJNjK0u+TJqa
         h8ig==
X-Gm-Message-State: AOJu0YyJuXpLHY2QdeDNc2lFZiyFfEmgDz5Gn3Py6mcNkRhknjyk8wmo
	VZSKnufJtwGjeyoftJL7gTorGgkWaRFUKj/bo1bwQrxhWHctrtD+zXRLVl9s3h52jf/hBIyrzpB
	RSpJYf6OKnxSmOxcv7kMZApCltdYp8k67mjIrZtIQB9RWdHcONBlow0M=
X-Google-Smtp-Source: AGHT+IH2j7VQawNDcHbQxaCpP6l4rDtxF+LFPAcZJTSsEyVFPJ4hXJGAn0fC+KrzBb/O8Rp3F+ihMCHORvJ4XiZJI/tyane9eto+
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:12c9:b0:3ab:1b7a:5932 with SMTP id
 e9e14a558f8ab-3aff0682c2cmr113845555ab.18.1734342261451; Mon, 16 Dec 2024
 01:44:21 -0800 (PST)
Date: Mon, 16 Dec 2024 01:44:21 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <675ff675.050a0220.37aaf.0124.GAE@google.com>
Subject: [syzbot] Monthly wireless report (Dec 2024)
From: syzbot <syzbot+list7655e841c85eeae9d270@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org, 
	netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello wireless maintainers/developers,

This is a 31-day syzbot report for the wireless subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/wireless

During the period, 5 new issues were detected and 1 were fixed.
In total, 52 issues are still open and 146 have already been fixed.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  56849   Yes   WARNING in __ieee80211_beacon_get
                   https://syzkaller.appspot.com/bug?extid=18c783c5cf6a781e3e2c
<2>  6078    Yes   WARNING in __cfg80211_ibss_joined (2)
                   https://syzkaller.appspot.com/bug?extid=7f064ba1704c2466e36d
<3>  4865    Yes   WARNING in ath6kl_bmi_get_target_info (2)
                   https://syzkaller.appspot.com/bug?extid=92c6dd14aaa230be6855
<4>  3910    Yes   WARNING in rate_control_rate_init (3)
                   https://syzkaller.appspot.com/bug?extid=9bdc0c5998ab45b05030
<5>  2200    Yes   WARNING in __rate_control_send_low (3)
                   https://syzkaller.appspot.com/bug?extid=34463a129786910405dd
<6>  1844    Yes   WARNING in plfxlc_mac_release
                   https://syzkaller.appspot.com/bug?extid=51a42f7c2e399392ea82
<7>  1183    Yes   WARNING in ieee80211_start_next_roc
                   https://syzkaller.appspot.com/bug?extid=c3a167b5615df4ccd7fb
<8>  629     Yes   INFO: task hung in rfkill_global_led_trigger_worker (3)
                   https://syzkaller.appspot.com/bug?extid=50499e163bfa302dfe7b
<9>  387     Yes   INFO: task hung in crda_timeout_work (8)
                   https://syzkaller.appspot.com/bug?extid=d41f74db64598e0b5016
<10> 315     Yes   INFO: task hung in reg_check_chans_work (7)
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

