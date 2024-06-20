Return-Path: <linux-kernel+bounces-222508-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3B1D9102FB
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 13:35:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B5BE2876D9
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 11:35:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B28D1ABCBE;
	Thu, 20 Jun 2024 11:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BmKrjxOg"
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E29D1AC239
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 11:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718883312; cv=none; b=PW+PcwT1+hHpnJ0931nheRwJPKdsrZL4ymFqFbXVMVt63Iy+w+W5P3cLLm0Nv7HBaLKpCY5p29JMmXPmbAFV/2mEOX9bgvGfRems1s1yvEBcmWucF9GVoTPWooVDQvM1jNR2yNnqowMbJoITyuc0wewk7AwvIw6XIvQPs3k0zJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718883312; c=relaxed/simple;
	bh=oOZv8tGbYc82cA/I5ucBrkQYLVo4QrwMB1ASBg/dOCU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Qd+hdILPteOE4g/Z4N+efvot2YeR49ebER+o/cJNyzpeMKsxeXSMJhT6wiaHKlys31f5TdpTRR76eHxf8sjDZ5LW3j1NVUPHBXDihJvDDaoGl/JF5wB0qICnrUaK2pp4qaHSwTlWQ+TeaJwo5LMJ3dhrjQRDNi/3LMdgsB2FsIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BmKrjxOg; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2ec1620a956so8202521fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 04:35:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718883309; x=1719488109; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ucm5uoyXbWeiBfyorFJ2TTmyVLZllZQAufxu5LXpC9s=;
        b=BmKrjxOgzrdPqZmGoufph+RudB59URIW0+egBlGEj0xLQCNTSQ0J3/0SzuWaIhi5Y+
         T9uEDkhsDWIhwerfiV4wfEU9Wnu3On9YziiayCZmkYR6Dy1auTmE9qG7+H4A00xieV5F
         XZy1uA69ru+rhPehh5RYHjRTV2q0G/RdqAABOv0sVVveyEnafrZz8txJpehXVPS8gzvF
         lDBbM5q/igxuW282uO3gs8RxfWZSDvxdJPQyGKIAD3EiAcPpBJaSD4R++4NnSPqiYAiZ
         SDnIC+WJgpni1YhDDAn0eI6DRojM7q0T5tyBdZL+Jd41DJq/MB+52svpmdW5tYAb4bAK
         obGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718883309; x=1719488109;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ucm5uoyXbWeiBfyorFJ2TTmyVLZllZQAufxu5LXpC9s=;
        b=oVkJ2unimqp/lgG8Dh8ovTnTOUnF14QmEUpnQUcI5Mxw+ZI2lR09Q1IJZxW5tdDZbM
         TTmaXoDs05fynCu9QHLClAbOcbcNerJFLfbSgcsRitTsH5Vmx9XfEE/AsLkOIwyyG1Mo
         +2MvzngDhn/o6DCA897PrqCEdLsRq3UMlF0VmY+8onjsFf/9cbFyyOVC7/Chi1y1aOM7
         fQ7UOyIiS0dcooWNmFALgqmpzCI1pD5/UfdG/3Iag/si4TB1t4FcQx6bqbhqBCQ7YLY4
         +KuQhN2RcT4WxDaCPU1sldClR6XdcUP2qD8YE5+cIVeG+TXtPpe6rqMFg90VZLKGpx0E
         mpyw==
X-Forwarded-Encrypted: i=1; AJvYcCUjetuuYLSk5liCEu0RA41U3yD2c7JXSonYjMQ4Zbdl+nOAVzl9pbOur1qM17l0DlUMyXsxN82schQ94Bc5SScW3s00dTJa70e2Gn8p
X-Gm-Message-State: AOJu0YwVcRewNM/6gMhUbM52vP7Zib3/Oxi/6L3Iz9N+80R+kkKrNHeG
	2ZNHuD35X3SszJRaPcWPNnTOEHU7uwGbFM72WAHBL+dVVIVAQJDsKUtA+P/CH5Y=
X-Google-Smtp-Source: AGHT+IGCiIDIoYSisVXo+ZB+zS0aVSEEsBqiNcTjA1lAiqVyjloGPunGlLuMfIiyiuCdUmat3EsNeg==
X-Received: by 2002:a2e:2c1a:0:b0:2ec:1dee:4a2c with SMTP id 38308e7fff4ca-2ec3cfe5a34mr31845791fa.32.1718883308821;
        Thu, 20 Jun 2024 04:35:08 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.137])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42471e6623fsm49708985e9.1.2024.06.20.04.35.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 04:35:08 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Thu, 20 Jun 2024 13:34:50 +0200
