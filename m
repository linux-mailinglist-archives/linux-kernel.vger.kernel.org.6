Return-Path: <linux-kernel+bounces-440740-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E1659EC386
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 04:45:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43CA4285863
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 03:45:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA5A523F9E0;
	Wed, 11 Dec 2024 03:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jK2sn+22"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 489E923EC09;
	Wed, 11 Dec 2024 03:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733888572; cv=none; b=Ko11YvuUBxL8R0XrsFQiTS6eEOuVCzRfbkmsU+OpUc/2H0v9P27gHvFEXJQS956PnQncMW2OGgie2XSXxe5+WohPrD3ZHPYwP++J1yavQNC1EOp/YoSXA7IuFo1tjMykGfL3bNd3Fp+nYI/N6OytyMc0cEXdORh7XEgcp2P9oD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733888572; c=relaxed/simple;
	bh=UKG9Wbc6VVDszzxURZfPCS6h2ksQkdqX9+aM37MM68Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PPoj94hB2Pu4LsHW2Fcwh2MvCXzjC5SQoatURUdeLAQooZ69F1TDVbrCHpTkowX4pOPI8BkcrOrMIKl5X9/BBFI16Jq6HE/vIrBxAaRMe70ldrMmRrDuxsZCjzYvMDcCANoU5j+tnaqt1W/0rI/k6IXXPrqfS9Jw9BbGSAT8L1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jK2sn+22; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733888570; x=1765424570;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=UKG9Wbc6VVDszzxURZfPCS6h2ksQkdqX9+aM37MM68Y=;
  b=jK2sn+223eWpXY0bKz7DqFYzoHk0eI5EtF1aeD8OB50+PTdU7Lc2gj09
   CnIVy231ajy53/sSWhfjINaXwnIj3mMFToRAX2XAhqqaNL9wpZTtvPYe5
   dfPy+KyXt8QZb9sFmjAXEZPvdkuzi8WgG7hTaa2BFqiMBv2Aa5t4d+WVy
   9z6CTKKirGR7Ez9WzQdpcWXdLJ9E3dPecoPQ5nnNdtvc+zaEvGpy4uzk4
   X0Gdh1etH+8eH4Y/96xzu1D+oxQocHA2u74tGrSwywvcy97OsepyefgVv
   7bQV8JDaVAVR/Y3JQGgycQZ0uYvhYk+5grxtiiVdCQPz6giqnCLGtucfC
   A==;
X-CSE-ConnectionGUID: sX6xztApQZ2JOoT5tQZP3Q==
X-CSE-MsgGUID: 1W58VfOhSLSvh5i5bZ1i3g==
X-IronPort-AV: E=McAfee;i="6700,10204,11282"; a="34395749"
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="34395749"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2024 19:42:50 -0800
X-CSE-ConnectionGUID: +01tzQJLQVOX2DPVlHidFA==
X-CSE-MsgGUID: bpdkC1gQQuSQKnttvRP8IA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="95696894"
Received: from lstrano-mobl6.amr.corp.intel.com (HELO localhost) ([10.125.109.231])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2024 19:42:48 -0800
From: Ira Weiny <ira.weiny@intel.com>
Date: Tue, 10 Dec 2024 21:42:27 -0600
Subject: [PATCH v8 12/21] cxl/mem: Configure dynamic capacity interrupts
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241210-dcd-type2-upstream-v8-12-812852504400@intel.com>
References: <20241210-dcd-type2-upstream-v8-0-812852504400@intel.com>
In-Reply-To: <20241210-dcd-type2-upstream-v8-0-812852504400@intel.com>
To: Dave Jiang <dave.jiang@intel.com>, Fan Ni <fan.ni@samsung.com>, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 Jonathan Corbet <corbet@lwn.net>, Andrew Morton <akpm@linux-foundation.org>, 
 Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Dan Williams <dan.j.williams@intel.com>, 
 Davidlohr Bueso <dave@stgolabs.net>, 
 Alison Schofield <alison.schofield@intel.com>, 
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, 
 linux-cxl@vger.kernel.org, linux-doc@vger.kernel.org, 
 nvdimm@lists.linux.dev, linux-kernel@vger.kernel.org, 
 linux-hardening@vger.kernel.org, Li Ming <ming.li@zohomail.com>
