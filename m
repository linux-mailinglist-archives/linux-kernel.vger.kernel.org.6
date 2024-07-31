Return-Path: <linux-kernel+bounces-269794-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C6A889436EF
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 22:15:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2DB91C217B8
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 20:15:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 911E215F40D;
	Wed, 31 Jul 2024 20:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="seCBmTC4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3DD116C86B;
	Wed, 31 Jul 2024 20:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722456881; cv=none; b=Gu0bYljykqhBEU5QY4CGx6qiih4Q1v3dDdQNhwWqV/JRzV1cp5PvcpjlVC77wXPUNygDeqRnsYdukRKygUVTW4LbgCh8qlZbrd4PJ4Prrc6GtNlQv0WsNR/MDRCsaT36xbvuwGb42BAmhr1wqX8XJlL0Z+PYh4WvSlET7NwWwP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722456881; c=relaxed/simple;
	bh=HFHMuPV4AJNPvJgLrd4qvJXAA0KQuKcLTWFtPOSBV7w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=l5Zyn/AaGcSsEvtBROTrsIFaqogmtjDbPhu9Fg/5TSCwYoTJL6kNVPY7AH+bFB2dk7nXqTk/5xKnXC2OqknisShcucSBscv9H4f24oWIk7KoDdZuVyJv7niYaItNgFO3pEHigBk3ggFku9vD7+x0F1FWg41NN1Dljzhlees5uXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=seCBmTC4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DEC6C4AF16;
	Wed, 31 Jul 2024 20:14:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722456881;
	bh=HFHMuPV4AJNPvJgLrd4qvJXAA0KQuKcLTWFtPOSBV7w=;
	h=From:To:Cc:Subject:Date:From;
	b=seCBmTC40Hj7a6xaJYPtRBmv0qd+Ukn0du1tm3UNxvn+KOuQ5CMI0NzrroTrP5VTM
	 N3tJ8NSrnRS8x4a9MAfPt4MIt+19CG17pKxlrmtU7lt+JcY1dVUCuRFTyvEes/n17I
	 me4uEHafSYgcCCQ84tHuCvCPkXjYvLbcEeC8sDckkU0UA2Y3HkmrgqndZiiIfTG/0S
	 3WYg0b4y58USYAqLyWFcLRBYF7OYbUOwmbJbNoxUwst/tVO5FRs81jsW7/3jfv7QUw
	 1lSqJhVCB8JYe697sA6DAAA+CAr9+DSj4r2MHlMRubok9P/W5wNt/MJcax/dsPPBuD
	 WlhjyFUrB6pFw==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] usb: dwc3: Use of_property_read_variable_u32_array() to read "power"
Date: Wed, 31 Jul 2024 14:14:00 -0600
Message-ID: <20240731201407.1838385-5-robh@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There's no need to get the length of an DT array property before
parsing the array. of_property_read_variable_u32_array() takes a minimum
and maximum length and returns the actual length (or error code).

This is part of a larger effort to remove callers of of_find_property()
and similar functions. of_find_property() leaks the DT struct property
and data pointers which is a problem for dynamically allocated nodes
which may be freed.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 drivers/usb/dwc3/dwc3-octeon.c | 19 ++++---------------
 1 file changed, 4 insertions(+), 15 deletions(-)

diff --git a/drivers/usb/dwc3/dwc3-octeon.c b/drivers/usb/dwc3/dwc3-octeon.c
index 6010135e1acc..1a3b205367fd 100644
--- a/drivers/usb/dwc3/dwc3-octeon.c
+++ b/drivers/usb/dwc3/dwc3-octeon.c
@@ -419,7 +419,7 @@ static int dwc3_octeon_probe(struct platform_device *pdev)
 	int ref_clk_sel, ref_clk_fsel, mpll_mul;
 	int power_active_low, power_gpio;
 	int err, len;
-	u32 clock_rate;
+	u32 clock_rate, gpio_pwr[3];
 
 	if (of_property_read_u32(node, "refclk-frequency", &clock_rate)) {
 		dev_err(dev, "No UCTL \"refclk-frequency\"\n");
@@ -476,21 +476,10 @@ static int dwc3_octeon_probe(struct platform_device *pdev)
 
 	power_gpio = DWC3_GPIO_POWER_NONE;
 	power_active_low = 0;
-	if (of_find_property(node, "power", &len)) {
-		u32 gpio_pwr[3];
-
-		switch (len) {
-		case 8:
-			of_property_read_u32_array(node, "power", gpio_pwr, 2);
-			break;
-		case 12:
-			of_property_read_u32_array(node, "power", gpio_pwr, 3);
+	len = of_property_read_variable_u32_array(node, "power", gpio_pwr, 2, 3);
+	if (len > 0) {
+		if (len == 3)
 			power_active_low = gpio_pwr[2] & 0x01;
-			break;
-		default:
-			dev_err(dev, "invalid power configuration\n");
-			return -EINVAL;
-		}
 		power_gpio = gpio_pwr[1];
 	}
 
-- 
2.43.0


