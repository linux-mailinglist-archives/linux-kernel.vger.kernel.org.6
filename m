Return-Path: <linux-kernel+bounces-444730-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 389509F0BBE
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 12:57:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 553FF166C88
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 11:57:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96F7E1DF267;
	Fri, 13 Dec 2024 11:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="HLIGzHAJ"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45DAF4A21
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 11:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734091041; cv=none; b=iAo34LJbqf6P3rQLYlLCczIjEu3sIby3VTdV9EIbYYSa35XnZ37w/wAueMMifpHQ1T0usfs62oiltu/4s7wL5pJtwNyPRADwzsSQ+Ww1rTw1wPfp+4ajbwZUA7BXRhaYFVOzZgHsVCY67JnUX/H/4JKDGGWq0Rqq2VJRowR0+qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734091041; c=relaxed/simple;
	bh=HXe0zxDUrYQi00ifKobx5cfHqRJGWFp6B1OtWex7KaY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FMMola6WVChIU50XwK1b7g5eo1+39+XJJr1qBkoaiKUjRNzu3gMYZYLanAdrc9kVS5KBANuGwAAIPTHViAXCYeyQFx2VIkyQMa+2qqArnx1MzFyTePEQIbDYZK1zUUTj58xlmlvhXBqq32oAs2FpNuvOVuCOSDmKQQGvkQkU39g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=HLIGzHAJ; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-436281c8a38so9033335e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 03:57:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1734091037; x=1734695837; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=snfyq8lDZYDcZd3/jEIiaO5E3Ue45FWLsNzNsDHm93g=;
        b=HLIGzHAJxD6/hF/Ji02G3yFHJ3tgR3YwE/vLtOA+Zh4Cx4uqv3vSZV7oWWSnmjGuIk
         of/FAdOQAIK1eBYh0KevT7ZCVkmdAGcC/H8AMDWh81jQ3I50BfJR5LcekZAy/QMai4U+
         hNgSvn5JoH4zUY3BQ/8EtXEijH9QgPa5goqFola7POofkl2oN5Aoc0FW6Jk4F75uyZgR
         aq5R42gvmPDJtou/VEIgMuewPUnzPHpaSlbE+0KTUT9VaM/RWkVCpyH2F6n1gltLRp9Q
         gaxfUlgb2BQ6upUMOkV8hStxyczzdFgqCifDRajOlWPrHKbFj9jHQxbthNuOYjN+WUt0
         +rEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734091037; x=1734695837;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=snfyq8lDZYDcZd3/jEIiaO5E3Ue45FWLsNzNsDHm93g=;
        b=Xu2xTFVupnwCYDvc2FKWfZ2unHZjfkG4DSGaETfo52ZlHy9OpK7fS2okBpPO891ctq
         XKcDT/DsNmfLXcQJxqJ7Os6/kYdLLZyhgPJs+2nd+Fr1ZT2oyjYbBj2nJEhZ/yolS7Z7
         AJcIE3ynsNfCpXz2XbAHspn4/nk4HfBl9eGkQ4GnYWQJUSk07Bq9PG/nCYugmWty0HMJ
         DGx+krIA4aQ5czvR8EYxtvImjFAus9/pt9X5Nd+0GcyyEziCq4qdRAikd0y5CPz8hOAD
         x5u1swlMoE5Ea2Y89tsANmGBJnqmBDyc4TGBHgANLYkdb1hZh7lTdH6det8WFVETCKph
         Fz3A==
X-Forwarded-Encrypted: i=1; AJvYcCXsk88EuEvaPOg4orWAgQXNac2lBIiIqrDL1BQyXXJ4Og/iaWY1FLXgCljLCuU7W9MlD4KaAcifFe4YDZg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgmaFfPdwwcG0SxKOupzk9NsiLkOCnaIUchYPYKMbNznuR5NPH
	Ruktz6oSjqrLtFTO2KJcVl7kVRBlz3SSFwH5Lishtd4/zBF5BetnM7LHluZSxwc1Zn8cfZ6WyNT
	l
X-Gm-Gg: ASbGnctWTQVfIgrMA/GRnVR1/X7XKEdvSdPeAZWwy9plJRuMAkR0jCQUbtjX9tCju69
	rwLTtuOwvsCM9+FZIH+ayHQrtpc4IuR9Hb1XMPDErC+ZZwJBTdfWYnDB0iH0mgvsvHsVQuBmlxo
	CxtaAnEvlITkLwpqH6bKD5LuQTlE69Y6bOVzfNqvmwAFmqetHFx63ccBaLMcnY9ONP2gxEnXIdt
	J1aPs+zqrb70AdbzDq07ZPz7TMU5QMjQckpkezTlkzT39Monyj9SQx0b6bLz3cK1uPKTMOmGyoU
	S3ghGSQdHfRUPcZvr6AhWZWe+s0By9YnZoIPVbw=
X-Google-Smtp-Source: AGHT+IGuKBifitMwHJD63dlWjth+MyOB5tJF7VkrOI/FkjnTg+QJm2BBh02u9ybtuzDz8g87bmxHIg==
X-Received: by 2002:a05:600c:5397:b0:433:c76d:d57e with SMTP id 5b1f17b1804b1-4362aa34e4cmr16687785e9.5.1734091036669;
        Fri, 13 Dec 2024 03:57:16 -0800 (PST)
