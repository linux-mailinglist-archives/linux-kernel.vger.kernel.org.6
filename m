Return-Path: <linux-kernel+bounces-559036-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 88072A5EE9C
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 09:56:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0D6F16FE94
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 08:56:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBA4E263C6F;
	Thu, 13 Mar 2025 08:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WRfBU0Ax"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EB00262D1C;
	Thu, 13 Mar 2025 08:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741856149; cv=none; b=f+3mO8IHvwkcD921Y+LTD7ATN0WLcWEWufeeMIZyikFLZtuFEHMRyorMy3Zv8JQC3YVjT7Cl/rlaEW7RGK765b28NNdwm3ELQMy46QHhMYZuyVPnt9C6crzqC+ccQK+e2NoQ7p0mYotFMpZqrsfTfPwy5WAJhXbsqu0BhwXbdag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741856149; c=relaxed/simple;
	bh=TWVmCd9sRlFWNOJvA/h/A4jXKCn/9mMzGzNHPLXP+1k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=los0roy5MMZhnfT2mIxPtcQeAqtqQ91kqUzC+WwxP/sUDXHuv0/V2Hv9muYDxxKyGbeNpaksWDqW+B3q9DHWGcHdTcLd2issJpCbJcROZTYwv+06oemx89oIDpWYn3vSgYs9KsSWXTiEXiZLNnajSnGnUveWZNXVaHG8pHRsq5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WRfBU0Ax; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741856148; x=1773392148;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=TWVmCd9sRlFWNOJvA/h/A4jXKCn/9mMzGzNHPLXP+1k=;
  b=WRfBU0Ax5bAWYNMKQLKUG6HrpE3CmTjiZ03of/cgYyvGzkdITFeBs4t/
   eg/xpnoF0WJe20aQqJPbjzBf4ncfLK/RgkPar4+fXKpKAHd2WgZgN7KFP
   TTorg3JeLXaSgi9p5HGgcGMpKvjTBeIf78Y5nFqmCsyHCTzHzLC83bzHw
   Bwd+men9jxCABxxaBPtzNFueom2Jt51G0qa0znUNWQYakdJtSd+AvNINA
   bsnCs4WpeNtVl+IJzavfjlFnl2Sm6OdATkPuHOmkCN9AcGEyHtn6YIJUc
   n/Wnzqit/DPB/10tKkTEMGpHCLZfID8wCkHWo8QQZLYP7TjeB6/cBl8/r
   Q==;
X-CSE-ConnectionGUID: ooSg8m3DS+yJMMsn7ZvqGw==
X-CSE-MsgGUID: zRab3DTLQ6+Dmp1UG2AAvg==
X-IronPort-AV: E=McAfee;i="6700,10204,11371"; a="46614470"
X-IronPort-AV: E=Sophos;i="6.14,244,1736841600"; 
   d="scan'208";a="46614470"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2025 01:55:47 -0700
X-CSE-ConnectionGUID: FgaI41hzTSSUUxLvpp8RKQ==
X-CSE-MsgGUID: CmCKwnOfTOuPDcdafuHmwA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,244,1736841600"; 
   d="scan'208";a="120691590"
Received: from yongliang-ubuntu20-ilbpg12.png.intel.com ([10.88.227.39])
  by fmviesa006.fm.intel.com with ESMTP; 13 Mar 2025 01:55:45 -0700
From: Choong Yong Liang <yong.liang.choong@linux.intel.com>
To: Hans de Goede <hdegoede@redhat.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	David E Box <david.e.box@linux.intel.com>,
	Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] platform/x86: intel_pmc_ipc: add option to build without ACPI
Date: Thu, 13 Mar 2025 16:55:26 +0800
Message-Id: <20250313085526.1439092-1-yong.liang.choong@linux.intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: David E. Box <david.e.box@linux.intel.com>

Introduce a configuration option that allows users to build the
intel_pmc_ipc driver without ACPI support. This is useful for
systems where ACPI is not available or desired.

Based on the discussion from the patch [1], it was necessary to
provide this option to accommodate specific use cases.

Link: https://patchwork.kernel.org/project/netdevbpf/patch/20250227121522.1802832-6-yong.liang.choong@linux.intel.com/#26280764 [1]

Signed-off-by: David E. Box <david.e.box@linux.intel.com>
Co-developed-by: Choong Yong Liang <yong.liang.choong@linux.intel.com>
Signed-off-by: Choong Yong Liang <yong.liang.choong@linux.intel.com>

---
v2 Changes:
- Updated the patch description based on the comment
- Update the author correctly
- Used "#ifdef" instead of "#if" for CONFIG_ACPI
- Placed "#ifdef" inside the function

v1: https://patchwork.kernel.org/project/platform-driver-x86/patch/20250312022955.1418234-1-yong.liang.choong@linux.intel.com/
---
---
 include/linux/platform_data/x86/intel_pmc_ipc.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/platform_data/x86/intel_pmc_ipc.h b/include/linux/platform_data/x86/intel_pmc_ipc.h
index 6e603a8c075f..1d34435b7001 100644
--- a/include/linux/platform_data/x86/intel_pmc_ipc.h
+++ b/include/linux/platform_data/x86/intel_pmc_ipc.h
@@ -36,6 +36,7 @@ struct pmc_ipc_rbuf {
  */
 static inline int intel_pmc_ipc(struct pmc_ipc_cmd *ipc_cmd, struct pmc_ipc_rbuf *rbuf)
 {
+#ifdef CONFIG_ACPI
 	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
 	union acpi_object params[PMC_IPCS_PARAM_COUNT] = {
 		{.type = ACPI_TYPE_INTEGER,},
@@ -89,6 +90,9 @@ static inline int intel_pmc_ipc(struct pmc_ipc_cmd *ipc_cmd, struct pmc_ipc_rbuf
 	}
 
 	return 0;
+#else
+	return -ENODEV;
+#endif /* CONFIG_ACPI */
 }
 
 #endif /* INTEL_PMC_IPC_H */
-- 
2.34.1


