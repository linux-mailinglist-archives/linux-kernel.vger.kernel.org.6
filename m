Return-Path: <linux-kernel+bounces-218138-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 104FE90BA08
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 20:47:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 46631B248C7
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 18:30:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F5E01990BB;
	Mon, 17 Jun 2024 18:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="enUZwLqC"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61AB4198E96;
	Mon, 17 Jun 2024 18:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718648979; cv=none; b=RyU4R86u0cvoKbPM9jLfH/LGOK53iB0vrB4bxfKglebL9zTcHbmRrVaWAVpYYCD7WPIjgaDy6g/Cqsv/GSKHmvUfCVwh23MHkskNsROlwNo3/Gk7xJDnPf5BJN+OfsHshoN8pAlj2zmi6OCfWDhsdcy8GjkvI4piz1V88CRu4hA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718648979; c=relaxed/simple;
	bh=tR+zU5R22K0toTXTcO/PbvJto65bjcz/hgek1oodBZY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Z077Sm6qJUtnM2W8TMKEptgofo+sLuMmtOQB2ssoiKFuJZudmBcVq+AxYFoggHri1mW6Aw3+85d3lPCh7eufYcDdYgw9c7RE0Ax26cR+GANcycjwTvD+724PpV8AYMdgT9VyvQW4pMdW5NZx+ZOYLB8qtRy0HCZygPcKVca/wTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=enUZwLqC; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a6f253a06caso551799966b.1;
        Mon, 17 Jun 2024 11:29:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718648976; x=1719253776; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MU+B7r1roWhCC53/0w9lcVlxSyXhmtFcjHMLXN2RUmE=;
        b=enUZwLqCATsaIQX3IR123YGg9b08PwCV9mxlVUEH52B4qqg26SrKg4BACk8hLQUUcI
         QSVGAGnBQkyGEfqo7uDA8iupVekCQEr3D3ZLY7q5Is4zQPDfrAwXVNn8ewXGLI+Elfwq
         JH5MVfN3oxlpWigI+rpMaxbOdQXaETOppDB9qXkZ/xIlTCgyTBxaPlpXRbWBViAp5Aws
         8VWxNND455adQcx5gzPSHZ5Vf+hgefJcKhlqSKvueczv+kzcCQWoJQ0OgQq15RASA1qD
         ASR4XI+piceN7J33M2WI2rxMT+SbrIQ6qT/U+gKjmf0mFe+N33mSuy0GVBI22a15SQli
         v3rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718648976; x=1719253776;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MU+B7r1roWhCC53/0w9lcVlxSyXhmtFcjHMLXN2RUmE=;
        b=efrwHCPwllgD/HtINcQesApXcYYjYiUjgkKQ/GwTDV+623hqEIP0CIj+/QqOU9OXZL
         hRvJghrY9SashauAypFVhSyya6AZsxiODUkccH1yZC903y8fTarXDf86m8CbrA20D8VD
         EWEEQQEOTEACS1YUeYbED+z8z4W1k3DP3P5GuqCy0vi1/YVF4TVmspz+F3Hpd3vQUVcB
         DKwVUDq2fllT8k+W6xR1+r2O/3Z44Y85+0PHAPtIoZDod5/9l5GsqMnSX6IWPfp1ldyN
         KWmxukdvuj8SiU/4HhIAe7Vu9KlNgk7giwU2jS1g+0rMsVEl8QFkawVOEellr/XqkjNj
         u8BA==
X-Forwarded-Encrypted: i=1; AJvYcCXr7SZBYdQWf7glqyHUcWzfRJHoGobik80T+PEs/eSDqKtHJu6RQOomccFTivDhPQLCgEXCJq2VmK6xQ/3EA/6pBfm/7FisBeE2UqbYwgCNQ1Vb1CzeKncVhkFkQKpjH/Nz7ZIphGdHLQ==
X-Gm-Message-State: AOJu0Yw5gKYA6Ns9GPy8ZBpH7ih+wLf/YGDaRtI+XK+P0ZajENhwzKtl
	P9+HCo3yFUTBk2+W4E1laq3S5KO7i1nteOgZSCj4ukOgybjI2NzO
X-Google-Smtp-Source: AGHT+IHkpZcSAkDTfYa+4J9rdwDgw8EyCrZ88JhFCy8q4cRrxJtlYkExbYxfQTReGkkcw3FRZ9JpNA==
X-Received: by 2002:a17:906:a45a:b0:a6f:5f26:4d91 with SMTP id a640c23a62f3a-a6f60de27c5mr743717166b.69.1718648975302;
        Mon, 17 Jun 2024 11:29:35 -0700 (PDT)
Received: from latitude-fedora.lan ([2001:8f8:183b:6864::d35])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f8a6e58bdsm115397666b.187.2024.06.17.11.29.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jun 2024 11:29:34 -0700 (PDT)
From: Alexey Charkov <alchark@gmail.com>
Date: Mon, 17 Jun 2024 22:28:53 +0400
Subject: [PATCH v5 3/8] arm64: dts: rockchip: add passive GPU cooling on
 RK3588
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240617-rk-dts-additions-v5-3-c1f5f3267f1e@gmail.com>
References: <20240617-rk-dts-additions-v5-0-c1f5f3267f1e@gmail.com>
In-Reply-To: <20240617-rk-dts-additions-v5-0-c1f5f3267f1e@gmail.com>
To: Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, 
 Dragan Simic <dsimic@manjaro.org>, Viresh Kumar <viresh.kumar@linaro.org>, 
 Chen-Yu Tsai <wens@kernel.org>, Diederik de Haas <didi.debian@cknow.org>, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Alexey Charkov <alchark@gmail.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1718648960; l=1275;
 i=alchark@gmail.com; s=20240125; h=from:subject:message-id;
 bh=tR+zU5R22K0toTXTcO/PbvJto65bjcz/hgek1oodBZY=;
 b=UPyTLJFVwLauiOTlYWLbLMzDwMdWePM1iup7rFrqrBm60G1h1262CZ5HG0ZKTZrBeJby32q0u
 BOGYLSXVUvRAPJKUxRh+CyFsyf3/zZU1hBPdyHr3LYzJXCeiEqn+NyI
X-Developer-Key: i=alchark@gmail.com; a=ed25519;
 pk=xRO8VeD3J5jhwe0za0aHt2LDumQr8cm0Ls7Jz3YGimk=

As the GPU support on RK3588 has been merged upstream, along with OPP
values, add a corresponding cooling map for passive cooling using the GPU.

Signed-off-by: Alexey Charkov <alchark@gmail.com>
---
 arch/arm64/boot/dts/rockchip/rk3588-base.dtsi | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588-base.dtsi b/arch/arm64/boot/dts/rockchip/rk3588-base.dtsi
index 574359279867..758aff5e040b 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-base.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3588-base.dtsi
@@ -2487,17 +2487,29 @@ center_crit: center-crit {
 		};
 
 		gpu_thermal: gpu-thermal {
-			polling-delay-passive = <0>;
+			polling-delay-passive = <100>;
 			polling-delay = <0>;
 			thermal-sensors = <&tsadc 5>;
 
 			trips {
+				gpu_alert: gpu-alert {
+					temperature = <85000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
 				gpu_crit: gpu-crit {
 					temperature = <115000>;
 					hysteresis = <0>;
 					type = "critical";
 				};
 			};
+			cooling-maps {
+				map0 {
+					trip = <&gpu_alert>;
+					cooling-device =
+						<&gpu THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
 		};
 
 		npu_thermal: npu-thermal {

-- 
2.45.2


