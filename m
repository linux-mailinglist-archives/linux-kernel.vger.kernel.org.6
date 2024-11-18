Return-Path: <linux-kernel+bounces-412774-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A0AD9D0F03
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 11:54:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1E0D7B2391A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 10:47:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43F731953BA;
	Mon, 18 Nov 2024 10:47:29 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7430B193409
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 10:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731926848; cv=none; b=hjwo+hs97eikKzPlvv9KLa4ECIpgphe9rejZyQgaAMfvzeU3CPGuNQKGvEiMys9DnYn5k5aGmWfWP5W1jVcooNQBCoUXV+iY6Y+CyGylXqJwQX0kiHfeUA4kzFTTKN/mIwXWo3FBCl3Nn9Y/ECP73bgCrq+/YDN7EUbCW/BIJyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731926848; c=relaxed/simple;
	bh=2ZYJYKTYfovbB4L1kx9gexhKFGA1ZJeKNRys2wgZDFQ=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=a5O+xmE4t5QiUGsDttPbomPROHkc7weLJoxQOy7Nu6sY/weKH6ME9EfxXGgT+/SKxEn33tz/4S6LTfQaIn0W4v5taLuoFEskhsbCNz9WDg7DEAzELunSlyl+X8O9LpIJBk3eeu/3f+B9/3bUe8cO7Q5LEglaWHMdtwPDPwxlk/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a5b2ec15a9so18283565ab.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 02:47:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731926846; x=1732531646;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=G64vNE+Dz+2awEnSqOeMPFFtWQcwTuaEK3/oD3t9tZo=;
        b=QFR2wDNoSDqCrCaYmCxX9VHxlsNaB+euJf4zVOatCN+e6GPnHhWiTHHK6cjn2KWEtX
         Jn24K+iyCmKsRuXbqCSvrQulBieu25bXrFe5H1aXlH0y+uimQ8fZYKXIELjNiAjpHwIn
         Lk78SuC1AjjGqbzENIvhY5JFemf0mfa1FOv9eX3T+a86Vz1P5vymYd+reXgqYtBzukfq
         +x/Pum1LUSdRnZB2gwUTm+K2hFbX4tFCNXWHztcK4FQG0vBgXUiih4Sk6QF7ZoWD+BIe
         n/qWbnd87fxSfBI5RrHKVggFPJxwIEXjAIi+Vw/vDd+0d+PTbhnegSY/7eQ7l8R0Gl1s
         ECtA==
X-Gm-Message-State: AOJu0Yx/wq9g4OfuJU4loRZ1DBj8ClTNzQQTZcODGonYHE32zQ9TJA2g
	VI+CkjBkBdSvxlvzIBaSgzJfR0xB11TgaeJ/+40xp6OCqEQndg5+k0b6ZavNnXKP/7Uqve1RIiw
	HQZbNak9xfBx5v+ApH368JSJCCVSwqgE9g51HIfMPB8x8CJDx2voPq50=
X-Google-Smtp-Source: AGHT+IE0l6RP9Q+OdwdrF3JGFN+MKypDtpe10OL1UVJTIOKf33TQUzoUkGWAIUOepdYBopIhBYQoBvc1ZN/tKCLdA7HbPBNvVJDM
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c23:b0:3a7:6cd8:120c with SMTP id
 e9e14a558f8ab-3a76cd813demr15972255ab.4.1731926846641; Mon, 18 Nov 2024
 02:47:26 -0800 (PST)
Date: Mon, 18 Nov 2024 02:47:26 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <673b1b3e.050a0220.87769.0031.GAE@google.com>
Subject: [syzbot] Monthly media report (Nov 2024)
From: syzbot <syzbot+list5a9a1a81d8075add9094@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello media maintainers/developers,

This is a 31-day syzbot report for the media subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/media

During the period, 0 new issues were detected and 0 were fixed.
In total, 20 issues are still open and 85 have already been fixed.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  879     Yes   general protection fault in ir_raw_event_store_with_filter
                   https://syzkaller.appspot.com/bug?extid=34008406ee9a31b13c73
<2>  818     Yes   KASAN: use-after-free Read in em28xx_init_extension (2)
                   https://syzkaller.appspot.com/bug?extid=99d6c66dbbc484f50e1c
<3>  436     Yes   KASAN: use-after-free Read in v4l2_fh_open
                   https://syzkaller.appspot.com/bug?extid=b2391895514ed9ef4a8e
<4>  279     Yes   WARNING in usb_free_urb
                   https://syzkaller.appspot.com/bug?extid=b466336413a1fba398a5
<5>  247     No    INFO: rcu detected stall in dvb_usb_read_remote_control (2)
                   https://syzkaller.appspot.com/bug?extid=01926e7756f51c12b6a3
<6>  118     Yes   WARNING in smsusb_init_device/usb_submit_urb
                   https://syzkaller.appspot.com/bug?extid=85e3ddbf0ddbfbc85f1e
<7>  103     Yes   WARNING in smsusb_start_streaming/usb_submit_urb
                   https://syzkaller.appspot.com/bug?extid=12002a39b8c60510f8fb
<8>  54      No    KASAN: slab-use-after-free Read in em28xx_release_resources
                   https://syzkaller.appspot.com/bug?extid=16062f26c6480975e5ed
<9>  50      No    WARNING in call_s_stream
                   https://syzkaller.appspot.com/bug?extid=5bcd7c809d365e14c4df
<10> 4       Yes   KASAN: use-after-free Read in em28xx_close_extension (2)
                   https://syzkaller.appspot.com/bug?extid=a11c46f37ee083a73deb

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

