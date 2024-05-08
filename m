Return-Path: <linux-kernel+bounces-173745-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 887788C04CA
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 21:19:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA5AA1C2129F
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 19:19:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A286130A50;
	Wed,  8 May 2024 19:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RdRsqh5t";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YH3r0xnK"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3D30130A4C
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 19:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715195961; cv=none; b=Af/Eb0jfKTsrUWIvZoBbBdLCopAmYR6onkhU02F6tgsqYFgF/oC+3H/9JqviEFSMYQk1Sbg97eUK2H49Hx6h9bj1qrKTwFqYaTI343MCeUKE7OXOch7TNOtEIFGTo8kPu2SWGM8Fz2Z/vbNQEXSFvm1YEk2JZR4K5KPG46rGHsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715195961; c=relaxed/simple;
	bh=jH88eul7dXJ5lPQd8aQYwKQzV3eep8y6Qd3LrIJf2cc=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=CeE+VSk/Mgt3cYHjqzVOKIyqv9zSuzJaqjNGkszYshqJGOlUMmk0gTfaJaVNzQDc6iloYKXRG6hA98ak0gUIJnfU+5fV+TJFurFfNlu1Pc43ZKKLkKzs4j/q8E/0yA2ej703eCYa8GE4gmrRRxv+Xs0zNDCU//jsHX/EpqAw31o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RdRsqh5t; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YH3r0xnK; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1715195957;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=srojUdq0elW15+CVwv4RHuTpXX7dRNIqURJ4CkMJfK8=;
	b=RdRsqh5t54KsP2O/M/jU5HwPIYVQgwv9Lrd1q7l+fUO/k/kOYFLD7edShEwYjVNq/tmZuR
	9U6BLoFBM4ik7aTRJY7D6wgRfzkYLLKRV6mJl18dIVgjzdM7uhbAFBCq2MB+b7G6sjD9Gx
	J0QEfG+I9+aDwZmY9bgqCbjOijKxxSJ8A8RDsb9hgBrV6MxMZy/OPdnaN2KcmFa3W8tGYm
	2lxSLDdpT+2YABzBdaOEBzpDGYD/nQGvNMUCBSHKMP03ensFCfb+G3qiei0U2HfyGyOi3d
	VhWGGiACW1TkjGM0YE5f0hkOTbHyuJrxyBSV8K7iIcG1+E0hC1aNygxXrMDvgw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1715195957;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=srojUdq0elW15+CVwv4RHuTpXX7dRNIqURJ4CkMJfK8=;
	b=YH3r0xnKW3fJM7laX2dVyK2t3LjsPZTX01UAP3Vp4CIn9yQvWI/UYsmmM0snI1K2U18uDZ
	TPsOZUNmGVOac4BA==
To: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] riscv: change XIP's kernel_map.size to be size of the entire kernel
Date: Wed,  8 May 2024 21:19:17 +0200
Message-Id: <20240508191917.2892064-1-namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With XIP kernel, kernel_map.size is set to be only the size of data part of
the kernel. This is inconsistent with "normal" kernel, who sets it to be
the size of the entire kernel.

More importantly, XIP kernel fails to boot if CONFIG_DEBUG_VIRTUAL is
enabled, because there are checks on virtual addresses with the assumption
that kernel_map.size is the size of the entire kernel (these checks are in
arch/riscv/mm/physaddr.c).

Change XIP's kernel_map.size to be the size of the entire kernel.

Signed-off-by: Nam Cao <namcao@linutronix.de>
Cc: <stable@vger.kernel.org> # v6.1+
---
I wouldn't consider this inconsistency to be a bug. It only became a
a problem after kernel_map.size is used to check virtual addresses in
5f763b3b5960 ("riscv: Fix DEBUG_VIRTUAL false warnings"). So I will only
backport this to stable versions that contain this commit: v6.1+

 arch/riscv/mm/init.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index c081e7d349b1..0c0562839899 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -903,7 +903,7 @@ static void __init create_kernel_page_table(pgd_t *pgdir,
 				   PMD_SIZE, PAGE_KERNEL_EXEC);
 
 	/* Map the data in RAM */
-	end_va = kernel_map.virt_addr + XIP_OFFSET + kernel_map.size;
+	end_va = kernel_map.virt_addr + kernel_map.size;
 	for (va = kernel_map.virt_addr + XIP_OFFSET; va < end_va; va += PMD_SIZE)
 		create_pgd_mapping(pgdir, va,
 				   kernel_map.phys_addr + (va - (kernel_map.virt_addr + XIP_OFFSET)),
@@ -1072,7 +1072,7 @@ asmlinkage void __init setup_vm(uintptr_t dtb_pa)
 
 	phys_ram_base = CONFIG_PHYS_RAM_BASE;
 	kernel_map.phys_addr = (uintptr_t)CONFIG_PHYS_RAM_BASE;
-	kernel_map.size = (uintptr_t)(&_end) - (uintptr_t)(&_sdata);
+	kernel_map.size = (uintptr_t)(&_end) - (uintptr_t)(&_start);
 
 	kernel_map.va_kernel_xip_pa_offset = kernel_map.virt_addr - kernel_map.xiprom;
 #else
-- 
2.39.2


