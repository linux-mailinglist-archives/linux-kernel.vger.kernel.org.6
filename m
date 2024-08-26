Return-Path: <linux-kernel+bounces-301887-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 969D695F6E6
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 18:41:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA3731C20D55
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 16:41:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 042BC19754D;
	Mon, 26 Aug 2024 16:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fb3NRPUb"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7424D19539F;
	Mon, 26 Aug 2024 16:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724690391; cv=none; b=GoSljom0Cq1Tc/JreYq6KFvQYMAjBHWw2ske0PaGX7uTPugFlTmzocxBapZNMZLxnl50xft9+5CTM3KPu/V3A3tOMMFmuizRCQguxUW0Xite4Av229A+AG8rQ6zpmAHSiHij3KgasYfMWDwNWLQvdalNE433AG+RFzrlIW5GY54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724690391; c=relaxed/simple;
	bh=amzFsueMAjB/dtxA5/mHMWLcbBcsme8w4wvLbIqwftA=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=DmAJnWhb3W8hU4PTWyMEig9VfuMlHj8XnNv4Fi+PMQzDr6kojlJEVkmP2BXJZ19ucOGTig7Spk5iD5lHWJ1OfzEd1cYS8fpI4cgUfcJO+3Uqi+W+yrCvbt8hXPa5bz/q4YhXztZLv462Lt64SJHbt1C5nK7mg0mX2QihyNNqVZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fb3NRPUb; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a86a69bfcdaso14438566b.0;
        Mon, 26 Aug 2024 09:39:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724690388; x=1725295188; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xEBnzy+nuAfpfauBPCGu34CbakxHPVG1Dzjy87tNiYM=;
        b=Fb3NRPUbFYjTtS70SS9XVKjEXOwe1asf8461Nkn4NJJOimO/P1sHl8/RkmeuoprPzy
         mZXjb/dK152vxvDYdLyaXp/1s2V0j2g09FifUbnm8CtDzun4D+GLJi4S4bUsCjL5UCil
         v8Ntjp11w45MQw+Ko08kMjfJGC0tHDBEIx9NgmOHbYK0NNWxjO37DxwP7fHBdkMJG2oV
         COaGLi1IMZ76JUTZWYUG1nF1Yp7NaOGW9EuYG4IpiqqcazBUeXcwAELla3ll1Nu2VMz9
         OD2VHATQyrcW0DZ4QKbWSFl4+oFGlctkB7OGsL0BZaqRKkrM7tpFpL4fjDUuSEgWsSWV
         N9wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724690388; x=1725295188;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xEBnzy+nuAfpfauBPCGu34CbakxHPVG1Dzjy87tNiYM=;
        b=lP7vWRQshjDT0veYXQNZ3lofAZ5noU7f/Pqd8i936sWknYOM0UMdmKq2Sxl1y0IA55
         r7fPib31ndD4jy9OWgilmx9UEVDlXLPyPpLY25wVPlOu2iLZZZXWO5ao2q6H1p0YBoz0
         w+GflRWZ0mYYS+wGG84qiJzcr1XrBC3gVhcYk0F7dKCI4R8zwRciP5JC7bcMyMJKsJ20
         nKfW43Zqb+maq0RnsJmXBmu0Udd5Taw6q/ldRAb9/FbWnpuM+SjX7yJF1Kn3jY7errux
         CX9Z5CwSaO/YvFszNR0/9Q/iQcAEPatzNpl1TvhXoIUX2L5drfSBPowN1oco2FNAx5/c
         vUNw==
X-Forwarded-Encrypted: i=1; AJvYcCU50YbFn+cqP2o9DqdbsrKU4p1E/sZaC0/vauNCADQeyLJiul4eOYJoq34+ulOUesFuWk/3pdZPOQxcZfM+@vger.kernel.org, AJvYcCWVsr7DA5AErMLrPu01ZESYns7ytQDijYCxtHwDQo3C2MOt4LqY4CEjHSwuIIKfyyK/KqLE2lIQJgdS@vger.kernel.org, AJvYcCWWdkdDR9E+hyn/9UHJ0L6AKwOj2hySCl08aYJFtkvvlaUSOZYWnH5ZcUWUdnJWgoa0e6vU4LBWJpe1@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9/ewpfxuVX12AoE0j5yP3dNjD80dYwjTObdNXbTOf6hETAcPh
	D+onPmdpLfN7VosABrCe6fYWtlg4CVvrbzkyAOVuPk5P0L/92qpx
