Return-Path: <linux-kernel+bounces-172178-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D349A8BEE74
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 22:57:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E6AD2846E5
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 20:57:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 948C269D3C;
	Tue,  7 May 2024 20:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QcbsOcVM"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97BD4187326;
	Tue,  7 May 2024 20:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715115428; cv=none; b=kFU+DLcri4dc3Zh78HxFdPJlHUfxtdMm+ze+kBpRv2v37T4gSNKS+kbkaqcMuUKAWVwUXsWB8jzJoi7yXb2guJDTM5PXSnQYFkgJDeE7SPApe15D5fmNZPgkXqyQYG7XgbhayCBh3DlAAvbig8++Qm/V6GVnELWMgzFZI/ygFDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715115428; c=relaxed/simple;
	bh=l9R6ZctW1GwYtMEchDn8Z2hexXc1AAVmZaGYJc7SQHA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=W/YLPfZyaW8G65zPfPAJP1B+A5wQ8kxrYA7vwNm0FA6QUALxzK0LRwGsPhKW0iX65hqtl6U4EG9ju4qDVabk5zhrHUk8Zh1ctOVqZDiMoahKxzAAfvRBiertoUZ7+zCklJ0ezbTYA48/LG8rD97KTX25iI5970wtrxlqjoa2C5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QcbsOcVM; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715115428; x=1746651428;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=l9R6ZctW1GwYtMEchDn8Z2hexXc1AAVmZaGYJc7SQHA=;
  b=QcbsOcVMYPcuHQLW6nGmrwswOtXh0utBFmJEkX81lkVXwMup/wuTJJ+d
   /YnvulV19ITOlB0wJd4rpnNnWjTPy3h10X2ovvlhE2LPLs7SAmkjxv1YA
   V4t88BtunSqYLO+pDukSHEMoEXApPv3HHkpzO2nINMGwm+wMpnyqaU3iT
   E8wQfRWaUKfNKOUTye9vTV0R/uf7Jo1wIOYS7+FPLqo55/W2SlwnXgFJ5
   rYWbv5tBUvTe276/a9b++nudPXzFo4zTT4WAx3j0DoP0iNy/Fnaorj7Io
   3YsIFZa/H3BdraDXJmoydcKIVzxSXTTy9XdWbZdTuKNtOoTmuEznldNNm
   Q==;
X-CSE-ConnectionGUID: cBPZ0XR1R2C0WQ3yUajVcQ==
X-CSE-MsgGUID: PiC2zz8ERnyPOSH86NoJRA==
X-IronPort-AV: E=McAfee;i="6600,9927,11066"; a="10810407"
X-IronPort-AV: E=Sophos;i="6.08,143,1712646000"; 
   d="scan'208";a="10810407"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2024 13:57:07 -0700
X-CSE-ConnectionGUID: vpB2YEaKQAGcaiAM27ZIHQ==
X-CSE-MsgGUID: L3kkAFj9RkCNx6BaeGvQCw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,143,1712646000"; 
   d="scan'208";a="28636016"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa009.fm.intel.com with ESMTP; 07 May 2024 13:57:04 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 3D4FD12A; Tue, 07 May 2024 23:57:02 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: alsa-devel@alsa-project.org,
	linux-sound@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Peter Rosin <peda@axentia.se>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] ASoC: atmel: tse850-pcm5142: Remove unused of_gpio.h
Date: Tue,  7 May 2024 23:56:59 +0300
Message-ID: <20240507205659.690270-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

of_gpio.h is deprecated and subject to remove.
The driver doesn't use it, simply remove the unused header.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 sound/soc/atmel/tse850-pcm5142.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/soc/atmel/tse850-pcm5142.c b/sound/soc/atmel/tse850-pcm5142.c
index 611da23325d3..5d208e0b4b90 100644
--- a/sound/soc/atmel/tse850-pcm5142.c
+++ b/sound/soc/atmel/tse850-pcm5142.c
@@ -35,10 +35,9 @@
 // of the (filtered) output from the PCM5142 codec.
 
 #include <linux/clk.h>
-#include <linux/gpio.h>
+#include <linux/gpio/consumer.h>
 #include <linux/module.h>
 #include <linux/of.h>
-#include <linux/of_gpio.h>
 #include <linux/regulator/consumer.h>
 
 #include <sound/soc.h>
-- 
2.43.0.rc1.1336.g36b5255a03ac


