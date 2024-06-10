Return-Path: <linux-kernel+bounces-208117-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 654F99020F8
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 13:59:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F6D51F22455
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 11:59:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F35438175E;
	Mon, 10 Jun 2024 11:56:28 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBC6C7F48A
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 11:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718020588; cv=none; b=WhuWoUdEl5a80stsAHW2bgiIJpW+txb5hWz4Ne1NIIpUn8mvZ6DBKuESQvVYPzTau0yieTCQRfj7KpyndSR4wCjz1o66GHb+PWjDTqHsaUoowBKvESNWER8bfgravnIfbutCDljjJ/XEUyWrElzFrzc4z9jkKUwq6Gez3LZn6bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718020588; c=relaxed/simple;
	bh=K52nylIbtVGwpoFEvp+klLGscHlbN8NzK5pbrvNYjiQ=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=hDUPoLnthrJSjJAkGtIvr/rYe4SMl/MIoGi5CawSS/+SrHHLUV4qNHNr+zcO20njmYpwRTJPsDEKPGbQCSxLe2OEXgCxKpEmiJOnlcZHvoNefvk76AFm1/9O5GhyUmPAoxRKnjVrXnpIGXEAtXZ5cWhN5P6PDTwnsdcNxGLG8Gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7eb01189491so544670739f.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 04:56:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718020586; x=1718625386;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xA4ca/H7Pmgrnbw/NchvsBd76PXlaIQBXBo41MMl9Ww=;
        b=MrsaaPema8awKeRQTadWsRYGRUKvLGc8wwBoyv5MFkftdAEjoFR6t1wGEb0LVwJkpj
         f1ARTFvaK2OqS1zbfMA5HZ9FXKpzqyMWBA+Kc6gKZ5dpADK7e/H/f+hXdU4h8bOHfxVG
         K0HpLz8AQ/4aebjivkFVtmibdePEV2ePaQEPuIy823bhMpoVwmaiyczJ5FrAdZOqGpVe
         0QbFi2IIFnUQ08adjL6ttCa/LBYNhBNaQySOtg+khF4a1A3PSsm8PdK+n7k5T2N6C7LU
         NhKFl4bZVFgI1svYiN8sLk4cjJccytNp+VaxqciR+crCJ64+K3wCiLYeTRNSkAyNXIG1
         kVOg==
X-Gm-Message-State: AOJu0Yw1Cy0dcMKt7LVsZAcjcvZpzYH0xvBelpTmasCESFWvZJVj4OB0
	ittZxF0SljHG67e5fRhMSUUtx9zGn8WYH9O2FdTQFqvqmsHdEpujjv8RwFeEhETXhi7SzqM2lAi
	oRUSiUaImflXJEDsi6Hh1jc/EgxNT38DSq+/wi38tVnjxjII0FZa3rA4=
X-Google-Smtp-Source: AGHT+IGPa80KdKvehD4oNyzcwIRHfqGRmK9BKMuArSUhjJxQ0xIFiu1fkY07+hDKwslQz+7kc0jlHFUmpwgOIyO9kHTQ72HMMpUl
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:1642:b0:4b4:cf36:c09f with SMTP id
 8926c6da1cb9f-4b7b167393cmr401481173.5.1718020586232; Mon, 10 Jun 2024
 04:56:26 -0700 (PDT)
Date: Mon, 10 Jun 2024 04:56:26 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c26f45061a87d6e1@google.com>
Subject: [syzbot] Monthly usb report (Jun 2024)
From: syzbot <syzbot+listb516818c4565cc7c4df6@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello usb maintainers/developers,

This is a 31-day syzbot report for the usb subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/usb

During the period, 7 new issues were detected and 2 were fixed.
In total, 76 issues are still open and 338 have been fixed so far.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  3414    Yes   KMSAN: uninit-value in dib3000mb_attach (2)
                   https://syzkaller.appspot.com/bug?extid=c88fc0ebe0d5935c70da
<2>  883     Yes   WARNING in ar5523_submit_rx_cmd/usb_submit_urb
                   https://syzkaller.appspot.com/bug?extid=6101b0c732dea13ea55b
<3>  870     Yes   general protection fault in ir_raw_event_store_with_filter
                   https://syzkaller.appspot.com/bug?extid=34008406ee9a31b13c73
<4>  651     Yes   INFO: task hung in usbdev_open (2)
                   https://syzkaller.appspot.com/bug?extid=b73659f5bb96fac34820
<5>  646     Yes   INFO: task hung in hub_port_init (3)
                   https://syzkaller.appspot.com/bug?extid=b6f11035e572f08bc20f
<6>  406     Yes   INFO: task hung in r871xu_dev_remove
                   https://syzkaller.appspot.com/bug?extid=f39c1dad0b7db49ca4a8
<7>  363     Yes   INFO: rcu detected stall in hub_event
                   https://syzkaller.appspot.com/bug?extid=ec5f884c4a135aa0dbb9
<8>  304     Yes   KASAN: use-after-free Read in v4l2_fh_init
                   https://syzkaller.appspot.com/bug?extid=c025d34b8eaa54c571b8
<9>  302     Yes   INFO: rcu detected stall in syscall_exit_to_user_mode (2)
                   https://syzkaller.appspot.com/bug?extid=a68ef3b1f46bc3aced5c
<10> 277     No    INFO: task hung in hub_event (3)
                   https://syzkaller.appspot.com/bug?extid=a7edecbf389d11a369d4

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

