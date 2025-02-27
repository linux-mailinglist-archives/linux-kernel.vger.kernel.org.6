Return-Path: <linux-kernel+bounces-536118-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D851AA47BB2
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 12:17:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD81F3B18BD
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 11:15:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37CC7231A36;
	Thu, 27 Feb 2025 11:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="D8mX3Dyb"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CBA223099F;
	Thu, 27 Feb 2025 11:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740654736; cv=none; b=UzGFFItMG15KADwXjRgJwyYuqRh90o2v1f8Dmn/ns+axuFavgWRHWQMK8x6931BZSXgNhi9WYkIcFmTiljdjYaD+vbMtvt+jNqzuflZe/5WsqvqLrtjZNedH/iHFTtWSBvePlAU85nFlRSQh+W04DRv9/8aJowvIxrY7cepXXb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740654736; c=relaxed/simple;
	bh=goZDLHvWODKwCst2CM1CW/pL0JVHaP6YCWm3xiQc4VU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H9BBVnEgSvLnaRXBxPcd0ymsKARbDYYTTlpgChLE2TFQZTu30k4miYFm9jP4GGJAi6HMkJceVy1tPCaQ7uB/cuIDjoO3c1iZfqaAbGS06R99PlDl4Op+BeUI6ScBgNE1siaQqTIN/Sr3dMEQiWQaxqcKhbpPJLmj0LtM2+1DCdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=D8mX3Dyb; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740654735; x=1772190735;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=goZDLHvWODKwCst2CM1CW/pL0JVHaP6YCWm3xiQc4VU=;
  b=D8mX3Dyby+Pwbj0f+DTRcb6iE2orXcgO6kvoOLk8gaW4JRhyjLn3rEmH
   pgoJam2oenKDs3K+lSChD/9drWP1An04yErQKYWrKU7hG6PDdYPGvIc1q
   5P7k3LuBLn5BxqxJQ9YhOdSubth+WFHmVRx+vwDuLL/L0aRPLkatlFNXi
   0YDJkF27AG6sd/ZH13exXOXc9JKzY4fMMctd8HweDa1wtOw0yPc0PIIIH
   1zmmU+ICWAzISwqS3cf9HTFqhvNmZlbfaL2yTFg3TyvRgfXg2kPWlkeaI
   82kTox2yIMOROTR2wH/tzAihObLqK4cWwrH57xPJeUCWfwr7Yn+AcGDND
   g==;
X-CSE-ConnectionGUID: GT3mApu7Q8CeszSey2ZiVQ==
X-CSE-MsgGUID: 5myswXPnTx29m4lfRykDYA==
X-IronPort-AV: E=McAfee;i="6700,10204,11357"; a="45189916"
X-IronPort-AV: E=Sophos;i="6.13,319,1732608000"; 
   d="scan'208";a="45189916"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2025 03:12:15 -0800
X-CSE-ConnectionGUID: rOcDuwchRNGPzT9qRZT4FA==
X-CSE-MsgGUID: iP4wvjr6TGm2dvXJD6umJA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="154179052"
Received: from johunt-mobl9.ger.corp.intel.com (HELO yungchua-desk.intel.com) ([10.124.220.110])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2025 03:12:13 -0800
From: Bard Liao <yung-chuan.liao@linux.intel.com>
To: linux-sound@vger.kernel.org,
	broonie@kernel.org,
	tiwai@suse.de,
	vkoul@kernel.org
Cc: vinod.koul@linaro.org,
	linux-kernel@vger.kernel.org,
	pierre-louis.bossart@linux.dev,
	bard.liao@intel.com
Subject: [PATCH v3 16/16] ASoC: rt711-sdca: add DP0 support
Date: Thu, 27 Feb 2025 19:11:29 +0800
Message-ID: <20250227111130.272698-17-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250227111130.272698-1-yung-chuan.liao@linux.intel.com>
References: <20250227111130.272698-1-yung-chuan.liao@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>

DP0 is required for BPT/BRA transport.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Reviewed-by: Péter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Liam Girdwood <liam.r.girdwood@intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
---
 sound/soc/codecs/rt711-sdca-sdw.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/sound/soc/codecs/rt711-sdca-sdw.c b/sound/soc/codecs/rt711-sdca-sdw.c
index f5933d2e085e..e87e2e1bfff7 100644
--- a/sound/soc/codecs/rt711-sdca-sdw.c
+++ b/sound/soc/codecs/rt711-sdca-sdw.c
@@ -225,6 +225,14 @@ static int rt711_sdca_read_prop(struct sdw_slave *slave)
 		j++;
 	}
 
+	prop->dp0_prop = devm_kzalloc(&slave->dev, sizeof(*prop->dp0_prop),
+				      GFP_KERNEL);
+	if (!prop->dp0_prop)
+		return -ENOMEM;
+
+	prop->dp0_prop->simple_ch_prep_sm = true;
+	prop->dp0_prop->ch_prep_timeout = 10;
+
 	/* set the timeout values */
 	prop->clk_stop_timeout = 700;
 
-- 
2.43.0


