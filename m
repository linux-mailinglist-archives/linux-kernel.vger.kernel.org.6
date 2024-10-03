Return-Path: <linux-kernel+bounces-348656-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C72C98EA1C
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 09:09:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E7747B2496C
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 07:09:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FB4613D53F;
	Thu,  3 Oct 2024 07:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dPT12BRD"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 813F1139CE9;
	Thu,  3 Oct 2024 07:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727939263; cv=none; b=WIPQZ6GCm2kz2EXUPMgfo58eEnXC8fsctDzAEGKRusmdAzklafhKMNvpvRqpk+k9ecNX0tZMJ3X4+MRW4V33i9Gq35xGZIzarzlp63PbqwLQM3V9Jds7ayUGraSdWTYijd+PwRnh2BL1hJGe1jNhAWz0etMWVVYpXJBHBvs3fuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727939263; c=relaxed/simple;
	bh=scaVtywZM8FRzxJE7xGyoly1lnhP22/2qGmw6jgkdxg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GjdxaVoJtWe3TUdGLEgBJPLPjf0fRySrjcJdOYylUhXjhV4aDLYZI/5hAheMRqZYfNXoMuT7Gw27aNRZtZXgJJXPxnhmo7M4ysEKDJexoExKXCnJiky25him4a14nXJ6NCsCXgZyZy+7QPGqApNclyPkqck09/1oRI09T6k6lBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dPT12BRD; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727939263; x=1759475263;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=scaVtywZM8FRzxJE7xGyoly1lnhP22/2qGmw6jgkdxg=;
  b=dPT12BRDHIhy6IDukOEte7fi2eiqw3aAi3bPydRwhD2eKK6OuuGyA9fU
   eK1Zr5/ewXILEOlnNJMorK0FjPQGvLebn528eTCcyBIp4KJMEZeQroSsr
   r+baz3rQ8aGzpLFbweIj986/SLLTSlgHf+eEHbBpa316tqi/lE3y6j9bG
   qcbsycdosrXDjjQ+Aobywwb3mr8IfEBA1FyQwrAqySCG3AUoHGl9A7tal
   MeruiPA8T7ba0mL/Q74FKaUZRGZyc5g+ZjTsbBidkYW09xmnxrgW2JA02
   LiSXvHf4niEKWUUjN9Ga8u6OxAsi2fkse0FMvsIOAOp7NZR8q4yv2w0Vc
   g==;
X-CSE-ConnectionGUID: W//G8Q61QCOpuFKKOI9JIA==
X-CSE-MsgGUID: ag61yH/FQKKhQzc/p9FbQQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11213"; a="27070772"
X-IronPort-AV: E=Sophos;i="6.11,173,1725346800"; 
   d="scan'208";a="27070772"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2024 00:07:43 -0700
X-CSE-ConnectionGUID: cHMZSe4MSCWXPooqqMckGw==
X-CSE-MsgGUID: TYpvzF9OTAG2gOTTbwHtrQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,173,1725346800"; 
   d="scan'208";a="74508407"
Received: from anmitta2-mobl4.gar.corp.intel.com (HELO yungchua-desk.intel.com) ([10.247.118.10])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2024 00:07:40 -0700
From: Bard Liao <yung-chuan.liao@linux.intel.com>
To: linux-sound@vger.kernel.org,
	vkoul@kernel.org
Cc: vinod.koul@linaro.org,
	linux-kernel@vger.kernel.org,
	pierre-louis.bossart@linux.dev,
	bard.liao@intel.com
Subject: [PATCH v2 RESEND 08/14] soundwire: mipi-disco: remove DPn audio-modes
Date: Thu,  3 Oct 2024 15:06:44 +0800
Message-ID: <20241003070650.62787-9-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241003070650.62787-1-yung-chuan.liao@linux.intel.com>
References: <20241003070650.62787-1-yung-chuan.liao@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

The concept of DPn audio-modes was never used by anyone, and was
removed from the DisCo for SoundWire 2.0 specification.

Remove the definitions and TODO.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/mipi_disco.c |  2 --
 include/linux/soundwire/sdw.h  | 34 ----------------------------------
 2 files changed, 36 deletions(-)

diff --git a/drivers/soundwire/mipi_disco.c b/drivers/soundwire/mipi_disco.c
index fdab3d4a1379..79cf8212f97a 100644
--- a/drivers/soundwire/mipi_disco.c
+++ b/drivers/soundwire/mipi_disco.c
@@ -304,8 +304,6 @@ static int sdw_slave_read_dpn(struct sdw_slave *slave,
 		fwnode_property_read_u32(node, "mipi-sdw-port-encoding-type",
 					 &dpn[i].port_encoding);
 
-		/* TODO: Read audio mode */
-
 		fwnode_handle_put(node);
 
 		i++;
diff --git a/include/linux/soundwire/sdw.h b/include/linux/soundwire/sdw.h
index cc0afb8af333..66feaa79ecfc 100644
--- a/include/linux/soundwire/sdw.h
+++ b/include/linux/soundwire/sdw.h
@@ -254,41 +254,8 @@ struct sdw_dp0_prop {
 	bool imp_def_interrupts;
 };
 
-/**
- * struct sdw_dpn_audio_mode - Audio mode properties for DPn
- * @bus_min_freq: Minimum bus frequency, in Hz
- * @bus_max_freq: Maximum bus frequency, in Hz
- * @bus_num_freq: Number of discrete frequencies supported
- * @bus_freq: Discrete bus frequencies, in Hz
- * @min_freq: Minimum sampling frequency, in Hz
- * @max_freq: Maximum sampling bus frequency, in Hz
- * @num_freq: Number of discrete sampling frequency supported
- * @freq: Discrete sampling frequencies, in Hz
- * @prep_ch_behave: Specifies the dependencies between Channel Prepare
- * sequence and bus clock configuration
- * If 0, Channel Prepare can happen at any Bus clock rate
- * If 1, Channel Prepare sequence shall happen only after Bus clock is
- * changed to a frequency supported by this mode or compatible modes
- * described by the next field
- * @glitchless: Bitmap describing possible glitchless transitions from this
- * Audio Mode to other Audio Modes
- */
-struct sdw_dpn_audio_mode {
-	u32 bus_min_freq;
-	u32 bus_max_freq;
-	u32 bus_num_freq;
-	u32 *bus_freq;
-	u32 max_freq;
-	u32 min_freq;
-	u32 num_freq;
-	u32 *freq;
-	u32 prep_ch_behave;
-	u32 glitchless;
-};
-
 /**
  * struct sdw_dpn_prop - Data Port DPn properties
- * @audio_modes: Audio modes supported
  * @num: port number
  * @max_word: Maximum number of bits in a Payload Channel Sample, 1 to 64
  * (inclusive)
@@ -318,7 +285,6 @@ struct sdw_dpn_audio_mode {
  * machine
  */
 struct sdw_dpn_prop {
-	struct sdw_dpn_audio_mode *audio_modes;
 	u32 num;
 	u32 max_word;
 	u32 min_word;
-- 
2.43.0


