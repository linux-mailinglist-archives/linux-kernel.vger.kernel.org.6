Return-Path: <linux-kernel+bounces-216714-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2FAC90A4F1
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 08:14:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3187E288D77
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 06:14:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E87A195B1D;
	Mon, 17 Jun 2024 06:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iimiXwhX"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BC20187321;
	Mon, 17 Jun 2024 06:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718604439; cv=none; b=LsXaHETXpILgq7017X4a/8Xb8dOyQ0I1H4PUksdHK0qo83+IT7mDcqfyzdnuAeA3JScDRlrIAKPLm/JWoYcQkgCgXFQkEUKLSOdId9zhjMixIbSDRa3zzdAGU0vYbBSX3k88JH0l5a/dxMfiH1C5BWjEKS+j7M3y2zhZaR96t5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718604439; c=relaxed/simple;
	bh=thTPNNoDXBJ4gDJLDAVKzpHIlZxexyMsW0e4VxTR29U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RI2bfIq9M1vHxLivzanawPu2TSGZMDUECRQRq74noe6avxudNwWJjS810bUb7rMsgQ4aKmPHAMEZLKF+60g4HPn+w4EqDJqOt3gjjUM2Y5spLYRNL0cJWNNQyYF+bd+8HunxvYHj5yZOpkNDSrVjGdAIFKmkyQHQ93TdBs+SBTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iimiXwhX; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718604438; x=1750140438;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=thTPNNoDXBJ4gDJLDAVKzpHIlZxexyMsW0e4VxTR29U=;
  b=iimiXwhX5QPCqMYpe9/bhx5BltZKMIxCAoLeLGsuICesR85eU0SUQox8
   q2kP0nUiHfp7JINl4Pqgb0yoWh6e5RPQQy6LejbJo9FZ7XUhmSLKD0GH+
   iabN/OXwyWCgp65EmK7Ri5R5AaLstBBdgBKql2JbO1JCFQkZslJQDnRQt
   zJ5lVItFSpfmqpe3OltmWSv9mE7/MaOexlMkrIbLNrc0s9mzf8w4cOlsx
   qEukPJHlNFCIlnkPSPJCJTdG8+Ml/GsnkVkS7NpA1OxZvamOHu/p+HRr3
   cBGNZ71E1X3B8enff6rR3DMLZ+KaoOsUkHA/SvyIdpHDICFG2fJwRER/a
   g==;
X-CSE-ConnectionGUID: 2eVIeemxQeqUQxxDNtSEZg==
X-CSE-MsgGUID: GQsTLzYfSI6Sk7yW6cqfBQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11105"; a="15138452"
X-IronPort-AV: E=Sophos;i="6.08,244,1712646000"; 
   d="scan'208";a="15138452"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2024 23:07:18 -0700
X-CSE-ConnectionGUID: 1REyfH9ZS2O5r5qdoHFBbA==
X-CSE-MsgGUID: lcc0qEOFTJ6x19flLCMnOg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,244,1712646000"; 
   d="scan'208";a="41028170"
Received: from ncintean-mobl1.ger.corp.intel.com (HELO tkristo-desk.intel.com) ([10.245.246.69])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2024 23:07:16 -0700
From: Tero Kristo <tero.kristo@linux.intel.com>
To: hdegoede@redhat.com,
	srinivas.pandruvada@linux.intel.com,
	ilpo.jarvinen@linux.intel.com
Cc: linux-kernel@vger.kernel.org,
	platform-driver-x86@vger.kernel.org
Subject: [PATCH 1/7] platform/x86/intel-uncore-freq: Re-arrange bit masks
Date: Mon, 17 Jun 2024 09:04:34 +0300
Message-ID: <20240617060708.892981-2-tero.kristo@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240617060708.892981-1-tero.kristo@linux.intel.com>
References: <20240617060708.892981-1-tero.kristo@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rename the various bitmasks from the 'UNCORE_GENMASK_*' to
'UNCORE_*_MASK', and re-order them based on the register they reside in.

No functional change intended.

Signed-off-by: Tero Kristo <tero.kristo@linux.intel.com>
Reviewed-by: Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>
---
 .../uncore-frequency/uncore-frequency-tpmi.c  | 25 +++++++++++--------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/drivers/platform/x86/intel/uncore-frequency/uncore-frequency-tpmi.c b/drivers/platform/x86/intel/uncore-frequency/uncore-frequency-tpmi.c
