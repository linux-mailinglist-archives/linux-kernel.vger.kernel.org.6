Return-Path: <linux-kernel+bounces-528267-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 45EE3A415A0
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 07:46:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E9D918956AE
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 06:45:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0900B23A982;
	Mon, 24 Feb 2025 06:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="czgWAo2J"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B53CE23A9B6;
	Mon, 24 Feb 2025 06:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740379522; cv=none; b=CUZy8XtX/3hs9ck3Dju/DEkPGQGI1Ff0xw8V926klR7R6JV0vSg7i+iSGRcgrKNTX9EYJa1klpRwNknwd/bNvAHrR8IEXkVGwgeLqGLEgWlmeituhj264FrSQGhyex8jKV1tqFEKOgd01L4DSkj0yDoBQkv+gUcVqf6OeRXJAoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740379522; c=relaxed/simple;
	bh=V6z1mbHtzjhlkL0FbBMywzmI7KnvbrIMxHqOYIDsMhk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rnRkp4YpqSrMc6hR41no8+8Z/lpsNzcyuPnp64q9xOwuNe8ucK7IzkYARu+tal3i1SiKPr1xX/EzTb+C1xRHSp2+KDavJRhzvK17qfxUSoIap7SH3bcTXS/r1UjCT9LW9ybquGcP7mctr6PbPOUo4q/ecu6BcH1XRVOUJjKKCWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=czgWAo2J; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740379520; x=1771915520;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=V6z1mbHtzjhlkL0FbBMywzmI7KnvbrIMxHqOYIDsMhk=;
  b=czgWAo2JiwvcxUcw4vfeVL+gBvLwnvRLKH5bRLkvFear8THAWzQQA3o9
   aH56hrfQW/X1voymQu+f4EH3fw4cdlcxqZO20TEEQozsTf4gV4lqwZzd2
   3gzZhPJ0XQ+igKbAV6FaJqb9TXFhFqT9MthT/+j987JjI5xa0BdA2WyzX
   8gboLQ61nbFIRduiPgEZCCj75huZSYX4r6S4Et6eoLcgZs419g7b/Sjel
   FiCqjy1XsT3WBiYgMKuqtZ/M/sPZnM6LtWYtPkQSxkfhX18alznWI/I3Q
   oFur6y8pvpSXGy6oXnMQJa3vutBm4sl1SIfyPYwhz2/RqzBKxt7nQhXbd
   A==;
X-CSE-ConnectionGUID: ErlN/cvFQAeBqND9vjg8KQ==
X-CSE-MsgGUID: q1QCmDnTRLS7t31XSe++hA==
X-IronPort-AV: E=McAfee;i="6700,10204,11354"; a="58538925"
X-IronPort-AV: E=Sophos;i="6.13,309,1732608000"; 
   d="scan'208";a="58538925"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2025 22:45:20 -0800
X-CSE-ConnectionGUID: jrrFaPSbTga+6Vx2/W/pdQ==
X-CSE-MsgGUID: nIfYeYmhTmiiD6gcntkBbQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,309,1732608000"; 
   d="scan'208";a="120597665"
Received: from ssimmeri-mobl2.amr.corp.intel.com (HELO yungchua-desk.intel.com) ([10.124.222.232])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2025 22:45:18 -0800
From: Bard Liao <yung-chuan.liao@linux.intel.com>
To: linux-sound@vger.kernel.org,
	broonie@kernel.org,
	tiwai@suse.de,
	vkoul@kernel.org
Cc: vinod.koul@linaro.org,
	linux-kernel@vger.kernel.org,
	pierre-louis.bossart@linux.dev,
	bard.liao@intel.com
Subject: [PATCH v2 02/16] soundwire: cadence: add BTP support for DP0
Date: Mon, 24 Feb 2025 14:44:36 +0800
Message-ID: <20250224064451.33772-3-yung-chuan.liao@linux.intel.com>
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


