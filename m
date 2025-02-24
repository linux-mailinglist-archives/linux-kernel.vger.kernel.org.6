Return-Path: <linux-kernel+bounces-528268-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C5549A4159E
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 07:45:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8562816EB72
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 06:45:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CD5F24166D;
	Mon, 24 Feb 2025 06:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lWdhLEVP"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6914C1C8632;
	Mon, 24 Feb 2025 06:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740379523; cv=none; b=IVwUsXNU0SGa1mK7cXJmUrfRthidWfa/w5WX9fitNpeBOSZRpJyP3fnX5D9sDbfxyAG3Y/tS8bRqhu1AgmPzprtmhdVJQeAhBwVUE2FMqIuuNaVzuyfX/AH2Mijwsh9w/SaeJ6adGsXEs+IUz2Oc4WzfcLrL5N5zavseIKZ9pL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740379523; c=relaxed/simple;
	bh=HSF+H1PDIlrUCc++S+iDhYzlOmMHnlfrSJQjr96Q2lo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q8M5+JmfE45g1sJTWx7DV++DwzmGcc3iysyo30FubyuLFzuy7ZB7nHdfWd2Wi6J28jCRdAZTr8isE6gFCZ0l/+SbpNBTHdJxkpQWZCtFOjSi98gFLxRuVIbuc8j73eAvpOytlcQZ3rYIK0EVTopyExrPIfa783CADyfn8HN8BfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lWdhLEVP; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740379522; x=1771915522;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HSF+H1PDIlrUCc++S+iDhYzlOmMHnlfrSJQjr96Q2lo=;
  b=lWdhLEVPBUeRrzI+pBak2wXHo0dv9Nol3gZW1FIGztWfBFvEWT7yZNmA
   9O5zCTjvdUeQd1yJSZg5+a2Lf38bUi33as3RZGelzSFkaYo0hmRaBFALr
   7mo0c6pbOv+XhWJqo+J6JIZxPhPTlaEUprqNzux87QGZ6I+0x14ELeV+H
   K6/TvL/tr4rlzUob30fe7XbYekTLitc3Al0H5DFzXOt5DQVVxIKNysNrh
   XrE1c/welJ4wtTHWrCyz3oo4xWhOk7D8LA2xKeURxS2AFTOlhw41Yv0u7
   Yl0XgYM+eRqs4MvJF/WtTK3OHK7SZRjjUsRFMr7xTu8zxkjkOmH/5AEMJ
   w==;
X-CSE-ConnectionGUID: fRMty6nxQ4GD4VTO+d6T5w==
X-CSE-MsgGUID: xGmyOoYuSxebCX8KxXL7LQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11354"; a="58538930"
X-IronPort-AV: E=Sophos;i="6.13,309,1732608000"; 
   d="scan'208";a="58538930"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2025 22:45:22 -0800
X-CSE-ConnectionGUID: gL1Dm1gGS9KDJ/IvYe82xQ==
X-CSE-MsgGUID: L+dgnO3zRQqfuNkQmVZLRQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,309,1732608000"; 
   d="scan'208";a="120597676"
Received: from ssimmeri-mobl2.amr.corp.intel.com (HELO yungchua-desk.intel.com) ([10.124.222.232])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2025 22:45:20 -0800
From: Bard Liao <yung-chuan.liao@linux.intel.com>
To: linux-sound@vger.kernel.org,
	broonie@kernel.org,
	tiwai@suse.de,
	vkoul@kernel.org
Cc: vinod.koul@linaro.org,
	linux-kernel@vger.kernel.org,
	pierre-louis.bossart@linux.dev,
	bard.liao@intel.com
Subject: [PATCH v2 03/16] soundwire: extend sdw_stream_type to BPT
Date: Mon, 24 Feb 2025 14:44:37 +0800
Message-ID: <20250224064451.33772-4-yung-chuan.liao@linux.intel.com>
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

BPT/BRA need to be special cased, i.e. there's no point in using the
bandwidth allocation since the entire frame can be used.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Reviewed-by: Péter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Liam Girdwood <liam.r.girdwood@intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
---
 include/linux/soundwire/sdw.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/include/linux/soundwire/sdw.h b/include/linux/soundwire/sdw.h
index 2d6c30317792..857b670eb9a5 100644
--- a/include/linux/soundwire/sdw.h
+++ b/include/linux/soundwire/sdw.h
@@ -150,12 +150,14 @@ enum sdw_dpn_pkg_mode {
  *
  * @SDW_STREAM_PCM: PCM data stream
  * @SDW_STREAM_PDM: PDM data stream
+ * @SDW_STREAM_BPT: BPT data stream
  *
  * spec doesn't define this, but is used in implementation
  */
 enum sdw_stream_type {
 	SDW_STREAM_PCM = 0,
 	SDW_STREAM_PDM = 1,
+	SDW_STREAM_BPT = 2,
 };
 
 /**
@@ -879,7 +881,7 @@ struct sdw_port_config {
  * @ch_count: Channel count of the stream
  * @bps: Number of bits per audio sample
  * @direction: Data direction
- * @type: Stream type PCM or PDM
+ * @type: Stream type PCM, PDM or BPT
  */
 struct sdw_stream_config {
 	unsigned int frame_rate;
@@ -929,7 +931,7 @@ struct sdw_stream_params {
  * @name: SoundWire stream name
  * @params: Stream parameters
  * @state: Current state of the stream
- * @type: Stream type PCM or PDM
+ * @type: Stream type PCM, PDM or BPT
  * @m_rt_count: Count of Master runtime(s) in this stream
  * @master_list: List of Master runtime(s) in this stream.
  * master_list can contain only one m_rt per Master instance
-- 
2.43.0


