Return-Path: <linux-kernel+bounces-443422-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DA7E9EEFF1
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 17:23:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 813F31899934
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 16:15:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42FFE244687;
	Thu, 12 Dec 2024 16:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oc3pg1tG"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82656243551
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 16:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734019256; cv=none; b=qrUZLAn6xdEtqa6EUzCyNQ6697sds1TdsaUv/nOozDYi0sFFORVvksJQ3b2Ej/VXRq/QTOg2GliEqcwy/8UmkrQcsLhkBId5ObECUiKjmpAJvF0ovmYXppoCay2XVMESw2thoi5M5wdbSDOO08vq7Kru53j+djv+FkCAh6pYRtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734019256; c=relaxed/simple;
	bh=/C7bHQrkgGdLprOLUDNL1QPrbsGLOKte0YUezSURupU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZHcx7bYCpXgcYKR3YTiyGPHCP+HfQTxCCkv+Ecpak2TDbSqYH7MczLP8UZr6V6ASdSKiXUNYhW7CSEsqhUGXrG4pcQpYmGDIAtONkW9qtAJ/attmfhVQrfX6WwkpfXaO/TGHoRU7+GWRBqdJXo6JUyLDf0gSYPWn0fsgMqkx0cI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=oc3pg1tG; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3862a921123so547960f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 08:00:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734019253; x=1734624053; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mUJZKl6ex9Y6tnVneUNF04HScPdq/LgCtN2B23fl+ms=;
        b=oc3pg1tG5cZU3BVT9S1eH4v24orfEjakcbFRdzF40K32ojWsMRowUnw0RX9Mt1Vxdy
         O0EhVQ1o+YqWE0dgYZSiQKa5mSUbKNzfPKI8vX4dpUJYlRMbW2ATxV6+WJJMJ99zTP8A
         DZboSDqEWInTm5yYp3+Q8L13C4lawOFK/TI+0PoDXF6u6ElwWA2aciWqzndQjd0C1Opj
         YjqwV4pAHnM0jHV5e18l/NutkLlolc+MpHF8/XHaLwwieBe6VzVXb/wzlpD8iVaKnu3A
         GJGOQ8ZfYyLLGQCxfAvpQF71JfeDBwsDXQ7J0GzXrofn7boMgCtA66mECU/z0VwIHIUK
         YLoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734019253; x=1734624053;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mUJZKl6ex9Y6tnVneUNF04HScPdq/LgCtN2B23fl+ms=;
        b=NxP9p1az8mSKlEmcQ0shgf/cgEhql63aqHIgU9MEMKGOS8q/vsyefM/k1kS588iruG
         ktHUtcNWmt+LDdq6YTLZJzNDfB2Ow38epB3CGmknR9IHReZusoyiKw+17Ay+nQWmYc6w
         BvXkTw/4mptXuFhG3GdHbKaZuemXRaUzGx55XMLF+nVT9bUl4+1rpg8irhsP2wjvDEsV
         6lpZpz/+L2CWxHKnVoyLSFMH6NEQGPGTxGxNsK/rwEoFzi6vs6m2UwsjX05zgJdlFnAo
         GX+EHIRM2aomqdWmUwu1sT86Ev5ADjdptviUao9oPXAB6OBBEpGJWfFKk5jJku9vYX0E
         UFLA==
X-Forwarded-Encrypted: i=1; AJvYcCU9RPYj/4EXCQeFcdt9W63fQbt+q7FVT01ebwJxS4V6iyDzQlOCgH0ciL82z14lzUhHDLLcWbFB7JyDIQQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWJLZ+SIjOCYJiqmJlQuSFnhbdFono649fzSa1OO3JJlBSPjin
	kn9aTE9IpPTA9OQ8Ab9SJpY4de3DsyCz1Px1o0mayQslrd/rGGBOU8wHZthcDKk=
