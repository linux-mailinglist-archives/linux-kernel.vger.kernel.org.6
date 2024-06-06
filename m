Return-Path: <linux-kernel+bounces-203874-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05EA28FE17F
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 10:49:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E99131C2350C
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 08:49:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7157813F422;
	Thu,  6 Jun 2024 08:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HMI+taXL"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DDBC13DB8D
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 08:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717663705; cv=none; b=c//LD28bVVch1fbfJ96eI3RBioMW27fqT9XRVFyLwKP6u3R/nGoV3C94q9oqPfSTuJWb4Od2FpcWinnJqxL7vwvo9s8ln+63fY5+ELZT+oDwq5+KlgJcLLm5YsIvTSWO0c2OxFoJJC+6OeKlcBJM2o2D7BGPWlHPoOZeQD73YAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717663705; c=relaxed/simple;
	bh=QM5KvwfkUBuCDEX5LFM5kIWXkN8IDPDmIiueKWnAI5s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AATLJ9oX0njLGjTlN3LZyJmgU8JgRSdS5kyvHdrQAvG+b0k/Mk53rFhiM4woT5qA+2lMokR04Z2ge6C+bv2vzspD7n2bBnSvG+ay6+pkNZp1lquhjUr32vBI+i4AIYcNWSrUS8JSEmjOK/qkKuKxA6fV7BvSOmOKULZJflLi96g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HMI+taXL; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-42160f2dc32so120445e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2024 01:48:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717663702; x=1718268502; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uLN9fK/Q1IJ4qkUSkkhIFN2WinWIfdWij0oNshXV/Tg=;
        b=HMI+taXLJ6EPgMrb47RTDf/u0moHsUrFZrVHYboKK8jq7zLEGdTB/UZhqpamsSq97d
         RLH5/Z/Y3i6HTPtwturux1KrGXB/UySqktvVw09Xo1c+2HvGNOkNjM8xP3LypRfoZJdc
         LccwI8GfB0nBsVzc3Ye+l0iy9dADTy11Jg54YOB+b2IA1QnNld2aNblZ6NrROmveZoJV
         mPmQATF6CO8B3niaMKa45qcyefX6eHcwDpY9yQexK7PcobROJ11tlWTS7J5Ps/E6bIsf
         x/DrGlAnVH0zMEI3EhLmJWyBRb8bcguN0AlSThHj0gKHiF4kWnQ+0/WDfJQ+/0UL0He9
         Ua+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717663702; x=1718268502;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uLN9fK/Q1IJ4qkUSkkhIFN2WinWIfdWij0oNshXV/Tg=;
        b=loDsBOlVR9VNx5J4evJxMtqzvBB/KC7WUeQiNE9DE4RVsAhdvI1XG4grqz+T2VZqEP
         m4QFF6qKMhnkjsQGfXotgtDptoHOgO+9Q1XAhMsuGDfjbWQLq7rK0ourfQjXdIEhk2uZ
         hfoueJu1zmDyRcyaLXtvqLYDBptAkWM2gsdnt7iCvsIZNQYuqnPIqPbG36zpwokupJjp
         wgBDuVdmuVxR5gw6B7zOcmfIO8wJXBKJLeg8iAcV/UdN8fJXgBuB9sWTaYoakIaO4E+c
         UzzuIUPX30+b2RuXwXcPB11P3QydIanoroNQkmBdq/6yzZ3zICTfLNcGqRfm4DSzy5yJ
         6Ing==
X-Forwarded-Encrypted: i=1; AJvYcCUrYhKPsHRlb7W3HSS31iUsvOnm2xbb2r8BLoBGwRWHzHkSCJnbD35zzNLmDiKRutmUcDbftb2oU67n8a/QHrkOeAiCl38aE03PiAqu
X-Gm-Message-State: AOJu0YxD6TRS3Mz0PUIP7E8DLfd2zmatb8tkCubO1c5PcXsOjxm6ZHSV
	NGdW6wdaN2+BVX0RpYSinmsmzy3W3YVHsnMh93VC7/UD7attg9MFGawOdADfVnGSbNU+e8/xSLX
	Z
