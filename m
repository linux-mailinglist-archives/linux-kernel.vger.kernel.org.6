Return-Path: <linux-kernel+bounces-536113-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 74690A47B99
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 12:15:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88787189150D
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 11:14:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1FAF22F3BA;
	Thu, 27 Feb 2025 11:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ng758FbG"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7206022F388;
	Thu, 27 Feb 2025 11:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740654729; cv=none; b=MRndXf59A+TFaIRIqtJcE3+HzrVbDaj3ldHNx666K5JPVdZlYd0QTqQBcS5zVnxV/hrFgW4jN7a22BKuwpcZEof+fChOFvaNcARauogch/5cEy6Wn83WWkJ4gehl9WhGANfa8hFDZMJ6xZbP5D+6t5r89UF0rudxeYYtOQtMLMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740654729; c=relaxed/simple;
	bh=2vXDq7+SgVA2KCvb2xNhw8okvp63e4r2OZttvitqe08=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OdfSpGrna2+J6RJbattesqV6TmN8lzVuD/Io1ZJ7M5w77BrcF7azW18wwlq0M0BuSiYUdQZt/rkPTI+zo0Et8yjQ2mNfmGQDUoI4z5GqqUzyDoFdKqNaJOF97UKzUQmD6JaKJmb16ImNhOS089DI81L63lB+X3KZhliIS05rsAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ng758FbG; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740654727; x=1772190727;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2vXDq7+SgVA2KCvb2xNhw8okvp63e4r2OZttvitqe08=;
  b=Ng758FbGUV3Iabdt/ooYatoNU6Obsv693V8iWD9mO81XudsmHvs05QH7
   nsq6bLXJ5UFv4csvG/Uyxua8klN8XLsHrJ8f3h6RwCQr4TqsZAbIQzTwH
   FJXO9+g+i9G/ryUN8kfneZToaxMO3rEA8hxpIH7m4GMGXeMW3MSSBja3C
   LOl1fURjEZ7Fze/I2cdvD7vTEJP+G1U52OnGSMwugdNZOzeVGMbFNJ1tw
   US+DXFa+upjU5XC5vdA+Kk5QqcU/6DRcsQrYjCtEHZOIU4A+DIMQ28fxK
   Y2gdwNaHrTHyNDkJZNr9azBtrYQ1Y3Etwp0YGX6xJYZVVSxEwQFP7snyC
   w==;
X-CSE-ConnectionGUID: 3ifbbnHMSZGsQvaTP2MIkg==
X-CSE-MsgGUID: DiH3L7B+SQOaz1ICje7Zgg==
X-IronPort-AV: E=McAfee;i="6700,10204,11357"; a="45189881"
X-IronPort-AV: E=Sophos;i="6.13,319,1732608000"; 
   d="scan'208";a="45189881"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2025 03:12:06 -0800
X-CSE-ConnectionGUID: fUXFgi3bQIq1ClMlpIkM9w==
X-CSE-MsgGUID: P+IN5HrQTm6Sp+vNbgfI1g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="154179032"
Received: from johunt-mobl9.ger.corp.intel.com (HELO yungchua-desk.intel.com) ([10.124.220.110])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2025 03:12:04 -0800
From: Bard Liao <yung-chuan.liao@linux.intel.com>
To: linux-sound@vger.kernel.org,
	broonie@kernel.org,
	tiwai@suse.de,
	vkoul@kernel.org
Cc: vinod.koul@linaro.org,
	linux-kernel@vger.kernel.org,
	pierre-louis.bossart@linux.dev,
	bard.liao@intel.com
Subject: [PATCH v3 12/16] soundwire: intel: add BPT context definition
Date: Thu, 27 Feb 2025 19:11:25 +0800
Message-ID: <20250227111130.272698-13-yung-chuan.liao@linux.intel.com>
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


