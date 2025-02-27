Return-Path: <linux-kernel+bounces-536103-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EA566A47B8B
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 12:12:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5B3AE7A61BA
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 11:11:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2C9B22B5AA;
	Thu, 27 Feb 2025 11:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QSPDsh20"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6D9522ACDC;
	Thu, 27 Feb 2025 11:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740654708; cv=none; b=n+3rud9vG5JyiRpQNRdbLxPpJJGiRAmaSOaQzZ83y/Jd0aB+vCCVcCyODN5VqSW7D5Rzu4Aas9BrmgaeKwUrmtDKJBnPEjFqBX6cThRVUcOOLvuqb+S7Bltxrd5WXO/UCMiv209Tobyovr89Qc3zPo6+UREX7pO0tJP1sGVs/Lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740654708; c=relaxed/simple;
	bh=V6z1mbHtzjhlkL0FbBMywzmI7KnvbrIMxHqOYIDsMhk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gT7nPMHMAA7lW6fAEYDxOTWbM4FZoTKvRduf4ZMITtqlbAh1/o08tcZfowYn5XfFtzNSXhkJdSN0TguC29qxrOZPsIfPWXoeymvZqyWjfvyNr6vUc5CpurGxdTSD9X/LuHvpBQ2vxCDaafJ3tExlYNr20RT++JswUfDwPk6R5ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QSPDsh20; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740654706; x=1772190706;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=V6z1mbHtzjhlkL0FbBMywzmI7KnvbrIMxHqOYIDsMhk=;
  b=QSPDsh20188DrBuejOQfQg33kZ3/ZQNeEsenJRdSACgMbZWM8JHQGRvh
   KVZ49KnhqQ7Iywz0U6rVgZG+EAWQgC/9xbi+8H3WRjuC6LoZi9sCiwYqt
   RBU/s70iqJMONzZcbxrjx3YWZYTZyBTj0npPeAPE0JFN9UKvhUX0OUHY7
   iB2mmQhLVV/QF7pq49dlXrJAofB+zWueXnHcwpw1cgQFmcyRU+F2tJ+rP
   ccbdgwrhv676nThOwp835MLPkgELn3SB+bcnPA4UOVzl/KTbcPwD72Rke
   gpECc3w1HaYfY9YouRUCOoaa0xu+/lOtSWuINz8atJ0dzyLObS9YSnw3s
   w==;
X-CSE-ConnectionGUID: LRrCWvBYRVioGFEao9Jd9Q==
X-CSE-MsgGUID: /E36R2jaReartoxO2PMsbQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11357"; a="45189796"
X-IronPort-AV: E=Sophos;i="6.13,319,1732608000"; 
   d="scan'208";a="45189796"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2025 03:11:46 -0800
X-CSE-ConnectionGUID: e2GhIDbiT9ufdtPaeEyCuQ==
X-CSE-MsgGUID: 3oUSWY4aRTOV7wb+YrR52A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="154178918"
Received: from johunt-mobl9.ger.corp.intel.com (HELO yungchua-desk.intel.com) ([10.124.220.110])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2025 03:11:44 -0800
From: Bard Liao <yung-chuan.liao@linux.intel.com>
To: linux-sound@vger.kernel.org,
	broonie@kernel.org,
	tiwai@suse.de,
	vkoul@kernel.org
Cc: vinod.koul@linaro.org,
	linux-kernel@vger.kernel.org,
	pierre-louis.bossart@linux.dev,
	bard.liao@intel.com
Subject: [PATCH v3 02/16] soundwire: cadence: add BTP support for DP0
Date: Thu, 27 Feb 2025 19:11:15 +0800
Message-ID: <20250227111130.272698-3-yung-chuan.liao@linux.intel.com>
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

The register definitions are missing a BULK_ENABLE bitfield which must
be set for DP0.

In addition, the existing mapping from PDI to Data Port is 1:1. That's
fine for PCM streams which are by construction in one direction
only. The BTP/BRA protocol is bidirectional and relies on DP0 only,
which breaks the 1:1 mapping. DP0 MUST be mapped to both PDI0 and
PDI1, with PDI0 taking care of the TX direction and PDI1 of the RX
direction.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Reviewed-by: Péter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Liam Girdwood <liam.r.girdwood@intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
---
 drivers/soundwire/cadence_master.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/soundwire/cadence_master.c b/drivers/soundwire/cadence_master.c
index 68be8ff3f02b..b29929b59510 100644
--- a/drivers/soundwire/cadence_master.c
+++ b/drivers/soundwire/cadence_master.c
@@ -184,6 +184,7 @@ MODULE_PARM_DESC(cdns_mcp_int_mask, "Cadence MCP IntMask");
 #define CDNS_PORTCTRL_TEST_FAILED		BIT(1)
 #define CDNS_PORTCTRL_DIRN			BIT(7)
 #define CDNS_PORTCTRL_BANK_INVERT		BIT(8)
+#define CDNS_PORTCTRL_BULK_ENABLE		BIT(16)
 
 #define CDNS_PORT_OFFSET			0x80
 
@@ -1917,13 +1918,20 @@ void sdw_cdns_config_stream(struct sdw_cdns *cdns,
 
 		if (cdns->bus.params.m_data_mode != SDW_PORT_DATA_MODE_NORMAL)
 			val |= CDNS_PORTCTRL_TEST_FAILED;
+	} else if (pdi->num == 0 || pdi->num == 1) {
+		val |= CDNS_PORTCTRL_BULK_ENABLE;
 	}
 	offset = CDNS_PORTCTRL + pdi->num * CDNS_PORT_OFFSET;
 	cdns_updatel(cdns, offset,
-		     CDNS_PORTCTRL_DIRN | CDNS_PORTCTRL_TEST_FAILED,
+		     CDNS_PORTCTRL_DIRN | CDNS_PORTCTRL_TEST_FAILED |
+		     CDNS_PORTCTRL_BULK_ENABLE,
 		     val);
 
-	val = pdi->num;
+	/* The DataPort0 needs to be mapped to both PDI0 and PDI1 ! */
+	if (pdi->num == 1)
+		val = 0;
+	else
+		val = pdi->num;
 	val |= CDNS_PDI_CONFIG_SOFT_RESET;
 	val |= FIELD_PREP(CDNS_PDI_CONFIG_CHANNEL, (1 << ch) - 1);
 	cdns_writel(cdns, CDNS_PDI_CONFIG(pdi->num), val);
-- 
2.43.0


