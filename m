Return-Path: <linux-kernel+bounces-231407-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F759919865
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 21:43:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0D074B2185B
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 19:43:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 169EF192B88;
	Wed, 26 Jun 2024 19:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RqFF3BY8"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41C54192B64
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 19:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719430994; cv=none; b=RNwqDWLbWxzzBTpuC0DjHYpHl/B/tX2aozLZeZO8u2xLtgDC+BoNiQLxKIpTsjaYspxf8lwfx2oSdPR33BuWErE0bedpo8XA7WPqSsh1YC10z9FhHOeAHgfysbz38rtMToZwjMTHhfFRxKVQ6hN0EnnB5iLM1SVsj69yxMYXOaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719430994; c=relaxed/simple;
	bh=cSR0gYcxjPBmP6LYpUXWyVrCem1Nc/dEqwkoBvR6aRM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b3B8omD/gPCBnZJSNAgKL7cgzdX2W6Vv9MXkq0oJB3/kyiAqmapmRfhBZ8sqtSPI+TBBfBWCPN1UCq8mOEo82S5lzO+nEMD60zZaPHiGAWJnhmbpMn/MxmCxTOVSnnQxlllhIm1nZjOwTbqYl6KuO5CQWq1/mNpJJKG1zF0xwlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RqFF3BY8; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-424acfff613so13797435e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 12:43:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719430989; x=1720035789; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6B6zMz66mId752W71/Awh4RoZkm3MLOugnC6sEYYCNg=;
        b=RqFF3BY8hvS05OVOt1eDzYCLugrfFsKwbqWl7zV06OKnhPh5nSGckrfh4MgPSuy+Zf
         fiZc43dmgXfEx+TnCPTXLVM9mQlk3QN+HTcvXtGhl5Rv6qf9CVL9qg1vhuHixWw7wNR7
         Zs1MeJOy/0SlB2aX48KF+NprqpsywME3smMYLEXcegL/lsMKto81kUeHSzHYU2tAgUS1
         AARGiRqu0yApnnEns5LOLO+FkYirNEBvy4e74sgnImczvkbNf0RPXXnsWK3JEiUXi7SN
         rUNYEphPWI9dVY87ba+zB1xIsSYpVFxLNjaR/HTKREiRO9WfDL2CUa4nGrgRkZgx4zsX
         lDIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719430989; x=1720035789;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6B6zMz66mId752W71/Awh4RoZkm3MLOugnC6sEYYCNg=;
        b=tCq6vWktl9Vs1j9eYsYupRQ9eCGudCxJVt5x7ZX26Ul1oU2+m8UtmO/yfD7cpHWOay
         vHMVQT2GjTKc9p8QrB4W8o9izCLQxDpKhmUVZga/R+LUBJBHRt7+Fg0iLi7U6h1OpVlV
         86XgsyJBpbE9gwYEvfQCvCiZhF7OvrPAP9dB/nUoi41EvXvV38jRdMk5P3AuzN5iYzdQ
         y1q2tR8iu27VN/jNCd/z/f2Av8w4JSxeJ4bF5qVFJ76VFuqtEDclT7lFIxYRq8al1SW3
         PzZVwT3e5CACKFUB9yFoHtHvsR/z9buSubXsoCBiG+e9FgHWrWAwnD1iFsLvBpjFRQ5U
         CMJg==
X-Forwarded-Encrypted: i=1; AJvYcCWlmDV+xhI4AzXyfTW9/LU3jbZnM83lnsCkPPw32Pa2d6qArEn1hGfyN0TDntRYQDBcQmdM8hIIi6lqGSuhy/wjApJyfsSfSoqhAUkl
X-Gm-Message-State: AOJu0YxV+y0NDxrE1rRFQK3bw06EijYwXcu0sQftjOqkvBhOcb6Eh2LB
	3z0NfJggq1xy4KZxzxUe7wshgbhgy783jMcEYmKxB1Eyupfcj5W0saYhYlhdT9A=
X-Google-Smtp-Source: AGHT+IHE/9FMLNxeq1ujy3GK1f/VeuXsMI30Klw5I97NuBAg2W8K6Jh0ubTi20bQaUpHSFcBiirkNw==
X-Received: by 2002:a05:600c:43d4:b0:424:a4a2:9478 with SMTP id 5b1f17b1804b1-424a4a294cemr41167465e9.25.1719430989622;
        Wed, 26 Jun 2024 12:43:09 -0700 (PDT)
Received: from gpeter-l.lan ([2a0d:3344:2e8:8510:24d9:a20a:2de5:8eda])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-424c837eb2bsm36728905e9.39.2024.06.26.12.43.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jun 2024 12:43:08 -0700 (PDT)
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
Subject: [PATCH 1/3] arm64: dts: exynos: gs101: add syscon-poweroff and syscon-reboot nodes
Date: Wed, 26 Jun 2024 20:42:58 +0100
Message-ID: <20240626194300.302327-2-peter.griffin@linaro.org>
X-Mailer: git-send-email 2.45.2.741.gdbec12cfda-goog
In-Reply-To: <20240626194300.302327-1-peter.griffin@linaro.org>
References: <20240626194300.302327-1-peter.griffin@linaro.org>
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

Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
---
This feature has a runtime dependency on the following series
https://lore.kernel.org/linux-arm-kernel/20240621115544.1655458-1-peter.griffin@linaro.org/
and also the exynos-pmu and clk-gs101 patches in this series to be functional.
---
 arch/arm64/boot/dts/exynos/google/gs101.dtsi | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm64/boot/dts/exynos/google/gs101.dtsi b/arch/arm64/boot/dts/exynos/google/gs101.dtsi
index a66e996666b8..ce24b80985a2 100644
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
2.45.2.741.gdbec12cfda-goog