X-Google-Smtp-Source: AGHT+IHbARgAmNxg4Cbi+E0/YnVBks6tDcx14l7inz4Q0CkixJluT8YVLmjj50b/VKagIKSP8C8PsA==
X-Received: by 2002:a17:907:7e95:b0:a80:a193:a509 with SMTP id a640c23a62f3a-a86a5188f38mr526531166b.2.1724690387597;
        Mon, 26 Aug 2024 09:39:47 -0700 (PDT)
Received: from ?IPV6:2a02:a449:4071:1:32d0:42ff:fe10:6983? ([2a02:a449:4071:1:32d0:42ff:fe10:6983])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a868f47bedcsm695577866b.145.2024.08.26.09.39.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Aug 2024 09:39:47 -0700 (PDT)
Message-ID: <a3292ed0-3489-4887-8567-40ea4983c592@gmail.com>
Date: Mon, 26 Aug 2024 18:39:46 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v1 9/9] dt-bindings: clock: rockchip: remove CLK_NR_CLKS and
 CLKPMU_NR_CLKS
To: heiko@sntech.de
Cc: robh@kernel.org, conor+dt@kernel.org, krzk+dt@kernel.org,
 mturquette@baylibre.com, sboyd@kernel.org, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <416cdaf2-fef2-471d-a03a-837775d6e7dc@gmail.com>
Content-Language: en-US
In-Reply-To: <416cdaf2-fef2-471d-a03a-837775d6e7dc@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

CLK_NR_CLKS and CLKPMU_NR_CLKS should not be part of the binding.
Remove since the kernel code no longer uses it.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 include/dt-bindings/clock/px30-cru.h   | 4 ----
 include/dt-bindings/clock/rk3036-cru.h | 2 --
 include/dt-bindings/clock/rk3228-cru.h | 2 --
 include/dt-bindings/clock/rk3288-cru.h | 2 --
 include/dt-bindings/clock/rk3308-cru.h | 2 --
 include/dt-bindings/clock/rk3328-cru.h | 2 --
 include/dt-bindings/clock/rk3368-cru.h | 2 --
 include/dt-bindings/clock/rk3399-cru.h | 4 ----
 8 files changed, 20 deletions(-)

diff --git a/include/dt-bindings/clock/px30-cru.h b/include/dt-bindings/clock/px30-cru.h
index 5b1416fcde6f..a2abf1995c34 100644
--- a/include/dt-bindings/clock/px30-cru.h
+++ b/include/dt-bindings/clock/px30-cru.h
@@ -175,8 +175,6 @@
 #define PCLK_CIF		352
 #define PCLK_OTP_PHY		353

-#define CLK_NR_CLKS		(PCLK_OTP_PHY + 1)
-
 /* pmu-clocks indices */

 #define PLL_GPLL		1
@@ -195,8 +193,6 @@
 #define PCLK_GPIO0_PMU		20
 #define PCLK_UART0_PMU		21

-#define CLKPMU_NR_CLKS		(PCLK_UART0_PMU + 1)
-
 /* soft-reset indices */
 #define SRST_CORE0_PO		0
 #define SRST_CORE1_PO		1
diff --git a/include/dt-bindings/clock/rk3036-cru.h b/include/dt-bindings/clock/rk3036-cru.h
index a96a9870ad59..99cc617e1e54 100644
--- a/include/dt-bindings/clock/rk3036-cru.h
+++ b/include/dt-bindings/clock/rk3036-cru.h
@@ -94,8 +94,6 @@
 #define HCLK_CPU		477
 #define HCLK_PERI		478

-#define CLK_NR_CLKS		(HCLK_PERI + 1)
-
 /* soft-reset indices */
 #define SRST_CORE0		0
 #define SRST_CORE1		1
