Return-Path: <linux-kernel+bounces-536109-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F88BA47B9A
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 12:15:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E165164364
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 11:13:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE2F222DFAE;
	Thu, 27 Feb 2025 11:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ELITNdbb"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD5F422D7A5;
	Thu, 27 Feb 2025 11:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740654720; cv=none; b=PfNBXDCKftwoFz3ponBrWILxziKUxtri9rQK2Jv724cQlTcohL6YS5hhbt5zcdNke6UYEyhQsQu9jjYLSVbJPudZumU+rRzTP9JJjSa41FpBlsMfumcsgFyff3RuW/gp478kLL1ueMe2Zd5F8pZKELj2bN0qwxUSwgzgWRZUPZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740654720; c=relaxed/simple;
	bh=n/tmGf7u2M+6dJ0HA/2jjiroZMIY7BNs+wBOXTsMTSg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NTEEEH8d6phgsKvnpu1r0qGqknrg7G3gGB9dHhtkOqYsqSanVpiJVE4uS2Iz+a9uC6QFL05nT7WufAMnB2aOgibaZ6Bw2OUc+1+snDC4plaq5O5uRQr7NZ7cuQ3xi/uilvlHCB7n61NKupKNvHlhtEkjEavTJkth64svESO9k4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ELITNdbb; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740654719; x=1772190719;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=n/tmGf7u2M+6dJ0HA/2jjiroZMIY7BNs+wBOXTsMTSg=;
  b=ELITNdbbIIDQM5x4o+EkpP6U7zbCilyCAwX4iJv5T/laO65Lw9ivWBa3
   aO1XKwtuWORlYBuz+MnHnrhMNZ0ci0wvn/0wXYD/vRMMvfk7146fhG8Jx
   PnWE8LC0UDkNXKVo8SeptLTUSWWxGNBswBzupum4tqWiVy/pgaWRtkrsA
   q6MGkzZ+v+MaNLMKPgM7gkKPCfA/xqn7zvam7Q98N0m8ztarpKsZq7Tro
   KdlIRCqEA1sAOuu18wWKSDu2Ehc5z9xlsFiAjVSYS2R39MHntT4LK2mLl
   UELAntG2S94AyqWAljLOQ42Z7vWJtT0RScv0Tob7OlDb8jXhF+j5vDmIp
   A==;
X-CSE-ConnectionGUID: 7fLxQkzQTqW1QQUKLWA1xg==
X-CSE-MsgGUID: xIw9/EG8R4qd/aHqSEmeFw==
X-IronPort-AV: E=McAfee;i="6700,10204,11357"; a="45189847"
X-IronPort-AV: E=Sophos;i="6.13,319,1732608000"; 
   d="scan'208";a="45189847"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2025 03:11:58 -0800
X-CSE-ConnectionGUID: yxNyzOcSTja7Ab8Lm01fGg==
X-CSE-MsgGUID: snOjoSsgSGKEiR/LUOhEQg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="154179006"
Received: from johunt-mobl9.ger.corp.intel.com (HELO yungchua-desk.intel.com) ([10.124.220.110])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2025 03:11:56 -0800
From: Bard Liao <yung-chuan.liao@linux.intel.com>
To: linux-sound@vger.kernel.org,
	broonie@kernel.org,
	tiwai@suse.de,
	vkoul@kernel.org
Cc: vinod.koul@linaro.org,
	linux-kernel@vger.kernel.org,
	pierre-louis.bossart@linux.dev,
	bard.liao@intel.com
Subject: [PATCH v3 08/16] soundwire: bus: add bpt_stream pointer
Date: Thu, 27 Feb 2025 19:11:21 +0800
Message-ID: <20250227111130.272698-9-yung-chuan.liao@linux.intel.com>
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


