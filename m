Return-Path: <linux-kernel+bounces-445874-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CA589F1CE3
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 07:06:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C269E188E20E
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 06:06:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C0117E76D;
	Sat, 14 Dec 2024 06:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qH06jJjl"
Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com [209.85.222.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7C9B27450
	for <linux-kernel@vger.kernel.org>; Sat, 14 Dec 2024 06:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734156394; cv=none; b=ZIoq/vWyzB8aGnz6fgvceiEh5bIl/MrkoRp9I61U4D5uWLBgEFiYIop7qejgVQCFkfKFz+gRwSye0X8T7gx7pGoTSveuS6PQhFhiLeYW85vN0uMshG3sTOhvNNCJo/uHsWa0UE2lwgc0ZImFVaaNdBaRhAo70SzZ6Boq6BdciAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734156394; c=relaxed/simple;
	bh=JE7IsIzLoE5ku+ZnAyg4dQH6FM6JByhvn9j/yEEgLvo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z+frvlPj2oAjPHY6Bil46hrPiIGbTqc2KbKt2QdOqO6qJAQbK0ERtPJECCOYNrDg1PFYKyZD/hD9hYlKDqqe2Trt0AHM18dCOh0Yb6XyvDPbUYulfG6yLRLnprj+iL3zUdJ0wURglfo3TjIlNwJ2viEqsAmn0JBBXQZS3+gWTuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qH06jJjl; arc=none smtp.client-ip=209.85.222.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ua1-f46.google.com with SMTP id a1e0cc1a2514c-85bb13573fbso732327241.1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 22:06:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734156391; x=1734761191; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+BvpiHD8VFIrHOGpdAZnsJorFC4PacPUGhTqUh5KljQ=;
        b=qH06jJjlZ4r8uOqnl+9uVAjzV0hyaqqvo4p4nYnS05/2c9f1z/4xTXKvSazJmk56cg
         odSV1Z4w4dnwTlcsvMplBCkFKGe7d0KSNmxYff8kP7jOEOCMO+hwgDJpxVrMR0ItCgC2
         FGWG7XSfZQM7SG0AVyv9hLDDrmgi0aMDEtEXdtwu2bfxbIoe26hs8S7bk32M8CMqkJA9
         xbCHuLPOF8NqxMp/j7KkyjjZOAecUmmk1lKH9hbh05dzXVNXIRIFHr6GsfCAFDXjgEiG
         KYqPmOmZDzVCcycLWN+IjauyQjNRcBOSL7/Yn1rBAGYsBO6S4MjugKRKD6BjGlE4nZVa
         7ecQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734156391; x=1734761191;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+BvpiHD8VFIrHOGpdAZnsJorFC4PacPUGhTqUh5KljQ=;
        b=qDUOY2OCu4Z7lgibDNmL1olKKUxfx3doZQtzOXtLBDJpyPBoNkeTleEuT+G+jmlP9U
         ul/ZnjGOJ14061NWa5OyUZKMa2cfJy0IFUVEv4ZJiB1lmKbGKTUtDk9+XK+Z/bN3F5xM
         ZTppzcevv5dGdFDSZabm2qPttICntP+CWS40kWtMTxirx01cpjZPlAcaLP8PssSmQS9+
         pu0abIBdPdNU6nEv33pW7R4L4TybBRvtTqIFaWDEtQ1FOkyihMu55FZLq/iJiD89zCUs
         IqP8zIPGPRIfr9UadLENjoyZo58+YDcZfDvi8z3xq7JXTWvpG4ZwfRo2hZtXith+kkvi
         Rymw==
X-Forwarded-Encrypted: i=1; AJvYcCXFwbtJjUtEsxy5CzJsOlBogoZXP2NmS+FjYbpWzOZmMRBckonZdk2x06+vmcqpolKfye9K23MUolmWZTs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1hrV/kDJlJhgBTcSvk03VD3cDPnNlb961WSj47jpW/RZ45/Hj
	Q6E9rB6xY+LEqcgi/MsqNxMk75krNsVnBOB/84yomCWXZxXXb8zga1c+i9bX6XpLcCl7e2Bhs6x
	MEGpepOBM5qPzgCESOW3lpLnDy+uLJ7gdbXU/
X-Gm-Gg: ASbGncu/QQxuCg7GOOpzHe4XU2vIZf5LT/c6RzRImHF0TaNrodsRFxipYYHn7tKVgk5
	hruF+ug6SYRB87VKbS2ImstDUUzTg28HV0pN24gd6RVONrSULBjpXBHkNUb/zG/BjJDOzxQ0=
X-Google-Smtp-Source: AGHT+IEEULGlR4gzfG513Xr/sAdXhmFBBjAh554QAfzSXWDIjxBcdEmJ2mmOeJhIWcz+U5EXab7jwZOv46YIrURnxfA=
X-Received: by 2002:a05:6102:26d4:b0:4b2:4a38:7b8f with SMTP id
 ada2fe7eead31-4b25ddaf066mr6412178137.17.1734156391292; Fri, 13 Dec 2024
 22:06:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <675d01e9.050a0220.37aaf.00be.GAE@google.com>
In-Reply-To: <675d01e9.050a0220.37aaf.00be.GAE@google.com>
From: Yu Zhao <yuzhao@google.com>
Date: Fri, 13 Dec 2024 23:05:54 -0700
Message-ID: <CAOUHufZ+UDx5pXD7b1pBC8P0Ubu1p2Z5r6Qx+ruT5g78q02Cxw@mail.gmail.com>
Subject: Re: [syzbot] [mm?] WARNING in lock_list_lru_of_memcg
To: syzbot <syzbot+38a0cbd267eff2d286ff@syzkaller.appspotmail.com>, 
	Kairui Song <kasong@tencent.com>
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 13, 2024 at 8:56=E2=80=AFPM syzbot
<syzbot+38a0cbd267eff2d286ff@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    7cb1b4663150 Merge tag 'locking_urgent_for_v6.13_rc3' of =
g..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D16e96b3058000=
0
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3Dfee25f93665c8=
9ac
> dashboard link: https://syzkaller.appspot.com/bug?extid=3D38a0cbd267eff2d=
286ff
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Deb=
ian) 2.40
>
> Unfortunately, I don't have any reproducer for this issue yet.
>
> Downloadable assets:
> disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7=
feb34a89c2a/non_bootable_disk-7cb1b466.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/13e083329dab/vmlinu=
x-7cb1b466.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/fe3847d08513/b=
zImage-7cb1b466.xz
>
> IMPORTANT: if you fix the issue, please add the following tag to the comm=
it:
> Reported-by: syzbot+38a0cbd267eff2d286ff@syzkaller.appspotmail.com
>
> ------------[ cut here ]------------
> WARNING: CPU: 0 PID: 80 at mm/list_lru.c:97 lock_list_lru_of_memcg+0x395/=
0x4e0 mm/list_lru.c:97
> Modules linked in:
> CPU: 0 UID: 0 PID: 80 Comm: kswapd0 Not tainted 6.13.0-rc2-syzkaller-0001=
8-g7cb1b4663150 #0
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.=
16.3-2~bpo12+1 04/01/2014
> RIP: 0010:lock_list_lru_of_memcg+0x395/0x4e0 mm/list_lru.c:97
> Code: e9 22 fe ff ff e8 9b cc b6 ff 4c 8b 7c 24 10 45 84 f6 0f 84 40 ff f=
f ff e9 37 01 00 00 e8 83 cc b6 ff eb 05 e8 7c cc b6 ff 90 <0f> 0b 90 eb 97=
 89 e9 80 e1 07 80 c1 03 38 c1 0f 8c 7a fd ff ff 48