index bb8e72deb354..b58294498921 100644
--- a/drivers/platform/x86/intel/uncore-frequency/uncore-frequency-tpmi.c
+++ b/drivers/platform/x86/intel/uncore-frequency/uncore-frequency-tpmi.c
@@ -69,9 +69,12 @@ struct tpmi_uncore_struct {
 	bool write_blocked;
 };
 
-#define UNCORE_GENMASK_MIN_RATIO	GENMASK_ULL(21, 15)
-#define UNCORE_GENMASK_MAX_RATIO	GENMASK_ULL(14, 8)
-#define UNCORE_GENMASK_CURRENT_RATIO	GENMASK_ULL(6, 0)
+/* Bit definitions for STATUS register */
+#define UNCORE_CURRENT_RATIO_MASK			GENMASK_ULL(6, 0)
+
+/* Bit definitions for CONTROL register */
+#define UNCORE_MAX_RATIO_MASK				GENMASK_ULL(14, 8)
+#define UNCORE_MIN_RATIO_MASK				GENMASK_ULL(21, 15)
 
 /* Helper function to read MMIO offset for max/min control frequency */
 static void read_control_freq(struct tpmi_uncore_cluster_info *cluster_info,
@@ -80,11 +83,11 @@ static void read_control_freq(struct tpmi_uncore_cluster_info *cluster_info,
 	u64 control;
 
 	control = readq(cluster_info->cluster_base + UNCORE_CONTROL_INDEX);
-	*max = FIELD_GET(UNCORE_GENMASK_MAX_RATIO, control) * UNCORE_FREQ_KHZ_MULTIPLIER;
-	*min = FIELD_GET(UNCORE_GENMASK_MIN_RATIO, control) * UNCORE_FREQ_KHZ_MULTIPLIER;
+	*max = FIELD_GET(UNCORE_MAX_RATIO_MASK, control) * UNCORE_FREQ_KHZ_MULTIPLIER;
+	*min = FIELD_GET(UNCORE_MIN_RATIO_MASK, control) * UNCORE_FREQ_KHZ_MULTIPLIER;
 }
 
-#define UNCORE_MAX_RATIO	FIELD_MAX(UNCORE_GENMASK_MAX_RATIO)
+#define UNCORE_MAX_RATIO	FIELD_MAX(UNCORE_MAX_RATIO_MASK)
 
 /* Callback for sysfs read for max/min frequencies. Called under mutex locks */
 static int uncore_read_control_freq(struct uncore_data *data, unsigned int *min,
@@ -134,11 +137,11 @@ static void write_control_freq(struct tpmi_uncore_cluster_info *cluster_info, un
 	control = readq(cluster_info->cluster_base + UNCORE_CONTROL_INDEX);
 
 	if (min_max) {
-		control &= ~UNCORE_GENMASK_MAX_RATIO;
-		control |= FIELD_PREP(UNCORE_GENMASK_MAX_RATIO, input);
+		control &= ~UNCORE_MAX_RATIO_MASK;
+		control |= FIELD_PREP(UNCORE_MAX_RATIO_MASK, input);
 	} else {
-		control &= ~UNCORE_GENMASK_MIN_RATIO;
-		control |= FIELD_PREP(UNCORE_GENMASK_MIN_RATIO, input);
+		control &= ~UNCORE_MIN_RATIO_MASK;
+		control |= FIELD_PREP(UNCORE_MIN_RATIO_MASK, input);
 	}
 
 	writeq(control, (cluster_info->cluster_base + UNCORE_CONTROL_INDEX));
@@ -204,7 +207,7 @@ static int uncore_read_freq(struct uncore_data *data, unsigned int *freq)
 		return -ENODATA;
 
 	status = readq((u8 __iomem *)cluster_info->cluster_base + UNCORE_STATUS_INDEX);
-	*freq = FIELD_GET(UNCORE_GENMASK_CURRENT_RATIO, status) * UNCORE_FREQ_KHZ_MULTIPLIER;
+	*freq = FIELD_GET(UNCORE_CURRENT_RATIO_MASK, status) * UNCORE_FREQ_KHZ_MULTIPLIER;
 
 	return 0;
 }
-- 
2.43.0


