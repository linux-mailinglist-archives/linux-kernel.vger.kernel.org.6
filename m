Return-Path: <linux-kernel+bounces-273659-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 36C95946BF0
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Aug 2024 04:11:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 96B5EB21660
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Aug 2024 02:11:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E1A33FC2;
	Sun,  4 Aug 2024 02:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Vsgt6i1M"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE0A81C20
	for <linux-kernel@vger.kernel.org>; Sun,  4 Aug 2024 02:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722737483; cv=none; b=qQo2H3cA21sjg6Q/m1zA0ur7ArTC0o6+pcx6jfkwKOeIXCuQMlL4mDbwVd04s3ht8UDvl40Xw/6XIArWIusVUnWWZMGEJyUZJ7h/MKAOmWUMYCfl3NOrEtRxfG2YFJqTL6AyfehpQz6VXj5P7wpcnWR0+9V4B6B0I1z8racN1ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722737483; c=relaxed/simple;
	bh=pMNWvnX0oXqGdbUFqY1gy7d59DBaFMQ6daE7FrQ2cok=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tkB97wbgGmYhK10hFTCJO/VdD9ukAkcBozQiN/D7+Iy3qzjHLZGlSm8BBR2fiSpdQ4SQ9A2aScVaE3LrtN5h1v2oXhdTz6UuZrolwhOV3OjUHAkjRVOjURueYl7kCY/5Qh3+FpQxDHg2G91x0SHxhDsVdUlovKpovzXWhRYcrAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Vsgt6i1M; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4742B4cg017298;
	Sat, 3 Aug 2024 21:11:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1722737464;
	bh=0M1j4GPHFXZKwZggPzkLnpr55RObTkvzbmxuiEEK9Eg=;
	h=From:To:CC:Subject:Date;
	b=Vsgt6i1MlAno3BKPtlNE0rD7Kbx178yhETsfQaXquMFuW+2ZkhXddQ2k0LeJjjKpr
	 8YZmP6Z5fejFO06J9rc16Du7gP+Hl9Xe3HscEJS1zeDTl7EVEasE39GCx9XQazN+i+
	 HKaQd0UP1zzUAKYpTpvbxMzjD6PfsNm+l0X6Kp6E=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4742B4Ea088546
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Sat, 3 Aug 2024 21:11:04 -0500
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sat, 3
 Aug 2024 21:11:03 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sat, 3 Aug 2024 21:11:03 -0500
Received: from LT5CG31242FY.dhcp.ti.com ([10.250.160.49])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4742B0rN048121;
	Sat, 3 Aug 2024 21:11:01 -0500
From: Shenghao Ding <shenghao-ding@ti.com>
To: <linux-kernel@vger.kernel.org>
CC: <baojun.xu@ti.com>, <13564923607@139.com>, <robinchen@ti.com>,
        <alsa-devel@alsa-project.org>, Shenghao Ding <shenghao-ding@ti.com>
Subject: [PATCH v1] MAINTAINERS: update entries in TEXAS INSTRUMENTS AUDIO (ASoC/HDA) DRIVERS and add entries for haptic driver
Date: Sun, 4 Aug 2024 10:10:53 +0800
Message-ID: <20240804021054.1035-1-shenghao-ding@ti.com>
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
Due to job change to Shenghao Ding and Baojun Xu, drop entries for the
audio converter and add entries for both haptics drivers and middle-
power audio amplifier drivers.

Signed-off-by: Shenghao Ding <shenghao-ding@ti.com>
---
 MAINTAINERS | 29 +++++++++++------------------
 1 file changed, 11 insertions(+), 18 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8766f3e5e87e..34639103e463 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -22567,37 +22567,30 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/sound/davinci-mcasp-audio.yaml
 F:	sound/soc/ti/
 
-TEXAS INSTRUMENTS AUDIO (ASoC/HDA) DRIVERS
+TEXAS INSTRUMENTS AUDIO (ASoC/HDA) & HAPTICS DRIVERS
 M:	Shenghao Ding <shenghao-ding@ti.com>
-M:	Kevin Lu <kevin-lu@ti.com>
 M:	Baojun Xu <baojun.xu@ti.com>
 L:	alsa-devel@alsa-project.org (moderated for non-subscribers)
 S:	Maintained
+F:	Documentation/devicetree/bindings/input/ti,drv260x.yaml
+F:	Documentation/devicetree/bindings/input/ti,drv266x.yaml
 F:	Documentation/devicetree/bindings/sound/tas2552.txt
+F:	Documentation/devicetree/bindings/sound/tas5720.txt
 F:	Documentation/devicetree/bindings/sound/ti,tas2562.yaml
 F:	Documentation/devicetree/bindings/sound/ti,tas2770.yaml
+F:	Documentation/devicetree/bindings/sound/ti,tas2781.yaml
 F:	Documentation/devicetree/bindings/sound/ti,tas27xx.yaml
-F:	Documentation/devicetree/bindings/sound/ti,pcm1681.yaml
-F:	Documentation/devicetree/bindings/sound/ti,pcm3168a.yaml
-F:	Documentation/devicetree/bindings/sound/ti,tlv320*.yaml
-F:	Documentation/devicetree/bindings/sound/ti,tlv320adcx140.yaml
-F:	Documentation/devicetree/bindings/sound/tlv320aic31xx.txt
+F:	Documentation/devicetree/bindings/sound/ti,tas5086.txt
+F:	Documentation/devicetree/bindings/sound/ti,tas57xx.yaml
+F:	Documentation/devicetree/bindings/sound/ti,tas5805m.yaml
 F:	Documentation/devicetree/bindings/sound/tpa6130a2.txt
+F:	drivers/input/misc/drv2*.c
 F:	include/sound/tas2*.h
-F:	include/sound/tlv320*.h
+F:	include/sound/tas5086.h
 F:	include/sound/tpa6130a2-plat.h
 F:	sound/pci/hda/tas2781_hda_i2c.c
-F:	sound/soc/codecs/pcm1681.c
-F:	sound/soc/codecs/pcm1789*.*
-F:	sound/soc/codecs/pcm179x*.*
-F:	sound/soc/codecs/pcm186x*.*
-F:	sound/soc/codecs/pcm3008.*
-F:	sound/soc/codecs/pcm3060*.*
-F:	sound/soc/codecs/pcm3168a*.*
-F:	sound/soc/codecs/pcm5102a.c
-F:	sound/soc/codecs/pcm512x*.*
 F:	sound/soc/codecs/tas2*.*
-F:	sound/soc/codecs/tlv320*.*
+F:	sound/soc/codecs/tas5*.*
 F:	sound/soc/codecs/tpa6130a2.*
 
 TEXAS INSTRUMENTS DMA DRIVERS
-- 
2.34.1


