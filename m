Return-Path: <linux-kernel+bounces-365361-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DE0AB99E12E
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 10:33:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 95EE31F22CA3
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 08:33:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE4471CC8B1;
	Tue, 15 Oct 2024 08:33:28 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB6571C760D
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 08:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728981208; cv=none; b=jOKdys2EraeVw9rKaAQ5XS0rwNo/4XxsVnDhL0KD6GYk1mxR6+XiJDhVPJkKjwNmWoMNBhD1k6BYvUkVjPstd6i2ysekQAS1i8W0xIAGnJe1hb2BfH8V3TEESV0mzMYF6p56G1miNqmPpKHlZTsLpw3gfNQ52WeQO65wKTDZhcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728981208; c=relaxed/simple;
	bh=brGXm5QGlWX/75RpntS9S7a9tixHTLH1SjkC/et3nG8=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=J7MgJBvEiwlHiuO7l5ao9hzT3xcDPrUZCWiLTIw8q7a9VIzWAtFFTIyE2N0envPNgDpd8NLgTGKVh1luLXEB0p9aa0RLD58MXoi0/n7ZB4fVKoBAr9j9djjEx2c55hJzsOx4Td35mAkb9FzZEu7TTDHh2BjsYxDAYlCH0/6eeM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a3b7d1e8a0so25934275ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 01:33:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728981205; x=1729586005;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wJ+92rKJpzc7gFGhxIcfKPxEEBkRlPMq6apblhq+LxY=;
        b=HoriR93ionVvCu6QXl+zP+J82jSAhCqOrCBl7v/8h5kuwFS3hFZ2nMi8d9eVSI8Fpb
         Rf0xVo9Saysc1QhbZmZNUhbj6gl0aLW3aAkhyNjPzERU8MHNrLA8siixWc03YK3QOgq5
         Wn3UKW6R9+gb1O/UFzv1d/Wu6MxA9jlJJwOVBroDkng75TixR7UJOq3WexHeYWCUFi5C
         WzLDldElUCNzXfyeSWdLlsf3tELt9DsEIKz1KbzsMyhkh2UcGMMVN7kfFVv7mk8zSnIn
         IajxasQfff6p9DfDBtKBOdnme9X1kn+7guAcialb1rUzd2Pu1N8EQ9lBxLBgAJXB70SJ
         Pz3A==
X-Forwarded-Encrypted: i=1; AJvYcCWP8U/5b1FpwzkivKrHVmvBEgB/mSY6W04OfDhLW0HhNBDaCv95fR0wr529FbugfbalLMAy2u/ZLEjb9/g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMc6viB/sVXoKKG2iEvfSXWs7DUK+JYPitl0+bg1nTBgdjKFBo
	6QUNHiJNyqnuaBHHo2iBcvJw572SNzro0s0ZxH/0PfIEpoVR2tGiJoVY4TgVk1L+f1A4rrh34bF
	tWzGrl1JS778bwMAp715H/1IJOfd5nQehjtWPzGqSzih/Qcxx/cNjm9g=
X-Google-Smtp-Source: AGHT+IG61fSjJUpq0XydR2YAsm8DLx453GM2CbssO1bSfKVnVPORJxKdimQF+PztK/jVwgMTGcLN3LB7eQxAYzPEMyRxQJnnpjgh
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:b2d:b0:3a1:a5dc:aa4e with SMTP id
 e9e14a558f8ab-3a3bcdbb661mr77680745ab.8.1728981204935; Tue, 15 Oct 2024
 01:33:24 -0700 (PDT)
Date: Tue, 15 Oct 2024 01:33:24 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <670e28d4.050a0220.f16b.0006.GAE@google.com>
Subject: [syzbot] Monthly bluetooth report (Oct 2024)
From: syzbot <syzbot+list1d979a49215bb9d63dc5@syzkaller.appspotmail.com>
To: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	luiz.dentz@gmail.com, marcel@holtmann.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello bluetooth maintainers/developers,

This is a 31-day syzbot report for the bluetooth subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/bluetooth

During the period, 6 new issues were detected and 2 were fixed.
In total, 47 issues are still open and 72 have been fixed so far.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  13649   Yes   possible deadlock in rfcomm_dlc_exists
                   https://syzkaller.appspot.com/bug?extid=b69a625d06e8ece26415
<2>  4263    Yes   WARNING in call_timer_fn
                   https://syzkaller.appspot.com/bug?extid=6fb78d577e89e69602f9
<3>  345     Yes   general protection fault in lock_sock_nested
                   https://syzkaller.appspot.com/bug?extid=d3ccfb78a0dc16ffebe3
<4>  175     Yes   BUG: sleeping function called from invalid context in hci_le_create_big_complete_evt
                   https://syzkaller.appspot.com/bug?extid=2fb0835e0c9cefc34614
<5>  130     Yes   KASAN: slab-use-after-free Read in l2cap_recv_frame
                   https://syzkaller.appspot.com/bug?extid=5c915dc5dd417b83b348
<6>  85      Yes   KASAN: slab-use-after-free Write in sco_conn_del
                   https://syzkaller.appspot.com/bug?extid=6b9277cad941daf126a2
<7>  57      Yes   BUG: sleeping function called from invalid context in lock_sock_nested (3)
                   https://syzkaller.appspot.com/bug?extid=55cd5225f71c5cff7f6f
<8>  46      Yes   WARNING: ODEBUG bug in put_device
                   https://syzkaller.appspot.com/bug?extid=a9290936c6e87b3dc3c2
<9>  45      No    KASAN: slab-use-after-free Read in skb_queue_purge_reason (2)
                   https://syzkaller.appspot.com/bug?extid=683f8cb11b94b1824c77
<10> 36      No    WARNING in l2cap_chan_send
                   https://syzkaller.appspot.com/bug?extid=b6919040d9958e2fc1ae

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

