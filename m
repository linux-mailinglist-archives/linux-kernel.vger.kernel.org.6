Return-Path: <linux-kernel+bounces-269087-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6268E942D66
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 13:39:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94F291C21A55
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 11:39:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AFB91AD9EA;
	Wed, 31 Jul 2024 11:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OB7OS++f"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33A431A8BEF
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 11:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722425975; cv=none; b=UNrHVBdubtpQ6d1Rae3Un6xOUTGRQzgwz0WyDGvLUhzYnip5dHtkodtoPvF1NLTNccHXjUkm/B4/ytfwftjHSmUDqFql4cktHWdM9FdSOUj3+XocnnqSd1X277rMphkePB3MV4oEe/QHh1lbD1ZwQl39aT6yVz947gHhLbnS2/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722425975; c=relaxed/simple;
	bh=Sqp4QMCAb+3yPAvyOyWl6RP06SAAmeeES7e2qhgudA8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aDq4PYdX/P9/5PzWewDm8jlrfAjrg1YlTrM84UezE7V42yPr3+E/g8mhP61Uq0ZyYTeoNcQr9+ngafP7o3GJ4nYCFCUXMyNbtjekCxGhFRv+kTzyPWyKkuHgXs1HS9LvoytprM9wmsJfJJZj09LlDB3LePcsKELAU03aYL6BGRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OB7OS++f; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-70d162eef54so3926342b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 04:39:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722425973; x=1723030773; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ufe9f1aVq4XJvqV0V6RRRWx503LS6so5gVk+Ooe+2bY=;
        b=OB7OS++f6mB3CI2HGdywZS2mQ/jEFRy2SN4gM0Q+js59P05zbDa2a+tgNxT53CdqLx
         ssbxWU9DtlPkMb0M6QtcyNJBwtzZYP639pSPZAVig0neOosZovIun5l8Nl1DpsnrJc4r
         ztoXRL7qDOMLKbvH+wNg2Mf5vafsvQCDq8n6rXZHUV0Zwv2bOnhfKV4w1/oR7bi4gLhr
         YoJAPLrLRj0/WXBt+JknHaR7DfGusUdeY6WNvWUUGEpz3+rhuqERWjjGd3Z+yzo/c+b0
         iSOgZ7meDY6ALDxXEvg30LLPKvckN/tbK1yWtLVEjMpRvs/PNgMWGjl954yuzccnbu9F
         9opg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722425973; x=1723030773;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ufe9f1aVq4XJvqV0V6RRRWx503LS6so5gVk+Ooe+2bY=;
        b=Mtd5vaYeuLL71lq4f8vgob91r+McHsqAKIupZ5hLtoJcgN/i8CjEkkuXXRpfg3dS/1
         ygcIPDmBMSmdZJ4cO26QWOHR9scbEaqj+he64kKfukCqzyO7SA/NrsDsFZ3Zxsr1JwOS
         wWxLwF6uH9n16ltt96iQXF8bjMUE5cN1etRvgC5zIdE+QNaJ3R0HagXFa/+eV23CxVMn
         Jpb1m4pM7fAAlf04h80v+mJQiCZNoPjZePusPzYLvY8JB4aMa5ECLlsqP6/QheO+zGCq
         nts5zN9K3uoC8esKVCOAcEwwHsgokZB/UspwtNjziHy3RMY/7XX5C/aC15DAsK8NuXSc
         oDHQ==
X-Forwarded-Encrypted: i=1; AJvYcCXHx64dSPVODxQl1VTDH5RtMAc+zkL1BofSq54GUaRmrg9jUUJuqUdZWTxA2HFjzCiznaFP09MYfyrASwwoW9tbDn7o+VCg5SMmo0I1
X-Gm-Message-State: AOJu0Yzw8A2vuWcR4v2STa8kYSeCOjnB7RMIWi+BW6jbuAOWpGB4+ySX
	Co8kz/w2FgyLVn5tJA3COhnL64mc4J4gKkog0Wbvr4nFhsb/gpiL
X-Google-Smtp-Source: AGHT+IEpWQE0PpAjVOudxt5MtO5UL/YgFmAYeA5XrPyfqeIgzsAv3P4uAhWllcuzmQBA9T4/qgErtg==
X-Received: by 2002:a05:6a20:7284:b0:1c4:936e:b8a2 with SMTP id adf61e73a8af0-1c4a12cd2f2mr13742329637.27.1722425973414;
        Wed, 31 Jul 2024 04:39:33 -0700 (PDT)
