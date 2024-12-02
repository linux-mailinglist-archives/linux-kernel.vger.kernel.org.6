Return-Path: <linux-kernel+bounces-426898-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 865959DF9EA
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 05:32:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E46C163506
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 04:31:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C89331F8AE8;
	Mon,  2 Dec 2024 04:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fMNTCLNh"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7467E28399
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 04:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733113881; cv=none; b=Lal3/l9iC2FgXGsTOuWtKLyPaTMyOmypyqxAYNUEh+W9wfssyKz9y+fQp6CzIthBlyvQJywXk+DDYUAl/HYeoIVpgcmt7dhq+EWi0/s0G3+DX/q6ssxU+zwp+GmM98XnErVisztW8gsRgAYqGOMK1RhVvjIo8Z+Cw34ZjplmZFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733113881; c=relaxed/simple;
	bh=I8V/7V3SVx8vuQQOsrk4tQa3kHCsx1BzJ9FYIb8rnbs=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=KYnPqcdbAXZ3bYGOeP6uT3b2GeVlG+6plb0MwxAoS2SWJCXkgb+ThxcZRSMq6afCivebiPsuL05c237KroVA6JQFhwqQAUMJbME5yt+DumGJmmWG+8G3Fu12A480uZ19wE2IIkk+G3eLWMOrS+nEPYSa2z6NGJ8F2exqMg82W6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fMNTCLNh; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5d0cfb9fecaso2334833a12.2
        for <linux-kernel@vger.kernel.org>; Sun, 01 Dec 2024 20:31:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733113878; x=1733718678; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=I8V/7V3SVx8vuQQOsrk4tQa3kHCsx1BzJ9FYIb8rnbs=;
        b=fMNTCLNhCyqmCfjeGCssWz5e7LEqOqhewVUmoLqavUvxHUrtlJlo0CMGUFXz5m1RGG
         XzguxwpoFFjR7YYfbFQAQbuPHF/rk6QyOVVgy6w9BtbFoz+NjDGGvMr+0cn8TifPvo4l
         Yn2yltsRavzFhWwlBQQchuMLjvIRuJpmYqqe9G6Xk+lrUtQG5mOibpVJ4b4BA/2wk0YR
         IoLPLz9Ul6QMbDvW4GCu+hJhZVD33A1bcHOS7VLJ8Ce4pNuYWykxA2/rTGP5kevJacth
         KyaNxwUBTpnaez0t6TYeOqNqUyciTGf5CCPwI5Ih6UfFqdy6+jcX5zWOchZ5LH78aYM7
         ktDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733113878; x=1733718678;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=I8V/7V3SVx8vuQQOsrk4tQa3kHCsx1BzJ9FYIb8rnbs=;
        b=nPHScSsUjOeOzDLGIt1VMd0LwORN+3Innc4lZoXphItsRz04VfpYpDgg7r+xnmS/YM
         barNc55X02Y8rMXNxIjdU/MwbbT3LGijvjwimwMOBDbdgaudC0wMW+9+bRuVST6ywWcs
         8c7eQZFJO8SVu8BNYW3HqfzkIcjuSP1CGnu37WFt/RpKfKWYyFlmLIHMXZKqDlOY2Hu7
         9RefnGYALkfulOTcSFXBMrJBVggXhY08tASTlbztbBonWGWiaEqRhdF+xQP7t1TaRM8H
         PfKGeK3THP8yAjcVWxYcVHJ6KWSziSrC5Iu4YRRil0HG1NTo6D2vbx+qsJPKTaVRxg8c
         5Rng==
X-Gm-Message-State: AOJu0YyAgE0c7cmwZ3juIYltJGz8JI0v9VgEKoP2fWqV2nd5uKELTtr5
	monpC9ub4gX5LNJX9lUee3MI6svFzmKsE4T4HVIn2nayUA47wmv4NlUF27ZV1hlUmaQup63qpNh
	ghU5ccf0uDlNU0okwm54RWwsvTF6bnZyg
X-Gm-Gg: ASbGnctikBeRtoJ6sSjI1nK2vABlXhH1gZdfR+vjgTKAB/TYrB+xvS+OzhAAsWG1mgj
	GHAfPDTBdsLAP1jCHWwHUSDwldhhyGj++
