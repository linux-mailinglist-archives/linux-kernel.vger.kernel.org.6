Return-Path: <linux-kernel+bounces-394157-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A708B9BAB3C
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 04:25:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6827128240A
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 03:25:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC08719340B;
	Mon,  4 Nov 2024 03:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GKaRM68R"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB8F018C347;
	Mon,  4 Nov 2024 03:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730690644; cv=none; b=hdqZRBt48lUhzHOFONlp9VVf0C0MDNHZyIAP2YPRTOTrrxrsPxzALhyBCYFXAb5nn7DZUyLB5H4LiEm07U4FhGOWLJ2zjq4w9oz8D2oP9jAajB2lqD8keLFro+gJq8tFHEqNofkNNPko3bcTak7+P21c4UW0g2qgNqYrDDrOCbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730690644; c=relaxed/simple;
	bh=FMb4Dd3ZGB7CVfMUIr02lTZUonJ09uv5mSaHmF2/KFA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FmLfnxzb1oi4qOMxU97o8NNW+bL7yXXcdkDvcP+Bi7UFbBlqOTAXK0P3F8QuI6WnMUUaFILyjLM6vmdmnG6jVWT5N8v1kxcq4XXsudNmIWAp5kL04ueDwkIVgFqHoAaTfpqrNRAd5mAym/d13Gr2u6H/8L51nk8TymKkAZ3LVBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GKaRM68R; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730690642; x=1762226642;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FMb4Dd3ZGB7CVfMUIr02lTZUonJ09uv5mSaHmF2/KFA=;
  b=GKaRM68R/gx9krWzgjJd/YM2GCcAonA78sjx7A4vkYLMVWkT3+22suBa
   OeLsgN11aHTCcAayguy3dovC2n6T3JhSqEEZ/XThFIhhAi/FBT4p0e8x4
   DTFbtvGUqQfrGF7Lh3tZZgMQnMQU54ep6YOkQKMu5M4AF/jb+wGRVXiQd
   bdkw2L+tvPsGvVHGkkyYlH5xu/LP33EEe387dwtxvFL4KinQ+4lGCqA8O
   vcAqvvqSCZ1zJk4k4zy+qQuUmkxEsQLtXxsCb67PLTkxmS6vh26hOHCTz
   xOE63DSR8YlSJ3w0zPjVh5cyQT4zwXm1Bn1910/lgMAL7psdlB5rm6baH
   g==;
X-CSE-ConnectionGUID: MV4TMyylRvSWRecTchufAA==
X-CSE-MsgGUID: RltLfDUuQkmvuo5o4Deoog==
X-IronPort-AV: E=McAfee;i="6700,10204,11245"; a="30594301"
X-IronPort-AV: E=Sophos;i="6.11,256,1725346800"; 
   d="scan'208";a="30594301"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2024 19:23:57 -0800
X-CSE-ConnectionGUID: VaySHve6SueDRri4I5rwDQ==
X-CSE-MsgGUID: HrT8/Y6bReSmWhmR5rpA4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,256,1725346800"; 
   d="scan'208";a="114331826"
Received: from yungchua-ws.ostc.intel.com (HELO yungchua-ws.intel.com) ([10.54.69.90])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2024 19:23:57 -0800
From: Bard Liao <yung-chuan.liao@linux.intel.com>
To: linux-sound@vger.kernel.org,
	vkoul@kernel.org
Cc: vinod.koul@linaro.org,
	linux-kernel@vger.kernel.org,
	pierre-louis.bossart@linux.dev,
	bard.liao@intel.com
Subject: [PATCH 09/12] soundwire: generic_bandwidth_allocation: correct clk_freq check in sdw_select_row_col
Date: Mon,  4 Nov 2024 03:23:55 +0000
Message-Id: <20241104032358.669705-10-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241104032358.669705-1-yung-chuan.liao@linux.intel.com>
References: <20241104032358.669705-1-yung-chuan.liao@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The bits in Column 0 of Rows 0 to 47 are for control word and cannot be
used for audio. In practice, entire Column 0 is skipped.

Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
---
 drivers/soundwire/generic_bandwidth_allocation.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/soundwire/generic_bandwidth_allocation.c b/drivers/soundwire/generic_bandwidth_allocation.c
index d847413141d3..5c4dac36ad1a 100644
--- a/drivers/soundwire/generic_bandwidth_allocation.c
+++ b/drivers/soundwire/generic_bandwidth_allocation.c
@@ -302,7 +302,6 @@ static int sdw_compute_port_params(struct sdw_bus *bus)
 static int sdw_select_row_col(struct sdw_bus *bus, int clk_freq)
 {
 	struct sdw_master_prop *prop = &bus->prop;
-	int frame_int, frame_freq;
 	int r, c;
 
 	for (c = 0; c < SDW_FRAME_COLS; c++) {
@@ -311,11 +310,8 @@ static int sdw_select_row_col(struct sdw_bus *bus, int clk_freq)
 			    sdw_cols[c] != prop->default_col)
 				continue;
 
-			frame_int = sdw_rows[r] * sdw_cols[c];
-			frame_freq = clk_freq / frame_int;
-
-			if ((clk_freq - (frame_freq * SDW_FRAME_CTRL_BITS)) <
-			    bus->params.bandwidth)
+			if (clk_freq * (sdw_cols[c] - 1) <
+			    bus->params.bandwidth * sdw_cols[c])
 				continue;
 
 			bus->params.row = sdw_rows[r];
-- 
2.34.1


