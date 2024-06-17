Return-Path: <linux-kernel+bounces-217971-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CD27290B710
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 18:52:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 75C551F23EAC
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 16:52:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51D8B166312;
	Mon, 17 Jun 2024 16:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zxH3gaZu"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0086160884
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 16:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718643149; cv=none; b=fcxYv7VAQWO/okqVRxaSaTkWr/Il8DzPkKeqoAP5TMmEAUmH06aoOP+ssGu2lyemXpI83WYDCkTgZjGCVLObzt9tpKc7T4nbqbokXmiHZPOGsQEyBIRM0XmzIt9eVn6eYXxbgfaW03SoAQt6x8x+DvFCEBP8j2G8UIVZtHKvDfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718643149; c=relaxed/simple;
	bh=QlFWWrphdJLUKrnqdX/WA0FmGEy2H4QxLEAk/Rlk/Ts=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=r0Gzbd3sNlCvM5XSlEKgxuUyadz+oCOTZkPlgMvBRqgPUmnI4lktnPe6QdUGWXt304n0HqwaZ1x3DO2SG3sTc2sFefZd9jf5769YEaNZwDHuHb90hzTlWojOo8wbYBOX7FnXDUX4ZeU5WNytpYU3iMJRWnkWx7mHd/dI9cI9JJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zxH3gaZu; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a6ef64b092cso558884966b.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 09:52:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718643146; x=1719247946; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2SXqfMqzsmgi60tzvZSO8Ci7JwFaQflPhy4e9Xx/RRA=;
        b=zxH3gaZuO2hl7boyhtUD01r5UkeNqAlviSKD/SKNqWbel76bBSOTBaH8wplVVpZW+b
         7Bn+YUddHxLaLUDxjizruL0P5QgHnccxsUpFM/0HHqefzQiQUHlZlZrXbrHk4lpstx/t
         4oa1hfuAfREVfetR3YO3j44xsYs5UfQT5EVw6kXIqW1AVybYfUmCnSGeemqf1OVz4U/2
         2spEXHv9KoC++qpzHRGQrEgqRSPwCoSpZC+0byI6hD/oGNxhNZ4fGom30APHmNFFhr+J
         h82wFFNEC1dlsy37OUA/JdMsYEeuQq0y/FjgIKOydUdiw89aHJVXw3wQ8wubPx0ATGUH
         KunQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718643146; x=1719247946;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2SXqfMqzsmgi60tzvZSO8Ci7JwFaQflPhy4e9Xx/RRA=;
        b=rt8uA3QiSybvkO/+UEUhQT6+fd9QLRh9it94fLTro4+CIipYQQpzxRwaC76YrFZ4jP
         8cOMejXMHLrhS0bl+LKAGRX3uXrd2yZrv+R07m7z+NTefZuErVEZO72PoA+4jTMb+PFE
         +g8F4mymnk8lZ8Lh/NGcVHxhejQn3AWdTHtjNCFgtRMUZk+h+MjX1RxXTZcddtnG554G
         /gAlcdDjqvVFrR8Z1x4UKL9fICBtKdokJDZTKlLuiZXi+tebqJquG+4XK8tVwTEel2nr
         FRJTHmOJlacttxwwCEPSwB5I5vPez7V03by0Ahr9VwB/fD5AMUL52feVAlXkLangk8TR
         r8kQ==
X-Forwarded-Encrypted: i=1; AJvYcCVzA2Aqijn8fnA62AGgF1xyRl1xyjZeo0TGjKdiSq5ZpB6Dzt1LaS7JwcZJbUvvMFWj2IViiCQ2MvCgrlYqvLNYGARh4HvW9h9U4rEf
X-Gm-Message-State: AOJu0YxPnr0eUVM5tiT7/LsL5z+kdwWmx+eePzvfXwBrFYHguTRMG3mV
	5A+OO9RQRRS0YHecgv+qe66KTzmGRrvuhH2fWequIE5rlb3nJxuyNToEih5zkz8=
X-Google-Smtp-Source: AGHT+IGdOXSsdt9wpeM+S7PJouIKDjRGTea/R3paOf2QC08kw74Op/Ef1S4OlA1jnZ9Lbhjly1OS5g==
X-Received: by 2002:a17:906:3c05:b0:a6f:1cf9:9b56 with SMTP id a640c23a62f3a-a6f60cef3bdmr659622966b.9.1718643146286;
        Mon, 17 Jun 2024 09:52:26 -0700 (PDT)
Received: from puffmais.c.googlers.com (8.239.204.35.bc.googleusercontent.com. [35.204.239.8])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f8176eea5sm190176766b.88.2024.06.17.09.52.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jun 2024 09:52:25 -0700 (PDT)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Mon, 17 Jun 2024 17:52:18 +0100
Subject: [PATCH] arm64: dts: exynos: gs101-oriole: add regulators for USB
 phy
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240617-gs101-usb-regulators-in-dt-v1-1-e2242542c518@linaro.org>
X-B4-Tracking: v=1; b=H4sIAMFpcGYC/x3MSwqEMAwA0KtI1hNoix/0KjKL1sYakCqJDgPi3
 S0u3+ZdoCRMCkN1gdCPlbdcYD8VTIvPiZBjMTjjatPaDpNaY/HUgELpXP2xiSJnjAeGGMJE3jU
 z9VCCXWjm/5uP3/t+ABWWvJ9sAAAA
To: Peter Griffin <peter.griffin@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>
Cc: Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Will McVicker <willmcvicker@google.com>, Roy Luo <royluo@google.com>, 
 kernel-team@android.com, linux-arm-kernel@lists.infradead.org, 
 linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
X-Mailer: b4 0.13.0

The USB phy requires various power supplies to work.

While we don't have a PMIC driver yet, they should still be added to
the DT. Do so.

Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
Note that this patch depends on the updated DT binding from
https://lore.kernel.org/r/20240617-usb-phy-gs101-v3-0-b66de9ae7424@linaro.org
---
 arch/arm64/boot/dts/exynos/google/gs101-oriole.dts | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/exynos/google/gs101-oriole.dts b/arch/arm64/boot/dts/exynos/google/gs101-oriole.dts
index 5e8ffe065081..1a79d9ab3be0 100644
--- a/arch/arm64/boot/dts/exynos/google/gs101-oriole.dts
+++ b/arch/arm64/boot/dts/exynos/google/gs101-oriole.dts
@@ -145,6 +145,13 @@ &usbdrd31_dwc3 {
 };
 
 &usbdrd31_phy {
+	/* TODO: Update these once PMIC is implemented */
+	pll-supply = <0>;
+	dvdd-usb20-supply = <0>;
+	vddh-usb20-supply = <0>;
+	vdd33-usb20-supply = <0>;
+	vdda-usbdp-supply = <0>;
+	vddh-usbdp-supply = <0>;
 	status = "okay";
 };
 

---
base-commit: 6906a84c482f098d31486df8dc98cead21cce2d0
change-id: 20240617-gs101-usb-regulators-in-dt-bdbbcea25fe9

Best regards,
-- 
André Draszik <andre.draszik@linaro.org>


