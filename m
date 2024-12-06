Return-Path: <linux-kernel+bounces-435719-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D10269E7B5C
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 23:04:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 928F82825D8
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 22:04:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D667213E6E;
	Fri,  6 Dec 2024 22:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="qtbiXuiR"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB154204597
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 22:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733522642; cv=none; b=CGbNiAmS/n/AFwpXEEbencTHq6dd7HjlWAQ9VgVozky69kELwW79iG9PZXQndzovF+OIYRyKwpjDoNojsUy0lEjGBBOjLuyIXTfo1aPHxobFMiL6HCDNu0GQQDveM1YZHDB3UcEPhNuUr7TzXPMX34mCM44N8bumVnNRy0e67h4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733522642; c=relaxed/simple;
	bh=c+MpG+anKYTp08zkr7m18UAM/ICmNVHs0fwN4TQT7ug=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=N/IkDHCS4TuwNfYt1fK5URCRbwrvdjj1io0IUqT2gInhVuiDWTukTXbpyM9gQkpC2INg31VjAsjCNre6CLKwcqYvfgDhn2gLzrrm26B3pd7Il7zUbEv3SBVk1WGjMD8oFMz5BfRD66U+fgg2QTV7F3y7cHjABRmnh9u/GUKKyXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=qtbiXuiR; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1733522638;
	bh=c+MpG+anKYTp08zkr7m18UAM/ICmNVHs0fwN4TQT7ug=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=qtbiXuiRcHluHgvXACzF97zLJjyKeUFJnAgapyoHHXqs/tq3Fgm2PpdXm9TFH7Uq4
	 xLUgiAnlouRl1WhMGHLboXiLNYZ3tbIfS7I8veCOUJXOAwjFbjNvpO8aBbo7JamoOq
	 8phD4IKqkHU3HAXtqDAlGKphfsgzNWgRefvs2f+XyHGHtLwr7ys58CuOelpY2f16yl
	 6frBPeUiB1QFAZoFsj3w53ya7llEBDsuc+EW8A4tJ/w6bt+HsiimpYTd69fSJLsM9e
	 l4eg6U7ze7FsZ98gTu7vgpy6WSc5kF4mwg9ypjQ6h8TG9EvAsSd7pCuboU/Ym0IP83
	 wXagWU40IJhmw==
Received: from localhost (unknown [188.27.48.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 0C2ED17E3809;
	Fri,  6 Dec 2024 23:03:58 +0100 (CET)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Sat, 07 Dec 2024 00:03:42 +0200
Subject: [PATCH 2/4] phy: hdmi: Add color depth configuration
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241207-phy-sam-hdptx-bpc-v1-2-03c2e4d6d797@collabora.com>
References: <20241207-phy-sam-hdptx-bpc-v1-0-03c2e4d6d797@collabora.com>
In-Reply-To: <20241207-phy-sam-hdptx-bpc-v1-0-03c2e4d6d797@collabora.com>
To: Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Heiko Stuebner <heiko@sntech.de>
Cc: Sandor Yu <Sandor.yu@nxp.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
 Maxime Ripard <mripard@kernel.org>, kernel@collabora.com, 
 linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org
X-Mailer: b4 0.14.2

Extend the HDMI configuration options to allow managing bits per color
channel.  This is required by some PHY drivers such as
rockchip-samsung-hdptx.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 include/linux/phy/phy-hdmi.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/phy/phy-hdmi.h b/include/linux/phy/phy-hdmi.h
index 6a696922bc7f29af63d88646701b2c0fcee5c885..f0ec963c6e84f1b7728acafc824dff191c6b873d 100644
--- a/include/linux/phy/phy-hdmi.h
+++ b/include/linux/phy/phy-hdmi.h
@@ -9,11 +9,13 @@
 /**
  * struct phy_configure_opts_hdmi - HDMI configuration set
  * @tmds_char_rate: HDMI TMDS Character Rate in Hertz.
+ * @bpc: Bits per color channel.
  *
  * This structure is used to represent the configuration state of a HDMI phy.
  */
 struct phy_configure_opts_hdmi {
 	unsigned long long tmds_char_rate;
+	unsigned int bpc;
 };
 
 #endif /* __PHY_HDMI_H_ */

-- 
2.47.0


