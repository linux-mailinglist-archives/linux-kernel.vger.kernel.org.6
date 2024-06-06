Return-Path: <linux-kernel+bounces-204127-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 395298FE48C
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 12:46:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58B6D1C24D42
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 10:46:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADF19194C80;
	Thu,  6 Jun 2024 10:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bs8GTU35"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 658D12E639
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 10:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717670757; cv=none; b=t/GratvkdtKdSLfQdX/rtysnD3U9GyRQj1gBMF17nEpmWFUJQ3f2veXEaPGp2sJmF/z+xgsCjG2x0PpEO1e/WGE/9u7jdNLFZ4DSzA949hLf/kej+Lpu9QRko5SuDbZMHOFasGO8VI80n3tvP/Ejd+98vacLaGvS4U7WMdNS/uM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717670757; c=relaxed/simple;
	bh=h3rlAL05qzuoEVAgqdyf4GZBDnMMNwXcIPdnVSrPw1o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H35/L8nNS9qfAAuvE8hHKxOgxh48PaLNxR07Tckm5OnPKZ/tPt3mm8Xc6Tde97jF6n/sCDab5SQdmfY7Da2QKJ6JxZi2raYT6Z0bwQyzjgYQ3CGh5SG8+N3YE/ZPxYKvMKtSOtFWRZ1a2hEZ15LOWoydkyfCXvu8eyznanfuKOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bs8GTU35; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-52b962c4bb6so1128749e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2024 03:45:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717670753; x=1718275553; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jP/P1r8f+yBhFT8klLxmUkK6v5m++uhvmhlQ2QteYiM=;
        b=bs8GTU354ru479OWw7pqCl6u2qhCnvWbXsuCHOucogadzx2LqnD1WNBtjuHsJtf5Hg
         Oh2kPwVHK3CUwerZwT9ODBIaC/dgpt5Y0Ok66UpTUjNchTwd9dHwLMIpuKFpNFIdz6mZ
         V1WqAyWNKfUCxIjB/Ix5R647Xt8inLqlAtVhzufk+QwH4XUoOqBgkPE0OGTWub2lbl1h
         do9vCTZkmq9h7WJbiGZm+vuGDj1BWTH1lX2SzqQ3/Qqso248hbv0YVvHN/LwKrI4ZbKD
         aTMc5kb/CqUwHkgR2YhvFtny6xonG/P7ZXK6atDy7OBr0MsrDen4DW8hRL0JfA47kUn5
         RvhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717670753; x=1718275553;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jP/P1r8f+yBhFT8klLxmUkK6v5m++uhvmhlQ2QteYiM=;
        b=cy2OQuCctpGLOpW06FvaomvNyltVJM/JaKqTspE3k9aa7j27bs5AWttCOImw02VEU4
         EIvBjkcz2E1B7Rr5WjxlDOXuPnH5v0d6mz1HDQjeLkBU3d1R0EQn97wJzrDLWt1Os1GK
         WCRruItH87xjW81cfrXsuAZL48pKpayRHw8jZdxjmgR2rG1ApyY1Z0CEqvnCiNDSy9J+
         wTh97PgEVrTvmShVeCi8KqF/cZPP9THDwL0yjYt5tkDzIun19uwFG5zBSUV304bRsdjy
         AWMmuLBPV0kzMVOjjyopP84RxyLx3AzTs1tcgTqwkSd2uJmxOHxkOia6t/bqgfmyDpPu
         9h2A==
X-Gm-Message-State: AOJu0Yyec+72l2TF5owGSbD0njpYVxcGanr9+toNA4Zn8VfuwNeHLfe0
	l9nqMrvWeXUZzyJT8Lt0nsmVD6Ms6HKYwpQhxt7ysIdfsGqPo7T1gXP7cFoxmBa1JvSyKJ1kc9I
	jv22v6LFDLlAxowe0in4xHo5qdzQ=
X-Google-Smtp-Source: AGHT+IHf+U8AmaOcxLHhcMMePjN2rSCYrwuCaaNR9m85rVCNdzEtI6ULy38kKvbCkgR2zOxbfRxUoUaw2XAbAu/eP50=
X-Received: by 2002:a05:6512:33ce:b0:51f:2f5a:54ae with SMTP id
 2adb3069b0e04-52bab4c9be7mr5099012e87.7.1717670753295; Thu, 06 Jun 2024
 03:45:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6e8b7716-c657-4f20-b509-6356b5c8075b.bugreport@ubisectech.com>
