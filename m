Return-Path: <linux-kernel+bounces-569996-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6319EA6AA8F
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 17:05:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D1E2D189EDCA
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 16:03:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEA46227EB1;
	Thu, 20 Mar 2025 16:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="a2GD44Yj"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DE74227E90
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 16:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742486454; cv=none; b=t540OpL647TLJuKiFl3Y/0Iv/UHRaSRrhAF13KOKy7kUbkcBKg87LBY+3VVNVgSZ3pUnMQiTniIlJKlzZhEN/XCjSTyKiBgnn9my6HMEahYTnxFrnsaS5ZXoaGC7VJsrqeEsr1UwBV/luYxSNUFgJyn6QVXaUlhb8TeTO3f0gys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742486454; c=relaxed/simple;
	bh=PM3qn/s33KHnLl3YvY8GLYvLdFsywv9G587wE6W8Bwk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VN0QGEUA7hqKWn3fpR6YHPwwHQ/y51wfhkbknPsQ9+SQGOPf92zP0ufQAZmDN0Iz/x15stlb7mqmJ6WXRFt2VFbSf6XiruMh2Xq7tIpfMR/DYvtH9k9jqQnr3G2AKEyH6NSWIgkQvWTOiSEhKAfllJ+Rye7t361+LDgnGI20RlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=a2GD44Yj; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from [127.0.1.1] (91-158-153-178.elisa-laajakaista.fi [91.158.153.178])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 6F923187B;
	Thu, 20 Mar 2025 16:58:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1742486337;
	bh=PM3qn/s33KHnLl3YvY8GLYvLdFsywv9G587wE6W8Bwk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=a2GD44YjfgYan56h/9MmD7/HfbWCIT+rsU0mi4dXgLdgncWmONx1Fqr/aE+gOca/1
	 Sx3RaQfs+Us/MPZo3Gb57tNaFJ82EywRdwJCzW6hxRlIcUkDzdj7sObkgYaUaWq+99
	 BpRB0AkUMpsFnQJDoak80OGloewv+Eyfkhmn2ABg=
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Date: Thu, 20 Mar 2025 18:00:04 +0200
Subject: [PATCH 09/18] drm/bridge: cdns-dsi: Fix REG_WAKEUP_TIME value
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250320-cdns-dsi-impro-v1-9-725277c5f43b@ideasonboard.com>
References: <20250320-cdns-dsi-impro-v1-0-725277c5f43b@ideasonboard.com>
In-Reply-To: <20250320-cdns-dsi-impro-v1-0-725277c5f43b@ideasonboard.com>
To: Jyri Sarha <jyri.sarha@iki.fi>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-phy@lists.infradead.org, Francesco Dolcini <francesco@dolcini.it>, 
 Aradhya Bhatia <aradhya.bhatia@linux.dev>, 
 Devarsh Thakkar <devarsht@ti.com>, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
X-Mailer: b4 0.15-dev-c25d1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1914;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=PM3qn/s33KHnLl3YvY8GLYvLdFsywv9G587wE6W8Bwk=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBn3DuZloA+exiVEum1Q6IiqSYRfYHq0oMCRsYYe
 0Ewlqz9wMSJAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCZ9w7mQAKCRD6PaqMvJYe
 9aG3EACZaRefFebSDtsTRi5sPJx//iUij0iLw0822RCYY/BLgg2ClMcNAcgZN/d8e7ezSqsXqcM
 iptPCOsHKggzQGtZ9ZnRZeng3Ie+rmb/BsqpKBiOuwWtsOGJfrt6GWoE93nm8ZkPqyyKSCdDqIk
 jTHniVzGMwrKEd2gTkox26qG1MECgmpeO8XFhSXft4B2BGu+/ZQrP7aC9cFZ/0RhAhxn6wVstFY
 BDDGGIDKIMd6tdIBD5z1xG1LzbeCuSprHUNMdKhQ2TCTXFG7lB83uLO493ZIrVNryYwgEqk3Fj/
 x2pFS2vFeVCf1aHMcGWb56QsTiWMEWC+5OsrL8E3kIxS5WO71VTk68Hc7NuIDBqWv4z6OQxx598
 TSOSDvwrQ6rGD8M2W0XDi8W4SVcKAIJK9V+hSDJjrpRLtishgFS0GLui5DDhaJEDXCqua04zJv2
 2I1tD58/5OrRydynC+7jdAAB1BD5OocNpBNGFcKtEBqsNWfovxNRA6dFSAVS218C3NiFVNk5SEY
 58Wxd/rGARUmVTnHCTFNWK+MDf9FXGzBnX6yS23JNyJCgtkcK7qfyN8+85zwH0+7R3yJlGP+5D9
 PoMI9auXgGutPJymhWGUsHxI+tT+/0ufJqKkfkZAyOA5q5viCH2k1ZIUFUORtmnlWuMfzg50/Ps
 jawDxvJJpfUYppw==
X-Developer-Key: i=tomi.valkeinen@ideasonboard.com; a=openpgp;
 fpr=C4380C3E965EFD81079FF3A7FA3DAA8CBC961EF5

The driver tries to calculate the value for REG_WAKEUP_TIME. However,
the calculation itself is not correct, and to add on it, the resulting
value is almost always larger than the field's size, so the actual
result is more or less random.

According to the docs, figuring out the value for REG_WAKEUP_TIME
requires HW characterization and there's no way to have a generic
algorithm to come up with the value. That doesn't help at all...

However, we know that the value must be smaller than the line time, and,
at least in my understanding, the proper value for it is quite small.
Testing shows that setting it to 1/10 of the line time seems to work
well. All video modes from my HDMI monitor work with this algorithm.

Hopefully we'll get more information on how to calculate the value, and
we can then update this.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
---
 drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c b/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c
index 0aaa1d06b21c..62811631341b 100644
--- a/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c
+++ b/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c
@@ -882,7 +882,13 @@ static void cdns_dsi_bridge_atomic_pre_enable(struct drm_bridge *bridge,
 
 	tx_byte_period = DIV_ROUND_DOWN_ULL((u64)NSEC_PER_SEC * 8,
 					    phy_cfg->hs_clk_rate);
-	reg_wakeup = (phy_cfg->hs_prepare + phy_cfg->hs_zero) / tx_byte_period;
+
+	/*
+	 * Estimated time [in clock cycles] to perform LP->HS on D-PHY.
+	 * It is not clear how to calculate this, so for now,
+	 * set it to 1/10 of the total number of clocks in a line.
+	 */
+	reg_wakeup = dsi_cfg.htotal / nlanes / 10;
 	writel(REG_WAKEUP_TIME(reg_wakeup) | REG_LINE_DURATION(tmp),
 	       dsi->regs + VID_DPHY_TIME);
 

-- 
2.43.0


