Return-Path: <linux-kernel+bounces-175330-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E67508C1E19
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 08:30:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98B4828346D
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 06:30:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E62D1527BE;
	Fri, 10 May 2024 06:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vUci3mxs";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="E9NLekMt"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B0CB16133B
	for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 06:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715322538; cv=none; b=YcvCuhLs+WRQaFgNLZh/qNgMrEfwOExrdqi5QxWuGC+kmyzd3PacemF+wr8W+rGD/KJ1uWKgD4fVqOckRd1dtCTS4bCVmC9oksyGozzUYDhP19iNkovBkdXdf+0W5EiVb0xjFHw2pVACLJ0Rmai5PGIzgIkaCVDGIvaudaH+KJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715322538; c=relaxed/simple;
	bh=CNpdEK3MJv43HW1yYZPberffHKHd6wwAinUzJcICKdg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XbknMt4+/sxIA7mUyNt7tvNZdk7pvqvrYvje2KNbIWWbKBkB687RJ8ieOWGLmOswl8E2YLaVfY4StCUBubsAnAD/T8P7KymFIDIN2rTl7h9gWecp+TPFz2g7HdXjVIXtzXg8JQtey6ag3h0MHCLa7SHBF52TaAqkdRd02ezw/bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vUci3mxs; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=E9NLekMt; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1715322531;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=klI6/ArsoUUqM1dHkfkXFimVv/Utnrzo9cziv0cncTY=;
	b=vUci3mxsVRkrS+PdrHpT4mSD+AuQXFTlpS/Cp66iSbOTbRw1Yc14DiTxc5OFSYWwCzZS9v
	xu3+PRzERyR5CVCZVS97bHq9ZPKUbTyU9xpMg1yVKEhJtw+3h5Nhs8kj73NIQ6JwpSEh6I
	TtEXrdkkrfSdVyylXSe8LrANkF3XeXG9jBtWvxAzIJI5Ohh7QWivHZTl1G/bVwF6d1tKAP
	gO3wacbTFb7dfqy9/vi/ogfBDWwywW3dFX8C7bG91S5Ggh8pE0G/kPcKwIH9OfyY3WIbrJ
	3KZLb0qX+Dw1l01Qh7jxAQSGB3j9qxyEVlwWEkhCNjQiG9cXTQr0FhAaXQ8hYw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1715322531;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=klI6/ArsoUUqM1dHkfkXFimVv/Utnrzo9cziv0cncTY=;
	b=E9NLekMt7HVvwSbWb2yg+E0ZsWU/PWXTBilGU3G5C04v2aon3LtmJ9VbZOToLP9+yDAYLF
	W0uNWoYSrn3DaqAA==
To: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Nam Cao <namcao@linutronix.de>
Subject: [PATCH 6/7] riscv: drop the use of XIP_OFFSET in create_kernel_page_table()
Date: Fri, 10 May 2024 08:28:44 +0200
Message-Id: <8748eab99d76e466a44a0bb81d836ff1c9ad9879.1715286093.git.namcao@linutronix.de>
In-Reply-To: <cover.1715286093.git.namcao@linutronix.de>
References: <cover.1715286093.git.namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

XIP_OFFSET is the hard-coded offset of writable data section within the
kernel.

By hard-coding this value, the read-only section of the kernel (which is
placed before the writable data section) is restricted in size.

As a preparation to remove this hard-coded value entirely, stop using
XIP_OFFSET in create_kernel_page_table(). Instead use _sdata and _start to
do the same thing.

Signed-off-by: Nam Cao <namcao@linutronix.de>
---
 arch/riscv/mm/init.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index 9846c6924509..62ff4aa2be96 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -907,7 +907,7 @@ static void __init relocate_kernel(void)
 static void __init create_kernel_page_table(pgd_t *pgdir,
 					    __always_unused bool early)
 {
-	uintptr_t va, end_va;
+	uintptr_t va, start_va, end_va;
 
 	/* Map the flash resident part */
 	end_va = kernel_map.virt_addr + kernel_map.xiprom_sz;
@@ -917,10 +917,11 @@ static void __init create_kernel_page_table(pgd_t *pgdir,
 				   PMD_SIZE, PAGE_KERNEL_EXEC);
 
 	/* Map the data in RAM */
+	start_va = kernel_map.virt_addr + (uintptr_t)&_sdata - (uintptr_t)&_start;
 	end_va = kernel_map.virt_addr + kernel_map.size;
-	for (va = kernel_map.virt_addr + XIP_OFFSET; va < end_va; va += PMD_SIZE)
+	for (va = start_va; va < end_va; va += PMD_SIZE)
 		create_pgd_mapping(pgdir, va,
-				   kernel_map.phys_addr + (va - (kernel_map.virt_addr + XIP_OFFSET)),
+				   kernel_map.phys_addr + (va - start_va),
 				   PMD_SIZE, PAGE_KERNEL);
 }
 #else
-- 
2.39.2


