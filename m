Return-Path: <linux-kernel+bounces-348839-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 587D298EC70
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 11:49:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 699F0B22EE0
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 09:49:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 149DB13211C;
	Thu,  3 Oct 2024 09:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IX76ZNFf"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00983147C71;
	Thu,  3 Oct 2024 09:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727948926; cv=none; b=Rxu7K7wzNk8Sb5Ol+Edy2PExgD83ZFl6uEwbbRKVUFlUXIqBCVTyZEHLPCC3NBH1eOZEqATqKbdJbHn2JBKAtY61SWLMuZb5uaP7pqosI0m0NLyjhs4QWqJXZPyBZ3AxhwEQrtKrm9jJTRE326BVo+qQLUNpjNLoOHlNFguKdKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727948926; c=relaxed/simple;
	bh=g8um18tgzxJglPzNME4wkxEVm4I9gf9B+lYHTz4Q/lU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GLSQlEiLiIHWTPxcBdm/332uwdMbHptjqzgObSfH3DbI0GLKPP48Gt1JJm97QHmlk8P+Yxw1fujeinpNDwr0r2jKMOFYDGI6vWLH4klq3MNT77B/XSjAVRycK+ofoOB7gu8PxQO91Jt1dyElEqMENK5VPs0L3tF0XTm7uX1St+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IX76ZNFf; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727948925; x=1759484925;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=g8um18tgzxJglPzNME4wkxEVm4I9gf9B+lYHTz4Q/lU=;
  b=IX76ZNFfIKNQabF2UoprXT4L3z2RpP7jj3kGhAtODGSMBDSzxXOK+GtS
   rlYDruguW8zqQP4Un8zgCgScxhZ2OX2vvw9XwxtRhRTCWP6bd6O0pUPcg
   yPH4rv8RhZLr2lU6erMBwo+tv16jT+oxRlcNLHbRuXimUirmWxwm/0ASg
   XcWSMgEFM0gIpec8puMnfPm+ihVpqJ/BDkK23n7ILnCoth4FLodDCworo
   nZKzh19IZHhJkA2aKZ5nP3iVVOJrRE8yycQ0QdpOwROaZaLPwWHVDi0MG
   N9tcleCSw3LF1GnWiKsZSt50Msv9iLHYmZYENfNBFo+9bCezAHDE2pisv
   g==;
X-CSE-ConnectionGUID: lG2HxjssSbK+d3QiFTqv9g==
X-CSE-MsgGUID: afIkf3bGSouKvSyoyPxPSg==
X-IronPort-AV: E=McAfee;i="6700,10204,11213"; a="27022061"
X-IronPort-AV: E=Sophos;i="6.11,174,1725346800"; 
   d="scan'208";a="27022061"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2024 02:48:44 -0700
X-CSE-ConnectionGUID: ZkzVd9FHTP+p+x5kTneeMA==
X-CSE-MsgGUID: 9wxj8VpxQ+ueiiWAXywl4A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,174,1725346800"; 
   d="scan'208";a="105065636"
Received: from anmitta2-mobl4.gar.corp.intel.com (HELO yungchua-desk.intel.com) ([10.247.118.10])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2024 02:48:41 -0700
From: Bard Liao <yung-chuan.liao@linux.intel.com>
To: linux-sound@vger.kernel.org,
	vkoul@kernel.org
Cc: vinod.koul@linaro.org,
	linux-kernel@vger.kernel.org,
	pierre-louis.bossart@linux.dev,
	bard.liao@intel.com
Subject: [PATCH 1/2] soundwire: cadence: add soft-reset on startup
Date: Thu,  3 Oct 2024 17:48:29 +0800
Message-ID: <20241003094830.119673-2-yung-chuan.liao@linux.intel.com>
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

Follow the recommended programming flows.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Péter Ujfalusi <peter.ujfalusi@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/cadence_master.c   | 25 +++++++++++++++++++++++++
 drivers/soundwire/cadence_master.h   |  1 +
 drivers/soundwire/intel_bus_common.c |  6 ++++++
 3 files changed, 32 insertions(+)

diff --git a/drivers/soundwire/cadence_master.c b/drivers/soundwire/cadence_master.c
index 05652e983539..7c8c977a923a 100644
--- a/drivers/soundwire/cadence_master.c
+++ b/drivers/soundwire/cadence_master.c
@@ -1377,6 +1377,31 @@ static void cdns_init_clock_ctrl(struct sdw_cdns *cdns)
 	cdns_writel(cdns, CDNS_MCP_SSP_CTRL1, ssp_interval);
 }
 
+/**
+ * sdw_cdns_soft_reset() - Cadence soft-reset
+ * @cdns: Cadence instance
+ */
+int sdw_cdns_soft_reset(struct sdw_cdns *cdns)
+{
+	int ret;
+
+	cdns_updatel(cdns, CDNS_MCP_CONTROL, CDNS_MCP_CONTROL_SOFT_RST,
+		     CDNS_MCP_CONTROL_SOFT_RST);
+
+	ret = cdns_config_update(cdns);
+	if (ret < 0) {
+		dev_err(cdns->dev, "%s: config update failed\n", __func__);
+		return ret;
+	}
+
+	ret = cdns_set_wait(cdns, CDNS_MCP_CONTROL, CDNS_MCP_CONTROL_SOFT_RST, 0);
+	if (ret < 0)
+		dev_err(cdns->dev, "%s: Soft Reset timed out\n", __func__);
+
+	return ret;
+}
+EXPORT_SYMBOL(sdw_cdns_soft_reset);
+
 /**
  * sdw_cdns_init() - Cadence initialization
  * @cdns: Cadence instance
diff --git a/drivers/soundwire/cadence_master.h b/drivers/soundwire/cadence_master.h
index e1d7969ba48a..c34fb050fe4f 100644
--- a/drivers/soundwire/cadence_master.h
+++ b/drivers/soundwire/cadence_master.h
@@ -168,6 +168,7 @@ int sdw_cdns_probe(struct sdw_cdns *cdns);
 irqreturn_t sdw_cdns_irq(int irq, void *dev_id);
 irqreturn_t sdw_cdns_thread(int irq, void *dev_id);
 
+int sdw_cdns_soft_reset(struct sdw_cdns *cdns);
 int sdw_cdns_init(struct sdw_cdns *cdns);
 int sdw_cdns_pdi_init(struct sdw_cdns *cdns,
 		      struct sdw_cdns_stream_config config);
diff --git a/drivers/soundwire/intel_bus_common.c b/drivers/soundwire/intel_bus_common.c
index d3ff6c65b64c..ad1f8ebdbfc9 100644
--- a/drivers/soundwire/intel_bus_common.c
+++ b/drivers/soundwire/intel_bus_common.c
@@ -16,6 +16,12 @@ int intel_start_bus(struct sdw_intel *sdw)
 	struct sdw_bus *bus = &cdns->bus;
 	int ret;
 
+	ret = sdw_cdns_soft_reset(cdns);
+	if (ret < 0) {
+		dev_err(dev, "%s: unable to soft-reset Cadence IP: %d\n", __func__, ret);
+		return ret;
+	}
+
 	/*
 	 * follow recommended programming flows to avoid timeouts when
 	 * gsync is enabled
-- 
2.43.0


