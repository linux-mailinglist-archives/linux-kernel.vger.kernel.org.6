Return-Path: <linux-kernel+bounces-429523-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75B569E1E3E
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 14:53:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 23C3CB3676F
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 13:19:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F6361EF0AA;
	Tue,  3 Dec 2024 13:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Bhb3NnYN"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E6AD1F12EB;
	Tue,  3 Dec 2024 13:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733231914; cv=none; b=iOVj0aYkUoGoRAJOuxyjTflc1hNNgwGRuahYg97CrkEicoVRhfu8QlrI0JL5+fBAVCc6dgw/+BVMyG1q4DivOrsWqiA6io3cd/Sc2v/eqdEY9F+ZZKKnEfWK8zuqsepVo5FYnTJBxOEOiYt9Bp/fI0FC9Db2KBakRyG4BUnB/nM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733231914; c=relaxed/simple;
	bh=Q7maksDBaLIIDrKSJZH4DRQa93S4eVVppMEdVHaY0oY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DLbXaBMoN2HQvGA2QaLWBtiH1indnKopytH67O4JC4fy1gd/fNnHir7xzuLC1gVGOYqQVS518n+x+3Tx0AxHfDjAxrGMp8raRUHxL1tRSLxQKhujCXlUVN6rS0TgS1Phri89QkKQjaDRGTlCYdO2QqyyPJBl8WiniSNgHoHZiKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Bhb3NnYN; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733231913; x=1764767913;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Q7maksDBaLIIDrKSJZH4DRQa93S4eVVppMEdVHaY0oY=;
  b=Bhb3NnYNgmtniEmeHU287Rv2JO/8lBBB1iaMraRwkwNacG+AMQIg63+m
   dEVx7nU/68jEXvrWF/jeNYNnRCYmrVRwNEtMiFDALCOmPJB1VO/T+pZih
   VqWPkBF1c4X0g9cLeroCG7ccoGhljXqYfg0/J3YyeIcI5siXNESvIj7oV
   JFXTUhhwyJhUdGnJk7mC83ge0cX5HG+F+aWL0rGsnbRVo20+dOAdxbZg9
   d7UJ2yXEeSFzISUdJQwmiFCudU1BrKGt1flkUHIuM4pEvlEj8a9O3YZ6G
   f5haJ6Cqkdw14gGdbO18phHFuO7T+w+WxJBy1PHelIvWHBXC/1NeuOgPg
   A==;
X-CSE-ConnectionGUID: 7YLzMA/LRiWYUzmBTH8FSg==
X-CSE-MsgGUID: tQDwY4bXSGePf7wibkEu7w==
X-IronPort-AV: E=McAfee;i="6700,10204,11274"; a="33500725"
X-IronPort-AV: E=Sophos;i="6.12,205,1728975600"; 
   d="scan'208";a="33500725"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2024 05:18:33 -0800
X-CSE-ConnectionGUID: he2ucC34S2+eQmUtJJhaGQ==
X-CSE-MsgGUID: v+1AuDGDQImqTLWZ/bqNNw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,205,1728975600"; 
   d="scan'208";a="130896069"
Received: from ccbilbre-mobl3.amr.corp.intel.com (HELO yungchua-desk.intel.com) ([10.124.223.75])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2024 05:18:32 -0800
From: Bard Liao <yung-chuan.liao@linux.intel.com>
To: linux-sound@vger.kernel.org,
	vkoul@kernel.org
Cc: vinod.koul@linaro.org,
	linux-kernel@vger.kernel.org,
	pierre-louis.bossart@linux.dev,
	bard.liao@intel.com
Subject: [PATCH v2 03/14] soundwire: add lane_used_bandwidth in struct sdw_bus
Date: Tue,  3 Dec 2024 21:18:02 +0800
Message-ID: <20241203131813.58454-4-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241203131813.58454-1-yung-chuan.liao@linux.intel.com>
References: <20241203131813.58454-1-yung-chuan.liao@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

To support multi-lane, we need to know how much bandwidth
is used on each lane. And to use the lane that has enough
bandwidth.

Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Reviewed-by: Péter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 include/linux/soundwire/sdw.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/soundwire/sdw.h b/include/linux/soundwire/sdw.h
index bb4e33a4db17..ae38ac848d38 100644
--- a/include/linux/soundwire/sdw.h
+++ b/include/linux/soundwire/sdw.h
@@ -893,6 +893,7 @@ struct sdw_master_ops {
  * @multi_link: Store bus property that indicates if multi links
  * are supported. This flag is populated by drivers after reading
  * appropriate firmware (ACPI/DT).
+ * @lane_used_bandwidth: how much bandwidth in bits per second is used by each lane
  */
 struct sdw_bus {
 	struct device *dev;
@@ -924,6 +925,7 @@ struct sdw_bus {
 	struct dentry *debugfs;
 #endif
 	bool multi_link;
+	unsigned int lane_used_bandwidth[SDW_MAX_LANES];
 };
 
 int sdw_bus_master_add(struct sdw_bus *bus, struct device *parent,
-- 
2.43.0


