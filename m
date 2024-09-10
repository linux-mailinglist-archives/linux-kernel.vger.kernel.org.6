Return-Path: <linux-kernel+bounces-323237-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 305379739E0
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 16:30:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBC67289A84
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 14:30:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92183193096;
	Tue, 10 Sep 2024 14:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bc8Qu74Z"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AE3F183094;
	Tue, 10 Sep 2024 14:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725978636; cv=none; b=hM/qNmzJpo6Yb9SXKGSgm/rrTi//qaCXhXmGlecyFT+iGQdP9Umjfn4mrYi4oUyte3cWanF/D5rb2SpQ0HYUCl8pnj6u8u3ZpJK/G0U+n8nPj9AOgefJ0ZO5PB/BkBjI1Akdnf+041WHsTn7JjDGar6X3aiYX33SnLvL0rNeqaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725978636; c=relaxed/simple;
	bh=37dA2/8Lo9EhECpZNUmgs9Cpix+RL76xxtBnhKKmQZ4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=agCPSLtEN+o8wcMKaCChElaWPTCGqviRqqB8Drt3mcUObYPVnnUaxYS/yYwhKVE06j70Wy6v/fwGio3Hgc2I1lUchQdgmvhWkZkJIMn95tDQ5ERQaxsz2bl+3mo/nhNxBCCvoLMC8ZZaoIebuAm9g8rVqvuT2qkogqfZ6W1Zg/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bc8Qu74Z; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725978635; x=1757514635;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=37dA2/8Lo9EhECpZNUmgs9Cpix+RL76xxtBnhKKmQZ4=;
  b=bc8Qu74ZZSOG6E8J47a5+uo77GchuSiEfapyAZlRNTZW5yTq6lfwtB26
   zSBhzuja8L2Xf2cOmcBPyt1ZJBWRJyOmk8UFP2TT9xsrgQJHJ84SZoSF/
   lzdqV+NjseqPYoONdki2ZPfMajThLV6yeXXoa1SgAIAXfkKlpbK5JS5Ll
   8T2Z1Jg7nLAYqA/S5+Zv45WqHSspS2DJeaFM9z50eagBJI0fVhT1sqyw7
   fOPjQDAiPS6iBwEiwT45X6Ai2N0Uv6GL5KGp7rg8mcjDNQBYtgiWWcVbA
   OHtLYsuglAz2ZMrWP+s5STXVmeLxTO+jVPzIq0nBdmNUR0z3zrxVPNGPz
   w==;
X-CSE-ConnectionGUID: nIl77YtkQG+MkKVmY7/xJw==
X-CSE-MsgGUID: v0a7TTM8SeOt9j5V9xY4rA==
X-IronPort-AV: E=McAfee;i="6700,10204,11191"; a="47248518"
X-IronPort-AV: E=Sophos;i="6.10,217,1719903600"; 
   d="scan'208";a="47248518"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2024 07:30:34 -0700
X-CSE-ConnectionGUID: /x6KIXWGR/6Fn6YjK6hZPw==
X-CSE-MsgGUID: u/gKSHp1TgmQ9jHq7UVplw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,217,1719903600"; 
   d="scan'208";a="67288474"
Received: from cvapit-mobl1.ger.corp.intel.com (HELO yungchua-desk.intel.com) ([10.247.118.236])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2024 07:30:31 -0700
From: Bard Liao <yung-chuan.liao@linux.intel.com>
To: broonie@kernel.org,
	tiwai@suse.de,
	vkoul@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org,
	pierre-louis.bossart@linux.intel.com,
	bard.liao@intel.com
Subject: [PATCH] MAINTAINERS: update Pierre Bossart's email and role
Date: Tue, 10 Sep 2024 22:30:21 +0800
Message-ID: <20240910143021.261261-1-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

Update to permanent address and Reviewer role.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Péter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 .mailmap    | 1 +
 MAINTAINERS | 6 +++---
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/.mailmap b/.mailmap
index caf46a652f15..34a003e2ee10 100644
--- a/.mailmap
+++ b/.mailmap
@@ -527,6 +527,7 @@ Pavankumar Kondeti <quic_pkondeti@quicinc.com> <pkondeti@codeaurora.org>
 Peter A Jonsson <pj@ludd.ltu.se>
 Peter Oruba <peter.oruba@amd.com>
 Peter Oruba <peter@oruba.de>
+Pierre-Louis Bossart <pierre-louis.bossart@linux.dev> <pierre-louis.bossart@linux.intel.com>
 Pratyush Anand <pratyush.anand@gmail.com> <pratyush.anand@st.com>
 Praveen BP <praveenbp@ti.com>
 Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com> <pradeepc@codeaurora.org>
diff --git a/MAINTAINERS b/MAINTAINERS
index 38f9f8d1eedc..b56ceb3fcb16 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11146,12 +11146,12 @@ F:	drivers/gpio/gpio-i8255.h
 
 INTEL ASoC DRIVERS
 M:	Cezary Rojewski <cezary.rojewski@intel.com>
-M:	Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
 M:	Liam Girdwood <liam.r.girdwood@linux.intel.com>
 M:	Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
 M:	Bard Liao <yung-chuan.liao@linux.intel.com>
 M:	Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
 M:	Kai Vehmanen <kai.vehmanen@linux.intel.com>
+R:	Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>
 L:	alsa-devel@alsa-project.org (moderated for non-subscribers)
 S:	Supported
 F:	sound/soc/intel/
@@ -21378,13 +21378,13 @@ S:	Maintained
 F:	tools/sound/dapm-graph
 
 SOUND - SOUND OPEN FIRMWARE (SOF) DRIVERS
-M:	Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
 M:	Liam Girdwood <lgirdwood@gmail.com>
 M:	Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
 M:	Bard Liao <yung-chuan.liao@linux.intel.com>
 M:	Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
 M:	Daniel Baluta <daniel.baluta@nxp.com>
 R:	Kai Vehmanen <kai.vehmanen@linux.intel.com>
+R:	Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>
 L:	sound-open-firmware@alsa-project.org (moderated for non-subscribers)
 S:	Supported
 W:	https://github.com/thesofproject/linux/
@@ -21393,7 +21393,7 @@ F:	sound/soc/sof/
 SOUNDWIRE SUBSYSTEM
 M:	Vinod Koul <vkoul@kernel.org>
 M:	Bard Liao <yung-chuan.liao@linux.intel.com>
-R:	Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
+R:	Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>
 R:	Sanyog Kale <sanyog.r.kale@intel.com>
 L:	alsa-devel@alsa-project.org (moderated for non-subscribers)
 S:	Supported
-- 
2.43.0


