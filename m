Return-Path: <linux-kernel+bounces-548785-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 15FF4A54958
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 12:31:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F924189653E
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 11:31:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A641620C49E;
	Thu,  6 Mar 2025 11:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="DCBBFAcb"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A48E20B80F
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 11:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741260640; cv=none; b=HNGz+mQnlTQQ62EQVf8JJpOXAlK5d1DMq3yiaGaMt7W75kUX3A5yXPYgI8/Hnfg+C7YvFvEacFQMz5UF9NhYpqbX94/GVubs13gf9qyQD8CQiZUUEWCK0hCxEUhmRh7KgkCpneh//Vdvpm2vK4MXNoZg8upqfCmMhCC+G2eTUzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741260640; c=relaxed/simple;
	bh=xUBRrkr1aLPPwLeMGNd5Xto6SUkG0PhtvIzCxxAX118=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Rhb9UuHMszYETq5OBuD6630lyPoiVWI7Bld3+dsgh2/araOm+SB6BOH9b+893e4LB2tR++xXbT1Em9tceARZKD3hVXGEUU6yAOuYRsH7JykVboIdFMCOJNoyYfcOC1w7/zwMuJGtmSVSJH97VmM4DVzbaFeAigZm42LLeOPGqfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com; spf=pass smtp.mailfrom=amarulasolutions.com; dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b=DCBBFAcb; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-43948021a45so4708265e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Mar 2025 03:30:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1741260637; x=1741865437; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T8/6J4AE7rdE7DvbcqL7lv8LvF8nVi/MJUfgoa9DfhY=;
        b=DCBBFAcbox3jKss6W/cABwjtS00TIs6MpXGm7Sm51Mic8Er8xxGVORva3/Xk/zVdr6
         1UU+Zw8gnOhvB16nVcue2EwQMD/fimYNJ1Lw6w6x1yvSX9phctkOSM3+oZDH6RJmcFTH
         tVeryW6XKepqyn3ExyiKzCz7I3mmJWOLSOb2s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741260637; x=1741865437;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T8/6J4AE7rdE7DvbcqL7lv8LvF8nVi/MJUfgoa9DfhY=;
        b=iRYKWuM2qYB4cdn/QFT02gmlvweBsg0BsjADQ60Hw2ouR0a5fCOSz3SidM3AStWjBF
         j9Ske4Pxosx3pFz4r9B5W0vhKq0zlVAum2Uc2luI6CQ+9BKj/u8vOkqJ4sd6luMHZ75a
         tawLdTxOg02rB+Q6fpDA2PaMJ5+FLO5s1PnwNG2wuW74NKSuPXqtoDuo8rH5M2j7QFou
         R88iz/WHyvm55kjB0wKn+hhxlUk28Wx59c6rgclrJc8++D+8EE1PoZu6v0Sm6PPZ+QUG
         tYKGRVYmDib/lhuTQWgUvUUx3De/GW8armYJRkhzmA0PY4eY5v5xlh1sIC4Wz1k9TeHs
         xJHw==
X-Gm-Message-State: AOJu0YyCtXlHsrCeuIBVmCY1z0ErZToFcH7tLPp2xOKBezy0Uk60guz0
	+1sGXKF160pVp9rBclNWUbjcQW1d9V2PM9dehmVw7Ec7SdFej85kWh+g6ta67JqiWIPpgnNchJF
	d
X-Gm-Gg: ASbGncs/CVz6KOeBI2xX8+s4PQwA305dxs574PO3r+LRmp8+8so6No66P0syf1+XrBz
	vKRtP60kKG6SG5ZCBIefrPXipEjPquajw8ycuGTEaD+bMZgTDwUyEmu8VQlDCyr2TBOZ1O5Fjla
	3EzOu82k6PJ1B6hLvPJ6/KKttl3VeFQBSKo+a89wZSbPxkkHTNHcJI9lugOTS5GJUKi6+8dd3Ha
	7T0kVJlPdsQhkScJuUiQA5jIZVD/kOoGtql0i9xONeH7Qr5WPv+TobPMyTDudkgDRU1RTeE+71f
	ep+ltSUjaLTFAx91RINs3Ea5b/ObMX2RNr9H+HGFfB2RXV/sTsr+o6UN/suAl3nVuZPuL+aBpVj
	UdMK3dw==
X-Google-Smtp-Source: AGHT+IGnwsNJxAKDrbK2kKQUMvhybDoBV/jgl1/I/PSi+Fn1DxAEWp8gH/c4FLNEhP/j536e3/gNkw==
X-Received: by 2002:a05:6000:2cd:b0:391:13d6:c9f0 with SMTP id ffacd0b85a97d-3911f7bd651mr6196780f8f.47.1741260636943;
        Thu, 06 Mar 2025 03:30:36 -0800 (PST)
