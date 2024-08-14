Return-Path: <linux-kernel+bounces-287130-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 93EA0952358
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 22:27:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C71AC1C214F4
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 20:27:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6691B1C37AA;
	Wed, 14 Aug 2024 20:27:05 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 795CC1BC070
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 20:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723667225; cv=none; b=Sma03YsoVubr2DU2I+2ZlXovpcjB7vaCqB0zcwyYUTJgJ/m0ju3IhSCZ5cmBDLDq7vJP+87nTlNrt4QbVgWByCq+lTMKKSal7BLDjLRd0QFVvkYxOfFmOq8J7So94Wg+UENa/C6hVvUXqb5WY/8UkNX+tzuULaEbTGviTaNjgVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723667225; c=relaxed/simple;
	bh=3/PzT+cBz/HOJNDvt4yEtBFL0FXMBuaIBLvF9Hf1vCY=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=H2z75WkjHnyHN/bH6iBXMwNy9BDzTM0dBGe1HGMhRR96r9FKWkEla+Iv3Fl3JiyigcpmaT0SCzfquhH+hvVjgDEJxrs9X7ZfxyqLAEIoVteb55Qi1mNvoeM8naKcHBNHMQnKa3fIE63tb4t263lzKaZ3czFmlbSiRr41SG2lGGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-81f9612b44fso35269139f.2
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 13:27:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723667222; x=1724272022;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=83cV3ypXX5lLzfQXzR0ZZM6JNuUWD5iCyFx0Gi5V0S0=;
        b=io4r9cLLDhl8384x8DGTGNhpf3LE4QbxEqpf3Cc1JGdL+HUb+IuWGZMOH5XccmGOru
         t4s3RuJ9yxdg4g2JW8ure3GwK2HdEtULN0GLTn0Ma5MZhX/q5aj3PTdz7+jsCBO0BWsc
         9HHG32SL3asWCzCGdVe2C6VsGgPPET3TXnWsN3FLjMey2nxtnCJODUGuUyLy7l88uvcj
         FidXOVAzNV4rHerl9oXY9b0PGSBQWHy9qvRZLfXpI39JOEFtSciKrKnDPoZpgd+5DePl
         s7xN1OzBm5W8uB2eGmGG+JmjdChOz1FUXykZKoA8TJLDVe/ioaLBN6O/xlFZDUBWFC5k
         23WA==
X-Forwarded-Encrypted: i=1; AJvYcCV/Lrcbht6l21zTxjc/lQ3tlAqweuJqsPqJ14dgN+gMkwITfv7+sMXP3rL+lT8IW/i7S/2C280i5I6gjMobpYb9tsuAoHDL7U/u1Il1
X-Gm-Message-State: AOJu0YynSr+78P49eB2QEsHsb4UFhR0FxaXR3YuCs+2Wo0cT6iYZPa5K
	Qp+doL78xqqqrqrJIUSaCs2i2OrggVFyNxXJx505Mp0yJD/HYXxYFtxak6bgOPeTz3xdm7Qdmvt
	X3GC/Zsvh7l4HUmL/pDarjDGg9TNplAaWGGLXyChrp1zCWHyKjMRsVJk=
X-Google-Smtp-Source: AGHT+IGgnkf3jTRzJsoAhA2dNqwPNx2+mABBXV6K4MoHEo45th6H/vN2XUgfe5+tWcNhYCc5epIjXA65FCuXQJN/rfrlGDDSka3u
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:60ca:b0:7f6:85d1:f82d with SMTP id
 ca18e2360f4ac-824dacef3e3mr22200539f.1.1723667222534; Wed, 14 Aug 2024
 13:27:02 -0700 (PDT)
Date: Wed, 14 Aug 2024 13:27:02 -0700
In-Reply-To: <tencent_537623A0A452D778B77A26C4736243668905@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000082aa87061faa8cfb@google.com>
Subject: Re: [syzbot] [f2fs?] WARNING: lock held when returning to user space
 in f2fs_ioc_start_atomic_write
From: syzbot <syzbot+733300ca0a9baca7e245@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
WARNING: lock held when returning to user space in f2fs_ioc_start_atomic_write

F2FS-fs (loop0): Mounted with checkpoint version = 48b305e5
syz.0.15: attempt to access beyond end of device
loop0: rw=10241, sector=45096, nr_sectors = 8 limit=40427
================================================
WARNING: lock held when returning to user space!
6.11.0-rc3-next-20240812-syzkaller-dirty #0 Not tainted
------------------------------------------------
syz.0.15/6178 is leaving the kernel with locks still held!
1 lock held by syz.0.15/6178:
 #0: ffff88807032a0e0 (&fi->i_gc_rwsem[READ]){+.+.}-{3:3}, at: f2fs_down_write fs/f2fs/f2fs.h:2196 [inline]
 #0: ffff88807032a0e0 (&fi->i_gc_rwsem[READ]){+.+.}-{3:3}, at: f2fs_ioc_start_atomic_write+0x2ed/0xac0 fs/f2fs/file.c:2163


Tested on:

commit:         9e686969 Add linux-next specific files for 20240812
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
console output: https://syzkaller.appspot.com/x/log.txt?x=16367cfd980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=61ba6f3b22ee5467
dashboard link: https://syzkaller.appspot.com/bug?extid=733300ca0a9baca7e245
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1510e1f5980000


