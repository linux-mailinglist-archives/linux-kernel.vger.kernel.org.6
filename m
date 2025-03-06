Return-Path: <linux-kernel+bounces-548146-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A737CA540CD
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 03:43:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D1B5A16A5EA
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 02:43:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8556F18EFDE;
	Thu,  6 Mar 2025 02:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JVjThDHu"
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D64F18BC20
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 02:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741228992; cv=none; b=PIIfLOsHZ1msTSwfnnS7zKbw0mo0bzVGLLEBSAXETERwAGax3xLD6XsxQqTfZOsNGhVz81gjlGE2L9oidqizUE8HSlFajrQTooPLPpLAYKv003vwWUMBwK/T27sERvXsNu7jYV13B0EVAvSuHlRn+ujOBPGdPNWbOMfb1eO8WmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741228992; c=relaxed/simple;
	bh=mGmVA41InuhWKFDP5IX+GXBDPzYWsKn7qwH08B/7Xbo=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=pycZSmcxgjTa5e0SSd3EMsN7WxO4hAmbqrzEz/Xntl6tT4rn5R15rffFy9SC4ua88nfEp3A6DuT6/JkpfoKQOr5eR3wQLPRf2nlfXL5T3Bjdih1YC/LXvboD7fNc+khKwk6OWtl2cnvT8TJulEUy3iymWUNdSZJGCnocBzNQFIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JVjThDHu; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-6e89c11fd8fso3295386d6.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Mar 2025 18:43:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741228990; x=1741833790; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=79veWWMEqpkUTSnr6eizZS2Ox0WRYptpzWwPvtn6UYE=;
        b=JVjThDHushBvekeP/HeZasPrMpaprZumpEvhZ3P77p326f5I4FpEysmzCHsgRj9NIT
         bi6hrgAiH1Q7uwNbzgYT0JkCAJpGywWKzyRTlH2cfdQArHIjcIaCV98E0uZGKy4zknXS
         u3PUtNiiaapUawX0Bo86DzyzNN9H3uCYnud0TdzZEl/70uExtOGj8VDIwV/JnMFF63ox
         /xZrYK6+jlkRSD0uDCOkciJHoaJbHWuF05codL7EZt3g0vklOltp1oMSrX64kkYMISBU
         le541aiV5YoApHppblAK6t4iu7D0C2dH7zrlsvT3nOZ8jwr81Lj+aDDtegVae+toQuHl
         oFNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741228990; x=1741833790;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=79veWWMEqpkUTSnr6eizZS2Ox0WRYptpzWwPvtn6UYE=;
        b=DTePURJ5E9cO8xSUnxCIXDFGqeW8HvM4URZ70mW2KXsnLKNdixjKSb+ZkYSnJCX/Du
         E0o72+I4H6J6SrHMQEzBxsuShH49M6O/dLK2R5GWk6RpIzaDxdIvT0+gq8w1Zofqo4AZ
         M9lw/vRduUyRmlDuwqV3fyPvt8YVRLy6CXvMNDK8jSFHbbukCUVJKR3AWqKv7avP9GCS
         BT9S0fpgc+T47Xbxv7YyV1m728/fJ9XDVJaHXVEPxSOVBrnZ6WlsPHO0po2yBgjN6uGb
         T8mGvmTHN9aL0SmPnTrSg7TYTD0jf5vVBFDkUhLdUpkBTNqSQSVxDjvsHSmBG03fPlvC
         9M1A==
X-Forwarded-Encrypted: i=1; AJvYcCUa5R9HSnsvqlHKjdEiWTQXMFjwtTNXDPJy8sAeK4NWxUN2e0wiBS0FSt3QEOcLHAEebizCjb0d/gm9kh4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz26yd8i3w0oXiCdnSsnGv4q22XvRH66C6iXFbyEK4AQP0CN8D4
	7LRJmWAWgJbpVTaddz0T7jjoDMXbh7kdFMt0AX9G5nDYTWPmNxBD/uFa0l0TgEQn0Yoy6Edck/X
	4fXtNKCd65tsy0tGNfe8Vws2aoazHkHOEQtJKbqGk
X-Gm-Gg: ASbGnctQ/QQYiKpANcQ1BV12mgGJ0YnFPJ57R6hyPOia7jvNY4oyQd8xAVE/xfnByS/
	XBRCixH9ps2tNsYegea7pCfFX1IQT63gagFDYZcREipmKYmjMGnc0NSkvkDDcsYxeJyPPwYaWqn
	tB0Rc/F6MR2mnkgcvOfOixJSkszFA=
X-Google-Smtp-Source: AGHT+IH3Vp5qfbw91pBfK04ImWE2cHJHPA97nGIuZNgdA2FsKaKMYthlzLsyZFtNIrZGDhcktmG51lqbgOGdS3/umM0=
X-Received: by 2002:a05:6214:5856:b0:6e8:f0f8:680e with SMTP id
 6a1803df08f44-6e8f0f869a1mr36062026d6.9.1741228989977; Wed, 05 Mar 2025
 18:43:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Luka <luka.2016.cs@gmail.com>
Date: Thu, 6 Mar 2025 10:42:58 +0800
X-Gm-Features: AQ5f1JrscYg_mdogcQmb8LzhvtNFir9gloUNfwlqY0sEklBQxTQ5tKBgXTyjDb4
Message-ID: <CALm_T+2cEDUJvjh6Lv+6Mg9QJxGBVAHu-CY+okQgh-emWa7-1A@mail.gmail.com>
Subject: Potential Linux Crash: WARNING in ext4_dirty_folio in Linux kernel v6.13-rc5
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
=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=
=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=
=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=
=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94Call
Trace=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=
=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=
=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=
=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=
=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=
=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=
=80=94