Received: from localhost.localdomain ([2001:b07:6474:ebbf:4703:aa8c:6eab:8161])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912bfb79b9sm1749650f8f.3.2025.03.06.03.30.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 03:30:36 -0800 (PST)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: linux-kernel@vger.kernel.org
Cc: Stephen Boyd <sboyd@kernel.org>,
	Peng Fan <peng.fan@nxp.com>,
	Abel Vesa <abelvesa@kernel.org>,
	linux-amarula@amarulasolutions.com,
	Dario Binacchi <dario.binacchi@amarulasolutions.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Fabio Estevam <festevam@gmail.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Rob Herring <robh@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-clk@vger.kernel.org
Subject: [PATCH v10 03/18] dt-bindings: clock: imx8mp: add VIDEO_PLL clocks
Date: Thu,  6 Mar 2025 12:27:52 +0100
Message-ID: <20250306112959.242131-4-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250306112959.242131-1-dario.binacchi@amarulasolutions.com>
References: <20250306112959.242131-1-dario.binacchi@amarulasolutions.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Unlike audio_pll1 and audio_pll2, there is no video_pll2. Further, the
name used in the RM is video_pll. So, let's add the IMX8MP_VIDEO_PLL[_*]
definitions to be consistent with the RM and avoid misunderstandings.

The IMX8MP_VIDEO_PLL1* constants have not been removed to ensure
backward compatibility of the patch.

No functional changes intended.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

(no changes since v6)

Changes in v6:
- Add 'Acked-by' tag of Krzysztof Kozlowski

Changes in v5:
- New

 include/dt-bindings/clock/imx8mp-clock.h | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/include/dt-bindings/clock/imx8mp-clock.h b/include/dt-bindings/clock/imx8mp-clock.h
index 7da4243984b2..3235d7de3b62 100644
--- a/include/dt-bindings/clock/imx8mp-clock.h
+++ b/include/dt-bindings/clock/imx8mp-clock.h
@@ -16,7 +16,8 @@
 #define IMX8MP_CLK_EXT4				7
 #define IMX8MP_AUDIO_PLL1_REF_SEL		8
 #define IMX8MP_AUDIO_PLL2_REF_SEL		9
-#define IMX8MP_VIDEO_PLL1_REF_SEL		10
+#define IMX8MP_VIDEO_PLL_REF_SEL		10
+#define IMX8MP_VIDEO_PLL1_REF_SEL		IMX8MP_VIDEO_PLL_REF_SEL
 #define IMX8MP_DRAM_PLL_REF_SEL			11
 #define IMX8MP_GPU_PLL_REF_SEL			12
 #define IMX8MP_VPU_PLL_REF_SEL			13
@@ -26,7 +27,8 @@
 #define IMX8MP_SYS_PLL3_REF_SEL			17
 #define IMX8MP_AUDIO_PLL1			18
 #define IMX8MP_AUDIO_PLL2			19
-#define IMX8MP_VIDEO_PLL1			20
+#define IMX8MP_VIDEO_PLL			20
+#define IMX8MP_VIDEO_PLL1			IMX8MP_VIDEO_PLL
 #define IMX8MP_DRAM_PLL				21
 #define IMX8MP_GPU_PLL				22
 #define IMX8MP_VPU_PLL				23
@@ -36,7 +38,8 @@
 #define IMX8MP_SYS_PLL3				27
 #define IMX8MP_AUDIO_PLL1_BYPASS		28
 #define IMX8MP_AUDIO_PLL2_BYPASS		29
-#define IMX8MP_VIDEO_PLL1_BYPASS		30
+#define IMX8MP_VIDEO_PLL_BYPASS			30
+#define IMX8MP_VIDEO_PLL1_BYPASS		IMX8MP_VIDEO_PLL_BYPASS
 #define IMX8MP_DRAM_PLL_BYPASS			31
 #define IMX8MP_GPU_PLL_BYPASS			32
 #define IMX8MP_VPU_PLL_BYPASS			33
@@ -46,7 +49,8 @@
 #define IMX8MP_SYS_PLL3_BYPASS			37
 #define IMX8MP_AUDIO_PLL1_OUT			38
 #define IMX8MP_AUDIO_PLL2_OUT			39
-#define IMX8MP_VIDEO_PLL1_OUT			40
+#define IMX8MP_VIDEO_PLL_OUT			40
+#define IMX8MP_VIDEO_PLL1_OUT			IMX8MP_VIDEO_PLL_OUT
 #define IMX8MP_DRAM_PLL_OUT			41
 #define IMX8MP_GPU_PLL_OUT			42
 #define IMX8MP_VPU_PLL_OUT			43
-- 
2.43.0


