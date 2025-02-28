Return-Path: <linux-kernel+bounces-538349-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 98FE7A4976A
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 11:33:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8EE361884B97
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 10:33:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5066B25EF9A;
	Fri, 28 Feb 2025 10:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="BoGWHZwQ"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADD0E258CC2;
	Fri, 28 Feb 2025 10:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740738801; cv=none; b=igj0zyXQPge9l18BFrWHGPkFep3fAuPargcPdIJBml/CRqYOwpsz6OBQsNz1gTUkdb+DjBaWEMC/bsi//lY86hzrIOtlOMalbSYNz45+0aSQeO9aA6HmOc8OppZF62g1ry8+CI7fg2cpzB0E0DdwAroJxnvzQXFFzw3GDooFXlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740738801; c=relaxed/simple;
	bh=kDGY2YRO4TVDC32xVznZInM/iWmYlqIPkiZVzBj3Lrc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=DYJrmSY0qdYanGhAWScqCd5U0vJYelvCmeEFAv5r8Va5pz7GZa5W1z/F8BmuFI+IGeXaOsB4yag/kJuuQTKfZbV53rEO0JCnpwLxsR85PJ7ajzJ5RQAh+21pfnLwsPnv+DEziOWxcO9N7rKZV/frQRLIsNnquNxfQRYS3Xo8jOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=BoGWHZwQ; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1740738795;
	bh=kDGY2YRO4TVDC32xVznZInM/iWmYlqIPkiZVzBj3Lrc=;
	h=From:Date:Subject:To:Cc:From;
	b=BoGWHZwQRWEr8/81RONBuVIcCgxDCt/VZyc2pihZIE17gXKI/ysf6hhnQPHjgDL/2
	 +Sx9il5pLxOdbHVfiWAJ6hRcI6bBmnpkITo7GNZwjMTQcAysLPjnbyOajzIKlMlLKU
	 2SlXp2oaIC5gWyLIt370cOv/3UCoWL5I3n/2fEox2F3RjNjuMDwBYWpUc9HzSIl/Ym
	 tOyPOZA0CPJLseCfK0jYsZ20OGCLTjJjulda0Js70f9fzlqNs5ZK3Lw3IQsNYMOcbZ
	 qQo4U1+X+Ghoa6cv8SQpst/S/YGlxRys9rb5FSwU8WEeSsDdzT9bjJC6/VERP5kMJi
	 jzRKvJe4k8P4g==
Received: from yukiji.home (lfbn-tou-1-1147-231.w90-76.abo.wanadoo.fr [90.76.208.231])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: laeyraud)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id EDDD217E0199;
	Fri, 28 Feb 2025 11:33:14 +0100 (CET)
From: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
Date: Fri, 28 Feb 2025 11:32:19 +0100
Subject: [PATCH] ASoC: mediatek: mt6359: Fix DT parse error due to wrong
 child node name
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250228-mt6359-fix-probe-failed-v1-1-64941d387b2c@collabora.com>
X-B4-Tracking: v=1; b=H4sIALKQwWcC/y2NQQ6CMBREr9L8tT+pJShwFcOilKn+RCi21ZAQ7
 m4jLt9kZt5GCVGQqFMbRXwkSZgLnE+K3MPOd7CMhcloU2tjrjzlS1W37GXlJYYB7K08MbJtKmg
 PtNo4KuslonR+z7f+4IjXuwjyEdJgE9iFaZLcqRlr5r+koX7fv8WwDZeaAAAA
X-Change-ID: 20250227-mt6359-fix-probe-failed-a83e0fee902c
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>
Cc: kernel@collabora.com, linux-sound@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, 
 Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1740738794; l=1893;
 i=louisalexis.eyraud@collabora.com; s=20250113; h=from:subject:message-id;
 bh=kDGY2YRO4TVDC32xVznZInM/iWmYlqIPkiZVzBj3Lrc=;
 b=PS2OyWfK67cny/X2RYnJVeS4ofLhP5AJvnFhlJTPG/rHIOY9UdU9PVW8/XDv0sX1aV2owfifH
 ItBqfYymvVkBbQSTaz2C+C/lXRs5I8cGhYiH4VOiTREO/H0IR14pkr9
X-Developer-Key: i=louisalexis.eyraud@collabora.com; a=ed25519;
 pk=CHFBDB2Kqh4EHc6JIqFn69GhxJJAzc0Zr4e8QxtumuM=

A recent dtbs_check error fix in mt6359.dtsi file changed a node name
(from "mt6359codec" to "audio-codec") without modifying the mt6539
codec code that uses it.
It leads to a probe failure after devicetree parsing returns in error:
```
[    1.354025] mt6359-sound mt6359-sound: mt6359_platform_driver_probe() failed to parse dts
[    1.355066] mt6359-sound mt6359-sound: probe with driver mt6359-sound failed with error -22
```

So, add the child node retrieval with the new name and if not found,
try with the older one for backward compatibility.

Fixes: 76b35f59bbe6 ("arm64: dts: mediatek: mt6359: fix dtbs_check error for audio-codec")
Signed-off-by: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
---
I've tested this patch on a Mediatek Genio 510 EVK board with a kernel
based on linux-next (tag: 20250228)
---
 sound/soc/codecs/mt6359.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/mt6359.c b/sound/soc/codecs/mt6359.c
index 0b76a55664b0352f6ee2d0f3c96466ffe1df2d6d..f73120c6a6ce680797a1f61841815ca01a24adf4 100644
--- a/sound/soc/codecs/mt6359.c
+++ b/sound/soc/codecs/mt6359.c
@@ -2867,9 +2867,12 @@ static int mt6359_parse_dt(struct mt6359_priv *priv)
 	struct device *dev = priv->dev;
 	struct device_node *np;
 
-	np = of_get_child_by_name(dev->parent->of_node, "mt6359codec");
-	if (!np)
-		return -EINVAL;
+	np = of_get_child_by_name(dev->parent->of_node, "audio-codec");
+	if (!np) {
+		np = of_get_child_by_name(dev->parent->of_node, "mt6359codec");
+		if (!np)
+			return -EINVAL;
+	}
 
 	ret = of_property_read_u32(np, "mediatek,dmic-mode",
 				   &priv->dmic_one_wire_mode);

---
base-commit: 15c3f6fa407bf6913c282b22ef2bcfa40cb53927
change-id: 20250227-mt6359-fix-probe-failed-a83e0fee902c

Best regards,
-- 
Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>


