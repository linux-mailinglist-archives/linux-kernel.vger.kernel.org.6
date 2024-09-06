Return-Path: <linux-kernel+bounces-319295-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A51AA96FA36
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 19:56:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C34431C20F35
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 17:56:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0586A1D79A1;
	Fri,  6 Sep 2024 17:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="DKlnfWbe"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09F601D47A3
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 17:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725645380; cv=none; b=BFKLR1jti0+5wRe0V9Rr+4KIzhoD0UJ7NBxKBpW/Q2Fodduy0nQD4xDkdlmNz2F8wa26ubkN6FqsO0q9FM0HYCoiP4Ue75UGT8jy/du4FrvvfFNVghsT2e3TTsA35ukavdY7yhVf2HTvrgzrAqOP/mB/WaN3wXAGHur6PkyrZy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725645380; c=relaxed/simple;
	bh=zXF9mBceAiZFdmRrbogrjHaU81xz+97SowfN+Xu6mAM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dAAn0zcFVGjz2FFfveXZwu188Up+/+CNjMUF2WzMbtn96UIvSy2P6TsiFSNVyUXsfeQefDuRleypcJhVEBGPg1wndNcipGPECTCy/vFQxesVuUWBWdF+1FqcwESomqjv9wSiBJSeYI76J7epIH988hEJAAhP5yaK7N5K8HZi+bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=DKlnfWbe; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5333b2fbedaso4068593e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 06 Sep 2024 10:56:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1725645376; x=1726250176; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3jdiU1lP8uomQ4mDAPSUCDr8UHJhYvRZzMOjvIOy2wE=;
        b=DKlnfWbeiLL+6I0dbBoKFwooMdK2qgZPvFdbBwC/7i9jIzbjmvl252wPOuVfc7ozWh
         7ncoZcIZRxaq5YxSeASMJWwYYY2PcAe/wk4AdsNKgSReFqdfYgNps+Kyk48sOyQ0kDAP
         h+6iPRs5dI6OZbC6TyX2Qc2vViA8YgYpfwqh3TBa2xne9m2vohREL5Yr7Rsl5bw1NJzK
         knbRzdoVJIydrK1kL4zUOFQBDNWj3+hRcK09RQrMYokIVJZhz1buttb2Pi9vUZ9/fyF/
         c2jqmMI3cJA3tFXkD1taFZy9eESL4koYoUFzMGlAgoL5p/CAWKhVGOtWe1ZDAx/qlS17
         J9MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725645376; x=1726250176;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3jdiU1lP8uomQ4mDAPSUCDr8UHJhYvRZzMOjvIOy2wE=;
        b=Fnc7lvGzNzGBFuZdeVPDbQs10vD6tHLl5Tk5vdtLAdtnN86zMYOoJ3Q4E+s75aGBKQ
         R7CwAqGRZQQwk5NAa2lIl8U9Aan23/0qNSP1thIU2uOKLk3sV79ICrx4JIY1axGBHyR3
         2WWJWuM+yaxSqKl7ioM8mjOV/O9n09OFjWWSfS39HOwH9byx0B56/J4GUirU+dfYaATj
         jnX4FG7Fh36GKOeWsIhENRrkz4+n8DHejO7gNkRyf4UwpaTjsbBFd9jq5RVLA+S6A1QG
         JKwba9qb2iPeVUhR/QmRWF4qkud8Toc7zJwyOsCEveMPQP9RcG8n6F+KpSzSXm5flNsS
         ldLw==
X-Forwarded-Encrypted: i=1; AJvYcCW/XYqNLxZ86PZO/N773/kCVQNPihwXt4GCbO7iUtt+6DW6DCJOWHVN0pM28TSATt2TbqOtFR1ZooWHHL8=@vger.kernel.org
X-Gm-Message-State: AOJu0YydGdvVZ/UvvrXGn1TG2p1aN82Wy8BV7LCKh80cOfB2gFoHKsHB
	x+0WKs7Z0smk6QEFK4iXU00O/QqjZqPuSDrrYTpq0yx19jy4NwlJg9asfb9FXQM=
