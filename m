Return-Path: <linux-kernel+bounces-525519-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EDD9AA3F0D3
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 10:47:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23B21188C4F5
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 09:46:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A99602063F8;
	Fri, 21 Feb 2025 09:41:24 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EA912045B9
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 09:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740130884; cv=none; b=kpOLNGlyFllYGhrHB+q8e9bfN3QBDXcf4N0Qv2g3Dqs9OiMpU4CQYDurmrIFP1YjNPVb00XVz/lxEObNoVC7gNFn8fpeWNbBlPT/AmbWmLRuLeXEdo1AH5v15Yn5FOvqiKQQgDxn92aqDdERnONPQ9PONVQl8pguoF8WRM1/LIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740130884; c=relaxed/simple;
	bh=ZkkWKXP5VI04+XhhK4BFzZn5nqZ0ICb2qmJ7kldPgGc=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=S+hXVTXuoEabvS1Ig2gLOfS29HYsF1v3cwQZIvZ4N1npK4YP2p0XU45NU+Dzx4CUEs7pRfE1HD3Cc2E88O3rlgVsn3YcrJ2rBwGSAy7cxo9aG0KVVgc1xrmKsF8udqWwOSerJQNTaLFgviOyeAJMLCfo6So777OwAJ7uXG7xCMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-8559aa4b853so140853839f.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 01:41:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740130881; x=1740735681;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=T95fukwRaCyhjkDTbTMQl87Lxi7TRA8tZuBkDLMn1N4=;
        b=nKiJxc9VZ/ko6PA4tq/OUP3d9qntcvnB7XU0CdV0SxkGtOfnz6mSZvDixehO9LO7Tw
         +xs8i35yZGQi/Jgw4tOfHBAv9LtgXmjL1Rm1aeHZ7mRzhL34RAAJfHz78dSxlKkfNilU
         aNwe4qre8IBIlAJPD0GySvaUA6mZE0dHLEeTsi051tty5TPWUO6KedeGFQdk5FOc+w6y
         B6o6jm4wL8ZxKJtJBS8fyzJkrm4VqJdrlUiZJDEqFJ5iOG4HCVWe+oHxp5uTVFf4hrPB
         ZZEszUSedH/qLYVEoEOISg034qEQk5M2TViPcw+uezARvYpGjQ7u68LOoJBVV8wV1kPB
         gBqg==
X-Gm-Message-State: AOJu0YxvPphzQShJtY1vebG0qI7UbxPdPf7/Sl/uVBACQNzF/mKlGiRQ
	6qCgSmVB0wlYr8eAUcb1cN20P1z4haQ9CNfHqWx4rf+kb+p4NRJ4lEvWzii7fK93s6gYTVvp15w
	FJswMEtMo/aJFJtOtdG3l5qvWSUZWYxtPeKgHPPbY1FIwafz1XnLlD2U=
X-Google-Smtp-Source: AGHT+IEF5bFtK+eCANJbgUQqmfBu+0vXYeTFRBcR8iV7drnQDTpoOIsrcWPIDwV5HrQ9LgxOXhepfrQaeAw9suS96bC1WqcVv1Jo
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1908:b0:3d0:21aa:a752 with SMTP id
 e9e14a558f8ab-3d2cae47e92mr26100285ab.2.1740130881644; Fri, 21 Feb 2025
 01:41:21 -0800 (PST)
Date: Fri, 21 Feb 2025 01:41:21 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67b84a41.050a0220.14d86d.0358.GAE@google.com>
Subject: [syzbot] Monthly pm report (Feb 2025)
From: syzbot <syzbot+liste374d52634bb41a6b682@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello pm maintainers/developers,

This is a 31-day syzbot report for the pm subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/pm

During the period, 1 new issues were detected and 0 were fixed.
In total, 5 issues are still open and 9 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 586     Yes   WARNING in enable_work
                  https://syzkaller.appspot.com/bug?extid=7053fbd8757fecbbe492
<2> 3       Yes   possible deadlock in lock_system_sleep
                  https://syzkaller.appspot.com/bug?extid=ace60642828c074eb913
<3> 2       Yes   possible deadlock in dpm_for_each_dev
                  https://syzkaller.appspot.com/bug?extid=2a03726f1d4eff48b278

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

