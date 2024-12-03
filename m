Return-Path: <linux-kernel+bounces-430046-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED77C9E2CFE
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 21:25:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 264A8B362C3
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 19:21:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43AE01FF7CF;
	Tue,  3 Dec 2024 19:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="T+cfWrQH"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92BEC13B2B8;
	Tue,  3 Dec 2024 19:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733253669; cv=none; b=QcJde5GKQk/6BZaSDt5NOYGoSIOEHOd0LDK9VtaZ4k3ovXcRKWDOHXYtPmUL4/8+I0xaq42w7myDdx0kas31KIwGZf5u6wsHDsCO2exe5F9/vUtDIzZsfKgGfgjiuNznPKDR37rHM+5iQ0uLWylIvzdys9j+K00f/DSKIJ4M7ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733253669; c=relaxed/simple;
	bh=me674ysn4T+xkyXkjVxxdq0efYr8UjvgzBFk7LZAd70=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=QhaHMFksUu8vcmZEGrHH2+s3NncHmny/ob8pL9AzHN99G1aswk+FQTxiltvZj9uX4Uea9A7hTMIE8fBSRJkajWHgFFiblFlUW+3wT6uRF3Q/s6It3lgIclRZzsW6YgmUqHkPWHhRyjpUpqHR4fCj2bc43AiWHaqq9N6Lm/hIyFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=T+cfWrQH; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1733253665;
	bh=me674ysn4T+xkyXkjVxxdq0efYr8UjvgzBFk7LZAd70=;
	h=From:Date:Subject:To:Cc:From;
	b=T+cfWrQHcK7y+GOW+utyX+YR65qTl5gxPICvVGkewfy97+N38ZlGuIA4ujurN7R71
	 vQNewctBhMLcDCSitu9XlfMOWf+qP1lPnWN3N43bBdR9JN9kIRsM6h2sCJWucMstJ3
	 kgg4HNgVn6xVIOGnxsfu1pU8MpIkY6gYEpsgf6wn1SX319Gh5rU3k+0M3ligHz61Z2
	 ikr28pZMIlHc6V5ZmvzrrrkBwXLUmVUcuBfNPRghHORCiH/oZrmyZqNDyyEANJ8+p6
	 fVVAB9jGZlr2ZmdS0dVRp+ecmlUiZ/m6yPpKAw+uvO70ya74rcawN1VzqWRYLRhvc2
	 nO9AwAN/JcSaQ==
Received: from [192.168.0.47] (unknown [IPv6:2804:14c:1a9:53ee::1005])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id A715017E1036;
	Tue,  3 Dec 2024 20:21:02 +0100 (CET)
From: =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
Date: Tue, 03 Dec 2024 16:20:58 -0300
Subject: [PATCH] ASoC: mediatek: mt8188-mt6359: Remove hardcoded dmic codec
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241203-mt8188-6359-unhardcode-dmic-v1-1-346e3e5cbe6d@collabora.com>
X-B4-Tracking: v=1; b=H4sIABlaT2cC/x3MSw5AMBAA0KvIrE2irU+5ilhUO5iFkhaRiLtrL
 N/mPRApMEXosgcCXRx58wkiz8Auxs+E7JJBFrIUslC4HlpojbWqWjz9YoKzmyN0K1scTVOX7aR
 NI0dIwx5o4vvf++F9P0HiRgRtAAAA
X-Change-ID: 20241203-mt8188-6359-unhardcode-dmic-ba7649f8a72b
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Trevor Wu <trevor.wu@mediatek.com>
Cc: kernel@collabora.com, linux-sound@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, 
 =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
X-Mailer: b4 0.14.2

Remove hardcoded dmic codec from the UL_SRC dai link to avoid requiring
a dmic codec to be present for the driver to probe, as not every
MT8188-based platform might need a dmic codec. The codec can be assigned
to the dai link through the dai-link property in Devicetree on the
platforms where it is needed.

No Devicetree currently relies on it so it is safe to remove without
worrying about backward compatibility.

Fixes: 9f08dcbddeb3 ("ASoC: mediatek: mt8188-mt6359: support new board with nau88255")
Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
---
 sound/soc/mediatek/mt8188/mt8188-mt6359.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/sound/soc/mediatek/mt8188/mt8188-mt6359.c b/sound/soc/mediatek/mt8188/mt8188-mt6359.c
index 08ae962afeb92965109b303439419bc6e7c2a896..1550e56ab57d54b179ebe5cbd60db1660bb0bd2c 100644
--- a/sound/soc/mediatek/mt8188/mt8188-mt6359.c
+++ b/sound/soc/mediatek/mt8188/mt8188-mt6359.c
@@ -188,9 +188,7 @@ SND_SOC_DAILINK_DEFS(pcm1,
 SND_SOC_DAILINK_DEFS(ul_src,
 		     DAILINK_COMP_ARRAY(COMP_CPU("UL_SRC")),
 		     DAILINK_COMP_ARRAY(COMP_CODEC("mt6359-sound",
-						   "mt6359-snd-codec-aif1"),
-					COMP_CODEC("dmic-codec",
-						   "dmic-hifi")),
+						   "mt6359-snd-codec-aif1")),
 		     DAILINK_COMP_ARRAY(COMP_EMPTY()));
 
 SND_SOC_DAILINK_DEFS(AFE_SOF_DL2,

---
base-commit: b852e1e7a0389ed6168ef1d38eb0bad71a6b11e8
change-id: 20241203-mt8188-6359-unhardcode-dmic-ba7649f8a72b

Best regards,
-- 
Nícolas F. R. A. Prado <nfraprado@collabora.com>


