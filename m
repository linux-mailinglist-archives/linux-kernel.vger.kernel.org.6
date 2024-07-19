Return-Path: <linux-kernel+bounces-257158-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E08509375FC
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 11:43:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0FBAF1C2341C
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 09:43:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A098413CFB8;
	Fri, 19 Jul 2024 09:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="gnS73A56"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0EF912DD88
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 09:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721381991; cv=none; b=t/WLLt6yRlW8tKFSQ5//BHg/IDz9zdVBPOEgpk7VuqDUochLT8W3oxgPVVBmyWmZ+z7vjKuQ7jRwR0AOOPuESCcCWCLfC9Son9Z5uowW5ZwPlXp5vmYeMiKnI0jjRnE/m2MeFM0DTCJ51iZa9xTkKvqajoEEURdIhup7b2RfoxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721381991; c=relaxed/simple;
	bh=PBjruZtx9EOHUxkdlD0klsOvpdGmBCht+2QX12HHm3E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cqkvTN8JZ1GEPZ2tNc3HQKYVJrx/Vecf4egGt7zfIhlB0R8fql/pCJfD+UqE9eftyOPi+COEw8/jNqIrPqwzTt9qYdjYhgK4+5+bDd2vw3Oqrw0TimN4Q+JYP5aVuk68Eyy0Dn2U3tCQ4MVcgmF9eQu0A2KN4x2yZejrJpuwORw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=gnS73A56; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4267300145eso11579895e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 02:39:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1721381988; x=1721986788; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eMpk3y2xmBZCQPaJCy/EfgttwiP6OCjkgxpc1ntR5zI=;
        b=gnS73A56f0LWkJffdeE8DuTLb4/O6PiFaDGntt3GIkmRZLsUVFGL8Elrgdlm/IAau6
         +B90XzrMIwi+0vK7HHHobxTtpK3lGhESGviDVnwonYUeAS6EYLW2Eur+/rXUk05dYrcS
         0w3es+rpDw34fjKVvv+ic9pzwYtI4bnBftLnGAfmGLuo+IJGRF0RByJ3CA0Q7Ts4DfBS
         3tqfvObVfgBKBhLV3+L1QIKMiq7gvHnh/Dre5lbpcVgus+p7kjZFLmRoxYVEOSYwnjEx
         Ne/ffjTjHlUDiN+Xlg7I4kSfl1VnRNN4lMJwtJj6wNkPsSoztZjMtwd8PiQQeh3+48mE
         DY4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721381988; x=1721986788;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eMpk3y2xmBZCQPaJCy/EfgttwiP6OCjkgxpc1ntR5zI=;
        b=VRstBMAvRVuVOj1COVpJNHkOFC64r4KMR0iR7NW4jAprhBNEGRq+dVGVjxF8tyTJgv
         ANuso9qwabL/b6NJjVwyOjUqEJ4PC/yuN6bPldNUz0QWXCc07XtyzAB+iIqdAqCT9R4L
         4YfRdfg8phfO8s2RDOMHLE2i5ihRwRj0jb4PW5OQrbsz/U1jqyCof63MNyxGnXyYXYe+
         X5xNRauLaXvQHf84Ik0WvM2x+Pjg3taTDCGxLSgwIOy+OkbA6v2ZJX3/FuoCYfYrH9SJ
         oroZ9yZ7v3UaQ6yOwx8ZJxi0D9PyobY5DvLphZOcLTNQHljR8TQ9zglPed0nbKsGtkoc
         uZoQ==
X-Forwarded-Encrypted: i=1; AJvYcCWmecxWXBEFjRK66U/LbT9UvXh1GoPVKn2lST8oVZPVCSk6SR7KbK5VvUQMnO95KOaoKM+NV1EwKyPe1zsaQyzQlFBB7clDhJe8wZ7d
X-Gm-Message-State: AOJu0YwlvOBkspfGneQL+1NAdJSvrQZYAXoXaUagCmGAmmmL6iJP4BTp
	ja/0TL68gv/nlOfU3i0mrBlNSfNi1oiZ3cOX5tJ0dHH8u4NYqDGdDR9EC93Yt9I=
