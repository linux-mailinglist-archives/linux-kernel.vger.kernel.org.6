Return-Path: <linux-kernel+bounces-206699-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ACFD5900CD6
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 22:23:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 48EB01F201A0
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 20:23:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 904F915539F;
	Fri,  7 Jun 2024 20:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jV4r27iO";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qenheITo"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22506153BC3
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 20:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717791740; cv=none; b=RRgA9GuU6Wv4bT3pPcDf4vl49djAO8ZfdmW4gKvlT+3I5tleRvcG7q92viLjKiY0uwCu+VMoBDd1dwTiamggvpljLx0IlLSht753+O1jrkeRwgGnpx+dLkOL6JKbdta3WXaLXeenPb50SjHMKnFppvGBhm7geCb0yOZjy4gs+J4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717791740; c=relaxed/simple;
	bh=CnPSiJoSkTaS4DgxuVepbWdO7rowLFCL7+5optFOhBE=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mEwJyXvKejkh+LbUip1cWXghIQX6ToZJTl2yyFKWAkgbE4N0ISkAg2nrNOQXVYAmeKU4MiSYX2aD79QO0VCF0eqlCc+KbY4TwJKR7/4woJ49dI35sVSS4GZkl+R80aB030579qhtENbKFOardCkjZjtAXCaNj9EWxnMghsWEzSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jV4r27iO; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qenheITo; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1717791734;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y4FmsaK4U8owu4NlSDzmS6G8DVihDPJxkQgSL8xnqno=;
	b=jV4r27iONhJVERHB641eznAaftrwZ3nE682uV9gC1aGX3evxbgEtI3+I/GGIFZOgjpwiHX
	jrivhNjIULLbcTEF1ebUWj0KfocGBOpUnJ089SgjLwdKHrT3YqY/Eg0SXgoahKrD73OQPD
	GIPo3UKx7rqQ8OQfdvFUdf7X8OHayoEhJvPcmX6BDOlSxCWNVz6CkE8p3Fk92DtWshTiPF
	dt03h8kY0i0/VeSoJX638ThLxRh0Z3R5ck0NRVVs8N5T4i5pkp03gk2RhX4GYCP2ODf4pk
	b/rBf/p5UzcV/U6PLxXYHL0ZFnOUVb7oknY6vFnqE2fmMzHNT9Mjn98ZwcXy8Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1717791734;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y4FmsaK4U8owu4NlSDzmS6G8DVihDPJxkQgSL8xnqno=;
	b=qenheITowqvS4kQkmh3FtMet7WUSPFv4Sdzt965PbpQbng2mrMAKUNPxeXEZyrFEa0dnT6
	byAMvr7yCjRM4vBg==
To: Alexandre Ghiti <alexghiti@rivosinc.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 7/8] riscv: drop the use of XIP_OFFSET in create_kernel_page_table()
Date: Fri,  7 Jun 2024 22:22:12 +0200
Message-Id: <4ea3f222a7eb9f91c04b155ff2e4d3ef19158acc.1717789719.git.namcao@linutronix.de>
In-Reply-To: <cover.1717789719.git.namcao@linutronix.de>
References: <cover.1717789719.git.namcao@linutronix.de>
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
Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>
---
 arch/riscv/mm/init.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index 313459329d16..b7b6affd4b79 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -911,7 +911,7 @@ static void __init relocate_kernel(void)
 static void __init create_kernel_page_table(pgd_t *pgdir,
 					    __always_unused bool early)
 {
-	uintptr_t va, end_va;
+	uintptr_t va, start_va, end_va;
 
 	/* Map the flash resident part */
 	end_va = kernel_map.virt_addr + kernel_map.xiprom_sz;
@@ -921,10 +921,11 @@ static void __init create_kernel_page_table(pgd_t *pgdir,
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


