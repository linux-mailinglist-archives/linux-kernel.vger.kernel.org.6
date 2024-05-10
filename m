Return-Path: <linux-kernel+bounces-175461-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0A0B8C2004
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 10:47:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2FE92B20DFF
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 08:47:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 199A71607A8;
	Fri, 10 May 2024 08:47:30 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 589DC1581E3
	for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 08:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715330849; cv=none; b=seAezH1W/nOcaMQ+r5Tkj5neTi03zdtAeoyrzDKJjvcFHhseYpKAL/cPRApeJ6VMmrv/UJPSmrH4cXHfwvG05aOF97gbN/kW+p1p0nGR+JbcnpsETgOEOn0bLBPHJ936jDBvZk9R/y7rlpcphcZIb7DpII3EY3tdPUUHVMhz5bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715330849; c=relaxed/simple;
	bh=exOJw8EAR1YSuOnAFdCSIBAXxjg49TrN6aACOGqPHQk=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Vi4aEl6CXBwicSS/fvJL2EBqd2PCL5ZI5f7JZ4VP8u4j0uSOpg1itbjNtRHr3zkyC0lFMnX7W1xY/IceFdiNTF2q4fhXok+r5FiyE0sZxkrHbniPH3R/MK2diJ+ErgmRhDR0RxzlRe8GEDckdD9Doxs7+4egL85NEq7mZoWnPRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7da41da873bso230658539f.3
        for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 01:47:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715330847; x=1715935647;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XpD9qVq4Hpwd5UROK+voy9ilNo5bK/m4WK9c2Y2l9SM=;
        b=xBBNChEvexDS5vDJeOaWh+6hQH0/pLExT8jy1fJN4/dIx5AZTK+vd0i9zgAaIxKU5E
         EdtCPtGENGTrLscSF36ZUJbSVlS47K6Jm3H6vH3b7JebZ7NixfpSO/yJPacX0nlQ79x8
         ZdrMGz6VQ0POPrNBzNCKpoZBi7JOzIbc6zQ3/VVREzV9wlVNu339LleCensE+1pt7pm9
         VR4ZjpEAPrCP/azQ7DWS099R3UF6Ml1wk968M20/GZmilsrBzHnh9Z4S1S59hC1VkgVV
         vJV/5JMLwj+CW3u30vUuhXaCx94nyUYlXO83RQNH29tMCxEcbHZ2SB6Ph5YnB+43clX2
         8YtA==
X-Gm-Message-State: AOJu0YxgkWjmJ1x21RvthfLLT5ql7IM4R0iT9FTYbY/T34hwYb8JVMR3
	YgaSWtdbYMRcRZl478yEatZmAYgPFgOfSTI0MODaK7Agkm4jmX9kJbZAbpqm2LQMqY8SpAmLA8H
	AjXg/aaD7PhC3ryX9bhDLKVRSb4tHllb8PpO00GbdWXSSRoLOiiLGNmY=
X-Google-Smtp-Source: AGHT+IGxycv88vad4phESjnL4Kc3pCnpyejTbFRKAfqcwbLA2at4ZWScHJpWqE0DWpR8ymshVeU6XxVgAECa9w2L/tMibRf8Vri7
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:8305:b0:487:100b:9212 with SMTP id
 8926c6da1cb9f-48958af8591mr131917173.3.1715330847426; Fri, 10 May 2024
 01:47:27 -0700 (PDT)
Date: Fri, 10 May 2024 01:47:27 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d556f50618159550@google.com>
Subject: [syzbot] Monthly usb report (May 2024)
From: syzbot <syzbot+list7b488901ebb9fc4e944d@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello usb maintainers/developers,

This is a 31-day syzbot report for the usb subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/usb

During the period, 5 new issues were detected and 0 were fixed.
In total, 74 issues are still open and 333 have been fixed so far.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  2933    Yes   KMSAN: uninit-value in dib3000mb_attach (2)
                   https://syzkaller.appspot.com/bug?extid=c88fc0ebe0d5935c70da
<2>  869     Yes   general protection fault in ir_raw_event_store_with_filter
                   https://syzkaller.appspot.com/bug?extid=34008406ee9a31b13c73
<3>  644     Yes   INFO: task hung in hub_port_init (3)
                   https://syzkaller.appspot.com/bug?extid=b6f11035e572f08bc20f
<4>  636     Yes   INFO: task hung in usbdev_open (2)
                   https://syzkaller.appspot.com/bug?extid=b73659f5bb96fac34820
<5>  405     Yes   INFO: task hung in r871xu_dev_remove
                   https://syzkaller.appspot.com/bug?extid=f39c1dad0b7db49ca4a8
<6>  353     Yes   INFO: rcu detected stall in hub_event
                   https://syzkaller.appspot.com/bug?extid=ec5f884c4a135aa0dbb9
<7>  304     Yes   KASAN: use-after-free Read in v4l2_fh_init
                   https://syzkaller.appspot.com/bug?extid=c025d34b8eaa54c571b8
<8>  275     No    INFO: task hung in hub_event (3)
                   https://syzkaller.appspot.com/bug?extid=a7edecbf389d11a369d4
<9>  261     Yes   INFO: task hung in get_bMaxPacketSize0
                   https://syzkaller.appspot.com/bug?extid=f7ac46d91cf13b4591a4
<10> 231     Yes   INFO: rcu detected stall in syscall_exit_to_user_mode (2)
                   https://syzkaller.appspot.com/bug?extid=a68ef3b1f46bc3aced5c

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