X-Google-Smtp-Source: AGHT+IHkI5bQ3THfbu9n+W7E481AfDPpqx7RjnI9aZPldPP6vcT4yhD2GCn82GpZhRHfUSF7NbJPvA==
X-Received: by 2002:a05:600c:4f96:b0:426:6fd2:e14b with SMTP id 5b1f17b1804b1-427c2cb87a5mr62481585e9.11.1721381988244;
        Fri, 19 Jul 2024 02:39:48 -0700 (PDT)
Received: from toaster.lan ([2a01:e0a:3c5:5fb1:5ac4:5655:4dfe:ce97])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3687868bc91sm1100956f8f.45.2024.07.19.02.39.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jul 2024 02:39:47 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
To: Stephen Boyd <sboyd@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>
Cc: Jerome Brunet <jbrunet@baylibre.com>,
	linux-kernel@vger.kernel.org,
	linux-amlogic@lists.infradead.org,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Subject: [PATCH 3/3] clk: meson: axg-audio: add sm1 earcrx clocks
Date: Fri, 19 Jul 2024 11:39:32 +0200
Message-ID: <20240719093934.3985139-4-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240719093934.3985139-1-jbrunet@baylibre.com>
References: <20240719093934.3985139-1-jbrunet@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit

Add CMDC, DMAC and peripheral clocks for the eARC RX device found on the
sm1 SoC family

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/clk/meson/axg-audio.c | 32 +++++++++++++++++++++++++++++++-
 drivers/clk/meson/axg-audio.h |  2 ++
 2 files changed, 33 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/meson/axg-audio.c b/drivers/clk/meson/axg-audio.c
index 2426f3dbb7a2..06dc1e1f45e5 100644
--- a/drivers/clk/meson/axg-audio.c
+++ b/drivers/clk/meson/axg-audio.c
@@ -753,6 +753,9 @@ static struct clk_regmap toddr_d =
 	AUD_PCLK_GATE(toddr_d, AUDIO_CLK_GATE_EN1, 1);
 static struct clk_regmap loopback_b =
 	AUD_PCLK_GATE(loopback_b, AUDIO_CLK_GATE_EN1, 2);
+static struct clk_regmap earcrx =
+	AUD_PCLK_GATE(earcrx, AUDIO_CLK_GATE_EN1, 6);
+
 
 static struct clk_regmap sm1_mst_a_mclk_sel =
 	AUD_MST_MCLK_MUX(mst_a_mclk, AUDIO_SM1_MCLK_A_CTRL);
@@ -766,6 +769,10 @@ static struct clk_regmap sm1_mst_e_mclk_sel =
 	AUD_MST_MCLK_MUX(mst_e_mclk, AUDIO_SM1_MCLK_E_CTRL);
 static struct clk_regmap sm1_mst_f_mclk_sel =
 	AUD_MST_MCLK_MUX(mst_f_mclk, AUDIO_SM1_MCLK_F_CTRL);
+static struct clk_regmap sm1_earcrx_cmdc_clk_sel =
+	AUD_MST_MCLK_MUX(earcrx_cmdc_clk, AUDIO_EARCRX_CMDC_CLK_CTRL);
+static struct clk_regmap sm1_earcrx_dmac_clk_sel =
+	AUD_MST_MCLK_MUX(earcrx_dmac_clk, AUDIO_EARCRX_DMAC_CLK_CTRL);
 
 static struct clk_regmap sm1_mst_a_mclk_div =
 	AUD_MST_MCLK_DIV(mst_a_mclk, AUDIO_SM1_MCLK_A_CTRL);
@@ -779,6 +786,11 @@ static struct clk_regmap sm1_mst_e_mclk_div =
 	AUD_MST_MCLK_DIV(mst_e_mclk, AUDIO_SM1_MCLK_E_CTRL);
 static struct clk_regmap sm1_mst_f_mclk_div =
 	AUD_MST_MCLK_DIV(mst_f_mclk, AUDIO_SM1_MCLK_F_CTRL);
+static struct clk_regmap sm1_earcrx_cmdc_clk_div =
+	AUD_MST_MCLK_DIV(earcrx_cmdc_clk, AUDIO_EARCRX_CMDC_CLK_CTRL);
+static struct clk_regmap sm1_earcrx_dmac_clk_div =
+	AUD_MST_MCLK_DIV(earcrx_dmac_clk, AUDIO_EARCRX_DMAC_CLK_CTRL);
+
 
 static struct clk_regmap sm1_mst_a_mclk =
 	AUD_MST_MCLK_GATE(mst_a_mclk, AUDIO_SM1_MCLK_A_CTRL);
