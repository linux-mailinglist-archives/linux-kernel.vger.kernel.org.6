Return-Path: <linux-kernel+bounces-440050-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AC109EB7F1
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 18:16:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECF2B283EC8
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 17:16:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5236A244A54;
	Tue, 10 Dec 2024 17:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="YqVBcQyo"
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69641230267;
	Tue, 10 Dec 2024 17:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733850826; cv=none; b=YeXIajJ7qhnREyuX2W5QhRErxixih76BJreVSg6Ona+It4YD00K1zH+sZ6W1ro1hXRlE1dQqcAmlHV2sNTv9KiauuofXr5/TmQNT7pYJJn3ZuDfQqPL7NT6MaMCAlSK3G3t7AaUsAMISgQdl6qtP0dm9JvGOAM7b/6H4Sf8IOrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733850826; c=relaxed/simple;
	bh=yXVDYOaFNfqyTkNQE0fHYz5+EtCSfCYIRXZ7RoLTbas=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=d4kWJ1pp4bcAJBzil2EKj0NzIDmWs0BfIEzJihzRQe5ZAKV/yaAYMD4do/DnXjanbMTVTMxhqbW6kN9r89R5bJbY/0OBGoHEvpjg9MnERaIBbs4onOK/+H/yzZ6icGGhp99vNZGoNt1qLFKj3+WhjEyfxcUq5XUj9XTB8JUlz74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=YqVBcQyo; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 429B72000C;
	Tue, 10 Dec 2024 17:13:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1733850817;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SXXuJ7wjA+iPshQUOOp+J39ONzwVePGwpts3g/T0ovA=;
	b=YqVBcQyoYn7xBCN0Cy6z0YgVsDD5jX0PT/xOUz/vhOwpe25Zxt9LKLlTneWzidOsOOo/j5
	Gj102J+1nrVaUo/bvL4AMoDEVEBmzota6FVlnLvlCPktpUoNk9+k3HhSuZNVqZfzsLehS/
	5jlVEkvOTxNdhRv+BXnmvDBCjKHLJ5iNQUSxbxc7nrIXuhAq1K0f65E22JZ5TBLCg4m6zK
	0Pwzs3qBDyVxNJ0GMok63n++Ue7CwK4DfY460DU0LumcGEuEaIedMeE5GiYZHYSZDeb+88
	m2V92uMa3MXeAbQNbAudMQmH3II9/leCsG4H7Y3OmrhNsKVWkwqqUszvVsZt8g==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Tue, 10 Dec 2024 18:13:36 +0100
Subject: [PATCH v6 2/5] usb: cdns3-ti: run HW init at resume() if HW was
 reset
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241210-s2r-cdns-v6-2-28a17f9715a2@bootlin.com>
References: <20241210-s2r-cdns-v6-0-28a17f9715a2@bootlin.com>
In-Reply-To: <20241210-s2r-cdns-v6-0-28a17f9715a2@bootlin.com>
To: Peter Chen <peter.chen@kernel.org>, Pawel Laszczak <pawell@cadence.com>, 
 Roger Quadros <rogerq@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Mathias Nyman <mathias.nyman@intel.com>
Cc: =?utf-8?q?Gr=C3=A9gory_Clement?= <gregory.clement@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, linux-usb@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
X-Mailer: b4 0.14.2
X-GND-Sasl: theo.lebrun@bootlin.com

At runtime_resume(), read the W1 (Wrapper Register 1) register to detect
if an hardware reset occurred. If it did, run the hardware init sequence.

This callback will be called at system-wide resume. Previously, if a
reset occurred during suspend, we would crash. The wrapper config had
not been written, leading to invalid register accesses inside cdns3.

Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
 drivers/usb/cdns3/cdns3-ti.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/usb/cdns3/cdns3-ti.c b/drivers/usb/cdns3/cdns3-ti.c
index d704eb39820ad08a8774be7f00aa473c3ff267c0..d35be7db7616ef5e5bed7dbd53b78a094809f7cc 100644
--- a/drivers/usb/cdns3/cdns3-ti.c
+++ b/drivers/usb/cdns3/cdns3-ti.c
@@ -188,6 +188,12 @@ static int cdns_ti_probe(struct platform_device *pdev)
 	data->vbus_divider = device_property_read_bool(dev, "ti,vbus-divider");
 	data->usb2_only = device_property_read_bool(dev, "ti,usb2-only");
 
+	/*
+	 * The call below to pm_runtime_get_sync() MIGHT reset hardware, if it
+	 * detects it as uninitialised. We want to enforce a reset at probe,
+	 * and so do it manually here. This means the first runtime_resume()
+	 * will be a no-op.
+	 */
 	cdns_ti_reset_and_init_hw(data);
 
 	pm_runtime_enable(dev);
@@ -232,6 +238,24 @@ static void cdns_ti_remove(struct platform_device *pdev)
 	platform_set_drvdata(pdev, NULL);
 }
 
+static int cdns_ti_runtime_resume(struct device *dev)
+{
+	const u32 mask = USBSS_W1_PWRUP_RST | USBSS_W1_MODESTRAP_SEL;
+	struct cdns_ti *data = dev_get_drvdata(dev);
+	u32 w1;
+
+	w1 = cdns_ti_readl(data, USBSS_W1);
+	if ((w1 & mask) != mask)
+		cdns_ti_reset_and_init_hw(data);
+
+	return 0;
+}
+
+static const struct dev_pm_ops cdns_ti_pm_ops = {
+	RUNTIME_PM_OPS(NULL, cdns_ti_runtime_resume, NULL)
+	SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend, pm_runtime_force_resume)
+};
+
 static const struct of_device_id cdns_ti_of_match[] = {
 	{ .compatible = "ti,j721e-usb", },
 	{ .compatible = "ti,am64-usb", },
@@ -245,6 +269,7 @@ static struct platform_driver cdns_ti_driver = {
 	.driver		= {
 		.name	= "cdns3-ti",
 		.of_match_table	= cdns_ti_of_match,
+		.pm     = pm_ptr(&cdns_ti_pm_ops),
 	},
 };
 

-- 
2.47.1


