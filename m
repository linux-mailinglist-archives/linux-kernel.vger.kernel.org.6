Return-Path: <linux-kernel+bounces-546793-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7FFBA4FECC
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 13:39:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 059E23A67E2
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 12:39:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60C1424502C;
	Wed,  5 Mar 2025 12:39:07 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81FFB244190
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 12:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741178347; cv=none; b=E5qS+yMU48O/ucLQ5aW1J+xFCP+pvRbn0u9YDkoROrzNreXYsB1ir518rLSn8ElV0yGM9dDg2cfbyAjtZGvBB+qn99835wSm67C+JrEbedcSua4+qE6SO6YSdp9j15OdvqDT9+EbTr7bULKoNPb+KS4pUVIFNe9BKZQ2vPuAPl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741178347; c=relaxed/simple;
	bh=IB7czfateYUHUxEiu47avZUPJwehR0r2MQVz3YPBNH0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Ln6fqCigIqVFw78/sluXhqnus/IeD88YGMixU7sUsNNN4jnYyxHXquAZAKM9wLV3Vc/YXYoXm0JkwslcsCyrDE/DKv5KBYmimKazcU5h8XD3iZU6FKNwfdEiIM+Ok2mqEWEV1UzbJnsbDZB/6Yrz76s+G5s+eAp/wB7FkFzJAfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-85add719f8dso238365139f.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Mar 2025 04:39:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741178344; x=1741783144;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RXpsMAPoj+4A1NN4Ax4EJwVniP3a5HWM+w5ZQXQDxTY=;
        b=oyq92E75wV40ZeYzrtnoJcjRKQ4lh2iJrZ54F0r/Rjpoqixys/f+ASJ/Vn73DW1f0+
         1tDlDt45j4dA+FyrmADSZmltEDHUmtJJa0kN9VdHlxTM+L0zVDce5gPx79/7cNxZG60k
         oH073WV/i1Wp1O1UASh45J8rNsE3yN6nKuX1u3vtg7LQp9FtXLvV/xr5nyb/Bda+1ikU
         vcKYPV8V3Z2IdmYRBEUkWvZqIQPrK80bAeAlUvymNX4SDbNH+8SjgYDxh2qD9q/RC79Z
         HfGA3zTpkskBJRr8hV1iT+r/8dawNfDMNu25vWlOX+QU44Nyewd4ZkmvkoDUmh6ZCanH
         /m/g==
X-Forwarded-Encrypted: i=1; AJvYcCUGadvSWobzXTeL6Zpkej6wu2tiWyV+gXdXVnhiYBVFlGP/5g+K7But8Jk1X2MCwU+mAeBFYD7lc0gk+6I=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmAa8PCoM4V3VYNWKjhIQp3xfrqx5ZaACjVxjhYi2i+v0N6ZFF
	x5HKfJH3a3Wk5xzOexhJYsJjKtbqU4x58kr8cXK0kN3zd83NccpVQ6/pqp97XD0SnpGjVq2L/3d
	9uv1l3vNEthMNjhvJWltVstrbDThIICsrhyjpmnL2+XX7EEi0HFp44Qk=
X-Google-Smtp-Source: AGHT+IGHm2gYjHfFwJicnispYrnljNMPIH58Mw8Z7efuMB0pGpl2d9WB9bCKmW3SVNoT5o6VQ/OODWMPKvHXJDNvrmuQk/fvfrLJ
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:184a:b0:3d3:fa64:c6ed with SMTP id
 e9e14a558f8ab-3d42b8a2fefmr36002275ab.7.1741178344641; Wed, 05 Mar 2025
 04:39:04 -0800 (PST)
Date: Wed, 05 Mar 2025 04:39:04 -0800
In-Reply-To: <tencent_39D0AED84CBEE7DC86D712DEC64CC9AFAE06@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67c845e8.050a0220.15b4b9.0021.GAE@google.com>
Subject: Re: [syzbot] [xfs?] [mm?] WARNING: bad unlock balance in __mm_populate
From: syzbot <syzbot+8f9f411152c9539f4e59@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
WARNING: lock held when returning to user space in __mm_populate

mm2: 00000000b2166d05, map held lock: 1, vma: 0000000029fbeeab, ret: -14, __get_user_pages
mm: 00000000b2166d05, vma: 0000000029fbeeab, mmap lock held: 1, locked: 0, ret: -14, mm addr is valid: 1, __mm_populate
================================================
WARNING: lock held when returning to user space!
6.14.0-rc4-syzkaller-ge056da87c780-dirty #0 Not tainted
------------------------------------------------
syz-executor198/8642 is leaving the kernel with locks still held!
1 lock held by syz-executor198/8642:
 #0: ffff0000d544a3d0 (&mm->mmap_lock){++++}-{4:4}, at: mmap_read_lock include/linux/mmap_lock.h:190 [inline]
 #0: ffff0000d544a3d0 (&mm->mmap_lock){++++}-{4:4}, at: __mm_populate+0x1a0/0x590 mm/gup.c:2017


Tested on:

commit:         e056da87 Merge remote-tracking branch 'will/for-next/p..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=1377d7a0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d6b7e15dc5b5e776
dashboard link: https://syzkaller.appspot.com/bug?extid=8f9f411152c9539f4e59
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64
patch:          https://syzkaller.appspot.com/x/patch.diff?x=17448254580000