> RSP: 0018:ffffc9000105e798 EFLAGS: 00010093
> RAX: ffffffff81e891c4 RBX: 0000000000000000 RCX: ffff88801f53a440
> RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
> RBP: ffff888042e70054 R08: ffffffff81e89156 R09: 1ffffffff2032cae
> R10: dffffc0000000000 R11: fffffbfff2032caf R12: ffffffff81e88e5e
> R13: ffffffff9a3feb20 R14: 0000000000000000 R15: ffff888042e70000
> FS:  0000000000000000(0000) GS:ffff88801fc00000(0000) knlGS:0000000000000=
000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000020161000 CR3: 0000000032d12000 CR4: 0000000000352ef0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <TASK>
>  list_lru_add+0x59/0x270 mm/list_lru.c:164
>  list_lru_add_obj+0x17b/0x250 mm/list_lru.c:187
>  workingset_update_node+0x1af/0x230 mm/workingset.c:634
>  xas_update lib/xarray.c:355 [inline]
>  update_node lib/xarray.c:758 [inline]
>  xas_store+0xb8f/0x1890 lib/xarray.c:845
>  page_cache_delete mm/filemap.c:149 [inline]
>  __filemap_remove_folio+0x4e9/0x670 mm/filemap.c:232
>  __remove_mapping+0x86f/0xad0 mm/vmscan.c:791
>  shrink_folio_list+0x30a6/0x5ca0 mm/vmscan.c:1467
>  evict_folios+0x3c86/0x5800 mm/vmscan.c:4593
>  try_to_shrink_lruvec+0x9a6/0xc70 mm/vmscan.c:4789
>  shrink_one+0x3b9/0x850 mm/vmscan.c:4834
>  shrink_many mm/vmscan.c:4897 [inline]
>  lru_gen_shrink_node mm/vmscan.c:4975 [inline]
>  shrink_node+0x37c5/0x3e50 mm/vmscan.c:5956
>  kswapd_shrink_node mm/vmscan.c:6785 [inline]
>  balance_pgdat mm/vmscan.c:6977 [inline]
>  kswapd+0x1ca9/0x36f0 mm/vmscan.c:7246
>  kthread+0x2f0/0x390 kernel/kthread.c:389
>  ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
>  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
>  </TASK>

This one seems to be related to "mm/list_lru: split the lock to
per-cgroup scope".

Kairui, can you please take a look? Thanks.

> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
>
> If the report is already addressed, let syzbot know by replying with:
> #syz fix: exact-commit-title
>
> If you want to overwrite report's subsystems, reply with:
> #syz set subsystems: new-subsystem
> (See the list of subsystem names on the web dashboard)
>
> If the report is a duplicate of another one, reply with:
> #syz dup: exact-subject-of-another-report
>
> If you want to undo deduplication, reply with:
> #syz undup
>

