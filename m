Return-Path: <linux-kernel+bounces-371212-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D56AD9A3804
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 10:07:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C28C1F23ABD
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 08:07:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D92718E033;
	Fri, 18 Oct 2024 08:07:03 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FD7118CBF9;
	Fri, 18 Oct 2024 08:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729238822; cv=none; b=iCcK4cu6eGcuMYCdQEskeMeDFxng/r2Zr4EcXFcxqToUMY0u/1NLCXirSkGkhHlhxOv8hat2JNWuo/KKVC6pBZi+V3ZBVCreVqGvaO+nvm3FuzoqmiZ7qqNOTi7IBRfAYR9kBW03IlFs9L0sAmZVN1AiG1wufOEWP3YjnwcvLkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729238822; c=relaxed/simple;
	bh=KQ4U2h/c9xTnpqFTc78cPcrWSmak6RCnKE9EAQ6C4d0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AkIaNQXQZCw/1wWKnGuZiiTJzUxujIMB05VWkRh1MMsZKwYxSWmgZMHMaK/enmVHwRRuchw8QCcfrBl76gC058eOi78ISg3QZoV0+OzteFp/XbvI3vX3HH/BgMTwl5KjbW5FqxaGtE1b8sLoo0JdCTO2s9RlTqFJBcNlpZqq2wU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3536BFEC;
	Fri, 18 Oct 2024 01:07:30 -0700 (PDT)
Received: from pluto.. (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 798653F528;
	Fri, 18 Oct 2024 01:06:58 -0700 (PDT)
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
Subject: [PATCH 4/5] firmware: arm_scmi: Use max_msg and max_msg_size devicetree properties
Date: Fri, 18 Oct 2024 09:06:01 +0100
Message-ID: <20241018080602.3952869-5-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20241018080602.3952869-1-cristian.marussi@arm.com>
References: <20241018080602.3952869-1-cristian.marussi@arm.com>
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
 drivers/firmware/arm_scmi/driver.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
index 015a4d52ae37..09eb0713d91c 100644
--- a/drivers/firmware/arm_scmi/driver.c
+++ b/drivers/firmware/arm_scmi/driver.c
@@ -3056,8 +3056,20 @@ static const struct scmi_desc *scmi_transport_setup(struct device *dev)
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
2.46.1


