Return-Path: <linux-kernel+bounces-305840-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E5FC96351D
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 00:58:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4340A1C211AA
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 22:58:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F7081AE055;
	Wed, 28 Aug 2024 22:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="kbQvPOEd";
	dkim=pass (1024-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="Ob5pUIM3"
Received: from mx-lax3-2.ucr.edu (mx-lax3-2.ucr.edu [169.235.156.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34AC11AE03A
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 22:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=169.235.156.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724885884; cv=none; b=Jf84nSxWY+R/rCaBgvkqAuLHLVNjFuue18jqezgI+FkiBVUD1BJOBIdqkLtyPz/UUb5yGl94VgCF5Mtq9VoGw1epQqOZRxWi4XuFSAX3Q3Bm5Ret1c0lMN7n83lTgVPjmF4DX6ArkS3Uea2nLv4/tzNHthOkvE0vySYHBP8BrzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724885884; c=relaxed/simple;
	bh=mH/g7ll4FI7BDdOfh5JOlytsoVZVoCZLbdj/TexsXbk=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=pBy/JYLYhs8ljji5883SGDe/E6vx48Agp68+ds2Z4S+/ThjKkgz4Zn1hmnBRmhCZw1SuwSb4rDAWs5cAUc42maDl54qPbJAnwmfEX3qIrQK2BdaPzzWEA8CTaGuX+jgIaYGRbUy3iN2BHVlZJ5I3lkSyB/3exX+M19N9WAlZXR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ucr.edu; spf=pass smtp.mailfrom=ucr.edu; dkim=pass (2048-bit key) header.d=ucr.edu header.i=@ucr.edu header.b=kbQvPOEd; dkim=pass (1024-bit key) header.d=ucr.edu header.i=@ucr.edu header.b=Ob5pUIM3; arc=none smtp.client-ip=169.235.156.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ucr.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ucr.edu
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
  t=1724885883; x=1756421883;
  h=dkim-signature:x-google-dkim-signature:
   x-forwarded-encrypted:x-gm-message-state:
   x-google-smtp-source:mime-version:from:date:message-id:
   subject:to:cc:content-type:x-cse-connectionguid:
   x-cse-msgguid;
  bh=mH/g7ll4FI7BDdOfh5JOlytsoVZVoCZLbdj/TexsXbk=;
  b=kbQvPOEdOHvMJX3baV3y6bkbO2q3U6aXd+iIg/A6CAjf2XnNKY+xKR59
   SltOVBnIrhI9cyVg4ATJuQcoUo9Eb+HG2xhac7aAyppT9qdiUJI04CZS+
   XeqWM5Do6PD4k0k8YJyp4aUkJNCnW1xIS4MaXAbK6JIfW6itzTnEHirr7
   ShvpGTHQaWKXARun0NmnPrbpGVQ9bZoa8i0Y8qOH0bJsTRzbmM512G7PD
   AFrJNp6srUggI9oVQL8JqOohyEzLISQqdYC/2Fushn+fdB0Z1MTA8uvm1
   +ikNlSPq6h+cQRZ9oUxS1XEbSZrXRUKrSu9drIQJrYG11LOenuSp9jFlN
   A==;
X-CSE-ConnectionGUID: /wwQbudnTAGecH+9ngOFxw==
X-CSE-MsgGUID: B6+WJ8IhRkujTbke6GcJfw==
Received: from mail-pj1-f69.google.com ([209.85.216.69])
  by smtp-lax3-2.ucr.edu with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 28 Aug 2024 15:58:02 -0700
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2d5ebec87cdso36657a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 15:58:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ucr.edu; s=rmail; t=1724885882; x=1725490682; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=yLxVY8X/T4f7fRZ6UyOP0yKGoxXEhzabMD9FibXb7GE=;
        b=Ob5pUIM3xw8CRG8lpnzHLIAIYJNr5KyZs7YslwU1M6iuopuPc+xVyn7KXDnKG3tejf
         lOuVnAqSLNsUEyXf2Egi+LxBmlgeIlZ9BV3XantYzozWxFJVl7qBufRiZgG2OfATtKhV
         9zJ+qxO094yeKbPlNbxpwgTxnQG7tFxdvCANI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724885882; x=1725490682;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yLxVY8X/T4f7fRZ6UyOP0yKGoxXEhzabMD9FibXb7GE=;
        b=bUENHYaUyZnnKBnjSNrZgFgDVJQnhnaLKgw0P1DYlcUx5vg4KNlpOGK4novFMJNfdo
         6G7vhq4hzkkCmBjsiCkOnDBqNMDXvK+IMc4/66TOMD50YJ7w5VS320MejfQCNFe4E8X2
         0YsFKhWMPZ7ZMwgaM0rv/evVZBNMFD3Uo+DYmgTM5dpwdGgTgQgWp12eb2U9A4GFaBsa
         skvr3wJwYt4yWsNLpKiMyHHHZQNPqOi3ykZEDVqGQbmxYU2WHBJ1Dy/DzXJyEzdZz600
         lcjFftsxWToDLzwS0BaVRfYb2hLLYtm1bOj/Xk3jswkPnP0zOCvHAAfltsn9uaPae8OS
         BE5w==
X-Forwarded-Encrypted: i=1; AJvYcCVCFUbbiXQD5/g8A3rFqgaIh2qlX2HCBVxJQFUvqEFZve+I4TEfphOaLZdCJh6dbr/0lZjTwZm9z6wArZk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzANL5Jg5i3mKfPrB7HrDM1U6Be1T3SebMhp36WRnwQQQ4NxQgx
	YAX8+MR9UNEsJoN9y1SeBbkVhRKmIBTh8fjJXMtYJfiUvan43mLXUqUeJMIcSc8gYfDQr8aS0jd
	JNkgTIQOCZcf/lr9HWUAEqtXIm2YVQsjKURQLQexw6MdNe4KwdLF41GdhW5UZ698S2SliLFCF5d
	fdcUNuZ31keixKUW+06Af6BaKqdPq2/gn0TxQ2Fg==
X-Received: by 2002:a17:90b:17d2:b0:2c8:f3b7:ec45 with SMTP id 98e67ed59e1d1-2d8564af81cmr825633a91.36.1724885881818;
        Wed, 28 Aug 2024 15:58:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHXEe6dhUHQh465WEYk7KUByrrAZDRSly0qwGGKpGNnIr+sgNfIemlPXdgVS5YvdQVvQxPGAJKRxkeedJF+AwU=
X-Received: by 2002:a17:90b:17d2:b0:2c8:f3b7:ec45 with SMTP id
 98e67ed59e1d1-2d8564af81cmr825608a91.36.1724885881159; Wed, 28 Aug 2024
 15:58:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Xingyu Li <xli399@ucr.edu>
Date: Wed, 28 Aug 2024 15:57:50 -0700
Message-ID: <CALAgD-718DVmcVHtgSFGKbgr0ePoUjN2ST=gBtdYtGX5GUqBQg@mail.gmail.com>
Subject: BUG: kernel panic: corrupted stack end in sg_ioctl
To: dgilbert@interlog.com, James.Bottomley@hansenpartnership.com, 
	martin.petersen@oracle.com, linux-scsi@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Cc: Yu Hao <yhao016@ucr.edu>
Content-Type: text/plain; charset="UTF-8"

Hi,

We found a bug in Linux 6.10 using syzkaller. It is possibly a
corrupted stack  bug.
The reprodcuer is
https://gist.github.com/freexxxyyy/9025a217d3002b14deca0b14768c6f97

The bug report is:

Syzkaller hit 'kernel panic: corrupted stack end in sg_ioctl' bug.

Kernel panic - not syncing: corrupted stack end detected inside scheduler
CPU: 0 PID: 8135 Comm: syz-executor302 Not tainted 6.10.0 #13
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x23d/0x360 lib/dump_stack.c:114
 panic+0x331/0x850 kernel/panic.c:347
 schedule_debug+0x2a8/0x3f0 kernel/sched/core.c:5964
 __schedule+0x12b/0x15e0 kernel/sched/core.c:6630
 __schedule_loop kernel/sched/core.c:6825 [inline]
 schedule+0x143/0x310 kernel/sched/core.c:6840
 schedule_timeout+0x1b9/0x300 kernel/time/timer.c:2581
 io_schedule_timeout+0x96/0x120 kernel/sched/core.c:9034
 do_wait_for_common kernel/sched/completion.c:95 [inline]
 __wait_for_common kernel/sched/completion.c:116 [inline]
 wait_for_common_io+0x31c/0x620 kernel/sched/completion.c:133
 blk_wait_io block/blk.h:82 [inline]
 blk_execute_rq+0x369/0x4a0 block/blk-mq.c:1408
 sg_scsi_ioctl drivers/scsi/scsi_ioctl.c:593 [inline]
 scsi_ioctl+0x20fc/0x2c70 drivers/scsi/scsi_ioctl.c:901
 sg_ioctl_common drivers/scsi/sg.c:1109 [inline]
 sg_ioctl+0x16c3/0x2d50 drivers/scsi/sg.c:1163
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:907 [inline]
 __se_sys_ioctl+0xfe/0x170 fs/ioctl.c:893
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0x7e/0x150 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x67/0x6f
RIP: 0033:0x7f63634e0e0d
Code: c3 e8 37 25 00 00 0f 1f 80 00 00 00 00 f3 0f 1e fa 48 89 f8 48
89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d
01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f636347c1a8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f636357d088 RCX: 00007f63634e0e0d
RDX: 0000000020000080 RSI: 0000000000000001 RDI: 0000000000000003
RBP: 00007f636357d080 R08: 00007f636347c640 R09: 00007f636347c640
R10: 00007f636347c640 R11: 0000000000000246 R12: 00007f636357d08c
R13: 00007f63635412b4 R14: 2367732f7665642f R15: 00007f636345c000
 </TASK>
Kernel Offset: disabled
Rebooting in 86400 seconds..


-- 
Yours sincerely,
Xingyu

