Return-Path: <linux-kernel+bounces-267723-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 979799414C1
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 16:48:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 350B4B23724
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 14:48:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DA1C1A38E7;
	Tue, 30 Jul 2024 14:48:05 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C2B71A38DC;
	Tue, 30 Jul 2024 14:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722350884; cv=none; b=gb7wahVJbliYdjofIQxjugGXJeksLta/D1m6dzoRlys/RB6eHpPcf0nTuzPxcmiEu2eww1WrW3iMEE5ux6mBGlMMksWBZQSoj1hzrSrGv6Gv4pZO0jjyWtVFP40B4SuOBNpIclG6HJ6Cwxjm54PoCy/wXwmYAifXC2Vbvxgx3NU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722350884; c=relaxed/simple;
	bh=nZi9fwkzJW3/B5O8IGUlj0FY93R9FbQCXSMKA6Bk61g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ryb0HNNpGRhEgTu8DzydBEHX0DncP8QrXdfH8s+V4v+uMWzMsZ7/cKqTCNVHexHg1Gp4i9tmnW8cN39r7JD6IfnBU0Rioc9xSh27gffVUhItAcLQP/715gcHHn0MVXq4U1s5PxuCwIMJaCJB+VazIVG3mUP/cj0Qz8jkhdmRe0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B69D11007;
	Tue, 30 Jul 2024 07:48:28 -0700 (PDT)
Received: from pluto.guestnet.cambridge.arm.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2E5CE3F766;
	Tue, 30 Jul 2024 07:48:00 -0700 (PDT)
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
	Cristian Marussi <cristian.marussi@arm.com>,
	Peng Fan <peng.fan@nxp.com>
Subject: [PATCH v1 3/6] firmware: arm_scmi: Use max-rx-timeout-ms from devicetree
Date: Tue, 30 Jul 2024 15:47:04 +0100
Message-ID: <20240730144707.1647025-4-cristian.marussi@arm.com>
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

Override default maximum RX timeout with the value picked from the
devicetree, when provided.

Suggested-by: Peng Fan <peng.fan@nxp.com>
Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 drivers/firmware/arm_scmi/driver.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
index 332cd5207bbc..e7dab0eea540 100644
--- a/drivers/firmware/arm_scmi/driver.c
+++ b/drivers/firmware/arm_scmi/driver.c
@@ -2964,6 +2964,7 @@ static int scmi_debugfs_raw_mode_setup(struct scmi_info *info)
 static const struct scmi_desc *scmi_transport_setup(struct device *dev)
 {
 	struct scmi_transport *trans;
+	int ret;
 
 	trans = dev_get_platdata(dev);
 	if (!trans || !trans->desc || !trans->supplier || !trans->core_ops)
@@ -2980,6 +2981,14 @@ static const struct scmi_desc *scmi_transport_setup(struct device *dev)
 
 	dev_info(dev, "Using %s\n", dev_driver_string(trans->supplier));
 
+	ret = of_property_read_u32(dev->of_node, "max-rx-timeout-ms",
+				   &trans->desc->max_rx_timeout_ms);
+	if (ret && ret != -EINVAL)
+		dev_err(dev, "Malformed max-rx-timeout-ms DT property.\n");
+
+	dev_info(dev, "SCMI max-rx-timeout: %dms\n",
+		 trans->desc->max_rx_timeout_ms);
+
 	return trans->desc;
 }
 
-- 
2.45.2


