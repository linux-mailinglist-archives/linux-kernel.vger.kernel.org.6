Return-Path: <linux-kernel+bounces-303384-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFF28960B64
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 15:10:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DD08285439
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 13:10:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C3C11C4EE9;
	Tue, 27 Aug 2024 13:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="S98JY2IE"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3002F1BF329;
	Tue, 27 Aug 2024 13:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724764103; cv=none; b=OA0CjWhykp2S8kb7GZHs8rMWdbp+AJzAP7eIKF9MgWf+0zeyDu0CFHBbUHqunwlYfasfhFf+gUBEUlVTOD32SBs6muwVHEiiY5sjK003kc6TABhIkCHO+CZmARZ7Qtm15+/XTzwwJbAMcodFMjBTlYOS7NTu0CEH6AL3UpKnb/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724764103; c=relaxed/simple;
	bh=tR8A1eViSyQSc4oQ1f/zM0XJtPGc9luqCHbxUT7oPnk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PJCuxOCYNi0CxqIvswYe/GLJj7uSojWaSkHnGfqzvBEh2aIxob7GWzQHwFo6f3Dy/EFQMDQowUX9Gvp+btiUlqbvv++cyObCnjRehz1Pyq+vO9y9MJVfKGkwtfFV55Q/KIQ7zMJAg4QfJ7dqauA6Zev1R5Mh05VSlocZGDSemFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=S98JY2IE; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724764102; x=1756300102;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tR8A1eViSyQSc4oQ1f/zM0XJtPGc9luqCHbxUT7oPnk=;
  b=S98JY2IEf6wDp9BHAzsPQrF42sBr2U6tZJKcHnmevp4TzMwEk/6e0L/T
   Aj027yO0s+Ed5KrWpucVGrfsC5UIh5LOpQiSCLDe9y5/hx5wWEgCmQb4I
   +wSFJxquBaEYjCq3VpH8PAL+/e88p264KaGbk0FrVor7fohAahj+0BmYw
   Jjs2EADw8CbAA2Np9tYem2oZ8VIonRcOMg2y8QAwaj64sPWSCkBm8ndKq
   hueUFgJsaSt2XB57EMsu/wwoEpqXG7q7b3T9/hsyx4C4P86Y59RGps/TF
   ZVVkRqqNUfEuOHp0eBHulVp8TWa/2a9oHz79C39uLh0ydLQdNBhQ48XSU
   w==;
X-CSE-ConnectionGUID: U+kyo/SgRXCXWyr10Cb97Q==
X-CSE-MsgGUID: qWYrSreASbSvexS1DdijVw==
X-IronPort-AV: E=McAfee;i="6700,10204,11176"; a="23400635"
X-IronPort-AV: E=Sophos;i="6.10,180,1719903600"; 
   d="scan'208";a="23400635"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2024 06:08:21 -0700
X-CSE-ConnectionGUID: 8MJSROCYQA+YGy03MGqWrQ==
X-CSE-MsgGUID: 5hnilwz4Stm3Z70dGdiRDw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,180,1719903600"; 
   d="scan'208";a="67552121"
Received: from anmitta2-mobl4.gar.corp.intel.com (HELO yungchua-desk.intel.com) ([10.247.118.39])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2024 06:08:20 -0700
From: Bard Liao <yung-chuan.liao@linux.intel.com>
To: linux-sound@vger.kernel.org,
	vkoul@kernel.org
Cc: vinod.koul@linaro.org,
	linux-kernel@vger.kernel.org,
	pierre-louis.bossart@linux.intel.com,
	bard.liao@intel.com
Subject: [PATCH 11/14] soundwire: mipi-disco: add support for peripheral channelprepare timeout
Date: Tue, 27 Aug 2024 21:07:04 +0800
Message-ID: <20240827130707.298477-12-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240827130707.298477-1-yung-chuan.liao@linux.intel.com>
References: <20240827130707.298477-1-yung-chuan.liao@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

The DisCo for SoundWire 2.0 spec renamed the
'mipi-sdw-slave-channelprepare-timeout', add support for the new
definition in backwards-compatible ways.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/mipi_disco.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/soundwire/mipi_disco.c b/drivers/soundwire/mipi_disco.c
index 5f42d23bbc85..6feba5631eae 100644
--- a/drivers/soundwire/mipi_disco.c
+++ b/drivers/soundwire/mipi_disco.c
@@ -344,6 +344,7 @@ int sdw_slave_read_prop(struct sdw_slave *slave)
 	struct device *dev = &slave->dev;
 	struct fwnode_handle *port;
 	int nval;
+	int ret;
 
 	device_property_read_u32(dev, "mipi-sdw-sw-interface-revision",
 				 &prop->mipi_revision);
@@ -366,8 +367,11 @@ int sdw_slave_read_prop(struct sdw_slave *slave)
 	device_property_read_u32(dev, "mipi-sdw-clockstopprepare-timeout",
 				 &prop->clk_stop_timeout);
 
-	device_property_read_u32(dev, "mipi-sdw-slave-channelprepare-timeout",
-				 &prop->ch_prep_timeout);
+	ret = device_property_read_u32(dev, "mipi-sdw-peripheral-channelprepare-timeout",
+				       &prop->ch_prep_timeout);
+	if (ret < 0)
+		device_property_read_u32(dev, "mipi-sdw-slave-channelprepare-timeout",
+					 &prop->ch_prep_timeout);
 
 	device_property_read_u32(dev,
 			"mipi-sdw-clockstopprepare-hard-reset-behavior",
-- 
2.43.0


