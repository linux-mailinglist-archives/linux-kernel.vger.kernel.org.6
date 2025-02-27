Return-Path: <linux-kernel+bounces-536104-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 43629A47B8D
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 12:13:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4B5677A5A6A
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 11:11:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 693AC22CBD8;
	Thu, 27 Feb 2025 11:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Onz1juQ7"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32E1622A80B;
	Thu, 27 Feb 2025 11:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740654709; cv=none; b=LJv5ihvDSuZdQhU3I7nqA1d+O38bFS+OvagwhQ3yR4izg86BoIjIX3dR1YzHA49Xuyj6NTMQElkSoK+Kqbmo9UgM987K3PmdQ+SQCCk3SYw2K8TyUQZqh8RiwWg5uSW/P1A4fqqlQjix9fLt3YX27xNXz2zu1rMOa1YWIjSQqyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740654709; c=relaxed/simple;
	bh=HSF+H1PDIlrUCc++S+iDhYzlOmMHnlfrSJQjr96Q2lo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y70gXpOMlWEFg0LvRCK80LJ+TNd+rUTe7PO3imnP40Bubz5p+bLwvRSk+SVtA43IxLESQK6Zt9SyrLzZU3ShGXHhvFW5EzuJ1s+PmIPo26KZKHaUtemAfSXgdO235Ejwv+i8khxvsdRoM1ToE2ajS/KbMxf64nyQhkNO4qRcxAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Onz1juQ7; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740654708; x=1772190708;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HSF+H1PDIlrUCc++S+iDhYzlOmMHnlfrSJQjr96Q2lo=;
  b=Onz1juQ75svVlI87k57GpLGlIGg/U7uVzQWdRFpMvVv1TziRU666L7C1
   bi//ZqRfmbj6fkwq4+1Sw1/Egy1zMr4g/xVpGf6jNwxNiMVJi4hbyaHEc
   FXFxhKVxMaN2VT3K/p8fBdNkR+qA8WgOoDu0Xm4xeZ/YhRFcRtyRfXzbd
   dKVfuR2Dz5Icej4GgeqiPAdZEixj/WaTL4iOCu1vwLTh/1jeCtsMbzKS7
   7AoP0oq9QipqhoHy8ntcVnra1aEwffr5dC4AXairFoD/izFU2X+6lLTAY
   WQdUa/jGEtg9FeihTGWtZx/wseUHdpeeDuU79Uhy74fUSRVbHYBL2nmQ7
   Q==;
X-CSE-ConnectionGUID: Wr0keiuETYyWAjLR7IUzgw==
X-CSE-MsgGUID: rWOFNnDGTGCYzgqXFrRXeg==
X-IronPort-AV: E=McAfee;i="6700,10204,11357"; a="45189803"
X-IronPort-AV: E=Sophos;i="6.13,319,1732608000"; 
   d="scan'208";a="45189803"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2025 03:11:48 -0800
X-CSE-ConnectionGUID: uxJSRMX/QFWa96kzMCuBSw==
X-CSE-MsgGUID: dC2FZylaR7mdSlpeDsrhrw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="154178928"
Received: from johunt-mobl9.ger.corp.intel.com (HELO yungchua-desk.intel.com) ([10.124.220.110])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2025 03:11:46 -0800
From: Bard Liao <yung-chuan.liao@linux.intel.com>
To: linux-sound@vger.kernel.org,
	broonie@kernel.org,
	tiwai@suse.de,
	vkoul@kernel.org
Cc: vinod.koul@linaro.org,
	linux-kernel@vger.kernel.org,
	pierre-louis.bossart@linux.dev,
	bard.liao@intel.com
Subject: [PATCH v3 03/16] soundwire: extend sdw_stream_type to BPT
Date: Thu, 27 Feb 2025 19:11:16 +0800
Message-ID: <20250227111130.272698-4-yung-chuan.liao@linux.intel.com>
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