X-Gm-Gg: ASbGncsjcke67+xHyHXwv8zgnL31UC17R+gj3JnaKHTS+PfQwbmM1ttNK4cClJndtrY
	S4/jXj37fp3V3Vu95occbYVDFaeRqI1icQ8ghenhhWkVPWGaCOch/HVGQRkWtg7XKskQ20w59kW
	Dpu858L6+f20bHWpW0IJ1mEh/omozaJdjabSX9xGRP31ccPgVj0agr4+BCP+b5S+QQMmCYwiiAM
	4Xt6wT0sAprzbwiB6ABIg/fxaabn8vXZif0bDJZDS2+ujSBAQT+43QFfflE32ij6Z0yv530WhUn
	i5qWyNi9cgRcMf8UNFq9209nPwANIjte9A==
X-Google-Smtp-Source: AGHT+IEN5nwnyUkAQMvO2q9jKMCm5xWXv8+YOzw7jcftLoAsAmmzmAcKvyZSzw3KzqJ0H/b/wrjw7w==
X-Received: by 2002:a05:6000:186b:b0:385:ec8d:8ca9 with SMTP id ffacd0b85a97d-387877c98ffmr3397430f8f.42.1734019251001;
        Thu, 12 Dec 2024 08:00:51 -0800 (PST)
Received: from ta2.c.googlers.com (32.134.38.34.bc.googleusercontent.com. [34.38.134.32])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38782514d35sm4462941f8f.74.2024.12.12.08.00.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2024 08:00:50 -0800 (PST)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
Date: Thu, 12 Dec 2024 16:00:41 +0000
Subject: [PATCH v2 4/4] arm64: defconfig: enable ACPM protocol and Exynos
 mailbox
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241212-b4-acpm-v4-upstream-dts-v2-4-91b7a6f6d0b0@linaro.org>
References: <20241212-b4-acpm-v4-upstream-dts-v2-0-91b7a6f6d0b0@linaro.org>
In-Reply-To: <20241212-b4-acpm-v4-upstream-dts-v2-0-91b7a6f6d0b0@linaro.org>
To: Peter Griffin <peter.griffin@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 andre.draszik@linaro.org, kernel-team@android.com, willmcvicker@google.com, 
 peter.griffin@linaro.org, daniel.lezcano@linaro.org, 
 vincent.guittot@linaro.org, ulf.hansson@linaro.org, arnd@arndb.de, 
 Tudor Ambarus <tudor.ambarus@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1734019247; l=1030;
 i=tudor.ambarus@linaro.org; s=20241212; h=from:subject:message-id;
 bh=/C7bHQrkgGdLprOLUDNL1QPrbsGLOKte0YUezSURupU=;
 b=q/qMWb3Eov9H0T2BHl7oTCrCuPXOj90JVrh0cjnd8k61RuCnu1AB8+Cevc0d3x4+b2BnG9tb0
 ExoRQa94+dQA0btBlEStNmn/o64BWNR7SWxVKOt/i78pqHEKVU8gpwT
X-Developer-Key: i=tudor.ambarus@linaro.org; a=ed25519;
 pk=uQzE0NXo3dIjeowMTOPCpIiPHEz12IA/MbyzrZVh9WI=

Enable the Samsung Exynos ACPM protocol and its transport layer, the
Exynos mailbox driver. Samsung Exynos platforms implement ACPM to
provide support for PMIC, clock frequency scaling, clock configuration
and temperature sensors.

Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 arch/arm64/configs/defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index c62831e61586..91139b1cf813 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -262,6 +262,7 @@ CONFIG_IMX_SCU=y
 CONFIG_QCOM_TZMEM_MODE_SHMBRIDGE=y
 CONFIG_QCOM_QSEECOM=y
 CONFIG_QCOM_QSEECOM_UEFISECAPP=y
+CONFIG_EXYNOS_ACPM_PROTOCOL=m
 CONFIG_GNSS=m
 CONFIG_GNSS_MTK_SERIAL=m
 CONFIG_MTD=y
@@ -1378,6 +1379,7 @@ CONFIG_HWSPINLOCK_QCOM=y
 CONFIG_TEGRA186_TIMER=y
 CONFIG_RENESAS_OSTM=y
 CONFIG_ARM_MHU=y
+CONFIG_EXYNOS_MBOX=m
 CONFIG_IMX_MBOX=y
 CONFIG_OMAP2PLUS_MBOX=m
 CONFIG_PLATFORM_MHU=y

-- 
2.47.0.338.g60cca15819-goog


