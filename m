Return-Path: <linux-kernel+bounces-543067-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41202A4D122
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 02:44:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B12023ACF8A
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 01:44:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 173C515383A;
	Tue,  4 Mar 2025 01:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="C/insOKg"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B978A13AA27
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 01:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741052668; cv=none; b=WFqvoTm0xle+xhAfNoeycXbKMQDpuEPOANvL9IiM5oh1imBtAcOrolIgCst0lqyacip5juleTyOw/FOMP8v7r2wrBxMreky81O7nbzLlxOntqWx9eD3T4OLHBvFTDSJu/WDkh10EH6bjncC/maEB5JibAK59s96p92nY6gv2vpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741052668; c=relaxed/simple;
	bh=SBKosOyQ+vqRRzYCaSZdG4Ns7DFVxhSrWT6ixWWkh/c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KOCHHoT7b/vRz2I/8h5cRPxnA1hw3FloMn+u88nqNirzJKE+W09J0gzcAhqzvi4ycsQPQNyGcrZsGjDwA2ubVAdfLp1345RQNEkKTFYabBDh310WUcpeXJz4NE0V54uBagmD8Ffe1uVEls7q+mKGHlOlwjXMZstXef7sbdGr/5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=C/insOKg; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1741052659;
	bh=SBKosOyQ+vqRRzYCaSZdG4Ns7DFVxhSrWT6ixWWkh/c=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=C/insOKgXcw6ARzrlNpuhz9Fm9s56VDre1JMRsUowSRkvTFqUJiI7XLv0/eQVGX1K
	 Xz1cW0Pn/AiugnEvp5T15VjRpP/eS4MpGsDWoEGoSQCo67xJBsbkiqqFwUza8hwD2p
	 LLCeQk/y9AA8d1PdEoqFHhVse34HXHejm/WJawNMvEWSoh+a6B/ehSgQGUSEGMGwxA
	 dSCI2L56Yc4xHTGGXqHoPb1lSA9SX+RdjhDpVy5tCe/05S6Zp1Ig/CcbU3iVmzxS5g
	 EOu//NGkvRMqeK71TGl50825S5+tTmakZXggSln/5t2mBTECrwxc4itn/Gf3oLxYIX
	 6nFjpseAMQsFA==
Received: from localhost (unknown [188.27.58.83])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with UTF8SMTPSA id E9D9817E0E8E;
	Tue,  4 Mar 2025 02:44:18 +0100 (CET)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Tue, 04 Mar 2025 03:44:01 +0200
Subject: [PATCH v4 02/12] phy: hdmi: Add color depth configuration
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250304-phy-sam-hdptx-bpc-v4-2-8657847c13f7@collabora.com>
References: <20250304-phy-sam-hdptx-bpc-v4-0-8657847c13f7@collabora.com>
In-Reply-To: <20250304-phy-sam-hdptx-bpc-v4-0-8657847c13f7@collabora.com>
To: Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Heiko Stuebner <heiko@sntech.de>
Cc: Algea Cao <algea.cao@rock-chips.com>, Sandor Yu <Sandor.yu@nxp.com>, 
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
2.48.1


