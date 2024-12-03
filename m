Return-Path: <linux-kernel+bounces-430122-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B7519E2D87
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 21:49:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 05B2CB61EC9
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 20:06:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8572420E02D;
	Tue,  3 Dec 2024 20:01:12 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 257D7205E37;
	Tue,  3 Dec 2024 20:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733256072; cv=none; b=IL+i/8YKamqfJ4+GvoiN564SOCr8PykoO338+PpvPQ1sS43exAb+NNXM3ibrIcfEmmLlGqtbtsII8yEmVFsu71YGxpbTAG23Rna/lSt7tYxgxR6Mi7IqbHIsPhcGfNYmXz9N31H0kcMXHyb3XwMyfNf/G9YL4bbNQ7/6JzIAUUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733256072; c=relaxed/simple;
	bh=QOJ+12hGDkUho7wq6DP7RfEJABK+teP6XEI9hXaFyuM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g9OAshPN/pY6amyLG/a3ric7ROaBMc16Iiqhc+Zh/xTtbVfKqE2P/B3bclnBLQ6Pj+xgUQ18zMK6AvFo2h8h5Hm9x3fDrtxWtogOeqXAdwX4n4BSbakF8UU4iP472qiGLaf3AUrQbF8najjT0oJAILBXzJ7YnL0lJd2atMxhCro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5C509143D;
	Tue,  3 Dec 2024 12:01:37 -0800 (PST)
Received: from pluto.guest.local (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BB7693F5A1;
	Tue,  3 Dec 2024 12:01:06 -0800 (PST)
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
	Cristian Marussi <cristian.marussi@arm.com>
Subject: [PATCH 1/2] firmware: arm_scmi: Support vendor protocol modules autoloading
Date: Tue,  3 Dec 2024 20:00:37 +0000
Message-ID: <20241203200038.3961090-2-cristian.marussi@arm.com>
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

SCMI vendor protocols namespace is shared amongst all vendors so that there
can be multiple implementation for the same protocol ID by different
vendors, exposing completely different functionalities and used by distinct
SCMI vendor drivers.

For these reasons, at runtime, when some driver asks for a protocol, the
proper implementation to use is chosen based on the SCMI vendor/subvendor/
impl_version data as advertised by the platform SCMI server and gathered
from the SCMI core during stack initialization: this enables proper runtime
selection of vendor protocols even when many different protocols from
different vendors are built into the same image via a common defconfig.

This same selection mechanism works similarly well even when all the vendor
protocols are compiled as loadable modules, as long as all such required
protocol modules have been previously loaded by some other means.

Add support for the automatic loading of vendor protocol modules, based on
protocol/vendor IDs, when an SCMI driver attempts to use such a protocol.

Reported-by: Johan Hovold <johan+linaro@kernel.org>
Closes: https://lore.kernel.org/lkml/ZytnRc94iKUfMYH0@hovoldconsulting.com/
Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 drivers/firmware/arm_scmi/driver.c | 56 ++++++++++++++++++++++++------
 1 file changed, 46 insertions(+), 10 deletions(-)

diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
index eeed1689b208..60050da54bf2 100644
--- a/drivers/firmware/arm_scmi/driver.c
+++ b/drivers/firmware/arm_scmi/driver.c
@@ -24,6 +24,7 @@
 #include <linux/io.h>
 #include <linux/io-64-nonatomic-hi-lo.h>
 #include <linux/kernel.h>
+#include <linux/kmod.h>
 #include <linux/ktime.h>
 #include <linux/hashtable.h>
 #include <linux/list.h>
@@ -43,6 +44,8 @@
 #define CREATE_TRACE_POINTS
 #include <trace/events/scmi.h>
 
+#define SCMI_VENDOR_MODULE_ALIAS_FMT	"scmi-protocol-0x%02x-%s"
+
 static DEFINE_IDA(scmi_id);
 
 static DEFINE_XARRAY(scmi_protocols);
@@ -275,6 +278,44 @@ scmi_vendor_protocol_lookup(int protocol_id, char *vendor_id,
 	return proto;
 }
 
+static const struct scmi_protocol *
+scmi_vendor_protocol_get(int protocol_id, struct scmi_revision_info *version)
+{
+	const struct scmi_protocol *proto;
+
+	proto = scmi_vendor_protocol_lookup(protocol_id, version->vendor_id,
+					    version->sub_vendor_id,
+					    version->impl_ver);
+	if (!proto) {
+		int ret;
+
+		pr_debug("Looking for '" SCMI_VENDOR_MODULE_ALIAS_FMT "'\n",
+			 protocol_id, version->vendor_id);
+
+		/* Note that vendor_id is mandatory for vendor protocols */
+		ret = request_module(SCMI_VENDOR_MODULE_ALIAS_FMT,
+				     protocol_id, version->vendor_id);
+		if (ret) {
+			pr_warn("Problem loading module for protocol 0x%x\n",
+				protocol_id);
+			return NULL;
+		}
+
+		/* Lookup again, once modules loaded */
+		proto = scmi_vendor_protocol_lookup(protocol_id,
+						    version->vendor_id,
+						    version->sub_vendor_id,
+						    version->impl_ver);
+	}
+
+	if (proto)
+		pr_info("Loaded SCMI Vendor Protocol 0x%x - %s %s %X\n",
+			protocol_id, proto->vendor_id ?: "",
+			proto->sub_vendor_id ?: "", proto->impl_ver);
+
+	return proto;
+}
+
 static const struct scmi_protocol *
 scmi_protocol_get(int protocol_id, struct scmi_revision_info *version)
 {
@@ -283,10 +324,8 @@ scmi_protocol_get(int protocol_id, struct scmi_revision_info *version)
 	if (protocol_id < SCMI_PROTOCOL_VENDOR_BASE)
 		proto = xa_load(&scmi_protocols, protocol_id);
 	else
-		proto = scmi_vendor_protocol_lookup(protocol_id,
-						    version->vendor_id,
-						    version->sub_vendor_id,
-						    version->impl_ver);
+		proto = scmi_vendor_protocol_get(protocol_id, version);
+
 	if (!proto || !try_module_get(proto->owner)) {
 		pr_warn("SCMI Protocol 0x%x not found!\n", protocol_id);
 		return NULL;
@@ -294,11 +333,6 @@ scmi_protocol_get(int protocol_id, struct scmi_revision_info *version)
 
 	pr_debug("Found SCMI Protocol 0x%x\n", protocol_id);
 
-	if (protocol_id >= SCMI_PROTOCOL_VENDOR_BASE)
-		pr_info("Loaded SCMI Vendor Protocol 0x%x - %s %s %X\n",
-			protocol_id, proto->vendor_id ?: "",
-			proto->sub_vendor_id ?: "", proto->impl_ver);
-
 	return proto;
 }
 
@@ -366,7 +400,9 @@ int scmi_protocol_register(const struct scmi_protocol *proto)
 		return ret;
 	}
 
-	pr_debug("Registered SCMI Protocol 0x%x\n", proto->id);
+	pr_debug("Registered SCMI Protocol 0x%x - %s  %s  0x%08X\n",
+		 proto->id, proto->vendor_id, proto->sub_vendor_id,
+		 proto->impl_ver);
 
 	return 0;
 }
-- 
2.47.0