X-Google-Smtp-Source: AGHT+IGBc60EUzgfQIO7x7pMmvCDDu/Dey9ki/bSYlFsQ5WT4Ja2RhHgyzpAHffW3V8MuV7/7xKCWD8Wd2UQJOJPAqE=
X-Received: by 2002:a17:906:cd1:b0:aa5:5711:18b8 with SMTP id
 a640c23a62f3a-aa581062dfdmr1745535966b.59.1733113877556; Sun, 01 Dec 2024
 20:31:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: cheung wall <zzqq0103.hey@gmail.com>
Date: Mon, 2 Dec 2024 12:31:06 +0800
Message-ID: <CAKHoSAswYPiyoc3UegpLv2yOSk2OOZuSYLPYJ47B=uvSbtF0tg@mail.gmail.com>
Subject: "Bug in vsscanf" in Linux kernel Version 2.6.26
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

I am writing to report a potential vulnerability identified in the
Linux Kernel version 2.6.26.
This issue was discovered using our custom vulnerability discovery
tool.

Affected File:

File: lib/vsprintf.c
Function: vsscanf

Detailed call trace:

[ 2020.553690] RIP [<ffffffffa030b3a0>] :sch_dsmark:dsmark_init+0x45/0x123
[ 2020.553691] RSP <ffff8101711a39a8>
[ 2020.553691] CR2: 0000000000000004
[ 2020.558108] ---[ end trace 9deab910d1f789fc ]---
[ 2190.055853] BUG: unable to handle kernel NULL pointer dereference
at 0000000000000000
[ 2190.056043] IP: [<ffffffff8031edcc>] vsscanf+0x600/0x657
[ 2190.056131] PGD 158d4c067 PUD 1691c4067 PMD 0
[ 2190.056209] Oops: 0000 [5] SMP
[ 2190.056267] CPU 16
[ 2190.056311] Modules linked in: sch_dsmark pppoe pppox l2cap
xfrm6_mode_transport crypto_null crypto_blkcipher nfnetlink_queue
dummy inet_diag fuse sch_sfq llc2 xfrm4_mode_transport tun ppp_generic
slhc xfrm_user nf_conntrack_netlink nf_nat nf_conntrack_ipv4
nf_conntrack hci_uart bluetooth nfnetlink sctp libcrc32c 9p 9pnet
xfrm4_tunnel tunnel4 ipcomp xfrm4_mode_tunnel deflate zlib_deflate
zlib_inflate af_key ipv6 loop snd_pcsp snd_pcm snd_timer serio_raw
button snd parport_pc container soundcore parport snd_page_alloc
i2c_piix4 psmouse i2c_core evdev ext3 jbd mbcache ide_cd_mod ide_disk
cdrom ata_generic libata scsi_mod dock ide_pci_generic floppy piix
e1000 ide_core thermal processor fan thermal_sys
[ 2190.059364] Pid: 23203, comm: a.out Tainted: G D 2.6.26-1-amd64 #1
[ 2190.059364] RIP: 0010:[<ffffffff8031edcc>] [<ffffffff8031edcc>]
vsscanf+0x600/0x657
[ 2190.059364] RSP: 0018:ffff8101d6039a90 EFLAGS: 00000202
[ 2190.059364] RAX: ffff8101d6039a25 RBX: 0000000000000003 RCX: ffff8101d6039bbc
[ 2190.059364] RDX: ffffffffa021a3d0 RSI: ffffffffa021a3d0 RDI: 0000000000000000
[ 2190.059364] RBP: ffff8101d6039ad8 R08: ffff8101d6039bc0 R09: ffff8101d6039bc4
[ 2190.059364] R10: 0000000000000000 R11: 0000000000000001 R12: 0000000000000000
[ 2190.059364] R13: 0000000000000000 R14: 0000000000000000 R15: ffff8102314a6140
[ 2190.059364] FS: 00007fcabeeea6e0(0000) GS:ffff81023b4469c0(0000)
knlGS:0000000000000000
[ 2190.059364] CS: 0010 DS: 0000 ES: 0000 CR0: 000000008005003b
[ 2190.059364] CR2: 0000000000000000 CR3: 0000000171938000 CR4: 00000000000006e0
[ 2190.059364] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[ 2190.059364] DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000400
[ 2190.059364] Process a.out (pid: 23203, threadinfo ffff8101d6038000,
task ffff8102383a5830)
[ 2190.059364] Stack: ffffffffa021a3d0 0000000000000020
00000000001280d2 0000000000000003
[ 2190.059364] 0000000000000000 00000000ffffff01 ffff8101d6039c38
0000000000002000
[ 2190.059364] ffffffff8031ee6c 0000003000000010 ffff8101d6039bb8
ffff8101d6039af8
[ 2190.059364] Call Trace:
[ 2190.059364] [<ffffffff8031ee6c>] ? sscanf+0x49/0x51
[ 2190.059364] [<ffffffffa0217b2b>] ? :9pnet:parse_opts+0xbf/0xcc
[ 2190.059364] [<ffffffff8027684e>] ? __alloc_pages_internal+0xd6/0x3bf
[ 2190.059364] [<ffffffffa021912f>] ? :9pnet:p9_trans_create_tcp+0x51/0x1d6
[ 2190.059364] [<ffffffff803208fb>] ? match_token+0x6d/0x1d2
[ 2190.059364] [<ffffffffa0215610>] ? :9pnet:p9_client_create+0x181/0x2b3
[ 2190.059364] [<ffffffff803208fb>] ? match_token+0x6d/0x1d2
[ 2190.059364] [<ffffffffa022475a>] ? :9p:v9fs_session_init+0x289/0x32f
[ 2190.059364] [<ffffffff8027684e>] ? __alloc_pages_internal+0xd6/0x3bf
[ 2190.059364] [<ffffffffa02230ec>] ? :9p:v9fs_get_sb+0x6d/0x1d9
[ 2190.059364] [<ffffffff8029cbbc>] ? vfs_kern_mount+0x93/0x11b
[ 2190.059364] [<ffffffff8029cc97>] ? do_kern_mount+0x43/0xdc
[ 2190.059364] [<ffffffff802b16a9>] ? do_new_mount+0x5b/0x95
[ 2190.059364] [<ffffffff802b18a0>] ? do_mount+0x1bd/0x1e7
[ 2190.059364] [<ffffffff8027684e>] ? __alloc_pages_internal+0xd6/0x3bf
[ 2190.059364] [<ffffffff802b1954>] ? sys_mount+0x8a/0xce
[ 2190.059364] [<ffffffff8020beca>] ? system_call_after_swapgs+0x8a/0x8f
[ 2190.059364]
[ 2190.059364]
[ 2190.059364] Code: 8d 74 24 10 4c 89 e7 48 8b 19 e8 fc f4 ff ff 89
03 48 8b 44 24 10 41 ff c5 48 85 c0 74 18 49 89 c4 48 8b 14 24 8a 02
84 c0 74 47 <41> 80 3c 24 00 0f 85 16 fa ff ff 48 8b 04 24 80 38 25 75
33 80
[ 2190.060321] RIP [<ffffffff8031edcc>] vsscanf+0x600/0x657
[ 2190.060321] RSP <ffff8101d6039a90>
[ 2190.060321] CR2: 0000000000000000
[ 2190.064870] ---[ end trace 9deab910d1f789fc ]---

Repro C Source Code: https://pastebin.com/Di8qKaPR

Root Cause:

The root cause of this issue lies in the improper handling of options
parsing in the parse_opts function within the 9pnet module, as
indicated by the stack trace. Specifically, the crash occurs due to a
NULL pointer dereference in the vsscanf function while attempting to
parse the options provided during a mount system call. The PoC
triggers this by providing malformed or incomplete options for the 9p
filesystem mount with the trans=tcp parameter. The lack of adequate
validation and error handling in the parse_opts function leads to the
dereferencing of a NULL pointer when attempting to read an invalid or
missing field, causing a kernel panic. This highlights a vulnerability
in the kernel's option parsing logic for the 9P transport, resulting
in instability when exposed to crafted input.

Thank you for your time and attention.

Best regards

Wall