In-Reply-To: <6e8b7716-c657-4f20-b509-6356b5c8075b.bugreport@ubisectech.com>
From: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Date: Thu, 6 Jun 2024 19:45:36 +0900
Message-ID: <CAKFNMomUZp9QfMWxcncQW-V-i45sN38-XCTLPenTWkU7KTk0Mg@mail.gmail.com>
Subject: Re: kernel BUG in __folio_start_writeback
To: Ubisectech Sirius <bugreport@ubisectech.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, willy <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 6, 2024 at 7:01=E2=80=AFPM Ubisectech Sirius wrote:
>
> Hello.
> We are Ubisectech Sirius Team, the vulnerability lab of China ValiantSec.=
 Recently, our team has discovered a issue in Linux kernel 6.8. Attached to=
 the email were a PoC file of the issue.
>
> Stack dump:
>  __vm_munmap+0x13d/0x390 mm/mmap.c:2990
>  __do_sys_munmap mm/mmap.c:3007 [inline]
>  __se_sys_munmap mm/mmap.c:3004 [inline]
>  __x64_sys_munmap+0x62/0x90 mm/mmap.c:3004
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xd5/0x270 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x6f/0x77
> ------------[ cut here ]------------
> kernel BUG at mm/page-writeback.c:2991!
> invalid opcode: 0000 [#1] PREEMPT SMP KASAN NOPTI
> CPU: 1 PID: 12198 Comm: segctord Not tainted 6.8.0 #1
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/0=
1/2014
> RIP: 0010:__folio_start_writeback+0x6f3/0xad0 mm/page-writeback.c:2991
> Code: e8 a2 28 ce ff 48 89 ef e8 aa ed 1d 00 49 89 c7 e9 67 fd ff ff e8 8=
d 28 ce ff 48 c7 c6 e0 91 d7 8a 48 89 ef e8 7e 7c 0d 00 90 <0f> 0b e8 76 28=
 ce ff e8 c1 eb d9 08 e9 4b fb ff ff e8 67 28 ce ff
> RSP: 0018:ffffc900020ffa00 EFLAGS: 00010293
> RAX: 0000000000000000 RBX: ffff88804246c1f8 RCX: ffffc900020ff860
> RDX: ffff888018964980 RSI: ffffffff81bc8432 RDI: 0000000000000000
> RBP: ffffea00018b57c0 R08: 0000000000000001 R09: fffffbfff1eb0742
> R10: ffffffff8f583a17 R11: 0000000000000001 R12: 1ffff9200041ff45
> R13: 0000000000000000 R14: 0000000000000001 R15: ffffea00018b57c0
> FS:  0000000000000000(0000) GS:ffff88807ec00000(0000) knlGS:0000000000000=
000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f9cb42f0088 CR3: 00000000454c0000 CR4: 0000000000750ef0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> PKRU: 55555554
> Call Trace:
>  <TASK>
>  nilfs_segctor_prepare_write fs/nilfs2/segment.c:1697 [inline]
>  nilfs_segctor_do_construct+0x1c10/0x78a0 fs/nilfs2/segment.c:2113
>  nilfs_segctor_construct+0x8c7/0xb10 fs/nilfs2/segment.c:2418
>  nilfs_segctor_thread_construct fs/nilfs2/segment.c:2526 [inline]
>  nilfs_segctor_thread+0x3cc/0xf30 fs/nilfs2/segment.c:2610
>  kthread+0x2cc/0x3b0 kernel/kthread.c:388
>  ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
>  ret_from_fork_asm+0x1b/0x30 arch/x86/entry/entry_64.S:243
>  </TASK>
...
>
> Thank you for taking the time to read this email and we look forward to w=
orking with you further.

I believe this issue will be fixed by the following bug fix, which is
currently in the mm tree and will be merged into the mainline soon:

https://lkml.kernel.org/r/20240530141556.4411-1-konishi.ryusuke@gmail.com

After the merge, it will also be sent to the stable trees.

Please wait a little while until then.

Thanks,
Ryusuke Konishi

