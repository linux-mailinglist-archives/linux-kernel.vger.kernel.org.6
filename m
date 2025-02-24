Return-Path: <linux-kernel+bounces-528273-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 867C7A415A5
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 07:46:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1CD63B50BA
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 06:46:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A6AA245011;
	Mon, 24 Feb 2025 06:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bmeBXjY0"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1A93242914;
	Mon, 24 Feb 2025 06:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740379532; cv=none; b=DAyRCf2o0mweF4tOkwQJd1wT24vG9jdAdAKNg1zj8MizE4gHk0sMcGpYB4QF300iqPEd2mLw0V04YeyvBHZQ70jN7M5sfxn4sYvVRU+AEO/NDJN6OC4cJdrb+qUbYjWU7KK6TMNcUPlPPwmpwmaM+tSI7ZZchoVQBM2U3rizvrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740379532; c=relaxed/simple;
	bh=n/tmGf7u2M+6dJ0HA/2jjiroZMIY7BNs+wBOXTsMTSg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GzGDjDN1MFBKtVtadLU1rdvw8lCy8Lnoavi2EQwFjViH2XMV28FWO1j9zzcieI1xXHa6hTxAtd+gMSVtgp/sryVgc1GQ80Rmvf+ZlCK3IUa/IgwDJh1ny/XI6GAhm7+aNZhFelZXf0JOPm51hN0OjJlZLkI9Fmdy6F4o3NsFXHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bmeBXjY0; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740379531; x=1771915531;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=n/tmGf7u2M+6dJ0HA/2jjiroZMIY7BNs+wBOXTsMTSg=;
  b=bmeBXjY0IyPp1syFJfQdMSGd7MRUmmyUiD9NVkpOaoGdsrnKY/y2Nieg
   3fe5BAm0LxGQB2+X5+m1IFRu8TAZd8dyz5bl23H6RER8EFtqnwG4AnYq9
   MqJJjPzWQGkbGQ33iSR2QVpeMFLIh5eIOccFlvt3bSEw+fKq8r3fAp9DP
   wC+mpTd0RwaLT2M9IU5fZ3eC/0srM/fUb3V8bR71cVAGlTzjyA0q8JY7/
   2V4zKpyzaaL+nVoI4KDmEq7bD3iTE9NMa51znP+ECSzBzcmU281PeMkkC
   9exISPVYZbUwk7rikOMRAS/iJeUrPvZw+jgtI9msbFMkIFkvtvFBwu32K
   Q==;
X-CSE-ConnectionGUID: SPUgEGYYQ2mSe8MFIWkHvw==
X-CSE-MsgGUID: Nedhb743TL6LaQTqIsQngg==
X-IronPort-AV: E=McAfee;i="6700,10204,11354"; a="58538960"
X-IronPort-AV: E=Sophos;i="6.13,309,1732608000"; 
   d="scan'208";a="58538960"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2025 22:45:30 -0800
X-CSE-ConnectionGUID: 7MqRpvGAQMKmQN28B1nIbQ==
X-CSE-MsgGUID: lgw/sC0OROaFkTbEIhfBgw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,309,1732608000"; 
   d="scan'208";a="120597717"
Received: from ssimmeri-mobl2.amr.corp.intel.com (HELO yungchua-desk.intel.com) ([10.124.222.232])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2025 22:45:29 -0800
From: Bard Liao <yung-chuan.liao@linux.intel.com>
To: linux-sound@vger.kernel.org,
	broonie@kernel.org,
	tiwai@suse.de,
	vkoul@kernel.org
Cc: vinod.koul@linaro.org,
	linux-kernel@vger.kernel.org,
	pierre-louis.bossart@linux.dev,
	bard.liao@intel.com
Subject: [PATCH v2 08/16] soundwire: bus: add bpt_stream pointer
Date: Mon, 24 Feb 2025 14:44:42 +0800
Message-ID: <20250224064451.33772-9-yung-chuan.liao@linux.intel.com>
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

Add a convenience pointer to the 'sdw_bus' structure. BPT is a
dedicated stream which will typically not be handled by DAIs or
dailinks. Since there's only one BPT stream per link, storing the
pointer at the link level seems rather natural.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Reviewed-by: Péter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Liam Girdwood <liam.r.girdwood@intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
---
 include/linux/soundwire/sdw.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/soundwire/sdw.h b/include/linux/soundwire/sdw.h
index 69f3e700796d..2362f621d94c 100644
--- a/include/linux/soundwire/sdw.h
+++ b/include/linux/soundwire/sdw.h
@@ -979,6 +979,7 @@ struct sdw_stream_runtime {
  * @stream_refcount: number of streams currently using this bus
  * @btp_stream_refcount: number of BTP streams currently using this bus (should
  * be zero or one, multiple streams per link is not supported).
+ * @bpt_stream: pointer stored to handle BTP streams.
  * @ops: Master callback ops
  * @port_ops: Master port callback ops
  * @prop: Master properties
@@ -1017,6 +1018,7 @@ struct sdw_bus {
 	struct sdw_bus_params params;
 	int stream_refcount;
 	int bpt_stream_refcount;
+	struct sdw_stream_runtime *bpt_stream;
 	const struct sdw_master_ops *ops;
 	const struct sdw_master_port_ops *port_ops;
 	struct sdw_master_prop prop;
-- 
2.43.0


