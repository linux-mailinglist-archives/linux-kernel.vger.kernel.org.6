Return-Path: <linux-kernel+bounces-447087-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 41F7E9F2D2F
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 10:44:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DEF101884848
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 09:44:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AACED201100;
	Mon, 16 Dec 2024 09:44:23 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFF5E201033
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 09:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734342263; cv=none; b=sRsmcW0Saox7td7LyuhAM66sS61dUQEfCtoeB+lxHzZjnwrkl97nDZzqmANvS80jAW7wN8S+8VUqVheztpHGKiPj+GlfcprM2e1KjBImymP8t3iRDr3p5Bq4JMuaFMOGQjDeyVCUH3UQFrsNdt3BDtbfxsFutjSyFxkefK8DLMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734342263; c=relaxed/simple;
	bh=F2SjC0h/OdRY60mWc5uSsVjUgK6l5Cnrl7XaTv3guRE=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=iSAaXyJGW822nl+hyZEZlYPD92X7y5Qz/oQ2bqMK7FZhqyWvvVnCJHGbnViF3uWxZ3VAu4zlYCKZ+WqFNtFlKg5IW4R/1OmP6MNjLnV0nHNv4y1s9nqIVK4D/11ChuKAF6fNbdLLhO7GAV/eK0rf/tYbFQ6vp1MYlGas64I4vas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a9d195e6e5so39816165ab.2
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 01:44:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734342261; x=1734947061;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rQTFow5kBgqg7MVcn2fDaYhYjBgMHcFLjw9h5v8S15E=;
        b=Zi3Ldom27FCgDFoPcqWpWEX0WlVPgfcdpd5VvrLdcul8oT0/n0e2fiixzOmMINjPDP
         KSjnV17wfq+wHwfmRwfVJj/5r5HEM6dCfL/TQrSJ6JVi59tyeOjf3tWsxXDnmByfqrva
         5r5KBaSUEUnTJE6MhIUJKqlfZq4fAdmg6rNbOitdMdJWuhMLh2X751Tc2J4/7kBmaG/8
         DiJ46tdtrIgsHySJM/hq+n7oOdUCdfzoHb7LznlhoMHJO/3qFdDk4fdkg+UqTBhNmUSe
         vHMPxwx+ALORNhiTknO09qJGcw4jC/0iMBs77CHHP3aG/KvZuOTOxhpr81Ae8DaVVNnT
         ELJw==
X-Forwarded-Encrypted: i=1; AJvYcCXp32I4riqYE2NLZUiRXw1S6z71YJ7wDwif3+mI03BbWsJDSiZLCWpAsaFsp41qhQ1azYUPv9C0yW1zDmM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyX2dIb7YDJLByevVGo03dEMdnnUkFC+iNxn8cCrssN0NrUDO2r
	xWj+VQ5OPny4wzNEjqnPXf3bjKloU3DfX23GyAV8ZllTjTpab1v3qYw1/BTM1YXDbLUztfE4qIV
	HqO6G6iL8izBybwkJoJNxzRUDKJtftZS4c/fXuc9LHgTLL8MBRnNpH88=
X-Google-Smtp-Source: AGHT+IE32lVajrmmFMsx2oL8z54XtOUSw3a/mH6s1PlqARarrcIulnuMxdV5kYWZXeAofjzJ+wcZ6adrpUZlojlsIK+gxeTLyRSm
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:248c:b0:3a7:8d8e:e730 with SMTP id
 e9e14a558f8ab-3aff2dd5e5fmr108753445ab.22.1734342261004; Mon, 16 Dec 2024
 01:44:21 -0800 (PST)
Date: Mon, 16 Dec 2024 01:44:20 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <675ff674.050a0220.37aaf.0122.GAE@google.com>
Subject: [syzbot] Monthly dri report (Dec 2024)
From: syzbot <syzbot+listbe2d42c16524143e5dc9@syzkaller.appspotmail.com>
To: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello dri maintainers/developers,

This is a 31-day syzbot report for the dri subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/dri

During the period, 2 new issues were detected and 0 were fixed.
In total, 18 issues are still open and 31 have already been fixed.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  1064    Yes   WARNING in drm_syncobj_array_find
                   https://syzkaller.appspot.com/bug?extid=95416f957d84e858b377
<2>  331     Yes   WARNING in vkms_get_vblank_timestamp (2)
                   https://syzkaller.appspot.com/bug?extid=93bd128a383695391534
<3>  70      Yes   WARNING in drm_mode_create_lease_ioctl
                   https://syzkaller.appspot.com/bug?extid=6754751ad05524dae739
<4>  64      No    INFO: task hung in drm_atomic_get_plane_state
                   https://syzkaller.appspot.com/bug?extid=eee643fdccb7c015b3a6
<5>  47      Yes   WARNING in drm_wait_one_vblank (2)
                   https://syzkaller.appspot.com/bug?extid=147ba789658184f0ce04
<6>  19      Yes   WARNING in drm_gem_prime_fd_to_handle
                   https://syzkaller.appspot.com/bug?extid=268d319a7bfd92f4ae01
<7>  14      Yes   divide error in drm_mode_vrefresh
                   https://syzkaller.appspot.com/bug?extid=622bba18029bcde672e1
<8>  4       Yes   KASAN: slab-use-after-free Read in drm_atomic_helper_wait_for_vblanks (2)
                   https://syzkaller.appspot.com/bug?extid=0f999d26a4fd79c3a23b
<9>  4       Yes   WARNING in drm_prime_destroy_file_private (2)
                   https://syzkaller.appspot.com/bug?extid=59dcc2e7283a6f5f5ba1
<10> 4       Yes   divide error in drm_mode_debug_printmodeline
                   https://syzkaller.appspot.com/bug?extid=2e93e6fb36e6fdc56574

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