X-Google-Smtp-Source: AGHT+IECttwHDPmI8V8mxOWpTCwFKVm8/XvvY/9RJMf97OlEDsPIh0y8mXOYqQLmzS4HXoBF7YL/pg==
X-Received: by 2002:a05:6512:104b:b0:533:4505:5b2d with SMTP id 2adb3069b0e04-53658816b7amr1773198e87.60.1725645375329;
        Fri, 06 Sep 2024 10:56:15 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:b9fc:a1e7:588c:1e37])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37891607e58sm442920f8f.24.2024.09.06.10.56.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2024 10:56:15 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Fri, 06 Sep 2024 19:56:00 +0200
Subject: [PATCH v6 1/2] arm64: dts: qcom: sm8650: extend the register range
 for UFS ICE
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240906-wrapped-keys-dts-v6-1-3f0287cf167e@linaro.org>
References: <20240906-wrapped-keys-dts-v6-0-3f0287cf167e@linaro.org>
In-Reply-To: <20240906-wrapped-keys-dts-v6-0-3f0287cf167e@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, 
 Gaurav Kashyap <quic_gaurkash@quicinc.com>, 
 Om Prakash Singh <quic_omprsing@quicinc.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1283;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=wOUQIYwF2JfX+JAHWM9ajdudqzpwOY2jHNEhJ7xj3Fk=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBm20I9RU2jfoen5xigcqe1RP/+3Mj0P+rc831zI
 SCFNndtEtGJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCZttCPQAKCRARpy6gFHHX
 ciGnD/sECGoh4mnwUhEu4lqEiHfQQvXJ+PsLS284Mo1jpNS2D3PGRcO7iVizNoyfExfFaQ0/Lgv
 oO+/00Uy8Lv/HLbdeGoIW7elgZNlVmEemAKB/6yewiQ1BvGEvy7+rRLZ4ApZopnHkTZKUXsuiXj
 Qq14iUZUhxXSZ6pUaXZxivMj02yGTLy7/wjdBAqGglXz0tT1M639dOY0DWeAtP3piKOACxDoATD
 UZCvs2oHtQk9YMSh2ifiMNvcDiZtFxN8WKANCzpgKvCDbNWXwP/2Qh3PK9CYMPAyGR4Bk8i61l5
 NsLDpjyL5TIM1+NqRReD3ilppFUyD0c8aIjmUjxg6LqtY1J4CRmvJjhIGyDpPNgPMrpJA6MzS2n
 99wvuT90nE1xhIEO3i+Mx3ixCeXSiXCo94zs0Xf+CfCAmao8mEtMg+N1OXNdNK+mCqpvCm7pgxD
 +KlepkQouTXxmM4RPF4ZBrq1Tgq1gIP1uL6bR/skynhuY6i4awZPejpWWcvuKJhCN5vA4bn/A00
 D3EgJAGDZgF5MhqtkCRlKkJPGWu+v5nOWnzkXPqiigFhURul2cmx3QEFIVbMOdUcSi0JJMPinoz
 ovwnUAK6gEGuhaPRFJiIid0tZHIK93YZSUBTnFIYQ+RQbbKedkg/FtVcsnN1lts6voAx1WRIuuv
 CoKuTbo4SaFoWIw==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Gaurav Kashyap <quic_gaurkash@quicinc.com>

The Inline Crypto Engine (ICE) for UFS/EMMC supports the Hardware Key
Manager (HWKM) to securely manage storage keys. Enable using this
hardware on sm8650.

This requires us to increase the register range: HWKM is an additional
piece of hardware sitting alongside ICE, and extends the old ICE's
register space.

Reviewed-by: Om Prakash Singh <quic_omprsing@quicinc.com>
Tested-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Gaurav Kashyap <quic_gaurkash@quicinc.com>
Co-developed-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8650.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8650.dtsi b/arch/arm64/boot/dts/qcom/sm8650.dtsi
index 01ac3769ffa6..54b119d6cf92 100644
--- a/arch/arm64/boot/dts/qcom/sm8650.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8650.dtsi
@@ -2595,7 +2595,7 @@ &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>,
 		ice: crypto@1d88000 {
 			compatible = "qcom,sm8650-inline-crypto-engine",
 				     "qcom,inline-crypto-engine";
-			reg = <0 0x01d88000 0 0x8000>;
+			reg = <0 0x01d88000 0 0x10000>;
 
 			clocks = <&gcc GCC_UFS_PHY_ICE_CORE_CLK>;
 		};

-- 
2.43.0


