Return-Path: <linux-kernel+bounces-246252-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 32C0192BFA5
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 18:22:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A89E7B29C05
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 16:20:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6A4A19E7C8;
	Tue,  9 Jul 2024 16:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dc8+heEE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25F7419DF92
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 16:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720541989; cv=none; b=M4k29sMLZunK3Zi8e36/BSvVCSpOfH6zLPcXInFqwcwnfsmL3or96d+hl1ynVieavnquXQ86TU1GqAzuS/mWn9q9vnv/I6pGemDLoeyUXfoy93gtPSwiKPXbOrY6hX0KssYF3r6ZwA5ZyIjYPaoE1CIerPoDeljRTJ49A9N9hlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720541989; c=relaxed/simple;
	bh=LxdHS/iVvGgXLX0NrhPkm37EW8j2G1mEgzmdRErP8WM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nkArkeBY+QS/5SsN+kASzqZe4SY7u8Q18hulg/3X98ipFqUCvDYMjtyuY/eo4zvXemv5qNcNbKGtWu/65BP33svb8sTw717rZutkBxvY9qGIrbgGMsFQ55OoZQadEWv+Wm6e/sbJEC1VxZkdbyh/Wu3Dfgk/60rfVL1y+phdFlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dc8+heEE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE1C7C4AF07;
	Tue,  9 Jul 2024 16:19:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720541989;
	bh=LxdHS/iVvGgXLX0NrhPkm37EW8j2G1mEgzmdRErP8WM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dc8+heEEUlEQjy70KsSTH6WNgfr8V+N9kGMBv9C35PjHVuocYJwbEBglMVi+o/lXM
	 YQvK7dBQ6xSpg91CLqMXNYHmFNGV+DoYdZN4OHwbm6hyAJ09+RgDpQtCnDHSoxxvvv
	 INGvM+JoJ/pGu/ERfbcj/ApJI8WRNiPeOv2/4aCdMYFIZ+zKfCdPSO5IwS/c8lmRxE
	 6G6tMM0SGzTm5PDxiAAXy2FUXjpqmpa8b65AL+QBvmYdJbTS5Q5M49Ge0uVrKeN2Zp
	 hOTCxHP+NjFM5oIxyaEmJqR+Lx8Dw+Dfn5cpJfgPF+wDWeQGr2NnB68SIctQrznvMy
	 5qm3bqaeOHyig==
From: Jisheng Zhang <jszhang@kernel.org>
To: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>
Cc: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] riscv: select ARCH_USE_SYM_ANNOTATIONS
Date: Wed, 10 Jul 2024 00:05:22 +0800
Message-ID: <20240709160536.3690-3-jszhang@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240709160536.3690-1-jszhang@kernel.org>
References: <20240709160536.3690-1-jszhang@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now, riscv has been converted to the new style SYM_ assembler
annotations. So select ARCH_USE_SYM_ANNOTATIONS to ensure the
deprecated macros such as ENTRY(), END(), WEAK() and so on are not
available and we don't regress.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 arch/riscv/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 0525ee2d63c7..c51b32a8ddff 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -62,6 +62,7 @@ config RISCV
 	select ARCH_USE_CMPXCHG_LOCKREF if 64BIT
 	select ARCH_USE_MEMTEST
 	select ARCH_USE_QUEUED_RWLOCKS
+	select ARCH_USE_SYM_ANNOTATIONS
 	select ARCH_USES_CFI_TRAPS if CFI_CLANG
 	select ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH if MMU
 	select ARCH_WANT_DEFAULT_TOPDOWN_MMAP_LAYOUT if MMU
-- 
2.43.0


