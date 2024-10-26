Return-Path: <linux-kernel+bounces-383296-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A24449B19A6
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 17:54:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4D201B21076
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 15:54:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9C1A7E591;
	Sat, 26 Oct 2024 15:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="INVacg0Z"
Received: from out-187.mta0.migadu.com (out-187.mta0.migadu.com [91.218.175.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8CEB23741
	for <linux-kernel@vger.kernel.org>; Sat, 26 Oct 2024 15:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729958040; cv=none; b=GlJqsYpk8wcEKXDgZQhdej4S4eavoZtJLDKoQ07H8aQuyfkz0qf6mDfrSvuo9ECB6OYgzEQHHMH8s0T4LumBuMAHQCHmuOJtOhURc9Xkx1EEPYlYuMWRvgv9iRACvNQpiTII8DYpxzo1m01ieGIO3+ApOsMqw+RL2+foLGJloI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729958040; c=relaxed/simple;
	bh=X4FrbSoyY3nl2u9HVc4ER9FQGO1gtD9pEGPdPZRliTM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZzSCevM01wxHwMvnB9toizu+WLcwGm3Hzo7HGcfy1qyYdZxBAcmVOkGHDMTwOxIWaXF3ym1WWlDlYHnL09eo6L77dWZDGXsdMqfYDDnMDVqHTW1qPDElzRwy5k3FNLejaF1Z+0On+buJs3a96cSdEtg7f+sA3AiMzenHnp9HsyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=INVacg0Z; arc=none smtp.client-ip=91.218.175.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1729958034;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=s1YWqkMnBtrc9mboMzUV/AKv/C9CTZRcvX8zL+thI+w=;
	b=INVacg0Z0r9fQ06HVo8JITG0U8zRvnfEjZWymSfk/5qTJ88H8Qm46NYb5bb26jnh5+7EfA
	q8IPnsG/Hw12pFQJ1Qu4vJhrlXMhHk6kjPKXOSTHP1RYZ4sOXZS2opYxJVZR9Wbn04+AMv
	leloHx83XOHYKl8R0moSC8BQ5Xf7ZVI=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Dinh Nguyen <dinguyen@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RESEND PATCH] clk: socfpga: arria10: Optimize local variables in clk_pll_recalc_rate()
Date: Sat, 26 Oct 2024 17:53:04 +0200
Message-ID: <20241026155304.159716-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Since readl() returns a u32, the local variable reg can also have the
data type u32. Furthermore, divf and divq are derived from reg and can
also be a u32.

Since do_div() casts the divisor to u32 anyway, changing the data type
of divq to u32 also removes the following Coccinelle/coccicheck warning
reported by do_div.cocci:

  WARNING: do_div() does a 64-by-32 division, please consider using div64_ul instead

Compile-tested only.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 drivers/clk/socfpga/clk-pll-a10.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/socfpga/clk-pll-a10.c b/drivers/clk/socfpga/clk-pll-a10.c
index b028f25c658a..62eed964c3d0 100644
--- a/drivers/clk/socfpga/clk-pll-a10.c
+++ b/drivers/clk/socfpga/clk-pll-a10.c
@@ -35,7 +35,7 @@ static unsigned long clk_pll_recalc_rate(struct clk_hw *hwclk,
 					 unsigned long parent_rate)
 {
 	struct socfpga_pll *socfpgaclk = to_socfpga_clk(hwclk);
-	unsigned long divf, divq, reg;
+	u32 divf, divq, reg;
 	unsigned long long vco_freq;
 
 	/* read VCO1 reg for numerator and denominator */
-- 
2.47.0


