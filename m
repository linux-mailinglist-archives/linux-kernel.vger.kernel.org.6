Return-Path: <linux-kernel+bounces-557164-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 596FBA5D461
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 03:30:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98305179D38
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 02:30:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6460318C936;
	Wed, 12 Mar 2025 02:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="C6q4XuFp"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 836F078F26;
	Wed, 12 Mar 2025 02:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741746613; cv=none; b=H2ao25HaW32Yw+SlU2aF+2UuFySqUcVVCFx2j4i44QwIwtnq5JNAMw/dBVztdnY1AIY5DRkqdfpl7/pktvQYKlaAZ5i65s8q+QjQZCZectptXLRfim0mU8sm5Nwvy73ZazmRyPnGkTTFcP8U5yQTau6mnxwhn+jpAW6mtBz551U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741746613; c=relaxed/simple;
	bh=D+BYOPU/tyZGEaeihV/q19h7846VhI8LhSlf1dlGg1E=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=i3uNxs5KgF+XymIfrt2RsOpSVoz4B3R/oAK7RjlA1cW7S4w0SkCnzbJ5yMiL9NrPVq/c9I6bVrsYbZpV9R5QoGdEE49e4+qUlolE8gJzPrWjyJ/hdN0sc5H6el6mTPsn2XF22Or2ryxGZfqZoP+JG2vc19FL+g/OkUXO54+OSVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=C6q4XuFp; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741746612; x=1773282612;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=D+BYOPU/tyZGEaeihV/q19h7846VhI8LhSlf1dlGg1E=;
  b=C6q4XuFp8BJFUq6AmWSTsWFgRuUZ43s3+2mk7WAlvT59ilNwSx0tNq8U
   RN6puKsM3cTAGdUipZkKrpKhj/DhogrkuvZuuEWsUQemgetr0m7Bu2JU2
   wK4f6bfPLYZcyYYCR2FzIHt9Z55PGsUo/A3h5ChtAnjVsbnzkSRVWguzI
   GEiJWU/jm45IbMHJs9zEG5OeOTnLI+WoZulf6/eg1pYnsPvb/DVEJ25n7
   0lAPF0YouuTzB2O3dGK8CmZIfEZm/uWRCKksd1ioKUrp3/EuFz/IZFNYN
   NXShnQEjbTB+TdvhHyU+llR9ya3M/M7VHCOlNdAITws0YX4OIV66HS0GS
   w==;
X-CSE-ConnectionGUID: pj0SfoO2Skmc5EIEzYj6LA==
X-CSE-MsgGUID: rbUmeT6jR5GC72ijpaUaLw==
X-IronPort-AV: E=McAfee;i="6700,10204,11370"; a="65270308"
X-IronPort-AV: E=Sophos;i="6.14,240,1736841600"; 
   d="scan'208";a="65270308"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2025 19:30:11 -0700
X-CSE-ConnectionGUID: RrG0n1x4Sfun5V+xmW/I6Q==
X-CSE-MsgGUID: 4yFxb486RjuEGEadb6zB6w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,240,1736841600"; 
   d="scan'208";a="157695740"
Received: from yongliang-ubuntu20-ilbpg12.png.intel.com ([10.88.227.39])
  by orviesa001.jf.intel.com with ESMTP; 11 Mar 2025 19:30:08 -0700
From: Choong Yong Liang <yong.liang.choong@linux.intel.com>
To: Hans de Goede <hdegoede@redhat.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	David E Box <david.e.box@linux.intel.com>,
	Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1] platform/x86: intel_pmc_ipc: add option to build without ACPI
Date: Wed, 12 Mar 2025 10:29:55 +0800
Message-Id: <20250312022955.1418234-1-yong.liang.choong@linux.intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch introduces a configuration option that allows users to
build the intel_pmc_ipc driver without ACPI support. This is useful
for systems where ACPI is not available or desired.

Based on the discussion from the patch: https://patchwork.kernel.org/
project/netdevbpf/patch/20250227121522.1802832-6-
yong.liang.choong@linux.intel.com/#26280764, it was necessary to
provide this option to accommodate specific use cases.

Signed-off-by: David E. Box <david.e.box@linux.intel.com>
Signed-off-by: Choong Yong Liang <yong.liang.choong@linux.intel.com>
---
 include/linux/platform_data/x86/intel_pmc_ipc.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/platform_data/x86/intel_pmc_ipc.h b/include/linux/platform_data/x86/intel_pmc_ipc.h
index 6e603a8c075f..a852f1a02532 100644
--- a/include/linux/platform_data/x86/intel_pmc_ipc.h
+++ b/include/linux/platform_data/x86/intel_pmc_ipc.h
@@ -34,6 +34,7 @@ struct pmc_ipc_rbuf {
  *
  * Return: 0 on success. Non-zero on mailbox error
  */
+#if CONFIG_ACPI
 static inline int intel_pmc_ipc(struct pmc_ipc_cmd *ipc_cmd, struct pmc_ipc_rbuf *rbuf)
 {
 	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
@@ -90,5 +91,9 @@ static inline int intel_pmc_ipc(struct pmc_ipc_cmd *ipc_cmd, struct pmc_ipc_rbuf
 
 	return 0;
 }
+#else
+static inline int intel_pmc_ipc(struct pmc_ipc_cmd *ipc_cmd, struct pmc_ipc_rbuf *rbuf)
+{ return -ENODEV; }
+#endif /* CONFIG_ACPI */
 
 #endif /* INTEL_PMC_IPC_H */
-- 
2.34.1


