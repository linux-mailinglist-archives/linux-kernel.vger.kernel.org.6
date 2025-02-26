Return-Path: <linux-kernel+bounces-534450-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C6EC3A466F3
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 17:47:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F24F3A6DAA
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 16:47:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A25E2248B9;
	Wed, 26 Feb 2025 16:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kUpCpQPm"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 349992222DA;
	Wed, 26 Feb 2025 16:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740588405; cv=none; b=flAlWZmaR1hATlp8gXuSCcY5itA67i3U8LeepQBGkNXgrjafKv/K12TGRNr+j194MoH5BTk0IQ5vqyzTH4WHlqMXyvNv7NFlEoZW0EFHddyiMuDj/4ltfO84egGwn9cGORRHi8md4m9OFGTI6JR1vjsy18+QmTYe6lhGXCsbAbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740588405; c=relaxed/simple;
	bh=3HhpQLzDJ5PhgxGSSZYJ2mur7iygkWAwE5N74zfdasM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GQ41cqoKEmqPPjk+vRIS4BUqh3uAzhXCQyGY39LdQPto/aCHOArjaVxaWZAJhOu2uXz8KI2pCFh1n0DWjq4EcG0c1QMAELGS7bX7RJVdij+6uS8KLfrNuGRlLCggEiqhVFKMehy8bAyTx33tWF3lgXrIPxPYNjEmOv98V7ltM5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kUpCpQPm; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4399ca9d338so172615e9.3;
        Wed, 26 Feb 2025 08:46:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740588401; x=1741193201; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6pnuI6sBYlkwLaLjuQ7fgcpXHpa/8YRA5z4IIzVEteY=;
        b=kUpCpQPmCr8yuPeTTpoi8pOVN4RdBJn0nYGqNkoo/0386onBe4Yr5TnAB3tQXTnc3h
         h/Zp79LNwuGc0fJd35x87C7I5zYuCrIuOAZQ+IsLpcsvQ7PfeldqCeBrvxHr3XNyszjC
         k/PGqQ+IB9OXkN6ys4SGSfGHYH3oqaBJispIh+W+Fk74ePcFIRMTAjazWCEK4UR4byfK
         mPb0gHMI38UvIdKQ+6ukx43BfnrJXsi1zzBjv/ZTDoC0bfoxvbs6q0RapjT2ryC6S4Yj
         ucxRtaZo9k31geoGeSvAC5PP9/Y6hHa60k2473EejIsJcrqvDwRQQuY4ssmqm2lvy1TK
         IK9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740588401; x=1741193201;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6pnuI6sBYlkwLaLjuQ7fgcpXHpa/8YRA5z4IIzVEteY=;
        b=m2lCiv4KGwCRliPYEB9ox7nbfBPPScjLe1XZZPfXuBw9O/CzGMwu6cpGAhB1IO/Y3W
         N2vYb1ugYqcXhDgbm/Bk5l3ReR64X1gLZ9WsfcUGdE0MrODxDJiCSSjGl3i8NTjW/+qe
         5h0cJAT90cK9rSLTpFAxijeLOmBHEXk9ltEFcaZLAtVwQ266kjJG+hwZbbcUmFRaxHjC
         1UNXMB04tIJktItrJv55eFPZ6Qg7dwJdpZ+HhQ0foziOJ1xvAj/2rNlyE3pn5+f8eTYA
         +ENnAJZEkto9nA1oKFqROUpdDDJp+UQrzCbguR+3+ocWV81alo9DRWhyC1lrYgdIpq5y
         IUoA==
X-Forwarded-Encrypted: i=1; AJvYcCUtOEQjOJ05ZDnkcDwLqBbEWqEVbOBIWw7Xq4Qj8oqo3i8FnOaIl5qtJ+kCr9fThg7HrytnctoetVWQ@vger.kernel.org, AJvYcCWLuaEW82kGXDOZhTWOEnFDTGI8H5GcdAf3qkMVZx+HKlSyRnTu2VOl5RxeAbQPCqq/wIaKlkrCNDRGKHIn@vger.kernel.org, AJvYcCXsLKaQTSc1oXu0XmTRWbCGiM/W9VVkLWEF84cGD5JzuV8Tfng+UYCzRwxSLtqQMl1+cftHqa/fyaek@vger.kernel.org
X-Gm-Message-State: AOJu0YzfMJdXb6chCSAwZLLBMNb1NYc8wDuzgXYqrwOezJ4RGBxrr5Cx
	Ri805E/KeVGGf+QJL8CXuk+HXyOKzD4eBx0BGXwNEKZr4sqIB93X
X-Gm-Gg: ASbGnctPBQxDr5Fyrt2YJouaK/tEwSWr8sPi4+FIpapjey95OkcorJlrcQKLjlHpoip
	dBeZuu6/BK1EZf8CM9+YANpk2y20KMYeTt7KpdrRxRYDWgBh9LO5OcnCABZdEGxIf3QK/EN7Fzq
	r/Ov3SsdBZOj1A8bulDaj7pCDIBi6SgkdXyEpbZBJ3M4hoUGg4YLlrh9UKuoOFLvsNhUOS2jaaS
	byliR5LKN4EUXzluhJJOyzd9qNkZQoYI1lkestub8xEwG/IQjMV0hrZN8TfAa0HOugCccMeGylr
	OhUGh0ElxxHEZy7b2EyPCh+pNeX5OD3pgZapB+eVp5WWVC0aL2ZZsk515YZ9lRRj
X-Google-Smtp-Source: AGHT+IExPqM/gnSNIKRczXrwwSNY2JYUNb14I/Jluil+QDW7N2/0KA9eUaCIBmPYlFa5rXUAj1siew==
X-Received: by 2002:a05:600c:a01:b0:439:a88f:852a with SMTP id 5b1f17b1804b1-43ab0f6deb8mr72370865e9.23.1740588401209;
        Wed, 26 Feb 2025 08:46:41 -0800 (PST)
Received: from playground.localdomain ([188.25.208.27])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390cd8e7165sm6200215f8f.73.2025.02.26.08.46.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 08:46:40 -0800 (PST)
From: Laurentiu Mihalcea <laurentiumihalcea111@gmail.com>
To: Abel Vesa <abelvesa@kernel.org>,
	Peng Fan <peng.fan@nxp.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Marek Vasut <marex@denx.de>,
	Stephen Boyd <sboyd@kernel.org>,
	Shengjiu Wang <shengjiu.wang@nxp.com>,
	Adam Ford <aford173@gmail.com>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>,
	linux-clk@vger.kernel.org,
	imx@lists.linux.dev,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/4] clk: clk-imx8mp-audiomix: fix dsp/ocram_a clock parents
Date: Wed, 26 Feb 2025 11:45:11 -0500
Message-Id: <20250226164513.33822-3-laurentiumihalcea111@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250226164513.33822-1-laurentiumihalcea111@gmail.com>
References: <20250226164513.33822-1-laurentiumihalcea111@gmail.com>
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
index c409fc7e0618..775f62dddb11 100644
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


