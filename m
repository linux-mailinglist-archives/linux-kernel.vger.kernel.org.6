Return-Path: <linux-kernel+bounces-528276-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 864CCA415A9
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 07:48:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94E171896FF1
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 06:47:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED2E824A047;
	Mon, 24 Feb 2025 06:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JT37uG86"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E71BB2475DD;
	Mon, 24 Feb 2025 06:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740379540; cv=none; b=Puu4kuIVseQ4RoB/aBLSFDDGNfnTqrE4p3Uaxx/h8kKFUJbXMKCf6oj3whLNLTFnt0KFkVqyVYReFIp+A77M12bPtfixIF8wG+OKjqwVFBNuWG1n+rVEYwbjQeRvToHACXqf2EFRyf3+5DPHZMHW2WnevlWqNOSJeT1rPbcQjX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740379540; c=relaxed/simple;
	bh=2vXDq7+SgVA2KCvb2xNhw8okvp63e4r2OZttvitqe08=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CgQuZdactQJxEM3txP6qYs1gq+HgnsWstt10i7LEO84DR2MrRy40JmWRWth5piQxZvSfp21fsdupD7ZaB2VgNEnPZsg81gZuG8JMUmjvnWiAEWNaWuCx7vP0H8kPbjjWcVnzVz3d7T6h+lhKX0b4uSAT3aOHrq6wjNHmzavuREw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JT37uG86; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740379539; x=1771915539;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2vXDq7+SgVA2KCvb2xNhw8okvp63e4r2OZttvitqe08=;
  b=JT37uG86oPKbh9LTnGqRN2jkmWoJb9yqX2RVlRU1vxfUuunWNrl/KJzK
   iLTZRXKwfGGKPGzdkWpew4m/w6HYJyXxqML3n9gmTlsqUmaE9hmvqIi7X
   0F6QkoCUKNXjAhy4Oyln5USOmv/x4BFFTlhPCH11FWew5/gafg69INbjE
   q/iIKV+VdgF/oXPG+FSUpwWadCIjMhKTeTrBikCHUiPCzD+NRX1vpWgqo
   ul1vzSp+R5ZPP11kHZXlgT891VILTQBIT8nvkXYVeJTflVkQ+nfo4WF60
   jfBXXS1YBg7z+THH0uwBBonG7wxNHyhCaGVwM1lu9eRcGkOGDoSBqG9aM
   w==;
X-CSE-ConnectionGUID: AKYHmGL6TaKghMmv5tdEKQ==
X-CSE-MsgGUID: F9sGyvf8TjymjPlmKVd+RA==
X-IronPort-AV: E=McAfee;i="6700,10204,11354"; a="58538983"
X-IronPort-AV: E=Sophos;i="6.13,309,1732608000"; 
   d="scan'208";a="58538983"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2025 22:45:37 -0800
X-CSE-ConnectionGUID: TbpLUdrsRC2tnLGcLAguPg==
X-CSE-MsgGUID: 4Y4dYBloSMy6QGpiyUBaZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,309,1732608000"; 
   d="scan'208";a="120597743"
Received: from ssimmeri-mobl2.amr.corp.intel.com (HELO yungchua-desk.intel.com) ([10.124.222.232])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2025 22:45:36 -0800
From: Bard Liao <yung-chuan.liao@linux.intel.com>
To: linux-sound@vger.kernel.org,
	broonie@kernel.org,
	tiwai@suse.de,
	vkoul@kernel.org
Cc: vinod.koul@linaro.org,
	linux-kernel@vger.kernel.org,
	pierre-louis.bossart@linux.dev,
	bard.liao@intel.com
Subject: [PATCH v2 12/16] soundwire: intel: add BPT context definition
Date: Mon, 24 Feb 2025 14:44:46 +0800
Message-ID: <20250224064451.33772-13-yung-chuan.liao@linux.intel.com>
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

This is needed to be shared between open/send_async/close.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Reviewed-by: Péter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Liam Girdwood <liam.r.girdwood@intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
---
 drivers/soundwire/intel.h | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/soundwire/intel.h b/drivers/soundwire/intel.h
index dddd29381441..d44e70d3c4e3 100644
--- a/drivers/soundwire/intel.h
+++ b/drivers/soundwire/intel.h
@@ -48,11 +48,34 @@ struct sdw_intel_link_res {
 	struct hdac_bus *hbus;
 };
 
+/**
+ * struct sdw_intel_bpt - SoundWire Intel BPT context
+ * @bpt_tx_stream: BPT TX stream
+ * @dmab_tx_bdl: BPT TX buffer descriptor list
+ * @bpt_rx_stream: BPT RX stream
+ * @dmab_rx_bdl: BPT RX buffer descriptor list
+ * @pdi0_buffer_size: PDI0 buffer size
+ * @pdi1_buffer_size: PDI1 buffer size
+ * @num_frames: number of frames
+ * @data_per_frame: data per frame
+ */
+struct sdw_intel_bpt {
+	struct hdac_ext_stream *bpt_tx_stream;
+	struct snd_dma_buffer dmab_tx_bdl;
+	struct hdac_ext_stream *bpt_rx_stream;
+	struct snd_dma_buffer dmab_rx_bdl;
+	unsigned int pdi0_buffer_size;
+	unsigned int pdi1_buffer_size;
+	unsigned int num_frames;
+	unsigned int data_per_frame;
+};
+
 struct sdw_intel {
 	struct sdw_cdns cdns;
 	int instance;
 	struct sdw_intel_link_res *link_res;
 	bool startup_done;
+	struct sdw_intel_bpt bpt_ctx;
 #ifdef CONFIG_DEBUG_FS
 	struct dentry *debugfs;
 #endif
-- 
2.43.0


