Return-Path: <linux-kernel+bounces-429524-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 125979E1D63
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 14:19:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB2D7281366
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 13:19:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 001C31F4714;
	Tue,  3 Dec 2024 13:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hkwrZiBh"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA4001F4279;
	Tue,  3 Dec 2024 13:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733231916; cv=none; b=tVgvj3APE/Jmmu613ot8kx0SjAOn2WxIvqAf5uvCMaPvh9JilxXBQNoTYmrt4KE+pgkbudQEfUcPER4Z+4NgRllRzbEbT4jg7nmPEFf9L3WPtVOowL8DPKHxjawPFGOpevyaYLNxEFtl9QkUuqpXNFlE2HNhHusiCU4UOjUaBnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733231916; c=relaxed/simple;
	bh=nUwpBVyWW3nhErV7e7yaO5JiDn7fxwHOdQqKMQIBUYY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aoeoucxf7265UNTUKxEfEtTbJ1RHa/uvQoZaG8o4kyLfzQvb3WbY3jAD7o8NuzuwRb7aHwmH1GHxMOSLk7syuTkC2KrQ04BfvMkdHRr90nEVnsmpU+354N/63COwt1SGBNmRcjlkT01Il0DdwPolEjB9nMK9ZEWUSUXSWwfaO44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hkwrZiBh; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733231915; x=1764767915;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nUwpBVyWW3nhErV7e7yaO5JiDn7fxwHOdQqKMQIBUYY=;
  b=hkwrZiBhILHJSD9qEs8wU2FSmCIkpFIMmAlqkB1sG8h+A8+lWnQv+5Pu
   HB+C3EyzoWeZ+ZiG1j4l32OqjstQcSQShcyTcvnUmw+MUXaJpxdCFmHWg
   Dy+PuCilXxGukm6574eI9yvtkPMU6CY4DYKRUHFwHaSWMak+BYcC80Giv
   AEC4wPkBO1xq2Tt6+X0DgLaP51NuUNZZxsWv/vQzrJxVptfGHUEH9RxId
   Cbsy2tG1FzWQrrRRJDsZ1kbnMSMKsOFJ4eR2+zn0dRznkwUnun54xYvhu
   HCZ3vmCXIXuB4HEt+LUOW5H1HnF8LkmsXNL1HwHF3R8iucr7Y2bEnFvM/
   A==;
X-CSE-ConnectionGUID: pS5GYhNKQDGsPSHyAM8+8A==
X-CSE-MsgGUID: jNiFg8l7ThuIRuPdjm+mIQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11274"; a="33500730"
X-IronPort-AV: E=Sophos;i="6.12,205,1728975600"; 
   d="scan'208";a="33500730"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2024 05:18:34 -0800
X-CSE-ConnectionGUID: n7Ux+6meR/uyYTMigesk1w==
X-CSE-MsgGUID: AtqfwkQfQhaBsk0vmnVxiw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,205,1728975600"; 
   d="scan'208";a="130896077"
Received: from ccbilbre-mobl3.amr.corp.intel.com (HELO yungchua-desk.intel.com) ([10.124.223.75])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2024 05:18:33 -0800
From: Bard Liao <yung-chuan.liao@linux.intel.com>
To: linux-sound@vger.kernel.org,
	vkoul@kernel.org
Cc: vinod.koul@linaro.org,
	linux-kernel@vger.kernel.org,
	pierre-louis.bossart@linux.dev,
	bard.liao@intel.com
Subject: [PATCH v2 04/14] soundwire: stream: set DEPREPARED state earlier
Date: Tue,  3 Dec 2024 21:18:03 +0800
Message-ID: <20241203131813.58454-5-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241203131813.58454-1-yung-chuan.liao@linux.intel.com>
References: <20241203131813.58454-1-yung-chuan.liao@linux.intel.com>
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
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
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
2.43.0


