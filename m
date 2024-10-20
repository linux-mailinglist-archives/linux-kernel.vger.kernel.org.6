Return-Path: <linux-kernel+bounces-373173-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AE7289A534D
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 11:30:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58E9D1F22724
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 09:30:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2E4112EBE7;
	Sun, 20 Oct 2024 09:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="laP+EMK3"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 941002BB13
	for <linux-kernel@vger.kernel.org>; Sun, 20 Oct 2024 09:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729416594; cv=none; b=EWMc32okQJLXCSWZ0IVLe8+exE0GFoSwRmjppjzQrlohJaBkJb5UrND6Q5Nu8xjfdyeOI3AzpbtgVVf1/7XI1eajyz4w510afC+cJ/tK3TPQKEQ1c7sh7N9FphivOBHGs6dfU+NYyFxy7SjBZFMb7FKxCkwGLYCO1gCgEfZNqLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729416594; c=relaxed/simple;
	bh=f4+3NrXiOvRx5VMS92z8cndi93FcTfRv/14V0+tnu1I=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=E86gTYcJkaRloJ+muq6Okx+H8KLQyKJKtBUVSZkA/NV/FcGFzvMLcNCW2l9yBqXSUySs4xmJl9WeDYsti83fJS+/04GSmcxS8AVgegUD8D9N4JqPvMCNUFAwn3u5LjBI3YLR0o+N6ogaYWHO9nhMMCx9OApX/FnNgr92HlnqW4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=laP+EMK3; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 49K8Nh63047918;
	Sun, 20 Oct 2024 03:23:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1729412623;
	bh=xexHhvEe2kVwpZ9LE2L5U2BC9N6li+GrRCgPFQOWfO4=;
	h=From:To:CC:Subject:Date;
	b=laP+EMK3VMMsdPOXK2wvd8zPyPRnQXtSw+lyfFAjIxrYSf5112WTgOLYAB1b+tLXF
	 9QFiiTlC2bRVDlHXdKsUg2nYUZD7Z3oBvHOSwmVUqSGdw/QkjomvkoH3cqiDQd8wSZ
	 oZE8vGzOVVz+2jlNotxTSKh6sHS2jO37QCF7TAaE=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 49K8Nh6D076080
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Sun, 20 Oct 2024 03:23:43 -0500
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sun, 20
 Oct 2024 03:23:43 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sun, 20 Oct 2024 03:23:43 -0500
Received: from LT5CG31242FY.dhcp.ti.com ([10.250.161.55])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 49K8Nc6R033118;
	Sun, 20 Oct 2024 03:23:39 -0500
From: Shenghao Ding <shenghao-ding@ti.com>
To: <linux-kernel@vger.kernel.org>
CC: <baojun.xu@ti.com>, <13564923607@139.com>, <13916275206@139.com>,
        <navada@ti.com>, <v-hampiholi@ti.com>, <m-shrivastava1@ti.com>,
        <sakshi@ti.com>, <sandeepk@ti.com>, <robinchen@ti.com>,
        <alsa-devel@alsa-project.org>, Shenghao Ding <shenghao-ding@ti.com>
Subject: [PATCH v6] MAINTAINERS: update entries in TEXAS INSTRUMENTS LOW/MIDDLE-POWER AUDIO AMPLIFIER (ASoC/HDA) DRIVERS and add entries for haptic driver
Date: Sun, 20 Oct 2024 16:23:34 +0800
Message-ID: <20241020082334.857-1-shenghao-ding@ti.com>
X-Mailer: git-send-email 2.33.0.windows.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Due to internal re-org, Kevin has no longer maintained audio driver.
Due to job responsibility change, drop entries for the audio converter
and add entries for both haptics drivers and middle-power audio amplifier
drivers. Add audio converter, set the Status as Supported.

Signed-off-by: Shenghao Ding <shenghao-ding@ti.com>

---
v6:
 - fixed spelling mistakes
v5:
 - | Reported-by: kernel test robot <lkp@intel.com>
   | Closes: https://lore.kernel.org/oe-kbuild-all/202410021557.FByBO9Dp-lkp@intel.com/
v4:
 - Add Touch Screen support