diff --git a/include/dt-bindings/clock/rk3228-cru.h b/include/dt-bindings/clock/rk3228-cru.h
index de550ea56eeb..138b6ce514dd 100644
--- a/include/dt-bindings/clock/rk3228-cru.h
+++ b/include/dt-bindings/clock/rk3228-cru.h
@@ -146,8 +146,6 @@
 #define HCLK_S_CRYPTO		477
 #define HCLK_PERI		478

-#define CLK_NR_CLKS		(HCLK_PERI + 1)
-
 /* soft-reset indices */
 #define SRST_CORE0_PO		0
 #define SRST_CORE1_PO		1
diff --git a/include/dt-bindings/clock/rk3288-cru.h b/include/dt-bindings/clock/rk3288-cru.h
index 33819acbfc56..c6034b01b050 100644
--- a/include/dt-bindings/clock/rk3288-cru.h
+++ b/include/dt-bindings/clock/rk3288-cru.h
@@ -195,8 +195,6 @@
 #define HCLK_CPU		477
 #define HCLK_PERI		478

-#define CLK_NR_CLKS		(HCLK_PERI + 1)
-
 /* soft-reset indices */
 #define SRST_CORE0		0
 #define SRST_CORE1		1
diff --git a/include/dt-bindings/clock/rk3308-cru.h b/include/dt-bindings/clock/rk3308-cru.h
index d97840f9ee2e..ce4cd72b9d3d 100644
--- a/include/dt-bindings/clock/rk3308-cru.h
+++ b/include/dt-bindings/clock/rk3308-cru.h
@@ -212,8 +212,6 @@
 #define PCLK_CAN		233
 #define PCLK_OWIRE		234

-#define CLK_NR_CLKS		(PCLK_OWIRE + 1)
-
 /* soft-reset indices */

 /* cru_softrst_con0 */
diff --git a/include/dt-bindings/clock/rk3328-cru.h b/include/dt-bindings/clock/rk3328-cru.h
index 555b4ff660ae..8885a2e98c65 100644
--- a/include/dt-bindings/clock/rk3328-cru.h
+++ b/include/dt-bindings/clock/rk3328-cru.h
@@ -201,8 +201,6 @@
 #define HCLK_RGA		340
 #define HCLK_HDCP		341

-#define CLK_NR_CLKS		(HCLK_HDCP + 1)
-
 /* soft-reset indices */
 #define SRST_CORE0_PO		0
 #define SRST_CORE1_PO		1
diff --git a/include/dt-bindings/clock/rk3368-cru.h b/include/dt-bindings/clock/rk3368-cru.h
index 83c72a163fd3..ebae3cbf8192 100644
--- a/include/dt-bindings/clock/rk3368-cru.h
+++ b/include/dt-bindings/clock/rk3368-cru.h
@@ -182,8 +182,6 @@
 #define HCLK_BUS		477
 #define HCLK_PERI		478

-#define CLK_NR_CLKS		(HCLK_PERI + 1)
-
 /* soft-reset indices */
 #define SRST_CORE_B0		0
 #define SRST_CORE_B1		1
diff --git a/include/dt-bindings/clock/rk3399-cru.h b/include/dt-bindings/clock/rk3399-cru.h
index 39169d94a44e..4c90c7703a83 100644
--- a/include/dt-bindings/clock/rk3399-cru.h
+++ b/include/dt-bindings/clock/rk3399-cru.h
@@ -335,8 +335,6 @@
 #define HCLK_SDIO_NOC			495
 #define HCLK_SDIOAUDIO_NOC		496

-#define CLK_NR_CLKS			(HCLK_SDIOAUDIO_NOC + 1)
-
 /* pmu-clocks indices */

 #define PLL_PPLL			1
@@ -378,8 +376,6 @@
 #define PCLK_INTR_ARB_PMU		49
 #define HCLK_NOC_PMU			50

-#define CLKPMU_NR_CLKS			(HCLK_NOC_PMU + 1)
-
 /* soft-reset indices */

 /* cru_softrst_con0 */
--
2.39.2


