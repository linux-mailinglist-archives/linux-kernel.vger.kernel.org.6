Return-Path: <linux-kernel+bounces-196370-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 66C598D5AC5
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 08:50:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 983D61C222A3
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 06:50:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C9738062A;
	Fri, 31 May 2024 06:50:35 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5238C7BB0C
	for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 06:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717138234; cv=none; b=eHSOPPfvjYeyj4CAfM7sNPpzXQPBzJqITUMaDHOuo7B9Wsv47wOH2QiHoK1aAdOiR9BBFVnOvnouH6Txthx2cOT97K2G1LwBw8pkGZzZSteXrooNuVuL18lseUgIsJljTP0mEwS5uVC9M5yXcfDWfKGZLDXaOeThShH01N1Nc1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717138234; c=relaxed/simple;
	bh=W8fRjq7Z6y710iIkROTQ7PaNQUOchdeTRaZz7588gfY=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=FilFcsU9BeCdlcA4W5b9Y7aH2Vs4kawlhwBESh1hdZYp3iwg17eoD/UAaA2S9D2gH6Qv+k8lB4Onfra3q8lFw4caaZYMIPVfLq5eOq8MgSwtdHC/HZYoN2g3Tyy/GINe2Tmof7wk6uAikDxhrf3mHGX1DjH7nZS189dmu1qaQGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3747f77bafcso12762275ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 23:50:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717138232; x=1717743032;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0vrmo5/ch+u7W6jSFxsW+zK74pp2lMQV7jM4YwFzhww=;
        b=aGOo+ll1L4H8cAU1BDpuuJ+/d5G+IwRdo9lqtc1Vwmn+zFYaTMjT9/TlPxpwGUOXv5
         9MJHlXvteNUKK96Nfw5+uJYYX+GI8UxfL4hRpop3iIOV10+YM0DV1xN97a927gPqx6wX
         Ex70cT6QnTK7uf0Xdflypj2Cis5Twdh3+dQV4Pyq+Fogat9k0XvDWwCxayfah06xCP45
         jtA7bqaYR8kw6dB6BovEr7mbENlNyukelbiVXPIrFX5tDN/uewojoI1F7nRiaADYHAbL
         94eh62ovzHwqExAle8Jd29g34/16l9J+epG1uh/YeVeRkXZ/umCskpplUHk8kcbEgMuj
         spdQ==
X-Gm-Message-State: AOJu0YzIq5+4joGTOAnKm/8KI/jZbndvIswcEIy44aGFuA09PtX1cM8T
	8yXm3mzx+LNvXJ8IeoFwBQAfmIYICWCcgiyWkkHbOg7E1H8F3N+s3S/Db/2ZOtup/7Ns37VljkE
	FO6ZYc69S3uIdT68BDQS2SAzwcGmHZx3ECd6mP4g0D/vZLC24PYmoSIk=
X-Google-Smtp-Source: AGHT+IHtu4v0ERkxIQGbp2AR9qY7gfva9hE+/LAlzF/Y6AzElTm6868MwH+MeitESvwqbNkrAcYyf/GXzaR8LkRWxChDYG6aj/ir
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2167:b0:371:62ca:48ae with SMTP id
 e9e14a558f8ab-3748b9cf92cmr713135ab.3.1717138232568; Thu, 30 May 2024
 23:50:32 -0700 (PDT)
Date: Thu, 30 May 2024 23:50:32 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000061fac40619ba66f6@google.com>
Subject: [syzbot] Monthly trace report (May 2024)
From: syzbot <syzbot+list0820d438c1905c75bc71@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	mhiramat@kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello trace maintainers/developers,

This is a 31-day syzbot report for the trace subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/trace

During the period, 1 new issues were detected and 0 were fixed.
In total, 10 issues are still open and 35 have been fixed so far.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 705     Yes   WARNING in format_decode (3)
                  https://syzkaller.appspot.com/bug?extid=e2c932aec5c8a6e1d31c
<2> 26      Yes   INFO: task hung in blk_trace_ioctl (4)
                  https://syzkaller.appspot.com/bug?extid=ed812ed461471ab17a0c
<3> 7       Yes   WARNING in get_probe_ref
                  https://syzkaller.appspot.com/bug?extid=8672dcb9d10011c0a160
<4> 6       Yes   INFO: task hung in blk_trace_remove (2)
                  https://syzkaller.appspot.com/bug?extid=2373f6be3e6de4f92562
<5> 5       Yes   general protection fault in bpf_get_attach_cookie_tracing
                  https://syzkaller.appspot.com/bug?extid=3ab78ff125b7979e45f9

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

