Return-Path: <linux-kernel+bounces-330658-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22FC197A261
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 14:35:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 532011C24AD4
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 12:35:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EEF4154BEB;
	Mon, 16 Sep 2024 12:35:28 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B09204C70
	for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 12:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726490128; cv=none; b=cveTA6S+KcHtKQKCxXJGm6sRLxcS9AMidP4y43rNESjeJRbbmLm4fDaj+Tb9hKRNZADVtrOGh8Q9HBVsQy3w5lIrkdFsnANBqEEq+viI0iQfi3OhAKra/IVKtZ4mNjw6DOcvkLv38KhD4kUFns6Z5RPNoNQJG2C/Qn7pSQV7WUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726490128; c=relaxed/simple;
	bh=7ihM5m4xYiXXJMVZ6qnBaJ2jDCZdGGV/4+zxwGcADT0=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=e0z6PmdqpeICNJWn6iPtw8YPW8jZ6PIiGmavcjut9CTEjxORtwcZNsEe9m5QQ9GBqm9cytbMKLVw5FSLGtiWvHdzxWm9z5YE6yGNuY4zOdxq9pJQ+ZEuB/DTumowtSd3JharY10C7pJDmETuUe3koqC2KTROMDpDIzTHrlUyg2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-39f53b1932aso74191385ab.3
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 05:35:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726490126; x=1727094926;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dwY9h5Q5x6R+zn5FfpHHLLD1pG8RAJIsVnvThQ4msJ8=;
        b=W6GPHiNjnJV8pTvF8Mug0gAKGAgDndpFeM7WW05hIUPhkOmhBzCehnBP4213WHQgsT
         H5ss1OHpn33YvOOBv2ZHXSbtBLrEZMU4DOqB53g1i2a1vQ6vn835LPHDaMf6eq3/GdYy
         FjKZjS8hnFOLoPrUue3VPq6ew8bxmY9eXCvBRKLsq0D6dPbSlzVDYe0Dmx15dicYV/Me
         yKyisco16RpFLjOrtj8+l9eb+yHi3rbw7VuhbtbLPJRlRb+kez8FbKSWzep+Si7grmuz
         twuNE+OlgnImfqEWSiXqlwhbOFVLBvuS0P25dvP6ZmJ7PQANyyzpX3N7TUTbD6a9Pkmf
         +CMA==
X-Forwarded-Encrypted: i=1; AJvYcCVBcoSI/APwzKB/asyzKxO6uf71JrgbWXeq0vZwmgGNCus9uKLF6NOuTMQU+w7A3WD8R5rAvg8eYvHity4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZChXqUjXl+FkDt7XdXxOM6POHMeRzF0hRfw6MwMhk066fY4NL
	XRsqQEYK8hJwW2Fv9rIQtdCEHBhysZGgMH/+MOKmo8x6jFtJR7tveYNmY/Cpw3QIcRxDx8edzVC
	KzD5HLCwtfjw7sqg49kX2DVC5sG95CIR5/45Xbo6XsJu6IGfK5CgmG58=
X-Google-Smtp-Source: AGHT+IEqSamn73OAR8wii+icocxFfo8TX+A/fJcNjvyIr/koS2bA4c+aRXkcl0Ydw3NjKK2ngwtXsky0jQtb4WoiiL9QxMXZIQkB
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:cdaa:0:b0:3a0:ab86:9293 with SMTP id
 e9e14a558f8ab-3a0ab86a6b5mr6662125ab.26.1726490125861; Mon, 16 Sep 2024
 05:35:25 -0700 (PDT)
Date: Mon, 16 Sep 2024 05:35:25 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a918c606223bce75@google.com>
Subject: [syzbot] Monthly f2fs report (Sep 2024)
From: syzbot <syzbot+list1835a579772406839600@syzkaller.appspotmail.com>
To: chao@kernel.org, jaegeuk@kernel.org, 
	linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello f2fs maintainers/developers,

This is a 31-day syzbot report for the f2fs subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/f2fs

During the period, 1 new issues were detected and 0 were fixed.
In total, 8 issues are still open and 41 have been fixed so far.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 903     Yes   INFO: task hung in f2fs_balance_fs
                  https://syzkaller.appspot.com/bug?extid=8b85865808c8908a0d8c
<2> 55      No    INFO: task hung in f2fs_file_open
                  https://syzkaller.appspot.com/bug?extid=6b03a52da637aa5db978
<3> 5       Yes   KASAN: null-ptr-deref Write in f2fs_stop_gc_thread
                  https://syzkaller.appspot.com/bug?extid=1a8e2b31f2ac9bd3d148

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

