Return-Path: <linux-kernel+bounces-310100-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 753E09674EA
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Sep 2024 06:15:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1606C28786E
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Sep 2024 04:15:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EF31171D2;
	Sun,  1 Sep 2024 04:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="CWHDUzWS"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B8F937708
	for <linux-kernel@vger.kernel.org>; Sun,  1 Sep 2024 04:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725164115; cv=none; b=CXSwkcX+KJVzGqn2IEyQlbvniy9w85XZgc4c3Pks1Dpw/fQFV9SIAy7imAMN3GK0nxh70CBUatIckSen5zauQsMw/8a3Xoh/E/wN+dMGddqyOr7zUmF9mUWzh99I35qlWUS8znVefT0JvHmk1JnzaJDpO+gATi387WJg90k8icQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725164115; c=relaxed/simple;
	bh=N1qyzebOPPr4MFj/fz8OBKWOQl02rsdyQSABarlOVyw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=DCCyDkUGbjjyLC/JeJZoUXmVhCKvlB03igCePIXvG7WZNt2fhxz3kX1u5eg+KN8o2h/JzgPnUCVqNLQctU9T4TEu03VX8v+7oNOwi9VxijvjWtq6bdp+XK9NEYgtzJQTIwI44t4jEl3x7gI+TcfYFBOPQ6tbEyXbm+DI3bk24NA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=CWHDUzWS; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4814EuiJ021044;
	Sat, 31 Aug 2024 23:14:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1725164096;
	bh=Vvrk7weRt2njxNz4Baew/bPUSNDz8gUCQ3JxiclKtJo=;
	h=From:To:CC:Subject:Date;
	b=CWHDUzWSFX3p/k5ZbczpYYwX2JeEpH2f7/0m5G9Ny/2tciTtw14verz1pfDHOz3xB
	 JrYeyFXcodFJIsyztVoIDjjZJBakIhmmUN/akYLrKJtxVkC6Hw/IgRonqQh6CHmAz0
	 Djdrs93iRb5fS0oJgXtK59FFij3RMFh3TehQYXy0=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4814Euqg025681
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Sat, 31 Aug 2024 23:14:56 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sat, 31
 Aug 2024 23:14:56 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sat, 31 Aug 2024 23:14:56 -0500
Received: from LT5CG31242FY.dhcp.ti.com ([10.250.160.161])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4814Er0U057741;
	Sat, 31 Aug 2024 23:14:54 -0500
From: Shenghao Ding <shenghao-ding@ti.com>
To: <linux-kernel@vger.kernel.org>
CC: <baojun.xu@ti.com>, <13564923607@139.com>, <13916275206@139.com>,
        <robinchen@ti.com>, <alsa-devel@alsa-project.org>,
        Shenghao Ding
	<shenghao-ding@ti.com>
Subject: [RESEND PATCH v4] MAINTAINERS: update entries in TEXAS INSTRUMENTS LOW/MIDDLE-POWER AUDIO AMPLIFIER (ASoC/HDA) DRIVERS and add entries for haptic driver
Date: Sun, 1 Sep 2024 12:14:48 +0800
Message-ID: <20240901041448.1236-1-shenghao-ding@ti.com>
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
v4:
 - Add Touch Screen support
v3:
 - Add Audio converter section
 - Set the section of LOW/MIDDLE-POWER AUDIO AMPLIFIER as Supported
v2:
 - Add the detailed information of the maintained drivers.
---
 MAINTAINERS | 34 +++++++++++++++++++++++++---------
 1 file changed, 25 insertions(+), 9 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index fe83ba7194ea..a2448dab3601 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -22596,26 +22596,43 @@ S:	Maintained
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
+TEXAS INSTRUMENTS AUDIO Converter (ASoC) and Touch Screen DRIVERS
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
+F:	drivers/input/touchscreen/tsc2*.*
 F:	include/sound/tlv320*.h
-F:	include/sound/tpa6130a2-plat.h
-F:	sound/pci/hda/tas2781_hda_i2c.c
 F:	sound/soc/codecs/pcm1681.c
 F:	sound/soc/codecs/pcm1789*.*
 F:	sound/soc/codecs/pcm179x*.*
@@ -22625,9 +22642,8 @@ F:	sound/soc/codecs/pcm3060*.*
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


