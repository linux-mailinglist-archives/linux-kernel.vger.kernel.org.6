Return-Path: <linux-kernel+bounces-196001-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB2CA8D55E5
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 01:02:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 861D7287965
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 23:02:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E68C019069F;
	Thu, 30 May 2024 23:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ex5w7TCP"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E29B1190695;
	Thu, 30 May 2024 23:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717110060; cv=none; b=OfulxRZWZJVWV5++C14XpsEs6n5zw61F/U2vpbA5eaHkWLuwgfe2yHSOOTovkVwcBelQPfxzzk71/DVkcDkOvLPZ5fJMdLgq7suznwBYNorXl+4FJ64yitbhKK/WBHGLYZi9CslFU4J/c0kAcJK1TLsLfOO4YFVGcHbm33WCEu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717110060; c=relaxed/simple;
	bh=sA6qI//FTL7pgyGldUMsd1jU+l556RY52OWXWgjHnto=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cMUcDQMPhp9+Zyw+bdY338NjjdjKrC1LipqNDhQLgh1CCMrFui6vpe9jkm57Pe4MbN03QdU7NvA/UxSHAkkzjp/mB5g/Nyv6HdCVflSdJTShchBbCIvbVJUgID6jw5ZcpP58og1xdoKJJSrePa9WUeD4YVYM+trojmZ69pS6ytY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ex5w7TCP; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717110060; x=1748646060;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=sA6qI//FTL7pgyGldUMsd1jU+l556RY52OWXWgjHnto=;
  b=ex5w7TCPFJQTcglxysPdFAcYR14/9nxCZEGof8jSt4Qx6P6D9WUEra86
   CO0t4qhfp7Ufu4E+ctg/jkyLUezo+MKQsknbCK9JPM/aTSmrxocYL66Cc
   +A6duzntuuymbgtG5hKvWAWfrvR1SM+4ZWEo0N6nhXZv4tJU/foTzPJY2
   0D8v6uJ50QLFg6I6/WudUfCQDknUzEejzQKWlYKkwvDz6XJzsNVmGGPFW
   iF5/xvup12yNMSnFIE6sLxM4AmKPWWIMompqpSAr10by0vtVcJP4zICrg
   EiJ+tf7gEZFowYNKszPhQLAlhaTVfG6Q/lfuz4GMP3k/FbLwMZgLzgJLB
   A==;
X-CSE-ConnectionGUID: zNYk+dNpRjmkh7YFOKMzyQ==
X-CSE-MsgGUID: rMolwGlZSmK1LQHobhUX0Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11088"; a="24195360"
X-IronPort-AV: E=Sophos;i="6.08,202,1712646000"; 
   d="scan'208";a="24195360"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2024 16:00:59 -0700
X-CSE-ConnectionGUID: shNDdpbZSeqWsVWRt7QFTg==
X-CSE-MsgGUID: 1ruPcTT0SvuZbWAI61H1sw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,202,1712646000"; 
   d="scan'208";a="40895352"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa003.jf.intel.com with ESMTP; 30 May 2024 16:00:50 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 7DB356CB; Fri, 31 May 2024 02:00:40 +0300 (EEST)
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
Subject: [PATCH v1 6/6] ASoC: samsung: Replace of_gpio.h by proper one
Date: Fri, 31 May 2024 01:58:52 +0300
Message-ID: <20240530230037.1156253-7-andriy.shevchenko@linux.intel.com>
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
 sound/soc/samsung/aries_wm8994.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/samsung/aries_wm8994.c b/sound/soc/samsung/aries_wm8994.c
index a548ac33dd94..01716df0c842 100644
--- a/sound/soc/samsung/aries_wm8994.c
+++ b/sound/soc/samsung/aries_wm8994.c
@@ -1,11 +1,11 @@
 // SPDX-License-Identifier: GPL-2.0+
 #include <linux/extcon.h>
+#include <linux/gpio/consumer.h>
 #include <linux/iio/consumer.h>
 #include <linux/input-event-codes.h>
 #include <linux/mfd/wm8994/registers.h>
 #include <linux/module.h>
 #include <linux/of.h>
-#include <linux/of_gpio.h>
 #include <linux/regulator/consumer.h>
 #include <sound/jack.h>
 #include <sound/pcm_params.h>
-- 
2.43.0.rc1.1336.g36b5255a03ac


