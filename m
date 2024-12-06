Return-Path: <linux-kernel+bounces-434891-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 217D29E6C5B
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 11:35:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61C5A1884C0A
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 10:34:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B9B91FC10D;
	Fri,  6 Dec 2024 10:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="vhB6ht+5"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 289D51F9EA5
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 10:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733481282; cv=none; b=BC+KR+J+EQ3lXsr8WR49oZ95H+1CHwwxPTeZRFXhOjA5XR0dagDHMHUioCU76SgbswmJeFHchiJHoTPM2OVbHmcNqmhL7PaZzuNAlmG28URnFt3VLr3XjSK3kXO5PsF9hVy5/uzNO5GKCi/fNM3fieC0wlqj0ChAWpfZIsPpK+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733481282; c=relaxed/simple;
	bh=2YK5YwhO1j+aqd8HeSyhgTSUwWsDYjIpp4AWZgZMlx4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S8a1zFch0bAGE7qfoRQF/j5QdTUoaRvbkVFkwjiDNkQtYM2X4mKK9TrLWI2gGElH2vNH5z4fRvICPCcN1VH3xvvkCdCVMIrM5U3bIwp0tUwWtJ9VKMVxNk6UH6i2TRV/oOuD8nEGxvUWQhRO1pISAilLXQNtn0mN0god8vnwKVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=vhB6ht+5; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=SO3Xh29xRkdmQmLn6fa6N/djXaj2dmx9KQNMok66AoA=; b=vhB6ht+507ZVQSUB/53u6YxVEU
	kkBQESnINzaHc1MK6vkAs0aYmwVtf6XKW8ezYAx8gR6xYpsigr9GLQEwjKX6aRBOyabg4wRVEnmbX
	ziVvluAie5euLgQmRYlvSAbtuFx/Iq8dVaQG+nS1Hd6wUzPQakaV3Xi5gEZLrIs21SHuWZ1KmTChV
	DzzwqQ2Hr+wU8UhIRB7Y4ZVrxEZe5ADNKv6po5N85a4R5MfwBbeBeK6DlMtN1Mn46LGSyyUF1xF8b
	1fSWBlXHad+EZ0mdZujv/FFcCX3KMwsuMK/5dNF0eyXje0nTX6HRzFtoIZ/iP0zCtwb3MvX6Ffwib
	R3oVHnwA==;
Received: from i53875bc4.versanet.de ([83.135.91.196] helo=localhost.localdomain)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1tJVfI-0007XU-0C; Fri, 06 Dec 2024 11:34:28 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: vkoul@kernel.org,
	kishon@kernel.org
Cc: heiko@sntech.de,
	cristian.ciocaltea@collabora.com,
	linux-phy@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	quentin.schulz@cherry.de,
	Heiko Stuebner <heiko.stuebner@cherry.de>
Subject: [PATCH 1/2] phy: phy-rockchip-samsung-hdptx: annotate regmap register-callback
Date: Fri,  6 Dec 2024 11:34:00 +0100
Message-ID: <20241206103401.1780416-2-heiko@sntech.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241206103401.1780416-1-heiko@sntech.de>
References: <20241206103401.1780416-1-heiko@sntech.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Heiko Stuebner <heiko.stuebner@cherry.de>

The variant of the driver in the vendor-tree contained those handy
comments in the regmap register callback. Having the different ranges
describe what they are looks helpful.

Signed-off-by: Heiko Stuebner <heiko.stuebner@cherry.de>
---
 drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c b/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c
index 4ced1479e2dc..c5c64c209e96 100644
--- a/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c
+++ b/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c
@@ -766,13 +766,13 @@ static struct tx_drv_ctrl tx_drv_ctrl_hbr2[4][4] = {
 static bool rk_hdptx_phy_is_rw_reg(struct device *dev, unsigned int reg)
 {
 	switch (reg) {
-	case 0x0000 ... 0x029c:
-	case 0x0400 ... 0x04a4:
-	case 0x0800 ... 0x08a4:
-	case 0x0c00 ... 0x0cb4:
-	case 0x1000 ... 0x10b4:
-	case 0x1400 ... 0x14b4:
-	case 0x1800 ... 0x18b4:
+	case 0x0000 ... 0x029c: /* CMN Register */
+	case 0x0400 ... 0x04a4: /* Sideband Register */
+	case 0x0800 ... 0x08a4: /* Lane Top Register */
+	case 0x0c00 ... 0x0cb4: /* Lane 0 Register */
+	case 0x1000 ... 0x10b4: /* Lane 1 Register */
+	case 0x1400 ... 0x14b4: /* Lane 2 Register */
+	case 0x1800 ... 0x18b4: /* Lane 3 Register */
 		return true;
 	}
 
-- 
2.45.2


