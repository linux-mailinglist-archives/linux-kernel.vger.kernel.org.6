Return-Path: <linux-kernel+bounces-563112-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EAF2A63718
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Mar 2025 19:58:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDD213AD06E
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Mar 2025 18:57:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F8D2202C48;
	Sun, 16 Mar 2025 18:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K+7P6+7z"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D43E1F9A8B;
	Sun, 16 Mar 2025 18:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742151414; cv=none; b=KGYAEOzmJ7HTDKhm4z3hmtOwARF6ecoTx2eHUEqRYAjIaYyOFVkvbz2cAsG8/GPRPuBvl4QZMHX+TzuYMAM+zqsWJbPC9t7N9Ql/PxNEe1dJssOAX9rV51XJHJ3z/wJ0n2p7szCvxzNMdW4GE1SJUQ9WVMZO/CICoV3iH5HtY4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742151414; c=relaxed/simple;
	bh=aghljR1wM2BDQQZuPDhqoTtY/vyWZD8fyPWNjyzLVSk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tQTCSDw8w/+YviaHNXLHR8iDfswHKJa9OhU8ZBCtpnaBf3GzW2WLdmh4lqPSXx88K1tfSPTspK6NK9V/VQ1StCiFw2uSwEahg6BHiSaZcb5rlCNt0Iici34onI/0nMtZ+ytkfKR8hf7KLAFPmFvtA/rh5+eaD9EUM8o8DC7jxGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K+7P6+7z; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-43cfecdd8b2so10104885e9.2;
        Sun, 16 Mar 2025 11:56:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742151411; x=1742756211; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YKV+hWN9JpR1oWviShl5FW1hZNTpiT4lwbZMt2wB8jc=;
        b=K+7P6+7z8CxfZcd/jm/nRhA6xwOcNpuSXIsegWy/0PvBhVYPOaJVRF3Z6x6pgZciwq
         rlhQU90ZAcpSFX38YS+CBEr4mNDngWexemMw5fzGzB536tXG6sFWmL25lbiR4QnfhRug
         7f3XTVJ91oJ8RyW2jpwUOMbU3ZSSao5jULQNAIPdL2GRA0l9f4PosroVqj9Hv2R9gjfW
         SJUVrEV3vJ+VVBCfa+Ot2T282R3ADEhmX/vtyrVUODio18FzYQziuSQJ5hckbyccCBGV
         ZAgSX+UZa3ipvXGw7LmpwKYeKn3Gm2a2Zy/AzsPO+Br1PpE7aRgWQGFLacrDb4Gvf6hl
         fuMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742151411; x=1742756211;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YKV+hWN9JpR1oWviShl5FW1hZNTpiT4lwbZMt2wB8jc=;
        b=aQeR+MzioemwRw4NUNx9beAtCqpxaV6NCcsSYRtq3x8L5VdW+u9Xng54/FnZn0+QA6
         GQL4cubYFgRmSL2kikYGMUi4RIG+4D97X81TKYMqetVlyoryWEj5QMzfJJSCUfNiQCNm
         EEwuSALGdnJcLL6YjF3cNqEZrVzSXyZBBlnEjAj1OHjJ/F4TtScKZlb3Fe2C/vCgRh0p
         72QtmVTTke+9s4PiY4b3jmwZI4hZrf+zwCFsTR3AdDElTeLA+IttJpQGdhqIwRMEqwZY
         G5frw2JMCLN2Si1VFfeURT0MNkjmHhhyjzz1Qs19lSN+qaYpZxHr/4SFEDTZbxt3q7B8
         du4A==
X-Forwarded-Encrypted: i=1; AJvYcCVnS/GgJwHqLAsG2vKR2dHVSUMtF0e0wLxeswxgpCMq6+M4k9yJg2OOkBXI3WNzYDalI4QJQtanFwqR@vger.kernel.org, AJvYcCXNMlLtZF+xBAba3H1/0wrvuE2+sbc+JiDaFvE1oEcrF46d5Z18bZI/nQnTy+9YoTXG4zRWv94X4Ei+/il5@vger.kernel.org
X-Gm-Message-State: AOJu0YwU0NsgBTfSHIGNBp3oo76dVhnqbkJDPEWG40Ae3jZaRsCs3W+A
	Gg1wImEl+I5nV4mHDzHa/gCw0d/FSUMDSJeVjIy/KwNmjyQehn6L
