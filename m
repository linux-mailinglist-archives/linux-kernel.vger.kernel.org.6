Return-Path: <linux-kernel+bounces-325543-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A526E975B09
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 21:50:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51A2A1F22FA1
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 19:50:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2BC01BA876;
	Wed, 11 Sep 2024 19:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cHsApBcr"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91A651B4C56;
	Wed, 11 Sep 2024 19:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726084245; cv=none; b=jUM41wTrTA9q1AedPn9hr8xDF8uf8TPFrARyBTrlxK3CdsFElHXUlV4Qvohn3p7e3dC8iMMtlQJ6uKHI1xxB89pBZp0f21+q5tpYKoi/Vwdt75/AK721Be2BT74+bvkOS/LPrz6yTww7KdvN0De8hO7veltps+D0Act9COy9XVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726084245; c=relaxed/simple;
	bh=B+mA53yt7sUD0OfFPbneG6pz99+KVi/5tFhE+c3Qysk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=irY6ju4RjG8nOyZZG9CY38yjqQ0GgKZ377ylap8wzfppEQybvpnRLBfwXIoVkKJD7S+FUR8nvnkonPjXCJ/GTmfxvEkn39XFTtSfUr2mQBAnSt+KBwNT5b5/wYRFj2nX/vhYDG6Rq5kIRSYvTUPzZgs3uDBoFc6Ng3uicNHeJKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cHsApBcr; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726084244; x=1757620244;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=B+mA53yt7sUD0OfFPbneG6pz99+KVi/5tFhE+c3Qysk=;
  b=cHsApBcrviKQItq0MlMet+KWovJXN6fcWOzbDJ5J1v7OJot6IV119Fke
   Kr7HqvzUcK5yyTV7A99dYQum6TpxOzRQCPVsGir4g9OZ8nB3AnwZj83CI
   1sw/IwAEAti9FAhsGJofr8X3J1fnl5pJOxGA+Oba9vdwwGA9UtqvdCxXU
   FrQ4at/iM/u6fqukED2X2+wXTazjosReLR5DoGa/SmUUvP6xJgkRMsiLK
   DIRGk0QvwDzorLIz3BrnVvv00/BnREajRaftraqcZIldl7dOiqd6EMlHW
   2+FjWs5sKQq9jtWSdw5vGU80sgxDJ5Zpqf+a2ZOF9V9G2UWkJzPF1KCHf
   Q==;
X-CSE-ConnectionGUID: 24pAIPs4Q6iU3q+M+Pl5Zw==
X-CSE-MsgGUID: rSRUe98qSLyfq9u5rCfocg==
X-IronPort-AV: E=McAfee;i="6700,10204,11192"; a="24777179"
X-IronPort-AV: E=Sophos;i="6.10,220,1719903600"; 
   d="scan'208";a="24777179"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2024 12:50:43 -0700
X-CSE-ConnectionGUID: UbI9j++lTEKXmz/VxsxhTA==
X-CSE-MsgGUID: 8Y2U04N6Q9SJunNhf+SKAg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,220,1719903600"; 
   d="scan'208";a="72070264"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa004.fm.intel.com with ESMTP; 11 Sep 2024 12:50:41 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id DBC84170; Wed, 11 Sep 2024 22:50:39 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Takashi Iwai <tiwai@suse.de>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] ALSA: ump: Use %*ph to print small buffer
Date: Wed, 11 Sep 2024 22:50:39 +0300
Message-ID: <20240911195039.2885979-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use %*ph format to print small buffer as hex string.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 sound/core/ump.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/sound/core/ump.c b/sound/core/ump.c
index 243ecdbb2a6e..cf22a17e38dd 100644
--- a/sound/core/ump.c
+++ b/sound/core/ump.c
@@ -489,11 +489,7 @@ static void snd_ump_proc_read(struct snd_info_entry *entry,
 			    ump->info.manufacturer_id);
 		snd_iprintf(buffer, "Family ID: 0x%04x\n", ump->info.family_id);
 		snd_iprintf(buffer, "Model ID: 0x%04x\n", ump->info.model_id);
-		snd_iprintf(buffer, "SW Revision: 0x%02x%02x%02x%02x\n",
-			    ump->info.sw_revision[0],
-			    ump->info.sw_revision[1],
-			    ump->info.sw_revision[2],
-			    ump->info.sw_revision[3]);
+		snd_iprintf(buffer, "SW Revision: 0x%4phN\n", ump->info.sw_revision);
 	}
 	snd_iprintf(buffer, "Static Blocks: %s\n",
 		    (ump->info.flags & SNDRV_UMP_EP_INFO_STATIC_BLOCKS) ? "Yes" : "No");
@@ -710,14 +706,11 @@ static int ump_handle_device_info_msg(struct snd_ump_endpoint *ump,
 	ump->info.sw_revision[1] = (buf->device_info.sw_revision >> 16) & 0x7f;
 	ump->info.sw_revision[2] = (buf->device_info.sw_revision >> 8) & 0x7f;
 	ump->info.sw_revision[3] = buf->device_info.sw_revision & 0x7f;
-	ump_dbg(ump, "EP devinfo: manid=%08x, family=%04x, model=%04x, sw=%02x%02x%02x%02x\n",
+	ump_dbg(ump, "EP devinfo: manid=%08x, family=%04x, model=%04x, sw=%4phN\n",
 		ump->info.manufacturer_id,
 		ump->info.family_id,
 		ump->info.model_id,
-		ump->info.sw_revision[0],
-		ump->info.sw_revision[1],
-		ump->info.sw_revision[2],
-		ump->info.sw_revision[3]);
+		ump->info.sw_revision);
 	return 1; /* finished */
 }
 
-- 
2.43.0.rc1.1336.g36b5255a03ac


