Return-Path: <linux-kernel+bounces-353250-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B9171992B39
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 14:13:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F3E61F23AD8
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 12:13:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A0771D2F5F;
	Mon,  7 Oct 2024 12:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YXZuLDyv"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B81471BA285;
	Mon,  7 Oct 2024 12:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728303178; cv=none; b=a+ya573DBP8+3ncsS6EMn9pzwcyS9VeQ0EFRcXsh11qonRxI9dwchjnPMqSaLkpCYYWWwMPHHeUUceuPz7WsPk+pFuaBsP0+WerzJzYlDYpJHc9/xFfcZ6RqoylheiENsqXgsHJlyY9cToqpruTNJ/K8xg6TSULo1OeboOfyhw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728303178; c=relaxed/simple;
	bh=eUsEx3EPiolUZTSJw8qX0abCZJfMLLpQqRgiDt2cv+k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sdFSVRDV+3MpMK72wsE54C64eS5BBmivQo/a2dPyIs65/Y2whpPstjPevvpeGnaCMDVsr9rIaq0Ss6nrztx0cRjVncLqVkX0KoETCL8fRUPqg2bQItVy2P5kztkiGWRCPr210Y/z+UOFxNFkiEY5hAMEQyZ7a3t5WJPZ/w8sj1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YXZuLDyv; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728303177; x=1759839177;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=eUsEx3EPiolUZTSJw8qX0abCZJfMLLpQqRgiDt2cv+k=;
  b=YXZuLDyvH3P5UUyLvuWU8yBgi+3S8gcn3SBQ8XNSS3DGNR+evYqThvnA
   XtPtIjdjtJJ5ZW71rmQLsoM2OtpyGOahObhYBMWQQlS/MHD8OAJq67tjt
   tQYxDeBVBJBIx3WaZgw+uyiWlWX8O/iQku8o8Hiyfvu3n91ZmW2/ZxEFg
   vENkpNZ3K8oyw/3EgY1daQGdMvrch53iWCJxN8E0LxI9NTjPca0+HGdtV
   y2PEm/IyQe/4armf44IBEpgoEoeaOJPNbS3UJ360cnuXpHWEvscnH8Wtp
   ZOGZ1j+oi4bnmDkiRTEUk8sIAvIIOIFC5Oyd+cAcayF5yx65RquZPTPgv
   w==;
X-CSE-ConnectionGUID: hUPXvs42TRKLL+o13NP47g==
X-CSE-MsgGUID: xmCwPrfkT1qEI7wGQYaeWQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11217"; a="15064798"
X-IronPort-AV: E=Sophos;i="6.11,184,1725346800"; 
   d="scan'208";a="15064798"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2024 05:12:56 -0700
X-CSE-ConnectionGUID: sdU2Bv+aSGWLiRsDxTvO8w==
X-CSE-MsgGUID: B8AuLV7bQ2Orm2CMrzXn3w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,184,1725346800"; 
   d="scan'208";a="80246880"
Received: from anmitta2-mobl4.gar.corp.intel.com (HELO yungchua-desk.intel.com) ([10.247.118.70])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2024 05:12:53 -0700
From: Bard Liao <yung-chuan.liao@linux.intel.com>
To: broonie@kernel.org,
	tiwai@suse.de,
	vkoul@kernel.org
Cc: vinod.koul@linaro.org,
	linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org,
	pierre-louis.bossart@linux.dev,
	bard.liao@intel.com,
	peter.ujfalusi@linux.intel.com
Subject: [PATCH 1/2] ASoC: SOF: Intel: hda-mlink: expose unlocked interrupt enable routine
Date: Mon,  7 Oct 2024 20:12:40 +0800
Message-ID: <20241007121241.30914-2-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241007121241.30914-1-yung-chuan.liao@linux.intel.com>
References: <20241007121241.30914-1-yung-chuan.liao@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

When the eml_lock is already taken, we need an unlocked version.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Liam Girdwood <liam.r.girdwood@intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 include/sound/hda-mlink.h       |  4 ++++
 sound/soc/sof/intel/hda-mlink.c | 18 ++++++++++++++++++
 2 files changed, 22 insertions(+)

diff --git a/include/sound/hda-mlink.h b/include/sound/hda-mlink.h
index 9ced94686ce3..6774f4b9e5fc 100644
--- a/include/sound/hda-mlink.h
+++ b/include/sound/hda-mlink.h
@@ -15,6 +15,7 @@ int hda_bus_ml_init(struct hdac_bus *bus);
 void hda_bus_ml_free(struct hdac_bus *bus);
 
 int hdac_bus_eml_get_count(struct hdac_bus *bus, bool alt, int elid);
+void hdac_bus_eml_enable_interrupt_unlocked(struct hdac_bus *bus, bool alt, int elid, bool enable);
 void hdac_bus_eml_enable_interrupt(struct hdac_bus *bus, bool alt, int elid, bool enable);
 bool hdac_bus_eml_check_interrupt(struct hdac_bus *bus, bool alt, int elid);
 
@@ -71,6 +72,9 @@ static inline void hda_bus_ml_free(struct hdac_bus *bus) { }
 static inline int
 hdac_bus_eml_get_count(struct hdac_bus *bus, bool alt, int elid) { return 0; }
 
+static inline void
+hdac_bus_eml_enable_interrupt_unlocked(struct hdac_bus *bus, bool alt, int elid, bool enable) { }
+
 static inline void
 hdac_bus_eml_enable_interrupt(struct hdac_bus *bus, bool alt, int elid, bool enable) { }
 
diff --git a/sound/soc/sof/intel/hda-mlink.c b/sound/soc/sof/intel/hda-mlink.c
index 9a3559c78b62..46f89d6d06f8 100644
--- a/sound/soc/sof/intel/hda-mlink.c
+++ b/sound/soc/sof/intel/hda-mlink.c
@@ -481,6 +481,24 @@ int hdac_bus_eml_get_count(struct hdac_bus *bus, bool alt, int elid)
 }
 EXPORT_SYMBOL_NS(hdac_bus_eml_get_count, SND_SOC_SOF_HDA_MLINK);
 
+void hdac_bus_eml_enable_interrupt_unlocked(struct hdac_bus *bus, bool alt, int elid, bool enable)
+{
+	struct hdac_ext2_link *h2link;
+	struct hdac_ext_link *hlink;
+
+	h2link = find_ext2_link(bus, alt, elid);
+	if (!h2link)
+		return;
+
+	if (!h2link->intc)
+		return;
+
+	hlink = &h2link->hext_link;
+
+	hdaml_link_enable_interrupt(hlink->ml_addr + AZX_REG_ML_LCTL, enable);
+}
+EXPORT_SYMBOL_NS(hdac_bus_eml_enable_interrupt_unlocked, SND_SOC_SOF_HDA_MLINK);
+
 void hdac_bus_eml_enable_interrupt(struct hdac_bus *bus, bool alt, int elid, bool enable)
 {
 	struct hdac_ext2_link *h2link;
-- 
2.43.0


