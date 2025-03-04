Return-Path: <linux-kernel+bounces-544170-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA197A4DE34
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 13:45:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 127491683D1
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 12:45:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 793B6202C4E;
	Tue,  4 Mar 2025 12:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="alw6DETQ"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74B2A202F70
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 12:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741092289; cv=none; b=lUKwL7E/CMcV80zkAMh9TrfwLmBaVIpGIRrnYa8SAHOrZd3e2uThrP0c9UgkevD7HaMCYMA8OikMD25w2oXgcHvsUjM0D0+3KMr46zHo9LXKA/1Mz/d+67Q0MJIiEn6b5OjndR2YQZbXlURGB0TD8wLZhx/I1aw1mGwE2hUZdAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741092289; c=relaxed/simple;
	bh=p52caFVCC/RT99Rzjhd4LQTnNLGIz2zKYYi5cQiWnjc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cPre/VOJ8pL/ymBEY0EWEOC+iMuiPWk2ttQSd320Xt/3yNJm56t2MAUE6PFxyHP5z0tXoUMYPJuJznUuA6dop3LSZRY9ldl1X/MWuispUqorwJ2FA4sZyahbCt3QFKjd2OBV3xZt09TKzA/g+wkGDrEnkjWNVuUCmdVqiPWLZqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=alw6DETQ; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Pu83Mb40jejkNbJKC2LIx4LiblmoRe/j7LFnThEkjwI=; b=alw6DETQckRTX6x5yzyqCZGAtw
	xutdjeey1EdrIAPe7clsn6m3TkcERsyoV34D7JZPUXNyjH1MQnbLdMBvIHpUpQhstvKYa+DA/Ak8B
	UR426//s+1PaxuglwwVtNKIjGdqmPaECqhzW0EqAaTPrKLlaO2vy3LYVf3CWl7NddNQgpEnvyfhY1
	r90kNSu54aPsaJZKtJ7/zVIk4g/1crhNaNh4fNkzoh33FB4+AbXxGVSNswi/6zHZzGzB1kllq+EhE
	jCsKHhVvVlAq7yadddewH7twf3gdM80aV6jNv2vKSFy8bK4KBIB/aIloNYqgV2L6Uf5Ez+RMKcoap
	q09asTsg==;
Received: from i53875a38.versanet.de ([83.135.90.56] helo=phil..)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1tpRdS-0003B0-MR; Tue, 04 Mar 2025 13:44:34 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: heiko@sntech.de
Cc: andy.yan@rock-chips.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	dri-devel@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	quentin.schulz@cherry.de,
	Heiko Stuebner <heiko.stuebner@cherry.de>
Subject: [PATCH v3 3/3] drm/rockchip: lvds: lower log severity for missing pinctrl settings
Date: Tue,  4 Mar 2025 13:44:18 +0100
Message-ID: <20250304124418.111061-4-heiko@sntech.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250304124418.111061-1-heiko@sntech.de>
References: <20250304124418.111061-1-heiko@sntech.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Heiko Stuebner <heiko.stuebner@cherry.de>

While missing lvds pinctrl is unexpected and is reported, we nevertheless
don't fail setting up the device and instead continue without explicit
pinctrl handling. So lower the log-level from error to warning to reflect
that.

Signed-off-by: Heiko Stuebner <heiko.stuebner@cherry.de>
---
 drivers/gpu/drm/rockchip/rockchip_lvds.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_lvds.c b/drivers/gpu/drm/rockchip/rockchip_lvds.c
index bfebe42a0331..a673779de3d2 100644
--- a/drivers/gpu/drm/rockchip/rockchip_lvds.c
+++ b/drivers/gpu/drm/rockchip/rockchip_lvds.c
@@ -464,14 +464,14 @@ static int rk3288_lvds_probe(struct platform_device *pdev,
 
 	lvds->pins->p = devm_pinctrl_get(lvds->dev);
 	if (IS_ERR(lvds->pins->p)) {
-		dev_err(lvds->dev, "no pinctrl handle\n");
+		dev_warn(lvds->dev, "no pinctrl handle\n");
 		devm_kfree(lvds->dev, lvds->pins);
 		lvds->pins = NULL;
 	} else {
 		lvds->pins->default_state =
 			pinctrl_lookup_state(lvds->pins->p, "lcdc");
 		if (IS_ERR(lvds->pins->default_state)) {
-			dev_err(lvds->dev, "no default pinctrl state\n");
+			dev_warn(lvds->dev, "no default pinctrl state\n");
 			devm_kfree(lvds->dev, lvds->pins);
 			lvds->pins = NULL;
 		}
-- 
2.47.2