X-Mailer: b4 0.15-dev-2a633
X-Developer-Signature: v=1; a=ed25519-sha256; t=1733888537; l=5667;
 i=ira.weiny@intel.com; s=20221211; h=from:subject:message-id;
 bh=UKG9Wbc6VVDszzxURZfPCS6h2ksQkdqX9+aM37MM68Y=;
 b=zqTCRsCB9d5pmLJLOmsGtRsKl4BevAqm5a65J/R5xuNN1849c/JR7yJ18PWltpnKwfcGvaF5B
 6SBY5KeYbv3DcppuHOz/bRJ294nQteyuzGwfGJJZATjeCar4nTaM26V
X-Developer-Key: i=ira.weiny@intel.com; a=ed25519;
 pk=noldbkG+Wp1qXRrrkfY1QJpDf7QsOEthbOT7vm0PqsE=

Dynamic Capacity Devices (DCD) support extent change notifications
through the event log mechanism.  The interrupt mailbox commands were
extended in CXL 3.1 to support these notifications.  Firmware can't
configure DCD events to be FW controlled but can retain control of
memory events.

Configure DCD event log interrupts on devices supporting dynamic
capacity.  Disable DCD if interrupts are not supported.

Care is taken to preserve the interrupt policy set by the FW if FW first
has been selected by the BIOS.

Based on an original patch by Navneet Singh.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Li Ming <ming.li@zohomail.com>
Reviewed-by: Fan Ni <fan.ni@samsung.com>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
 drivers/cxl/cxlmem.h |  2 ++
 drivers/cxl/pci.c    | 73 ++++++++++++++++++++++++++++++++++++++++++----------
 2 files changed, 62 insertions(+), 13 deletions(-)

diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index bbdf52ac1d5cb5df82812c13ff50ca7cacfd0db6..863899b295b719b57638ee060e494e5cf2d639fd 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -226,7 +226,9 @@ struct cxl_event_interrupt_policy {
 	u8 warn_settings;
 	u8 failure_settings;
 	u8 fatal_settings;
+	u8 dcd_settings;
 } __packed;
+#define CXL_EVENT_INT_POLICY_BASE_SIZE 4 /* info, warn, failure, fatal */
 
 /**
  * struct cxl_event_state - Event log driver state
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 22e6047e3c3db7a16670b7a5aa4797ad20befb22..15e85ba66ff7112a8413c4c1acc4b4a71f47a298 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -685,23 +685,34 @@ static int cxl_event_get_int_policy(struct cxl_memdev_state *mds,
 }
 
 static int cxl_event_config_msgnums(struct cxl_memdev_state *mds,
-				    struct cxl_event_interrupt_policy *policy)
+				    struct cxl_event_interrupt_policy *policy,
+				    bool native_cxl)
 {
 	struct cxl_mailbox *cxl_mbox = &mds->cxlds.cxl_mbox;
+	size_t size_in = CXL_EVENT_INT_POLICY_BASE_SIZE;
 	struct cxl_mbox_cmd mbox_cmd;
 	int rc;
 
-	*policy = (struct cxl_event_interrupt_policy) {
-		.info_settings = CXL_INT_MSI_MSIX,
-		.warn_settings = CXL_INT_MSI_MSIX,
-		.failure_settings = CXL_INT_MSI_MSIX,
-		.fatal_settings = CXL_INT_MSI_MSIX,
-	};
+	/* memory event policy is left if FW has control */
+	if (native_cxl) {
+		*policy = (struct cxl_event_interrupt_policy) {
+			.info_settings = CXL_INT_MSI_MSIX,
+			.warn_settings = CXL_INT_MSI_MSIX,
+			.failure_settings = CXL_INT_MSI_MSIX,
+			.fatal_settings = CXL_INT_MSI_MSIX,
+			.dcd_settings = 0,
+		};
+	}
+
+	if (cxl_dcd_supported(mds)) {
+		policy->dcd_settings = CXL_INT_MSI_MSIX;
+		size_in += sizeof(policy->dcd_settings);
+	}
 
 	mbox_cmd = (struct cxl_mbox_cmd) {
 		.opcode = CXL_MBOX_OP_SET_EVT_INT_POLICY,
 		.payload_in = policy,
-		.size_in = sizeof(*policy),
+		.size_in = size_in,
 	};
 
 	rc = cxl_internal_send_cmd(cxl_mbox, &mbox_cmd);
