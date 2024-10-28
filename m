Return-Path: <linux-kernel+bounces-384871-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E4CA9B2FA0
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 13:05:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B10BC1C22274
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 12:05:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BE6C1DDA18;
	Mon, 28 Oct 2024 12:02:25 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 115A61DC747;
	Mon, 28 Oct 2024 12:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730116944; cv=none; b=QOk1ljizKyl8roijiP+vF1yf9LPVttTSCU99jFzHkZAmoBLqj9mupUUjgzuVy2I/kbGPBkYG1QvGEco2srN+Dp47IPOj3wxIpifJ1udhd+KeRKLlYjrV4USiVKPEukyscoSBy7ruFda+rxsg/hKHBCUdjHkUVStInFJusAN4fMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730116944; c=relaxed/simple;
	bh=F5zUdak1Jnw75m7oOr4TBN1CMB1W8ProzjphVO1IIzE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g8S6Cqc0yh0+ZAswLY3Uu/QyBoxyQdOg6hZd3xfP5Vv/Ov0uUFJn+X+zcEFYebjNi7e7dcVgj3mCzZSRtqUF22ixr4XPHIBA88PBw8ywS6jpoNnjtzm7yqUZuyZgwxM9Ra5oCHAt8N5JyINFlap8VjS/TViTE/ax3l5ITOWQQVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 14E35497;
	Mon, 28 Oct 2024 05:02:52 -0700 (PDT)
Received: from pluto.fritz.box (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6767D3F73B;
	Mon, 28 Oct 2024 05:02:20 -0700 (PDT)
From: Cristian Marussi <cristian.marussi@arm.com>
To: linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	arm-scmi@vger.kernel.org
Cc: sudeep.holla@arm.com,
	james.quinlan@broadcom.com,
	f.fainelli@gmail.com,
	vincent.guittot@linaro.org,
	etienne.carriere@st.com,
	peng.fan@oss.nxp.com,
	michal.simek@amd.com,
	quic_sibis@quicinc.com,
	quic_nkela@quicinc.com,
	dan.carpenter@linaro.org,
	Cristian Marussi <cristian.marussi@arm.com>,
	Peng Fan <peng.fan@nxp.com>
Subject: [PATCH v3 7/7] firmware: arm_scmi: Use vendor string in max-rx-timeout-ms
Date: Mon, 28 Oct 2024 12:01:51 +0000
Message-ID: <20241028120151.1301177-8-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241028120151.1301177-1-cristian.marussi@arm.com>
References: <20241028120151.1301177-1-cristian.marussi@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The original optional property was missing a vendor string prefix; this
has been rectified.

Fix the naming of such optional property in code too.

Cc: Peng Fan <peng.fan@nxp.com>
Fixes: 1780e411ef94 ("firmware: arm_scmi: Use max-rx-timeout-ms from devicetree")
Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 drivers/firmware/arm_scmi/driver.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
index 9bc1bb7caa55..eed73000c902 100644
--- a/drivers/firmware/arm_scmi/driver.c
+++ b/drivers/firmware/arm_scmi/driver.c
@@ -3044,10 +3044,10 @@ static const struct scmi_desc *scmi_transport_setup(struct device *dev)
 
 	dev_info(dev, "Using %s\n", dev_driver_string(trans->supplier));
 
-	ret = of_property_read_u32(dev->of_node, "max-rx-timeout-ms",
+	ret = of_property_read_u32(dev->of_node, "nxp,max-rx-timeout-ms",
 				   &trans->desc->max_rx_timeout_ms);
 	if (ret && ret != -EINVAL)
-		dev_err(dev, "Malformed max-rx-timeout-ms DT property.\n");
+		dev_err(dev, "Malformed nxp,max-rx-timeout-ms DT property.\n");
 
 	ret = of_property_read_u32(dev->of_node, "arm,max-msg-size",
 				   &trans->desc->max_msg_size);
-- 
2.47.0


