Return-Path: <linux-kernel+bounces-521439-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44AA3A3BD66
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 12:49:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82A153B185B
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 11:47:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 879971DEFF7;
	Wed, 19 Feb 2025 11:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="fM/JeB2i"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBACD2862AB;
	Wed, 19 Feb 2025 11:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739965632; cv=none; b=Dd3XURPVe8wgrpKoeBmTrJHvoJCn83TjDjq/Q6usbixa57Qr3GDjWPpMem/dwvdKGHHEfivyndXdltJCA8XpZsdeDc8fH4nPjFt170jS1V+ZiT0smQxB7iTFZIa4tBkXdWdD4zh0DUyzo4bzXjPc4BoBVi+NtcOx1j9MAsqufLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739965632; c=relaxed/simple;
	bh=rg6JGBnwoyXj86f8SpVJXTpW47+6OxJFViPXzvv9jmI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Lp3gVgflR00HVvc4MKoe13IjyvzLuY9/14oEVUcHyfmVUwTHa/riDhL7F5IwCzdobTF6HLysVMONjBMHnygAIQEwUGZutIz/uLO+WAQi/T072sYUAo3/jXJDxDOMeBJ5H+8qsHd7ABxDYuGv0TOvwRzyEN1pylFHKPWe4lF0oCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=fM/JeB2i; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1739965628;
	bh=rg6JGBnwoyXj86f8SpVJXTpW47+6OxJFViPXzvv9jmI=;
	h=From:To:Cc:Subject:Date:From;
	b=fM/JeB2iogD97w6JKDoOUBC8fWHgQxvym/3+yMS8tVYNmzRxXgf3ew69yFp61Pi02
	 X4P+kFAV42toqtgLXBDW5tHHe9eJx/lpQVkkSasjoByjafe14qT2xeg+RGpu/amhGk
	 dPxnHAA0aNQe7MFV/YqiuCipmCeP5pxTzn05fKDbj0Woa58DayOR64JbZoFdiYb1gm
	 7GobKKkYXcAnNabim9Tf17vLgev3qcyfToNMRO/rT5GbUa1dKmVz3ZslgnrBCwen8H
	 AelxJDR7Chti9r+sRRdVUcQbC0HqJAdwTSv9ahhFA4oWWiXN2EcZhY9LewKzDpSA/B
	 sqy9KsGUl0GYw==
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 5A58617E0E92;
	Wed, 19 Feb 2025 12:47:07 +0100 (CET)
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
Subject: [PATCH v2] usb: typec: tcpci_rt1711h: Unmask alert interrupts to fix functionality
Date: Wed, 19 Feb 2025 12:47:00 +0100
Message-ID: <20250219114700.41700-1-angelogioacchino.delregno@collabora.com>
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

Changes in v2:
 - Moved interrupts enablement call to before enabling irq wakeup as
   enable_irq_wake() cannot fail, and if anything goes wrong, since the
   interrupt was previously requested with devm, no further action is
   needed. Thanks Greg!

 drivers/usb/typec/tcpm/tcpci_rt1711h.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/usb/typec/tcpm/tcpci_rt1711h.c b/drivers/usb/typec/tcpm/tcpci_rt1711h.c
index 64f6dd0dc660..88c50b984e8a 100644
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
@@ -382,6 +387,12 @@ static int rt1711h_probe(struct i2c_client *client)
 					dev_name(chip->dev), chip);
 	if (ret < 0)
 		return ret;
+
+	/* Enable alert interrupts */
+	ret = rt1711h_write16(chip, TCPC_ALERT_MASK, alert_mask);
+	if (ret < 0)
+		return ret;
+
 	enable_irq_wake(client->irq);
 
 	return 0;
-- 
2.48.1