v3:
 - Add Audio converter section
 - Set the section of LOW/MIDDLE-POWER AUDIO AMPLIFIER as Supported
v2:
 - Add the detailed information of the maintained drivers.
---
 MAINTAINERS | 32 ++++++++++++++++++++++++--------
 1 file changed, 24 insertions(+), 8 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 87198c5e589e..d1484b5658e3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -22910,25 +22910,42 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/sound/davinci-mcasp-audio.yaml
 F:	sound/soc/ti/
 
-TEXAS INSTRUMENTS AUDIO (ASoC/HDA) DRIVERS
+TEXAS INSTRUMENTS LOW/MIDDLE-POWER AUDIO AMPLIFIER (ASoC/HDA) & HAPTICS DRIVERS
 M:	Shenghao Ding <shenghao-ding@ti.com>
-M:	Kevin Lu <kevin-lu@ti.com>
 M:	Baojun Xu <baojun.xu@ti.com>
 L:	linux-sound@vger.kernel.org
-S:	Maintained
+S:	Supported
+F:	Documentation/devicetree/bindings/input/ti,drv260x.yaml
+F:	Documentation/devicetree/bindings/input/ti,drv266x.yaml
 F:	Documentation/devicetree/bindings/sound/tas2552.txt
+F:	Documentation/devicetree/bindings/sound/tas5720.txt
 F:	Documentation/devicetree/bindings/sound/ti,tas2562.yaml
 F:	Documentation/devicetree/bindings/sound/ti,tas2770.yaml
+F:	Documentation/devicetree/bindings/sound/ti,tas2781.yaml
 F:	Documentation/devicetree/bindings/sound/ti,tas27xx.yaml
+F:	Documentation/devicetree/bindings/sound/ti,tas5086.txt
+F:	Documentation/devicetree/bindings/sound/ti,tas57xx.yaml
+F:	Documentation/devicetree/bindings/sound/ti,tas5805m.yaml
 F:	Documentation/devicetree/bindings/sound/ti,tpa6130a2.yaml
+F:	drivers/input/misc/drv2*.c
+F:	include/sound/tas2*.h
+F:	include/sound/tas5086.h
+F:	include/sound/tpa6130a2-plat.h
+F:	sound/pci/hda/tas2781_hda_i2c.c
+F:	sound/soc/codecs/tas2*.*
+F:	sound/soc/codecs/tas5*.*
+F:	sound/soc/codecs/tpa6130a2.*
+
+TEXAS INSTRUMENTS AUDIO Converter (ASoC) and Touch Screen DRIVERS
+L:	linux-sound@vger.kernel.org
+S:	Maintained
 F:	Documentation/devicetree/bindings/sound/ti,pcm1681.yaml
 F:	Documentation/devicetree/bindings/sound/ti,pcm3168a.yaml
+F:	Documentation/devicetree/bindings/sound/ti,pcm6240.yaml
 F:	Documentation/devicetree/bindings/sound/ti,tlv320*.yaml
 F:	Documentation/devicetree/bindings/sound/ti,tlv320adcx140.yaml
-F:	include/sound/tas2*.h
+F:	drivers/input/touchscreen/tsc2*.*
 F:	include/sound/tlv320*.h
-F:	include/sound/tpa6130a2-plat.h
-F:	sound/pci/hda/tas2781_hda_i2c.c
 F:	sound/soc/codecs/pcm1681.c
 F:	sound/soc/codecs/pcm1789*.*
 F:	sound/soc/codecs/pcm179x*.*
@@ -22938,9 +22955,8 @@ F:	sound/soc/codecs/pcm3060*.*
 F:	sound/soc/codecs/pcm3168a*.*
 F:	sound/soc/codecs/pcm5102a.c
 F:	sound/soc/codecs/pcm512x*.*
-F:	sound/soc/codecs/tas2*.*
+F:	sound/soc/codecs/pcm6240.*
 F:	sound/soc/codecs/tlv320*.*
-F:	sound/soc/codecs/tpa6130a2.*
 
 TEXAS INSTRUMENTS DMA DRIVERS
 M:	Peter Ujfalusi <peter.ujfalusi@gmail.com>
-- 
2.34.1


