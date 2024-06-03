Return-Path: <linux-kernel+bounces-199249-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5053B8D845B
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 15:49:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B8002840A4
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 13:49:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7389F12D775;
	Mon,  3 Jun 2024 13:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gymRbrNf"
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com [209.85.222.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FF6212F5B8
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 13:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717422577; cv=none; b=EqeYobEsf9rsa6y82JBLQXcatPi/MuET4+iUon0hb0cxMwGdHEFkJbHxqkEaj8c+hp6h08WQei2+FFsvfdm+ztzL1PGLPbhZRwAX6CTzvaEjISZSxk49mzl8RF1IQ0fJzGjT8kAXzApzSBo8+dCIKQaepGULLXbwzmux9L/6Y+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717422577; c=relaxed/simple;
	bh=GuyMXzBKnFe4zMqoq0koVRBGFYJgZszVF5dwzicK8uE=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=Lxz3CY6CaI9zld9MWqbsFFdk1RtZQXVW5OM4o578yEhS5GUYuwjATN1YZyjp2Trn9XVLx1ZQL1/+DcIOc/KqFvlmdDr0s21IaMPDhtcxRufQYFaEbgnvtjpseW4hP/7KnU6SXBhT/eeZo1MD95FzkGT2GzNPMts3Hf9fWy8Wei4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gymRbrNf; arc=none smtp.client-ip=209.85.222.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ua1-f50.google.com with SMTP id a1e0cc1a2514c-804c45a47b6so1392792241.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2024 06:49:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717422574; x=1718027374; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ZorXgNDwuZK2oFNcSHqr3ywKGFUsa6zHHPaEgR9iM74=;
        b=gymRbrNf+yO0nrkl+NQaLQCBAR/UqX1p2TbCz5m7IvyJZ/djcYDvwuZSrcbcKk1MvJ
         suQCeSFvZzCV5A6b/KVLpzaaXri3sYcTCjsd1Uaxb3mSPGpoDstgFMco07sJyktX7yp5
         ykSPXK/WyKPUUv/dtZtNdsilHVwWgemSbb4e20YrE/f3tbV7sCGQ2Gdu/+VLwdEKiOrE
         VpKTUrfc/KV0vo7EdJXKgsMb8VUm0Nbcfdbr3RktA4BJQYkvK5citB00vkgs233GwuSx
         7TSEUNaQbxbEaErDF1d2aRvilenT0xUrN+O3i98lW1yiGfoYXfshEaiQhUr8rbNi5cVU
         Cnww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717422574; x=1718027374;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZorXgNDwuZK2oFNcSHqr3ywKGFUsa6zHHPaEgR9iM74=;
        b=rl1VWIeTWFxG2REjkxN/aJ3dveEn05VkcfZTQQKCPEnsEt5Qtcr0iwX3I4ZGnjI39N
         2o/zbs9gAJqWhcTFESBp+0rOjh8opQc6EBTOhkcygb/ea1wURxAVJQ1jDqq0/0Mfj9y9
         xf7bfyY8YA018huIwnSrHfgeW96e54r4k4H3ZBZeIpFOiXiKieDC88u1OIicOFmTE7/5
         RXFBd6OZBgPkRRZrswRL3XbcvbLpKaCgqbivCUmfAJDdxkGPRdbcD/2lKYZV2CCfGVh2
         SpGgQIzGFrzWCldvadB2La9c3dme5WfwDBVEu6KB90hg6+35JrE7b4XAJIBRPrB2WKwu
         2ZbA==
X-Gm-Message-State: AOJu0YzWkJFpGqINja4mZ36DVGO5uqwlJxb1Q3i4A0EFdb0HttqJPweL
	AL34li+nu64iwQaJyEfHqqJGpoEBIqA6+meahSVcA2kskfX+O43hCV60PJu2xF+8Udqr9wQEMZT
	5ceUFv5LaCTFIVmv/bA845H45cRjMBuTRYtNujup0f/KhnA6AA2BBIg==
X-Google-Smtp-Source: AGHT+IHBf7jvxX3ogi9vqUdP1IVzd7xmTTBLPGzPNkqYVhRgcsV9KhaZnC/9PJzIWZYRJ9SWrE0q32XUuOOBcClneG0=
X-Received: by 2002:a67:f48a:0:b0:47b:b058:849b with SMTP id
 ada2fe7eead31-48bc1fe0c82mr9214089137.10.1717422573292; Mon, 03 Jun 2024
 06:49:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Mon, 3 Jun 2024 19:19:21 +0530
Message-ID: <CA+G9fYsGFerOtoxwpKLOYcRtyJkmgjdP=qg4Y5iP5q-4Lt17Lg@mail.gmail.com>
Subject: x86: WARNING: at mm/memblock.c:1339 memblock_set_node - Usage of
 MAX_NUMNODES is deprecated. Use NUMA_NO_NODE instead
To: open list <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>, 
	lkft-triage@lists.linaro.org
Cc: Andrew Morton <akpm@linux-foundation.org>, Mike Rapoport <rppt@kernel.org>, jbeulich@suse.com, 
	Dan Carpenter <dan.carpenter@linaro.org>, Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"

The following kernel warnings are noticed on x86 devices while booting
the Linux next-20240603 tag and looks like it is expected to warn users to
use NUMA_NO_NODE instead.

Usage of MAX_NUMNODES is deprecated. Use NUMA_NO_NODE instead

The following config is enabled
CONFIG_NUMA=y

Boot log:
--------
[    0.008547] ------------[ cut here ]------------
[    0.008547] Usage of MAX_NUMNODES is deprecated. Use NUMA_NO_NODE instead
[    0.008553] WARNING: CPU: 0 PID: 0 at mm/memblock.c:1339
memblock_set_node+0xed/0x100
[    0.008559] Modules linked in:
[    0.008561] CPU: 0 PID: 0 Comm: swapper Not tainted
6.10.0-rc1-next-20240603 #1
[    0.008563] Hardware name: Supermicro SYS-5019S-ML/X11SSH-F, BIOS
2.7 12/07/2021
[    0.008564] RIP: 0010:memblock_set_node+0xed/0x100
[    0.008567] Code: ea ea ff 00 74 0b 41 bc ff ff ff ff e9 6c ff ff
ff 48 89 75 d0 c6 05 5e ea ea ff 01 90 48 c7 c7 c8 e1 c7 a0 e8 d4 36
df fd 90 <0f> 0b 90 90 48 8b 75 d0 eb d2 e8 74 bb f3 fe 0f 1f 40 00 90
90 90
[    0.008568] RSP: 0000:ffffffffa1003de0 EFLAGS: 00010086 ORIG_RAX:
0000000000000000
[    0.008570] RAX: 0000000000000000 RBX: ffffffffa149b510 RCX: 0000000000000000
[    0.008572] RDX: 0000000000000000 RSI: 00000000ffffdfff RDI: 00000000ffffdfff
[    0.008572] RBP: ffffffffa1003e10 R08: 00000000ffffdfff R09: ffffffffa1003b90
[    0.008573] R10: 0000000000000001 R11: ffffffffa1079440 R12: 0000000000000040
[    0.008574] R13: 0000000000000000 R14: 000000008ad25c18 R15: 0000000000014770
[    0.008575] FS:  0000000000000000(0000) GS:ffffffffa135e000(0000)
knlGS:0000000000000000
[    0.008577] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    0.008578] CR2: ffff9ac23fe01000 CR3: 00000003ff246000 CR4: 00000000000200f0
[    0.008579] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[    0.008579] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[    0.008580] Call Trace:
[    0.008581]  <TASK>
[    0.008582]  ? show_regs+0x68/0x80
[    0.008586]  ? __warn+0x91/0x140
[    0.008589]  ? memblock_set_node+0xed/0x100
[    0.008591]  ? report_bug+0x175/0x1a0
[    0.008594]  ? fixup_exception+0x2b/0x2f0
[    0.008597]  ? early_fixup_exception+0xb3/0xd0
[    0.008600]  ? do_early_exception+0x1f/0x60
[    0.008603]  ? early_idt_handler_common+0x2f/0x40
[    0.008606]  ? memblock_set_node+0xed/0x100
[    0.008609]  ? __pfx_x86_acpi_numa_init+0x10/0x10
[    0.008612]  numa_init+0x8b/0x610
[    0.008615]  ? topo_register_apic+0x3a/0x130
[    0.008617]  x86_numa_init+0x23/0x70
[    0.008620]  initmem_init+0x12/0x20
[    0.008622]  setup_arch+0x8a3/0xd60
[    0.008624]  ? _printk+0x64/0x80
[    0.008628]  start_kernel+0x76/0x810
[    0.008630]  x86_64_start_reservations+0x1c/0x30
[    0.008632]  x86_64_start_kernel+0xca/0xe0
[    0.008634]  common_startup_64+0x12c/0x138
[    0.008637]  </TASK>
[    0.008638] ---[ end trace 0000000000000000 ]---

metadata:
 git_ref: master
 git_describe: next-20240603
 git_repo: https://gitlab.com/Linaro/lkft/mirrors/next/linux-next

Links:
 - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20240603/testrun/24170391/suite/log-parser-boot/tests/
 - https://tuxapi.tuxsuite.com/v1/groups/linaro/projects/lkft/tests/2hM1TaqYoxFAhzHCIRxz84OeUaj
 - https://storage.tuxsuite.com/public/linaro/lkft/builds/2hM1QI6QEe9bjg1sQrFs41ZSYmk
 - https://storage.tuxsuite.com/public/linaro/lkft/builds/2hM1QI6QEe9bjg1sQrFs41ZSYmk/config

--
Linaro LKFT
https://lkft.linaro.org