@@ -748,6 +759,30 @@ static int cxl_event_irqsetup(struct cxl_memdev_state *mds,
 	return 0;
 }
 
+static int cxl_irqsetup(struct cxl_memdev_state *mds,
+			struct cxl_event_interrupt_policy *policy,
+			bool native_cxl)
+{
+	struct cxl_dev_state *cxlds = &mds->cxlds;
+	int rc;
+
+	if (native_cxl) {
+		rc = cxl_event_irqsetup(mds, policy);
+		if (rc)
+			return rc;
+	}
+
+	if (cxl_dcd_supported(mds)) {
+		rc = cxl_event_req_irq(cxlds, policy->dcd_settings);
+		if (rc) {
+			dev_err(cxlds->dev, "Failed to get interrupt for DCD event log\n");
+			cxl_disable_dcd(mds);
+		}
+	}
+
+	return 0;
+}
+
 static bool cxl_event_int_is_fw(u8 setting)
 {
 	u8 mode = FIELD_GET(CXLDEV_EVENT_INT_MODE_MASK, setting);
@@ -773,18 +808,26 @@ static bool cxl_event_validate_mem_policy(struct cxl_memdev_state *mds,
 static int cxl_event_config(struct pci_host_bridge *host_bridge,
 			    struct cxl_memdev_state *mds, bool irq_avail)
 {
-	struct cxl_event_interrupt_policy policy;
+	struct cxl_event_interrupt_policy policy = { 0 };
+	bool native_cxl = host_bridge->native_cxl_error;
 	int rc;
 
 	/*
 	 * When BIOS maintains CXL error reporting control, it will process
 	 * event records.  Only one agent can do so.
+	 *
+	 * If BIOS has control of events and DCD is not supported skip event
+	 * configuration.
 	 */
-	if (!host_bridge->native_cxl_error)
+	if (!native_cxl && !cxl_dcd_supported(mds))
 		return 0;
 
 	if (!irq_avail) {
 		dev_info(mds->cxlds.dev, "No interrupt support, disable event processing.\n");
+		if (cxl_dcd_supported(mds)) {
+			dev_info(mds->cxlds.dev, "DCD requires interrupts, disable DCD\n");
+			cxl_disable_dcd(mds);
+		}
 		return 0;
 	}
 
@@ -792,10 +835,10 @@ static int cxl_event_config(struct pci_host_bridge *host_bridge,
 	if (rc)
 		return rc;
 
-	if (!cxl_event_validate_mem_policy(mds, &policy))
+	if (native_cxl && !cxl_event_validate_mem_policy(mds, &policy))
 		return -EBUSY;
 
-	rc = cxl_event_config_msgnums(mds, &policy);
+	rc = cxl_event_config_msgnums(mds, &policy, native_cxl);
 	if (rc)
 		return rc;
 
@@ -803,12 +846,16 @@ static int cxl_event_config(struct pci_host_bridge *host_bridge,
 	if (rc)
 		return rc;
 
-	rc = cxl_event_irqsetup(mds, &policy);
+	rc = cxl_irqsetup(mds, &policy, native_cxl);
 	if (rc)
 		return rc;
 
 	cxl_mem_get_event_records(mds, CXLDEV_EVENT_STATUS_ALL);
 
+	dev_dbg(mds->cxlds.dev, "Event config : %s DCD %s\n",
+		native_cxl ? "OS" : "BIOS",
+		cxl_dcd_supported(mds) ? "supported" : "not supported");
+
 	return 0;
 }
 

-- 
2.47.1


