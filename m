Return-Path: <linux-kernel+bounces-541234-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D523A4BA50
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 10:08:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B68316E344
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 09:07:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2519A1EFF9A;
	Mon,  3 Mar 2025 09:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HMQUcXLv"
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D198A1EF099
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 09:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740992718; cv=none; b=so78LeAoc2KiR6NWVsfIU+7yCh9y+iXls8IlNbEV+gXu3qvY5OygWDACohgPLQOkhogYfvGjhWRWrIZ75VvammAPX0wL5V6YMUjH0lmkgntrctMhYrdrprnXMtp0gjkNZ3uO2Lc9PmZs+J8s3nQQFGgNizsb+VtG7k8GWN134wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740992718; c=relaxed/simple;
	bh=twAu11/PRIW6bi1GvK7p8LanMReL12MhaLWQhmhJH1M=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=WUMnjjYisLck5N5HZtVbiD5NaH1FuE/uRrXPtD676CNVmM1FI3rIt16TOjJaTgF/Hnt87qJHkC0l3tRd2Tu4QSi9zf5Gkmh+8Vog6AO/NsoqW1QLBgiRmWOByS/RID3tmf7c2x9MYDDk/+XVscymSqDb3TDJR5AxqKCGOUEhHc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HMQUcXLv; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-2c186270230so535464fac.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 01:05:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740992716; x=1741597516; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ayER41rrknj9o1FxD0EbDGZpUx0hR5m/9eUcKAT7z20=;
        b=HMQUcXLvGK9aTD5kayfsomOzzeUp/fWUOtEkW1//3dkcCqF8UsMLdriw5eMyfCTUSQ
         Yg6kVJislS7DjlIjz9+e4nQKhDhiSBOPwWWzjYi6pEPfr1u5rdG7RNXkKThDP4WRhiLz
         UZg7NmVgzH+sybu1wYgZ08YmaVar2AM4ZorkcKook/PgoZ0hVyX0ORL2+lbNXzQrRlSp
         ISPLYS8mzVYzrkeRRJambcj9q0iknquwZyneYhciyH53q1fEKaD8qjBSeEHeFCLXXq2I
         ESkGukthGtOuTt3Cf3+XPqtOE13MYm/86cWCJ3izZppMwISzdUDXzdcqrbTikLYwmSlp
         H9kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740992716; x=1741597516;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ayER41rrknj9o1FxD0EbDGZpUx0hR5m/9eUcKAT7z20=;
        b=fg28AjoFVUdSxm/2pvb3lyYWGeeJ5nxVzQTNlkaYkQ6GHWm1AvD8ZKStPQqnv7yTjF
         4IRRlk6L9OWrDTOu2XakI45daxlt2ALOyesBLYbB/e4Mpa7cjRtYUv/UDbQcS6AFJhho
         hYl+PqX2z+MfHPj6BYOV6OXLEoNdfBUHpx8WlWT9dGkHmPvfJZO7ff4d5sQjdR/hyjLE
         1QcyM3kRgI/7Rah/Y84IppFabQIhLvDtsgGIcpUxjFAe8DJBOVKHv06xSGEgPE+2ObHO
         T/0vmYFLMlq2kPEfVvjuWOG0sggoJcTzr8Yqvvpb7drUwKxVjY+9IPpVlbc4LmD3NqQl
         RLrw==
X-Forwarded-Encrypted: i=1; AJvYcCUAWGmJZqOkZw/hMl/s8d0NSOPbJQzLw+E5QJLo5qoLLEFCT5X/MhUpn9c/v1HY+cxSwceulHolcnw8oSQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6rfNCtfm46n1tdEBIYHMZFOPCtYzNxEbnqSLkhR5M91g5PajW
	a0gFDVYlEpqOfe8WOUj0lhfTVeWU/LTOMlUHs0CCTZnZrLMp9/Vu0IYyWdowNt4UqGOQM7+zsZW
	jGnSxo28r8TUjx4Cltj3KVW3pcnS5uroEF8bm/g==
X-Gm-Gg: ASbGncue7cIE3jAjtYM9ali7A1EJ1RjxIkwB9ovWZT7Gmeycj1uq8iuF5Ue0OX5Oe5z
	DwxfqZrXO+vBOhhoYD1rltqpeJ+zQs2A2GzjwXMKdawj72ZZTRrLN5uJk72iN7lHeDuBm7YYFeM
	Pdr/LLktJRo3DXPvD/oroiqhubMQ==
X-Google-Smtp-Source: AGHT+IHVfN9jgx4mKT/i6a3ODk82fUK4vIZBFKN9C9gzcGh8SEROMDecp5xmXRXDbXe1X3i8NqgrqbC5YJg7m20YBfc=
X-Received: by 2002:a05:6871:e413:b0:29e:719b:7837 with SMTP id
 586e51a60fabf-2c1783c64b7mr7043039fac.13.1740992715741; Mon, 03 Mar 2025
 01:05:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Strforexc yn <strforexc@gmail.com>
