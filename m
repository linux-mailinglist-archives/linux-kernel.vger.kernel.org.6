Return-Path: <linux-kernel+bounces-267725-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 912529414C5
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 16:49:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2C30BB25E95
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 14:49:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 078241A2C03;
	Tue, 30 Jul 2024 14:48:12 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C41E1A3BB7;
	Tue, 30 Jul 2024 14:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722350891; cv=none; b=N8BXYBzRmI7I6P2p2yHrQ5WZD+bJ5mXvIZWn2xERz0coPfTVwfCDEYXiP1BhUDZnZbMGl8KtNhI09B1dcm86mbjD7R4t25x2wWagAOCK7UHmSevJk+4y+UHlZiRp0jCYb1yfI2KZKPHLpZK72FEIPgW1+Sz6YS75EzIllBc8XIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722350891; c=relaxed/simple;
	bh=fAYayJWEJghDVq/MkzUI7txEIHh26n/qL/Sbjq1/CX0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VahuLTg7ux5zOBfy11TnjjAfJLBZiFA6wcU/MhASB1C8hhq5FJCr+bLBTdFseJJ2nlNaYSFHPyV+OxrlLahr6MsHyFaG3Ggmax9dkkpaj66AepNqxo+QTUy3dv/payNYdRsdtA8SKsdxGTmkTwipLL6tYJg5WLz+vIneJMjstQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D6F041007;
	Tue, 30 Jul 2024 07:48:34 -0700 (PDT)
Received: from pluto.guestnet.cambridge.arm.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 807D53F766;
	Tue, 30 Jul 2024 07:48:06 -0700 (PDT)
From: Cristian Marussi <cristian.marussi@arm.com>
To: linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	arm-scmi@vger.kernel.org,
	devicetree@vger.kernel.org
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
	souvik.chakravarty@arm.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	Cristian Marussi <cristian.marussi@arm.com>
Subject: [PATCH v1 5/6] firmware: arm_scmi: Use max_msg and max_msg_size from devicetree
Date: Tue, 30 Jul 2024 15:47:06 +0100
Message-ID: <20240730144707.1647025-6-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240730144707.1647025-1-cristian.marussi@arm.com>
References: <20240730144707.1647025-1-cristian.marussi@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Override max_msg and max_msg_size transport properties when corresponding
devicetree properties are available.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 drivers/firmware/arm_scmi/driver.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
index e7dab0eea540..8295e63be38e 100644
--- a/drivers/firmware/arm_scmi/driver.c
+++ b/drivers/firmware/arm_scmi/driver.c
@@ -2986,8 +2986,20 @@ static const struct scmi_desc *scmi_transport_setup(struct device *dev)
 	if (ret && ret != -EINVAL)
 		dev_err(dev, "Malformed max-rx-timeout-ms DT property.\n");
 
-	dev_info(dev, "SCMI max-rx-timeout: %dms\n",
-		 trans->desc->max_rx_timeout_ms);
+	ret = of_property_read_u32(dev->of_node, "max-msg-size",
+				   &trans->desc->max_msg_size);
+	if (ret && ret != -EINVAL)
+		dev_err(dev, "Malformed max-msg-size DT property.\n");
+
+	ret = of_property_read_u32(dev->of_node, "max-msg",
+				   &trans->desc->max_msg);
+	if (ret && ret != -EINVAL)
+		dev_err(dev, "Malformed max-msg DT property.\n");
+
+	dev_info(dev,
+		 "SCMI max-rx-timeout: %dms / max-msg-size: %dbytes / max-msg: %d\n",
+		 trans->desc->max_rx_timeout_ms, trans->desc->max_msg_size,
+		 trans->desc->max_msg);
 
 	return trans->desc;
 }
-- 
2.45.2


