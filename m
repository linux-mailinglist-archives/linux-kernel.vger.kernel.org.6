Return-Path: <linux-kernel+bounces-524849-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 617B2A3E7D5
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 23:55:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C009B174C84
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 22:55:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 364A0264F8A;
	Thu, 20 Feb 2025 22:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="p8cRiakL"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC6571EE006;
	Thu, 20 Feb 2025 22:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740092103; cv=none; b=YiEY0e7bE7CWROMmkBO7wSnpg36ntKl3/4NmlaCbfpqcWFgWOaUY7iQ53fW89BMeWqCP2iSmel2napXJ5rtItf606VJ3S280IvVnFtxsajHc8F9JQPf58rKFyunKMHI+4bzTvh+uN/814IGuzSAImUViL/5wspJ2vzdaMjQ7sNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740092103; c=relaxed/simple;
	bh=DktQpxtauAC5g+lipDBJYaL7npm7F09OzqG0cjR/2ng=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=a4p99ACRCHmoZzAPODfw02LoSYQQfKwE+WT0/yPR4ME6GXkdhKwxPtSnpg9dZ0Mp7HaN/nslzJupDGHv87nPaWmUUR8Xh+wmitDQV6YKg029zaISN9YHs5RtWNRAzt/cq+iMYJX2gxBTqt4CdU7RVeOX1TbXfP06SQFH1VerNFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=p8cRiakL; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:
	Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=oSKKJbUYqziujy0RHotnIyr9o5/uqZVZjvk3oBazYKc=; b=p8cRiakL6Gtp2ex5re1Nep60ng
	ZcekMOH8a6yqPllf61zcfcjMctyQZaOmIQJyR2f2dk2SM5P8gQpwKBR3AVthxcLbcG2wrf3DsdTnz
	4qBwZ8FTdFnY2tmvd0VHkqzEm1EWI6Hr69NzRA3ilLXSqQ4f/14qkuAXLrzAHfDyYSr+XCegIKuWJ
	qOY0R4EUwUinbuOQfSs5woXat9S36i9MnAanR5oWtfP3RBPt5x7RannGh/6ibXXb8YaTrf4nz1Kdh
	AebWqrETkL7EGxaC0JDyyl1zev29P/vkzlrrgsj0IuHJKer4V0ms0btAmjJacgdsnO1YEmvBhBi+A
	GMPf6/Hw==;
Received: from i53875bc0.versanet.de ([83.135.91.192] helo=localhost.localdomain)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1tlFRa-0003ww-Ld; Thu, 20 Feb 2025 23:54:58 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: mturquette@baylibre.com,
	sboyd@kernel.org
Cc: linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	liujianfeng1994@gmail.com,
	sebastian.reichel@collabora.com,
	cristian.ciocaltea@collabora.com,
	Heiko Stuebner <heiko@sntech.de>
Subject: [PATCH] clk: check for disabled clock-provider in of_clk_get_hw_from_clkspec
Date: Thu, 20 Feb 2025 23:54:48 +0100
Message-ID: <20250220225448.2763166-1-heiko@sntech.de>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

of_clk_get_hw_from_clkspec checks all available clock-providers by
compairing their of-nodes to the one from the clkspec. If no matching
clock-provider is found, the function returns EPROBE_DEFER to cause a
re-check at a later date.

If a matching clock-provider is found, a authoritative answer can be
retrieved from it whether the clock exists or not.

This does not take into account that the clock-provider may never appear,
because it's node is disabled. This can happen for example when a clock
is optional, provided by a separate block which just never gets enabled.

One example of this happening is the rk3588's VOP, which has optional
additional display-clock-supplies coming from PLLs inside the hdmiphy
blocks. These can be used for better rates, but the system will also
work without them.

The problem around that is described in the followups to:
https://lore.kernel.org/dri-devel/20250215-vop2-hdmi1-disp-modes-v1-3-81962a7151d6@collabora.com/

As we already know the of-node of the presumed clock-provider, just add
a check via of_device_is_available whether this is a "valid" device node.
This prevents ethernal defer-loops.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 drivers/clk/clk.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index cf7720b9172f..50faafbf5dda 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -5258,6 +5258,10 @@ of_clk_get_hw_from_clkspec(struct of_phandle_args *clkspec)
 	if (!clkspec)
 		return ERR_PTR(-EINVAL);
 
+	/* Check if node in clkspec is in disabled/fail state */
+	if (!of_device_is_available(clkspec->np))
+		return ERR_PTR(-ENOENT);
+
 	mutex_lock(&of_clk_mutex);
 	list_for_each_entry(provider, &of_clk_providers, link) {
 		if (provider->node == clkspec->np) {
-- 
2.47.2


