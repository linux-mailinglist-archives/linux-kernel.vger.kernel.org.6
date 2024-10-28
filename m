Return-Path: <linux-kernel+bounces-384867-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5831E9B2F99
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 13:04:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0EDFA1F22E84
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 12:04:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B2CD1DB924;
	Mon, 28 Oct 2024 12:02:18 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E98F1DAC9F;
	Mon, 28 Oct 2024 12:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730116937; cv=none; b=gj27d1jpjeexcSnBWN/cCE0oGAkRc3rcvqoOdYAeS87X/Hvm6TjOB4jCDQ2cgA5BMcNuQbj07bNx4ca5HmC3cfvnKh4otNfR3GHd8J+un/cOu8DyEGmh8yWtlYG3Hpe8H3teuxYj/g4l2GRn/ROOI51yv3SED6nAPhvyD6E156w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730116937; c=relaxed/simple;
	bh=fz60ziG+lao7DWzrHq4INr87CuLl1NlLAQ+wxu2hX5s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Uk00Z9eHD6SUl4Y7sMYvmfivjpHy2tTZ6VQ4vcrjAUoUS/0hKnZZmF4bNdQ5vHa3OHDa0Qbs9Tnr1uz/GBlo/uo8ClFthlcFM7H3NNWdDMgldDp656Nn3z8khBH83qr0tKpwh5RSqZm/tYx9bnptuAUvzfvWsQu7MyR4qiMmIEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 267F413D5;
	Mon, 28 Oct 2024 05:02:45 -0700 (PDT)
Received: from pluto.fritz.box (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9493A3F73B;
	Mon, 28 Oct 2024 05:02:13 -0700 (PDT)
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
	Cristian Marussi <cristian.marussi@arm.com>
Subject: [PATCH v3 4/7] firmware: arm_scmi: Use max_msg and max_msg_size devicetree properties
Date: Mon, 28 Oct 2024 12:01:48 +0000
Message-ID: <20241028120151.1301177-5-cristian.marussi@arm.com>
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

Override the default built-in max_msg and max_msg_size transport properties
when the corresponding properties were found to be described in the
devicetree.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
v1 --> v2
- using new prefixed arm, properties
---
 drivers/firmware/arm_scmi/driver.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
index 015a4d52ae37..b9a1d8c1034f 100644
--- a/drivers/firmware/arm_scmi/driver.c
+++ b/drivers/firmware/arm_scmi/driver.c
@@ -3056,8 +3056,20 @@ static const struct scmi_desc *scmi_transport_setup(struct device *dev)
 	if (ret && ret != -EINVAL)
 		dev_err(dev, "Malformed max-rx-timeout-ms DT property.\n");
 
-	dev_info(dev, "SCMI max-rx-timeout: %dms\n",
-		 trans->desc->max_rx_timeout_ms);
+	ret = of_property_read_u32(dev->of_node, "arm,max-msg-size",
+				   &trans->desc->max_msg_size);
+	if (ret && ret != -EINVAL)
+		dev_err(dev, "Malformed arm,max-msg-size DT property.\n");
+
+	ret = of_property_read_u32(dev->of_node, "arm,max-msg",
+				   &trans->desc->max_msg);
+	if (ret && ret != -EINVAL)
+		dev_err(dev, "Malformed arm,max-msg DT property.\n");
+
+	dev_info(dev,
+		 "SCMI max-rx-timeout: %dms / max-msg-size: %dbytes / max-msg: %d\n",
+		 trans->desc->max_rx_timeout_ms, trans->desc->max_msg_size,
+		 trans->desc->max_msg);
 
 	return trans->desc;
 }
-- 
2.47.0


