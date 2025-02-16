Return-Path: <linux-kernel+bounces-516824-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F1A9DA377E3
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Feb 2025 22:53:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CC953AC8E5
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Feb 2025 21:53:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1480186E2F;
	Sun, 16 Feb 2025 21:53:21 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E84717F9
	for <linux-kernel@vger.kernel.org>; Sun, 16 Feb 2025 21:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739742801; cv=none; b=YCRc/WZVm06f4cKelzPgGP0mdS8EuuoaCbyvl+E08rSoXfkpkqmIDUL4qYJR32A1EfDaYZFpdrrbE0oYBY8Q3eln1xhALdyamZ1dEylatsAcVwxHghkgz+b9xHvDr3gIWrQETdFMmpxH1jLl3e9EcovcD6XJQ4Ma18lD4H+WV4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739742801; c=relaxed/simple;
	bh=jqxpR+ubeqf7XwRv49fyoxeARITrO1dNIIVYPKYzXVw=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=GVusVFwD2EjUgP3OjcdbnEkRPL+EmJGectww/s0ypIKnT54kBE9Xduw+2qnT0jNH9JWUh00ofdy3dy5gj8Q0FMXfD+rf//CW64IV5BjQL0a0A8HprayZ5hBgeVsoE13ATKzSoGHarXQawsmBX+jl8c4xq62gbGKmJH7kjunn6t8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3d14950ac9fso65868885ab.2
        for <linux-kernel@vger.kernel.org>; Sun, 16 Feb 2025 13:53:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739742799; x=1740347599;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XOfBMxwpE5LCQL4hdjYMcZ0d/YSDtMX/y7FtHuOSaHA=;
        b=GqQ8lM4HFefhF9W0X92SdraWA9Ygy6NdxSW5HDY99XlQMuECPmliIjM8ALvgZU1+Kh
         Y9icQlsLKJbV++uo8NErJ9FXedyFnGb1TwcPTpXwmVn8JCXqUwyZBWSzoRcIQ95Qmuhy
         aabB82sM4g3h4Q5zZZNaagvD3O0a/NG29Gq5cUl1pfdSruDs3gcCSuRis+yhdjf1mYL3
         XWrsjx4R8LIxakE7c9Wq9nj47pQRso0RfW3aPtCzdcog5HKRF1Vj0xVKPRKRO5IyR75B
         toeYRF4MZQINVPF089SGFKexpfTUOpEC8jQWAa0BW0FeauwhixZ53kNKjQyCRsIJDWme
         P9BA==
X-Forwarded-Encrypted: i=1; AJvYcCWe1Q9Za4vmxABWkUA274fzGoPbraqrsz9pm5PjK8FjAn0SzKZ2HzfqzTaeMaVYiMXmVYCD7xm6WKuk8bs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpArw/WzWp2HN7kuJkA0+943UrDu6CReEvT354PyrMu6VClhmZ
	ceQ9Ktynom/IkbH29N1MpSyA2U25A+bdXL3I/Ce/DHQnjtZUGaDGitSG9IcEnNa251qDdnRpcow
	Gx44JCpPEh9UaN47so4/iF85NLR5sEK+68qg9Ps+mVnt2sCzvSrx4NR4=
X-Google-Smtp-Source: AGHT+IH3BfTFF/ArCvplVT1gvTbDIQfeVlZ3B5/V/3F9ZRpWsDy/1yNTT46CYSfuz9HhIHoXr0Fe71teUfh9QNGJWoaRu5SY72CE
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3981:b0:3cf:b26f:ff7c with SMTP id
 e9e14a558f8ab-3d28076cc24mr64456395ab.5.1739742799164; Sun, 16 Feb 2025
 13:53:19 -0800 (PST)
Date: Sun, 16 Feb 2025 13:53:19 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67b25e4f.050a0220.173698.0014.GAE@google.com>
Subject: [syzbot] Monthly dri report (Feb 2025)
From: syzbot <syzbot+listd06d93ded4741f6db52a@syzkaller.appspotmail.com>
To: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello dri maintainers/developers,

This is a 31-day syzbot report for the dri subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/dri

During the period, 0 new issues were detected and 0 were fixed.
In total, 21 issues are still open and 32 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 361     Yes   WARNING in vkms_get_vblank_timestamp (2)
                  https://syzkaller.appspot.com/bug?extid=93bd128a383695391534
<2> 72      Yes   WARNING in drm_mode_create_lease_ioctl
                  https://syzkaller.appspot.com/bug?extid=6754751ad05524dae739
<3> 71      Yes   WARNING in drm_wait_one_vblank (2)
                  https://syzkaller.appspot.com/bug?extid=147ba789658184f0ce04
<4> 21      Yes   WARNING in drm_gem_prime_fd_to_handle
                  https://syzkaller.appspot.com/bug?extid=268d319a7bfd92f4ae01
<5> 5       Yes   KASAN: slab-use-after-free Read in drm_atomic_helper_wait_for_vblanks (2)
                  https://syzkaller.appspot.com/bug?extid=0f999d26a4fd79c3a23b
<6> 4       Yes   WARNING in drm_prime_destroy_file_private (2)
                  https://syzkaller.appspot.com/bug?extid=59dcc2e7283a6f5f5ba1
<7> 2       No    possible deadlock in drm_mode_obj_get_properties_ioctl
                  https://syzkaller.appspot.com/bug?extid=43b8370f38144ca1e467

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

