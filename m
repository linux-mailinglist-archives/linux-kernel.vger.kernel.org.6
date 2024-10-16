Return-Path: <linux-kernel+bounces-367829-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 288A89A0748
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 12:28:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D23561F215C7
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 10:28:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C51F1210C1A;
	Wed, 16 Oct 2024 10:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SF1cu3yu"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC2F02101B5;
	Wed, 16 Oct 2024 10:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729074256; cv=none; b=fuN6bODBxecEbri4f90uBfwM6SvevW29u82ORuzyFX+QhCeUqfTwtkcbOOOvfHC7Eush5oiutwwiqwWYEjm40O63DaIlsup3QPePARnk0n5LlsleBrOiVq1xuNQkYjHVSP9l9lkhc9iS4DKYpzxCP1BcrYs/dVfFjUUFIMejRNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729074256; c=relaxed/simple;
	bh=vr/oL273acBCaJMtolC7CXyVZDTAOm/tQGUnqwMQ4Cw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ibjnD2R/SOw178fI7VWw0GUYD19Q57gxC+dnE5Bsop04CuHpa8azy7sL9KIkdtiaoolx1ZDz+VjnHj1b6KgCBxHmvjYxPWNQt+lPUOTiCSf77JgUMDEosmBQej8H614hEKkxOVZSAPGy5FWEKg5idJyHBUyx+4TPel8zaDt56fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SF1cu3yu; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729074255; x=1760610255;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vr/oL273acBCaJMtolC7CXyVZDTAOm/tQGUnqwMQ4Cw=;
  b=SF1cu3yuxD8yiY0OFnBdQ0e2CWhjenWQl3cgb++zZyH2rtxWGnoTd9yT
   Y7wR2AzCtbd2bdriEvtoyBWXf3au57DIYlpeuI8k7s7JEE4AqU/17Wlwv
   TqsXP8jWCNpAXB3H3N1ebrvqTNUpgWRIMYWbdiA4xkeCu2If4CqOBZs1W
   NLT7R0pz64OFP3kKlHJEGF7DAcJ7gCk4s/VcfW6nVPnHOsisHUBBsg9vN
   0XWpKOISnF4f3PudKtbty8bKOaT7A0E8rdtfn9HlDZ5VzojzGmw3JXC2s
   vplfzBHRAA7hWCQr0WNi8u8+E85WVp9vXg7MsH8Kyk6Z/UHgLGhUwegG2
   w==;
X-CSE-ConnectionGUID: ndaaJiGsRKmPevMdfHjnlg==
X-CSE-MsgGUID: SVNREGFjT3SM3xNet6xxBQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11226"; a="27985925"
X-IronPort-AV: E=Sophos;i="6.11,207,1725346800"; 
   d="scan'208";a="27985925"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2024 03:24:15 -0700
X-CSE-ConnectionGUID: azL7BDqiS5urRvF5McYGtQ==
X-CSE-MsgGUID: A5pgsrcCRi6CJEJV5YZSZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,207,1725346800"; 
   d="scan'208";a="82961005"
Received: from cvapit-mobl1.ger.corp.intel.com (HELO yungchua-desk.intel.com) ([10.247.118.236])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2024 03:24:12 -0700
From: Bard Liao <yung-chuan.liao@linux.intel.com>
To: broonie@kernel.org,
	tiwai@suse.de,
	vkoul@kernel.org
Cc: vinod.koul@linaro.org,
	linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org,
	pierre-louis.bossart@linux.dev,
	bard.liao@intel.com
Subject: [PATCH 08/11] ASoC: sdw_utils: add SmartMic DAI for RT712 VB
Date: Wed, 16 Oct 2024 18:23:30 +0800
Message-ID: <20241016102333.294448-9-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241016102333.294448-1-yung-chuan.liao@linux.intel.com>
References: <20241016102333.294448-1-yung-chuan.liao@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

In theory the dailinks are created based on the number of endpoints
reported in ACPI match tables, so it should harmless to add a new
dailink: RT712 VA would not use it since it has only 2 endpoints.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Péter Ujfalusi <peter.ujfalusi@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 sound/soc/sdw_utils/soc_sdw_utils.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/sound/soc/sdw_utils/soc_sdw_utils.c b/sound/soc/sdw_utils/soc_sdw_utils.c
index 6f6bff0f69fc..9fc07731a05b 100644
--- a/sound/soc/sdw_utils/soc_sdw_utils.c
+++ b/sound/soc/sdw_utils/soc_sdw_utils.c
@@ -144,8 +144,15 @@ struct asoc_sdw_codec_info codec_info_list[] = {
 				.widgets = generic_spk_widgets,
 				.num_widgets = ARRAY_SIZE(generic_spk_widgets),
 			},
+			{
+				.direction = {false, true},
+				.dai_name = "rt712-sdca-aif3",
+				.dai_type = SOC_SDW_DAI_TYPE_MIC,
+				.dailink = {SOC_SDW_UNUSED_DAI_ID, SOC_SDW_DMIC_DAI_ID},
+				.rtd_init = asoc_sdw_rt_dmic_rtd_init,
+			},
 		},
-		.dai_num = 2,
+		.dai_num = 3,
 	},
 	{
 		.part_id = 0x1712,
-- 
2.43.0