WARNING: CPU: 1 PID: 333 at mm/page_alloc.c:4240
__alloc_pages_slowpath mm/page_alloc.c:4240 [inline]
WARNING: CPU: 1 PID: 333 at mm/page_alloc.c:4240
__alloc_pages_noprof+0x1808/0x2040 mm/page_alloc.c:4766
Modules linked in:
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/=
2014
RIP: 0010:__alloc_pages_slowpath mm/page_alloc.c:4240 [inline]
RIP: 0010:__alloc_pages_noprof+0x1808/0x2040 mm/page_alloc.c:4766
Code: 89 fa 48 c1 ea 03 0f b6 14 02 48 89 f8 83 e0 07 83 c0 03 38 d0
7c 08 84 d2 0f 85 b3 07 00 00 f6 43 2d 08 0f 84 30 ed ff ff 90 <0f> 0b
90 e9 27 ed ff ff 44 89 4c 24 38 65 8b 15 c0 89 52 78 89 d2
RSP: 0018:ffff8880141ee990 EFLAGS: 00010202
RAX: 0000000000000007 RBX: ffff888012544400 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000002 RDI: ffff88801254442c
RBP: 0000000000048c40 R08: 0000000000000801 R09: 00000000000000f7
R10: 0000000000000000 R11: ffff88813fffdc40 R12: 0000000000000000
R13: 0000000000000400 R14: 0000000000048c40 R15: 0000000000000000
FS:  0000555589d15480(0000) GS:ffff88811b280000(0000) knlGS:000000000000000=
0
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055e47d593e61 CR3: 00000000141ce000 CR4: 0000000000350ef0
Call Trace:
 <TASK>
 alloc_pages_mpol_noprof+0xda/0x300 mm/mempolicy.c:2269
 folio_alloc_noprof+0x1e/0x70 mm/mempolicy.c:2355
 filemap_alloc_folio_noprof+0x2b2/0x2f0 mm/filemap.c:1009
 __filemap_get_folio+0x16d/0x3d0 mm/filemap.c:1951
 ext4_mb_load_buddy_gfp+0x42b/0xc00 fs/ext4/mballoc.c:1640
 ext4_discard_preallocations+0x45c/0xc70 fs/ext4/mballoc.c:5592
 ext4_clear_inode+0x3d/0x1e0 fs/ext4/super.c:1523
 ext4_evict_inode+0x1b2/0x1330 fs/ext4/inode.c:323
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
 alloc_pages_bulk_noprof+0x6d6/0xf40 mm/page_alloc.c:4701
 alloc_pages_bulk_array_mempolicy_noprof+0x1fd/0xcb0 mm/mempolicy.c:2559
 vm_area_alloc_pages mm/vmalloc.c:3565 [inline]
 __vmalloc_area_node mm/vmalloc.c:3669 [inline]
 __vmalloc_node_range_noprof+0x453/0x1170 mm/vmalloc.c:3846
 __vmalloc_node_noprof+0xad/0xf0 mm/vmalloc.c:3911
 xt_counters_alloc+0x32/0x60 net/netfilter/x_tables.c:1380
 __do_replace net/ipv4/netfilter/ip_tables.c:1046 [inline]
 do_replace net/ipv4/netfilter/ip_tables.c:1141 [inline]
 do_ipt_set_ctl+0x6d8/0x10d0 net/ipv4/netfilter/ip_tables.c:1635
 nf_setsockopt+0x7d/0xe0 net/netfilter/nf_sockopt.c:101
 ip_setsockopt+0xa4/0xc0 net/ipv4/ip_sockglue.c:1424
 tcp_setsockopt+0x9c/0x100 net/ipv4/tcp.c:4030
 do_sock_setsockopt+0xd3/0x1a0 net/socket.c:2313
 __sys_setsockopt+0x105/0x170 net/socket.c:2338
 __do_sys_setsockopt net/socket.c:2344 [inline]
 __se_sys_setsockopt net/socket.c:2341 [inline]
 __x64_sys_setsockopt+0xbd/0x160 net/socket.c:2341
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xa6/0x1a0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fc5c73fa87e
Code: 0f 1f 40 00 48 c7 c2 b0 ff ff ff f7 d8 64 89 02 48 c7 c0 ff ff
ff ff eb b1 0f 1f 00 f3 0f 1e fa 49 89 ca b8 36 00 00 00 0f 05 <48> 3d
00 f0 ff ff 77 0a c3 66 0f 1f 84 00 00 00 00 00 48 c7 c2 b0
RSP: 002b:00007ffc1866e9a8 EFLAGS: 00000206 ORIG_RAX: 0000000000000036
RAX: ffffffffffffffda RBX: 00007ffc1866ea30 RCX: 00007fc5c73fa87e
RDX: 0000000000000040 RSI: 0000000000000000 RDI: 0000000000000003
RBP: 0000000000000003 R08: 00000000000002d8 R09: 00007ffc1866ef30
R10: 00007fc5c75c0c60 R11: 0000000000000206 R12: 00007fc5c75c0c00
R13: 00007ffc1866e9cc R14: 0000000000000000 R15: 00007fc5c75c2dc0
 </TASK>

=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=
=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=
=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=
=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=
=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94Call
Trace=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=
=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=
=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=
=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=
=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=
=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=
=80=94

If you need more details or additional test results, please feel free
to let us know. Thank you so much for your attention! Please don't
hesitate to reach out if you have any suggestions or need further
communication.

Best regards,
Luka

