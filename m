Return-Path: <linux-kernel+bounces-536519-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 03E53A480A0
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 15:12:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64AEB3B89AE
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 14:10:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1EC723816C;
	Thu, 27 Feb 2025 14:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n3r6k2Ix"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4310236A9C;
	Thu, 27 Feb 2025 14:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740665221; cv=none; b=B0YQj9whWFmD13zaE7aJRYdtLQtq06a2/q1vMK4dCSA2NLKJl5ptET4S6aGFKTRFTbK+ws3S8t9Ji3iHShywhb3evc0quaovl8hnWcJxTifjjhUka3yUuH+Gqa6hVNx2HrzjkzG8bpmkGLBgo9ozIiGFr4I7/DP7GsrvewYTMzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740665221; c=relaxed/simple;
	bh=HSF+H1PDIlrUCc++S+iDhYzlOmMHnlfrSJQjr96Q2lo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Xwq3k7q9Rqvc09avoj1PDF17LoOPjTl22af7PCZ+by7VyMi/FdejIa6L6A/eAfj7pDpBYvTHYmIW/jA2/A9xlpuSKCrMFtLDEsU6yYWHkZAnCTnlHM+vdr7DGmWFS3SDztoqxBpYNoG04NK5TAefKyLG1cM6QZ2+ACgEBaM7Bfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=n3r6k2Ix; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740665220; x=1772201220;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HSF+H1PDIlrUCc++S+iDhYzlOmMHnlfrSJQjr96Q2lo=;
  b=n3r6k2Ixw3nvmJvU+CDBsFBKl70/yb/JBu+zMV/baRWAxgsIFEip+Pgk
   vshxl+YcI8sB4/4VarIYj5nusnXM9ngnUylRRdCQCpv2xJTsq95HNLATa
   GcR7tv3qKCiTUyOLVQeL/IsPyd7SxPCXGOrK+V8v/vq3+sFZ3/rA6N5s8
   397Ol+AijTVqFsJD6/D8KOK/Y2dWdHvvZ5ctqCRhYXMmIj6g8TbGkr82M
   MKOPE88jVTFo9CpKskLAeLQGzkAHROoCXtBVwpnNV5jUVmrJ/QhLdzE4q
   aQwfh3rCOVdUCHMEKreTue/BxscenJGRt+P9t5+mfbEsqEddm6JPCuOVr
   A==;
X-CSE-ConnectionGUID: vU/Lp+2kT86B9dpwD8GSfw==
X-CSE-MsgGUID: +thmmeTaQrKCIVnPI1FyrA==
X-IronPort-AV: E=McAfee;i="6700,10204,11358"; a="41438004"
X-IronPort-AV: E=Sophos;i="6.13,319,1732608000"; 
   d="scan'208";a="41438004"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2025 06:06:35 -0800
X-CSE-ConnectionGUID: J/YtT1XWSCKvidu1qs9cjw==
X-CSE-MsgGUID: djWZOb33QfOjabb0JYmdQg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,319,1732608000"; 
   d="scan'208";a="116831555"
Received: from ssimmeri-mobl2.amr.corp.intel.com (HELO yungchua-desk.intel.com) ([10.124.220.154])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2025 06:06:32 -0800
From: Bard Liao <yung-chuan.liao@linux.intel.com>
To: linux-sound@vger.kernel.org,
	broonie@kernel.org,
	tiwai@suse.de,
	vkoul@kernel.org
Cc: vinod.koul@linaro.org,
	linux-kernel@vger.kernel.org,
	pierre-louis.bossart@linux.dev,
	bard.liao@intel.com
Subject: [PATCH v4 03/16] soundwire: extend sdw_stream_type to BPT
Date: Thu, 27 Feb 2025 22:06:02 +0800
Message-ID: <20250227140615.8147-4-yung-chuan.liao@linux.intel.com>
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


