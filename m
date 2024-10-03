Return-Path: <linux-kernel+bounces-348660-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1544F98EA22
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 09:10:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1638288A73
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 07:10:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4282C14A099;
	Thu,  3 Oct 2024 07:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RFu4BOAp"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B215148832;
	Thu,  3 Oct 2024 07:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727939271; cv=none; b=GbwPM7XfsqDxjSta7kPgRHaoEtuGnKw04lnTOBRFuYLE98k8Yb9c2fTHesT2VXTBbZxSfrBi7noHUNfI7SqSx6It9evXwCUqXEXun5oNyqgpy3NvHeWYcmXA5ogm2WadZoqg2Q58aGMOKxVBmWJ4yk+tYrekZnm7fxJD8mBgWdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727939271; c=relaxed/simple;
	bh=tR8A1eViSyQSc4oQ1f/zM0XJtPGc9luqCHbxUT7oPnk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eheuEtbJk3TGsXUILIf1iMTklJQnSJ6fsAMj5tnRJRduqOGOXP53UNtzWIWFqf+DTrkEUFsH2wBxol6qSx14w1LkpPoC5Vp21/iHPsq46xsch0r+UoTHiZqMYwbrDiZOP5ti4FVDDDcYGYAxf5DKpAlhHTdDlBuzck6BQagh4uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RFu4BOAp; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727939271; x=1759475271;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tR8A1eViSyQSc4oQ1f/zM0XJtPGc9luqCHbxUT7oPnk=;
  b=RFu4BOApOuNnBBEz2PihU4LeH+vkGYYmmXL4SdKlQ5K/CQEojU5xguAX
   e79CWt8LmdYn7qtBuLVy3fa1tZoeMcgGejSN3D/iAx+yYh/7U9z3SyfES
   RR1I//tvDsr4jY/nO7dviDIw9xX4fX1Pcn/Siz3V4Ln5wg/gtVG0Kak/+
   SX5XTurHR7jZ/bd2Qh/U07ij8R9hUAK9U10i6XAiQJfmxFT8cLkl7G200
   OEAwy74R5ykuEJW2EY+15LdU1y6h3mi94Vod3goNrGM/FnVYt0i00/rpX
   ZSRBf6XL3fI5KRdeG+dKNhmIO1anrHXUq+dKA96PGedUj4+msmSWW5xG4
   Q==;
X-CSE-ConnectionGUID: xUTV38tjSBOEh8iZ4zObFQ==
X-CSE-MsgGUID: kdM/MWqqT/yht862HRYWVQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11213"; a="27070793"
X-IronPort-AV: E=Sophos;i="6.11,173,1725346800"; 
   d="scan'208";a="27070793"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2024 00:07:50 -0700
X-CSE-ConnectionGUID: vIX5oChxTDeeRIw9+jGwjQ==
X-CSE-MsgGUID: Qa8hrSILREm7hXoLrqRFAg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,173,1725346800"; 
   d="scan'208";a="74508420"
Received: from anmitta2-mobl4.gar.corp.intel.com (HELO yungchua-desk.intel.com) ([10.247.118.10])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2024 00:07:48 -0700
From: Bard Liao <yung-chuan.liao@linux.intel.com>
To: linux-sound@vger.kernel.org,
	vkoul@kernel.org
Cc: vinod.koul@linaro.org,
	linux-kernel@vger.kernel.org,
	pierre-louis.bossart@linux.dev,
	bard.liao@intel.com
Subject: [PATCH v2 RESEND 11/14] soundwire: mipi-disco: add support for peripheral channelprepare timeout
Date: Thu,  3 Oct 2024 15:06:47 +0800
Message-ID: <20241003070650.62787-12-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241003070650.62787-1-yung-chuan.liao@linux.intel.com>
References: <20241003070650.62787-1-yung-chuan.liao@linux.intel.com>
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


