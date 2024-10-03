Return-Path: <linux-kernel+bounces-348840-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C2C498EC71
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 11:49:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 342BE284A4C
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 09:49:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4D85126C00;
	Thu,  3 Oct 2024 09:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OjVlmaeB"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D218C14883F;
	Thu,  3 Oct 2024 09:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727948928; cv=none; b=tj/+WLfuEj8cvC+LqPmjxf+sCcc6p18k+gTJLFtSwKrlGIGXG0V86QafmZpauDW09j/MkTh8TxSA27Q8nCFi0PfEfruMk8NPHTUlsKObIvwzwUYyF0VcjrP05kJBXfV/GCf5dQQbAqJicvC6mJhu3CACB3Tc3gdRaLv+My1c+5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727948928; c=relaxed/simple;
	bh=i4DDyHett4jeZNRxWMt0RiZSzpcsO9MSuqhfOMx78/Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=INog5bwS+hghDI0aytvHcrPHbi56PX7N0M05xkoTyNuh6xXldtWC6/YZCzjymeH7bLs7SlFQEt0EykxaiB5Zhgw3pUyGIeXmsjRYbyq+ggc2xRUk7guvtQN1FiXcO6jxCARNoHHrw+56c6HtmOSq4TR9UhTZ1ev6VdV22cxBXxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OjVlmaeB; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727948927; x=1759484927;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=i4DDyHett4jeZNRxWMt0RiZSzpcsO9MSuqhfOMx78/Q=;
  b=OjVlmaeBO3ItxMUvKFs9+YxTpg9ZTf/2Q3YYwW8VPmwA4VHnWYE5r/7T
   nXCiuIMyrVjz2oureTSIfUmU/EkaBRvjOCdjnXyu5lhQ3GIc9sdX6dcGz
   NBitPNAEFHnZm44lREno1ylKq7pNJsiAbGGl/uUSa6o46Jj4MzwaYGmaj
   roudn/z+NkyNj5jTdPKtdG4tgf2QZJQaNDeOULa1vbxX9YeQgNRLYpgTp
   wy74GUmJDt4MyzL2/N+bR6E/qoQVCM19jxGT5ps5khmo1tribkOIQX9mt
   Bwv0VhWBaRQOztus9vYjMTG42/OrPcl8HoufZeq8KnIvgmt1ZcLLwRW5i
   g==;
X-CSE-ConnectionGUID: fX0gzhDLSNWsl63DK2mUHA==
X-CSE-MsgGUID: V9aH9ZXeTWKFJfds+fA3+Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11213"; a="27022068"
X-IronPort-AV: E=Sophos;i="6.11,174,1725346800"; 
   d="scan'208";a="27022068"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2024 02:48:46 -0700
X-CSE-ConnectionGUID: vEsaxeg6Tv2et1INnp9Dbg==
X-CSE-MsgGUID: ZdGF26WwTfOhR63xIGP8XQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,174,1725346800"; 
   d="scan'208";a="105065639"
Received: from anmitta2-mobl4.gar.corp.intel.com (HELO yungchua-desk.intel.com) ([10.247.118.10])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2024 02:48:43 -0700
From: Bard Liao <yung-chuan.liao@linux.intel.com>
To: linux-sound@vger.kernel.org,
	vkoul@kernel.org
Cc: vinod.koul@linaro.org,
	linux-kernel@vger.kernel.org,
	pierre-louis.bossart@linux.dev,
	bard.liao@intel.com
Subject: [PATCH 2/2] soundwire: cadence: clear MCP BLOCK_WAKEUP in init
Date: Thu,  3 Oct 2024 17:48:30 +0800
Message-ID: <20241003094830.119673-3-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241003094830.119673-1-yung-chuan.liao@linux.intel.com>
References: <20241003094830.119673-1-yung-chuan.liao@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

Follow recommended programming flows.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Péter Ujfalusi <peter.ujfalusi@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/cadence_master.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/soundwire/cadence_master.c b/drivers/soundwire/cadence_master.c
index 7c8c977a923a..f367670ea991 100644
--- a/drivers/soundwire/cadence_master.c
+++ b/drivers/soundwire/cadence_master.c
@@ -1425,6 +1425,11 @@ int sdw_cdns_init(struct sdw_cdns *cdns)
 	cdns_ip_updatel(cdns, CDNS_IP_MCP_CONTROL, CDNS_IP_MCP_CONTROL_CMD_ACCEPT,
 			CDNS_IP_MCP_CONTROL_CMD_ACCEPT);
 
+	/* disable wakeup */
+	cdns_ip_updatel(cdns, CDNS_IP_MCP_CONTROL,
+			CDNS_IP_MCP_CONTROL_BLOCK_WAKEUP,
+			0);
+
 	/* Configure mcp config */
 	val = cdns_readl(cdns, CDNS_MCP_CONFIG);
 
-- 
2.43.0


