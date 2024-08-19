Return-Path: <linux-kernel+bounces-291343-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FD8995610E
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 04:28:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9C663B20F88
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 02:28:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A07B826AD3;
	Mon, 19 Aug 2024 02:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ZBKR9tgc"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15ABC1BC3F
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 02:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724034473; cv=none; b=HwF8rtRwjPFzFypCl0CY3aE29VafryEUi4O57ZfIqHBLhkeYSmZkQOtyP7O6OhkkHLN7M+Miik3BeyvmIZAUGuwDZninrhDCU+Jm+YqZt6eJwfFzk+sYwk+rxHtDrbYai3IObOD8r95YXgD79d1tYjPrIFkRuHToExPpSmLt0F0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724034473; c=relaxed/simple;
	bh=LSCupG02/Ed1bshuLVvTpK2bckvj19gdlUMYDUdV7EA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gu1BfXxqfcd0MPTQXbiNVoF/4ZOPohmd85x3pHqqnw+rxyS5O4x8SvbLvJe2EN006Bnec2K/LpILuFdpvaz7jZZ90rLa+wIiCkDqZsl8syKPhRjY+Tv4I4j3UT80H18Q0KFLE8bxEBU3jQYqOednDdVzHLvUS9ysa9MFM1c8ZIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=ZBKR9tgc; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47J0vvQZ113347;
	Sun, 18 Aug 2024 19:57:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1724029077;
	bh=9+/19Ub1ffFb/UmWr5MbbU+vVXKmn/RVnVeApWiejbM=;
	h=From:To:CC:Subject:Date;
	b=ZBKR9tgcZEs9QX7CNiFDAm3o+r7MUadXJLGVFqBMnPISDN89O8lW5cdn8F/M+fXgt
	 pxmI5U1mNQvjMUNYUTyB8RXyJeM9Ef+aqj4y7HkHh0R9/97MS44b3zys+bh92uRq/A
	 SElKSC4e/AA4B+iGt7GwlxLJsZ30ChJ4fd3SBAA0=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 47J0vvDS004375
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Sun, 18 Aug 2024 19:57:57 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sun, 18
 Aug 2024 19:57:56 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sun, 18 Aug 2024 19:57:56 -0500
Received: from LT5CG31242FY.dhcp.ti.com ([10.250.160.152])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47J0vsTp057724;
	Sun, 18 Aug 2024 19:57:54 -0500
From: Shenghao Ding <shenghao-ding@ti.com>
To: <linux-kernel@vger.kernel.org>
CC: <baojun.xu@ti.com>, <13564923607@139.com>, <robinchen@ti.com>,
        <alsa-devel@alsa-project.org>, Shenghao Ding <shenghao-ding@ti.com>
Subject: [PATCH v3] MAINTAINERS: update entries in TEXAS INSTRUMENTS LOW/MIDDLE-POWER AUDIO AMPLIFIER (ASoC/HDA) DRIVERS and add entries for haptic driver
Date: Mon, 19 Aug 2024 08:57:49 +0800
Message-ID: <20240819005750.173-1-shenghao-ding@ti.com>
X-Mailer: git-send-email 2.33.0.windows.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Due to internal re-org, Kevin is no longer mnaintaining audio driver.
Due to job change, drop entries for the audio converter and add
entries for both haptics drivers and middle-power audio amplifier
drivers. Add audio converter, set the Status as Supported. So far, the
Software maintainer has not been confirmed. Once the maintainer was
confimred, the guy will update his mail into audio converter section.

Signed-off-by: Shenghao Ding <shenghao-ding@ti.com>

---
v3:
 - Add Audio converter section
 - Set the section of LOW/MIDDLE-POWER AUDIO AMPLIFIER as Supported
v2:
 - Add the detailed information of the maintained drivers.
---
 MAINTAINERS | 33 ++++++++++++++++++++++++---------
 1 file changed, 24 insertions(+), 9 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index f328373463b0..32954c5a63c3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -22569,26 +22569,42 @@ S:	Maintained
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
+TEXAS INSTRUMENTS AUDIO Converter (ASoC) DRIVERS
+L:	alsa-devel@alsa-project.org (moderated for non-subscribers)
+S:	Maintained
 F:	Documentation/devicetree/bindings/sound/ti,pcm1681.yaml
 F:	Documentation/devicetree/bindings/sound/ti,pcm3168a.yaml
+F:	Documentation/devicetree/bindings/sound/ti,pcm6240.yaml
 F:	Documentation/devicetree/bindings/sound/ti,tlv320*.yaml
 F:	Documentation/devicetree/bindings/sound/ti,tlv320adcx140.yaml
 F:	Documentation/devicetree/bindings/sound/tlv320aic31xx.txt
-F:	Documentation/devicetree/bindings/sound/tpa6130a2.txt
-F:	include/sound/tas2*.h
 F:	include/sound/tlv320*.h
-F:	include/sound/tpa6130a2-plat.h
-F:	sound/pci/hda/tas2781_hda_i2c.c
 F:	sound/soc/codecs/pcm1681.c
 F:	sound/soc/codecs/pcm1789*.*
 F:	sound/soc/codecs/pcm179x*.*
@@ -22598,9 +22614,8 @@ F:	sound/soc/codecs/pcm3060*.*
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


