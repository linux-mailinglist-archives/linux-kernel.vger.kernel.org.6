Return-Path: <linux-kernel+bounces-526491-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47C43A3FF5C
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 20:10:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F6C0425833
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 19:10:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A29925335D;
	Fri, 21 Feb 2025 19:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MCzf+2zv"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EF35253338;
	Fri, 21 Feb 2025 19:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740165016; cv=none; b=n8GuzWcw75BuAeO/FearsZsVTQCDMsJ3biniHu6FplSHTGSJuw8xlqhcKwRqEtewZApArr1yTk8E5Eidmv3FSUHb7rV0FqNCWXfHM0Hkv+NsZgwpHbEUfeqVCSkjm0ps3zpuWt0Ir94e+ZxS6G5k43ma5I3ztwegL9H5lGTwA3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740165016; c=relaxed/simple;
	bh=gFt22yPqdJX9uvjOktQlvN65YTwavsxpkKOsvVw0/qM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Fwi7s5LAm4njItWxsatS/fVIEA5yNxjUTUf0yt3IueVomIPFHRFzK/TY8m0jB3trijJip4SigNfP+qpYnJfSZPDWrrg/duYDXBdXCusSTE6cCIMknpOhLGWecNO1hTOhSPykjEpIvjcEakPZSARRENZpNC0WHRxjd9VUO6H+vKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MCzf+2zv; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-aaf3c3c104fso433287866b.1;
        Fri, 21 Feb 2025 11:10:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740165013; x=1740769813; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tOMBM0/LptOoZWpnGTFXn3VuyeurWEITTiZxZ/wflWQ=;
        b=MCzf+2zvtbjt5B3pswq/olA9kZMGAcBUizw6S7C2hP3vgIxHz5dj+wfXS51bLkvRuW
         YhT7Fvjh/oH9iwu/fJYEMQ698xB8Lxesv0ammVNJvk8xzc+EzNTitW7lYea/Z2hxjn6a
         Ze510mp2b+DU29ZPwdUbjfecJ39sxWOC88VO1/fYODXSNcNcCstr2OxFcclNJITwlBXi
         Z8OQ1KK/Pl1hHfV8LGrxBEHBG8iBNazUJpsjr3AT3PaUIxPxd2PisbtdJttsNCvyrIjS
         FhRv2W3OIDx4ojlQWEiQ1y6SgCJpz1+82fIrv0ps9MP6Z8WlPrfeX057AFCnUVOLxqOH
         eSvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740165013; x=1740769813;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tOMBM0/LptOoZWpnGTFXn3VuyeurWEITTiZxZ/wflWQ=;
        b=WPg6xIiYc6vQmwotpgohRVIx5Grhcq2vBVnyYWk926jekAwrreFzY+yEjtsevaWrps
         wAF699Jk1WKtR09UHy+t8fHgbHW9STRskY/obk0B8ebWYnbWLhqtJopv6yvLeLuwwVU5
         n4fYy8DF+ENbcXYQFovNsxJ/tV6uc6K0XoNYTYQnMpZOGieiDTPtrDDNi6R09Ec6of3z
         SQqqJRol14BFKulr2cRukwyvAdTGbBnf1vccOJzwmGS+tljiosC1+cIL39JL6gUtq819
         A0lqQbVSPHsF2IheslkMlWRVXoKlXwg3dUKPHXP8LH5bFH8viNi/jKyAMnrfKqrUVdnh
         3aAg==
X-Forwarded-Encrypted: i=1; AJvYcCU0aH0YB7arf2H4tNaG9A72EzE0irO9NlFPyspLXJ/Abyodveeq0gf36EFwljyKfFE7yQ3DOjWSkmQZnEqr@vger.kernel.org, AJvYcCV/Y+Ww/0iMKwOn0nEy8BBSMT1vWNaGsXSIVoGfD7SGg+e61BItWu5jMKBQHdaeCD3Gwl8+gKzqHcdh@vger.kernel.org, AJvYcCWsME7v43ynamHF4P29CY81B4HMK/ojmgr7a1EPSPhZRtPNULpgxyitAHmJ0+S5cFAg5YQmJav3wCIC@vger.kernel.org
X-Gm-Message-State: AOJu0YzS96iJdenLXirrSAe7PJRUaZIUxs5Ic0uVQn/jKU+94u9eu6nX
	A/SnoPu10hQr3kFSUWZgcQejtENrOHtYtQfcqYs00VuRrO1S24W8
