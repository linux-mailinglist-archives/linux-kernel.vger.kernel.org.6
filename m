Return-Path: <linux-kernel+bounces-536523-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D249A480EB
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 15:23:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3ABD42164F
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 14:11:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25C2423AE7C;
	Thu, 27 Feb 2025 14:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RLe1Oa6w"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8A89238D56;
	Thu, 27 Feb 2025 14:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740665224; cv=none; b=SUEK4YCpZMDdAA69cToCb2P+1anlLCPUKbeNgEohemlQ1Q1Cg8K22i4mpeZumSbPQSkP4lPsHRnpeI3xzGm5zGlr+CoZhC821gj0QWcVWX7HRxrcyiJWtxlyEZQJMfqXt3VwNqDEbGBSvUZcyFwaFZV8YzyuJzujIX23rnA09Pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740665224; c=relaxed/simple;
	bh=n/tmGf7u2M+6dJ0HA/2jjiroZMIY7BNs+wBOXTsMTSg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CRIn7JWZPZ8ha17OQHUPBBt4meT487gRPeZNIBIsnnttSQSC046Vcx7IMwYaU1s9vTVKF3zNKwvG4XZ9x3/44Wg0M42F8WCyIVu1KLhU2Txj+018diOH0uzwEmWzfd6hMFOv+WpMKulXEHLXI024qhkRAMrDwUa7E7qf9ig+cY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RLe1Oa6w; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740665223; x=1772201223;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=n/tmGf7u2M+6dJ0HA/2jjiroZMIY7BNs+wBOXTsMTSg=;
  b=RLe1Oa6wNzxFuAVGdLtmXy82BUbEnAo4rT1VQBk+hxM62QL5p/LOIt7M
   pCk/8gumyYn/9b84DsZPYWXDuAlC7TwrB/15fizv9KGhe+9V0T2TN1hr8
   oVEs7gJg0GxSR4rRYGy1fUF4BUAwtcSeeC6d+0ZZutKx8naw7EnhvNdcv
   sE/tLqU9vxLo1KwWDYw8qiNM0MGynYgZzY+VGVu6VS5qoidsGaFHHggvT
   0B53kVZLCE7ZS0JRN+EBznkFSTURpvD7oJBrBIyv+BqJaw0vLtbg5e28Y
   CUwwOhyCWsyJvV6dm9ZY5pi5O1YpfaBm78X5LdqBVJXGqGIDdGGf7Z829
   g==;
X-CSE-ConnectionGUID: QVV0kOHxRpCGdt6lUv6ukA==
X-CSE-MsgGUID: 4b4w/xfGRpmJYKEGzaIySw==
X-IronPort-AV: E=McAfee;i="6700,10204,11358"; a="41438056"
X-IronPort-AV: E=Sophos;i="6.13,319,1732608000"; 
   d="scan'208";a="41438056"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2025 06:06:45 -0800
X-CSE-ConnectionGUID: 9PrT7f5USlmGnyVniNRbBA==
X-CSE-MsgGUID: 407QkpDTQCutMQwAfEclBQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,319,1732608000"; 
   d="scan'208";a="116831630"
Received: from ssimmeri-mobl2.amr.corp.intel.com (HELO yungchua-desk.intel.com) ([10.124.220.154])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2025 06:06:42 -0800
From: Bard Liao <yung-chuan.liao@linux.intel.com>
To: linux-sound@vger.kernel.org,
	broonie@kernel.org,
	tiwai@suse.de,
	vkoul@kernel.org
Cc: vinod.koul@linaro.org,
	linux-kernel@vger.kernel.org,
	pierre-louis.bossart@linux.dev,
	bard.liao@intel.com
Subject: [PATCH v4 08/16] soundwire: bus: add bpt_stream pointer
Date: Thu, 27 Feb 2025 22:06:07 +0800
Message-ID: <20250227140615.8147-9-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250227140615.8147-1-yung-chuan.liao@linux.intel.com>
References: <20250227140615.8147-1-yung-chuan.liao@linux.intel.com>
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


