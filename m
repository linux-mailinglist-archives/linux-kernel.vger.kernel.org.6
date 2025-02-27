Return-Path: <linux-kernel+bounces-536532-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49B7AA480AF
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 15:14:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79DEC3A3746
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 14:13:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14C6C24338F;
	Thu, 27 Feb 2025 14:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cKWNtwWF"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FCBD2417C8;
	Thu, 27 Feb 2025 14:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740665230; cv=none; b=sj+RjvR4LCaYSRMWCFSF/JoDJU1SZoR9O2eaIes0kDJDFMVPqoHrKtc8zOqbFi7iEJW8UJiQNJaZoRmYVi5DHAq3M8KTC3Rr6hlX4qoq3BTk2glGm9kEhWF8y4ROcssrO5DEc8lvbvtgY3vJnl2lPMBnfjTxnz/oyMvQBIrX1dI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740665230; c=relaxed/simple;
	bh=goZDLHvWODKwCst2CM1CW/pL0JVHaP6YCWm3xiQc4VU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kE8vZTwJRT3txsJ2rpegKmiOGx+F8VCDUP2qONV4PGFfs3NoJxd2NrqqDKHBTbcFyuFmbx0Q/KTtjoVdCaQ14OqK7znjtaBeiFqQ9mtcnjTVK9+FYadQhNuIJaqLjOCrgLqrKBdm7sl5P2GFA/TzaxATIvyrKm3g66Ut1Z6jigk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cKWNtwWF; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740665229; x=1772201229;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=goZDLHvWODKwCst2CM1CW/pL0JVHaP6YCWm3xiQc4VU=;
  b=cKWNtwWFp3uRjZvCB2JCXumnWgX/En+skFCZMb8rfrJpo3tTjGWifpWP
   4SjwLSNzUfUlOykg6LI8v+bngRCRk7LL/8aFQPvyysm/vYgmLQBMCP82T
   v7yH2xQ82x+Z7/gqkW0W34GpQLBB5Tonfk5XlTEMEdk//Yr8WmvIbfY4q
   o+eFlaY6jnkDsir0xGHy37i9D6vclOyDNK3Kw0XRf9gR3nmfN/cUuTFcN
   fQBVFHi7d4571z0Nh2QPJxpW4zuRiu6FPDoz1pcLcpXQ44Xw+jKnlocua
   1XQQQ7hgrytCv6KHQAdtL79fpaW9BJLLbBrupirtIQtugc4lfwUv13ov4
   A==;
X-CSE-ConnectionGUID: vOrBLuzJRdy8jZZbsoBlRg==
X-CSE-MsgGUID: HSJs5alzTXKaIBA2mD5W3w==
X-IronPort-AV: E=McAfee;i="6700,10204,11358"; a="41438120"
X-IronPort-AV: E=Sophos;i="6.13,319,1732608000"; 
   d="scan'208";a="41438120"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2025 06:07:00 -0800
X-CSE-ConnectionGUID: VMW8zrYCQHKWLJsjtbC5hQ==
X-CSE-MsgGUID: qx3XXiPBQLGBUROwW1nV9A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,319,1732608000"; 
   d="scan'208";a="116831792"
Received: from ssimmeri-mobl2.amr.corp.intel.com (HELO yungchua-desk.intel.com) ([10.124.220.154])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2025 06:06:58 -0800
From: Bard Liao <yung-chuan.liao@linux.intel.com>
To: linux-sound@vger.kernel.org,
	broonie@kernel.org,
	tiwai@suse.de,
	vkoul@kernel.org
Cc: vinod.koul@linaro.org,
	linux-kernel@vger.kernel.org,
	pierre-louis.bossart@linux.dev,
	bard.liao@intel.com
Subject: [PATCH v4 16/16] ASoC: rt711-sdca: add DP0 support
Date: Thu, 27 Feb 2025 22:06:15 +0800
Message-ID: <20250227140615.8147-17-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250227140615.8147-1-yung-chuan.liao@linux.intel.com>
References: <20250227140615.8147-1-yung-chuan.liao@linux.intel.com>
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


