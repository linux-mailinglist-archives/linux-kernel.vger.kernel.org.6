Return-Path: <linux-kernel+bounces-374820-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E6F7D9A70A4
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 19:09:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A80FB28370A
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 17:09:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 078C61F8EF0;
	Mon, 21 Oct 2024 17:08:04 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4BDD1F4FD8;
	Mon, 21 Oct 2024 17:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729530483; cv=none; b=n3oSosAqZMNbkjaNb8zV6Ipxfa5AGwGNix/gKRWEV4yT6IS6AcByIeZWm20CzZFHqAiPF4gGdNiaM9bdxjjfGdqxjte6rcTvrvXnVKQOgrZbAbfB095puBgPV4Ucz/NGxzNNadnevR5c57L0Uo66SnpsP0l9V51b9si8hbOJH8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729530483; c=relaxed/simple;
	bh=eQGTVdKP64doc6cKkUoknaNCFhz2SV5Y78Ntb4bCU8U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eZluXGruxB5tGODc0UFgMRJy/zPNzqEAJw9fWGK6sB0ZcnumK/lpXWHPgFAoWHcsrS+wLt9dtfx07ghZATrvSG6IyD1rTGaLN2bbJaWdyzA0wSxoFpcpTWlJZFnRtTXTcC9yIw8S/8Ls9vASGPL7ivpxzlvmMWUSyF6U9d0fyc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6A87EFEC;
	Mon, 21 Oct 2024 10:08:31 -0700 (PDT)
Received: from pluto.fritz.box (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DC3F53F528;
	Mon, 21 Oct 2024 10:07:59 -0700 (PDT)
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
Subject: [PATCH v2 4/5] firmware: arm_scmi: Use max_msg and max_msg_size devicetree properties
Date: Mon, 21 Oct 2024 18:07:25 +0100
Message-ID: <20241021170726.2564329-5-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20241021170726.2564329-1-cristian.marussi@arm.com>
References: <20241021170726.2564329-1-cristian.marussi@arm.com>
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
2.46.1


