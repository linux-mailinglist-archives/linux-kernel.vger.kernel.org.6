Return-Path: <linux-kernel+bounces-230628-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 65BC6917F8E
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 13:24:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CB196B226CC
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 11:24:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A0CD180A93;
	Wed, 26 Jun 2024 11:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mG9Ck6+b"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB54F17F4F2
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 11:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719401029; cv=none; b=bS1NitX0bAww4gCcRScWzk173gwGINU0f7qgaPA4ilWa9swACwVAcmti51jgn5C1dXuVitRHaqWN9z357Ucj0L3KXpri+ux5oBM5/tuIgEJ6oS4qkLWEStitE57EIn3e9wkFtXTlLMi9nCUTCTD8a/X12nlAkiZ+E9vBWR1+leE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719401029; c=relaxed/simple;
	bh=v2qb/MVWAG/EQ9hPvKewoWpkPwivNisigop3GluQkSM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gU0W6E55HhksaKxD17BC9EzuQfUorGYTTGxJkkd+HLWF6/HelUcIILPF5gbZsNbbYYsZc4DHvzixCglhkdLTeltLib61gXw31HXN6VpwpFRbbEZnFJOXi5CLjCVCOiXeWOmRhUA5U1Fn5NTSbYaILg9zJNetHjmjPU2IT23cJuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mG9Ck6+b; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-57d0f929f79so93102a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 04:23:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719401026; x=1720005826; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tGlGUUqYBd9eXKuviJ+eBUjVQ2ns17XDtHcCv0Am680=;
        b=mG9Ck6+bbmV6FtL7jZD5I4nP5dfCIlfOjrrsqUVEOi4wkaR7VXJH3YHPfzVXFSsFTO
         TVa1C/cqAMvxy6v+90FT7klcdMvcYB4lJxh8mx5oJiGHETeRzrXMp4/Rn+2GXx+XTzyI
         udyAiLT7uyfl7K24CIy2aY3GseUv+x16uKIjNXt7YE+MqOnNBqNP5Hz/27PcJBb+lfAg
         Pa77LErJO/2WzGTTnTpQ2/FHLDtZcnfvdVlxjEHNQX9h4LGO/DU4Lxkn86/uDDwGqLon
         +cJC4PAP62EKViWSj4DBxb7eDSCgSqqfK25/YuOo+9Rg2+FJYek2B6Oh+u9TEsyUdoIG
         dtjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719401026; x=1720005826;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tGlGUUqYBd9eXKuviJ+eBUjVQ2ns17XDtHcCv0Am680=;
        b=hB95hqY6l4pKcIwzgC/Zat6C1yD7gTqpaLcYiWYj7sQ7RtTjMG9nb1uRtUbxqoMLN6
         jkUb4z31LvFbySOB/+Z99lRzqWX61V2S6jYwTaKplfTI+O1XzKPsYonwQ2GPfo2Ve2+N
         VONYESal28dvAt7FjQFQ1Fo71ugg7AIs6Yav2RBJ/RRE2CX7Mm5o1/NyER9uCNV3UUsc
         97XH4dlJcUsRfKCuXOqfnzMbdjq0vHIeSGhLY30mPi9YVL3j21DKOo0bn5qFT+eYX8Ud
         OKwJ4Ho582EfoXBCPSs3v9UCh9mwfn2Egw41zlNunMKi6obO4VSHMsgfmZI0jen0Qn91
         kSRg==
X-Forwarded-Encrypted: i=1; AJvYcCUW3/xBA/9ak0kqaWN4tKt/86iOwyF01Xb+ank2RmOw84l446d7jSyATGmkhZ52nQImpC4ZSzDe2lAXdXjPW3U/QSHZiwUNZtXfv4Bw
X-Gm-Message-State: AOJu0YwJLQZ74Cdm3HaKMEh2UvucxrL1tQ7vmaS5MCTCnGmoAitFeROD
	vAiuu7NFt6oPY6Ln3C28rRsJtW/tt3o6vaUXS7PW8clY/9gCWMPay42DNjRkneRg7ujvCb1Epzu
	x
