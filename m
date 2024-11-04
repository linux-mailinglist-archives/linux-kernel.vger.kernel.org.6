Return-Path: <linux-kernel+bounces-394154-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 037E79BAB38
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 04:25:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35D8E1C214D4
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 03:25:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A44118CC1B;
	Mon,  4 Nov 2024 03:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LdR023oj"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6810B16D9AA;
	Mon,  4 Nov 2024 03:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730690642; cv=none; b=mvK7CUhmcPnsFlhFYs5/a1SMpE+E3VWo9i9eIG6SwP/8V6i2z6FloIxpA15IHxSEArsIx2yI6CQ7QmSoI5De6syK8RF02jIOASoNzt61+U9wMd4vDiYZxTQE+WhqtRPXSO0ewFv6sHltxaY5yox4dHYUI42P7FIGZyFXpdiRuZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730690642; c=relaxed/simple;
	bh=enGqaKOvLCvbtuKXzuf5hTbeFXMHB/bu9jBUui/cIL0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nFZafNOn+tXIL4IfTpxVaHMIjUDcJ5Z86Jw+l2qWuS5Vod7acuBzZOo8M797pLEtoJ3gHN/PulJwYKUGDgP/I1t23uI2Skb7N+t94OKPvjVN8jpQ2ykd+t8c9jy2fhPlhAiWg5UUTSI6pLuMiGsjiRpCJee0xTWyDv5W96Uq6CM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LdR023oj; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730690638; x=1762226638;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=enGqaKOvLCvbtuKXzuf5hTbeFXMHB/bu9jBUui/cIL0=;
  b=LdR023oj116inNNgGGHBYRiIlBJaJeqYkEITmvP0M8jtLwxkVirp8kHy
   4FGyx7XRNv50XGGU5Irciy9Nld+Qq2W6e0oPBHbpez0D+Kh/FCZioNzwx
   nTuOEoFCq4f0c/H9AtKhXLr1pL69bmKDiMZQeLYsJlfUHIQG2ZDESuzAo
   8nfvkg6M8NGOCsSonu1Yd8/D6om6QrFChFaQ6aQhWL3GH7qeIro8G20EN
   ignnY0Qx9D3IYSW4IEIc6HgONWaJH7y024dchOqBosKfMlJUc4wlxVMo1
   N9XormmgjVnpPkqN48kGSIZTm1BAurDWoAJfYdf1NAhydwpSlcQuIVdHj
   Q==;
X-CSE-ConnectionGUID: 87eBFuqNQF+kBBuvJtVtZA==
X-CSE-MsgGUID: aGubKluuTDmbnPDEGRA/+A==
X-IronPort-AV: E=McAfee;i="6700,10204,11245"; a="30594276"
X-IronPort-AV: E=Sophos;i="6.11,256,1725346800"; 
   d="scan'208";a="30594276"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2024 19:23:56 -0800
X-CSE-ConnectionGUID: tF7DJWrjTcG3tjexPIYByg==
X-CSE-MsgGUID: B1y+NqxIR7OYEuI2AdNwnw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,256,1725346800"; 
   d="scan'208";a="114331798"
Received: from yungchua-ws.ostc.intel.com (HELO yungchua-ws.intel.com) ([10.54.69.90])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2024 19:23:56 -0800
From: Bard Liao <yung-chuan.liao@linux.intel.com>
To: linux-sound@vger.kernel.org,
	vkoul@kernel.org
Cc: vinod.koul@linaro.org,
	linux-kernel@vger.kernel.org,
	pierre-louis.bossart@linux.dev,
	bard.liao@intel.com
Subject: [PATCH 03/12] soundwire: add lane_used_bandwidth in struct sdw_bus
Date: Mon,  4 Nov 2024 03:23:49 +0000
Message-Id: <20241104032358.669705-4-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241104032358.669705-1-yung-chuan.liao@linux.intel.com>
References: <20241104032358.669705-1-yung-chuan.liao@linux.intel.com>
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
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>
---
 include/linux/soundwire/sdw.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/soundwire/sdw.h b/include/linux/soundwire/sdw.h
index 928d56cd7e6d..e059d5330b11 100644
--- a/include/linux/soundwire/sdw.h
+++ b/include/linux/soundwire/sdw.h
@@ -889,6 +889,7 @@ struct sdw_master_ops {
  * @multi_link: Store bus property that indicates if multi links
  * are supported. This flag is populated by drivers after reading
  * appropriate firmware (ACPI/DT).
+ * @lane_used_bandwidth: how much bandwidth in bits per second is used by each lane
  */
 struct sdw_bus {
 	struct device *dev;
@@ -920,6 +921,7 @@ struct sdw_bus {
 	struct dentry *debugfs;
 #endif
 	bool multi_link;
+	unsigned int lane_used_bandwidth[SDW_MAX_LANES];
 };
 
 int sdw_bus_master_add(struct sdw_bus *bus, struct device *parent,
-- 
2.34.1


