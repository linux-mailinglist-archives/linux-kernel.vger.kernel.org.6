Return-Path: <linux-kernel+bounces-575003-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48691A6EC74
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 10:28:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B80BE7A30C2
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 09:27:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47B10253F2A;
	Tue, 25 Mar 2025 09:28:20 +0000 (UTC)
Received: from cstnet.cn (smtp84.cstnet.cn [159.226.251.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6158D1FDD;
	Tue, 25 Mar 2025 09:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742894899; cv=none; b=oPVvkRqx3D5KBBqFEKdWWqi/SMp+TgUxIPcsKdRQ/vLLmFDSysI79KM/qkaKFFiWWFp30JtWQDQVBGpXfHf9XSMhoVPNbhBlhsdcH2uCwEZIDceEd2zczrTXBH93xx2dLKqxn38WlzZDlEFaU6lxG2DTO5VUn4NGu5WATKuWBQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742894899; c=relaxed/simple;
	bh=RlzV/DVotiI5IkmU1KWUD9pG+Qn9qmbhQ/6ss8Rk0+I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UEPqfVDuIyknU4q9CQ2MyQwFOUhWdaZV7oClFgqHiRwGLvJ3at/Bpv1/UE726UFAUYf/EVqnn8IuiBRWd5+/bRit9aEV1Q5I7SSLrT1CAJ9oCt+jN2T+8Wd4DeVpJXHlePUJSLRKvPt1v5c0C5HbwnmOWqJ6a/qjB5Y8QhWr3UI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost (unknown [124.16.138.129])
	by APP-05 (Coremail) with SMTP id zQCowACn5g4cd+JnPWRMAQ--.6335S2;
	Tue, 25 Mar 2025 17:27:56 +0800 (CST)
From: Chen Ni <nichen@iscas.ac.cn>
To: lgirdwood@gmail.com,
	broonie@kernel.org,
	perex@perex.cz,
	tiwai@suse.com,
	wens@csie.org,
	jernej.skrabec@gmail.com,
	samuel@sholland.org,
	ckeepax@opensource.cirrus.com,
	u.kleine-koenig@baylibre.com,
	megi@xff.cz
Cc: linux-sound@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Chen Ni <nichen@iscas.ac.cn>
Subject: [PATCH v2] ASoC: sun8i-codec: Remove unnecessary NULL check before clk_prepare_enable/clk_disable_unprepare
Date: Tue, 25 Mar 2025 17:26:40 +0800
Message-Id: <20250325092640.996802-1-nichen@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowACn5g4cd+JnPWRMAQ--.6335S2
X-Coremail-Antispam: 1UD129KBjvJXoWxJrWDWF18XrWDCr45WFWDtwb_yoW8GF15pa
	4fGFWftrWfJ34F9rs3Zr18t3W5KrW29ay3A3yYk3Z5Zwn8GF10qF45Ja4v9FZ0kr98KF47
	Wr1UtasYyFn8GaDanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBj14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Gr1j6F4UJwAm72CE4IkC6x0Yz7v_Jr
	0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E
	8cxan2IY04v7MxkF7I0En4kS14v26r1q6r43MxkIecxEwVAFwVW8uwCF04k20xvY0x0EwI
	xGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480
	Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7
	IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k2
	6cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxV
	AFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUkrcfUUUUU=
X-CM-SenderInfo: xqlfxv3q6l2u1dvotugofq/

clk_prepare_enable() and clk_disable_unprepare() already checked
NULL clock parameter.Remove unneeded NULL check for clk here.

Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
---
Changelog:

v1 -> v2:

1. Add clean up for clk_prepare_enable() call.
---
 sound/soc/sunxi/sun8i-codec.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/sound/soc/sunxi/sun8i-codec.c b/sound/soc/sunxi/sun8i-codec.c
index 8b9eb1a202f7..7b3496caa31e 100644
--- a/sound/soc/sunxi/sun8i-codec.c
+++ b/sound/soc/sunxi/sun8i-codec.c
@@ -248,12 +248,10 @@ static int sun8i_codec_runtime_resume(struct device *dev)
 	struct sun8i_codec *scodec = dev_get_drvdata(dev);
 	int ret;
 
-	if (scodec->clk_bus) {
-		ret = clk_prepare_enable(scodec->clk_bus);
-		if (ret) {
-			dev_err(dev, "Failed to enable the bus clock\n");
-			return ret;
-		}
+	ret = clk_prepare_enable(scodec->clk_bus);
+	if (ret) {
+		dev_err(dev, "Failed to enable the bus clock\n");
+		return ret;
 	}
 
 	regcache_cache_only(scodec->regmap, false);
@@ -274,8 +272,7 @@ static int sun8i_codec_runtime_suspend(struct device *dev)
 	regcache_cache_only(scodec->regmap, true);
 	regcache_mark_dirty(scodec->regmap);
 
-	if (scodec->clk_bus)
-		clk_disable_unprepare(scodec->clk_bus);
+	clk_disable_unprepare(scodec->clk_bus);
 
 	return 0;
 }
-- 
2.25.1


