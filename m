Return-Path: <linux-kernel+bounces-369329-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FF3F9A1BD7
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 09:41:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E86141F23098
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 07:41:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A1C81D07BA;
	Thu, 17 Oct 2024 07:41:27 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8078B1C2339
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 07:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729150887; cv=none; b=YdyFhxrE17kQ2GftO5xrfB7J0d3vs5b3tHCdvm+X9Y3bsZ7NXz8/g/GUmb9ai/Bt7KzyIuT2MfCrcyFWqO0Ccmhs8Zr7XTJbmKdmB0qhQmH///g/4wIpEb21aIas/AgqvIRzdKCAeOMH++7+tyo09hFL9Jahm7esTMvhneiQpx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729150887; c=relaxed/simple;
	bh=vfx4/HAzvUz+bd6CCHfuiF+FNeKLK/7spJgmBVkfSGQ=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=l9wg+WT2dZtkQd2wyiNhoyMwYXybhZCfxm/m9xfI7quvzGpu1rIc9G83fb85p+ybgapBb/PmTeoVKz0J1NfLcUbaNzUAwRQnDJTUperGzTsB9Ej04fc6kcpBceCtKQusE/d1uILIN9XlMnA0/+QU+AlEetKdSP2bcY6bSK6PLuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-8354a877867so75100239f.3
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 00:41:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729150883; x=1729755683;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JZylQjTiOxGDwIxztHGJIN7yk4iil+pEqDzlvCCLlco=;
        b=Bj9fEchUAnevosCDB6EuIvcUGAwPLahf+53/ZxBZQ70mpwLLIB+Zbe7oPx4+ZRfCHi
         JkLiElMYnS0KyHjb5arDpCLcd/bOaojN+31ad4csxZeqpNIljLECkvq6mp7YtBuMerfn
         M0QzlMhzq5otPx9PuylaksEOlM5Bpp9hLfXHhviCMM2GU4r94JanJYCw989hWk8kbHuQ
         05T82Mqu2tpPUrNJEjXTLjHtk4KTYp7U1eMKodzRen3zyu/NU5cifklec+lceUllXbA8
         PhFxHkqArssfCjHkYACJk0Y3PBVFmssaxWYBoipwdUrhqJ/LKcrRfmJPwQ3tg3/gCW+I
         8dqQ==
X-Gm-Message-State: AOJu0YxIr112fSq7Ekc5u8poC/0OhCJmoc1g3qLYTERQLohwfXkSFgqh
	70X44XF8lFeMDuNu4fOoZ8hZKLQD4yb7WQfWtsjI2U/6HV8ypFx7SZnH3HVntPNRuq6H4tznexy
	AY1MkzTGpfxYN1Sg3Dfe8X3aVtTGugWRlDNJjEnPEaQnvopvStddigVA=
X-Google-Smtp-Source: AGHT+IGuuixLw2y2VwGx9is8GPOWOJklws8URI8WqBJFfw2w66j/TfXDjFE2msQwfSuagZpIX2e1tJKCg3jzLuA4Jg+JFHP6VGRu
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:13cf:b0:835:3884:77a3 with SMTP id
 ca18e2360f4ac-83a947117d5mr796531539f.13.1729150883437; Thu, 17 Oct 2024
 00:41:23 -0700 (PDT)
Date: Thu, 17 Oct 2024 00:41:23 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6710bfa3.050a0220.d9b66.0185.GAE@google.com>
Subject: [syzbot] Monthly media report (Oct 2024)
From: syzbot <syzbot+list354438eb692b8a2f8c97@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello media maintainers/developers,

This is a 31-day syzbot report for the media subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/media

During the period, 2 new issues were detected and 0 were fixed.
In total, 19 issues are still open and 85 have been fixed so far.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  874     Yes   general protection fault in ir_raw_event_store_with_filter
                   https://syzkaller.appspot.com/bug?extid=34008406ee9a31b13c73
<2>  663     Yes   KASAN: use-after-free Read in v4l2_fh_init
                   https://syzkaller.appspot.com/bug?extid=c025d34b8eaa54c571b8
<3>  287     Yes   KASAN: use-after-free Read in v4l2_fh_open
                   https://syzkaller.appspot.com/bug?extid=b2391895514ed9ef4a8e
<4>  236     Yes   WARNING in usb_free_urb
                   https://syzkaller.appspot.com/bug?extid=b466336413a1fba398a5
<5>  225     No    INFO: rcu detected stall in dvb_usb_read_remote_control (2)
                   https://syzkaller.appspot.com/bug?extid=01926e7756f51c12b6a3
<6>  105     Yes   WARNING in smsusb_init_device/usb_submit_urb
                   https://syzkaller.appspot.com/bug?extid=85e3ddbf0ddbfbc85f1e
<7>  101     Yes   WARNING in smsusb_start_streaming/usb_submit_urb
                   https://syzkaller.appspot.com/bug?extid=12002a39b8c60510f8fb
<8>  68      Yes   KASAN: use-after-free Read in em28xx_init_extension (2)
                   https://syzkaller.appspot.com/bug?extid=99d6c66dbbc484f50e1c
<9>  31      No    WARNING in call_s_stream
                   https://syzkaller.appspot.com/bug?extid=5bcd7c809d365e14c4df
<10> 23      No    KASAN: slab-use-after-free Read in em28xx_release_resources
                   https://syzkaller.appspot.com/bug?extid=16062f26c6480975e5ed

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

