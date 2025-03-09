Return-Path: <linux-kernel+bounces-553321-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ABB8EA5876E
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 19:56:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E89B116A81D
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 18:56:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE5EF212FA9;
	Sun,  9 Mar 2025 18:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DBaHtTha"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BA18202C4C
	for <linux-kernel@vger.kernel.org>; Sun,  9 Mar 2025 18:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741546575; cv=none; b=g3lIfmuaY/YNH4oAqin1q1MGlxofS9QHkT6irkFRADkO0JujCTRO5GaJbjMUe9+VuSxEdCcq9inbpPvw/3m2F906b30adwCEd2cCw8l6w/lAGntxqeqmCnZ1hDHDKyAueBe3n79GNPkIRYFhQoGBjU7nCHok2cG9M8h3JJfK9Fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741546575; c=relaxed/simple;
	bh=uvZ2+a6S6JpYckvLd3vN4y/XaCLyyGT9gNpQQ8dNmeI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YLURa2LWOzpPy4DXqeESJRTVZ/VmItu6fohFihEcAMbUmFRi3Xw3Dsod/8ttorBgFdGHBd7wxXps3uqbhk9lKNfxGBf3WSg3+rYWop7K9Rg/R48Rnxf5AaPEdY5VdnfU3qui5klJfnGWf9/Id0kxgQhVvhrPlAjh2KfOevEFjiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DBaHtTha; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3912622c9c0so179735f8f.3
        for <linux-kernel@vger.kernel.org>; Sun, 09 Mar 2025 11:56:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741546572; x=1742151372; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MrmBWLsc0A2hxy4AAIuONWnJt2T5epZ91diVlTxUCPM=;
        b=DBaHtTha2b/oWM/5kev9UR3vSTFF7JN5KsUd+aOeu5Kh6l8CFDshFMMB/uVBYqcG/e
         EL8maSl4wz4adQgxLK0/n1X4EBpUSfyIRRiJHHGH3hY5al7zIkqrgFihNlpZoTwNxkLG
         +7gGfGHMzqq3L0E8Hw/TKr3bZuMPvuKax9qoOI6cvVcfaAFtWlqJ01CfYNOPrXaSEFWI
         rnr98X2PznkqveXqJELLbG3s28TcZVvOEcSjiBdEd2CnZGyQDvIGmtXXAwC/YHPGJbLM
         /0hOTnpSsuwcfh/1zTT4yUELdJnJBTmk/EmoKg+v3APt4xQ77awktHN0szbx6iT2btSt
         BxRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741546572; x=1742151372;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MrmBWLsc0A2hxy4AAIuONWnJt2T5epZ91diVlTxUCPM=;
        b=NIvDoTC7dXwLX0PGHzBOYbYSwqjjUScc67HuFDPmfv/dVpnIYOJP4AZ74kaUqKdgAS
         CQWWR6pBWE8DB34Os1x98Jh1WiRBOH/w2pDhdUADRh0+I05S/oj9Jz/clH145eYfWLik
         I+AW+WENv4c/kn0odLK1qXcn26gs7PimaGsAJJuhxJ171wRxdLv8iD7po7TfiBnRY1z4
         hRdTqjLdDRj56jkB3hqYp5Z8GRl7LVO+oFIKcwBiFy3Ozkxjg7UbuLiAhxf5DxNiZ9GZ
         YMoPdgG7MIVggCDgrccz4KwsvnIvI+KJ80oetdgoGtkjLxRXUPLlhTyzCM7o6szjb9Fg
         fhWw==
X-Forwarded-Encrypted: i=1; AJvYcCXJn8RIkA+JG6lpNVDKCgJU6+mEvA+Iv+9Z7UevMT6JE2Jypy9bXUac+9WguY7f58awNw9b1rs6+0pRoJc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4CH3DjdOCcU5go/MEkQJLuWvWUEsy0znQ/yEnxEuGGOf4sJws
	i2A/okdB2B59Pv1AFPcfSJIAWdR2C34+GGzdjnYiszyNJ7OCU/zt5ZvxcBTnteo=
X-Gm-Gg: ASbGncsbtKlVjpAUBPY5EgXyEDIFToaZBECOdRd5WsOVPsZt/qeiu+SquKYmKIvEYEb
	r5rOJ42I3FW9NA+MORx/X1xHNUzpBhGL7+DK2tBCF8YX9Gowb5amPGcnvXE+uEctWIPGuT3yf+m
	YatV573AiaTw7DoPmz9dcXJ28r9cvgMlqrPquyBw2ZaW9ZC08xm7NlDm3SPrACDQ4IKwdNoQHyK
	5LiHvkz12i3mGUumMQPkAvp8e3GAxZnTdpQkzl+jAisYeIesgqhuD6t+Noyd/Xl0mznT+soN/ZW
	7zmHpKrgiMRlwLqLUs9G2dqgfYpcoOqxWIwJauT8HFVQLGvm+g9gSQ3ZIqg=
X-Google-Smtp-Source: AGHT+IEKpRHbbGfEM98G+jT1dTf4FeQB+l3gBVL1qFl0csub7dukLp0ucTCxODN6l+bL/aW/iBduNQ==
X-Received: by 2002:a05:600c:5122:b0:43b:c0fa:f9e5 with SMTP id 5b1f17b1804b1-43ce6eb5ab2mr15192015e9.4.1741546571601;
        Sun, 09 Mar 2025 11:56:11 -0700 (PDT)
Received: from krzk-bin.. ([178.197.206.225])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43cee22c13fsm44263945e9.40.2025.03.09.11.56.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Mar 2025 11:56:11 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Arnd Bergmann <arnd@arndb.de>,
	soc@lists.linux.dev
Cc: Tudor Ambarus <tudor.ambarus@linaro.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Peter Griffin <peter.griffin@linaro.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [GIT PULL 4/4 PATCH] arm64: defconfig: enable ACPM protocol and Exynos mailbox
Date: Sun,  9 Mar 2025 19:55:58 +0100
Message-ID: <20250309185601.10616-4-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250309185601.10616-1-krzysztof.kozlowski@linaro.org>
References: <20250309185601.10616-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tudor Ambarus <tudor.ambarus@linaro.org>

Enable the Samsung Exynos ACPM protocol and its transport layer, the
Exynos mailbox driver. Samsung Exynos platforms implement ACPM to
provide support for PMIC, clock frequency scaling, clock configuration
and temperature sensors.

Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
Link: https://lore.kernel.org/r/20250207-gs101-acpm-dt-v4-4-230ba8663a2d@linaro.org
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/configs/defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index cb7da4415599..18f96796298c 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -264,6 +264,7 @@ CONFIG_IMX_SCU=y
 CONFIG_QCOM_TZMEM_MODE_SHMBRIDGE=y
 CONFIG_QCOM_QSEECOM=y
 CONFIG_QCOM_QSEECOM_UEFISECAPP=y
+CONFIG_EXYNOS_ACPM_PROTOCOL=m
 CONFIG_GNSS=m
 CONFIG_GNSS_MTK_SERIAL=m
 CONFIG_MTD=y
@@ -1403,6 +1404,7 @@ CONFIG_HWSPINLOCK_QCOM=y
 CONFIG_TEGRA186_TIMER=y
 CONFIG_RENESAS_OSTM=y
 CONFIG_ARM_MHU=y
+CONFIG_EXYNOS_MBOX=m
 CONFIG_IMX_MBOX=y
 CONFIG_OMAP2PLUS_MBOX=m
 CONFIG_PLATFORM_MHU=y
-- 
2.43.0


