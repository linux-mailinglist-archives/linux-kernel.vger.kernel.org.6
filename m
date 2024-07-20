Return-Path: <linux-kernel+bounces-258028-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 508F9938249
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jul 2024 19:27:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BE7AEB211CE
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jul 2024 17:27:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC3ED1494DD;
	Sat, 20 Jul 2024 17:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QihgeSnv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ECAE1494C1
	for <linux-kernel@vger.kernel.org>; Sat, 20 Jul 2024 17:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721496419; cv=none; b=Rj3enFeR8Wwc9Uhmub40fzvV+vdTmPPMlfhh0kCqxgAS7LDBqpX7ALOllM1Cl2rR8169AbkqXugD1wBd6lR1MLOvApSclE8tuzPWFqHUi2o96ZQevqK3+FphLY8b97uI6GfnsrDb59e6DCiI3B69jlOmHowFiY6WDh0JKYt7AAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721496419; c=relaxed/simple;
	bh=Xt3rus8MTwutIvQ5H763TfjQNRRFpnqcC5IzkxuWKNs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=egA7JcufuMqEICg2X9Z/qDCtxD6n7E8VnWdL9Vo6H+4SMs4sR+O1ImNHHrKE0ICvrvqK/pIrV2UIskuyqjobNWlb578TZzZsPOXjlGWIg/NDkdSz0XMwJweI3SIfBu5/nqe7hBmIzMbxDO/bWIMSzRrnBehjdiAbjcmWfSHGhAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QihgeSnv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84504C4AF0A;
	Sat, 20 Jul 2024 17:26:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721496419;
	bh=Xt3rus8MTwutIvQ5H763TfjQNRRFpnqcC5IzkxuWKNs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QihgeSnvf2PG6PDvXw42EUn9W2Oi9atxy4Nf7WqIlvZyRTC4qpgDd43bxadaHLI8o
	 G7TVwBqzG9gC9FOAqBErLA9cR1tph4INUWAYs/GaWoQuthn76MwevRLw+oBVXpxsYw
	 QI8kpRYJGwRWvkACHfZtzQ5N7F9OMML+EPWNft5t3UUI9MSAaWT9SLH6EcfTXgX2jn
	 eTqRuMFQtySTtIJP/MeDVsb6yVHCFN6iTkA5CWHMn01XwPx6IA1DAjrZFPRwvVd+ct
	 gfkP4W7c3SC+BZ+aASXMRVuewUoo2jvRede2Xbp+Q3R2VxVuw8qaED7MjWaDz1pip3
	 YBG1UIfA5btfQ==
From: Jisheng Zhang <jszhang@kernel.org>
To: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Charlie Jenkins <charlie@rivosinc.com>,
	Deepak Gupta <debug@rivosinc.com>,
	Clement Leger <cleger@rivosinc.com>
Cc: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/7] riscv: errata: sifive: remove NOMMU handling
Date: Sun, 21 Jul 2024 01:12:30 +0800
Message-ID: <20240720171232.1753-6-jszhang@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240720171232.1753-1-jszhang@kernel.org>
References: <20240720171232.1753-1-jszhang@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since NOMMU is now properly handling in generic do_traps() which will
call do_trap_unknown() for instruciton page fault for NOMMU.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 arch/riscv/errata/sifive/errata_cip_453.S | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/riscv/errata/sifive/errata_cip_453.S b/arch/riscv/errata/sifive/errata_cip_453.S
index b1f7b636fe9a..6f004a1610f6 100644
--- a/arch/riscv/errata/sifive/errata_cip_453.S
+++ b/arch/riscv/errata/sifive/errata_cip_453.S
@@ -23,11 +23,7 @@
 
 SYM_FUNC_START(sifive_cip_453_page_fault_trp)
 	ADD_SIGN_EXT a0, t0, t1
-#ifdef CONFIG_MMU
 	la t0, do_page_fault
-#else
-	la t0, do_trap_unknown
-#endif
 	jr t0
 SYM_FUNC_END(sifive_cip_453_page_fault_trp)
 
-- 
2.43.0


