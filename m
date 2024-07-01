Return-Path: <linux-kernel+bounces-236231-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F094291DF0E
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 14:24:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B3B51C21382
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 12:24:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDDB514AD35;
	Mon,  1 Jul 2024 12:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lucidpixels.com header.i=@lucidpixels.com header.b="pk3dF2Vc"
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C49B14A09D
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 12:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719836648; cv=none; b=h3zX+lXS0NHPRWJGCU+CQUtRLXHyuUNegcU5N8psIMR82ESbeKQvvzKbkV6kedY554tRgc2K8uebdvpcO7FB7WOGvW1bQV6rQc9cZlXZGabWIjESID+6kqOZRBdGUXTIbBQ3ADyYUN1WlxZzXQDJ+NgI4X0i99sCmK3949vaACM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719836648; c=relaxed/simple;
	bh=vFp3IKQ8KdEHvswCMbxx2Hvylnp432DHrye0MkGLRTA=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=VOYw9T8KiuZlxEK3Il/i0/lvB/8s+bq2iOsNQxiQ/6v3iVHaxhA9uCjGadIMk2DZ7aFel83NqEG0iI7Pk47eq/BsRDNj5DBjyyIebXTZIYqiPCCOgC2RqC4v2BQpM7nB7qtXXl38jq7Tykov+AZmovncTIuHLiCwCMp6GE5Xz/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lucidpixels.com; spf=pass smtp.mailfrom=lucidpixels.com; dkim=pass (1024-bit key) header.d=lucidpixels.com header.i=@lucidpixels.com header.b=pk3dF2Vc; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lucidpixels.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lucidpixels.com
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-24c0dbd2866so1644172fac.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2024 05:24:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lucidpixels.com; s=google; t=1719836645; x=1720441445; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=zBj9g9bDyvIlpgcHXegxhxkeD3RVC4oLgSHzdmlYbcs=;
        b=pk3dF2Vc9wRIG5lujRPA/ahlV35zjDsmW1uqSPsg5gz2v3tObheegUKlfhLWo5agdN
         IZCcxPJdAuJc6W0VS6GKw76ScnOOZn44r5MbcGvxZIOhQ0I7Ptv8xif3LzHKZrwVCnXJ
         WYmhGbqxGR6Ej/YoJ4KZoB5iRPPDhiLb1roiY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719836645; x=1720441445;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zBj9g9bDyvIlpgcHXegxhxkeD3RVC4oLgSHzdmlYbcs=;
        b=DtI87snxylrS8swTTzeJkjMaCPLR4f58LHm/1r421w8qBreHPctnjZ3lNAh6xBloOx
         xCNKEreuYCuLmLHWdXR+zW8x45Ciy0CksMymEH9oEQx/jagqBqN+lPEG/+gUhmHn4K5C
         mYxkNYAzx2N6fZDCVKnQxQbvmje60Dzmq7jH2jKEtdBnsYFkqCyNaGraru9Z7EzzyNPj
         UhJhJT3dS8nKFCInL8CBD1cxnved9v/D1zvv2oEYTM1cinhmm63r7vAEOjvo6v4ahWf5
         5TTSOx8Lu5ZKY1tfbKAzMouAHgcT0ptna5mrNN6WpBWGU77Fcmip4/VdPRCoojDnXfN4
         6pXw==
X-Gm-Message-State: AOJu0YyU1cKfBlUtT58P/C0KL0gbzvphTCFyAr+YDFh/gxWGYIwSYc4k
	2ts8ynjHxR8cwgG6f+qIVMKZWdiTa1CFgeEbbM9lU/gi2abKKtCUoR9sfU4jfgIhnCcM+/4xDRj
	vX3c7OnuwDrmz0DGfU4R2pVzHUHVXyNrdpCFrcyHpJAodoODAmD1plQ==
X-Google-Smtp-Source: AGHT+IEqbvHdQx4GK15m/Vc1IL8A0MaA8TjByULtcu/8pRRM9glLpJQkXeqsR6/PeHkY+uPwb6wUm0y1uy/EedYWNEU=
X-Received: by 2002:a05:6870:ebcf:b0:25c:cb34:9193 with SMTP id
 586e51a60fabf-25db3550eafmr6041665fac.33.1719836644887; Mon, 01 Jul 2024
 05:24:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Justin Piszcz <jpiszcz@lucidpixels.com>
Date: Mon, 1 Jul 2024 08:23:53 -0400
Message-ID: <CAO9zADwJ_AXMJTjBLXkO_A0JhsXzsfqtx92DbSq_gcG9LPLZ_w@mail.gmail.com>
Subject: 6.1.0: NVME drive goes offline randomly even with:
 nvme_core.default_ps_max_latency_us=0 pcie_aspm=off
To: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hello,

Kernel: 6.1.0-17-amd64
Distribution: Debian stable
Arch: x86_64

I have 2 NVME drives as part of a BTRFS RAID-1, initially when this
happened the first time I added the following to the kernel cmdline at
boot:
nvme_core.default_ps_max_latency_us=0 pcie_aspm=off

This greatly reduced the frequency of this issue (last uptime was ~70
days).  However, it has occurred twice since then, this time I had
netconsole up to capture the crash.