Date: Mon, 3 Mar 2025 17:05:04 +0800
X-Gm-Features: AQ5f1JrwOL808TVePC2IJN5FDFbmXr24vcuElZAhmGzdFxp4XEP33LAGtFOR4y8
Message-ID: <CA+HokZriOfJqu5btsaEvgdrHY5e7XrJEM2CmPC7fgB5R2Umn_g@mail.gmail.com>
Subject: [BUG] UBSAN: Shift-Out-of-Bounds in befs_check_sb (BeFS) on
 6.14.0-rc4 - Possible Regression**
To: Luis de Bethencourt <luisbg@kernel.org>, Salah Triki <salah.triki@gmail.com>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Dear Linux Kernel Developers,
I=E2=80=99ve encountered a UBSAN-reported shift-out-of-bounds issue in the
BeFS filesystem on Linux 6.14.0-rc4 during superblock validation,
which may indicate a regression from prior fixes. Here are the
details:

Kernel commit: v6.14-rc4 (Commits on Feb 24, 2025)
Kernel Config : https://github.com/Strforexc/LinuxKernelbug/blob/main/.conf=
ig
Kernel Log:  https://github.com/Strforexc/LinuxKernelbug/blob/main/shift-ou=
t-of-bounds_befs_check_sb/log0
Reproduce C: https://github.com/Strforexc/LinuxKernelbug/blob/main/shift-ou=
t-of-bounds_befs_check_sb/repro.cprog

Bug Description:
UBSAN detects a shift-out-of-bounds in fs/befs/super.c:96:9, where a
shift exponent of 3229888891 exceeds the 32-bit int limit in
befs_check_sb. This occurs when mounting a BeFS filesystem with a
potentially malformed superblock.

Location: The fault occurs at (1 << befs_sb->block_shift) in
befs_check_sb, where block_shift (a __u32) is 3229888891, exceeding
the 32-bit shift limit (31).

Cause: No bounds check exists for block_shift before the shift
operation, allowing garbage or malicious values from a crafted
superblock to trigger undefined behavior.

Context: Syzkaller=E2=80=99s mount of a BeFS filesystem on loop0 likely
provided a malformed superblock.

Impact: Undefined shift behavior could crash the kernel or corrupt
memory, posing a DoS risk with malicious filesystems. UBSAN warns
here, but production kernels may fail silently.

Could BeFS maintainers investigate? This seems like a regression from
prior superblock validation fixes. Suggested actions:
1. Add a bounds check: if (befs_sb->block_shift > 31) { befs_error(sb,
"invalid block_shift: %u", befs_sb->block_shift); return BEFS_ERR; }.
2. Review historical BeFS patches to confirm if block_shift validation
was dropped.

Our knowledge of the kernel is somewhat limited, and we'd appreciate
it if you could determine if there is such an issue. If this issue
doesn't have an impact, please ignore it =E2=98=BA.
If you fix this issue, please add the following tag to the commit:
Reported-by: Zhizhuo Tang <strforexctzzchange@foxmail.com>, Jianzhou
Zhao <xnxc22xnxc22@qq.com>, Haoran Liu <cherest_san@163.com>

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
loop0: detected capacity change from 0 to 128
------------[ cut here ]------------
UBSAN: shift-out-of-bounds in fs/befs/super.c:96:9
shift exponent 3229888891 is too large for 32-bit type 'int'
CPU: 1 UID: 0 PID: 11513 Comm: syz.0.10 Not tainted 6.14.0-rc4 #1
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/=
2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x180/0x1b0 lib/dump_stack.c:120
 ubsan_epilogue lib/ubsan.c:231 [inline]
 __ubsan_handle_shift_out_of_bounds+0x1d2/0x350 lib/ubsan.c:468
 befs_check_sb.cold+0x19/0x6f fs/befs/super.c:96
 befs_fill_super+0x59f/0xcc0 fs/befs/linuxvfs.c:841
 get_tree_bdev_flags+0x396/0x630 fs/super.c:1636
 vfs_get_tree+0x93/0x350 fs/super.c:1814
 do_new_mount+0x368/0x730 fs/namespace.c:3560
 path_mount+0x4a6/0x17f0 fs/namespace.c:3887
 do_mount fs/namespace.c:3900 [inline]
 __do_sys_mount fs/namespace.c:4111 [inline]
 __se_sys_mount fs/namespace.c:4088 [inline]
 __x64_sys_mount+0x288/0x310 fs/namespace.c:4088
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcb/0x260 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fafc99ba41e
Code: 48 c7 c0 ff ff ff ff eb aa e8 5e 20 00 00 66 2e 0f 1f 84 00 00
00 00 00 0f 1f 40 00 f3 0f 1e fa 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d
01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fafca8b7da8 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 0000000000009e24 RCX: 00007fafc99ba41e
RDX: 0000400000000100 RSI: 0000400000009e40 RDI: 00007fafca8b7e00
RBP: 00007fafca8b7e40 R08: 00007fafca8b7e40 R09: 0000000003008001
R10: 0000000003008001 R11: 0000000000000246 R12: 0000400000000100
R13: 0000400000009e40 R14: 00007fafca8b7e00 R15: 00004000000001c0
 </TASK>
---[ end trace ]---

Regards,
Strforexc

