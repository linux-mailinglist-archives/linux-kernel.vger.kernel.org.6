Return-Path: <linux-kernel+bounces-175460-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AA6B8C2002
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 10:47:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB7E728219C
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 08:47:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C26E015FA94;
	Fri, 10 May 2024 08:47:29 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0167D77119
	for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 08:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715330849; cv=none; b=fZB7MnCO+CnYdKwQ9xFzvgTUKEWT2w2HwiZWqRKaDSSPdpo3vKLXbDORe2D6+DyF10PQmpi/xcN2iAHHo+ZO6m6gM7o1hQev7OTnli2byrWU1f9huIHy/vNwlFtjStRNsvccFTsAirQl+UTwDm0ykq9HmbBE3eI3uWAS7FxQoY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715330849; c=relaxed/simple;
	bh=z4fieskV9fBnvHcAQSR6SluMypmP6b+QigJYTswAuXY=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Q8GMljH/ttyah3eYr7WEN50rcm7th4fae/mVkjXnbM45jkZa0BGR7Odz3kGWJpe5lcq6lBTnCFl6DA0uDIHUWAxvAJEehdJ7FNoDUUDUiBVpY1MGwFVKx7rXfn8gIN7OQ33MRzBW+lqE2Vk+CuYZuMHaA71bSBrO/xIHRj4JnAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-36c60af9b4aso21377275ab.2
        for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 01:47:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715330847; x=1715935647;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=G7ysTa8lGB3gIp89Re4Hb5zO3F9EmrL6VpRkQGWIOKY=;
        b=G8W+1buh6BPwkRE0+haAiy/rSUhan1Zmwad/AjgXbiWTNUA7Una60Lvt9XLQMsStEG
         PWeXvfKCu3c2QxVMOEpTWtjDy1eztuDEoLqIW4Op53XoBOqGlmkRGOjFOAHWibqIMjE8
         l2SudeWZEqsPa9iQfjY7T31sR+tHHNdnYEuT7w6QIUviirP7kxzndTwiOlXzZbSFl2oU
         QRq+DCW4z1hwQHggKQb4vAWgb8AT7YyGwSwON4M3SFerpyoYCU4JMqdlo89Y6x0EKhS5
         NucvboGoh3yE0CAsb4zYYhDLAslhcEF2M9zw4cBDQtN172D3puSa3ZyAu+FZwOyBiZaW
         pzjA==
X-Forwarded-Encrypted: i=1; AJvYcCUfpklYp0LNbaiL0KkpQsmRt+kb7IK/BtK67CCdwpArTzFlPHP8THlpv9qS6eTMpzLfj19e2EGEtb6YhSbs69GUXdo6nXsDayurJcdq
X-Gm-Message-State: AOJu0YyNnSVvN3kE/ZYlECDFj7ICZr/JTDTSlF31qj/2Uk72PPy1pmFF
	PTSC1ggmA0fHwoUumHveRP+rWbYET9hs7SUtUchsQ/rCo04oJC8VctszkQX9vE1W2LIjdWWDEnH
	Wbxxn+9tAB7fM3lDXdah0tqRnIFzZrhYjU6vnZRFY+AYHgOLbpv82Ws0=
X-Google-Smtp-Source: AGHT+IHc0ETxoTnfULqi5pFfXN+tggwnOSONEjSVana0f0Oz1M23Mem0r9CAo328qe/t6U58PUgC4sx1zREtOZW7QwOBMm8sOVRr
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c41:b0:36c:48c5:d59e with SMTP id
 e9e14a558f8ab-36cc14f6cb7mr1060615ab.6.1715330847207; Fri, 10 May 2024
 01:47:27 -0700 (PDT)
Date: Fri, 10 May 2024 01:47:27 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d200cc0618159597@google.com>
Subject: [syzbot] Monthly bluetooth report (May 2024)
From: syzbot <syzbot+listd0ba33904b1725281a03@syzkaller.appspotmail.com>
To: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	luiz.dentz@gmail.com, marcel@holtmann.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello bluetooth maintainers/developers,

This is a 31-day syzbot report for the bluetooth subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/bluetooth

During the period, 10 new issues were detected and 0 were fixed.
In total, 47 issues are still open and 63 have been fixed so far.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  5056    Yes   WARNING in hci_conn_timeout
                   https://syzkaller.appspot.com/bug?extid=2446dd3cb07277388db6
<2>  2664    Yes   WARNING in call_timer_fn
                   https://syzkaller.appspot.com/bug?extid=6fb78d577e89e69602f9
<3>  2546    Yes   WARNING in hci_conn_del
                   https://syzkaller.appspot.com/bug?extid=b2545b087a01a7319474
<4>  913     Yes   KASAN: slab-use-after-free Read in __hci_req_sync
                   https://syzkaller.appspot.com/bug?extid=27209997e4015fb4702e
<5>  522     No    possible deadlock in __flush_workqueue
                   https://syzkaller.appspot.com/bug?extid=da0a9c9721e36db712e8
<6>  361     No    possible deadlock in touch_wq_lockdep_map
                   https://syzkaller.appspot.com/bug?extid=91dbdfecdd3287734d8e
<7>  236     Yes   KASAN: slab-use-after-free Write in sco_sock_timeout
                   https://syzkaller.appspot.com/bug?extid=4c0d0c4cde787116d465
<8>  119     Yes   general protection fault in lock_sock_nested
                   https://syzkaller.appspot.com/bug?extid=d3ccfb78a0dc16ffebe3
<9>  61      Yes   KASAN: slab-use-after-free Write in sco_conn_del
                   https://syzkaller.appspot.com/bug?extid=6b9277cad941daf126a2
<10> 7       Yes   BUG: sleeping function called from invalid context in hci_le_create_big_complete_evt
                   https://syzkaller.appspot.com/bug?extid=2fb0835e0c9cefc34614

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

