Return-Path: <linux-kernel+bounces-366802-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93CE199FA95
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 23:53:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C60971C21E55
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 21:53:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2FF721E3CE;
	Tue, 15 Oct 2024 21:53:31 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1865F21E3B5
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 21:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729029211; cv=none; b=U8QOTTc1FublTIfpfX7ZA6/HZaZA8R+XFA0CPNbZSKWGB2SDM1C7IB5x0vVOcZEDWQXkhsFmZSTmkso/y6T+YpmwRvCo+4XWbfrEH3zRbcI1qVBdYFvz9O/6KlQ8jz96NgsKZaRpSgJioqAy/2cyy3M38/SNSD8HZh1AmlI7Mk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729029211; c=relaxed/simple;
	bh=Or4vYfGDJI671FlDaFrz7e9NZqNNMIuzutqMV4xvcF0=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=APT/4IXEGoY0wC7UqbZSrqKBbBSQd46sxafTgWQOGYBO3Udp004hyht47wFRhXDazzcNeV/EsBrqfm4kT4iT4xwVyxc8fjMHIH+DZ2FwP+v+LuIPU+OFPmu1aqMaGA2ICtNpo6LXPQRzDYuhOZWQE9cY2bKWMbAiKc4PAtAZ7+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a3c5b90293so28307305ab.3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 14:53:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729029209; x=1729634009;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Z/vJY0eZAW/bLCBybcOesxjekxjUqb1MSo4imAeZBJI=;
        b=G+PH9otqMtzKqtS/MG55Aic8JTRCZjijZ2DGkm3QGb+k0gGWGZTGWkKVrS32kkmvTN
         hsqwB93wc+n3Z8zFaDElmPRgZYhUV1MHYzo8EGGRIXC1lTFepROJIc0/1ZX8GH5Wyz75
         83knLjdLN81gfb0n25Sftci3GlkJDVqWxPnK0zJm0vIdgyUTVVG5BNfF7srnF8BdUS8S
         ZCMrAjALdbAAWKhfvatlKye54Rh/GqeftMXt/oyYKNHciZ/UUPjnqIzYrZbXT+uHh6we
         XvO1bLIrONc3DStFUypUWlzlfR2TghV41t63bAk7WTbtUQ7ownH+UGJ5y/BwRi3Byr9y
         djvQ==
X-Forwarded-Encrypted: i=1; AJvYcCVnRmsinygvd8XmHJ32Eom3hzK2FOisz+zcXT3bxSCHmPmPpJ4+qTFHkNEeTJzPbNvPrKtcIoLdPjaB9+k=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywr+XOUzQBelLzaplZvlyixUdbVRlkJo1QsmKIBIwSbsjvXsxYV
	bHQ0UQ42pGVrMn2BLNhG7T2QufK7pEAbgKuIU9kU1TibpZLvqtzBAQ3Z1rapUdv1YCDM6EBdlj1
	cVyWtfa9w/UABOEH8yZd7YjWgLRSIQf5AmMZxwuPHhC6tdFT/ioSNfFo=
X-Google-Smtp-Source: AGHT+IG/1yPTJdgYzaNxH5EV6MnGwtegQq9A8Y3nUZHBsKdNsxtWyzMDp1ceYtAngIFnmjyBtgBJVai+Jc3vFcbo6AfshagXR5dR
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d15:b0:3a3:3e17:993f with SMTP id
 e9e14a558f8ab-3a3b5f4411fmr146677945ab.8.1729029209215; Tue, 15 Oct 2024
 14:53:29 -0700 (PDT)
Date: Tue, 15 Oct 2024 14:53:29 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <670ee459.050a0220.d5849.000d.GAE@google.com>
Subject: [syzbot] Monthly bpf report (Oct 2024)
From: syzbot <syzbot+list374d08c087a6bb36ee2f@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello bpf maintainers/developers,

This is a 31-day syzbot report for the bpf subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/bpf

During the period, 7 new issues were detected and 0 were fixed.
In total, 43 issues are still open and 272 have been fixed so far.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  20393   Yes   possible deadlock in trie_delete_elem
                   https://syzkaller.appspot.com/bug?extid=9d95beb2a3c260622518
<2>  1658    Yes   possible deadlock in __bpf_ringbuf_reserve
                   https://syzkaller.appspot.com/bug?extid=850aaf14624dc0c6d366
<3>  247     Yes   KMSAN: uninit-value in ___bpf_prog_run (4)
                   https://syzkaller.appspot.com/bug?extid=853242d9c9917165d791
<4>  159     Yes   possible deadlock in __queue_map_get
                   https://syzkaller.appspot.com/bug?extid=8bdfc2c53fb2b63e1871
<5>  135     No    possible deadlock in trie_update_elem
                   https://syzkaller.appspot.com/bug?extid=ea624e536fee669a05cf
<6>  54      Yes   possible deadlock in queue_stack_map_push_elem
                   https://syzkaller.appspot.com/bug?extid=252bc5c744d0bba917e1
<7>  47      Yes   possible deadlock in __stack_map_get
                   https://syzkaller.appspot.com/bug?extid=dddd99ae26c656485d89
<8>  43      Yes   INFO: rcu detected stall in sys_bpf (9)
                   https://syzkaller.appspot.com/bug?extid=4fe86fa6110c580ea1f5
<9>  18      Yes   INFO: rcu detected stall in sys_syslog (2)
                   https://syzkaller.appspot.com/bug?extid=269f9ad9bc32451d5fb5
<10> 11      Yes   UBSAN: array-index-out-of-bounds in bpf_prog_select_runtime
                   https://syzkaller.appspot.com/bug?extid=d2a2c639d03ac200a4f1

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

