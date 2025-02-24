Return-Path: <linux-kernel+bounces-529067-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A5643A41F91
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 13:50:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 251E03B2F33
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 12:40:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E29823BCE0;
	Mon, 24 Feb 2025 12:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="n0TKdl88"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D7801DDE9
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 12:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740400846; cv=none; b=LiaoYXNmDC2HnmnF+4MPS8ENnxoh8xo11clKBstM5JemUgPmW1Azy3HQSssmlpHA5VByvjAjjSm6E8euFuh3kodIUBojmb/YIC8Dmk5uXFXzEdXcbZD3mB05i9Jl8SOSOQL5fcYeUIqth6mP9+FoS2F4m006UAnSwSGLIYo7psk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740400846; c=relaxed/simple;
	bh=W6turjkF5UgWj4NumzTU+qn8HpLaCyt0loPxOO4rxQ4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=upKcP/Y+B+h6hI+ehXzd6xN6InEri84CoOgwsRcVhIKIBWsC7UUZh96DBS++Ou0VAWie0TEDkaqu+1Vnu4Gyzc3NZB9RAt3baM3N9cU9wrflW+WwMOIdmoU7rfrEvkKzM9b2ZTPdLF15hJs7MMWB+m0uPim0tAVHdyfSHSVfdOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=n0TKdl88; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from mail.ideasonboard.com (unknown [223.190.81.199])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 61F99220;
	Mon, 24 Feb 2025 13:39:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1740400756;
	bh=W6turjkF5UgWj4NumzTU+qn8HpLaCyt0loPxOO4rxQ4=;
	h=From:Date:Subject:To:Cc:From;
	b=n0TKdl88755ynz/laGzH3bMTzpQ89L/roRoyLaMRSxDGKoMghXxhcxA2O6iO6zyge
	 BTgdBdfJ3iGG0gZYM/KS4Svjho6WdmE6aYcsuBz1k+rxTRFZG7eEDd/QVgH9icVeyo
	 XmYzocFedfx/W80Q4fVZgNg9MDTbLJ58sd1Vyt6c=
From: Jai Luthra <jai.luthra@ideasonboard.com>
Date: Mon, 24 Feb 2025 18:10:05 +0530
Subject: [PATCH] phy: cadence: cdns-dphy-rx: Add runtime PM support
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250224-cdns_phy_pm-v1-1-0fe2c544cc87@ideasonboard.com>
X-B4-Tracking: v=1; b=H4sIAKRovGcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDIyMT3eSUvOL4gozK+IJc3SSjJPMUE3MjC2PTFCWgjoKi1LTMCrBp0bG
 1tQBE2u2zXQAAAA==
X-Change-ID: 20250224-cdns_phy_pm-b2b7d472835d
To: Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>
Cc: linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Devarsh Thakkar <devarsht@ti.com>, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, 
 Jai Luthra <jai.luthra@ideasonboard.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1208;
 i=jai.luthra@ideasonboard.com; h=from:subject:message-id;
 bh=W6turjkF5UgWj4NumzTU+qn8HpLaCyt0loPxOO4rxQ4=;
 b=owEBbQKS/ZANAwAIAUPekfkkmnFFAcsmYgBnvGi7z0kT3JUdhqyomX83zFcbIpSWh7NC3C9eK
 kx4WVY9RN+JAjMEAAEIAB0WIQRN4NgY5dV16NRar8VD3pH5JJpxRQUCZ7xouwAKCRBD3pH5JJpx
 RdTwD/9m+sldr3u0wwJEVQJysKRRj3/bo6eQYmkgkY3tXeiL+6nGUMAP3+3WzpsJ/E8lwVp32Gi
 YtTpKTs5ysTMn0NqtR2BZOd8tCl9BDkkNx/pnFF3kz2S0ZqAJu+0gRwb3T+7Tu8hZ2dsKEFGB9p
 vnhCOjDERnHX5T6ZeJlCeQdyjP9Lj+aS50p5wiXxhQgqVDjo5/s/3QZKU1QgLkGLL5BpfpkgBTt
 bK7rGJrnPYUWReHfDSVu4UPxo/+xL9R4poinWspatuoByjoCayc1G5mKFCM+mlcigqj3QZm4RqK
 MLSp4U0SZQq4i+3wfPCWRnTuDdRw09gJsKFAPs0NCw6LFaA9gciaRZzk9CkeIhTWl50loyi48i8
 qd78OY+i7Az90D/npTUjac6LDl9hPi5AML/tvoB3G2imHBA4cjMQjWOFXG5lsVeWikRyIsEBXPC
 l2jPFavL1KW4DVHSR4d5pHgWJ1TgmO0y7/WIJO4lScUxAbMthdGwTxaPAN04bCGfcYQtksQNgd3
 TU4e2guVRhy5YEGaUAt9HsozBTw0KNDXbhxyUo67Oh4Zd0fBFxa6aCWHRtP/pbZpRidjgWMpf8O
 Xhe4lA52qHJFjbnJTGYphDCMpSLdqqdWsxxQz6mop9WmQONFtm+LCXwDqMQLvDyMB0uheqiHWk/
 hSLSTbnq8QWPKjg==
X-Developer-Key: i=jai.luthra@ideasonboard.com; a=openpgp;
 fpr=4DE0D818E5D575E8D45AAFC543DE91F9249A7145

Enable runtime power management for the device. The PHY framework
handles calling pm_runtime_(get|put)_sync when powering on/off this
device.

Signed-off-by: Jai Luthra <jai.luthra@ideasonboard.com>
---
 drivers/phy/cadence/cdns-dphy-rx.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/phy/cadence/cdns-dphy-rx.c b/drivers/phy/cadence/cdns-dphy-rx.c
index 7729cf80a9bd892c3e5db6cdbdc4ece9ada2d99f..3ac80141189c4c8c350b678998e5dec7a15c3892 100644
--- a/drivers/phy/cadence/cdns-dphy-rx.c
+++ b/drivers/phy/cadence/cdns-dphy-rx.c
@@ -12,6 +12,7 @@
 #include <linux/phy/phy.h>
 #include <linux/phy/phy-mipi-dphy.h>
 #include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
 #include <linux/sys_soc.h>
 
 #define DPHY_PMA_CMN(reg)		(reg)
@@ -265,7 +266,7 @@ static int cdns_dphy_rx_probe(struct platform_device *pdev)
 		return PTR_ERR(provider);
 	}
 
-	return 0;
+	return devm_pm_runtime_enable(dev);
 }
 
 static const struct of_device_id cdns_dphy_rx_of_match[] = {

---
base-commit: d082ecbc71e9e0bf49883ee4afd435a77a5101b6
change-id: 20250224-cdns_phy_pm-b2b7d472835d

Best regards,
-- 
Jai Luthra <jai.luthra@ideasonboard.com>


