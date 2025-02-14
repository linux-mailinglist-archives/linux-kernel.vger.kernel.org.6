Return-Path: <linux-kernel+bounces-514184-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DB2EA353B6
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 02:31:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E4BC16A7E2
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 01:31:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAD9D537FF;
	Fri, 14 Feb 2025 01:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="haIXbS35"
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5399F173;
	Fri, 14 Feb 2025 01:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739496693; cv=none; b=XldM2sMOT2Zaz/SBF9tbnJWn2r/M+Exlzr7D6XvOwuuwUsv0KqFYe/12knLdGPdRR/S2fOY9ocbk8fNQO0lNIP05AoVl8r5+CGuloOG8SuP85qBkU43s8bDPM+EcYf/T8NOBKNNEVf8CHBc9jQC2GGSdr9giS2TCVClemEqnjxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739496693; c=relaxed/simple;
	bh=RFEVmCjfmdYWs0ftkl06kLHc8DHTGXiIKjat4huuF3o=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=TwObIIfkFguCgFKJq2ciGfUKxfhcjeLzQKh3fWuDaK0EXw5Rkr+eGTTa7YB6AV3i86dv5HkO3GuM52YNYbDdh+UVNTydvuO5jDtfqtyYs9D0hxbxyIApZYG86lQH0xGn0IvzEoUo0JhtJOrJOYULke1QifqstSmHtT2C2u0wg7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=haIXbS35; arc=none smtp.client-ip=198.47.23.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 51E1UsPo036830
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Feb 2025 19:30:55 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1739496655;
	bh=EE1HqY+OEVih7elLvMN2Jm/693KOJsTNtzvrXtix6yk=;
	h=From:To:CC:Subject:Date;
	b=haIXbS35O3T+BOcLtHlVveIcdLEJ/8BvGjIolRJBeRC/D0FOaLUkAuIi1twRildSL
	 Y88VdpRXudd6qmLWXBmzZaQkmbF4K99oYLcEgqKJKROlJ0RDVxFEM3pc/ttup06jyw
	 QpKUy9VkzbQf3TAseERJrHEjSNuO1/3HE5Ge7Fv4=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 51E1Us3v019847
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 13 Feb 2025 19:30:54 -0600
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 13
 Feb 2025 19:30:54 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 13 Feb 2025 19:30:54 -0600
Received: from lelvsmtp5.itg.ti.com ([10.250.165.138])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 51E1UkwX047835;
	Thu, 13 Feb 2025 19:30:47 -0600
From: Baojun Xu <baojun.xu@ti.com>
To: <tiwai@suse.de>
CC: <robh+dt@kernel.org>, <andriy.shevchenko@linux.intel.com>,
        <lgirdwood@gmail.com>, <perex@perex.cz>, <shenghao-ding@ti.com>,
        <navada@ti.com>, <13916275206@139.com>, <v-hampiholi@ti.com>,
        <v-po@ti.com>, <linux-sound@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <liam.r.girdwood@intel.com>,
        <yung-chuan.liao@linux.intel.com>, <baojun.xu@ti.com>,
        <broonie@kernel.org>, <antheas.dk@gmail.com>,
        <stuart.a.hayhurst@gmail.com>, <dan.carpenter@linaro.org>
Subject: [PATCH v1] ALSA: hda/tas2781: Fix index issue in tas2781 hda SPI driver
Date: Fri, 14 Feb 2025 09:30:21 +0800
Message-ID: <20250214013021.6072-1-baojun.xu@ti.com>
X-Mailer: git-send-email 2.43.0.windows.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Correct wrong mask for device index.

Signed-off-by: Baojun Xu <baojun.xu@ti.com>
---
 sound/pci/hda/tas2781_spi_fwlib.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/sound/pci/hda/tas2781_spi_fwlib.c b/sound/pci/hda/tas2781_spi_fwlib.c
index 0e2acbc3c900..131d9a77d140 100644
--- a/sound/pci/hda/tas2781_spi_fwlib.c
+++ b/sound/pci/hda/tas2781_spi_fwlib.c
@@ -2,7 +2,7 @@
 //
 // TAS2781 HDA SPI driver
 //
-// Copyright 2024 Texas Instruments, Inc.
+// Copyright 2024-2025 Texas Instruments, Inc.
 //
 // Author: Baojun Xu <baojun.xu@ti.com>
 
@@ -771,19 +771,19 @@ static int tasdevice_process_block(void *context, unsigned char *data,
 	switch (subblk_typ) {
 	case TASDEVICE_CMD_SING_W:
 		subblk_offset = tasdevice_single_byte_wr(tas_priv,
-			dev_idx & 0x4f, data, sublocksize);
+			dev_idx & 0x3f, data, sublocksize);
 		break;
 	case TASDEVICE_CMD_BURST:
 		subblk_offset = tasdevice_burst_wr(tas_priv,
-			dev_idx & 0x4f, data, sublocksize);
+			dev_idx & 0x3f, data, sublocksize);
 		break;
 	case TASDEVICE_CMD_DELAY:
 		subblk_offset = tasdevice_delay(tas_priv,
-			dev_idx & 0x4f, data, sublocksize);
+			dev_idx & 0x3f, data, sublocksize);
 		break;
 	case TASDEVICE_CMD_FIELD_W:
 		subblk_offset = tasdevice_field_wr(tas_priv,
-			dev_idx & 0x4f, data, sublocksize);
+			dev_idx & 0x3f, data, sublocksize);
 		break;
 	default:
 		subblk_offset = 2;
-- 
2.34.1