@@ -792,6 +804,10 @@ static struct clk_regmap sm1_mst_e_mclk =
 	AUD_MST_MCLK_GATE(mst_e_mclk, AUDIO_SM1_MCLK_E_CTRL);
 static struct clk_regmap sm1_mst_f_mclk =
 	AUD_MST_MCLK_GATE(mst_f_mclk, AUDIO_SM1_MCLK_F_CTRL);
+static struct clk_regmap sm1_earcrx_cmdc_clk =
+	AUD_MST_MCLK_GATE(earcrx_cmdc_clk, AUDIO_EARCRX_CMDC_CLK_CTRL);
+static struct clk_regmap sm1_earcrx_dmac_clk =
+	AUD_MST_MCLK_GATE(earcrx_dmac_clk, AUDIO_EARCRX_DMAC_CLK_CTRL);
 
 static struct clk_regmap sm1_tdm_mclk_pad_0 = AUD_TDM_PAD_CTRL(
 	tdm_mclk_pad_0, AUDIO_SM1_MST_PAD_CTRL0, 0, mclk_pad_ctrl_parent_data);
@@ -1232,6 +1248,13 @@ static struct clk_hw *sm1_audio_hw_clks[] = {
 	[AUD_CLKID_SYSCLK_A_EN]		= &sm1_sysclk_a_en.hw,
 	[AUD_CLKID_SYSCLK_B_DIV]	= &sm1_sysclk_b_div.hw,
 	[AUD_CLKID_SYSCLK_B_EN]		= &sm1_sysclk_b_en.hw,
+	[AUD_CLKID_EARCRX]		= &earcrx.hw,
+	[AUD_CLKID_EARCRX_CMDC_SEL]	= &sm1_earcrx_cmdc_clk_sel.hw,
+	[AUD_CLKID_EARCRX_CMDC_DIV]	= &sm1_earcrx_cmdc_clk_div.hw,
+	[AUD_CLKID_EARCRX_CMDC]		= &sm1_earcrx_cmdc_clk.hw,
+	[AUD_CLKID_EARCRX_DMAC_SEL]	= &sm1_earcrx_dmac_clk_sel.hw,
+	[AUD_CLKID_EARCRX_DMAC_DIV]	= &sm1_earcrx_dmac_clk_div.hw,
+	[AUD_CLKID_EARCRX_DMAC]		= &sm1_earcrx_dmac_clk.hw,
 };
 
 
@@ -1646,6 +1669,13 @@ static struct clk_regmap *const sm1_clk_regmaps[] = {
 	&sm1_sysclk_a_en,
 	&sm1_sysclk_b_div,
 	&sm1_sysclk_b_en,
+	&earcrx,
+	&sm1_earcrx_cmdc_clk_sel,
+	&sm1_earcrx_cmdc_clk_div,
+	&sm1_earcrx_cmdc_clk,
+	&sm1_earcrx_dmac_clk_sel,
+	&sm1_earcrx_dmac_clk_div,
+	&sm1_earcrx_dmac_clk,
 };
 
 struct axg_audio_reset_data {
@@ -1853,7 +1883,7 @@ static const struct audioclk_data sm1_audioclk_data = {
 	},
 	.reset_offset = AUDIO_SM1_SW_RESET0,
 	.reset_num = 39,
-	.max_register = AUDIO_CLK_SPDIFOUT_B_CTRL,
+	.max_register = AUDIO_EARCRX_DMAC_CLK_CTRL,
 };
 
 static const struct of_device_id clkc_match_table[] = {
diff --git a/drivers/clk/meson/axg-audio.h b/drivers/clk/meson/axg-audio.h
index 01a3da19933e..9e7765b630c9 100644
--- a/drivers/clk/meson/axg-audio.h
+++ b/drivers/clk/meson/axg-audio.h
@@ -64,5 +64,7 @@
 #define AUDIO_SM1_SW_RESET1	0x02C
 #define AUDIO_CLK81_CTRL	0x030
 #define AUDIO_CLK81_EN		0x034
+#define AUDIO_EARCRX_CMDC_CLK_CTRL	0x0D0
+#define AUDIO_EARCRX_DMAC_CLK_CTRL	0x0D4
 
 #endif /*__AXG_AUDIO_CLKC_H */
-- 
2.43.0