X-Gm-Gg: ASbGncveUnV9Q7Q7S++ZI7r5zAL+H5ZOzXsmOpY3HLx5vHIaPbFAmdZouceDYT+1g3Y
	Aw3fDsrV1c3IGnbTJUvWKAWKn4Z7r+TTOzF0cNI27+sdEMwcCO6FgAS/PltEUD2JGckeVxpamyw
	Hj6H55eehulhOPzIzXKg+/6ZztPzinUqsTqwQ+EqJpHaSIIGIWM7vlPFhOIT3tjzc6bf2X3zSBh
	8govXJfmjwtIKshNlAkMKfM0eEYmkQjlixBYxHurojmwkxpcYJTjnOH06ZWcWNIsU41o52526zL
	eaJk0eOC6SBo6neEtPa4b9YBuVUCetu/x4zS8jPLrmY3Mhj/V5QXinFo65A=
X-Google-Smtp-Source: AGHT+IH9dIYGKpfakCpm7QX9v0EfX1043+vTXy8S2cvINmOR+ptJQsFSlwJ4jw24HVfPeVBX1a9vlA==
X-Received: by 2002:a17:907:7285:b0:ab6:ef94:6054 with SMTP id a640c23a62f3a-abc0db35708mr483073766b.33.1740165013278;
        Fri, 21 Feb 2025 11:10:13 -0800 (PST)
Received: from playground.nxp.com ([82.79.237.175])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abb9b187203sm1027261566b.61.2025.02.21.11.10.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2025 11:10:12 -0800 (PST)
From: Laurentiu Mihalcea <laurentiumihalcea111@gmail.com>
To: Abel Vesa <abelvesa@kernel.org>,
	Peng Fan <peng.fan@nxp.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Marek Vasut <marex@denx.de>,
	Stephen Boyd <sboyd@kernel.org>,
	Shengjiu Wang <shengjiu.wang@nxp.com>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>,
	linux-clk@vger.kernel.org,
	imx@lists.linux.dev,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/4] clk: clk-imx8mp-audiomix: fix dsp/ocram_a clock parents
Date: Fri, 21 Feb 2025 14:09:27 -0500
Message-Id: <20250221190929.31469-3-laurentiumihalcea111@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250221190929.31469-1-laurentiumihalcea111@gmail.com>
References: <20250221190929.31469-1-laurentiumihalcea111@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>

The DSP and OCRAM_A modules from AUDIOMIX are clocked by
AUDIO_AXI_CLK_ROOT, not AUDIO_AHB_CLK_ROOT. Update the clock data
accordingly.

Fixes: 6cd95f7b151c ("clk: imx: imx8mp: Add audiomix block control")
Signed-off-by: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
Reviewed-by: Iuliana Prodan <iuliana.prodan@nxp.com>
---
 drivers/clk/imx/clk-imx8mp-audiomix.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/imx/clk-imx8mp-audiomix.c b/drivers/clk/imx/clk-imx8mp-audiomix.c
index b2cb157703c5..62a180d6f8cb 100644
--- a/drivers/clk/imx/clk-imx8mp-audiomix.c
+++ b/drivers/clk/imx/clk-imx8mp-audiomix.c
@@ -180,14 +180,14 @@ static struct clk_imx8mp_audiomix_sel sels[] = {
 	CLK_GATE("asrc", ASRC_IPG),
 	CLK_GATE("pdm", PDM_IPG),
 	CLK_GATE("earc", EARC_IPG),
-	CLK_GATE("ocrama", OCRAMA_IPG),
+	CLK_GATE_PARENT("ocrama", OCRAMA_IPG, "axi"),
 	CLK_GATE("aud2htx", AUD2HTX_IPG),
 	CLK_GATE_PARENT("earc_phy", EARC_PHY, "sai_pll_out_div2"),
 	CLK_GATE("sdma2", SDMA2_ROOT),
 	CLK_GATE("sdma3", SDMA3_ROOT),
 	CLK_GATE("spba2", SPBA2_ROOT),
-	CLK_GATE("dsp", DSP_ROOT),
-	CLK_GATE("dspdbg", DSPDBG_ROOT),
+	CLK_GATE_PARENT("dsp", DSP_ROOT, "axi"),
+	CLK_GATE_PARENT("dspdbg", DSPDBG_ROOT, "axi"),
 	CLK_GATE("edma", EDMA_ROOT),
 	CLK_GATE_PARENT("audpll", AUDPLL_ROOT, "osc_24m"),
 	CLK_GATE("mu2", MU2_ROOT),
-- 
2.34.1


