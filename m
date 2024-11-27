Return-Path: <linux-kernel+bounces-423372-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 469F39DA6B2
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 12:17:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B796BB2C21F
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 11:02:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BD271F1300;
	Wed, 27 Nov 2024 11:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XvkDYawG"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC7D41E493F
	for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 11:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732705307; cv=none; b=lEn8ykfStBvcVvbaAtORDlVJBfNYAqkAoVl3qwpBwjXxz+7sPtcn8ji/LshR/E74ydopoXAyIaaPNV4Ykv5DCAXvWigK0u0Kwz4vCZ4fu2zZ5h7MSVwU5apg0XKY3kaC/1/7kIMCy2Jmeh0R9k6PiYYj9FhywARyZCVZy4bcBPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732705307; c=relaxed/simple;
	bh=wuW9dlmQHK3i/Jcfb0eJR/IK57A7oEJMFzUPWXw07Qg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kxcJtyIpR6XHIW+pWe8b/43dh1HNgBK0Ta+sDLMqOh4aOx2mBTZ+0A9GMj/GQMnBVtc3wBj0FTUQgeUZ0FDFjMoj/MzpmILAnvzc6fjhZmSJ7dts51q8/Zw50cywTFKa/lcEsnG/aK/bsbRic8mwt+A5QALf678MN3+FNEfL2A4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XvkDYawG; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5ced377447bso8944951a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 03:01:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732705302; x=1733310102; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sFCCGNoly/ihHw+f0V0Z4F6JNgdV9f0RgxXs1v/pmwo=;
        b=XvkDYawGO4rLrHjuOYqc9USC/olOKHS/kuwzL+WCClMn0MJZNMsdLdBV9UsdlpJ+VR
         k7Y/yiMQSafgLrRjR6TY9QSkcPoPbg1Xh6/kEW+CpusbIvHPPvo5FfuzQLGsBTjyQWw2
         8J1v5O8qutOM1weFjrexJNNAwTsr+WpmPydiQJmoqlKExoqHzTiP+yTvUiU+2qWUJQAQ
         p0Mn3lMQABa8ds7dgIpAQoCSNmnEPWtnKdEC2YaIOGU+unIW9wsYEWR6+/ftyBXzhylo
         5wNgj9vv6Mfy7YYGU4OGXmvRSPqpoxFG/ILn82gJwazAuHJPZExOoG4p2+hjqFmBtggK
         h7AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732705302; x=1733310102;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sFCCGNoly/ihHw+f0V0Z4F6JNgdV9f0RgxXs1v/pmwo=;
        b=Ee+iKCImB/qzaw5iQ4xlu0mDaKHokneZfUgR6GswRS+Q3oKZKib3Rvm7CD1QQcmZlR
         3R/8kOZgR0W+xO/RVmto9xNINWY1oFOvGgIw0lp23vC3611c7lG9oM0duHmsO066t0Mh
         hDyJubR3sVvLVmRR9BQt7IoBy7t6EHZdeiKpRegQcQkjzETjR9o9yZ8fn54F7EtG/gfX
         WbZFZAfXhYhV1j80WUPAZoDX/q2DERrwoSduiZfrUyMM+d/YGqEmQ3t1lDqA+OvTnOwb
         uuPfmu1Xn4PJtSpjgTMvc9yxCYiUGK0EmWRcewH6kdlBagaiv1vCdl6JCa4JuShQXqAO
         PBrg==
X-Forwarded-Encrypted: i=1; AJvYcCVUHOcPLUnH9NB4/q3R8sy3tC52jN8P/2CZVwBDbffmMsN2ajGandpRb/mxo5Trl4c/fFIw35hF6AIL52s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8n5UG4k/gZnln3AKXTxiauZQJL64UQRuCD/LqKjjzUDmycq06
	2r0KUYvY5bYD5Tdjda+9kOC1pqCl078UfLW/1QIO7mUOA6hqPdXe7MTAaU63YWE=
X-Gm-Gg: ASbGncsHC8AFQ9AngJfxx4Jg94stkssta2cQaxowGezpZtwumT0MOC8DNpiScqIlgim
	/EqxacvlU7zY90HFBjQcOZjcn88/kEuLO5V6YmjmFZCxGJMNT1U/iTFnC2iziCzdrz8+9FKY/KI
	BVteLm4ygtcawohgkomPhI13KVBgPCCKNWI7Bf73xQVC8PCPsXWrbP7mvk1dRLRRLU9b/5jU9eC
	N4oNexCFtEsu0V9zYL+q7Lo2OE2lrEOcBDT4zBDuzQise20882siLWjZCMtmO5k1QFLqQ1+GnrY
	DV4B4Gr5TBKquqEM4f515qb0OFFe6URRSg==
X-Google-Smtp-Source: AGHT+IGf8PRBbpu00lqdlanskxanZwbdL0mBeUOVNbWHJwrX3n9oj1hwGayugKGWxCGG58SnT8c/lQ==
X-Received: by 2002:a05:6402:2807:b0:5cf:4687:b816 with SMTP id 4fb4d7f45d1cf-5d080c64a93mr2444477a12.31.1732705302188;
        Wed, 27 Nov 2024 03:01:42 -0800 (PST)
Received: from puffmais.c.googlers.com (64.227.90.34.bc.googleusercontent.com. [34.90.227.64])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa50b339612sm693762966b.84.2024.11.27.03.01.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2024 03:01:41 -0800 (PST)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Wed, 27 Nov 2024 11:01:41 +0000
Subject: [PATCH 3/6] arm64: dts: exynos: gs101: phy region for
 exynos5-usbdrd is larger
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241127-gs101-phy-lanes-orientation-dts-v1-3-5222d8508b71@linaro.org>
References: <20241127-gs101-phy-lanes-orientation-dts-v1-0-5222d8508b71@linaro.org>
In-Reply-To: <20241127-gs101-phy-lanes-orientation-dts-v1-0-5222d8508b71@linaro.org>
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Jagan Sridharan <badhri@google.com>, 
 Alim Akhtar <alim.akhtar@samsung.com>
Cc: Peter Griffin <peter.griffin@linaro.org>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Will McVicker <willmcvicker@google.com>, Roy Luo <royluo@google.com>, 
 kernel-team@android.com, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-samsung-soc@vger.kernel.org, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
X-Mailer: b4 0.13.0

Turns out there are some additional registers in the phy region, update
the DT accordingly.

Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
 arch/arm64/boot/dts/exynos/google/gs101.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/exynos/google/gs101.dtsi b/arch/arm64/boot/dts/exynos/google/gs101.dtsi
index 302c5beb224a..18d4e7852a1a 100644
--- a/arch/arm64/boot/dts/exynos/google/gs101.dtsi
+++ b/arch/arm64/boot/dts/exynos/google/gs101.dtsi
@@ -1267,7 +1267,7 @@ cmu_hsi0: clock-controller@11000000 {
 
 		usbdrd31_phy: phy@11100000 {
 			compatible = "google,gs101-usb31drd-phy";
-			reg = <0x11100000 0x0100>,
+			reg = <0x11100000 0x0200>,
 			      <0x110f0000 0x0800>,
 			      <0x110e0000 0x2800>;
 			reg-names = "phy", "pcs", "pma";

-- 
2.47.0.338.g60cca15819-goog


