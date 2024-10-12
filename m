Return-Path: <linux-kernel+bounces-362492-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 48AB499B594
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 16:40:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F37FC1F21BF6
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 14:40:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4630199934;
	Sat, 12 Oct 2024 14:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="uHURsS6v"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ABB5195F17
	for <linux-kernel@vger.kernel.org>; Sat, 12 Oct 2024 14:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728744024; cv=none; b=Nob56UrYb4Fx6MLR8npPRThD87CXG3a5HfJEMUapSCdVwnjOnG7dFtVN9loLMA0zgz2OkbBQVDN47hWXkH442Sn9+3R27FmI5Fb7+vq7s2xSUFh5H1JpJI/u7TbURKhIqBbE78HtkfxcRMtQg/Iu8PvX43Ig8or53kcZFCwtXAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728744024; c=relaxed/simple;
	bh=raNMV7XctJIbSEmg1aR+IsRod9wfbi2q0jEtotc1h3A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Icup92td+SPoeKlFZ/u9UFdsGy71TRGzbv+YauI9d25Zy7MQ4kAsea62eNCtVDhc4lqk8JfHy4wB3CqJ+RnQnRd7eQ9M7SNQwUx9509Cdt8f5vHSvUBd0WjN7nMv2nwHOej6HmNiu/x/lhYjFJagV8GbLfcsbpaCr+7F0lgUKRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=uHURsS6v; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a99f1fd20c4so59743166b.0
        for <linux-kernel@vger.kernel.org>; Sat, 12 Oct 2024 07:40:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1728744021; x=1729348821; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ULCkiQ8VoXo6ciE6Elqk4HCN1p6ytUWA5waL2W1UArY=;
        b=uHURsS6v2tEGk+6UMqxWafuAshLNmmtAQevKrUrrSQ8uN/tztD6rK77VtEiuhmDI+P
         fZpyWj2skQjN0xS4AkEzkO22qffNt449sSXWSuBC3vUCSktSA7NSTSLsTCaKu0/biwwK
         zARWQIjeg53jIQkUeDHKwecPjKKw6Qx1+Rk1Aeg4zLDHSdnZVaCaiBe60wH//D0bmUOm
         zgMH7lZHZid97xBmFuC6II1eE6JSA80wlI3sZttNYnGJdkKzeO17SxsdMNIWX4wmc3q4
         9CeQW/eIhVt2xpakzThVGHvk7mjrbYk70N8795m4jTqkBVk+X2tkPlMCQIAGue35Tpei
         jqrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728744021; x=1729348821;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ULCkiQ8VoXo6ciE6Elqk4HCN1p6ytUWA5waL2W1UArY=;
        b=VqhnYlKEFv5JmcJWE300krzgRswRrYBpwKHaTJN0qb3ehffEwufAE91pCHSNKiXQs8
         aeMizpWqhZk31uZ7tKdmwuRF0CZpTZVzkfp9nrwQxlmgtVQmzeihhjRPwYjZnKKIywhx
         Wo2SRZMnqdVgYVzo67Fac8RLn5UFQnwG7yK4VlmZlXz3D9n4RI9GeKkqoMTQU8dizz9E
         JudmUiR9/J9a6D80teqTPEANIzE2lwSm1lMeB5StYQgq8QT1wKZBH3Jf63yiW5sHgiFW
         aD/zz9L6vvBS7MpJ3CIbk65v+NBbGEcX0WYFWgfab2AeI2ohfyUZSoYzEiW94E8AmpZ9
         JJlQ==
X-Forwarded-Encrypted: i=1; AJvYcCUSwit8U4wQxgcOLO9Yr0W0t5np/dPd9cb9aG614VqSu9htEUGunMsN7neC+tIkK3x18+oyec1pyVqxCYw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3/UZ+d0VpiOhWH6l9VI7B2m3KxaUsIBQq4zXFbcd+Lzh9pC5B
	LgvzljGm3vwt0MRmZfr/iDq2a6SnazFqommajsYwsJrPKg3vuxVE0wtvsXinZhc=