Received: from alif.. ([14.195.28.86])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70ead6e15d7sm9748343b3a.22.2024.07.31.04.39.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jul 2024 04:39:33 -0700 (PDT)
From: Harith George <mail2hgg@gmail.com>
To: linus.walleij@linaro.org,
	linux@armlinux.org.uk,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: harith.g@alifsemi.com,
	akpm@linux-foundation.org,
	rppt@kernel.org,
	rmk+kernel@armlinux.org.uk,
	m.szyprowski@samsung.com,
	vishal.moola@gmail.com,
	david@redhat.com,
	willy@infradead.org,
	nico@fluxnic.net,
	ardb@kernel.org
Subject: [PATCH 2/2] arm: smp: Fix SMP for xip kernels
Date: Wed, 31 Jul 2024 17:09:05 +0530
Message-Id: <20240731113905.3326586-2-mail2hgg@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240731113905.3326586-1-mail2hgg@gmail.com>
References: <20240731113905.3326586-1-mail2hgg@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Harith George <harith.g@alifsemi.com>

Fix the physical address calculation of the following to get smp working
on xip kernels.
- secondary_data needed for secondary cpu bootup.
- secondary_startup address passed through psci.
- identity mapped code region needed for enabling mmu for secondary cpus.

Signed-off-by: Harith George <harith.g@alifsemi.com>
---
 arch/arm/kernel/head.S     | 4 ++++
 arch/arm/kernel/psci_smp.c | 7 +++++++
 arch/arm/mm/idmap.c        | 7 +++++++
 3 files changed, 18 insertions(+)

diff --git a/arch/arm/kernel/head.S b/arch/arm/kernel/head.S
index 28873cda464f..f22c50d4bd41 100644
--- a/arch/arm/kernel/head.S
+++ b/arch/arm/kernel/head.S
@@ -411,7 +411,11 @@ ENTRY(secondary_startup)
 	/*
 	 * Use the page tables supplied from  __cpu_up.
 	 */
+#ifdef CONFIG_XIP_KERNEL
+	ldr	r3, =(secondary_data + PLAT_PHYS_OFFSET - PAGE_OFFSET)
+#else
 	adr_l	r3, secondary_data
+#endif
 	mov_l	r12, __secondary_switched
 	ldrd	r4, r5, [r3, #0]		@ get secondary_data.pgdir
 ARM_BE8(eor	r4, r4, r5)			@ Swap r5 and r4 in BE:
diff --git a/arch/arm/kernel/psci_smp.c b/arch/arm/kernel/psci_smp.c
index d4392e177484..3bb0c4dcfc5c 100644
--- a/arch/arm/kernel/psci_smp.c
+++ b/arch/arm/kernel/psci_smp.c
@@ -45,8 +45,15 @@ extern void secondary_startup(void);
 static int psci_boot_secondary(unsigned int cpu, struct task_struct *idle)
 {
 	if (psci_ops.cpu_on)
+#ifdef CONFIG_XIP_KERNEL
+		return psci_ops.cpu_on(cpu_logical_map(cpu),
+			((phys_addr_t)(&secondary_startup)
+			- XIP_VIRT_ADDR(CONFIG_XIP_PHYS_ADDR)
+			+ CONFIG_XIP_PHYS_ADDR));
+#else
 		return psci_ops.cpu_on(cpu_logical_map(cpu),
 					virt_to_idmap(&secondary_startup));
+#endif
 	return -ENODEV;
 }
 
diff --git a/arch/arm/mm/idmap.c b/arch/arm/mm/idmap.c
index 448e57c6f653..4a833e89782a 100644
--- a/arch/arm/mm/idmap.c
+++ b/arch/arm/mm/idmap.c
@@ -84,8 +84,15 @@ static void identity_mapping_add(pgd_t *pgd, const char *text_start,
 	unsigned long addr, end;
 	unsigned long next;
 
+#ifdef CONFIG_XIP_KERNEL
+	addr = (phys_addr_t)(text_start) - XIP_VIRT_ADDR(CONFIG_XIP_PHYS_ADDR)
+		+ CONFIG_XIP_PHYS_ADDR;
+	end = (phys_addr_t)(text_end) - XIP_VIRT_ADDR(CONFIG_XIP_PHYS_ADDR)
+		+ CONFIG_XIP_PHYS_ADDR;
+#else
 	addr = virt_to_idmap(text_start);
 	end = virt_to_idmap(text_end);
+#endif
 	pr_info("Setting up static identity map for 0x%lx - 0x%lx\n", addr, end);
 
 	prot |= PMD_TYPE_SECT | PMD_SECT_AP_WRITE | PMD_SECT_AF;
-- 
2.34.1


