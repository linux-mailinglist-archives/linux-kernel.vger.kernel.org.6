Return-Path: <linux-kernel+bounces-526490-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA993A3FF59
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 20:10:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C40E64257FC
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 19:10:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E01A5253335;
	Fri, 21 Feb 2025 19:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YAZzPC+I"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C1A6253325;
	Fri, 21 Feb 2025 19:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740165014; cv=none; b=QidUGQ/7/K4T13b8/UyhyiXCGJQzMoo6OlO/ak3Y/OxkRpEdD/uDFuuME+X6rIxNfAmfBXPheqfphfCrHrMeP0+go7GOOuQSSsiXHp8ARMXqOqY9UPl7rrwubj21NAkCiup4P3L47H/n2QsfqhNjdROyiiooKJEuhFTWYqbrfgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740165014; c=relaxed/simple;
	bh=LeH65yTFTRVqmDaRl1tqPoArVGX6tswmQUVoL+mdRu0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Vw5vJiNTaAHeUApEoZWqhtCV2SPLiVe/4Su77svj/g9NL5K9UbpbQXQ/unYCnwcKUX/tDyuZGLipBmN8pi+xqgy/dXHeKTNn0ydxAN672W5mSKbrv59IkmMc4H8W5onx3JiY9428xBcJP0j1wsaX4ecHMTC3MaEMV6lFIA9oG6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YAZzPC+I; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5e04f87584dso3707074a12.3;
        Fri, 21 Feb 2025 11:10:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740165011; x=1740769811; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=567O03TXl1K2zaFaElzh+NHx2wBNM9WmJYIw4dMoWLI=;
        b=YAZzPC+I2znMflMrwjcfqBOPwTbIEjk+T57oJCoIQSr+0NP9n9oSErcKuLASBoDvo5
         IskXNw3p1bkvNffAeTbNjxAgVXyUwoJgZqVVRCqqiSzlu3/cO8FkxnVPRvqIkSbGFOlZ
         mDnFd74+LbG/o2Vg3WQsgUf1N5FiypyocgmQy+5K5qs3yh6a6/3+IdTTnsgyt0CXqrNT
         HIAR85UaED/VlzKlWJWgIyMNvv3auwenZmH+MxcJYUVcGw68UCxX8iQqHnyH91fwOpmU
         OSWQPmVSzRy+jA5fJ2mPnMnoE5mzag4Atld8laR2YxY6V+YXmLN2ZYgkyJi/Ht2Rp/D7
         RWSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740165011; x=1740769811;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=567O03TXl1K2zaFaElzh+NHx2wBNM9WmJYIw4dMoWLI=;
        b=s9pQO9Il65CBv15iKwctVJUEE3KHtyhg09AwOWowZodjWOXEdh8lvgzM7b5rBDCXsD
         6N0xbsI3gst+KrH+cz5Og7DR+TvzWeQmuborpg2KIbAfoFsdIE4kiMrxBxuCDFvqNeFj
         Z1bV6ajJ0omAzYR0QjRhhjg2qSc1xCdii8czLwY9/mhEtWUU++PcgEJfx7cH+axpUtx0
         iQjlAYi9bsVBQh10gy0yCzmFCddlT2zyNiUIbtoCYyZBaR5eT1/whXea86uvxRoaoDuc
         N2pgCUp2hppYF7hTiC4bpq/AKiJAU/I/v9IPrRWTpg3iS7APi1VzrWXgpBmpSAkUnlCm
         xZng==
X-Forwarded-Encrypted: i=1; AJvYcCU1CudE2WE3UDX+yTeLdz+zr9RhmKfTGkbnVWB4avmFRofAp6oOWocg3zygGDFtH+hxns0PaPsEo0JB@vger.kernel.org, AJvYcCUuiRJlbfEgWxM1kgOBA97Hkz9lZqbQ0Jna9jXBzyQLOpQnIcdMQSaMG4cgelEEDG94cuSht/n58hxj@vger.kernel.org, AJvYcCWek1MGQb+D4lLbcEKqxPkER1gpDrgeVu7m80VDLcDYcm/28uoskvuxUy+DON5/O3/nsR0zKRI+eGipD0Bm@vger.kernel.org
X-Gm-Message-State: AOJu0YyUyLMpEfrf/scqNlHSZd8rcTdiDcRuGvvPzqnOIEweTIC+5cRS
	j6wY1bZGTmL2aqvMAWtukgusfolgMW2vH2HYyUlp5Q81Npt7JPXd