X-Google-Smtp-Source: AGHT+IGWlpkwYPvczR/HmMNrTZLwB3u77RjG+9e11crQIzq8pDrWM2fLtcRa72Csddc7F8rgokMxAA==
X-Received: by 2002:a17:907:9489:b0:a99:e98f:e73d with SMTP id a640c23a62f3a-a99e9900010mr139675266b.37.1728744020855;
        Sat, 12 Oct 2024 07:40:20 -0700 (PDT)
Received: from localhost ([2001:4090:a244:83ae:2517:2666:43c9:d0d3])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a99a80dcd55sm332162666b.173.2024.10.12.07.40.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Oct 2024 07:40:20 -0700 (PDT)
From: Markus Schneider-Pargmann <msp@baylibre.com>
Date: Sat, 12 Oct 2024 16:39:29 +0200
Subject: [PATCH v3 3/6] arm64: dts: ti: k3-pinctrl: Add WKUP_EN flag
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241012-topic-am62-partialio-v6-12-b4-v3-3-f7c6c2739681@baylibre.com>
References: <20241012-topic-am62-partialio-v6-12-b4-v3-0-f7c6c2739681@baylibre.com>
In-Reply-To: <20241012-topic-am62-partialio-v6-12-b4-v3-0-f7c6c2739681@baylibre.com>
To: Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>, 
 Santosh Shilimkar <ssantosh@kernel.org>, 
 Vignesh Raghavendra <vigneshr@ti.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Anand Gadiyar <gadiyar@ti.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, Vishal Mahaveer <vishalm@ti.com>, 
 Kevin Hilman <khilman@baylibre.com>, Dhruva Gole <d-gole@ti.com>, 
 Markus Schneider-Pargmann <msp@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1051; i=msp@baylibre.com;
 h=from:subject:message-id; bh=raNMV7XctJIbSEmg1aR+IsRod9wfbi2q0jEtotc1h3A=;
 b=owGbwMvMwCGm0rPl0RXRdfaMp9WSGNK5umxevT6yTL1ugqjsyZ/d/gXll499jDv17/NM91mRA
 g/81Q/v6ShlYRDjYJAVU2S5+2Hhuzq56wsi1j1yhJnDygQyhIGLUwAmciyI4b+Xjcjhd2Hbfn+Y
 YHWNQa/HelKKjP3cHhmW5P9ZJz6kbHvO8L+yxdmtIUVko07zn7THwmUHvl0PeBMcwM21vePLNi+
 zw3wA
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41

WKUP_EN is a flag to enable pin wakeup. Any activity will wakeup the SoC
in that case.

Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
---
 arch/arm64/boot/dts/ti/k3-pinctrl.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-pinctrl.h b/arch/arm64/boot/dts/ti/k3-pinctrl.h
index 22b8d73cfd3264735ddf91874e60a0c5fc7ade5b..dd4d53e8420a1d671e04a70d4af8b0ea1b75b2b2 100644
--- a/arch/arm64/boot/dts/ti/k3-pinctrl.h
+++ b/arch/arm64/boot/dts/ti/k3-pinctrl.h
@@ -12,6 +12,7 @@
 #define PULLTYPESEL_SHIFT	(17)
 #define RXACTIVE_SHIFT		(18)
 #define DEBOUNCE_SHIFT		(11)
+#define WKUP_EN_SHIFT		(29)
 
 #define PULL_DISABLE		(1 << PULLUDEN_SHIFT)
 #define PULL_ENABLE		(0 << PULLUDEN_SHIFT)
@@ -38,6 +39,8 @@
 #define PIN_DEBOUNCE_CONF5	(5 << DEBOUNCE_SHIFT)
 #define PIN_DEBOUNCE_CONF6	(6 << DEBOUNCE_SHIFT)
 
+#define WKUP_EN			(1 << WKUP_EN_SHIFT)
+
 /* Default mux configuration for gpio-ranges to use with pinctrl */
 #define PIN_GPIO_RANGE_IOPAD	(PIN_INPUT | 7)
 

-- 
2.45.2


