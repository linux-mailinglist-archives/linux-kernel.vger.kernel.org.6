Return-Path: <linux-kernel+bounces-527499-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BC214A40BE4
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 23:38:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AA7707AC2BD
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 22:37:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E854204590;
	Sat, 22 Feb 2025 22:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="2FVqp01P"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 649912AF04;
	Sat, 22 Feb 2025 22:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740263873; cv=none; b=nxq+ZcW2h2f9/jFjfU9WdS0i1ye0a3gzTuwoqhSe6GjJh6sWcRF/CXeqVp47D3Duo8oE3rQIYeOsnfwn+ORRoRhaq2peJ76/YS9ZTZmo9R8BFCagone8ZWD0BR7A/CEJnaoyAoYoG9rSixSMtKuDngIiXY+UHbANoq0IjSBG3U0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740263873; c=relaxed/simple;
	bh=0LcO31T+f5RdJjXLyY8cCqbfbF00bXtgTsBHBhv45A8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rUtf0fqIuDhJzvDFoNSu6urQpcv7aHM6asbiuQJNcABPW7OjYmeCQIcKL/WVgAMClOenUL3qyksVBX3TRjdYg/fWRqgmyC0O+zLlmB4L9eWKtjcdzyBviwxBcSgRJXWT5lzQCbyXg1tCK38ObEfngkkUHIwU5aFM2kCiNjXsEbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=2FVqp01P; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:
	Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=OnNwP7mpVN7zXhPE9vJ/xWGv1zj1DccbezxtZx8sRBU=; b=2FVqp01PBKuoNTsqpzT9a0qVJV
	G3QUGO/WP9lVGZkYEizeFgE8Y1QtXmFVmRQ6U7ui+ordMWasogTovwY0sJG/pUczGPi4Wskv9GEKj
	t3FAig77PYjR7F7E8v/bKCn4kH8C86YC7mneIaTgI2zjstgWPCLePtrr9+EEWSicrra3sZdD/I9Xl
	nlZklOPzophBA0MFiPGEOBv/UaQAaI/DXxZgKv56ocJ1F0nAIEOSR/Ayd4VcF2RVrFmPq0Ol9Px9A
	0OyTybdHcUQFtDdRxYGVVtto9zF9+fDn1P7fMqpaYoY+Vf038317rM4zmkKpdu19ZzrjlC9FKPiOB
	Ib4ZXsfg==;
Received: from i53875a10.versanet.de ([83.135.90.16] helo=phil.fritz.box)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1tly7x-00048S-Dp; Sat, 22 Feb 2025 23:37:41 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: mturquette@baylibre.com,
	sboyd@kernel.org
Cc: linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	liujianfeng1994@gmail.com,
	sebastian.reichel@collabora.com,
	cristian.ciocaltea@collabora.com,
	heiko@sntech.de
Subject: [PATCH v2] clk: check for disabled clock-provider in of_clk_get_hw_from_clkspec
Date: Sat, 22 Feb 2025 23:37:33 +0100
Message-ID: <20250222223733.2990179-1-heiko@sntech.de>
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

If a matching clock-provider is found, an authoritative answer can be
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
This prevents eternal defer-loops.

Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Tested-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
changes in v2:
- add received Reviewed and Tested tags
- fix two spelling issues (Cristian and Sebastian)

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


