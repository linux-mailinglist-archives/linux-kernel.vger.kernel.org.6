Return-Path: <linux-kernel+bounces-208165-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 501A19021C6
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 14:42:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB22F1F21961
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 12:42:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0277E80BFC;
	Mon, 10 Jun 2024 12:42:25 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43BE5335A7
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 12:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718023344; cv=none; b=EtcufAXefyvkU4YpCGLGzi6znp9GDiiou+970B8UOq/oodfPmzGZrI0aAgoYiDT6pvXSYig9GiV/OAW39r2TrbliBtTsAIhBcSr1SLyzO+m/wxiaj9MGD80hmnodQ0s+wdgCkmLcRJkfVdnRgN/J7quosG4dNZZOFIp7vbKBlVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718023344; c=relaxed/simple;
	bh=9pEEsEtWPWEZhGfiUREMEIGd4bWdWZ/t/bAlfEEtMyI=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=JpDERkjilosaAWBkHVs/XFwKYmPRPxDOZmmtGcaE4o7k+VoD2sI2rP4ypV4kI26sDk+XYzzstVovGiHw8Akec0LWN9L/o6Nz22XqO8pv2Z6vWvB/WyfgKzPpMkjPrO5rzTANCV+1Ki2n8E4KwFWO/wUDqgb/1+/dCdpW0ePHatI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-375a2191038so9819995ab.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 05:42:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718023342; x=1718628142;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=heicVqTlBApA6TI6EbgMnMbZ4hjAwK975v9ad8FTkmQ=;
        b=Y4CDU6LyJWYa77Q9Eq+vITXMdySKV7FsB6MQB3sRVqByt07bODys71fHhlFM7DnSIb
         KEZJNM524hQW5O7WoBWxQRjmAunbz/i5iWvgHx0qJUlpfB4qy6Dserze8Ew/54aW3hev
         ACdiA31xIxa4LFkFj3ilXhhJxrEMO8eFavPBfV+N0Nrx+2ZPZJ8oNTJp2NMBQ0ZnKU+I
         2DsUW2sHzUWmXpm5VQdn+/ZrLmBcdS03J9nrmb78GU+nxfWg2um3QEGiaTGzRWlhMZ5w
         MyeR2oXsnpxv7yAbfOkwcZoPoKXKI10FuMpJvKDfg7ex62WFVS5M98asyoZQSNMwhnTY
         pBrQ==
X-Gm-Message-State: AOJu0Yz0mhYBSAnDmXjm+1KYcxq4gvoXSavwODmSRFM+z0tMFQchbgt8
	NhFSwhs7LT94kzzn4NlIHKLlM01V2XI+EdkyTRD09/p+dtrpOq8xk5ECrMswDAQkINwdLa/BXTY
	hKSyTD1iGZ0KJTIR1efg8rXpyQrl9jVCwIfy617ny/tiHhdp+v0UVfM8=
X-Google-Smtp-Source: AGHT+IEyT9p7QIQnNyVpJrU0YYdOPI3ODjNeVogYq48fPpzX9uJ7qFz2vhUWpnZi7onh2qxhPpYl62XjU2EGJHYQi49NozbacFbk
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c0d:b0:374:9a34:a16 with SMTP id
 e9e14a558f8ab-375803c115amr6908875ab.5.1718023342579; Mon, 10 Jun 2024
 05:42:22 -0700 (PDT)
Date: Mon, 10 Jun 2024 05:42:22 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000ceaf8061a887b5e@google.com>
Subject: [syzbot] Monthly wireless report (Jun 2024)
From: syzbot <syzbot+listaafa45acbbfb240a1e5c@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org, 
	netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello wireless maintainers/developers,

This is a 31-day syzbot report for the wireless subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/wireless

During the period, 10 new issues were detected and 2 were fixed.
In total, 35 issues are still open and 128 have been fixed so far.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  9438    Yes   WARNING in __ieee80211_beacon_get
                   https://syzkaller.appspot.com/bug?extid=18c783c5cf6a781e3e2c
<2>  4499    Yes   WARNING in __cfg80211_ibss_joined (2)
                   https://syzkaller.appspot.com/bug?extid=7f064ba1704c2466e36d
<3>  792     Yes   WARNING in ieee80211_start_next_roc
                   https://syzkaller.appspot.com/bug?extid=c3a167b5615df4ccd7fb
<4>  578     No    INFO: task hung in crda_timeout_work (7)
                   https://syzkaller.appspot.com/bug?extid=ef89ef34c36478f35fab
<5>  312     No    INFO: task hung in regdb_fw_cb
                   https://syzkaller.appspot.com/bug?extid=9d8f809bfaab2e794297
<6>  161     Yes   WARNING in __rate_control_send_low (2)
                   https://syzkaller.appspot.com/bug?extid=8dd98a9e98ee28dc484a
<7>  141     Yes   INFO: rcu detected stall in ieee80211_tasklet_handler (2)
                   https://syzkaller.appspot.com/bug?extid=f05226202eb082367495
<8>  83      Yes   WARNING in ieee80211_free_ack_frame (2)
                   https://syzkaller.appspot.com/bug?extid=ac648b0525be1feba506
<9>  76      Yes   INFO: task hung in reg_check_chans_work (6)
                   https://syzkaller.appspot.com/bug?extid=b87c222546179f4513a7
<10> 44      Yes   possible deadlock in zd_chip_disable_rxtx
                   https://syzkaller.appspot.com/bug?extid=0ec3d1a6cf1fbe79c153

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