Received: from alex-rivos.ba.rivosinc.com (lfbn-lyo-1-472-36.w2-7.abo.wanadoo.fr. [2.7.62.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4362557c357sm46528135e9.10.2024.12.13.03.57.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2024 03:57:16 -0800 (PST)
From: Alexandre Ghiti <alexghiti@rivosinc.com>
To: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Anup Patel <anup@brainfault.org>,
	Sunil V L <sunilvl@ventanamicro.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Alexandre Ghiti <alexghiti@rivosinc.com>
Subject: [RFC PATCH] riscv: Fix PCI warning by enabling PCI_MSI_ARCH_FALLBACKS
Date: Fri, 13 Dec 2024 12:57:04 +0100
Message-Id: <20241213115704.353665-1-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When the interrupt controller is not using the IMSIC and ACPI is enabled,
the following warning appears:

[    0.866401] WARNING: CPU: 1 PID: 1 at drivers/pci/msi/msi.h:121 pci_msi_setup_msi_irqs+0x2c/0x32
[    0.867071] Modules linked in:
[    0.867389] CPU: 1 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.13.0-rc2-00001-g795582ce7e24-dirty #44
[    0.867538] Hardware name: QEMU QEMU Virtual Machine, BIOS
[    0.867672] epc : pci_msi_setup_msi_irqs+0x2c/0x32
[    0.867738]  ra : __pci_enable_msix_range+0x30c/0x596
[    0.867783] epc : ffffffff8050af80 ra : ffffffff8050a66e sp : ff20000000023750
[    0.867809]  gp : ffffffff815153b0 tp : ff60000080108000 t0 : ff60000081109600
[    0.867833]  t1 : 0000000000000228 t2 : 0000000000000004 s0 : ff20000000023860
[    0.867857]  s1 : ff60000080de1000 a0 : ff60000080de1000 a1 : 0000000000000005
[    0.867880]  a2 : 0000000000000011 a3 : 0000000000000000 a4 : 0000000000000000
[    0.867902]  a5 : 0000000000000000 a6 : ff600000806368f0 a7 : fffffffffffffff0
[    0.867925]  s2 : 0000000000000005 s3 : ffffffffffffffff s4 : 0000000000000000
[    0.867948]  s5 : ff60000080de10c0 s6 : 0000000000000005 s7 : 0000000000000005
[    0.867970]  s8 : ff20000000023a08 s9 : ff600000811093c0 s10: 000000000000002c
[    0.867993]  s11: ff60000081109410 t3 : 0000000000000001 t4 : ff600000803a2878
[    0.868014]  t5 : 0000000000000004 t6 : ff60000080357450
[    0.868036] status: 0000000200000120 badaddr: ffffffff8050af80 cause: 0000000000000003
[    0.868186] [<ffffffff8050af80>] pci_msi_setup_msi_irqs+0x2c/0x32
[    0.868339] [<ffffffff80509172>] pci_alloc_irq_vectors_affinity+0xb8/0xe2
[    0.868362] [<ffffffff8059d62c>] vp_find_vqs_msix+0x12a/0x370
[    0.868385] [<ffffffff8059d8a0>] vp_find_vqs+0x2e/0x1de
[    0.868402] [<ffffffff8059bd80>] vp_modern_find_vqs+0x12/0x4e
[    0.868425] [<ffffffff80624a50>] init_vq+0x2b4/0x336
[    0.868448] [<ffffffff80624c36>] virtblk_probe+0xd4/0x90e
[    0.868469] [<ffffffff80594e02>] virtio_dev_probe+0x14a/0x1e6
[    0.868488] [<ffffffff805fe04c>] really_probe+0x86/0x234
[    0.868509] [<ffffffff805fe256>] __driver_probe_device+0x5c/0xda
[    0.868529] [<ffffffff805fe392>] driver_probe_device+0x2c/0xb2
[    0.868549] [<ffffffff805fe512>] __driver_attach+0x6c/0x11a
[    0.868569] [<ffffffff805fc17e>] bus_for_each_dev+0x60/0xae
[    0.868588] [<ffffffff805fda7c>] driver_attach+0x1a/0x22
[    0.868607] [<ffffffff805fd398>] bus_add_driver+0xce/0x1d6
[    0.868627] [<ffffffff805ff0b2>] driver_register+0x3e/0xd8
[    0.868647] [<ffffffff80594614>] __register_virtio_driver+0x1e/0x2c
[    0.868694] [<ffffffff80a31b82>] virtio_blk_init+0x6a/0x9e
[    0.868733] [<ffffffff8000f128>] do_one_initcall+0x58/0x194
[    0.868755] [<ffffffff80a011b0>] kernel_init_freeable+0x224/0x28e
[    0.868775] [<ffffffff809e4e48>] kernel_init+0x1e/0x13a
[    0.868795] [<ffffffff809ed952>] ret_from_fork+0xe/0x18

So enable PCI_MSI_ARCH_FALLBACKS to get rid of this.

Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
---

This is an RFC as I'm really not sure this is the right fix,
Anup/Sunil/Thomas if you have any idea, please step in! Thanks

 arch/riscv/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index d4a7ca0388c0..40d51feac2bb 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -199,6 +199,7 @@ config RISCV
 	select PCI_DOMAINS_GENERIC if PCI
 	select PCI_ECAM if (ACPI && PCI)
 	select PCI_MSI if PCI
+	select PCI_MSI_ARCH_FALLBACKS if PCI
 	select RISCV_ALTERNATIVE if !XIP_KERNEL
 	select RISCV_APLIC
 	select RISCV_IMSIC
-- 
2.39.2


