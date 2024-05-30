Return-Path: <linux-kernel+bounces-195997-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E9FE28D55DE
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 01:01:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 05FC51C23620
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 23:01:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04F1B18411B;
	Thu, 30 May 2024 23:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Mh00Qqp4"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9268D74041;
	Thu, 30 May 2024 23:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717110052; cv=none; b=GW8PShQ4ciLSgAZTwwZURJ8uwWykvH3EvyVoHOm5xHDvMdSfM4F9nwoS5AyGF+62EBaCaKrevqCiGKSVWivSVgUdIYFQqnE/2oEyeVP3tF1Mrm5FKmjCqGvZD81dufSWfMyZYbyD8X7wF4rSSarMa0N/BwnmigsVHD2fTcY75Ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717110052; c=relaxed/simple;
	bh=ZQKha7BG252KruQ9oU8AYSozYEYwH5AEwR9Xap5vJ0c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ajePD68MTIdLA0aXm2ZvYO5zfiywkWk8mcQT8IfTb1ul85PoOVirA2F8LBd/MZGZFTPWlzbZTbRTIQd7BkTjEIJlukLwHTJD4GFrDiUJ9/XxTaTSlvPkJILdESPCBe6nhyzMtMDBqvSpXSktxOA0KDWHmxEC9opIIviCd0Mi4PU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Mh00Qqp4; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717110052; x=1748646052;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZQKha7BG252KruQ9oU8AYSozYEYwH5AEwR9Xap5vJ0c=;
  b=Mh00Qqp4+BXwmCh5iH1329X7FlV2IGfeh0t3SAZxJp8eOjYAII3Lp78t
   MHnFtTrL8Vt1RH3t8YEKqqQaWWMm45QE9XaROeNlRv8258RKLTcfx93xE
   BG+yna3ig2jXzh616UgG3lyKLwUrYq1H0kNsCV1CGPXBzBX1bJycR0kfg
   U0oCKDTCgAnFHzNDKmJHMtNMryRZGKIvnUM7Pm2or5RyR8R0Jc+dV3KrS
   dZFax7Ci9XLtaRk7FFugGk1w23KgWEYANq/WspHLOcaEPrI51OU13FBYS
   nk8Ee/rJNGZYFDN2eZV2/LuKwIvB6rpWohOae+S3x+tLKmKqMJrTjhX9X
   g==;
X-CSE-ConnectionGUID: qMzX6oVKQ1WOpS/T5yKTSQ==
X-CSE-MsgGUID: mDMN238LTduqhYMkKjbjiA==
X-IronPort-AV: E=McAfee;i="6600,9927,11088"; a="24195243"
X-IronPort-AV: E=Sophos;i="6.08,202,1712646000"; 
   d="scan'208";a="24195243"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2024 16:00:51 -0700
X-CSE-ConnectionGUID: n2sq6o+KTKmqb2Ms3NcGVQ==
X-CSE-MsgGUID: xYZcJQfTQRiunh7Ud3EJJQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,202,1712646000"; 
   d="scan'208";a="40895197"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa003.jf.intel.com with ESMTP; 30 May 2024 16:00:41 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 569B74DE; Fri, 31 May 2024 02:00:40 +0300 (EEST)
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
Subject: [PATCH v1 4/6] ASoC: codecs: Replace of_gpio.h by proper one
Date: Fri, 31 May 2024 01:58:50 +0300
Message-ID: <20240530230037.1156253-5-andriy.shevchenko@linux.intel.com>
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
 sound/soc/codecs/aw88395/aw88395.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/aw88395/aw88395.c b/sound/soc/codecs/aw88395/aw88395.c
index 3c459a67ad0c..be6ebcb51cca 100644
--- a/sound/soc/codecs/aw88395/aw88395.c
+++ b/sound/soc/codecs/aw88395/aw88395.c
@@ -8,9 +8,9 @@
 // Author: Weidong Wang <wangweidong.a@awinic.com>
 //
 
+#include <linux/gpio/consumer.h>
 #include <linux/i2c.h>
 #include <linux/firmware.h>
-#include <linux/of_gpio.h>
 #include <linux/regmap.h>
 #include <sound/soc.h>
 #include "aw88395.h"
-- 
2.43.0.rc1.1336.g36b5255a03ac


