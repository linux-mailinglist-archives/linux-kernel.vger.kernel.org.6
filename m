Return-Path: <linux-kernel+bounces-521341-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 41E7EA3BBD2
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 11:45:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C9BB27A5AE0
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 10:44:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13E841DE4CA;
	Wed, 19 Feb 2025 10:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="h0LKRF3P"
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADE261D5CEA
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 10:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739961903; cv=none; b=ucvaKkGQ9p18XBvs1+3zldz7Dpdg5gnLhtSIkDpvh/BxsZTCuEPZGG8yd2kBwgVzXfYbmvq/1xyksAjbZTDf5Rva/0Nl4i4m8lNz6WMlbxEhNmlGZhLBc56uJBqPN1o8RctCzJv4vAescgo7HdaC64QRBBK0QFuzk/qG5EpmkUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739961903; c=relaxed/simple;
	bh=yOasvxAPT+33s1e8WIhGVLyj9p6z+7KuZNdkuNuKPQI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=o8WAsk+NGeZr9Jjirmi7B8f6jWQPn+DYWgcg/gWynsqm2ftBnJhgypBCYu6WOKubK3rFFytqq4EO0BHfLRcjU5NdXJGMr5ADgAtwZ9BDzWQSvltlQI2eVDrp+jZOomqreDGPA4YsaQIXPR2XUxLO3QVQBk07b8v4Cu6Nnz/RGrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=h0LKRF3P; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1739961889;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=+lLHrG6tRNaGKq8TsOg3rt8iC7m9nw0vu2rC3UkGSno=;
	b=h0LKRF3PkNW/x1UQSwcIU5DKC/9ASBUFtlWxCxJOgjyBSlmqTvp11D2GtOZ9H8gmwWHzxA
	c0mXEM1Mz3szoFFvq1tbZggD/wHHScVhTgxCninZYq8aYJv6UVDJJ/jHbPt6AczdLPsV4U
	oncHpCYcxO5acySrn09ZHTwgwWjusDE=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Dinh Nguyen <dinguyen@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RESEND PATCH] clk: socfpga: stratix10: Optimize local variables
Date: Wed, 19 Feb 2025 11:44:35 +0100
Message-ID: <20250219104435.1525-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Since readl() returns a u32, the local variable reg can also have the
data type u32. Furthermore, mdiv and refdiv are derived from reg and can
also be a u32.

Since do_div() casts the divisor to u32 anyway, changing the data type
of refdiv to u32 removes the following Coccinelle/coccicheck warning
reported by do_div.cocci:

  WARNING: do_div() does a 64-by-32 division, please consider using div64_ul instead

Compile-tested only.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 drivers/clk/socfpga/clk-pll-s10.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/socfpga/clk-pll-s10.c b/drivers/clk/socfpga/clk-pll-s10.c
index 1d82737befd3..a88c212bda12 100644
--- a/drivers/clk/socfpga/clk-pll-s10.c
+++ b/drivers/clk/socfpga/clk-pll-s10.c
@@ -83,9 +83,9 @@ static unsigned long clk_pll_recalc_rate(struct clk_hw *hwclk,
 					 unsigned long parent_rate)
 {
 	struct socfpga_pll *socfpgaclk = to_socfpga_clk(hwclk);
-	unsigned long mdiv;
-	unsigned long refdiv;
-	unsigned long reg;
+	u32 mdiv;
+	u32 refdiv;
+	u32 reg;
 	unsigned long long vco_freq;
 
 	/* read VCO1 reg for numerator and denominator */
-- 
2.48.1


