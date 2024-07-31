Return-Path: <linux-kernel+bounces-269732-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5271C94363D
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 21:17:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF8AC1F229E7
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 19:17:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6663C16EBE8;
	Wed, 31 Jul 2024 19:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A3VnWxv2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A22A816EB76;
	Wed, 31 Jul 2024 19:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722453252; cv=none; b=NgdUcf+4EdrGjavuPx5O36FtuGL5D7opuPyUYqNXK7X0JqB2bBjefI6r7bohp9/+S2maABb7UDO5lwDvp49b7ZbOTzhrCEJnrSR9L4A8tMXiNBLuCdlZJ9YycJJpYPQTQ+Vb7eR0MRZqQOfJxhy3ADcJPznuuzAayw3VapPIKYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722453252; c=relaxed/simple;
	bh=Yb9KX4oQgVp1G59d0ACBGnoozofmcvfUYaeuTlPClF0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DHQ4nHj7t9RYSmxq0h6CkSTYTTS4Ivw1V7xEz0WOU5Jbhf7K96b1oEHZd1V1e/Rh6ZLhGbxZXqV2QsV9K954V74Lv6beVeN68hwyztrAtKk3QsBNFKd+7Zx5eEyVtbXOKSZOx3SFZaiPa4VRMQUEEX2x1JryxT6CnEtM2XFQCVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A3VnWxv2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32963C4AF0C;
	Wed, 31 Jul 2024 19:14:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722453252;
	bh=Yb9KX4oQgVp1G59d0ACBGnoozofmcvfUYaeuTlPClF0=;
	h=From:To:Cc:Subject:Date:From;
	b=A3VnWxv2M+qGAlkIi/fuwwiGgsCW3t8USD6Ev6aHbmaKWigYbftc/+R9F8Q0kFITZ
	 wCPcyJwT84m+Sa7OFcTkBKfRN4GmFL+lnNOemJHdmQvjyfOiQrWWGTyJxhTVmvhkM/
	 oGfytNtxNuvmq6+RQSYpj6PWONxqs/qgcTTSV1Oq4prfSRRgK3va2mle3mYBeQFrE3
	 i51pcZ9WrHo+7W5cpXvp9JoQGyzKgk/4LgDVBPjvt9tp/bwSAC21hxAtAZs4ppNbhI
	 NcAdNZtaJ8rFJluR4Z69ffBC1tZvji8cdRsLEr2i7pMCkM5X0lIcvIZOhR4zuZFnG3
	 gn26FwAycMLDA==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>
Cc: linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: Use of_property_read_bool()
Date: Wed, 31 Jul 2024 13:12:58 -0600
Message-ID: <20240731191312.1710417-20-robh@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use of_property_read_bool() to read boolean properties rather than
of_get_property(). This is part of a larger effort to remove callers
of of_get_property() and similar functions. of_get_property() leaks
the DT property data pointer which is a problem for dynamically
allocated nodes which may be freed.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 sound/soc/codecs/ak4613.c | 4 ++--
 sound/soc/soc-core.c      | 8 ++++----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/sound/soc/codecs/ak4613.c b/sound/soc/codecs/ak4613.c
index 551738abd1a5..de9e43185555 100644
--- a/sound/soc/codecs/ak4613.c
+++ b/sound/soc/codecs/ak4613.c
@@ -840,14 +840,14 @@ static void ak4613_parse_of(struct ak4613_priv *priv,
 	/* Input 1 - 2 */
 	for (i = 0; i < 2; i++) {
 		snprintf(prop, sizeof(prop), "asahi-kasei,in%d-single-end", i + 1);
-		if (!of_get_property(np, prop, NULL))
+		if (!of_property_read_bool(np, prop))
 			priv->ic |= 1 << i;
 	}
 
 	/* Output 1 - 6 */
 	for (i = 0; i < 6; i++) {
 		snprintf(prop, sizeof(prop), "asahi-kasei,out%d-single-end", i + 1);
-		if (!of_get_property(np, prop, NULL))
+		if (!of_property_read_bool(np, prop))
 			priv->oc |= 1 << i;
 	}
 
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 724fe1f033b5..4b36afbdd166 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -3372,10 +3372,10 @@ unsigned int snd_soc_daifmt_parse_format(struct device_node *np,
 	 * SND_SOC_DAIFMT_INV_MASK area
 	 */
 	snprintf(prop, sizeof(prop), "%sbitclock-inversion", prefix);
-	bit = !!of_get_property(np, prop, NULL);
+	bit = of_property_read_bool(np, prop);
 
 	snprintf(prop, sizeof(prop), "%sframe-inversion", prefix);
-	frame = !!of_get_property(np, prop, NULL);
+	frame = of_property_read_bool(np, prop);
 
 	switch ((bit << 4) + frame) {
 	case 0x11:
@@ -3412,12 +3412,12 @@ unsigned int snd_soc_daifmt_parse_clock_provider_raw(struct device_node *np,
 	 * check "[prefix]frame-master"
 	 */
 	snprintf(prop, sizeof(prop), "%sbitclock-master", prefix);
-	bit = !!of_get_property(np, prop, NULL);
+	bit = of_property_read_bool(np, prop);
 	if (bit && bitclkmaster)
 		*bitclkmaster = of_parse_phandle(np, prop, 0);
 
 	snprintf(prop, sizeof(prop), "%sframe-master", prefix);
-	frame = !!of_get_property(np, prop, NULL);
+	frame = of_property_read_bool(np, prop);
 	if (frame && framemaster)
 		*framemaster = of_parse_phandle(np, prop, 0);
 
-- 
2.43.0


