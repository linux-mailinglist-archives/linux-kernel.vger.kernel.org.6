Return-Path: <linux-kernel+bounces-548152-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 39052A540DE
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 03:54:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 695BF1888B07
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 02:54:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A92971917E7;
	Thu,  6 Mar 2025 02:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zs+9cc4V"
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59C8627453
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 02:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741229668; cv=none; b=P9NmaXPa1CJZKZiYROEvB6hJFEjAulRDaqB/2gyvr1uiO0SQXUJP4yupFKfXF3F6JM0VlVod2yj7Fw8hq46tyoyXBMf8Z1/83aW/ICV/DKKbsuDDdmY7JrGRX2EKh+UVq4ujQsyWWrEizsEnB17R5gjWwcJll6tkPVoP8dLrsM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741229668; c=relaxed/simple;
	bh=/bx/TK+se18NueBvtvWpP/CeKeax/OVXBYZ85qs92oo=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=oPYBRdoneaV1fkQz+E/AkMnBornDNkwrcYSGpoK0Op5vBQIZwr7gl0GCiACMnUU9NW65SsqIQGUBzi3mYJ+oopDtc7bcnBWrJvHFEmH6Wbu6p0/1Qkj7/PUbojTL9+Fa8nPnLS6fqPy2eS71E688hx+FMoR+jXk8wiFm4FdJR+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zs+9cc4V; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6dcd4f1aaccso3666496d6.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Mar 2025 18:54:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741229665; x=1741834465; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=La1vrXM49WIvGoFatuu+fv2Ac+4bPLm8I7lWbAdr8WQ=;
        b=Zs+9cc4VbpleSXEw3v6Ita65IFhUzV0JNgPwET6vK8XnMQqwHohklpC03nm/m4x6Ds
         zqF5Zjg6geuy3DC/p2DZXkGVFP/+st1LJV9V8/Z4XDqiPUeBIK6YcBey7gBEPOuaQAXs
         oWplS4hvSOPHLOD7Xf5YaCw+6AQUhFuLv/owfRxteVCKDq2N+NsgLGwDZAu6HicnHhgz
         a5Uy4q+4EbbdjLJ+W/aNTckF5dOJKjXMe2pbJ58URAWdxA3OIIyP9r7mX5j4yhjOmcLW
         irIXBWUT2SLMhhxDQiEO4C7ZIEDEZXGPeRMiZqABGsSH34MwID9R+TAf9cdlNKe5aKZK
         iKPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741229665; x=1741834465;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=La1vrXM49WIvGoFatuu+fv2Ac+4bPLm8I7lWbAdr8WQ=;
        b=vNCR0YpeJy0mxeipvaznSZH/PhWVQPABIlVTw4zIBlQ7lU0BYu81V80UH4exaqBTL9
         3iEeg58czRQqSguuv7L5Nzn+Px/Ue/nmyJDrh6BlinCBvyIFpPYYsVYjwF7YYE7zpZC1
         hc5yK5CheQjgpaHHXF+vRNgfksmSq1+D1pcRbm3U69w7HsfZW+3PE38dOb/wccRWdWjl
         FUUeIxqMpwtp3iCsBB9Zoq1wr++ckHaKHvmUQvgjQjD0FohJfcA/f+N/kHFpX/N+YinV
         7EeR/l0hItp48E+dCE0DGPsGfJ0Qx3DMzGAeNtOMxivQbTFV909f7e81IwfOItaxhjsW
         z36g==
X-Forwarded-Encrypted: i=1; AJvYcCWyj+Ki8Bi3XFP1wkUY3uC9WwX8kSGlhIVESEcLB7SHftyJ2lEmkylbmK2VfO0lIJ5A2QQfa13oC1cec+Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy46TeWDn8GjEC4Cb3qURfh4JwUt6ovGrV6GowFu8bbWe1xzECO
	9OdvvW8RWAY/psAb1vBYcD2MIj72iUk67nNVGd6yVpLd8mZVM2oJWHorR1T5abY8ZJUqXwwxyYK
	okedvZfj6UjO6DL/GRqxGBmDiua38rdTzuqaLhA==
X-Gm-Gg: ASbGnctBi4Cs1zzVuAeySS82+V4V8AY3dmASGCBSeVcY3vueQseslXSIXw0jp98xBbp
	EbaUiKvuaLp9DNNw1YnrEDLycXONS+PRHo45Hu8fkS5/MsfFUV966ZtVYiCMsCcxAnb6z9gWjtk
	O3AP9h0nvBCqouNlPwfg3Sjqp4OP8=
