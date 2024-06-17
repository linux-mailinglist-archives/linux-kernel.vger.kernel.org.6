Return-Path: <linux-kernel+bounces-216715-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A26490A4F4
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 08:14:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 127F41C25DBD
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 06:14:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC040195F10;
	Mon, 17 Jun 2024 06:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kVlMDws8"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA6DE188CC7;
	Mon, 17 Jun 2024 06:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718604442; cv=none; b=k4Trf+1qi0xYBA/bMy9iEqhysSdST0hyNykzUVxZY5PLzVgrCgW43TWkG8asaAPYGUjGmpgr8SSnO5OrSiGcXpbth+6pUN1n0OB/ghZwonTOeKZHAop3jFNn2ugY1/RX9IzVEywdO4iC6kV5H8K8xl4IX+pKApuZiC1XLRIFVHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718604442; c=relaxed/simple;
	bh=FwSM0Ml2UAKEaoJy//4ZNW1Z1iaemOizowCezp2jhk8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XR6/BZWfLNm1BS7w8iElhDSMyWPkgTUSbYLnekk08bOnqUfYP5V84w0T9LT0m9WoG5O4Z0Ey3fcJEv5/G+38+D7iiYr9HmC+KtqueliOCHR+mHDGpVYIynPaJGGUS6utOmu4Q3wpVgCneiwFNL9LlbLlYmiYfzGi7chCWcUDd/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kVlMDws8; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718604441; x=1750140441;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FwSM0Ml2UAKEaoJy//4ZNW1Z1iaemOizowCezp2jhk8=;
  b=kVlMDws8KdOPPzN721c4B72FM7ODiUZinDXixJ1BAMsYxAyqJ1+Srxhq
   f/8dIyRpVjHGOcWTmYeTFTs+V4Ed63Rnl3jtRIXqUUT1Pm9GSUSdpUh46
   jihaFwaCy68PO02Suqwzk50wxKWkIs6uAjvBbw3OFkICM++igzbHSEMtg
   vzhKzSiXhcEpb7f7z1AzALV9FtDwPdWjd1ing+tkiWrhQb7FfI7gUOmuS
   7l3vUy5Naje4ZMRjRW5zfA4dprwCwMtdMvdAfWn2xqiOV9nX40cgXkj/F
   DRDzuIVQY6VpHRflv5LYse8Y1TfadkGyGaaP+9wfAKNa5K8rjHUgIK5Yy
   A==;
X-CSE-ConnectionGUID: U0/evHI6QeWBgU3NSClZJw==
X-CSE-MsgGUID: MbDdys0IQtesAfmJlWPiTw==
X-IronPort-AV: E=McAfee;i="6700,10204,11105"; a="15138456"
X-IronPort-AV: E=Sophos;i="6.08,244,1712646000"; 
   d="scan'208";a="15138456"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2024 23:07:20 -0700
X-CSE-ConnectionGUID: InvK7KtlQqidhyDFWLYNRw==
X-CSE-MsgGUID: 0VxYLw3KQVSnml7IrkUMqA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,244,1712646000"; 
   d="scan'208";a="41028173"
Received: from ncintean-mobl1.ger.corp.intel.com (HELO tkristo-desk.intel.com) ([10.245.246.69])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2024 23:07:18 -0700
From: Tero Kristo <tero.kristo@linux.intel.com>
To: hdegoede@redhat.com,
	srinivas.pandruvada@linux.intel.com,
	ilpo.jarvinen@linux.intel.com
Cc: linux-kernel@vger.kernel.org,
	platform-driver-x86@vger.kernel.org
Subject: [PATCH 2/7] platform/x86/intel-uncore-freq: Get rid of magic values
Date: Mon, 17 Jun 2024 09:04:35 +0300
Message-ID: <20240617060708.892981-3-tero.kristo@linux.intel.com>
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

Get rid of any magic bitmasks from the code. Define proper macros for
these, and use the bitfield operations to access them.

No functional change intended.

