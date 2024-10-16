Return-Path: <linux-kernel+bounces-367830-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 568309A0749
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 12:29:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02E8B1F252B5
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 10:29:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA04D208239;
	Wed, 16 Oct 2024 10:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RSUA5MxZ"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCF7A210C2F;
	Wed, 16 Oct 2024 10:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729074259; cv=none; b=Qkq12YtjMDKrBhEXQE/ubM8fxATvy3RIKs7JiSuKiC+0GwzNLBfjF3YTXIIWXjKQ6yu+B2qcYyqp30/ebraaVU9QxbCL+W0HDBX+9x3+ua+d+D4Q6VTjDNNMP3X8FiCdrnTCvQzBu4ddOMeKfnjqdl55+HHxCLRGb1tPGxgsFys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729074259; c=relaxed/simple;
	bh=aJrKVCeuvpCL/FbgZ8Sr/GttrHpwhSeE/BtJa7KW7u0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mNQ2j6yJoSropS1/UIZUAwCbqtykhOEaanPxrJEdb8IPONR4hystgbnuzac+w2y8gCeZSptDg0jUy9g1LMwVVWEUwrTPe98Fkt+53NxCAEkvi8GKzuB8l3k6VQ5PgRDyFjPBX19PytPdo9k6pzbHFLucJoTcsmJxb0G2bgQp0Xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RSUA5MxZ; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729074258; x=1760610258;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=aJrKVCeuvpCL/FbgZ8Sr/GttrHpwhSeE/BtJa7KW7u0=;
  b=RSUA5MxZWBYesXB2z0zUupaxoQDCQWZG2A1UT6jVrTbdp3fvm2MHqYn9
   diAFTXx+hCaN+1TJhWdprF+mUojUsTDzWLN2HYeCYMTCBdJVyY5VU5az0
   1sxqg7Br+zAKnUdI/GUhdDAtkyHofaDzb7DkisUVBaPQZ6ZKYqDgXopxW
   JAgg82IFQa8nyFhnAZAu2GeffSWUH8x90FK+U84Qrx1nVVBmKltJmfl1M
   pSPMBvtFPTXM8zLokQoFduoF3qjvMER/xolH5vetxC6Pu69fW0ESflBg3
   ezx8Sh1eFZw/r1Oi6iO/u3szK7JqIAGEmL97VdWQeGcwZb+X9g06buh+q
   A==;
X-CSE-ConnectionGUID: Uw5V5RqCT5OwNrgtlGyLkQ==
X-CSE-MsgGUID: 6CI7JaRIQMOFjyFh3vKlyg==
X-IronPort-AV: E=McAfee;i="6700,10204,11226"; a="27985931"
X-IronPort-AV: E=Sophos;i="6.11,207,1725346800"; 
   d="scan'208";a="27985931"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2024 03:24:18 -0700
X-CSE-ConnectionGUID: 73Cl4cYZQEa/hEXzSgG/9w==
X-CSE-MsgGUID: FXeXwmjjR3yzRBsegla9eA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,207,1725346800"; 
   d="scan'208";a="82961016"
Received: from cvapit-mobl1.ger.corp.intel.com (HELO yungchua-desk.intel.com) ([10.247.118.236])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2024 03:24:15 -0700
From: Bard Liao <yung-chuan.liao@linux.intel.com>
To: broonie@kernel.org,
	tiwai@suse.de,
	vkoul@kernel.org
Cc: vinod.koul@linaro.org,
	linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org,
	pierre-louis.bossart@linux.dev,
	bard.liao@intel.com
Subject: [PATCH 09/11] ASoC: sdw_utils: add SmartMic DAI for RT713 VB
Date: Wed, 16 Oct 2024 18:23:31 +0800
Message-ID: <20241016102333.294448-10-yung-chuan.liao@linux.intel.com>
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
dailink: RT713 VA would not use it since it has only 2 endpoints.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Péter Ujfalusi <peter.ujfalusi@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 sound/soc/sdw_utils/soc_sdw_utils.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/sound/soc/sdw_utils/soc_sdw_utils.c b/sound/soc/sdw_utils/soc_sdw_utils.c
index 9fc07731a05b..8196177ff5e7 100644
--- a/sound/soc/sdw_utils/soc_sdw_utils.c
+++ b/sound/soc/sdw_utils/soc_sdw_utils.c
@@ -185,8 +185,15 @@ struct asoc_sdw_codec_info codec_info_list[] = {
 				.widgets = generic_jack_widgets,
 				.num_widgets = ARRAY_SIZE(generic_jack_widgets),
 			},
+			{
+				.direction = {false, true},
+				.dai_name = "rt712-sdca-aif3",
+				.dai_type = SOC_SDW_DAI_TYPE_MIC,
+				.dailink = {SOC_SDW_UNUSED_DAI_ID, SOC_SDW_DMIC_DAI_ID},
+				.rtd_init = asoc_sdw_rt_dmic_rtd_init,
+			},
 		},
-		.dai_num = 1,
+		.dai_num = 2,
 	},
 	{
 		.part_id = 0x1713,
-- 
2.43.0