X-Google-Smtp-Source: AGHT+IEMfbqYPw/8yX/lCHMQC6HRTPN1zj2yIkpPp1LH+IeUa3AmTNwz322xMc58zyomIPKTvQilN+ZQ3Xwj2ve4GL8=
X-Received: by 2002:a05:6214:628:b0:6d4:25c4:e775 with SMTP id
 6a1803df08f44-6e8e6cd1a2amr65756066d6.15.1741229665092; Wed, 05 Mar 2025
 18:54:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Luka <luka.2016.cs@gmail.com>
Date: Thu, 6 Mar 2025 10:54:13 +0800
X-Gm-Features: AQ5f1JpvJe_SssUNkbY027VqZMcJvxpenWzMx3WhejsxA02A75cS0J1ArFq_kvY
Message-ID: <CALm_T+3j+dyK02UgPiv9z0f1oj-HM63oxhsB0JF9gVAjeVfm1Q@mail.gmail.com>
Subject: Potential Linux Crash: WARNING in __getblk_slow in Linux kernel v6.13-rc5
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Dear Linux Kernel Experts,

Hello!

I am a security researcher focused on testing Linux kernel
vulnerabilities. Recently, while testing the v6.13-rc5 Linux kernel,
we encountered a crash related to the mm kernel module. We have
successfully captured the call trace information for this crash.

Unfortunately, we have not been able to reproduce the issue in our
local environment, so we are unable to provide a PoC (Proof of
Concept) at this time.

We fully understand the complexity and importance of Linux kernel
maintenance, and we would like to share this finding with you for
further analysis and confirmation of the root cause. Below is a
summary of the relevant information:

Kernel Version: v6.13.0-rc5

Kernel Module: mm/page_alloc.c

=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=
=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94CallTr=
ace=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=
=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94

