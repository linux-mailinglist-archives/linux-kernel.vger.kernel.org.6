Return-Path: <linux-kernel+bounces-173630-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B9E28C031E
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 19:31:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A86C9B22331
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 17:31:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 922D712AAC7;
	Wed,  8 May 2024 17:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vVy8qvlN";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TsFzMXTa"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 683A12E3E8
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 17:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715189480; cv=none; b=rHv9062GMxf81KajK4hpuXWAJQz1y1+S0tdaLNOj93KMq3u0is9HMf+g0hUqHCmEXXeR7viZiBGmse/uPgZknYe3HnW8oUcBAmfmHOp/ET8RjzsAqrjdKPzBFAW/p9G74gPViIQfX6PFVr74pNjSJhuAciiGXmKZmNmcFi/ZCrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715189480; c=relaxed/simple;
	bh=EGSLti6hDZCZp3+9aWSRBrwaYaLNuhgib5RIQ9946Jc=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=TFFROJncO3EbghvRW+StwfRrAr2kFGEEKODmiM9vW7Y8qPJB0c8Qh0XTbplkYD2JAJxHK60P0YGcAkCL1200b0MVCoa5ChSDkcnKMBSd89CfwJa4zx8lMNTAcHVr4ooM/TJ3nRHU7ta1xea7Nd2BfOaSAqo1sFTwFzr9EGNIAtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vVy8qvlN; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TsFzMXTa; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1715189477;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=e0C2Sa+Ice2dYwvVccSs+oEF61GNXb4TH0cOy9XvlW8=;
	b=vVy8qvlNC9U0HL2SlYgzFblLB2M/X/P8pfzpzJ4LpdWDbp8//PosSd/F2PXXMRXrBe1Wzg
	1LzA3td9kat51Jc8GuvETVYD2+qoYYR+PWHAPKzK3s4NAm1kUhE8eaQmTwvcKm+YQNt1M4
	YX6O0ulNQL1LZ5ajog5ZCR+K02uUZXDo/+56v/oN87trdlC9iT6ns2LEymm83jybi9z5AT
	fBPwPZrZyey/9Kl228nQMrabMjg1xTTlKkACNpgUTtb+XMM7a7Q4yD7Iuji7oXzimqOH5I
	tligCfg9qTbOSK/tkQI06N50S60LiUjf+0UVhWvoZEfSUf8T+jCCiAB9FBVAeA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1715189477;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=e0C2Sa+Ice2dYwvVccSs+oEF61GNXb4TH0cOy9XvlW8=;
	b=TsFzMXTanDnoOVXl77mMiaef1NFwhltDqMAasvptpJf/7jgoCJeeoEHVkKnclZxfZry7Yc
	pLz85r9eP42S+yDQ==
To: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] riscv: Don't use hugepage mappings for vmemmap if it's not supported
Date: Wed,  8 May 2024 19:31:16 +0200
Message-Id: <20240508173116.2866192-1-namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit ff172d4818ad ("riscv: Use hugepage mappings for vmemmap") broke XIP
kernel, because huge pages are not supported on XIP kernel.

Only use hugepage mapping if it is supported.

Fixes: ff172d4818ad ("riscv: Use hugepage mappings for vmemmap")
Signed-off-by: Nam Cao <namcao@linutronix.de>
Cc: Alexandre Ghiti <alexghiti@rivosinc.com>
Cc: <stable@vger.kernel.org>
---
 arch/riscv/mm/init.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index 968761843203..c081e7d349b1 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -1414,6 +1414,8 @@ int __meminit vmemmap_check_pmd(pmd_t *pmdp, int node,
 int __meminit vmemmap_populate(unsigned long start, unsigned long end, int node,
 			       struct vmem_altmap *altmap)
 {
+	if (!IS_ENABLED(CONFIG_HAVE_ARCH_HUGE_VMAP))
+		return vmemmap_populate_basepages(start, end, node, NULL);
 	/*
 	 * Note that SPARSEMEM_VMEMMAP is only selected for rv64 and that we
 	 * can't use hugepage mappings for 2-level page table because in case of
-- 
2.39.2


