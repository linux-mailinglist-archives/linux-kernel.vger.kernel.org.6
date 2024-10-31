Return-Path: <linux-kernel+bounces-390344-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B821B9B78A4
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 11:27:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CCAB283295
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 10:27:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FD3919924F;
	Thu, 31 Oct 2024 10:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZUSvV5p/"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4CEB1991B8;
	Thu, 31 Oct 2024 10:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730370452; cv=none; b=ILssujtwfpXmDTBeyluE+a+82uV5OIL1GxtN+Jk7jB+fmPdDird3f7ht1s2Ehzxi1yE8t2/GfKlpo9LwXbxOaLR6szpVC4eJvz0NXCfoUGNa/EUNX/edo3qU4k1EDCVPJSnBkWuFL+xz3TZdox1lnfD+kvQBtKYb+zRWlqYAIyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730370452; c=relaxed/simple;
	bh=sMV2z22HhG0zsL48EdWLeFMLr9EjY9q66UIZQ9UxxWA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=j8xnF4LQR5JeTgj8Pg+mUMcZgS/qlfCgK5e/Y7D1o+1VW40zmS4xHWwD8C+P6M2w5vqZM2phxTCGXo+yT+hqS7b/7e411/bdoGZS0MfsK9852Ee7rnINLYuyfz8GgRt134HvnwNdCLClwIEWFZsvzq9tzEM5TbFvU974JdjVoxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZUSvV5p/; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730370451; x=1761906451;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=sMV2z22HhG0zsL48EdWLeFMLr9EjY9q66UIZQ9UxxWA=;
  b=ZUSvV5p/xSl378hlM0Pa9IOl2iojnI3hEZmzeU3nn8lVZHAuVsFEMHh3
   pB53ZCYHSxmIF3MwvXeHWxDOjeI2SnPwNZ2vANjHC2TLkDjdJ28zu3w06
   rOQV5aqlG5Mo/koixcfU510Mn4+IJS8LsFCWZov9g+rq9x4xCd5A7k495
   rMDtxOfeomBwvkFHRtBPPtiYS+vhY8aqbj07KiaysQs05VG7MkhDoKmNR
   aWtenoNYAdITVfosCsgnFDNWerMe11qO4gV+LBA/8ta0FjPEgAc4Huo7I
   ImKo6WtCF326jiledUyfIzORDa/mijvk14l+g2gIo15i7LJynCQOeCLYt
   A==;
X-CSE-ConnectionGUID: Eyuim79jRjGAz+8nwreTcA==
X-CSE-MsgGUID: M8CtX2PCSGquUsN3Va+5hg==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="33790964"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="33790964"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2024 03:27:30 -0700
X-CSE-ConnectionGUID: L3AEn0I4SUmVHwy636km8Q==
X-CSE-MsgGUID: S6Rf/zfdSbiDY2tP1Ub+yg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,247,1725346800"; 
   d="scan'208";a="120049378"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa001.jf.intel.com with ESMTP; 31 Oct 2024 03:27:27 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 3410717D; Thu, 31 Oct 2024 12:27:26 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Mark Brown <broonie@kernel.org>,
	Nicolas Belin <nbelin@baylibre.com>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Cc: Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] ASoc: mediatek: mt8365: Don't use "proxy" headers
Date: Thu, 31 Oct 2024 12:27:25 +0200
Message-ID: <20241031102725.2447711-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update header inclusions to follow IWYU (Include What You Use)
principle.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 sound/soc/mediatek/mt8365/mt8365-mt6357.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/sound/soc/mediatek/mt8365/mt8365-mt6357.c b/sound/soc/mediatek/mt8365/mt8365-mt6357.c
index d398e83ea052..9f28d6bf0323 100644
--- a/sound/soc/mediatek/mt8365/mt8365-mt6357.c
+++ b/sound/soc/mediatek/mt8365/mt8365-mt6357.c
@@ -6,12 +6,19 @@
  * Authors: Nicolas Belin <nbelin@baylibre.com>
  */
 
+#include <linux/array_size.h>
+#include <linux/dev_printk.h>
+#include <linux/err.h>
+#include <linux/mod_devicetable.h>
 #include <linux/module.h>
-#include <linux/of_gpio.h>
+#include <linux/pinctrl/consumer.h>
+#include <linux/platform_device.h>
+#include <linux/types.h>
+
 #include <sound/soc.h>
 #include <sound/pcm_params.h>
+
 #include "mt8365-afe-common.h"
-#include <linux/pinctrl/consumer.h>
 #include "../common/mtk-soc-card.h"
 #include "../common/mtk-soundcard-driver.h"
 
-- 
2.43.0.rc1.1336.g36b5255a03ac


