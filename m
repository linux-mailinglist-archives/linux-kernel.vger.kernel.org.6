Return-Path: <linux-kernel+bounces-174424-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C25C8C0E80
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 12:50:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E6F8BB246AB
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 10:50:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40A7C14C59C;
	Thu,  9 May 2024 10:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xip6jgRd"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03C7714B977
	for <linux-kernel@vger.kernel.org>; Thu,  9 May 2024 10:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715251729; cv=none; b=KoBYiFQUvl+hJW2UlMdJRni1S96LF+H8wRqoU5SrPalYYNQXCKdt40XaaGRpSU+krB3TCdR2vQhls8lmOzac1HWZ0uCQ6k2RYhnxrXSvR+0HbNgcJKiFJCGAszI+Sgxf9FPbWF6qDLmx5BDNoODUZh/9GK2sdPrVohdwlQ65iFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715251729; c=relaxed/simple;
	bh=vr0JkEDr29fBsYwVrEj21BsVRokcN68DvXqh0duEgEk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PQWiEGJRai/gBJrWLZGY0/T9f7lalY4fQ40Y6uJuD3cdmuKpVMlbPF28O/gCdh+Zg19+7INFVPMrTpHZt4b97Ah5sm5RhdtTjAKwPaGszAGFNigG3P3r0xcpjnPE0UttK26O0AWr8ffqmQgdksDtCjWyxBCoI8hpBLUFYqHrUiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xip6jgRd; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a599a298990so168658966b.2
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2024 03:48:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715251726; x=1715856526; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NAnteY4Ku2+wEU6Dmp4nyfLK0/g/WbuTESaTngARvs4=;
        b=xip6jgRdHdqsodVLL4ptrQsc9jfnz5yoKwn1RgC34OopUeqqOq6hBGT7sF0H2lELLT
         6vb2gUqvhlfj9LMAGp/+5b2JkEIoCWeVMb23pvRc1cvxpuDByfG7PWWGzCbpBvOijhG2
         YBWc8zQ0lQcIbxLTv9n5VaC2T4bkGmkBN/4sEC15nvVpmYosdfdaVyQGjbs3vcPpyrQR
         WTuH1jFpdxPdk6OPnT0T0KIypba6TY1QkQUA8w1PsNsJSmVvnVnxJgw1pFTNpGdetDWR
         tuuCXLYd5AoKbvCI81An64DQub+K8HOFGi/oI6E7QKjP6dojSZDAiniD6G0y8fqYgaJl
         ZnJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715251726; x=1715856526;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NAnteY4Ku2+wEU6Dmp4nyfLK0/g/WbuTESaTngARvs4=;
        b=tNi6VlXQEddIeUZDu4bCrtfhNlw2aKe6TZpa/azZ6yj2eXTtDyWCZlRzKeagKE1I6a
         COXFbYihLMx4qJFQkz4p6dO//93ChHA9Vasys18w2cbAl1eOsRWMXNTZjPx4Qpv/VucP
         0WlLgDQq2LR1ZcvpHSIfObReh+BXBgzgMLAeo7a8MmQ81IxdQVSGfYHw+X0i1F7pWmkO
         xv7elfzw7Orn4KgIIwP6sN7s5zbWVBw29juD7rKeMgxMb1fKjKRCW7CC//Ha88czNQa1
         LrqZhz0Ttf48VY7iSWV95H0iR9SIQsQQ6hx/dHLOIozzc/6oKVjCFrm1JZpiJ5hRpTX6
         zlDQ==
X-Forwarded-Encrypted: i=1; AJvYcCWhpRFMvRaw2HhEKyq7ULs2SKlzNI6d9ZEpaLGEri9nDQ8PG3MEmw/+Pppk7c8hUvtVpbeRh3cJAjcxX2la7u2e2V50hrPNsqZyjjIM
X-Gm-Message-State: AOJu0Yw2WvLPXIaWe1hhHCsXYTcKD+9Tox5ayjA8dz+H59HH3Ze6BXPp
	mLH/QHBbfCA1ChF1qnc6wS6xRpoKzy9wG9Caz+RLJpl3hzWmjElwQjarfS4Lrik=
X-Google-Smtp-Source: AGHT+IFOTVe25O3pIsAX/rCgSborCXKvhCmHmsBLt39hPOEhp1TeTMpFQcZ8/4M/6lj5v0rs2vv/ug==
X-Received: by 2002:a17:907:2685:b0:a59:a3ef:21eb with SMTP id a640c23a62f3a-a59fb9dce5fmr414990366b.73.1715251726392;
        Thu, 09 May 2024 03:48:46 -0700 (PDT)
Received: from krzk-bin.. ([178.197.206.169])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a17894d85sm60195966b.72.2024.05.09.03.48.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 May 2024 03:48:45 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 3/5] ARM: dts: imx6dl-aristainetos2_4: drop redundant 'power-on-delay' property
Date: Thu,  9 May 2024 12:48:36 +0200
Message-ID: <20240509104838.216773-3-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240509104838.216773-1-krzysztof.kozlowski@linaro.org>
References: <20240509104838.216773-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

LG4573 panel bindings do not allow 'power-on-delay' property.  Linux
driver does not use it, either.  Reported by dtbs_check:

  imx6dl-aristainetos2_4.dtb: display@0: Unevaluated properties are not allowed ('power-on-delay' was unexpected)

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm/boot/dts/nxp/imx/imx6dl-aristainetos2_4.dts | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/boot/dts/nxp/imx/imx6dl-aristainetos2_4.dts b/arch/arm/boot/dts/nxp/imx/imx6dl-aristainetos2_4.dts
index ec806b8d503a..c9b2ea2b24b2 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6dl-aristainetos2_4.dts
+++ b/arch/arm/boot/dts/nxp/imx/imx6dl-aristainetos2_4.dts
@@ -82,7 +82,6 @@ lcd_panel: display@0 {
 		compatible = "lg,lg4573";
 		spi-max-frequency = <10000000>;
 		reg = <0>;
-		power-on-delay = <10>;
 
 		display-timings {
 			native-mode = <&timing0>;
-- 
2.43.0


