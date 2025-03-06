Return-Path: <linux-kernel+bounces-548782-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28562A5494A
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 12:31:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B22FC3A8929
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 11:30:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B6A120B7F4;
	Thu,  6 Mar 2025 11:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="EEKtrSlr"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 063D720AF9C
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 11:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741260637; cv=none; b=PhknbeC1pTfqIU3vHTAWZ0SN2CqLf8b2TCY5PTc4oamnMft4aTM6j8QUgFLfJNwM/e68rMCwZ/Mcqu370Ec+clG2XpaHFJhJDsnrKJVrx7ghaZAb0BjXJjXNlaPuYLVmhGdtrAd4w70LtQz1jV8pMMei964IF8u5L8PzvmlTxvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741260637; c=relaxed/simple;
	bh=+1wDCnUf6V6waC2u4F0CjceMoJUJQ3m5duPgNX1wMjo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iCCFDRJqDy0cNy6meqvi8poJTmQxHq8x7SI0uN+yvH9HbBJnkREoRTmnFYo8CTVolnBaiAC82R+AUjeyYsR5E5s7KTZzSxLglSq7rI/8X0h2oy3uzV2ttBCVi6Ie8+kjJ0m6uFvOBFUqFb7fHNMXQJw3FRVBjnLt56YlDeiyZyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com; spf=pass smtp.mailfrom=amarulasolutions.com; dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b=EEKtrSlr; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3912e96c8e8so225265f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 06 Mar 2025 03:30:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1741260634; x=1741865434; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0D3K2ln9Lb+MNQxN4twGUjq+Zn0uEKE9IsRwsBI/jVw=;
        b=EEKtrSlrEHkyMoLoObcX3TVfd3kwuOPYXtEHaQWzZtv09l8TgWZK1W8QZjzxyBh+yl
         9ftdbKj4J2Vw8DJzSGQNl5dL8QLnRRZ3wIs3RSW60jUc3d/6+O9VHGSM/B2JPNsxR0ve
         yHT2CBeQlHXNtta0hLHAnowjwt4S5wJAflh04=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741260634; x=1741865434;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0D3K2ln9Lb+MNQxN4twGUjq+Zn0uEKE9IsRwsBI/jVw=;
        b=ktBa+se/JFucHI4Y4lwyXBtPeyo4tf6sHrQ+509VURBYVuub46xqqrupgLsYOQAyiJ
         M+5PUCUKStKtegPZ2HTHIBTsdBtyA6F4SruixUS4tdWylm3MZcJDjY3Hu1JZam9349c3
         NsxZ3VgtVZNkFZD8RRbSqWNWgH3MKWT7k3FubHYzbog8EmLQAPWA3+R7qhRkSpMAMZXo
         UUIN3Qp9tuXAdX1FiQKXmCs7j80j5Vcd2+0dxrmz5jQZEgSWRMlsS6l3PVh3t7yp+xaC
         CEDpcOu2M8B5jf8Iqwo5Ik5eUI6I7lzp8qL6Ya9wF2G4JyfQbkuhgmysmsqmqOJSCi/r
         000A==
X-Gm-Message-State: AOJu0YwcavxftyzoB/Qvl4tQ853I6T68fhe1kEWhvySc/bf3xjh982Uc
	IT65gLeEtDEZxpeizDMGbDLGq2+Pohb3XJJeSORiuqnyUAPiLIaq9eRM5P5A6iGumQWV6x2/qfV
	D
X-Gm-Gg: ASbGncse7fYRo3cXX4vn9tBsOF+/6oIlpzKB3N2D2EBDJoq4bTXlRbizHEg6z2jwE4K
	9VS6hU/YLCPtKBATfXk61Ujt4CPpEPylejqfxw7OEvDkOTz7eZVRZfKpSR/20Tl5LaVz0jr9F1i
	Gi1ztgqZtPToTRH9OcdIUi/EfzZGbrMeewaCz3ST1krAffqIAWOMorr/nmh97IBmXOJK78SXZIa
	XWE/sidDB6Brap2va51+VAvqhhlYaRP6HKT+WS0iZxGZy2enGbx7jwo67tZ0h6lzTA7S3LxlzOc
	tQezzt6LYpnYPhJ2se+B24iyXmAbdATPW5F91P/RWOINLbe5NQgu/HcNVpSNlKWMoXdEZwmpFUs
	oaCtqBw==
