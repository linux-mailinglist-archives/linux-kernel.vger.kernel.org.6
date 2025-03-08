Return-Path: <linux-kernel+bounces-552462-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D1A2EA57A18
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 13:21:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5262F18951E9
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 12:22:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5D2A1C5F3F;
	Sat,  8 Mar 2025 12:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="S0m3Ti7N"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87C931ACECB
	for <linux-kernel@vger.kernel.org>; Sat,  8 Mar 2025 12:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741436496; cv=none; b=cUwlyKWZlfb+VESAonyup4wALcpYUxXrKbEXx04xTiA2OTTdJm8V927klErF6MuTaK8tZLiXK9IS9MZtxTJDDtdRSPdIExQOnDhpEhRYRqh6zk33qC87f66GYISfiVsBqcokDrlrmlEH9ubRF8QcUNygOwFM82tqd2CQ6TkDJWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741436496; c=relaxed/simple;
	bh=SBKosOyQ+vqRRzYCaSZdG4Ns7DFVxhSrWT6ixWWkh/c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ioCMm0Bpbxqcb8n3nzoWTNuErGnI/skwRNOUgM2SLPuIZIhOWAhSbjaYtlocjRn+NbpXOTpHEqs0xE857XHbDAzfzVmRGJRTp64wENRCkJ//Gu7LqMBrrAQuWL4VlS5dDo4Eq1YRltO92pKiRviqUvwxzSu4lWreQMy+Rh0gTSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=S0m3Ti7N; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1741436492;
	bh=SBKosOyQ+vqRRzYCaSZdG4Ns7DFVxhSrWT6ixWWkh/c=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=S0m3Ti7N3s2Q3Ksu9/Efav1IukjC2ValhAMQNP3Qw2LZbHQH4EFDGRZMX3h6hPz4g
	 9xzPspbBPAkPnFglOu64L5vdl7A0wFx6HTeoHN+sADBI4peWVZ6azPFBAqHezp7FI2
	 VN8+O30r96D2TMgT/we2WVBTPqIXe5F63iabXdDyei5fzzEGdWxSH7WPG8HijrH1+p
	 VphkWSHxn9h3tyBSYu+obcjgNtFLZyf/UJMUmqGEPzU4+ThMm9+JjBMljhouSae02Z
	 KLB9EkslL/e2Yb88VuKue0XYLMNbruvoDmDVWUTw8IYHQXDXknDD/SBLyPrWL117tC
	 FTcG7ujw5fPyw==
Received: from localhost (unknown [84.232.140.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with UTF8SMTPSA id 985CF17E0F75;
	Sat,  8 Mar 2025 13:21:32 +0100 (CET)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Sat, 08 Mar 2025 14:21:11 +0200
Subject: [PATCH v5 02/12] phy: hdmi: Add color depth configuration
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250308-phy-sam-hdptx-bpc-v5-2-35087287f9d1@collabora.com>
References: <20250308-phy-sam-hdptx-bpc-v5-0-35087287f9d1@collabora.com>
In-Reply-To: <20250308-phy-sam-hdptx-bpc-v5-0-35087287f9d1@collabora.com>
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


