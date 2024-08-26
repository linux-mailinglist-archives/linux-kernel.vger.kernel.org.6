Return-Path: <linux-kernel+bounces-301081-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85A6895EC1A
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 10:36:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 422B4280D77
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 08:36:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5808F83CD6;
	Mon, 26 Aug 2024 08:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="o9EByFmH"
Received: from out203-205-221-233.mail.qq.com (out203-205-221-233.mail.qq.com [203.205.221.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20E5B55898;
	Mon, 26 Aug 2024 08:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724661370; cv=none; b=NRY2wZlmupOsWaNxzgKrF5k5sQ/f4M3UgVWfyEyUDoNA3WjGcG6FvXpI605qNAShucLDf0tsKvcDJB2NNBhgsS/Vz+ZWW0dYSPuNbUFB0o+RZN5qAt8A6/pBwBx08UUzTomjByf+Fdlf/hrCd0NOyiTC+9f5U5t+esWt12RPNo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724661370; c=relaxed/simple;
	bh=6yDI3/U08ZMOmLmWDHpOWMP0N4gIZcSVtDSd9UUJ6i0=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=chJbtvdcWlAm7o/HUT8NoAFBePIoqJXmrE896Qrzo3HSNEMimIXi/DybO5+LvVabrJcakNQi45h8xdgSR/PJtsXCC9UNvBSeM0lSR6Me7aYNCcxdQvguPR5mO3q/ccnRpSWTSU0q3pBnS6sTUftDPdpoi6DCy5R+rLT6Xie3DS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=o9EByFmH; arc=none smtp.client-ip=203.205.221.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1724661366; bh=TjB1mJGOet0/euYUc4+9dZJCDXiIYJxAIHE7thKe2Xg=;
	h=From:To:Cc:Subject:Date;
	b=o9EByFmHvxibaCecqgVL2mKjSz6TMB8/V4sULitzlYG9AtgBWIX0r8vw+W1dHolu8
	 gCXFgLXQj/XrR0+89DAotqu7q7ZbmjTf1QJ82D2+IYuF8oAAktLwA/UF/BKH8/wh3t
	 I/kSbkjrPNGcmji/qgVpnUQ4dL8nTA2N8wOuMxEY=
Received: from localhost.localdomain ([112.64.14.141])
	by newxmesmtplogicsvrszc19-0.qq.com (NewEsmtp) with SMTP
	id 76A1E6F3; Mon, 26 Aug 2024 16:29:42 +0800
X-QQ-mid: xmsmtpt1724660982twivsddyp
Message-ID: <tencent_713186AE6290AC7B8037FD247F5BF04C0308@qq.com>
X-QQ-XMAILINFO: OK7NBzdNss/RjFx9qnTP6wLjsMMMhlfJyMu1aOp7jdULQYCQAB/jXasbYhRaZn
	 F4qK0gr/EVa87F6sA5udRfyqQADMucnPUjLbEPuyBz8nDykkjZWL/HKD81hEo6yuyzgubtxKx02x
	 um1xL57uTLB86VHz2IKNSIeY2q0UThr51Avq7nIFmxsYa+rJcNgA39FyTWdxLuN61EM64TosbtoA
	 TXMMwVp72jRlB1i5qzvrZ7hLBEuRdhDulmjUPdExbk+wdeA1qGoEze05sYeTtd0evm6ZEW07v5Qk
	 Frivg02Pz6Qnz/hUtGs3W6kDb6IAXCnBGLtgoqGbXJVbmC9r3esLWUadLDmF/xQ4CYcfcoe+3/6i
	 RLNFIerV7vtpZpd7p0mqYPRP+1rY00Go/XSrJSfvyOYcJnoh6S0f/E1iO6j1y+hZQ1FKzVqbIupL
	 g48P1rM6pksRYHklbI3DeMaj551zqgfVri8Xl9n0cYytv8i1+uSLtfYkNohYikUWMbZZ4DxvJYq0
	 z1pjKuzJa4zk5fCepKHWLx6Z2+tDsRADqOavbEOPJ1LqKkjxuXa2NZYatA/QOnxL0jrhgV9+TVO2
	 cSby56RYoAKE9gn27zNoR8PG8dKLJXEpjYWD1j9MsfAp2yqTdedVWGjAGXzb0vOQtFj1uHBy55uL
	 AA92myph3+aYT0Iu1c8SYPcvh3LrfSSkhWoWegX/1ttJ25AFgQba+XcOQ7n0sBg0UAMyP4w8jDaF
	 /ZnAOM4OwvSZOJw2VwLDOMUU6ihA6tpycFN0YMN4029ybWPeh+wZgGXApKkl0clb6Y4dpuo+/Wkb
	 OKWb4C9wNNVb5stuuxgngNHJVpp7PJIqg2ZDqK3ZUqTX8KggP1ZDHfRLrPddhOngzpX/qcXbZR4V
	 dglYtGDRvQG21+vK2rjvgbpGeqsszlqxdOnWaT38ISI2ybOgLaFKIHOZz03VMFtGZe7Uud7X2RpW
	 bIWyu0pMJm7lp4fSZRY8A7vj/hFB7MrAiPt94wMadeJdtkF7AMRCQ2eF/2WBm5l8ysozGS2DfjCJ
	 ySmIO5Z21atEWk89O3
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
From: jiping huang <huangjiping95@qq.com>
To: mturquette@baylibre.com,
	sboyd@kernel.org
Cc: linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jiping huang <huangjiping95@qq.com>
Subject: [PATCH] clk: Delete redundant logic.
Date: Mon, 26 Aug 2024 16:29:39 +0800
X-OQ-MSGID: <20240826082939.2377-1-huangjiping95@qq.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In fact, the local variable "best_parent_rate" saved at the function
entrance is not used later on.

Signed-off-by: jiping huang <huangjiping95@qq.com>

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index 8cca52be993f..d076939c42ab 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -2295,11 +2295,6 @@ static struct clk_core *clk_calc_new_rates(struct clk_core *core,
 	if (IS_ERR_OR_NULL(core))
 		return NULL;
 
-	/* save parent rate, if it exists */
-	parent = old_parent = core->parent;
-	if (parent)
-		best_parent_rate = parent->rate;
-
 	clk_core_get_boundaries(core, &min_rate, &max_rate);
 
 	/* find the closest rate and parent clk/rate */
-- 
2.34.1