Subject: [PATCH 2/7] dt-bindings: i2c: google,cros-ec-i2c-tunnel: correct
 path to i2c-controller schema
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240620-dt-bindings-i2c-clean-v1-2-3a1016a95f9d@linaro.org>
References: <20240620-dt-bindings-i2c-clean-v1-0-3a1016a95f9d@linaro.org>
In-Reply-To: <20240620-dt-bindings-i2c-clean-v1-0-3a1016a95f9d@linaro.org>
To: Andi Shyti <andi.shyti@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
 Sergiu Moga <sergiu.moga@microchip.com>, Benson Leung <bleung@chromium.org>, 
 Guenter Roeck <groeck@chromium.org>, Doug Anderson <dianders@chromium.org>, 
 Enric Balletbo i Serra <eballetbo@kernel.org>, 
 =?utf-8?q?Ricardo_Ca=C3=B1uelo?= <ricardo.canuelo@collabora.com>, 
 Thierry Reding <thierry.reding@gmail.com>, 
 Jonathan Hunter <jonathanh@nvidia.com>, Vignesh R <vigneshr@ti.com>, 
 Kamal Dasu <kamal.dasu@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Florian Fainelli <florian.fainelli@broadcom.com>, 
 Wolfram Sang <wsa+renesas@sang-engineering.com>, 
 Chris Brandt <chris.brandt@renesas.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Geert Uytterhoeven <geert+renesas@glider.be>, 
 Magnus Damm <magnus.damm@gmail.com>, 
 Pierre-Yves MORDRET <pierre-yves.mordret@foss.st.com>
Cc: linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 chrome-platform@lists.linux.dev, linux-tegra@vger.kernel.org, 
 Krzysztof Kozlowski <krzk@kernel.org>, linux-omap@vger.kernel.org, 
 Kamal Dasu <kdasu.kdev@gmail.com>, linux-renesas-soc@vger.kernel.org, 
 linux-stm32@st-md-mailman.stormreply.com, stable@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1022;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=oOZv8tGbYc82cA/I5ucBrkQYLVo4QrwMB1ASBg/dOCU=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmdBPgSEMSR1DQFgpOr4nndNuYpTz1w8LwEmDS4
 0mTKxKxfwyJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZnQT4AAKCRDBN2bmhouD
 13PCEACPHog1fCP0NY2sMndBJdes0p4yAslPX9rTELMCOS5n5DPp637Do0m7jFjPFSaIDm3iPvs
 RksgCvs1gc6UMZtaL5lq02z8khB+ZrIyy2eNWUKoEKOTHkGqoNyiup6iyvZ5IPCl79R3Uu2Vuyc
 WgpJF7yIUkSWoLj+eqqrsiJK1rmDQu/H6QySDOa34JPLbE4e6oEgRVgl7+4sGvuu/OwFTILGYTd
 1De+1y75qaSe/BtA3H2EOfD39VJB4vDmRLnoDqWPd5BM0gQ+hApp5SwfTWYfFhrTsx2BUxpFfdp
 Rm/GKg61tGmvzgRIiyKvxv+jmYlEOjPQk2KAukH2uuIhZOrLGTCFgLYypk6phoJKezXfYIa9CIY
 Z/xaQDuglH6wtkcFVjWu94Jp3QurgG/mn4/TtKFPRjvWTcJzt/AaWQ3wDNlXuombZYuyrOvqCRj
 BPKybgVc6k88Av0AK9GbgcKqpzL1aJzk+3OsDcupIf9v2gyKLnCh63r/ruXQgE/tZDtwxY6IvmK
 1hicnz637diRzjdPPurY0OMN91Rl8uv67j7Xi5yJexUmFE7yZHRYQ+pn09lY/lXqBKYoTYnCHJp
 7/cj8xOfunNb24z4rm29nnaJ60CpvQc1a63gaQQ2q/8YnetFezeHwhYpyNHUUG9lv259BdHD+e3
 WsXEUhMwdoS6FpA==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

The referenced i2c-controller.yaml schema is provided by dtschema
package (outside of Linux kernel), so use full path to reference it.

Cc: <stable@vger.kernel.org>
Fixes: 1acd4577a66f ("dt-bindings: i2c: convert i2c-cros-ec-tunnel to json-schema")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/i2c/google,cros-ec-i2c-tunnel.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/i2c/google,cros-ec-i2c-tunnel.yaml b/Documentation/devicetree/bindings/i2c/google,cros-ec-i2c-tunnel.yaml
index ab151c9db219..580003cdfff5 100644
--- a/Documentation/devicetree/bindings/i2c/google,cros-ec-i2c-tunnel.yaml
+++ b/Documentation/devicetree/bindings/i2c/google,cros-ec-i2c-tunnel.yaml
@@ -21,7 +21,7 @@ description: |
   google,cros-ec-spi or google,cros-ec-i2c.
 
 allOf:
-  - $ref: i2c-controller.yaml#
+  - $ref: /schemas/i2c/i2c-controller.yaml#
 
 properties:
   compatible:

-- 
2.43.0


