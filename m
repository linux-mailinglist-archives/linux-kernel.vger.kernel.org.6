Return-Path: <linux-kernel+bounces-394151-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BAE29BAB35
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 04:24:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 946AAB21518
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 03:24:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F486189F32;
	Mon,  4 Nov 2024 03:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OX3eIFZ2"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E88161779B8;
	Mon,  4 Nov 2024 03:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730690640; cv=none; b=AGVe13Wp9WVhRXdzFauBfvBn0oUFUPpr2+02+3dEwJyLZuA/OFgRTUVkzZt3zAKbIs9AkEL24uypKeMJ/b0FtnT/lwOxCPIcQU+pka5vFlBrz0OfR1TUTxeTGyAkgtn6JCLY0xpM/I2ta97z75TbwbyLFLSWN7unVdwab+SO3wU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730690640; c=relaxed/simple;
	bh=hert8xvAlv41PLjcCm3Et18/iJ0pw9qwoJ2UTrU2Hwk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TK3XxP+N32sdR7GmyQtN5cbzNIinQxEiZ5XDaYYR0mN3f0EaVsYAV53Wn9TrHG2J5Y/gkzcPlAUUa/KGXTh6yp/TrtMJTCGVqlaFFGhZ164U4Xw4cqhEsT/c3dxa8YZJ9BLYfYeCFIkA85kIDKzwrM0nObgP5q9mzIm/AbetPJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OX3eIFZ2; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730690639; x=1762226639;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hert8xvAlv41PLjcCm3Et18/iJ0pw9qwoJ2UTrU2Hwk=;
  b=OX3eIFZ2RvVkb2Hpf7r6BjjE/AmYVqxY5joNBbmqOlCaMC873D0BARkA
   p3wK0aDECyKNmsCDvgMsuUzUtOUTNDHBiI7zC3qhVZiqQQ0Bap8/k/xkE
   WTvNLjFNiwLeU0b0kitalHz5ZGstvAatJcQ69w3XAKMd0tmA6IcJXS3ba
   QdDicULytbJEFqayE6S7LWpWuqX1o0J6to4PtPI1L/1GAjO/XJbKImZTV
   1nQdp4+91RDo28LeOpRgnRXkAA2Xgbr83hwFgRpKPrGxggtiszyAECErD
   salcjiPBsVCOGUC4t+3R30zm+2jHgWLcLF9p6HIE8d6U6wFUP/A0f9kFz
   A==;
X-CSE-ConnectionGUID: Ah4KncKrQxC0t/99AH3CLQ==
X-CSE-MsgGUID: u4pGJS8HTG+ah8AvKpqFlw==
X-IronPort-AV: E=McAfee;i="6700,10204,11245"; a="30594281"
X-IronPort-AV: E=Sophos;i="6.11,256,1725346800"; 
   d="scan'208";a="30594281"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2024 19:23:56 -0800
X-CSE-ConnectionGUID: 5JjPqjQDQBiW12b0hk2Ghw==
X-CSE-MsgGUID: OponI1C9SnajxdPYI/tmEw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,256,1725346800"; 
   d="scan'208";a="114331803"
Received: from yungchua-ws.ostc.intel.com (HELO yungchua-ws.intel.com) ([10.54.69.90])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2024 19:23:56 -0800
From: Bard Liao <yung-chuan.liao@linux.intel.com>
To: linux-sound@vger.kernel.org,
	vkoul@kernel.org
Cc: vinod.koul@linaro.org,
	linux-kernel@vger.kernel.org,
	pierre-louis.bossart@linux.dev,
	bard.liao@intel.com
Subject: [PATCH 04/12] soundwire: stream: set DEPREPARED state earlier
Date: Mon,  4 Nov 2024 03:23:50 +0000
Message-Id: <20241104032358.669705-5-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241104032358.669705-1-yung-chuan.liao@linux.intel.com>
References: <20241104032358.669705-1-yung-chuan.liao@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>

The existing logic is problematic in that we deprepare all the ports,
but still take into account the stream for bit allocation by just
walking through the bus->m_rt list.

This patch sets the state earlier, so that such DEPREPARED streams can
be skipped in the bandwidth allocation (to be implemented in a
follow-up patch).

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
---
 drivers/soundwire/stream.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/soundwire/stream.c b/drivers/soundwire/stream.c
index 7aa4900dcf31..795017c8081a 100644
--- a/drivers/soundwire/stream.c
+++ b/drivers/soundwire/stream.c
@@ -1643,8 +1643,15 @@ static int _sdw_deprepare_stream(struct sdw_stream_runtime *stream)
 {
 	struct sdw_master_runtime *m_rt;
 	struct sdw_bus *bus;
+	int state = stream->state;
 	int ret = 0;
 
+	/*
+	 * first mark the state as DEPREPARED so that it is not taken into account
+	 * for bit allocation
+	 */
+	stream->state = SDW_STREAM_DEPREPARED;
+
 	list_for_each_entry(m_rt, &stream->master_list, stream_node) {
 		bus = m_rt->bus;
 		/* De-prepare port(s) */
@@ -1652,6 +1659,7 @@ static int _sdw_deprepare_stream(struct sdw_stream_runtime *stream)
 		if (ret < 0) {
 			dev_err(bus->dev,
 				"De-prepare port(s) failed: %d\n", ret);
+			stream->state = state;
 			return ret;
 		}
 
@@ -1665,6 +1673,7 @@ static int _sdw_deprepare_stream(struct sdw_stream_runtime *stream)
 			if (ret < 0) {
 				dev_err(bus->dev, "Compute params failed: %d\n",
 					ret);
+				stream->state = state;
 				return ret;
 			}
 		}
@@ -1673,11 +1682,11 @@ static int _sdw_deprepare_stream(struct sdw_stream_runtime *stream)
 		ret = sdw_program_params(bus, false);
 		if (ret < 0) {
 			dev_err(bus->dev, "%s: Program params failed: %d\n", __func__, ret);
+			stream->state = state;
 			return ret;
 		}
 	}
 
-	stream->state = SDW_STREAM_DEPREPARED;
 	return do_bank_switch(stream);
 }
 
-- 
2.34.1


