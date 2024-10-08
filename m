Return-Path: <linux-kernel+bounces-354852-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E2C35994384
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 11:06:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8AE721F26808
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 09:06:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A6691D0E34;
	Tue,  8 Oct 2024 09:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="XFtsB8tI"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D98E613A88A
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 09:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728378095; cv=none; b=g/v+anM5dz7+mEag42cAsJEm2tf+rd/qkBwJ5gFVJkGVO8xQ5vyrXPBQlv0fPBROcmCeK/MVirCbACAyrYP9FoLpabydEqgrCaLsdvOetDvs5EOPo+yEe+uG7DjY4o2TUiZGFSqPyuj75q1y9PcyOeVJjgeWnsexdCkInvUHERU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728378095; c=relaxed/simple;
	bh=a2Lka12I+944SR7l+lXTUahOT32pJduQSO1CNn7GJL4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=GBdrABXs3WznCySVsNVvvkNGQ1xjVhcvcdEwYhsFtILLPDmgjE36M7LQSsPiwSGif5s3v5aYAI+HzlzOcq6TCBpK0MjaI4JKVUXJX2zl+VKsXPUgVzgUGuZByvkeQzBML7jaJla6VKRV1FgXsM5rze13JlHWXxpTN3iFhyZEd8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=XFtsB8tI; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 49891J3v120985;
	Tue, 8 Oct 2024 04:01:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1728378079;
	bh=0oTotaH4I4rxhhRb8VxxetmOMUWnu5ssBNn0TEWG5w8=;
	h=From:To:CC:Subject:Date;
	b=XFtsB8tIqLTiYQz8CAat9Gx2JGzg4Ci93mb9JDPSHni/5bdwABCMtcAJAzIXb9RLd
	 6Lvp0BN1N0dnz5ocisfR39WpeQYrwmhgs+BO1zv7SzPonAnRuZuQI34f2oKstSVwqg
	 L2k6wAzY+ytr72qdifi/n+8bjs7TGo0jW/tTu3jE=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 49891JDZ004532
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 8 Oct 2024 04:01:19 -0500
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 8
 Oct 2024 04:01:19 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 8 Oct 2024 04:01:19 -0500
Received: from LT5CG31242FY.dhcp.ti.com (lt5cg31242fy.dhcp.ti.com [10.85.14.123])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 49891Fwh069830;
	Tue, 8 Oct 2024 04:01:15 -0500
From: Shenghao Ding <shenghao-ding@ti.com>
To: <linux-kernel@vger.kernel.org>
CC: <baojun.xu@ti.com>, <13564923607@139.com>, <13916275206@139.com>,
        <navada@ti.com>, <v-hampiholi@ti.com>, <m-shrivastava1@ti.com>,
        <sakshi@ti.com>, <sandeepk@ti.com>, <robinchen@ti.com>,
        <alsa-devel@alsa-project.org>, Shenghao Ding <shenghao-ding@ti.com>
Subject: [PATCH v5] MAINTAINERS: update entries in TEXAS INSTRUMENTS LOW/MIDDLE-POWER AUDIO AMPLIFIER (ASoC/HDA) DRIVERS and add entries for haptic driver
Date: Tue, 8 Oct 2024 17:01:08 +0800
Message-ID: <20241008090109.48-1-shenghao-ding@ti.com>
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

Due to internal re-org, Kevin is no longer mnaintaining audio driver.
Due to job change, drop entries for the audio converter and add
entries for both haptics drivers and middle-power audio amplifier
drivers. Add audio converter, set the Status as Supported. So far, the
Software maintainer has not been confirmed. Once the maintainer was
confimred, the guy will update his mail into audio converter section.

Signed-off-by: Shenghao Ding <shenghao-ding@ti.com>

---
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
index a097afd76ded..ecc987548088 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -22901,25 +22901,42 @@ S:	Maintained
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
@@ -22929,9 +22946,8 @@ F:	sound/soc/codecs/pcm3060*.*
 F:	sound/soc/codecs/pcm3168a*.*
 F:	sound/soc/codecs/pcm5102a.c
 F:	sound/soc/codecs/pcm512x*.*
-F:	sound/soc/codecs/tas2*.*
+F:	sound/soc/codecs/pcm6240.*
 F:	sound/soc/codecs/tlv320*.*
-F:	sound/soc/codecs/tpa6130a2.*
 
 TEXAS INSTRUMENTS DMA DRIVERS
 M:	Peter Ujfalusi <peter.ujfalusi@gmail.com>

base-commit: 87d6aab2389e5ce0197d8257d5f8ee965a67c4cd
-- 
2.34.1


