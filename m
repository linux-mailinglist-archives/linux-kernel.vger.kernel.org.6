Return-Path: <linux-kernel+bounces-510923-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 210C8A323A0
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 11:41:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 98EBF18872F1
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 10:41:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2A19208962;
	Wed, 12 Feb 2025 10:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="oKpzx+ua"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C94B1EE7B9;
	Wed, 12 Feb 2025 10:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739356856; cv=none; b=rNYRumSnGAZbwuPvCWsTGCP6QFChHFp8QPvrpeqgzab1ONmEeWtGKliNgHhxvhpo+JeCbq78g5lRjVkqWIHLWNDYgfTJW/tptYbZtdMS6n3bHzpIEnCqQRyqFJs+Vvw/4C9hWdd9L+xDCIyVpiLNfRPPezfVsgFHO3XwnpK1eyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739356856; c=relaxed/simple;
	bh=OnLNwlAhOzZBDtombGvT1kO0+N5VxyWb4bM79tyfeAU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hIzweoMYbx3FHn4lvGgF8KvrJTal9xIAUAhRXGfgRm2pKO3mpEi4A0nRC1P3X31HAjKXWClAMWs7+joY/Dt/NUal9QUSiTcH6Wj79mB3wZTF/IIMQInpAcegV5JCDDoL83z0/gWzKId1bTybg5BcNMVUcE3l+90DVeF5eIWgxs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=oKpzx+ua; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1739356852;
	bh=OnLNwlAhOzZBDtombGvT1kO0+N5VxyWb4bM79tyfeAU=;
	h=From:To:Cc:Subject:Date:From;
	b=oKpzx+uauilxWz4qkbCZu5puD+Kog7MdyGiBCX09ni8mKVlblWfmcXXbcHAsvHkNF
	 BYPS+ZZBpavAg62F5cr8U5kFeVZ06dEcQv+m4C6tzvmrd2hpND3A4RSfM/xjAYiz49
	 pTi3W0o87h7IFJPPwrIafBXAX3Ft4WF3zHZgyYuGXKZkoDnZxb4aEWfmUH0LZYVolq
	 /BXhTZuLQtgjZD8odUmPuIZA6uO4wQ4OFOjNibBckZ+UgfF5uS3vPdkRF//CFr2OKO
	 xiqQYlt1lYtcldjoPdpwA8vn1LCfbYevPJDEGSsgmc1KKY4zihQZ2eeDk7sTfD4ObC
	 u8VDSPn/rpwBg==
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id A3EC917E0ECF;
	Wed, 12 Feb 2025 11:40:51 +0100 (CET)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: heikki.krogerus@linux.intel.com
Cc: gregkh@linuxfoundation.org,
	andre.draszik@linaro.org,
	angelogioacchino.delregno@collabora.com,
	linux@roeck-us.net,
	shufan_lee@richtek.com,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel@collabora.com,
	pablo.sun@mediatek.com
Subject: [PATCH] usb: typec: tcpci_rt1711h: Unmask alert interrupts to fix functionality
Date: Wed, 12 Feb 2025 11:40:40 +0100
Message-ID: <20250212104040.38723-1-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

During probe, the TCPC alert interrupts are getting masked to
avoid unwanted interrupts during chip setup: this is ok to do
but there is no unmasking happening at any later time, which
means that the chip will not raise any interrupt, essentially
making it not functional as, while internally it does perform
all of the intended functions, it won't signal anything to the
outside.

Unmask the alert interrupts to fix functionality.

Fixes: ce08eaeb6388 ("staging: typec: rt1711h typec chip driver")
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/usb/typec/tcpm/tcpci_rt1711h.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/usb/typec/tcpm/tcpci_rt1711h.c b/drivers/usb/typec/tcpm/tcpci_rt1711h.c
index 64f6dd0dc660..c71b213b2441 100644
--- a/drivers/usb/typec/tcpm/tcpci_rt1711h.c
+++ b/drivers/usb/typec/tcpm/tcpci_rt1711h.c
@@ -334,6 +334,11 @@ static int rt1711h_probe(struct i2c_client *client)
 {
 	int ret;
 	struct rt1711h_chip *chip;
+	const u16 alert_mask = TCPC_ALERT_TX_SUCCESS | TCPC_ALERT_TX_DISCARDED |
+			       TCPC_ALERT_TX_FAILED | TCPC_ALERT_RX_HARD_RST |
+			       TCPC_ALERT_RX_STATUS | TCPC_ALERT_POWER_STATUS |
+			       TCPC_ALERT_CC_STATUS | TCPC_ALERT_RX_BUF_OVF |
+			       TCPC_ALERT_FAULT;
 
 	chip = devm_kzalloc(&client->dev, sizeof(*chip), GFP_KERNEL);
 	if (!chip)
@@ -384,6 +389,11 @@ static int rt1711h_probe(struct i2c_client *client)
 		return ret;
 	enable_irq_wake(client->irq);
 
+	/* Enable alert interrupts */
+	ret = rt1711h_write16(chip, TCPC_ALERT_MASK, alert_mask);
+	if (ret < 0)
+		return ret;
+
 	return 0;
 }
 
-- 
2.48.1


