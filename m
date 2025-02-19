Return-Path: <linux-kernel+bounces-521339-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DD10FA3BBCE
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 11:43:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8D88189A091
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 10:43:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A46FE1DE4CA;
	Wed, 19 Feb 2025 10:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="lHxv1rQW"
Received: from out-184.mta1.migadu.com (out-184.mta1.migadu.com [95.215.58.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30CB01DE3D6
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 10:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739961789; cv=none; b=Z78lNEXWUQffJRZ6FRNQ4Xe+BrQk9pBSY9LvAIr43X4f192qrakCv8mFj5sHPtFmCDzZ4Q938cQv3xwinhaamvYcQd0EozM1u89u4Eae/lQB1yLuqNSyj7c5wOmCQxwyzFqm4jW21KyjIICgqjhcwBhQhjBS5wf5/b3kCI4N7s8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739961789; c=relaxed/simple;
	bh=vwR3Dde9N6LUvIAX31OqMPbVsGjC70xuGq4f8HLd26E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dMFdejgMCV5qJjiS/w7Dotx34lVbZtiY+rPotRc/zUmSYUSYGF3xRkg3KAF6tRq5Zy5MGngoq0hp+Ue1rxdMI+gH+Ikqn59DyczLQKIls4hpyM2Y16+DWAfd/0inlOCjeQjGcVp3jY8ZwtSOKIo4B66mJ4+l8r+O+lJNvFej8eM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=lHxv1rQW; arc=none smtp.client-ip=95.215.58.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1739961775;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=QxvIf0tFqiiS1NmW0FA0jKf0OtND4XikKa8Y58GH4EI=;
	b=lHxv1rQWpHbfW+N4AgLzhTYe7M4eaBT/+pjHprX0XgHRRUsZ7S+IT67OMUEBe7GF8VMRBD
	gr+tBV6qRPNqbo2BHMZ+8zoHd2MBumYf/gEJymM47CuyhPor8G5UDbE7howjn142pX1Hxq
	kRzdJ15csJDpFR7Y6rW7ANTfhZIrfKs=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Dinh Nguyen <dinguyen@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RESEND PATCH] clk: socfpga: clk-pll: Optimize local variables
Date: Wed, 19 Feb 2025 11:42:25 +0100
Message-ID: <20250219104224.1265-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Since readl() returns a u32, the local variables reg and bypass can also
have the data type u32. Furthermore, divf and divq are derived from reg
and can also be a u32.

Since do_div() casts the divisor to u32 anyway, changing the data type
of divq to u32 removes the following Coccinelle/coccicheck warning
reported by do_div.cocci:

  WARNING: do_div() does a 64-by-32 division, please consider using div64_ul instead

Compile-tested only.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 drivers/clk/socfpga/clk-pll.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/socfpga/clk-pll.c b/drivers/clk/socfpga/clk-pll.c
index 9dcc1b2d2cc0..03a96139a576 100644
--- a/drivers/clk/socfpga/clk-pll.c
+++ b/drivers/clk/socfpga/clk-pll.c
@@ -39,9 +39,9 @@ static unsigned long clk_pll_recalc_rate(struct clk_hw *hwclk,
 					 unsigned long parent_rate)
 {
 	struct socfpga_pll *socfpgaclk = to_socfpga_clk(hwclk);
-	unsigned long divf, divq, reg;
+	u32 divf, divq, reg;
 	unsigned long long vco_freq;
-	unsigned long bypass;
+	u32 bypass;
 
 	reg = readl(socfpgaclk->hw.reg);
 	bypass = readl(clk_mgr_base_addr + CLKMGR_BYPASS);
-- 
2.48.1


