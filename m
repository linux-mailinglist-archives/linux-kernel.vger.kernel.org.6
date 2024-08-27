Return-Path: <linux-kernel+bounces-303381-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B8EDB960B60
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 15:09:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E70A1F220FF
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 13:09:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18D7A1C4601;
	Tue, 27 Aug 2024 13:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nZCOcbX3"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF3111BD51F;
	Tue, 27 Aug 2024 13:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724764096; cv=none; b=VfNW68BA8ut49CF7cSMP52m/4+qD1E2VTdCKxIceBjztMwkCwAAO/Q49WKu2jjPeiUxILrP6kMd6mpeiM/XUi8P42dspyt6LRnYMuMu3Qgp050nR5CWhpXylW0Xw7Qe24MTIvotHzBLhcxWeWOEKn1yw5ejeJTC0a5cWnHLYhlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724764096; c=relaxed/simple;
	bh=scaVtywZM8FRzxJE7xGyoly1lnhP22/2qGmw6jgkdxg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h93fSNcFh99fRmVHUG3kYl/lfbdBRNoSlq8WjY0cuCXU8XPJpZxXNVftIFPri3udEVUPLiBE0Tco8ASuK7cVQiZsnmsH7wajmrBQKzdO/Ox5KI+heau1EAgMflXV5y9WRMRBld+RsWZzGVlpc/oCExvyu+p9uJf7sdKqQ0QNpps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nZCOcbX3; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724764095; x=1756300095;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=scaVtywZM8FRzxJE7xGyoly1lnhP22/2qGmw6jgkdxg=;
  b=nZCOcbX34cZ9QZBsk8hvRAzsNbiJx4MkmeIJcLfTqBvlDzUZpfmmLnQT
   Z5QrloeAnJkdaGNZ4pWQv4lQaXe0Q4eeK5bu2F81XNKTFIAzxuFaZaE+Z
   fkyvsVWQGzVP6ncXqRl2QzT9i86Zh4yITWyn221xvv03fxYIYSa77mwcU
   BTE8haGRzlsahLvzyAwksY6wKVkym5yzhI3vjqmndXOTbhBFRI61rHtNY
   hbyZgsstCcL4Za8DZW/ATWXnfazyXJ+saB4Pchyao3+P0lj8RIY8XX4kv
   GlomQliWvmjM7bpH61mKKq20iWwHJ4Tn9RohcBcRRwERaNxFTOZYv7RcN
   g==;
X-CSE-ConnectionGUID: uIhLvMnVSgOhSksnw8gLAQ==
X-CSE-MsgGUID: cngoMHcHR0+9O67xTZi/Tw==
X-IronPort-AV: E=McAfee;i="6700,10204,11176"; a="23400595"
X-IronPort-AV: E=Sophos;i="6.10,180,1719903600"; 
   d="scan'208";a="23400595"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2024 06:08:14 -0700
X-CSE-ConnectionGUID: LxqvbIUjS+OANqY50uZCZw==
X-CSE-MsgGUID: wnSwDm6hRVSlqxCY2wgzvQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,180,1719903600"; 
   d="scan'208";a="67551983"
Received: from anmitta2-mobl4.gar.corp.intel.com (HELO yungchua-desk.intel.com) ([10.247.118.39])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2024 06:08:13 -0700
From: Bard Liao <yung-chuan.liao@linux.intel.com>
To: linux-sound@vger.kernel.org,
	vkoul@kernel.org
Cc: vinod.koul@linaro.org,
	linux-kernel@vger.kernel.org,
	pierre-louis.bossart@linux.intel.com,
	bard.liao@intel.com
Subject: [PATCH 08/14] soundwire: mipi-disco: remove DPn audio-modes
Date: Tue, 27 Aug 2024 21:07:01 +0800
Message-ID: <20240827130707.298477-9-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240827130707.298477-1-yung-chuan.liao@linux.intel.com>
References: <20240827130707.298477-1-yung-chuan.liao@linux.intel.com>
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


