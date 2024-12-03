Return-Path: <linux-kernel+bounces-430123-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 393F29E2CAB
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 21:06:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F314128AF89
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 20:06:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 417A820E032;
	Tue,  3 Dec 2024 20:01:15 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E07E20E035;
	Tue,  3 Dec 2024 20:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733256074; cv=none; b=tFpIqKr4ei5g6xEOHm/l4lzmuU0iyvLpiym/99jZ0BP4TzmM6SHf33hbfO5MbOTyxolJIPsdnnpsZ3fOzC7ejz0wU/0gb+juLFVeyPkHcOA38Lt87UHjvoU9P0QU/0nnGG15VePyUFYrKcGnwPtdLEvpOp4Wb9epJdqpY5jJFx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733256074; c=relaxed/simple;
	bh=Y8XLP/8wvsHZ6IuoLZ0J19vxokDw45qrUah47Ok8APE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l7RDOT+mTJguSjvtiEpRDlasJvQslwhqvBMC7m2y4UGeyk3cFRNyPzfiS8QcXCgexqeb38qSJ4beBcKjJ5WDowbyC9qz/v7KiBtex8Cuu2IUtz2hsC/xLk0vMHsIz7/Cr7fU5aUsofo6PM1+sERvv044AOKq16YgOVXAFYMb8bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 60529175D;
	Tue,  3 Dec 2024 12:01:40 -0800 (PST)
Received: from pluto.guest.local (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B1E913F5A1;
	Tue,  3 Dec 2024 12:01:09 -0800 (PST)
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
	dan.carpenter@linaro.org,
	johan+linaro@kernel.org,
	Cristian Marussi <cristian.marussi@arm.com>,
	Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 2/2] firmware: arm_scmi: Add module aliases to i.MX vendor protocols
Date: Tue,  3 Dec 2024 20:00:38 +0000
Message-ID: <20241203200038.3961090-3-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241203200038.3961090-1-cristian.marussi@arm.com>
References: <20241203200038.3961090-1-cristian.marussi@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Using the pattern 'scmi-protocol-0x<PROTO_ID>-<VEND_ID>' as MODULE_ALIAS
allows the SCMI core to autoload this protocol, if built as a module, when
its protocol operations are requested by an SCMI driver.

Cc: Peng Fan <peng.fan@nxp.com>
Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 drivers/firmware/arm_scmi/vendors/imx/imx-sm-bbm.c  | 5 +++--
 drivers/firmware/arm_scmi/vendors/imx/imx-sm-misc.c | 5 +++--
 include/linux/scmi_imx_protocol.h                   | 9 +++++----
 3 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/firmware/arm_scmi/vendors/imx/imx-sm-bbm.c b/drivers/firmware/arm_scmi/vendors/imx/imx-sm-bbm.c
index 17799eacf06c..aa176c1a5eef 100644
--- a/drivers/firmware/arm_scmi/vendors/imx/imx-sm-bbm.c
+++ b/drivers/firmware/arm_scmi/vendors/imx/imx-sm-bbm.c
@@ -374,10 +374,11 @@ static const struct scmi_protocol scmi_imx_bbm = {
 	.ops = &scmi_imx_bbm_proto_ops,
 	.events = &scmi_imx_bbm_protocol_events,
 	.supported_version = SCMI_PROTOCOL_SUPPORTED_VERSION,
-	.vendor_id = "NXP",
-	.sub_vendor_id = "IMX",
+	.vendor_id = SCMI_IMX_VENDOR,
+	.sub_vendor_id = SCMI_IMX_SUBVENDOR,
 };
 module_scmi_protocol(scmi_imx_bbm);
 
+MODULE_ALIAS("scmi-protocol-" __stringify(SCMI_PROTOCOL_IMX_BBM) "-" SCMI_IMX_VENDOR);
 MODULE_DESCRIPTION("i.MX SCMI BBM driver");
 MODULE_LICENSE("GPL");
diff --git a/drivers/firmware/arm_scmi/vendors/imx/imx-sm-misc.c b/drivers/firmware/arm_scmi/vendors/imx/imx-sm-misc.c
index a86ab9b35953..83b69fc4fba5 100644
--- a/drivers/firmware/arm_scmi/vendors/imx/imx-sm-misc.c
+++ b/drivers/firmware/arm_scmi/vendors/imx/imx-sm-misc.c
@@ -309,10 +309,11 @@ static const struct scmi_protocol scmi_imx_misc = {
 	.ops = &scmi_imx_misc_proto_ops,
 	.events = &scmi_imx_misc_protocol_events,
 	.supported_version = SCMI_PROTOCOL_SUPPORTED_VERSION,
-	.vendor_id = "NXP",
-	.sub_vendor_id = "IMX",
+	.vendor_id = SCMI_IMX_VENDOR,
+	.sub_vendor_id = SCMI_IMX_SUBVENDOR,
 };
 module_scmi_protocol(scmi_imx_misc);
 
+MODULE_ALIAS("scmi-protocol-" __stringify(SCMI_PROTOCOL_IMX_MISC) "-" SCMI_IMX_VENDOR);
 MODULE_DESCRIPTION("i.MX SCMI MISC driver");
 MODULE_LICENSE("GPL");
diff --git a/include/linux/scmi_imx_protocol.h b/include/linux/scmi_imx_protocol.h
index 066216f1357a..53b356a26414 100644
--- a/include/linux/scmi_imx_protocol.h
+++ b/include/linux/scmi_imx_protocol.h
@@ -13,10 +13,11 @@
 #include <linux/notifier.h>
 #include <linux/types.h>
 
-enum scmi_nxp_protocol {
-	SCMI_PROTOCOL_IMX_BBM = 0x81,
-	SCMI_PROTOCOL_IMX_MISC = 0x84,
-};
+#define	SCMI_PROTOCOL_IMX_BBM	0x81
+#define	SCMI_PROTOCOL_IMX_MISC	0x84
+
+#define SCMI_IMX_VENDOR		"NXP"
+#define SCMI_IMX_SUBVENDOR	"IMX"
 
 struct scmi_imx_bbm_proto_ops {
 	int (*rtc_time_set)(const struct scmi_protocol_handle *ph, u32 id,
-- 
2.47.0


