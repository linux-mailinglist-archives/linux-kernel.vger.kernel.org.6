Return-Path: <linux-kernel+bounces-346895-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6330898CA72
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 03:12:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E99911F22DCA
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 01:12:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7E021C36;
	Wed,  2 Oct 2024 01:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="WFIOe5eU"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FF715227
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 01:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727831529; cv=none; b=B2JF8RljbtgRLCHrYGzuE9pNw1xWl3+M0T+XiTOOv7L0NtDN8rhrm+rtB3e4uxMar98ubBIrGTCHISNs+5RrrflU+CPdx9nOWzrxYiijdbInvLiIg1z/KIXYBYHubm19H7mM3wspwm6Rj0wUStKNoxvYSxYsCdIpEqu7iHJ2iCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727831529; c=relaxed/simple;
	bh=z98NvQKhkw1XBbwZGjWlSpFHs0vVHMhfc0SCYr8TQhU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tZVzzVlg19sP5SWPOThgjvCO4Jp8mIaLQVEQ8m1dhl3NL03YBvFRktcg3xmHN19UhbDaCKU+TJHjxUkro7mKhTpYyQcd6TBfWxPM+YspKSDMeoMHx8mJOHoESlzRFsIZSSZOJ1OQcuXbBKOyu0Dzl4oLJBNAQHkcFVLYga9qthk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=WFIOe5eU; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4921Bv5G065362;
	Tue, 1 Oct 2024 20:11:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1727831517;
	bh=hcFr96sAOM9Uc9TKipvNfZDwqqAIp8oT1vPCsTcntVA=;
	h=From:To:CC:Subject:Date;
	b=WFIOe5eUWJClipKz39A8/ZtTDj+7KgKhlhi8sLwhYJpAWNd0x5EGZ8s8IZKyvmpAE
	 UkBxjjvRkQWv3GehdDftNMM+OfBWtHLu6NxeZHbPDBC3ESLHtKsAd4f0e1ACjWVPYO
	 fFj9Wz78/e9LYWkuiYBKp+iqEwamELyVeaei+Ze4=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4921BvDY075420;
	Tue, 1 Oct 2024 20:11:57 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 1
 Oct 2024 20:11:57 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 1 Oct 2024 20:11:57 -0500
Received: from LT5CG31242FY.dhcp.ti.com ([10.250.161.55])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4921Bqat075695;
	Tue, 1 Oct 2024 20:11:53 -0500
From: Shenghao Ding <shenghao-ding@ti.com>
To: <linux-kernel@vger.kernel.org>
CC: <baojun.xu@ti.com>, <13564923607@139.com>, <13916275206@139.com>,
        <navada@ti.com>, <v-hampiholi@ti.com>, <m-shrivastava1@ti.com>,
        <sakshi@ti.com>, <sandeepk@ti.com>, <robinchen@ti.com>,
        <alsa-devel@alsa-project.org>, Shenghao Ding <shenghao-ding@ti.com>
Subject: [RESEND PATCH v4] MAINTAINERS: update entries in TEXAS INSTRUMENTS LOW/MIDDLE-POWER AUDIO AMPLIFIER (ASoC/HDA) DRIVERS and add entries for haptic driver
Date: Wed, 2 Oct 2024 09:11:47 +0800
Message-ID: <20241002011147.1345-1-shenghao-ding@ti.com>
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
v4:
 - Add Touch Screen support
v3:
 - Add Audio converter section
 - Set the section of LOW/MIDDLE-POWER AUDIO AMPLIFIER as Supported
v2:
 - Add the detailed information of the maintained drivers.
---
 MAINTAINERS | 35 ++++++++++++++++++++++++++---------
 1 file changed, 26 insertions(+), 9 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index c27f3190737f..689cc1ae70b5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -22897,25 +22897,43 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/sound/davinci-mcasp-audio.yaml
 F:	sound/soc/ti/
 
-TEXAS INSTRUMENTS AUDIO (ASoC/HDA) DRIVERS
+TEXAS INSTRUMENTS LOW/MIDDLE-POWER AUDIO AMPLIFIER (ASoC/HDA) & HAPTICS DRIVERS
 M:	Shenghao Ding <shenghao-ding@ti.com>
-M:	Kevin Lu <kevin-lu@ti.com>
 M:	Baojun Xu <baojun.xu@ti.com>
 L:	alsa-devel@alsa-project.org (moderated for non-subscribers)
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
-F:	Documentation/devicetree/bindings/sound/ti,tpa6130a2.yaml
+F:	Documentation/devicetree/bindings/sound/ti,tas5086.txt
+F:	Documentation/devicetree/bindings/sound/ti,tas57xx.yaml
+F:	Documentation/devicetree/bindings/sound/ti,tas5805m.yaml
+F:	Documentation/devicetree/bindings/sound/tpa6130a2.txt
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
+L:	alsa-devel@alsa-project.org (moderated for non-subscribers)
+S:	Maintained
 F:	Documentation/devicetree/bindings/sound/ti,pcm1681.yaml
 F:	Documentation/devicetree/bindings/sound/ti,pcm3168a.yaml
+F:	Documentation/devicetree/bindings/sound/ti,pcm6240.yaml
 F:	Documentation/devicetree/bindings/sound/ti,tlv320*.yaml
 F:	Documentation/devicetree/bindings/sound/ti,tlv320adcx140.yaml
-F:	include/sound/tas2*.h
+F:	Documentation/devicetree/bindings/sound/tlv320aic31xx.txt
+F:	drivers/input/touchscreen/tsc2*.*
 F:	include/sound/tlv320*.h
-F:	include/sound/tpa6130a2-plat.h
-F:	sound/pci/hda/tas2781_hda_i2c.c
 F:	sound/soc/codecs/pcm1681.c
 F:	sound/soc/codecs/pcm1789*.*
 F:	sound/soc/codecs/pcm179x*.*
@@ -22925,9 +22943,8 @@ F:	sound/soc/codecs/pcm3060*.*
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


