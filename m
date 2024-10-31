Return-Path: <linux-kernel+bounces-390347-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 137379B78B1
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 11:33:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F17F285780
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 10:33:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7128E19924E;
	Thu, 31 Oct 2024 10:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ga3uW7Uz"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38F2013A89A;
	Thu, 31 Oct 2024 10:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730370789; cv=none; b=hpcw/kh5u6vhY9KRIWM47MriRqL37CSDx0LWe4zC63lhHUx+O5ZDq7K/c5fSEPBYAQWTu683gaMBqREIZrxHphBRapmVwpJwvZIZWW4BkbPmOF9SvydLbzK1nE0InBVYZhkYmTaVGocsSP9WHz9/eJgtzY5Gf1rZMurZ/0rvx14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730370789; c=relaxed/simple;
	bh=eKNfUqel5OZ/TgCB4bHe6tb2bJ1iWuMce18w3T5R0H8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bpbR6ENAYvV0C1uJD514IXKNGHzh8qpakNvdoSSLt0qDGBQvBs4XeZTjHeVfc/doHFT0bpqSpjfO/5O9zVN7/CdhOzz05Cwl05TZ2NguXaie1sg9OK/utAXchXbcDpnDtfO9EcYrhy8lnI7XpgZzgox/ZngXvVy6v7DfUyqCxeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ga3uW7Uz; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730370788; x=1761906788;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=eKNfUqel5OZ/TgCB4bHe6tb2bJ1iWuMce18w3T5R0H8=;
  b=Ga3uW7Uz1cMVSkyabO6GQy/EszbuVmLS0GhSfANayt/ya74BehwGTD6F
   PlGtgJqIlqSSswDclFFwMo6oRpo1fLEqbVMAU1h+xEZYgWjleB2r/x80p
   iH7XQBOjG//xrW8PiSA85EfVzvfhiN/vjpLuQ+KP3OCiieh+IcFehGw+A
   gD3Zs7dEXo19RHNUgXvZCvL/xhOhre9ddyqVi2QkMeHnsKIKWJjFs03+G
   Q7HqSM/+lRI5aioQSKDFmNKwdUmAbzdXpd2cfB7PfbThzX6lcDqyr0e8x
   HOc2uw5NK1DaBd7KaER2y5efBZ6wtAOuWaXi9czvD2zwDX+GGDtihsNzf
   Q==;
X-CSE-ConnectionGUID: Ei+EczOLRK6y7FC/uf4l+Q==
X-CSE-MsgGUID: XEUk3eP/SO6QUCHMf1tldQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="30293902"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="30293902"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2024 03:33:08 -0700
X-CSE-ConnectionGUID: WfjPpFE0RAe6p3LORAF2+Q==
X-CSE-MsgGUID: IvOrv0jhR7+2FJzBn97Yuw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,247,1725346800"; 
   d="scan'208";a="86522566"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa003.fm.intel.com with ESMTP; 31 Oct 2024 03:33:05 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 392BA17D; Thu, 31 Oct 2024 12:33:03 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Mark Brown <broonie@kernel.org>,
	Prasad Kumpatla <quic_pkumpatl@quicinc.com>,
	Mohammad Rafi Shaik <quic_mohs@quicinc.com>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] ASoC: codecs: wcd937x: Remove unused of_gpio.h
Date: Thu, 31 Oct 2024 12:33:02 +0200
Message-ID: <20241031103302.2450830-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

of_gpio.h is deprecated and subject to remove. The drivers in question
don't use it, simply remove the unused header.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 sound/soc/codecs/wcd937x.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/codecs/wcd937x.c b/sound/soc/codecs/wcd937x.c
index 08fb13a334a4..c9d5e67bf66e 100644
--- a/sound/soc/codecs/wcd937x.c
+++ b/sound/soc/codecs/wcd937x.c
@@ -7,7 +7,6 @@
 #include <linux/gpio/consumer.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
-#include <linux/of_gpio.h>
 #include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
-- 
2.43.0.rc1.1336.g36b5255a03ac