X-Google-Smtp-Source: AGHT+IE0ewhlgTLPyWpb+gu/mszjOE1OKLDqyeFuWwoXtFnmdY+uucaefQm9kA1LPwTHsLYLbSi6zg==
X-Received: by 2002:a17:906:2690:b0:a6f:586b:6c1 with SMTP id a640c23a62f3a-a7245c2db6cmr654006866b.56.1719401025907;
        Wed, 26 Jun 2024 04:23:45 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.137])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6fe03b4528sm497772166b.206.2024.06.26.04.23.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jun 2024 04:23:45 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Wed, 26 Jun 2024 13:23:35 +0200
Subject: [PATCH v2 3/5] arm64: dts: ti: k3-am62: add dedicated wakeup
 controller compatible
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240626-dt-bindings-ti-soc-mfd-v2-3-ee4d69017326@linaro.org>
References: <20240626-dt-bindings-ti-soc-mfd-v2-0-ee4d69017326@linaro.org>
In-Reply-To: <20240626-dt-bindings-ti-soc-mfd-v2-0-ee4d69017326@linaro.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Roger Quadros <rogerq@kernel.org>, Nishanth Menon <nm@ti.com>, 
 Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1023;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=v2qb/MVWAG/EQ9hPvKewoWpkPwivNisigop3GluQkSM=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBme/o5IwHTUIUWXbVDGP/Vd3FSg9FhGZV+b6LRZ
 cN9uE6iXa6JAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZnv6OQAKCRDBN2bmhouD
 15geD/9evEiI3n1vqIsVpiwRXwmaoTYcURUWyBzfPKjtS8hsgn9StOmfcWMyzhXp/dze9dDvAic
 2v7Vu+Kl2cmzy3MAnL+yXY7ePuboCEhzK5OsxPRBANEjrkfZ5+22Fo+rwVCXXw8FOni/yv6HmWb
 W3p6Lxf4OXfjcDeO4s29sXlkzeVAOtNr026G2A5dRKXctn5JU//bQpVTDVFbOimHGeRw21D0/ED
 KMb6DRW/lsSqS6/WiNyeIDkY+baksgTZQCWurb97Qyd+NsrxJaaAr6a5YpD9M0H0oxnAL2aABXi
 vk/FVFvj5xZMUnb8JXtFafCvr+IGaONqZcai11Kf6uQHDjJAE7ZBVfmGEW+hsAZZDwv5nkmQ0y9
 TFqv9EDnqgB0aBaTJ1h5mYDMwckfT+P/5K0rbfbcaCDhDthupS14+KiymCjGEz9g/Yo4Lq3tH5I
 TF/Wk/b1ZTCg7X//vsyBBBNkQev+iTGEaEXOsrWZaRIL9Eu69crUMfV9py9V9zBxiywi2axl30Y
 HjOuwrRXCzpPoa1CveVwibqhJbNtDsjEXrIbhIKItYk3ilSsllq/cjl36uaeZ/ZIN4PWXqWVlTp
 5w3NBlRtSazU90dbZeOPT0JHxsADgP3mL8QwKvxL9tcZk3lIe01qBLLUtG8lYkHcX4aRGOR0xum
 1eJf3bS8cxvd3/g==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Each syscon node must come with a dedicated/specific compatible, which
is also reported by dtbs_check:

  k3-am62-lp-sk.dtb: syscon@43000000: compatible: ['syscon', 'simple-mfd'] is too short

Add one for the TI K3 AM62 wakeup system controller.

Reviewed-by: Roger Quadros <rogerq@kernel.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/ti/k3-am62-wakeup.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am62-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-am62-wakeup.dtsi
index 66ddf2dc51af..3c1023108642 100644
--- a/arch/arm64/boot/dts/ti/k3-am62-wakeup.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62-wakeup.dtsi
@@ -10,7 +10,7 @@
 &cbass_wakeup {
 	wkup_conf: syscon@43000000 {
 		bootph-all;
-		compatible = "syscon", "simple-mfd";
+		compatible = "ti,am62-system-controller", "syscon", "simple-mfd";
 		reg = <0x00 0x43000000 0x00 0x20000>;
 		#address-cells = <1>;
 		#size-cells = <1>;

-- 
2.43.0


