Return-Path: <linux-kernel+bounces-282135-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 70D7B94E005
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2024 07:15:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E4CA1C20D1C
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2024 05:15:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 244DE1798C;
	Sun, 11 Aug 2024 05:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="pgAIUNrd"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CF7B12E5B
	for <linux-kernel@vger.kernel.org>; Sun, 11 Aug 2024 05:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723353313; cv=none; b=Uop376MTV4eu94pVMGyk1Yj3/2SSqhoVwVOra05mm90LlDaNx3kskBAKqAILulipwR4e+qFKN8NdTzJaxnfPVzlf/1ZzLdBSjfQ9W0JmUFuKw3pHLNviiF6oVw3AqNLC45mEMG9rK+2P4AFITeOTSetZijH6hCXWkCilcBZwVcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723353313; c=relaxed/simple;
	bh=b8CW4c/6Nd6c4UOmnSTQaEDu3v75tfUytdfjWYBcX5k=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kRuyG4LtbovZYyTe5q2dBK9Qtjca3WV77lruPadjsa6O1aHiPAwUpDckh0LyDPRcOhWkOtju/hcv+gywwvDAV4N32mOpBHbZ60sFvaV0VdQz5ZdtrzVGWXzwR8aAybKR3fN6aS40OdXGay3E17E0AniT8/FrxbubN56XydRvcSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=pgAIUNrd; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47B5Estc127538;
	Sun, 11 Aug 2024 00:14:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1723353294;
	bh=dKv5oKRSD9gOCXzLcHTQOIALI08gMLiZsQmG5gcQiRU=;
	h=From:To:CC:Subject:Date;
	b=pgAIUNrdm4i+xxnEuQ24btrf2defI094C3rn9ytG+mjFoKglXsnyfuuHCnh5vWysg
	 c2Jir28fZl2XCfZFqRnRynKiWZZEOrVSzSaeYQLmbM2VVjNg9ZIheZmoWU4n5jowCm
	 XEGCkoIcgu6Fj6yU26A04rJlyQ9sXKgt8jx6tuRg=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 47B5Es5n003011
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Sun, 11 Aug 2024 00:14:54 -0500
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sun, 11
 Aug 2024 00:14:53 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sun, 11 Aug 2024 00:14:53 -0500
Received: from LT5CG31242FY.dhcp.ti.com ([10.250.160.152])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47B5EoFa002056;
	Sun, 11 Aug 2024 00:14:51 -0500
From: Shenghao Ding <shenghao-ding@ti.com>
To: <linux-kernel@vger.kernel.org>
CC: <baojun.xu@ti.com>, <13564923607@139.com>, <robinchen@ti.com>,
        <alsa-devel@alsa-project.org>, Shenghao Ding <shenghao-ding@ti.com>
Subject: [PATCH v2] MAINTAINERS: update entries in TEXAS INSTRUMENTS LOW/MIDDLE-POWER AUDIO AMPLIFIER (ASoC/HDA) DRIVERS and add entries for haptic driver
Date: Sun, 11 Aug 2024 13:14:44 +0800
Message-ID: <20240811051445.1600-1-shenghao-ding@ti.com>
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
v2:
 - Add the detailed information of the maintained drivers.
---
 MAINTAINERS | 29 +++++++++++------------------
 1 file changed, 11 insertions(+), 18 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index f328373463b0..d1f7e096b270 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -22569,37 +22569,30 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/sound/davinci-mcasp-audio.yaml
 F:	sound/soc/ti/
 
-TEXAS INSTRUMENTS AUDIO (ASoC/HDA) DRIVERS
+TEXAS INSTRUMENTS LOW/MIDDLE-POWER AUDIO AMPLIFIER (ASoC/HDA) & HAPTICS DRIVERS
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