Signed-off-by: Tero Kristo <tero.kristo@linux.intel.com>
---
 .../intel/uncore-frequency/uncore-frequency.c | 22 ++++++++++++-------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/drivers/platform/x86/intel/uncore-frequency/uncore-frequency.c b/drivers/platform/x86/intel/uncore-frequency/uncore-frequency.c
index b89c0dda9e5d..d3fdae695bbd 100644
--- a/drivers/platform/x86/intel/uncore-frequency/uncore-frequency.c
+++ b/drivers/platform/x86/intel/uncore-frequency/uncore-frequency.c
@@ -14,6 +14,7 @@
  * Author: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
  */
 
+#include <linux/bitfield.h>
 #include <linux/cpu.h>
 #include <linux/module.h>
 #include <linux/slab.h>
@@ -36,6 +37,11 @@ static enum cpuhp_state uncore_hp_state __read_mostly;
 #define MSR_UNCORE_PERF_STATUS	0x621
 #define UNCORE_FREQ_KHZ_MULTIPLIER	100000
 
+#define UNCORE_MAX_RATIO_MASK	GENMASK_ULL(6, 0)
+#define UNCORE_MIN_RATIO_MASK	GENMASK_ULL(14, 8)
+
+#define UNCORE_CURRENT_RATIO_MASK	GENMASK_ULL(6, 0)
+
 static int uncore_read_control_freq(struct uncore_data *data, unsigned int *min,
 				    unsigned int *max)
 {
@@ -49,8 +55,8 @@ static int uncore_read_control_freq(struct uncore_data *data, unsigned int *min,
 	if (ret)
 		return ret;
 
-	*max = (cap & 0x7F) * UNCORE_FREQ_KHZ_MULTIPLIER;
-	*min = ((cap & GENMASK(14, 8)) >> 8) * UNCORE_FREQ_KHZ_MULTIPLIER;
+	*max = FIELD_GET(UNCORE_MAX_RATIO_MASK, cap) * UNCORE_FREQ_KHZ_MULTIPLIER;
+	*min = FIELD_GET(UNCORE_MIN_RATIO_MASK, cap) * UNCORE_FREQ_KHZ_MULTIPLIER;
 
 	return 0;
 }
@@ -62,7 +68,7 @@ static int uncore_write_control_freq(struct uncore_data *data, unsigned int inpu
 	u64 cap;
 
 	input /= UNCORE_FREQ_KHZ_MULTIPLIER;
-	if (!input || input > 0x7F)
+	if (!input || input > FIELD_MAX(UNCORE_MAX_RATIO_MASK))
 		return -EINVAL;
 
 	if (data->control_cpu < 0)
@@ -73,11 +79,11 @@ static int uncore_write_control_freq(struct uncore_data *data, unsigned int inpu
 		return ret;
 
 	if (min_max) {
-		cap &= ~0x7F;
-		cap |= input;
+		cap &= ~UNCORE_MAX_RATIO_MASK;
+		cap |= FIELD_PREP(UNCORE_MAX_RATIO_MASK, input);
 	} else  {
-		cap &= ~GENMASK(14, 8);
-		cap |= (input << 8);
+		cap &= ~UNCORE_MIN_RATIO_MASK;
+		cap |= FIELD_PREP(UNCORE_MIN_RATIO_MASK, input);
 	}
 
 	ret = wrmsrl_on_cpu(data->control_cpu, MSR_UNCORE_RATIO_LIMIT, cap);
@@ -101,7 +107,7 @@ static int uncore_read_freq(struct uncore_data *data, unsigned int *freq)
 	if (ret)
 		return ret;
 
-	*freq = (ratio & 0x7F) * UNCORE_FREQ_KHZ_MULTIPLIER;
+	*freq = FIELD_GET(UNCORE_CURRENT_RATIO_MASK, ratio) * UNCORE_FREQ_KHZ_MULTIPLIER;
 
 	return 0;
 }
-- 
2.43.0