X-Google-Smtp-Source: AGHT+IE/gkxbTJgrx5WsPeKouxumhVaFZMtJX0zav5Vxl8++ByMzD32+sUdGSHcbzM+0gAmJx3MEGQ==
X-Received: by 2002:a5d:64cb:0:b0:390:df75:ddc4 with SMTP id ffacd0b85a97d-3911f7cba2amr6815821f8f.44.1741260634196;
        Thu, 06 Mar 2025 03:30:34 -0800 (PST)
Received: from localhost.localdomain ([2001:b07:6474:ebbf:4703:aa8c:6eab:8161])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912bfb79b9sm1749650f8f.3.2025.03.06.03.30.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 03:30:33 -0800 (PST)
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
Subject: [PATCH v10 01/18] dt-bindings: clock: imx8mm: add VIDEO_PLL clocks
Date: Thu,  6 Mar 2025 12:27:50 +0100
Message-ID: <20250306112959.242131-2-dario.binacchi@amarulasolutions.com>
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
name used in the RM is video_pll. So, let's add the IMX8MM_VIDEO_PLL[_*]
definitions to be consistent with the RM and avoid misunderstandings.

The IMX8MM_VIDEO_PLL1* constants have not been removed to ensure
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

 include/dt-bindings/clock/imx8mm-clock.h | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/include/dt-bindings/clock/imx8mm-clock.h b/include/dt-bindings/clock/imx8mm-clock.h
index 1f768b2eeb1a..102d8a6cdb55 100644
--- a/include/dt-bindings/clock/imx8mm-clock.h
+++ b/include/dt-bindings/clock/imx8mm-clock.h
@@ -16,7 +16,8 @@
 #define IMX8MM_CLK_EXT4				7
 #define IMX8MM_AUDIO_PLL1_REF_SEL		8
 #define IMX8MM_AUDIO_PLL2_REF_SEL		9
-#define IMX8MM_VIDEO_PLL1_REF_SEL		10
+#define IMX8MM_VIDEO_PLL_REF_SEL		10
+#define IMX8MM_VIDEO_PLL1_REF_SEL		IMX8MM_VIDEO_PLL_REF_SEL
 #define IMX8MM_DRAM_PLL_REF_SEL			11
 #define IMX8MM_GPU_PLL_REF_SEL			12
 #define IMX8MM_VPU_PLL_REF_SEL			13
@@ -26,7 +27,8 @@
 #define IMX8MM_SYS_PLL3_REF_SEL			17
 #define IMX8MM_AUDIO_PLL1			18
 #define IMX8MM_AUDIO_PLL2			19
-#define IMX8MM_VIDEO_PLL1			20
+#define IMX8MM_VIDEO_PLL			20
+#define IMX8MM_VIDEO_PLL1			IMX8MM_VIDEO_PLL
 #define IMX8MM_DRAM_PLL				21
 #define IMX8MM_GPU_PLL				22
 #define IMX8MM_VPU_PLL				23
@@ -36,7 +38,8 @@
 #define IMX8MM_SYS_PLL3				27
 #define IMX8MM_AUDIO_PLL1_BYPASS		28
 #define IMX8MM_AUDIO_PLL2_BYPASS		29
-#define IMX8MM_VIDEO_PLL1_BYPASS		30
+#define IMX8MM_VIDEO_PLL_BYPASS			30
+#define IMX8MM_VIDEO_PLL1_BYPASS		IMX8MM_VIDEO_PLL_BYPASS
 #define IMX8MM_DRAM_PLL_BYPASS			31
 #define IMX8MM_GPU_PLL_BYPASS			32
 #define IMX8MM_VPU_PLL_BYPASS			33
@@ -46,7 +49,8 @@
 #define IMX8MM_SYS_PLL3_BYPASS			37
 #define IMX8MM_AUDIO_PLL1_OUT			38
 #define IMX8MM_AUDIO_PLL2_OUT			39
-#define IMX8MM_VIDEO_PLL1_OUT			40
+#define IMX8MM_VIDEO_PLL_OUT			40
+#define IMX8MM_VIDEO_PLL1_OUT			IMX8MM_VIDEO_PLL_OUT
 #define IMX8MM_DRAM_PLL_OUT			41
 #define IMX8MM_GPU_PLL_OUT			42
 #define IMX8MM_VPU_PLL_OUT			43
-- 
2.43.0


