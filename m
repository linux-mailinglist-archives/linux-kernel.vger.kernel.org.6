Return-Path: <linux-kernel+bounces-300359-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E90695E2C6
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Aug 2024 10:50:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD0501F21898
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Aug 2024 08:50:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1ABB745F4;
	Sun, 25 Aug 2024 08:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EnJSYzvI"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58BC46F2F8
	for <linux-kernel@vger.kernel.org>; Sun, 25 Aug 2024 08:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724575793; cv=none; b=rGcb8NvGY/cj3nFn3c8wHnfA+T2EYhkCDK1RvDcn0iJjiyzCMbYUwzjAdDIDJxlerboaQDhydIu6NrCud7drtjs2etyzUBRYzXIdeW/bODJxDz2PB9aFrhqA0LTfcg0SJZJWEpD7Uct96gdW4N/knXjXuRy5bamhugbQSZZ/h3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724575793; c=relaxed/simple;
	bh=jFbZBwvOwRIn52AfzwHiXcl99jHNvWYflv+t7ict3Pc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=m9t/uMPNvSoNmAoru6GL4bWvCMOx8P/6F3OJT3Pwgs3gxOBE8Ge64ZHYmtQrt4/v39J40VzuZ9QJWfY07EeUP7YHm6LSIZTSotXqEcx8Npu7r8PbTGXMbKl0FY8Wns8AXPAxYGOUcokdUd3UjXpaVfRLgMZeujzzJPFU7U1VEqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=EnJSYzvI; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4280772333eso5205605e9.0
        for <linux-kernel@vger.kernel.org>; Sun, 25 Aug 2024 01:49:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724575790; x=1725180590; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EFcadNGvy7x7r92tr7jHWl9lbifMfuT6t7Vxj8SP/Jk=;
        b=EnJSYzvIKjog/CFUt+Jf5MAknU5Q0HC43Q2Yuut/VanUDdXHdBrgV1jrnUeV315v6S
         QQ4cg5qrPiDFK30UuQwdJg7vcz+Nglpyil/eNmEwqxbE4cLboVcAV4oyGNd8WB25GSFw
         pbeEbhutgTqHX3OXMs47v3jdaXldI15Avh9wrObjB904OiRBetsdnJWCC4UGL32329G2
         eDDpsUX/+eOozAZAvLlJtDH+6RqyyGgLqxx/5NYGeyXed5Bj6u6Qh/l3/Wtina/u1xIV
         X8qpTP7WKUEQiDbToKHWQ6dToJYfpzX/uUOZpXGWY8LhV/d6XVIXpNTS437riZ4IW1qK
         3EGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724575790; x=1725180590;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EFcadNGvy7x7r92tr7jHWl9lbifMfuT6t7Vxj8SP/Jk=;
        b=PNcJIkq6UCXzc3euGQk6yq0SID2VdyKs49ks0FAKwJb0J1gy0pACJUloSr6k1fQmng
         RV2n2wD1bryg6Al9NWY60dn7nwmKhYmSJsyvB4GyN0Wa+2D2lnKhyed/5rwgdZBE8s1h
         w7Tuyk51oNEKpLh/QlF0hMar7V8oaff8t17KioGd+5uUJJveK2GZUKmWaI9MqPTJ8obk
         B2G3hxyAc4/oCkKSzw7oou9xA05y9Xly9cyMFqmcI3Mfi2YR23qXKqbiFARwv7xEL+BU
         QOpz5+mda/u+Azf6Bak07TfBNJP8IH9bWWOC1/yaQyFBGqfYXg7c4dZtnJofQZef84Gf
         K4Xw==
X-Forwarded-Encrypted: i=1; AJvYcCUPV1CRdG3R0RbVU4sxsdYj/zjusk6JiYWfBeaYh+KyD5x+aWr2ygzW/JSlY+uaEmVQye95h+swPgr2Unk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1nOJCV4g0ZcVs0N0GDEQLRyuYVoLO8aJc9vWaf2jtZdBwgdIW
	wYKYca1cXdhPawSOnXfCvjL0omK4KiWR4bU6MiJGkz9agogL7322spK1bmp5ua8=
X-Google-Smtp-Source: AGHT+IFqH0eWasXxHm3lqwZoRqKEelIfT6oDSORS7GZS6+5bcKfRtIe6ivTGxioz5piGW5U07J9kWg==
X-Received: by 2002:a5d:59a9:0:b0:36b:36aa:a14e with SMTP id ffacd0b85a97d-373118d1d2fmr3033528f8f.8.1724575789527;
        Sun, 25 Aug 2024 01:49:49 -0700 (PDT)
Received: from krzk-bin.. ([178.197.222.82])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3730826b10bsm8108269f8f.114.2024.08.25.01.49.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Aug 2024 01:49:48 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] imx: MAINTAINERS: correct TQ Systems DTS patterns
Date: Sun, 25 Aug 2024 10:49:46 +0200
Message-ID: <20240825084946.20457-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix file patterns for TQ systems DTS after re-organizing the ARM DTS
structure to fix get_maintainers.pl self-tests like:

  ./MAINTAINERS:23329: warning: no file matches	F:	arch/arm/boot/dts/imx*mba*.dts*

Fixes: 724ba6751532 ("ARM: dts: Move .dts files to vendor sub-directories")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Shawn, can you grab it directly?
---
 MAINTAINERS | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index a7cb909ffa1d..6574b4910f8a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -23326,9 +23326,8 @@ TQ SYSTEMS BOARD & DRIVER SUPPORT
 L:	linux@ew.tq-group.com
 S:	Supported
 W:	https://www.tq-group.com/en/products/tq-embedded/
-F:	arch/arm/boot/dts/imx*mba*.dts*
-F:	arch/arm/boot/dts/imx*tqma*.dts*
-F:	arch/arm/boot/dts/mba*.dtsi
+F:	arch/arm/boot/dts/nxp/imx/*mba*.dts*
+F:	arch/arm/boot/dts/nxp/imx/*tqma*.dts*
 F:	arch/arm64/boot/dts/freescale/fsl-*tqml*.dts*
 F:	arch/arm64/boot/dts/freescale/imx*mba*.dts*
 F:	arch/arm64/boot/dts/freescale/imx*tqma*.dts*
-- 
2.43.0


