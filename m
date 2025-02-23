Return-Path: <linux-kernel+bounces-527687-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CADDA40E31
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 12:02:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2DFD01712B3
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 11:02:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66EA4205ACB;
	Sun, 23 Feb 2025 11:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="ISlAPxRv"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 140BF1632DD
	for <linux-kernel@vger.kernel.org>; Sun, 23 Feb 2025 11:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740308550; cv=none; b=ctHAWeTcanizdHHNvxwOP/FvWyP2CYWggfP6sx/UD1LJSWSkOmxX9Riktl0+xBv4O9nD3BoZ92p9xdUjMToEvoZV0HtxbYP2/40FfzY8CKSMxCoiMBgCrka9aDJVF3egDg9uWvHrd6tiUKYHM6Wjy0mYeDUcy7OSBOL9CUNpLnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740308550; c=relaxed/simple;
	bh=SBKosOyQ+vqRRzYCaSZdG4Ns7DFVxhSrWT6ixWWkh/c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RaOAlgAaFuqFly8RgLWtgoG3Qof06z+2ZKR/0PByLg7QRcLCrKJ+Q2nzBbyCQj0913/VoSQj6YE/Lk3knty5YmZjBIqXZoHRQ1JfTX1qByC10x0qPvGpnKJuUW8KYfXAZnkVDPa8M5m/Qa2pIsMZM3sz41eh9aWlg8bvTcg1SK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=ISlAPxRv; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1740308547;
	bh=SBKosOyQ+vqRRzYCaSZdG4Ns7DFVxhSrWT6ixWWkh/c=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ISlAPxRv07onHGgebl2EGfsQBH3cstDSaDszxZJiEnK4y4n0tXJLTF0IYmpNXuWQ7
	 7jukyMYv5gHmbeI5964NbEaExSpO0G+VTpSgiYRJ/KBxUh0kmY7J+9j+pnuAGtflWB
	 2wGQpK07afiOK1M9lxbdQqrGkojMSJhkbiZUNPCQ/8EtXWJG6+9l4dnerot1/GW0Gh
	 DyZKaJQkzPdZcojkGAKI6yKC1c3GRR8D/gbKylwtx+S5jYSDpAUbMsnTsHoXLZ4vvq
	 XZFLYg3xgL0YCgkq7t9M6S9GGMv27r0j8XRwAJq2ktzd/OK52rAYrjda1Bsnolkx0z
	 4+UTQP3L0eW0g==
Received: from localhost (unknown [188.27.58.83])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with UTF8SMTPSA id 364F217E0CFA;
	Sun, 23 Feb 2025 12:02:27 +0100 (CET)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Sun, 23 Feb 2025 13:02:09 +0200
Subject: [PATCH v3 2/8] phy: hdmi: Add color depth configuration
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250223-phy-sam-hdptx-bpc-v3-2-66a5c8e68327@collabora.com>
References: <20250223-phy-sam-hdptx-bpc-v3-0-66a5c8e68327@collabora.com>
In-Reply-To: <20250223-phy-sam-hdptx-bpc-v3-0-66a5c8e68327@collabora.com>
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


