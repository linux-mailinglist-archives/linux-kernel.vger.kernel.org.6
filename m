Return-Path: <linux-kernel+bounces-303385-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CB04960B65
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 15:10:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D7E201F22134
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 13:10:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3C061BF329;
	Tue, 27 Aug 2024 13:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f9B7H1at"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A856B1BF7EE;
	Tue, 27 Aug 2024 13:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724764106; cv=none; b=I0y5TRp/00xYVzHttuN1MMHCDmsbtEzSXRTNNa6Jp0P/fJ3UPyf2UqfbIMsOkqMAwna75O0wVIBuvmPKTsxBBGstyJd48b2aQc2hnIRe1tcILcuNN7NnexWEmyOil+xqMg3ePkk8WjXIX+ZzZT18VYwdbOMbwHRxrCh26PTl+7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724764106; c=relaxed/simple;
	bh=ZB3aqSPbxq3S58RNyPbBpF2vKgfog9SCStSlk2aXwzI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DkXaDB/sSBv1z9YCzJ/4yRKxfxrXR/4sCVi7gVbbt4iEPkkvWCfIzKex3q9g9ePoNr80Si0tXxd6aSZSQHPKn0TiN9CpeOoYodgjPIK7/BfJmbAAPW8z/ISqOYPSHclTxW7DpEoT0NEwhI5akzvg0SU46n0kdGLvt7e27+VFDXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=f9B7H1at; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724764104; x=1756300104;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZB3aqSPbxq3S58RNyPbBpF2vKgfog9SCStSlk2aXwzI=;
  b=f9B7H1atVco2cMAtk6Xu8+sCAMGLQgZFdbL4IRW/FTHrLlPtUf89Njph
   T7JnDXAokD2FCOxiEw7RBnn9gLmu/PFjQeZpYVH5c1jhXll9Nl91wNn2u
   xMp+pJYaOPgJO2GLfywmWSuhM5Kp/W/9rQriCs7uX4CGPjNDXAmpy+gDD
   JkMoQ3MLxw4tL1khBVmlOD6e2vhS2XUuFx1QYVKAyhUBZzR1crihSVTqL
   gua449f0dyoKY1esj223XjbEZBP8t4msYz70auHZ9osjcYDP04PlIw+6d
   /8aRw0RqrecuDs+DuRPgEzbkErw1P06QNmo2qrRQMPFkAPH2HL3WMZBSA
   Q==;
X-CSE-ConnectionGUID: o250sx72Qp64tQCTmZblfg==
X-CSE-MsgGUID: iUcPG/sqTb6R0SI6p4RHhg==
X-IronPort-AV: E=McAfee;i="6700,10204,11176"; a="23400644"
X-IronPort-AV: E=Sophos;i="6.10,180,1719903600"; 
   d="scan'208";a="23400644"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2024 06:08:24 -0700
X-CSE-ConnectionGUID: tYHDZn53RhiWLO6MKh/sOA==
X-CSE-MsgGUID: f1M16hlcQ42VtEnkRKHDuw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,180,1719903600"; 
   d="scan'208";a="67552138"
Received: from anmitta2-mobl4.gar.corp.intel.com (HELO yungchua-desk.intel.com) ([10.247.118.39])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2024 06:08:23 -0700
From: Bard Liao <yung-chuan.liao@linux.intel.com>
To: linux-sound@vger.kernel.org,
	vkoul@kernel.org
Cc: vinod.koul@linaro.org,
	linux-kernel@vger.kernel.org,
	pierre-louis.bossart@linux.intel.com,
	bard.liao@intel.com
Subject: [PATCH 12/14] soundwire: mipi-disco: add comment on DP0-supported property
Date: Tue, 27 Aug 2024 21:07:05 +0800
Message-ID: <20240827130707.298477-13-yung-chuan.liao@linux.intel.com>
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

The DisCo for SoundWire 2.0 spec adds support for a new property, but
it's not very helpful. Add a comment to explain that it's
intentionally ignored.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/mipi_disco.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/soundwire/mipi_disco.c b/drivers/soundwire/mipi_disco.c
index 6feba5631eae..d6eb63bf1252 100644
--- a/drivers/soundwire/mipi_disco.c
+++ b/drivers/soundwire/mipi_disco.c
@@ -398,7 +398,11 @@ int sdw_slave_read_prop(struct sdw_slave *slave)
 	device_property_read_u32(dev, "mipi-sdw-sink-port-list",
 				 &prop->sink_ports);
 
-	/* Read dp0 properties */
+	/*
+	 * Read dp0 properties - we don't rely on the 'mipi-sdw-dp-0-supported'
+	 * property since the 'mipi-sdw-dp0-subproperties' property is logically
+	 * equivalent.
+	 */
 	port = device_get_named_child_node(dev, "mipi-sdw-dp-0-subproperties");
 	if (!port) {
 		dev_dbg(dev, "DP0 node not found!!\n");
-- 
2.43.0