X-Google-Smtp-Source: AGHT+IGSktBg3igi8GWb9dMcYgXr4zEw/a/r8SvoK8C+S3AVdKHbOjSJxzo4An/FUE+mEFAirB1IAw==
X-Received: by 2002:a05:600c:1f93:b0:421:b79:93fd with SMTP id 5b1f17b1804b1-421562e7053mr41861205e9.21.1717663701851;
        Thu, 06 Jun 2024 01:48:21 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4215c2c690dsm14227445e9.34.2024.06.06.01.48.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jun 2024 01:48:21 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Thu, 06 Jun 2024 10:48:14 +0200
Subject: [PATCH 07/12] arm64: dts: amlogic: g12a-u200: add missing
 AVDD-supply to acodec
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240606-topic-amlogic-upstream-bindings-fixes-dts-v1-7-62e812729541@linaro.org>
References: <20240606-topic-amlogic-upstream-bindings-fixes-dts-v1-0-62e812729541@linaro.org>
In-Reply-To: <20240606-topic-amlogic-upstream-bindings-fixes-dts-v1-0-62e812729541@linaro.org>
To: Kevin Hilman <khilman@baylibre.com>, 
 Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=632;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=QM5KvwfkUBuCDEX5LFM5kIWXkN8IDPDmIiueKWnAI5s=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBmYXfMvEjLwITtzgzOM1XlPBOixFpTSMM8sfqbyqdF
 jR8DHTSJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZmF3zAAKCRB33NvayMhJ0Z/0D/
 0bRThBlCqq1W0Khr0Zfszttq737tMTpibC2xEl0q2XEFXFkrAaBCa8Zwl8TWdE0Xqb/xuP1IXUFs/3
 pXnRqbQU8sdjX2t/kSCFK+mTC8wh0hO0aeJS1ZICcTyJB84VFBN6Rr0rK3bfXHJEZ041r4m25gRmXn
 ZnYCO165uSStzXf2YCZr+aKjWI8M0nA03xQGKo+98t5IlK3+05GeTvWm0+2ec6eXWcNYEgUwmRsu44
 1OawnEzUKdYmsuRqFVNDR6TMIH4NpGirQmXU2Tci8wUEB7062XLYEyz63r77f46ED6i5w94S90ef4d
 UhTpSZYQX0Py0VsMu8kg1h+uDI2+jLQz10L3a8C0NE+v11Wy0kq6lSOprWFZboK0g0FP0YffEW3IZ1
 ruDJQm6B0bjYwavT+yDWItMCLy61OJWbCTgS5lH/EESO1ZYWAJrPvmOO2onkNyHPmhuYa0p988Omi3
 bCJqx7hcNcVsvGaRbs2obDkfnHhN1Yodh3KnjcsrH1p3PEvMfcW/MUW9yThsoyxldfdfrk0RB9hUgB
 6kTY4auJ4Wr9VC5S5rr1jj9u6glDRJ5tbv4I9jW/BbAQyGRr+i26KBYlo6zoVazkR7GBHWCfT9BoqP
 a6LLIe9yfEqabV1Mx/R+zMwKyP+LA8CBKXVfipCS9x8IjYhE23UKrKax6WWQ==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

This fixes the following:
audio-controller@32000: 'AVDD-supply' is a required property

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 arch/arm64/boot/dts/amlogic/meson-g12a-u200.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12a-u200.dts b/arch/arm64/boot/dts/amlogic/meson-g12a-u200.dts
index e0f15d824249..7560e471c56e 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12a-u200.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-g12a-u200.dts
@@ -365,6 +365,7 @@ codec {
 };
 
 &acodec {
+	AVDD-supply = <&vddao_1v8>;
 	status = "okay";
 };
 

-- 
2.34.1


