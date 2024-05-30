Return-Path: <linux-kernel+bounces-196002-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 048558D55E7
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 01:02:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3572B1C24AA5
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 23:02:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AF49194C81;
	Thu, 30 May 2024 23:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mLbA9AUI"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DC0715251B;
	Thu, 30 May 2024 23:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717110061; cv=none; b=DjK22CkMgfmxtNr8cfZJmSTBL2UJTcM3viWMr5+2j0NbzD5IRjL1hC02U0pjJQ+EGdet+oyZWSbRsLYFv9X4ajbGHPsyVZF//f0VoZTkpd5Q1ki2gQoBxe39m2DXGxpmNyKUgAaqQhP5AWxQcMku/zNs4TYFqZJco14ocfYOQlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717110061; c=relaxed/simple;
	bh=AuYIRZwuv1vWCs2uWjv6nHv7VSkA6+15BzU0BIBlcXI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ErWiOD3Lj/hX6fIcFsVBbM3n0k8FKY337gL/ZMir016SKk+28v1XFPxCUOVFry2o421DmgnGYwXCu7CSVwyCiaZqdYBN+qbwT1gw2111GHmagoJr96l2dj1GhdZfyYW4mssAOzMH9RqDDXDp/JTW7RameXiAa9mGVE1YfDa4qdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mLbA9AUI; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717110061; x=1748646061;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=AuYIRZwuv1vWCs2uWjv6nHv7VSkA6+15BzU0BIBlcXI=;
  b=mLbA9AUIsITTqfMOJuO53IlybMF9k28J6yt91uaqBAQtRVvpH44Hm9Zh
   0+1c/ShJxbczINJEJ4I7/ErZkYXHW4V8+XfVAqgH6fx18e9ihlvdrp8yS
   yfWnEXNzW3Qzv8y7Tx3lAnd0A/86vx+I7abZeqcOArY5WXrRYV7qSKrHT
   yoN+V+Awj5cpFzZjx/5Z+xHYFJlOu2eCvpMSER2FRWaUqqvOz4mA4PK6A
   qQMcAdkf0Fpxn5Fk70+VmhOYaVFDLWQygJTkmPTNLH7mI+8vZHUwMdJ14
   xeQfsOESn0K+GyDLqgcnFHJEDbfyztllXtmD3LIzPoRyrk7JIChCKkCkd
   Q==;
X-CSE-ConnectionGUID: Ei6AGBQvQyS2K9fkgntabQ==
X-CSE-MsgGUID: VR79rSvPRpe0H5J6+W1xtA==
X-IronPort-AV: E=McAfee;i="6600,9927,11088"; a="24195391"
X-IronPort-AV: E=Sophos;i="6.08,202,1712646000"; 
   d="scan'208";a="24195391"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2024 16:01:00 -0700
X-CSE-ConnectionGUID: sobAkPNVTae+BISEGqSQCg==
X-CSE-MsgGUID: iCEpUl0ZQQiPRNOUAbqr4A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,202,1712646000"; 
   d="scan'208";a="40895353"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa003.jf.intel.com with ESMTP; 30 May 2024 16:00:50 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 69C1F6AB; Fri, 31 May 2024 02:00:40 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Rob Herring <robh@kernel.org>,
	Weidong Wang <wangweidong.a@awinic.com>,
	Mark Brown <broonie@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Shenghao Ding <shenghao-ding@ti.com>,
	Marco Felsch <m.felsch@pengutronix.de>,
	Alper Nebi Yasak <alpernebiyasak@gmail.com>,
	Chancel Liu <chancel.liu@nxp.com>,
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	alsa-devel@alsa-project.org,
	patches@opensource.cirrus.com,
	linuxppc-dev@lists.ozlabs.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org
Cc: Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	James Schulman <james.schulman@cirrus.com>,
	David Rhodes <david.rhodes@cirrus.com>,
	Richard Fitzgerald <rf@opensource.cirrus.com>,
	Kevin Lu <kevin-lu@ti.com>,
	Baojun Xu <baojun.xu@ti.com>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Banajit Goswami <bgoswami@quicinc.com>,
	Shengjiu Wang <shengjiu.wang@gmail.com>,
	Xiubo Li <Xiubo.Lee@gmail.com>,
	Fabio Estevam <festevam@gmail.com>,
	Nicolin Chen <nicoleotsuka@gmail.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Heiko Stuebner <heiko@sntech.de>,
	Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: [PATCH v1 5/6] ASoC: generic: Replace of_gpio.h by proper one
Date: Fri, 31 May 2024 01:58:51 +0300
Message-ID: <20240530230037.1156253-6-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
In-Reply-To: <20240530230037.1156253-1-andriy.shevchenko@linux.intel.com>
References: <20240530230037.1156253-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

of_gpio.h is deprecated and subject to remove.
The driver doesn't use it directly, replace it
with what is really being used.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 sound/soc/generic/audio-graph-card2-custom-sample.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/soc/generic/audio-graph-card2-custom-sample.c b/sound/soc/generic/audio-graph-card2-custom-sample.c
index 1b6ccd2de964..8e5a51098490 100644
--- a/sound/soc/generic/audio-graph-card2-custom-sample.c
+++ b/sound/soc/generic/audio-graph-card2-custom-sample.c
@@ -5,8 +5,9 @@
 // Copyright (C) 2020 Renesas Electronics Corp.
 // Copyright (C) 2020 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
 //
+#include <linux/device.h>
+#include <linux/mod_devicetable.h>
 #include <linux/module.h>
-#include <linux/of_gpio.h>
 #include <linux/platform_device.h>
 #include <sound/graph_card.h>
 
-- 
2.43.0.rc1.1336.g36b5255a03ac


