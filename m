Return-Path: <linux-kernel+bounces-511844-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCD07A33070
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 21:06:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A547D7A193C
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 20:05:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAED3202C3E;
	Wed, 12 Feb 2025 20:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eBWB4wQ8"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7DAB201023
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 20:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739390773; cv=none; b=uc9y8FH4S+WyiMgqalf59/w0aaWIyIrNksCp9lP/FMnp0RFpRVqR6TzoGEXjBl9WN/LMLEOIbFT9ULbn26ozjf9B6PTSIC5Ch06xUrj+R9gGTlTQmVp7nBgIC00bBB2ILU8nICG/BANx3Mxc3Hot7+D9Ngc9yak+uo254XQHHJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739390773; c=relaxed/simple;
	bh=XTmQJPQ5vx5r/L8CDAB6q56EodWAZR1tsyiCvS/EAl4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FCV5gVuTWvjeWC2Jjy9fttugrvdUjP2567C308DqwH2M0KeEGXGOrUXYgVT0nnd5awE1WRUpSZqcAMqTLYTVzVXocz1XGvPP/KBzuwNlcIPnj77YQNI7xafc1dXu8TeAiS5G4g9k13ijM+pDHJWaV+RMIBzPet+uSbsNYauXmAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eBWB4wQ8; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739390771; x=1770926771;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XTmQJPQ5vx5r/L8CDAB6q56EodWAZR1tsyiCvS/EAl4=;
  b=eBWB4wQ8skAAw1nn74ZoVV3VToBPaEw90WQ20qgBOln7qZ+c9BGO3Kbl
   DXoMgqONoUUG+e1Jsd3+/3umjQoB/3+j/+WC29VmgpM962QxqttA6Mr+L
   4ObIVGAZiaZMvMveeKZ9AX94+dxCHi3DlCPTaHW/wqQwahTGWJuunW01e
   YlbhBdScpRAnbffrREhHlRmzAtJhiwZI8bv6v/2kWql3m9zfziS7A4G5o
   ECCybZMaDfLMBn3gd6MLEl5/n2C8i4Tt39f7SLQW2wxGgFVNg/IoYu/Er
   Y/SK3S2jhFycsTN9UAUIE46Hic3C7uMiwrbA4fDoGsBbaM9s+LabahrIW
   w==;
X-CSE-ConnectionGUID: 523PLXhlRqebR0S+a/hMAw==
X-CSE-MsgGUID: VF/74kASQeSYR/5zYMdoHA==
X-IronPort-AV: E=McAfee;i="6700,10204,11343"; a="50718501"
X-IronPort-AV: E=Sophos;i="6.13,280,1732608000"; 
   d="scan'208";a="50718501"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2025 12:06:08 -0800
X-CSE-ConnectionGUID: COHXL0iVRKaHteebi5GiEA==
X-CSE-MsgGUID: yztDUGpISz2+Sf8zHaaz4Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,280,1732608000"; 
   d="scan'208";a="118010764"
Received: from lucas-s2600cw.jf.intel.com ([10.165.21.196])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2025 12:06:08 -0800
From: Lucas De Marchi <lucas.demarchi@intel.com>
To: linux-kernel@vger.kernel.org
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>,
	dri-devel@lists.freedesktop.org,
	Danilo Krummrich <dakr@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Lucas De Marchi <lucas.demarchi@intel.com>
Subject: [PATCH 4/6] drm/xe: Stop setting drvdata to NULL
Date: Wed, 12 Feb 2025 12:05:40 -0800
Message-ID: <20250212200542.515493-5-lucas.demarchi@intel.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250212200542.515493-1-lucas.demarchi@intel.com>
References: <20250212200542.515493-1-lucas.demarchi@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

PCI subsystem is not supposed to call the remove() function when probe
fails and doesn't need a protection for that. The only places checking
for NULL drvdata, is on 2 sysfs files and they shouldn't be needed since
the files are removed and reads on open fds just return an error.

Remove the setting to NULL so it's possible to obtain the xe pointer
from callbacks like the component unbind from device_unbind_cleanup(),
i.e. after xe_pci_remove() already finished.

Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
---
 drivers/gpu/drm/xe/xe_device_sysfs.c | 6 ------
 drivers/gpu/drm/xe/xe_pci.c          | 7 +------
 2 files changed, 1 insertion(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_device_sysfs.c b/drivers/gpu/drm/xe/xe_device_sysfs.c
index 7375937934fae..7efbd4c52791c 100644
--- a/drivers/gpu/drm/xe/xe_device_sysfs.c
+++ b/drivers/gpu/drm/xe/xe_device_sysfs.c
@@ -32,9 +32,6 @@ vram_d3cold_threshold_show(struct device *dev,
 	struct xe_device *xe = pdev_to_xe_device(pdev);
 	int ret;
 
-	if (!xe)
-		return -EINVAL;
-
 	xe_pm_runtime_get(xe);
 	ret = sysfs_emit(buf, "%d\n", xe->d3cold.vram_threshold);
 	xe_pm_runtime_put(xe);
@@ -51,9 +48,6 @@ vram_d3cold_threshold_store(struct device *dev, struct device_attribute *attr,
 	u32 vram_d3cold_threshold;
 	int ret;
 
-	if (!xe)
-		return -EINVAL;
-
 	ret = kstrtou32(buff, 0, &vram_d3cold_threshold);
 	if (ret)
 		return ret;
diff --git a/drivers/gpu/drm/xe/xe_pci.c b/drivers/gpu/drm/xe/xe_pci.c
index 70b697fde5b96..41ec6825b9bcc 100644
--- a/drivers/gpu/drm/xe/xe_pci.c
+++ b/drivers/gpu/drm/xe/xe_pci.c
@@ -770,11 +770,7 @@ static int xe_info_init(struct xe_device *xe,
 
 static void xe_pci_remove(struct pci_dev *pdev)
 {
-	struct xe_device *xe;
-
-	xe = pdev_to_xe_device(pdev);
-	if (!xe) /* driver load aborted, nothing to cleanup */
-		return;
+	struct xe_device *xe = pdev_to_xe_device(pdev);
 
 	if (IS_SRIOV_PF(xe))
 		xe_pci_sriov_configure(pdev, 0);
@@ -784,7 +780,6 @@ static void xe_pci_remove(struct pci_dev *pdev)
 
 	xe_device_remove(xe);
 	xe_pm_runtime_fini(xe);
-	pci_set_drvdata(pdev, NULL);
 }
 
 /*
-- 
2.48.1


