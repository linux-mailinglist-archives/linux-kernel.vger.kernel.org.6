Return-Path: <linux-kernel+bounces-536528-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDD92A480A1
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 15:12:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 58F7B7A1EFE
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 14:11:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 759A024169B;
	Thu, 27 Feb 2025 14:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DbcnPFsB"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DA6B23C8AA;
	Thu, 27 Feb 2025 14:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740665227; cv=none; b=cWM1fNsT5gfMJHbdVviDcUcKfMQf5fqdDvd3ZTxqqcEl7jIw+eXO+iPrgU3j/IxWJUPy4E+piRTnwqMOmq24/sLTTZBNAUdHOyqNQRJL1eN/jM2U0V6XhoUcbpWLkNLGeIwI0Nxhk+my/LN1MFr3Kwcq3NYdCp1NAYM8bSEWZRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740665227; c=relaxed/simple;
	bh=2vXDq7+SgVA2KCvb2xNhw8okvp63e4r2OZttvitqe08=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WoHYjbzhgRfl/5VzYRL3Rs0uCpsnZYe10disqUcaDYNqUppXJJMFtcv8FxPXBGaX6m+N88o1wu4xVNzHM+lQj1C5dY4nl5tTHP6uTHo5ug1MX/c88YbqkhN/AiwjCecBWkxbfcfbQ2b1z6rthoL9NX9gBEUjKjrvY23onPdLHas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DbcnPFsB; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740665226; x=1772201226;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2vXDq7+SgVA2KCvb2xNhw8okvp63e4r2OZttvitqe08=;
  b=DbcnPFsB14xhO2utA57GaTg/0+qoFEX7iIh2H/YkT4oIh9Xsuol5mD4s
   7bHpbl5ORuR5vpqb/tttRSF+2U5QQEa5099UrUCeg+BcMGlNAwK8dAPtQ
   VD63b6E5qzLAWn5IWadjeCDYMRmeUE7zRwnU9TJHqlsuUVHm6rU55GQS0
   Q/18qPWkO5fwsSoqqPd5JeIK6WUGvn9/uziK581jF8/ZfsZfaPx5fyvYi
   /i9vyTeQTOeh7uUiEJZXiMJRSC5MZRPHdSfVht4LbA1yM/ZTZUIHxX4jx
   50N4N8f6SpsMRonT62oap9l8Ny0W9cMzRIMSdd8DSYgAFltp7+30NX2Df
   Q==;
X-CSE-ConnectionGUID: YVJTEtlhSF+PF42tmxUV1A==
X-CSE-MsgGUID: zOY6KnU6QyqG7//42ieiJg==
X-IronPort-AV: E=McAfee;i="6700,10204,11358"; a="41438095"
X-IronPort-AV: E=Sophos;i="6.13,319,1732608000"; 
   d="scan'208";a="41438095"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2025 06:06:52 -0800
X-CSE-ConnectionGUID: Lpntc/5PREytDo21JnwR0g==
X-CSE-MsgGUID: KS5kKneoQg+0v5GTqMNU/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,319,1732608000"; 
   d="scan'208";a="116831716"
Received: from ssimmeri-mobl2.amr.corp.intel.com (HELO yungchua-desk.intel.com) ([10.124.220.154])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2025 06:06:50 -0800
From: Bard Liao <yung-chuan.liao@linux.intel.com>
To: linux-sound@vger.kernel.org,
	broonie@kernel.org,
	tiwai@suse.de,
	vkoul@kernel.org
Cc: vinod.koul@linaro.org,
	linux-kernel@vger.kernel.org,
	pierre-louis.bossart@linux.dev,
	bard.liao@intel.com
Subject: [PATCH v4 12/16] soundwire: intel: add BPT context definition
Date: Thu, 27 Feb 2025 22:06:11 +0800
Message-ID: <20250227140615.8147-13-yung-chuan.liao@linux.intel.com>
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


