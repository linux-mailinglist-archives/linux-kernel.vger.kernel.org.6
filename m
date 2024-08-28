Return-Path: <linux-kernel+bounces-305909-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5252296363D
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 01:43:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 070771F21B9C
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 23:43:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80B801AE84C;
	Wed, 28 Aug 2024 23:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="BgIONApu";
	dkim=pass (1024-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="I10jGHXN"
Received: from mx6.ucr.edu (mx6.ucr.edu [138.23.62.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C8511684BB
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 23:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=138.23.62.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724888093; cv=none; b=d0q76sGW5ziFhlChPjv0mVFgyqmlM1gKq2DzCtwBUGFnyI1oy5uABuMtQK6Mm8Rzg0smnYABrHm0fV7EBTjJw4lrLLlmmA0JKYDsPPu2/Tn4DszmW1OW/iZTxprc9SexiNAULew0j5LbwEzjTJbJd5bxl/pgo0NplsD/1CXnPqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724888093; c=relaxed/simple;
	bh=xU+md2SetDkcYnHecB52y7DFrXKFh7mateJ7n0bOZaY=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=P28VGi58KcdvwopWSSwdhSJPbjUNLC3BjAol9b7YDdqvOYVyNXuHtEdI0s0LCp5rt0QTDPc4Hy0HW1Ns0HnagESmJ5ir16ZF5lTlqEif70KdoNpqlUmI2jYgieybY9kNPQYW3iH6H/uBWLmpmlt4s7lDPzUOuVAOZr7ahUPPlBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ucr.edu; spf=pass smtp.mailfrom=ucr.edu; dkim=pass (2048-bit key) header.d=ucr.edu header.i=@ucr.edu header.b=BgIONApu; dkim=pass (1024-bit key) header.d=ucr.edu header.i=@ucr.edu header.b=I10jGHXN; arc=none smtp.client-ip=138.23.62.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ucr.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ucr.edu
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
  t=1724888091; x=1756424091;
  h=dkim-signature:x-google-dkim-signature:
   x-forwarded-encrypted:x-gm-message-state:
   x-google-smtp-source:mime-version:from:date:message-id:
   subject:to:cc:content-type:x-cse-connectionguid:
   x-cse-msgguid;
  bh=xU+md2SetDkcYnHecB52y7DFrXKFh7mateJ7n0bOZaY=;
  b=BgIONApud7/bvaw+lT+7AqepcEnKp0pZO+NxQCriLkW31XOXTnZXR0pl
   Q8HjiRK+3UcZIFzzN2VLf1SxrYgzWOtteqafqrtiZD/McfnnoiUGwrD7k
   OKNKs1iqyEapTN9oDoWgnSga7K3Rcm5meJ+D1Tz4ieu6y1S06OkhbE5PB
   zqG7oX/BNQKSkvVegTniPW93thBnEVz6B1OFQ/nWTeoNuW6GhHJqZr9HS
   UTJCpJEEcZ988N8lBeTjqzTKPZ/8grP6PW7+zs/vunxSsnoMHPiVPVjLe
   AkZ5i4hw8dX03DEsLFzbnKH5M4z4K8hx/bjRytpIYTPt1ByNcAxxGir5U
   Q==;
X-CSE-ConnectionGUID: LPjPeBI6Rv6Ru3o5wmEccQ==
X-CSE-MsgGUID: HI2xtf3LRFylUKW+HdOnFw==
Received: from mail-il1-f197.google.com ([209.85.166.197])
  by smtpmx6.ucr.edu with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 28 Aug 2024 16:34:50 -0700
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-39d47fe875cso99115945ab.2
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 16:34:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ucr.edu; s=rmail; t=1724888090; x=1725492890; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9OfSZAS2IbNEBKOlhjo34CvGTPlpmaMUhKOP9nkqn58=;
        b=I10jGHXNAM0MdjwUpp/MQiv7yReBEowtvOsSnXXZMnoVk4ZKcn4XmqVlsJ94rgiYul
         4DLLXt7sPTFKIY5IDo1IRPjpzaUl0MJibtZI3i+rPaOunAmUupXljcQUT5M0LMCq0qi/
         7HjvOdNP+9OmK5Wkze5SPI1+G4JvIDQyW2hS4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724888090; x=1725492890;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9OfSZAS2IbNEBKOlhjo34CvGTPlpmaMUhKOP9nkqn58=;
        b=Ht2XHymkW/Uek4hUjlrjyWl5/rERLZh5p+Am6sGHPlhaKZoBKxZnj1zmPB88DdEyyM
         g6dL15TkUgdDdkM7kB5rimR4uj8tJ4RcQd2Unscjo2Qz6I0VMayz+/Dvs4Ewj/u5X3x7
         KZAT9jpCfv/a9Sfg6FQkwqF50uYUf16xYeOrbDzFukYSI+ZLCnGLSa4rgMbDnWkiR7DJ
         2J6+tatMKRxrmJJluT5PP9C9bjZBtdgB8R45EzX5ztgAGNiaVvRdGFlRNXJdpdbGid/Q
         jlhBaVS4NOvDMnOT7u07JrPbrIhsb+X+9EgE069nom2HJ2fqVhph/nMQJefkAO8MZM1q
         NpNA==
X-Forwarded-Encrypted: i=1; AJvYcCXep8JAMiIK3Q4W1jvJSeXnN8EgNHjFmyNxYRI967BAW8GIbHW9aCKlQO+kdlxi6Jjz1RLnrLQNedfUSh0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxrTK0IB1g42YslegqXvfhuKH9R7m3zn2wgjcDL/4WFqjswXrx
	xwc+Q3gH3PtPXPdTAEy6iYnLBPfeDBDSw+1v6h26SH98rzZSu9+YoktJFpRa13YwDdUdF6CFU39
	p7bM43xKZY+RMUFJr62YCDQGnwQ/5DfL1VDdoZB5KX2wI/++NsiicznPmqxQbJwreaYKwzmgBMS
	2ggWZciEi2v8e+0PTytChppCdqikSOPzowt+EbfA==
X-Received: by 2002:a05:6e02:2163:b0:39d:23e7:9709 with SMTP id e9e14a558f8ab-39f377fe8fbmr18823055ab.13.1724888090639;
        Wed, 28 Aug 2024 16:34:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHLz9RvA4l+Z6sywvQD2C5NkwUsJjLtb6kpT/TnPs6NQ9k1gr0Pw4jw9Y0tMH3qj56eN3Bb8OWpvGhLWZySCMQ=
X-Received: by 2002:a05:6e02:2163:b0:39d:23e7:9709 with SMTP id
 e9e14a558f8ab-39f377fe8fbmr18822925ab.13.1724888090313; Wed, 28 Aug 2024
 16:34:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Xingyu Li <xli399@ucr.edu>
Date: Wed, 28 Aug 2024 16:34:39 -0700
Message-ID: <CALAgD-7-Z+xbXwtvA9n9X2YE-B9f2bHFtyQxkX1uL+Yqd5zRuQ@mail.gmail.com>
Subject: BUG: corrupted list in neigh_destroy
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, dsahern@kernel.org, j.granados@samsung.com, 
	linux@weissschuh.net, judyhsiao@chromium.org, James.Z.Li@dell.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Yu Hao <yhao016@ucr.edu>
Content-Type: text/plain; charset="UTF-8"

Hi,

We found a bug in Linux 6.10 using syzkaller. It is possibly a
corrupted list bug.
The bug report is as follows, but unfortunately there is no generated
syzkaller reproducer.

Bug report:

list_del corruption, ffff88802cfc0d80->next is NULL
------------[ cut here ]------------
kernel BUG at lib/list_debug.c:53!
Oops: invalid opcode: 0000 [#1] PREEMPT SMP KASAN PTI
CPU: 0 PID: 4497 Comm: kworker/0:3 Not tainted 6.10.0 #13
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
Workqueue: events_power_efficient neigh_periodic_work
RIP: 0010:__list_del_entry_valid_or_report+0xc3/0x120 lib/list_debug.c:52
Code: 08 48 89 df e8 4e 01 96 fd 48 8b 13 4c 39 fa 75 62 b0 01 5b 41
5c 41 5e 41 5f c3 48 c7 c7 60 5a a9 8b 4c 89 fe e8 dd ff 96 06 <0f> 0b
48 c7 c7 c0 5a a9 8b 4c 89 fe e8 cc ff 96 06 0f 0b 48 c7 c7
RSP: 0018:ffffc90002ce7978 EFLAGS: 00010046
RAX: 0000000000000033 RBX: 0000000000000000 RCX: 31a71fdaa0dd1600
RDX: 0000000000000000 RSI: 0000000080000202 RDI: 0000000000000000
RBP: ffffc90002ce7ac8 R08: ffffffff8172e30c R09: 1ffff9200059ced0
R10: dffffc0000000000 R11: fffff5200059ced1 R12: dffffc0000000000
R13: ffff88802cfc0d80 R14: 0000000000000000 R15: ffff88802cfc0d80
FS:  0000000000000000(0000) GS:ffff888063a00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055dc1a4cee78 CR3: 000000000d932000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __list_del_entry_valid include/linux/list.h:124 [inline]
 __list_del_entry include/linux/list.h:215 [inline]
 list_move_tail include/linux/list.h:310 [inline]
 ref_tracker_free+0x191/0x7b0 lib/ref_tracker.c:262
 netdev_tracker_free include/linux/netdevice.h:4058 [inline]
 netdev_put include/linux/netdevice.h:4075 [inline]
 neigh_destroy+0x317/0x570 net/core/neighbour.c:914
 neigh_periodic_work+0x3c6/0xd40 net/core/neighbour.c:1007
 process_one_work kernel/workqueue.c:3248 [inline]
 process_scheduled_works+0x977/0x1410 kernel/workqueue.c:3329
 worker_thread+0xaa0/0x1020 kernel/workqueue.c:3409
 kthread+0x2eb/0x380 kernel/kthread.c:389
 ret_from_fork+0x49/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:244
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:__list_del_entry_valid_or_report+0xc3/0x120 lib/list_debug.c:52
Code: 08 48 89 df e8 4e 01 96 fd 48 8b 13 4c 39 fa 75 62 b0 01 5b 41
5c 41 5e 41 5f c3 48 c7 c7 60 5a a9 8b 4c 89 fe e8 dd ff 96 06 <0f> 0b
48 c7 c7 c0 5a a9 8b 4c 89 fe e8 cc ff 96 06 0f 0b 48 c7 c7
RSP: 0018:ffffc90002ce7978 EFLAGS: 00010046
RAX: 0000000000000033 RBX: 0000000000000000 RCX: 31a71fdaa0dd1600
RDX: 0000000000000000 RSI: 0000000080000202 RDI: 0000000000000000
RBP: ffffc90002ce7ac8 R08: ffffffff8172e30c R09: 1ffff9200059ced0
R10: dffffc0000000000 R11: fffff5200059ced1 R12: dffffc0000000000
R13: ffff88802cfc0d80 R14: 0000000000000000 R15: ffff88802cfc0d80
FS:  0000000000000000(0000) GS:ffff888063a00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055dc1a4cee78 CR3: 000000000d932000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


-- 
Yours sincerely,
Xingyu

