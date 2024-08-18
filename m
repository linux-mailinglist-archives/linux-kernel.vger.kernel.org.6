Return-Path: <linux-kernel+bounces-291165-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 29EA3955E39
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Aug 2024 19:33:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5DA2A1C20B59
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Aug 2024 17:33:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5F6C15B0F9;
	Sun, 18 Aug 2024 17:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dq0sMKCF"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3999915A87A
	for <linux-kernel@vger.kernel.org>; Sun, 18 Aug 2024 17:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724002225; cv=none; b=Cx7/0TJyulspgWnqaD/dj5zhqSWGiHC57sIpn9QefVlnfgbmWXD3pcC+bKpb7SH92w2JccPRk20Ci6XRZKyLEhZw96ECp68wVvGpfmSqqvbZRQCrBm9Rxl1mXRCNGz5IcTQzLetV9oag622PLdoUlwsbZRQielCPJWIh4Qvpe4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724002225; c=relaxed/simple;
	bh=+mrMQgdLRKHFnn02riPVi7GgEEOSr/gQ9Z3x/iTOm1U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dFiFJK9IWoxP5+z/1y8bUdKdGpzOEA6wuSkt2iGzs+576OrBkDR7xiaTvC0tRmp+RakTHzH2nvFzOIzp5C/AyW/ZGpCnOUawZmAsggGQw+g/3sNxEbL6ZP5aXoU5pFgWdkWmLw99r12e8p5qXF2IOHI1LxP4WfQa1j7e1y4n2i0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dq0sMKCF; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-428e0d184b4so26253225e9.2
        for <linux-kernel@vger.kernel.org>; Sun, 18 Aug 2024 10:30:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724002222; x=1724607022; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yDxabNXUGD2spiGWzUWebdJZipOuLFpvCr9ct8rDDA8=;
        b=dq0sMKCFRNqGniiP6l2gkRsmPVFWQ4wHwCk9XI/5qGMb/wISBTW9iC0PTciVSLMPOl
         c1DZWzTs1Sk4s5bL4xu1BFHB3G3oAiBi5gfsyhJpxe4r3ZWQNYbYnFc0fm5//1/NRMaY
         3P5xiLD43F6xA1hFdPr7ENtgb8RyAxuKc6V8lhAwVpy10M5w5TPaNe3+/oqFPsM/fvPM
         u/fTMUcBpHTyCf81x9thwLmfxBFDtTBMeYB+g5IxlTXix5Ee+10i5d3qKI3mr+ri6XFb
         sUVq/w8S2LF+Softw/VNLEEJOwsUl/WjnQ/ZT08ecDih72M93a4ezT/JGldG5teMREhh
         rDpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724002222; x=1724607022;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yDxabNXUGD2spiGWzUWebdJZipOuLFpvCr9ct8rDDA8=;
        b=BOuOXYcTWFYtmIx43rau91Xl44OlsT7U2465N3xw1rRN76hpF9/cMwQFRCLqEotHCD
         Ip29P2TUM5+ncUx1uRyRGVDCmTrLo9YBJYzmqdNC3P3I9EXia8bQF9j23uMeeJHQuOpL
         BaBy6GT+m0o3caotYDWMSv/C8UxGaTLZeCEMp1CLRIEWwxAuH2Ap9Ua9ksxnIAUbkbuH
         pKMXh5geP/xIRBgfwb7SreTyginX6pvvZcD7MRmY6tPAvYc2jOazUpOj7xUcUNficZmP
         oAUU8Hh4q6q2K7IN4qVBsXDKM7Vaiu1+aSBucRZc0MVemshx4WV+TuW0S8T0rBdGfi48
         eAqw==
X-Forwarded-Encrypted: i=1; AJvYcCXIi7uSbra2nYGXi2CdcfEWvvjIFCLeYp9qvZvLZPl0zgCpjwWsAM9vb6I4fjkhON6mrFiBZFFEbr/QI6B7np78Dy628bmxY0glpmmP
X-Gm-Message-State: AOJu0YyJd8CqTM3M965/uFDdV/CRLbvJe0TPjbqZST1Hn5RLYJ/Gb8Os
	1BLptGSm4SdyslTy9tK/UXcYWmEaKyV8H+J32f1A/dJItBJV0emhQUElXydEDuk=
X-Google-Smtp-Source: AGHT+IHTe5/9uPQMEtI6+zcncZ4iytZUcY1Qxy0hgPT1aarVYzDAmJ3Q55hH1n/3z5bWggegxUIW8w==
X-Received: by 2002:adf:f2c5:0:b0:371:7cd1:86e5 with SMTP id ffacd0b85a97d-37194314fa2mr4713443f8f.8.1724002222433;
        Sun, 18 Aug 2024 10:30:22 -0700 (PDT)
Received: from krzk-bin.. ([178.197.215.209])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429ded7d5a9sm134999915e9.43.2024.08.18.10.30.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Aug 2024 10:30:21 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Serge Semin <fancer.lancer@gmail.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Charles Keepax <ckeepax@opensource.cirrus.com>,
	Richard Fitzgerald <rf@opensource.cirrus.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Heiko Stuebner <heiko@sntech.de>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Magnus Damm <magnus.damm@gmail.com>,
	patches@opensource.cirrus.com,
	Elaine Zhang <zhangqing@rock-chips.com>,
	Gabriel Fernandez <gabriel.fernandez@foss.st.com>,
	linux-mips@vger.kernel.org,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 3/5] dt-bindings: clock: renesas,cpg-clocks: add top-level constraints
Date: Sun, 18 Aug 2024 19:30:12 +0200
Message-ID: <20240818173014.122073-3-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240818173014.122073-1-krzysztof.kozlowski@linaro.org>
References: <20240818173014.122073-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Properties with variable number of items per each device are expected to
have widest constraints in top-level "properties:" block and further
customized (narrowed) in "if:then:".  Add missing top-level constraints
for clocks and clock-output-names.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../devicetree/bindings/clock/renesas,cpg-clocks.yaml     | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/clock/renesas,cpg-clocks.yaml b/Documentation/devicetree/bindings/clock/renesas,cpg-clocks.yaml
index 9185d101737e..a0e09b7002f0 100644
--- a/Documentation/devicetree/bindings/clock/renesas,cpg-clocks.yaml
+++ b/Documentation/devicetree/bindings/clock/renesas,cpg-clocks.yaml
@@ -32,12 +32,16 @@ properties:
   reg:
     maxItems: 1
 
-  clocks: true
+  clocks:
+    minItems: 1
+    maxItems: 3
 
   '#clock-cells':
     const: 1
 
-  clock-output-names: true
+  clock-output-names:
+    minItems: 3
+    maxItems: 17
 
   renesas,mode:
     description: Board-specific settings of the MD_CK* bits on R-Mobile A1
-- 
2.43.0


