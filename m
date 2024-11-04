Return-Path: <linux-kernel+bounces-395423-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF9CC9BBDB6
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 20:07:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0BA281C21CAE
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 19:07:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F6171CCB46;
	Mon,  4 Nov 2024 19:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UGOiEUyh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF1501CC899
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 19:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730747224; cv=none; b=uKYkk/UV8GuWyU7YTGZixhqU3W19KImTkiuChcZU5LRmzrpb0ovh05bet/f3FGgMLSiVH2XZjPFVLrk4VAd4q8LD6P3aUFvdM04vfHEIQmAgasumyHXJzVxLu/UWGBXPH4+Oy6P9vgGM653dZuIFU4dqEC+rOyf4cXLsEqPd0sU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730747224; c=relaxed/simple;
	bh=Dl0TMpSb2eAzhg61AwTW0r0i9OW2iff6l56nxYhwNq0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Vc4VtC1tFcyKjRncXlIvf8fAxxqILq8M5qkOwVtnwLXFcajxpctP7t04mI06aYYhEWchNJm+ctNwZXAuKp5yZ3wa6bbGagSaWwkYPlOLDO2gO/FrgiSsO6LwIF7kVzvcvChfdPBOYMc1c3sr6R2vQjwF8yjT42pTN7BRrIwu0ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UGOiEUyh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28193C4CED0;
	Mon,  4 Nov 2024 19:07:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730747224;
	bh=Dl0TMpSb2eAzhg61AwTW0r0i9OW2iff6l56nxYhwNq0=;
	h=From:To:Cc:Subject:Date:From;
	b=UGOiEUyhyhHRCJ+RkTlev41cqWdhI+paCp1rekR5Lz075hpnzNynja9Vj1qOBXafp
	 fSTuXdIxDf8XcLcddBl2KCcf6YfU+SxFzp67Z0Kbw/6MbQi9HdNDkOCLKivIPAcTQq
	 LUYD7BMeEt6cCZz07lVm3noE29xw/2JnYZVz3laryy34jukjejO1x+n40HuKMsJXGj
	 IUzzwlcIRHTzbcu27xa7TnxPrlb4+zGkn+6fVGdtbQeXs0lTti9QN11Je2gHWuNWTD
	 iiaKD0UWAUjudL1VgbQsa+jg2eLqZvCQbivXQ0aZghGIdN/Tl4iyiZSLMmLITqiLle
	 a03WV8bpJoUbQ==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] misc: atmel-ssc: Use of_property_present() for non-boolean properties
Date: Mon,  4 Nov 2024 13:06:59 -0600
Message-ID: <20241104190700.275573-1-robh@kernel.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The use of of_property_read_bool() for non-boolean properties is
deprecated in favor of of_property_present() when testing for property
presence.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 drivers/misc/atmel-ssc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/atmel-ssc.c b/drivers/misc/atmel-ssc.c
index 6eac0f335915..1d0322dfaf79 100644
--- a/drivers/misc/atmel-ssc.c
+++ b/drivers/misc/atmel-ssc.c
@@ -153,7 +153,7 @@ static int ssc_sound_dai_probe(struct ssc_device *ssc)
 
 	ssc->sound_dai = false;
 
-	if (!of_property_read_bool(np, "#sound-dai-cells"))
+	if (!of_property_present(np, "#sound-dai-cells"))
 		return 0;
 
 	id = of_alias_get_id(np, "ssc");
@@ -176,7 +176,7 @@ static void ssc_sound_dai_remove(struct ssc_device *ssc)
 #else
 static inline int ssc_sound_dai_probe(struct ssc_device *ssc)
 {
-	if (of_property_read_bool(ssc->pdev->dev.of_node, "#sound-dai-cells"))
+	if (of_property_present(ssc->pdev->dev.of_node, "#sound-dai-cells"))
 		return -ENOTSUPP;
 
 	return 0;
-- 
2.45.2


