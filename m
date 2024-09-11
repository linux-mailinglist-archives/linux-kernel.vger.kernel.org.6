Return-Path: <linux-kernel+bounces-324826-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 49E6297515A
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 14:01:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E88D51F25FD0
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 12:01:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F004819E987;
	Wed, 11 Sep 2024 11:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AQyuUo8a"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00EE719E970;
	Wed, 11 Sep 2024 11:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726055963; cv=none; b=CRXb9qL0wUW2HYt9R3ENnb6nM9GxdbLEPqhRnQKsm7EDvmKX98O4gvKcf2O0dgBOZwTkQcdIBDj4ptetoj65+0cGJgIX1bihbi9abyidpDz2VTplycxNKqDVwrPd5zkiJXFkPsK0CbvNz4TeV8OK04L9gL5JH+6xHxvmkg6QZvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726055963; c=relaxed/simple;
	bh=scaVtywZM8FRzxJE7xGyoly1lnhP22/2qGmw6jgkdxg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JbbVq4yW41g1mqN5Q5AKHZBgcOx5VLIYFC1kXcwcLRjPlb3/aBXU88X0pFZFYB8r3Iv2+zcn22zrmuLXakllyHQCmh91SzXG8G7VWUbqB5QeFDKBx9BfBY7ijlXd9i+YulfK9nyorKXLSwVw21jEB8VXuZf3hnVX7+a/gI1I3Kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AQyuUo8a; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726055962; x=1757591962;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=scaVtywZM8FRzxJE7xGyoly1lnhP22/2qGmw6jgkdxg=;
  b=AQyuUo8aoLjgnvsEVR3EcVgBpatSoUJDeaZVrj9ZkDZgDrPoBRPGFhEl
   TCYXdS43/6O+xTrncjoSkCmoq8tP+7I98YmIkCWm0ULp3DY9LTPiGZTOB
   cXzj4yEk4oT6uMAZ6ad+SL2BjoNgqACMJXYm583meIiGMTCMTggGs6cCV
   sOPV7NAAzjpTSVLbqOosTvnYZKEmJ7XoZN2V0VbSq9fepVIoEq713S5cO
   0nWSE/t60f+TtlPCD/mzxzL1yi5fAiF1qXIm2EhkHenkHbDZM3NkS8nTZ
   IOzBTPOt6LllI7bvtLo3A8sAU5KaDOaW/xuG95XMsL6w3breNkEKYio8X
   g==;
X-CSE-ConnectionGUID: VNCD5mgHQYeSYdM+3Q/pbw==
X-CSE-MsgGUID: TqmqSYDDQNirgJp6eyHcsw==
X-IronPort-AV: E=McAfee;i="6700,10204,11191"; a="35417256"
X-IronPort-AV: E=Sophos;i="6.10,219,1719903600"; 
   d="scan'208";a="35417256"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2024 04:59:22 -0700
X-CSE-ConnectionGUID: ZFisY1gMS3mTVjLC0HM5lg==
X-CSE-MsgGUID: Ubfb31yqTcK9oNxR4RzlHg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,219,1719903600"; 
   d="scan'208";a="67292767"
Received: from bvivekan-mobl2.gar.corp.intel.com (HELO yungchua-desk.intel.com) ([10.247.118.254])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2024 04:59:19 -0700
From: Bard Liao <yung-chuan.liao@linux.intel.com>
To: linux-sound@vger.kernel.org,
	vkoul@kernel.org
Cc: vinod.koul@linaro.org,
	linux-kernel@vger.kernel.org,
	pierre-louis.bossart@linux.intel.com,
	bard.liao@intel.com
Subject: [PATCH v2 08/14] soundwire: mipi-disco: remove DPn audio-modes
Date: Wed, 11 Sep 2024 19:58:21 +0800
Message-ID: <20240911115827.233171-9-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240911115827.233171-1-yung-chuan.liao@linux.intel.com>
References: <20240911115827.233171-1-yung-chuan.liao@linux.intel.com>
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