X-Gm-Gg: ASbGncs7qL7ex6TVQJCd+t6nm9/Lq9rS0JRTjuXXWaMhthCt8BdB2atkFfvh5QXmMTK
	eHzxtHe7IXhYj8z4gws8vHgF3lZR2Lm89v1ZI8boYdflDZysM21BGhf2tZIRgYSfXS1d3czzQQ1
	FAxugR9jbKevhre1EmsvFCZMgZMBZ7brZVoxKGzUYX9DA58HxTuOlP3zuU5XxaftWs4Oz/qY03i
	6Aacjt4L8CrO3fa4siXE4SfIQhUfCnxt/ifzEc7PdL1b/2MHnvVWOJwsbTb+4r3BavGrlcU9H6c
	xeYQpPwZlGHn/6Aw/MDglKAuzFRHxnL4QykUArPS2W3P6JLUjKnifx1FdVhO0PNCd2uw
X-Google-Smtp-Source: AGHT+IHLZK3FCf/r7+5MKurX3pr5o4LJldkBwRRoPZ2/8ot7v5lwjboRWlnOjFSLvqToQ7g90WgAwg==
X-Received: by 2002:a05:600c:3399:b0:43d:2230:300f with SMTP id 5b1f17b1804b1-43d2230311bmr92200575e9.0.1742151410666;
        Sun, 16 Mar 2025 11:56:50 -0700 (PDT)
Received: from giga-mm.. ([2a02:1210:861b:6f00:82ee:73ff:feb8:99e3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d1ffb6292sm84692335e9.1.2025.03.16.11.56.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Mar 2025 11:56:50 -0700 (PDT)
From: Alexander Sverdlin <alexander.sverdlin@gmail.com>
To: sophgo@lists.linux.dev,
	soc@lists.linux.dev
Cc: Alexander Sverdlin <alexander.sverdlin@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen Wang <unicorn_wang@outlook.com>,
	Inochi Amaoto <inochiama@gmail.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Jisheng Zhang <jszhang@kernel.org>,
	Haylen Chu <heylenay@outlook.com>,
	Chao Wei <chao.wei@sophgo.com>,
	devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v5 7/7] arm64: defconfig: Enable rudimentary Sophgo SG2000 support
Date: Sun, 16 Mar 2025 19:56:37 +0100
Message-ID: <20250316185640.3750873-8-alexander.sverdlin@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250316185640.3750873-1-alexander.sverdlin@gmail.com>
References: <20250316185640.3750873-1-alexander.sverdlin@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Enable ARCH_SOPHGO, pinctrl (built-in, required to boot), ADC as module.
This defconfig is able to boot from SD card on Milk-V Duo Module 01
evalboard.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>
---
Changelog:
v5:
v4:
v3:
v2:
- moved CLK_SOPHGO_CV1800 from Kconfig.platforms here;

 arch/arm64/configs/defconfig | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index bde1287ad9a7..9c01f5333f0f 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -66,6 +66,7 @@ CONFIG_ARCH_RENESAS=y
 CONFIG_ARCH_ROCKCHIP=y
 CONFIG_ARCH_SEATTLE=y
 CONFIG_ARCH_INTEL_SOCFPGA=y
+CONFIG_ARCH_SOPHGO=y
 CONFIG_ARCH_STM32=y
 CONFIG_ARCH_SYNQUACER=y
 CONFIG_ARCH_TEGRA=y
@@ -652,6 +653,7 @@ CONFIG_PINCTRL_SM8450_LPASS_LPI=m
 CONFIG_PINCTRL_SC8280XP_LPASS_LPI=m
 CONFIG_PINCTRL_SM8550_LPASS_LPI=m
 CONFIG_PINCTRL_SM8650_LPASS_LPI=m
+CONFIG_PINCTRL_SOPHGO_SG2000=y
 CONFIG_GPIO_ALTERA=m
 CONFIG_GPIO_DAVINCI=y
 CONFIG_GPIO_DWAPB=y
@@ -1409,6 +1411,7 @@ CONFIG_QCOM_HFPLL=y
 CONFIG_CLK_GFM_LPASS_SM8250=m
 CONFIG_CLK_RCAR_USB2_CLOCK_SEL=y
 CONFIG_CLK_RENESAS_VBATTB=m
+CONFIG_CLK_SOPHGO_CV1800=y
 CONFIG_HWSPINLOCK=y
 CONFIG_HWSPINLOCK_QCOM=y
 CONFIG_TEGRA186_TIMER=y
@@ -1528,6 +1531,7 @@ CONFIG_QCOM_SPMI_VADC=m
 CONFIG_QCOM_SPMI_ADC5=m
 CONFIG_ROCKCHIP_SARADC=m
 CONFIG_RZG2L_ADC=m
+CONFIG_SOPHGO_CV1800B_ADC=m
 CONFIG_TI_ADS1015=m
 CONFIG_TI_AM335X_ADC=m
 CONFIG_IIO_CROS_EC_SENSORS_CORE=m
-- 
2.48.1


