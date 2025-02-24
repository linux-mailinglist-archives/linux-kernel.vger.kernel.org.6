Return-Path: <linux-kernel+bounces-528281-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 652ABA415AE
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 07:49:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2236C189921B
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 06:48:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EE1724BC10;
	Mon, 24 Feb 2025 06:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="A0EMSkvV"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D9EA24BC0B;
	Mon, 24 Feb 2025 06:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740379547; cv=none; b=rLvKJ8lWQeCev3fLLsLPaNwMSjEn+oTS+5mavell9DctBpaJnZ1EUTYMej1mGNbK94sjc/K18kASRA7IWMWMAXRvs/5oL6wAx7IBYpzzWTPAT2PkQVR0T8uWpJHVMjJ9/SjO0VYIzUqiAxalV7iD80jIyE3FOOPQQvPP0qvxA6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740379547; c=relaxed/simple;
	bh=goZDLHvWODKwCst2CM1CW/pL0JVHaP6YCWm3xiQc4VU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s7We/Jq+AV1IQvyB8v5s2U9Yff7EXEoOm7PmV9ILaRKX/JpNMIEajf+ytgY3oWVi7cgZJvE/GA73v5qHOliKAoIGqu7/EvF7FxIXlrbsf8Gx2Xp14W8NFy6v7HPYqHax+VfcYDgY21MQ+bmCUf95a7z7d/BAFXLGeUsB6Yvz7Gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=A0EMSkvV; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740379546; x=1771915546;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=goZDLHvWODKwCst2CM1CW/pL0JVHaP6YCWm3xiQc4VU=;
  b=A0EMSkvVDB9dg3kfA4Tvlr9qqrp0gIHG21XUA8Q/oszNKzdKqy7c2a2M
   W9VoEeLhbWka5SE3hQKrNezpK3rmwnY7ig2JEZL2LNQjaYbCX0Kp33qiC
   1fswbufPG+2WlDN5JjTx0StRlNTHpKSgXMl2SCTcpNU8Kue+FeuNHA0Qw
   QEiyeQB0pdR5UwndDJM0CgLARAHtFNqxNeXwQv7S10/s5ALj+zSjcqoF1
   mQ1qrq/Fo8qk7uoOA+1vrC4CD4+Ab8PpgPtxjDjPMoAqeRomTEVjOgQx1
   SjvoOwE4WLvwBNd0/zJtxpF7U9+RVLc5MnSmd6yOFrqq6VhO2DgXZ1w+9
   Q==;
X-CSE-ConnectionGUID: 3XR6j0jpSH2URwUDkEN+hw==
X-CSE-MsgGUID: v6oXg7NfQdCIaKx1A+YhLQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11354"; a="58539005"
X-IronPort-AV: E=Sophos;i="6.13,309,1732608000"; 
   d="scan'208";a="58539005"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2025 22:45:44 -0800
X-CSE-ConnectionGUID: Hltnk+N9TcKZ3XpdyEqzcA==
X-CSE-MsgGUID: rv1wvSlSQ3WfHosguoOkIQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,309,1732608000"; 
   d="scan'208";a="120597762"
Received: from ssimmeri-mobl2.amr.corp.intel.com (HELO yungchua-desk.intel.com) ([10.124.222.232])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2025 22:45:42 -0800
From: Bard Liao <yung-chuan.liao@linux.intel.com>
To: linux-sound@vger.kernel.org,
	broonie@kernel.org,
	tiwai@suse.de,
	vkoul@kernel.org
Cc: vinod.koul@linaro.org,
	linux-kernel@vger.kernel.org,
	pierre-louis.bossart@linux.dev,
	bard.liao@intel.com
Subject: [PATCH v2 16/16] ASoC: rt711-sdca: add DP0 support
Date: Mon, 24 Feb 2025 14:44:50 +0800
Message-ID: <20250224064451.33772-17-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250224064451.33772-1-yung-chuan.liao@linux.intel.com>
References: <20250224064451.33772-1-yung-chuan.liao@linux.intel.com>
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


