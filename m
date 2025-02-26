Return-Path: <linux-kernel+bounces-535017-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECAFEA46DDB
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 22:47:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02E003AAAB6
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 21:47:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 139B425A65F;
	Wed, 26 Feb 2025 21:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ShtI3Gt2"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7D511E1E19;
	Wed, 26 Feb 2025 21:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740606462; cv=none; b=LNg5uVT0owsQoHPnTndYyEPxmtXhoig6Yqhkzl5cCH0SYVwEhXamOP7HvRU60DkzkkqbnpnsR5p9wK4I0No8YAQ9l8GunAa5S2jf04ObRhnpl9lzSekkO8PL0eWUD9xYQSN/7I1rGgvk6xDx2ZlrlBCg2p2ruHowrh1nsjebxqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740606462; c=relaxed/simple;
	bh=oenYRvg0xo1hqY4TCIz0FMAJohQgmJguqQ7rj5rTx8E=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=Er/rY8hu6I2UgPb0xu8xU5xfEFHQEr3AuROistoP0EbY7L7ZMXs0HTjLRDWCnqKPZvGeMVDl2T/oeobWa4AYVeRCHgFAxljPcdZr+REGLtivrfIiiZtmH+nzC/X0zHeNfCuB/KK+/vJZp86U5ctRT8ku0QR/vJ0d9/BaiFUtVJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ShtI3Gt2; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740606461; x=1772142461;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=oenYRvg0xo1hqY4TCIz0FMAJohQgmJguqQ7rj5rTx8E=;
  b=ShtI3Gt2KAmTO9WLphSWG6o2WoEcJxCN2Qr8acSkksxx6U/KhMiEJr8L
   k9mBy/8Ttl+82KOqwQHEuekKDKuBXnIKVedz3ivbwCCvwGMcXgHUN2wxh
   e5LZ3oXm7jsdiMsKIM+/elhyru2ZKizISNTKFFXFM07pKQ2LVzLW9Tgig
   sYOLPhTIAcDiCt4W3ge/yCy3AJR8/2HgtzyA0cIG6bJe6Ct1SAIuKLxdh
   f10pLWgwfVlpF5tY4w5jSgd7f/HKcsls6dp5VZ/3tZltXAXuWMHPwmpcu
   rmq461Nq9r7Zr/vMS/SX7wzjSpmtIG71mmNX4e8zIYAgZ+2Wgf50LH6sx
   Q==;
X-CSE-ConnectionGUID: FS6B79ioQFyKavn95eHclA==
X-CSE-MsgGUID: qEudSXq6Qzqj9QTanZ7abQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11357"; a="51684200"
X-IronPort-AV: E=Sophos;i="6.13,318,1732608000"; 
   d="scan'208";a="51684200"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2025 13:47:40 -0800
X-CSE-ConnectionGUID: ZSlfOwEBROKj1tuQlpSRgw==
X-CSE-MsgGUID: ybLoDQ6qQFehurQtRlLbtA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,318,1732608000"; 
   d="scan'208";a="147649804"
Received: from mgoodin-mobl2.amr.corp.intel.com (HELO debox1-desk4.intel.com) ([10.125.108.21])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2025 13:47:40 -0800
From: "David E. Box" <david.e.box@linux.intel.com>
To: david.e.box@linux.intel.com,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] platform/x86/intel/vsec: Add Diamond Rapids support
Date: Wed, 26 Feb 2025 13:47:27 -0800
Message-ID: <20250226214728.1256747-1-david.e.box@linux.intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add PCI ID for the Diamond Rapids Platforms

Signed-off-by: David E. Box <david.e.box@linux.intel.com>
---
 drivers/platform/x86/intel/vsec.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/platform/x86/intel/vsec.c b/drivers/platform/x86/intel/vsec.c
index 77d17decb318..931ad606dee4 100644
--- a/drivers/platform/x86/intel/vsec.c
+++ b/drivers/platform/x86/intel/vsec.c
@@ -695,6 +695,11 @@ static const struct intel_vsec_platform_info oobmsm_info = {
 	.caps = VSEC_CAP_TELEMETRY | VSEC_CAP_SDSI | VSEC_CAP_TPMI,
 };
 
+/* DMR OOBMSM info */
+static const struct intel_vsec_platform_info dmr_oobmsm_info = {
+	.caps = VSEC_CAP_TELEMETRY | VSEC_CAP_TPMI,
+};
+
 /* TGL info */
 static const struct intel_vsec_platform_info tgl_info = {
 	.caps = VSEC_CAP_TELEMETRY,
@@ -711,6 +716,7 @@ static const struct intel_vsec_platform_info lnl_info = {
 #define PCI_DEVICE_ID_INTEL_VSEC_MTL_M		0x7d0d
 #define PCI_DEVICE_ID_INTEL_VSEC_MTL_S		0xad0d
 #define PCI_DEVICE_ID_INTEL_VSEC_OOBMSM		0x09a7
+#define PCI_DEVICE_ID_INTEL_VSEC_OOBMSM_DMR	0x09a1
 #define PCI_DEVICE_ID_INTEL_VSEC_RPL		0xa77d
 #define PCI_DEVICE_ID_INTEL_VSEC_TGL		0x9a0d
 #define PCI_DEVICE_ID_INTEL_VSEC_LNL_M		0x647d
@@ -721,6 +727,7 @@ static const struct pci_device_id intel_vsec_pci_ids[] = {
 	{ PCI_DEVICE_DATA(INTEL, VSEC_MTL_M, &mtl_info) },
 	{ PCI_DEVICE_DATA(INTEL, VSEC_MTL_S, &mtl_info) },
 	{ PCI_DEVICE_DATA(INTEL, VSEC_OOBMSM, &oobmsm_info) },
+	{ PCI_DEVICE_DATA(INTEL, VSEC_OOBMSM_DMR, &dmr_oobmsm_info) },
 	{ PCI_DEVICE_DATA(INTEL, VSEC_RPL, &tgl_info) },
 	{ PCI_DEVICE_DATA(INTEL, VSEC_TGL, &tgl_info) },
 	{ PCI_DEVICE_DATA(INTEL, VSEC_LNL_M, &lnl_info) },

base-commit: 2014c95afecee3e76ca4a56956a936e23283f05b
-- 
2.43.0