The full kernel netconsole before during and after the crash:
https://installkernel.tripod.com/20240701-6.1.0-crash.txt

The model & firmware version of both drives are identical:
Model Number:                       Samsung SSD 990 PRO with Heatsink 4TB
Firmware Version:                   4B2QJXD7

Motherboard being used:
Manufacturer: ASUSTeK COMPUTER INC.
Product Name: Pro WS W680-ACE IPMI

Is there a workaround or potential fix for this issue?

The issue starts when this occurs:
[6078737.345641] nvme nvme2: I/O 154 (I/O Cmd) QID 6 timeout, aborting
[6078737.348143] nvme nvme2: I/O 155 (I/O Cmd) QID 6 timeout, aborting

Then later, a kernel panic:
[6078894.702941] BTRFS error (device nvme0n1p2): error writing primary
super block to device 2
[6078894.707920] BTRFS warning (device nvme0n1p2): csum hole found for
disk bytenr range [3659038877598419968, 3659038877598424064)
[6078894.708310] BTRFS critical (device nvme0n1p2): unable to find
chunk map for logical 3659038877598419968 length 4096
[6078894.708652] BUG: kernel NULL pointer dereference, address: 000000000000005a
[6078894.708879] #PF: supervisor read access in kernel mode
[6078894.709107] #PF: error_code(0x0000) - not-present page
[6078894.709292] PGD 0 P4D 0
[6078894.709509] Oops: 0000 [#1] PREEMPT SMP NOPTI
[6078894.709692] CPU: 12 PID: 3349611 Comm: kworker/u64:18 Not tainted
6.1.0-17-amd64 #1  Debian 6.1.69-1
[6078894.709856] Hardware name: ASUSTeK COMPUTER INC. System Product
Name/Pro WS W680-ACE IPMI, BIOS 3401 03/19/2024
[6078894.710022] Workqueue: btrfs-endio btrfs_end_bio_work [btrfs]
[6078894.710267] RIP: 0010:btrfs_get_io_geometry+0x13/0xf0 [btrfs]
[6078894.710483] Code: f4 ff ff ff e9 67 ff ff ff 66 66 2e 0f 1f 84 00
00 00 00 00 0f 1f 00 0f 1f 44 00 00 41 56 49 89 c9 48 89 cf 41 55 41
54 55 53 <4c> 8b 76 70 89 d3 31 d2 4c 8b 5e 18 41 8b 4e 10 45 8b 6e 14
4d 29
[6078894.710692] RSP: 0018:ffffa9cfc6657c08 EFLAGS: 00010286
[6078894.710711] BTRFS error (device nvme0n1p2): error writing primary
super block to device 2
[6078894.710876] RAX: ffffffffffffffea RBX: ffffffffffffffea RCX:
32c7847906990c00
[6078894.710882] RDX: 0000000000000000 RSI: ffffffffffffffea RDI:
32c7847906990c00
[6078894.710882] RBP: ffffa9cfc6657d28 R08: ffffa9cfc6657cc8 R09:
32c7847906990c00
[6078894.710882] R10: 0000000000000003 R11: ffff9a3efff6dc28 R12:
ffff9a2018195000
[6078894.710883] R13: 0000000000000001 R14: 0000000000001000 R15:
ffffa9cfc6657d50
[6078894.710884] FS:  0000000000000000(0000) GS:ffff9a3e7fb00000(0000)
knlGS:0000000000000000
[6078894.710884] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[6078894.710885] CR2: 000000000000005a CR3: 0000000bfc210000 CR4:
0000000000750ee0
[6078894.710885] PKRU: 55555554
[6078894.710885] Call Trace:
[6078894.710887]  <TASK>
[6078894.710891]  ? page_fault_oops+0xd2/0x2b0
[6078894.710889]  ? __die_body.cold+0x1a/0x1f
[6078894.710893]  ? exc_page_fault+0x70/0x170
[6078894.715724]  ? asm_exc_page_fault+0x22/0x30
[6078894.716084]  ? btrfs_get_io_geometry+0x13/0xf0 [btrfs]
[6078894.716470] BTRFS error (device nvme0n1p2): error writing primary
super block to device 2
[6078894.716462]  ? btrfs_get_chunk_map.cold+0x15/0x42 [btrfs]
[6078894.717384]  __btrfs_map_block+0xc4/0xe40 [btrfs]
[6078894.717771]  ? kmem_cache_free+0x15/0x310
[6078894.718147]  btrfs_submit_bio+0xa2/0x240 [btrfs]
[6078894.718571]  btrfs_repair_one_sector+0x29f/0x3a0 [btrfs]
[6078894.718972]  ? btrfs_submit_data_write_bio+0x110/0x110 [btrfs]
[6078894.719364]  end_compressed_bio_read+0x118/0x2f0 [btrfs]
[6078894.719753]  process_one_work+0x1c4/0x380
[6078894.720135]  worker_thread+0x4d/0x380
[6078894.720510]  ? rescuer_thread+0x3a0/0x3a0
[6078894.720864]  kthread+0xd7/0x100
[6078894.721224]  ? kthread_complete_and_exit+0x20/0x20
[6078894.721579]  ret_from_fork+0x1f/0x30
[6078894.721984]  </TASK>

Justin

