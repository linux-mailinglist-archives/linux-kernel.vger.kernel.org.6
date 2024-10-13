Return-Path: <linux-kernel+bounces-362921-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CFA499BB39
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Oct 2024 21:21:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71DE81F2156A
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Oct 2024 19:21:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D558B1474B9;
	Sun, 13 Oct 2024 19:21:28 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 116D612EBDB
	for <linux-kernel@vger.kernel.org>; Sun, 13 Oct 2024 19:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728847288; cv=none; b=LJg16uKqwzaeD4nSp/Y9gMarnioMW/sLgdFyJBELxDLYYMf+tAftWY1GEwxTp1+0R0Y/LdZM0m6WlT+4W+W4nY9cXemqSnUMZCIfxHNhHK+gxGUuHUHWoRpT5Z2LLEa7gqykkA8+k1A3xDZXBVLseQ8yQTN7T/45lUCVtVry9/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728847288; c=relaxed/simple;
	bh=e9B1GYr7X704oC5pS3YuyF4rXsyj7DNqUwwBpXLsiIs=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=XM8l7cqZxh/9DvIs56kNRetGIj+4SvHEfDl6l1b6p+M2exfWkMqoVHHsKejn8EhQOVT/QiyP7CWWlBJMYh5NS+ByY0Y/JDC6R6RQIe/ld53PwYQ5ddkDX5vu2qmFOCwIm3xCiv1l1KCgt23b/C1kFNg4CAbCZblqsA8cU1QPVOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a3ae3c2cacso31240375ab.2
        for <linux-kernel@vger.kernel.org>; Sun, 13 Oct 2024 12:21:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728847286; x=1729452086;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4WU3kgEtTuMHg+8jTGa/m3Y0xT7Aassavqo9KaNTKhI=;
        b=DHAPrHVUnSjdFVGekeIvu32ZxkIpZNC0D+6O/jH4CCMwEgJLYvLDgXHhtZLWVZ9LBy
         FdUGrUws4o4oigb2SPtQAQHTuKF0IdF8kL4xK5BivsOauWYnIg6TmdMjhCe+LRIn0XQ2
         rJhOh1xfCxD/RPvXTLo+E51RIvZmeEYeNOYLWgH1sBWzT1EPhXmCBNB/Q/1S5MANxLnF
         NGiQd8bVy/PLQ10yJqVt2E93IrDTCl7ZbxxJ6pFK7pzRCuFWSO3qQSDl8t9NJBCZuDSY
         CqHw1/rGHV/nmHVxu+ODXHqgIX3AcrzFpHQfmGPguZeWuklWjJaYDEDbkYccFy7MsUTN
         YYaw==
X-Forwarded-Encrypted: i=1; AJvYcCXRry+Vy3R5iUL6Wxr3sCfttE5phaDzswhFRRLy3N3wKwfl2WkkjlssYI47zKanKk+0ES3i6u2JVSKDh50=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjrqKiBp2qnwv4BOisIPg+NL8uUSteS9SpSlBHmtBrCJgYd6cx
	TBBg0Ss5DN8K00KwQoDff0jvpJ62Mo+2pvWuYcDfPRuQxb01M7elOWmnKg9wHA2WRWOzSaitOEN
	2YSTngoNnqj0rFW9TcZvj95rWeob9ZC6179HNDmk6Uze/dsIsRbPo+W8=
X-Google-Smtp-Source: AGHT+IGM4P8g+P/xqgXlXPSOvSrmB/PNQ5Z6EW/IhzqSts0VYfiRKjLcz9UzpoSi75CVfI2RA6WVolB06KQIoaS4L4eU0xTQFoId
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a8a:b0:3a0:c15f:7577 with SMTP id
 e9e14a558f8ab-3a3b5f4976fmr78978865ab.9.1728847286172; Sun, 13 Oct 2024
 12:21:26 -0700 (PDT)
Date: Sun, 13 Oct 2024 12:21:26 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <670c1db6.050a0220.3e960.0044.GAE@google.com>
Subject: [syzbot] Monthly dri report (Oct 2024)
From: syzbot <syzbot+list6f950335a4c56f56249b@syzkaller.appspotmail.com>
To: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello dri maintainers/developers,

This is a 31-day syzbot report for the dri subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/dri

During the period, 0 new issues were detected and 0 were fixed.
In total, 18 issues are still open and 31 have been fixed so far.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 650     Yes   WARNING in drm_syncobj_array_find
                  https://syzkaller.appspot.com/bug?extid=95416f957d84e858b377
<2> 298     Yes   WARNING in vkms_get_vblank_timestamp (2)
                  https://syzkaller.appspot.com/bug?extid=93bd128a383695391534
<3> 55      No    INFO: task hung in drm_atomic_get_plane_state
                  https://syzkaller.appspot.com/bug?extid=eee643fdccb7c015b3a6
<4> 18      Yes   WARNING in drm_gem_prime_fd_to_handle
                  https://syzkaller.appspot.com/bug?extid=268d319a7bfd92f4ae01
<5> 17      Yes   WARNING in drm_wait_one_vblank (2)
                  https://syzkaller.appspot.com/bug?extid=147ba789658184f0ce04
<6> 11      Yes   divide error in drm_mode_vrefresh
                  https://syzkaller.appspot.com/bug?extid=622bba18029bcde672e1
<7> 4       Yes   divide error in drm_mode_debug_printmodeline
                  https://syzkaller.appspot.com/bug?extid=2e93e6fb36e6fdc56574
<8> 3       Yes   KASAN: slab-use-after-free Read in drm_atomic_helper_wait_for_vblanks (2)
                  https://syzkaller.appspot.com/bug?extid=0f999d26a4fd79c3a23b
<9> 2       Yes   WARNING in drm_prime_destroy_file_private (2)
                  https://syzkaller.appspot.com/bug?extid=59dcc2e7283a6f5f5ba1

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