WARNING: CPU: 2 PID: 18804 at mm/page_alloc.c:4240
__alloc_pages_slowpath mm/page_alloc.c:4240 [inline]
WARNING: CPU: 2 PID: 18804 at mm/page_alloc.c:4240
__alloc_pages_noprof+0x1808/0x2040 mm/page_alloc.c:4766
Modules linked in:
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/=
2014
RIP: 0010:__alloc_pages_slowpath mm/page_alloc.c:4240 [inline]
RIP: 0010:__alloc_pages_noprof+0x1808/0x2040 mm/page_alloc.c:4766
Code: 89 fa 48 c1 ea 03 0f b6 14 02 48 89 f8 83 e0 07 83 c0 03 38 d0
7c 08 84 d2 0f 85 b3 07 00 00 f6 43 2d 08 0f 84 30 ed ff ff 90 <0f> 0b
90 e9 27 ed ff ff 44 89 4c 24 38 65 8b 15 c0 89 b2 7a 89 d2
RSP: 0018:ffff888003f8e868 EFLAGS: 00010202
RAX: 0000000000000007 RBX: ffff88813e720000 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000002 RDI: ffff88813e72002c
RBP: 0000000000148c48 R08: 0000000000000801 R09: 00000000000000e6
R10: 0000000000000000 R11: ffff88813fffbc40 R12: 0000000000000000
R13: 0000000000000400 R14: 0000000000148c48 R15: 0000000000000000
FS:  00007f361ea66640(0000) GS:ffff88811b300000(0000) knlGS:000000000000000=
0
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fecaa5cd342 CR3: 0000000111a6e000 CR4: 0000000000350ef0
Call Trace:
 <TASK>
 alloc_pages_mpol_noprof+0xda/0x300 mm/mempolicy.c:2269
 folio_alloc_noprof+0x1e/0x70 mm/mempolicy.c:2355
 filemap_alloc_folio_noprof+0x2b2/0x2f0 mm/filemap.c:1009
 __filemap_get_folio+0x16d/0x3d0 mm/filemap.c:1951
 grow_dev_folio fs/buffer.c:1039 [inline]
 grow_buffers fs/buffer.c:1105 [inline]
 __getblk_slow+0x138/0x430 fs/buffer.c:1131
 bdev_getblk fs/buffer.c:1431 [inline]
 __bread_gfp+0xea/0x2c0 fs/buffer.c:1485
 sb_bread include/linux/buffer_head.h:346 [inline]
 fat12_ent_bread+0x231/0x3f0 fs/fat/fatent.c:86
 fat_ent_read+0x624/0xaa0 fs/fat/fatent.c:368
 fat_free_clusters+0x19c/0x860 fs/fat/fatent.c:568
 fat_free.isra.0+0x377/0x850 fs/fat/file.c:376
 fat_truncate_blocks+0x10d/0x190 fs/fat/file.c:394
 fat_free_eofblocks fs/fat/inode.c:633 [inline]
 fat_evict_inode+0x1b1/0x260 fs/fat/inode.c:658
 evict+0x337/0x7c0 fs/inode.c:796
 dispose_list fs/inode.c:845 [inline]
 prune_icache_sb+0x189/0x290 fs/inode.c:1033
 super_cache_scan+0x33d/0x510 fs/super.c:223
 do_shrink_slab mm/shrinker.c:437 [inline]
 shrink_slab+0x43e/0x930 mm/shrinker.c:664
 shrink_node_memcgs mm/vmscan.c:5931 [inline]
 shrink_node+0x4dd/0x15c0 mm/vmscan.c:5970
 shrink_zones mm/vmscan.c:6215 [inline]
 do_try_to_free_pages+0x284/0x1160 mm/vmscan.c:6277
 try_to_free_pages+0x1ee/0x3e0 mm/vmscan.c:6527
 __perform_reclaim mm/page_alloc.c:3929 [inline]
 __alloc_pages_direct_reclaim mm/page_alloc.c:3951 [inline]
 __alloc_pages_slowpath mm/page_alloc.c:4382 [inline]
 __alloc_pages_noprof+0xa48/0x2040 mm/page_alloc.c:4766
 alloc_pages_mpol_noprof+0xda/0x300 mm/mempolicy.c:2269
 pagetable_alloc_noprof include/linux/mm.h:2899 [inline]
 __pte_alloc_one_noprof include/asm-generic/pgalloc.h:70 [inline]
 pte_alloc_one+0x20/0x1b0 arch/x86/mm/pgtable.c:33
 do_fault_around mm/memory.c:5274 [inline]
 do_read_fault mm/memory.c:5313 [inline]
 do_fault mm/memory.c:5456 [inline]
 do_pte_missing mm/memory.c:3979 [inline]
 handle_pte_fault mm/memory.c:5801 [inline]
 __handle_mm_fault+0x15b9/0x2380 mm/memory.c:5944
 handle_mm_fault+0x1c6/0x4c0 mm/memory.c:6112
 faultin_page mm/gup.c:1196 [inline]
 __get_user_pages+0x421/0x2550 mm/gup.c:1494
 populate_vma_page_range+0x16b/0x200 mm/gup.c:1932
 __mm_populate+0x1c2/0x360 mm/gup.c:2035
 mm_populate include/linux/mm.h:3396 [inline]
 vm_mmap_pgoff+0x25d/0x2f0 mm/util.c:585
 ksys_mmap_pgoff+0x5a/0x480 mm/mmap.c:542
 __do_sys_mmap arch/x86/kernel/sys_x86_64.c:89 [inline]
 __se_sys_mmap arch/x86/kernel/sys_x86_64.c:82 [inline]
 __x64_sys_mmap+0x108/0x170 arch/x86/kernel/sys_x86_64.c:82
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xa6/0x1a0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f361f7a842d
Code: c3 e8 97 2b 00 00 0f 1f 80 00 00 00 00 f3 0f 1e fa 48 89 f8 48
89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d
01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f361ea66038 EFLAGS: 00000246 ORIG_RAX: 0000000000000009
RAX: ffffffffffffffda RBX: 00007f361f99c050 RCX: 00007f361f7a842d
RDX: 0000000000000003 RSI: 0000000000b36000 RDI: 0000000020000000
RBP: 00007f361f867922 R08: ffffffffffffffff R09: 0000000000000000
R10: 0000000000008031 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000006e R14: 00007f361f99c050 R15: 00007f361ea46000
 </TASK>

=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=
=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94CallTr=
ace=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=
=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94

If you need more details or additional test results, please feel free
to let us know. Thank you so much for your attention! Please don't
hesitate to reach out if you have any suggestions or need further
communication.

Best regards,
Luka