X-Gm-Gg: ASbGnctwhqHWRYO2S/AKfYC3wgHBkz6vS36MYbmotEw0glbSuapUxi1XPUUz8B3wcU9
	onf9c8GlXTIqgEeXSdMViR5kIOLZ9n5fzYZ/TcL5d8lVO8sJM8Y3sLAtoD3Eob5JfNoJTHa+wZH
	zEC3SBDwuXCKCcYXjoM5byad6DieffMq5aZTGuxEJvRRXwul7CaxrC7EAfnp7GaSysNWoddFauK
	jKNa1wjnUEkO2N0f2nHz9HTRfNTpR4oJQmNsMTP9CjsVu4mKdoQnC97B5e/M6vvMhYn4Oc5d4e+
	y07KeLn1IlakVfDqltqDRmQGoBdJxHLGj2VHyyQHZvLjMKiXd602LQbdTkk=
X-Google-Smtp-Source: AGHT+IEmPiejRQxTssIcrN88SLF0un2Lky5fZZJX36APFTjfjcJGDZ+uQm2T3CrIR28xRbfsva9TAw==
X-Received: by 2002:a17:906:314c:b0:ab7:ec8b:c642 with SMTP id a640c23a62f3a-abc099e9473mr411947166b.5.1740165010510;
        Fri, 21 Feb 2025 11:10:10 -0800 (PST)
Received: from playground.nxp.com ([82.79.237.175])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abb9b187203sm1027261566b.61.2025.02.21.11.10.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2025 11:10:10 -0800 (PST)
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
Subject: [PATCH v2 1/4] dt-bindings: clock: imx8mp: add axi clock
Date: Fri, 21 Feb 2025 14:09:26 -0500
Message-Id: <20250221190929.31469-2-laurentiumihalcea111@gmail.com>
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

The AUDIOMIX clock provider takes an additional clock: AUDIO_AXI_CLK_ROOT.

Signed-off-by: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
Reviewed-by: Iuliana Prodan <iuliana.prodan@nxp.com>
---
 .../devicetree/bindings/clock/imx8mp-audiomix.yaml     | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/clock/imx8mp-audiomix.yaml b/Documentation/devicetree/bindings/clock/imx8mp-audiomix.yaml
index 6588a17a7d9a..0272c9527037 100644
--- a/Documentation/devicetree/bindings/clock/imx8mp-audiomix.yaml
+++ b/Documentation/devicetree/bindings/clock/imx8mp-audiomix.yaml
@@ -24,8 +24,8 @@ properties:
     maxItems: 1
 
   clocks:
-    minItems: 7
-    maxItems: 7
+    minItems: 8
+    maxItems: 8
 
   clock-names:
     items:
@@ -36,6 +36,7 @@ properties:
       - const: sai5
       - const: sai6
       - const: sai7
+      - const: axi
 
   '#clock-cells':
     const: 1
@@ -72,10 +73,11 @@ examples:
                  <&clk IMX8MP_CLK_SAI3>,
                  <&clk IMX8MP_CLK_SAI5>,
                  <&clk IMX8MP_CLK_SAI6>,
-                 <&clk IMX8MP_CLK_SAI7>;
+                 <&clk IMX8MP_CLK_SAI7>,
+                 <&clk IMX8MP_CLK_AUDIO_AXI_ROOT>;
         clock-names = "ahb",
                       "sai1", "sai2", "sai3",
-                      "sai5", "sai6", "sai7";
+                      "sai5", "sai6", "sai7", "axi";
         power-domains = <&pgc_audio>;
     };
 
-- 
2.34.1


