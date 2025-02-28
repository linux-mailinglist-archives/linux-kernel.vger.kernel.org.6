Return-Path: <linux-kernel+bounces-537958-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 70B28A492E8
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 09:07:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36A871894D4A
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 08:06:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 483BC1DF99D;
	Fri, 28 Feb 2025 08:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BuMvP8Hc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BDB61DEFD4;
	Fri, 28 Feb 2025 08:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740729875; cv=none; b=Dau3wz6PurncCjFC96VeYRqyNZXr8kxD/zCiuOc47ktEei9d40PnOhbwWJXaACxZ8Feq/yfR1EI9Ngqb/wLnET/D7VvjeH1gy0Gn8r99GjjqoODF9YITaT/wzr9hwB9diGA1FtDf1va5mgGoCH8KPeQNqxFtm9OWb1JdZvJ52L4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740729875; c=relaxed/simple;
	bh=ng6uI31FAjjiJ3zN2b6BFVRcHb6da/jG3bCOtov0xR8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nj3LW2ChvCDeHjPYp1dtCuivOd+U870q+bQDTQ8FIPJUkoUxNu0sH0HM3DHUCgV28difcCA+UKMWZ9yPWHaZDYoe6MmoyOCUxJujcUECceRrUzipV4NhkI6pObwXt+SgjMJGoRliA/YpprgUZMCuYRJEbtSSV2jzrPe8vbtdux4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BuMvP8Hc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 16401C4CEEC;
	Fri, 28 Feb 2025 08:04:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740729875;
	bh=ng6uI31FAjjiJ3zN2b6BFVRcHb6da/jG3bCOtov0xR8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=BuMvP8HcQPbFDZblaAHtwyevthCEThdUAmFubB4fZy1kc7ex68paXGglcurxMmynE
	 9TPLPP8TiX28p9Vfw5LCF/fqBSaEKZDz/aklPBDrdxaxeVCNwXlU8Oz0ke8XhI6Hfn
	 MDzh/hIU9kcesbjkUxqNDwqETmpqs1W8mmd2KrX+fAkXW7nsa0vcFXgZJorYVQVVTa
	 VLvXxOxEduRVrhZvxqem1JoLpKaC6oKUKgF3CHAIx5xNTJ/isgmyrEIC0eRXPkm4Fb
	 xSbWO7ycJDVsq8f7sjxEjoABIRoEEpvKgqIB6RDBxjjwHt2rtUIN0sHKtlR0CxUbEF
	 f7NxdmR9EGYxA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBBF3C19776;
	Fri, 28 Feb 2025 08:04:34 +0000 (UTC)
From: jiebing chen via B4 Relay <devnull+jiebing.chen.amlogic.com@kernel.org>
Date: Fri, 28 Feb 2025 16:04:10 +0800
Subject: [PATCH v3 2/6] dt-bindings: clock: axg-audio: Add mclk and sclk
 pad clock ids
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250228-audio_drvier-v3-2-dbfd30507e4c@amlogic.com>
References: <20250228-audio_drvier-v3-0-dbfd30507e4c@amlogic.com>
In-Reply-To: <20250228-audio_drvier-v3-0-dbfd30507e4c@amlogic.com>
To: Jerome Brunet <jbrunet@baylibre.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Kevin Hilman <khilman@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>
Cc: linux-sound@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org, 
 jian.xu@amlogic.com, shuai.li@amlogic.com, zhe.wang@amlogic.com, 
 jiebing chen <jiebing.chen@amlogic.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1740729872; l=1189;
 i=jiebing.chen@amlogic.com; s=20250110; h=from:subject:message-id;
 bh=88wOt7PQOZgMOfEb+IdY8ro91DFKMHUEezQLsKjA1uk=;
 b=NRb7Af0SblT1s22xNxsRpztqbejXeyPzRRg2nWh298Z5IoQTpEqvtOgqR6DJjvmHrLnx8SwyW
 EGfSy9Q/ZiyAGHFbaJF3z/DGlcR+FTMidRL7/jsHGQltd1mRooAru3S
X-Developer-Key: i=jiebing.chen@amlogic.com; a=ed25519;
 pk=6rFvvF45A84pLNRy03hfUHeROxHCnZ+1KAGw/DoqKic=
X-Endpoint-Received: by B4 Relay for jiebing.chen@amlogic.com/20250110 with
 auth_id=316
X-Original-From: jiebing chen <jiebing.chen@amlogic.com>
Reply-To: jiebing.chen@amlogic.com

From: jiebing chen <jiebing.chen@amlogic.com>

Add clock IDs for the mclk pads found on s4 SoCs

Signed-off-by: jiebing chen <jiebing.chen@amlogic.com>
---
 include/dt-bindings/clock/axg-audio-clkc.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/include/dt-bindings/clock/axg-audio-clkc.h b/include/dt-bindings/clock/axg-audio-clkc.h
index 607f23b83fa7287fe0403682ebf827e2df26a1ce..75dde05343d1fa74304ee21c9ec0541a8f51b15e 100644
--- a/include/dt-bindings/clock/axg-audio-clkc.h
+++ b/include/dt-bindings/clock/axg-audio-clkc.h
@@ -162,5 +162,16 @@
 #define AUD_CLKID_EARCRX_DMAC_SEL	182
 #define AUD_CLKID_EARCRX_DMAC_DIV	183
 #define AUD_CLKID_EARCRX_DMAC		184
+#define AUD_CLKID_TDM_MCLK_PAD0_SEL     185
+#define AUD_CLKID_TDM_MCLK_PAD1_SEL     186
+#define AUD_CLKID_TDM_MCLK_PAD0_DIV     187
+#define AUD_CLKID_TDM_MCLK_PAD1_DIV     188
+#define AUD_CLKID_TDM_MCLK_PAD2         189
+#define AUD_CLKID_TDM_MCLK_PAD2_SEL     190
+#define AUD_CLKID_TDM_MCLK_PAD2_DIV     191
+#define AUD_CLKID_TDM_SCLK_PAD3		192
+#define AUD_CLKID_TDM_SCLK_PAD4		193
+#define AUD_CLKID_TDM_LRCLK_PAD3	194
+#define AUD_CLKID_TDM_LRCLK_PAD4	195
 
 #endif /* __AXG_AUDIO_CLKC_BINDINGS_H */

-- 
2.43.0



