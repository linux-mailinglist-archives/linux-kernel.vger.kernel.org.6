Return-Path: <linux-kernel+bounces-234659-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D9A3691C92E
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jun 2024 00:36:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 923F41F23E27
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 22:36:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2EC6136657;
	Fri, 28 Jun 2024 22:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mu9hOjdc"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCBE784DF8
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 22:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719614116; cv=none; b=YCL4no/ZQW6QLAJl/BAC32DJ3R+aQoHad8Qued+N2NUpWPkX4Lo++WMJBZDqILu16WgRng5sVrcqtR6VWmihEDVblFeBzqmOirMFFadVhs0Pwi5Dqpzo2tbE5jSCLlMlEavTq1Q3FaUDyZ/f0bsUcyaFll0/VPgNBoHk2/kepvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719614116; c=relaxed/simple;
	bh=KrvJFYN8v4/xFwPigPfwPOs0JB7ddf5NqDv1x7gWjlY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LyFUQbRM3eEduxODcXk2YcScPwYoHrrj3cQ4odW0l6ILJexiwGuYLpHkPSekGRoX4cscEEAEZhnnY/9szAqPgKQ2Tnh2n++G4qPOX2keWRNrrkHupsJkMbXBxcUJtgKHaxp8GLTscDoE1j6DJTqMKC08cS7lucpXeFzIPegxaHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mu9hOjdc; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4255fc43f1cso7827205e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 15:35:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719614112; x=1720218912; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A+35USzVPil6wRdDqJfS7dElyhUMtDCnmyu7VzjnW14=;
        b=mu9hOjdcOFuwenrHEr8hGVnVdck5Hnx74RLzInaQigVXLojCv1NqWh2nxdnHN3HzVs
         8qu2g1xqqD0os4qMocE1BuBRf4SWPKxUKpz38MJe6TWXVHPUmj7LAy6NekOAkVyiEzNa
         6F9CnfwBobyNbC6ySrYZd4PNmYMJDpeOol9yScJ9nDqUDEVa32WTXWRs+gAWvglFUWaY
         HgJPw9zyYg/2o99rcOdHhu5p8F2Vxu1AGn4iOh19qWZMco21LL6v7xzJcSL+G6JUfY4z
         BAZ+4KUpKfKCWINXMfXhn73PZh82LRTjHiiwYBLSHwEELSMDOW49RIpXLs6Eg6IZxrpB
         GrkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719614112; x=1720218912;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A+35USzVPil6wRdDqJfS7dElyhUMtDCnmyu7VzjnW14=;
        b=FuL1cm7yJ7FDj35Ce7YaM8APsGBq/B6dV2vmfr9DVqhhBl/J2my5mKqWWQ/K5Wgn62
         4LH2lxdxn0T4D46SXYee1YakjYdghnezPeYsQ3ek9Ens979TYp5dt/8kJX3/iqNATM6R
         D5sxbLgegA9l8iZhbrCIYurr61vOJNJZ4noSxtu3hW1Y9OICaREitD1DhLwRu80DqrjJ
         bI+WYrT9H5Cnsig8B2OvfPhSdDXFIPcZDQUY3cjEizvF7pU/VlkmE8SFO+k1NCs/FmjX
         TJ3B6EmRkTFDIKYFIFmJ2tS7hN6UWtCzV1lDxnT3Kg7YVj2gSuvqje1PZEynKUFokNnr
         QYAQ==
X-Forwarded-Encrypted: i=1; AJvYcCWAGZ2O9eo51PifrCSUYXSaYOO+x8mh/u7WX0+6kE2i0wk2vbZaEMx4HrnyaDwCLpCTts1o4AAYNBREYBPEI+/JfPZ+K8xV+1GWzZMp
X-Gm-Message-State: AOJu0Yzc5Pyb/vIj2vi2AQdKK6GYmNWorvGbsww+rp76rhbmrdysnIsv
	aRA7WVK1dRBBg9uP8f6yFrvYIg99ls3QwbjOboRNNhFB3TLPcvhJPaDnzH1erZ4=
X-Google-Smtp-Source: AGHT+IHdEzPFhVw89GaUbW5G4V1JA1tDs48lY6DDMMJTJQZDmiE/0Eu93AHY5VhEgJDeQnT0q07IDA==
X-Received: by 2002:a05:600c:4994:b0:425:5f6d:2f3c with SMTP id 5b1f17b1804b1-4255f6d32cfmr59547625e9.39.1719614112249;
        Fri, 28 Jun 2024 15:35:12 -0700 (PDT)
Received: from gpeter-l.lan ([2a0d:3344:2e8:8510::3aa])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3675a043a16sm3496711f8f.0.2024.06.28.15.35.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jun 2024 15:35:11 -0700 (PDT)
From: Peter Griffin <peter.griffin@linaro.org>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	alim.akhtar@samsung.com,
	s.nawrocki@samsung.com,
	cw00.choi@samsung.com,
	mturquette@baylibre.com,
	sboyd@kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	tudor.ambarus@linaro.org,
	andre.draszik@linaro.org,
	kernel-team@android.com,
	willmcvicker@google.com,
	devicetree@vger.kernel.org,
	linux-clk@vger.kernel.org,
	Peter Griffin <peter.griffin@linaro.org>
Subject: [PATCH v2 1/3] arm64: dts: exynos: gs101: add syscon-poweroff and syscon-reboot nodes
Date: Fri, 28 Jun 2024 23:35:04 +0100
Message-ID: <20240628223506.1237523-3-peter.griffin@linaro.org>
X-Mailer: git-send-email 2.45.2.803.g4e1b14247a-goog
In-Reply-To: <20240628223506.1237523-1-peter.griffin@linaro.org>
References: <20240628223506.1237523-1-peter.griffin@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Reboot of gs101 SoC can be handled by setting the
bit(SWRESET_SYSTEM[1]) of SYSTEM_CONFIGURATION register(PMU + 0x3a00).

Poweroff of gs101 SoC can be handled by setting bit(DATA[8]) of
PAD_CTRL_PWR_HOLD register (PMU + 0x3e9c).

Tested using "reboot" and "poweroff -p" commands.

Tested-by: Will McVicker <willmcvicker@google.com>
Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
---
 arch/arm64/boot/dts/exynos/google/gs101.dtsi | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm64/boot/dts/exynos/google/gs101.dtsi b/arch/arm64/boot/dts/exynos/google/gs101.dtsi
index eadb8822e6d4..302c5beb224a 100644
--- a/arch/arm64/boot/dts/exynos/google/gs101.dtsi
+++ b/arch/arm64/boot/dts/exynos/google/gs101.dtsi
@@ -1394,6 +1394,21 @@ sysreg_apm: syscon@174204e0 {
 		pmu_system_controller: system-controller@17460000 {
 			compatible = "google,gs101-pmu", "syscon";
 			reg = <0x17460000 0x10000>;
+
+			poweroff: syscon-poweroff {
+				compatible = "syscon-poweroff";
+				regmap = <&pmu_system_controller>;
+				offset = <0x3e9c>; /* PAD_CTRL_PWR_HOLD */
+				mask = <0x100>; /* reset value */
+			};
+
+			reboot: syscon-reboot {
+				compatible = "syscon-reboot";
+				regmap = <&pmu_system_controller>;
+				offset = <0x3a00>; /* SYSTEM_CONFIGURATION */
+				mask = <0x2>; /* SWRESET_SYSTEM */
+				value = <0x2>; /* reset value */
+			};
 		};
 
 		pinctrl_gpio_alive: pinctrl@174d0000 {
-- 
2.45.2.803.g4e1b14247a-goog


