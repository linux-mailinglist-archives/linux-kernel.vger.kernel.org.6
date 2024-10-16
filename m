Return-Path: <linux-kernel+bounces-367720-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 578FD9A05CE
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 11:41:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18102286194
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 09:41:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ADEB206068;
	Wed, 16 Oct 2024 09:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="iEWdKaOJ"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F34502038A4
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 09:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729071693; cv=none; b=qCNVpeVdFdqCXfFUCafke1YwSqunQHvssx3m9kU00+Okb3Mfy7FhHVqS6MDmDtaAqjyVHfJtqya/PyjUW+AaHlOxJwesawfbXgAwPMjfV8UxzI0bcWULg7J/5RvmiMJx+r7R3oeLr77QjYAM6TH/hU4XE3pSAijLrXO27bYpubU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729071693; c=relaxed/simple;
	bh=3MQEJC8kUuER8WEddRsKIJSrVNbnBBkYTor5eJpk+x0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pHb7C1NqXukPs7yL+dhgnqmKKnYzOLoCmjd8OBY1LePqNa57HKX3pzutsUjX/77A8QZPoYP5+28NAqdeCwC7/UBvmNoWvABCfoLXqIId3FlTVPCgFRugCKSYb/DV64KPP3t5H5sv1dOsAu6/nD5cLKPf/V8HHTxKoCLs04LCg9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=iEWdKaOJ; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4311ae6426aso43503195e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 02:41:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1729071690; x=1729676490; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=riDwr2JJEmNVTbyqdrMB0sCoh2/8iNo6TFpm2lok36g=;
        b=iEWdKaOJ6iuPh6Wt9je2loRr1pC2yBJn4mDzzth7w+LRVcTHu6EndWUjdg21c/5Y20
         LeQBJlTTf/yBntS0++MXke2gmDbqbojGmmd4w69klHcDVO2lJDDaqo/TjLNsWsuEqd2B
         mUbPho828tSqLmMWV0Jmr4s3P9YcpO9OtxeqqoboQMsNRqSRpA3wW+KrCgTh8hhGxJZO
         mpaz7ayja6V8CTZrTWefpT66XW3nw2I17E3z12AEA1I5YMHzLgMiOmNtfftcsXRt9srq
         3+An3eukJlA5hYShVsMWbE+mgnjmwaIxwFFCp3n8cguuUyzImKw1iKuyWJfiMAYNoXif
         k1kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729071690; x=1729676490;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=riDwr2JJEmNVTbyqdrMB0sCoh2/8iNo6TFpm2lok36g=;
        b=fshsgJlKP7igQUTC0uJ4ljd0u42EPavJy1Tzw1lg8WdUD5NwqLVBG6PmtUW2ggBBHu
         GRuRfg3nTYEwybkOue7NyIfOYIBG5GzxN6qDSEhPEP0gpXVeatQ3xk2FCV4AK9wLM/Km
         6VrvjbRGOOu5a6HSuZEPOZX8uuxJG1k44kL9EXc1M6dDgbEgh/wahfDCq54UAQpmojPi
         I8kJwLURUIUOwypGqF7NIe+J2dwf8r2O3KNm/cdAL8ICSkUXDHYbuREVPu6yTtLI7O6t
         7NmM3lDcH8wUBD2OmabzYXlQrEJpwBANFZ/MvAWzGwoBykleJTUkL+DVWAM211rMk9ml
         O6/w==
X-Forwarded-Encrypted: i=1; AJvYcCWNWfRw0btGDV/rz0hdJLLoMB42UAhHl368Q56iqM+3p2deW94pQvAiUhOBP8imVUS/U4lJbWFffX73XB8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwG2dFk5T8hCA2d8JavYjtyUuqFySbeDt3booausMXT2me4S32f
	B+vJd9QNYzc2BmFztxYWS+OqXH0SmQchd+g4jVQyhciYAbR7WC8p/VxFJDrgEzLVb1vZKLGXufC
	8
X-Google-Smtp-Source: AGHT+IHY1BwsiWUW9BTJw3ej/32B3c8IScpK2B6P5JrV+KdWHB8+oQRtl4NPq964yjdwwEBMyp1RjQ==
X-Received: by 2002:a05:600c:3ca3:b0:42c:de2f:da27 with SMTP id 5b1f17b1804b1-4314a285160mr27627415e9.2.1729071690002;
        Wed, 16 Oct 2024 02:41:30 -0700 (PDT)
Received: from [127.0.1.1] ([2a05:6e02:10a5:e010:472a:1760:2b0d:11e9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4313f56998fsm43654735e9.16.2024.10.16.02.41.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2024 02:41:29 -0700 (PDT)
From: Guillaume La Roque <glaroque@baylibre.com>
Date: Wed, 16 Oct 2024 11:41:10 +0200
Subject: [PATCH v3 2/2] irqchip: Kconfig: Added module build support for
 the TI interrupt aggregator
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241016-timodules-v3-2-fa71091ade98@baylibre.com>
References: <20241016-timodules-v3-0-fa71091ade98@baylibre.com>
In-Reply-To: <20241016-timodules-v3-0-fa71091ade98@baylibre.com>
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
 Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>, 
 Santosh Shilimkar <ssantosh@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 vishalm@ti.com, Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Kevin Hilman <khilman@baylibre.com>, 
 Guillaume La Roque <glaroque@baylibre.com>, 
 Nicolas Frayer <nfrayer@baylibre.com>
X-Mailer: b4 0.14.1

From: Nicolas Frayer <nfrayer@baylibre.com>

Added module build support in Kconfig for the TI SCI interrupt aggregator
driver. The driver's default build is built-in and it also depends on
ARCH_K3 as the driver uses some 64 bit ops and should only be built
for 64 bit platforms.

Signed-off-by: Nicolas Frayer <nfrayer@baylibre.com>
Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>
---
 arch/arm64/Kconfig.platforms      | 1 -
 drivers/irqchip/Kconfig           | 5 +++--
 drivers/irqchip/irq-ti-sci-inta.c | 1 +
 3 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index 393845a3ae5c..9dea47decfbd 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -135,7 +135,6 @@ config ARCH_K3
 	select SOC_TI
 	select TI_MESSAGE_MANAGER
 	select TI_SCI_PROTOCOL
-	select TI_SCI_INTA_IRQCHIP
 	select TI_K3_SOCINFO
 	help
 	  This enables support for Texas Instruments' K3 multicore SoC
diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index a958731404e9..9646322345e4 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -544,10 +544,11 @@ config TI_SCI_INTR_IRQCHIP
 	  TI System Controller, say Y here. Otherwise, say N.
 
 config TI_SCI_INTA_IRQCHIP
-	bool
-	depends on TI_SCI_PROTOCOL
+	tristate "TI SCI INTA Interrupt Controller"
+	depends on ARCH_K3 && TI_SCI_PROTOCOL
 	select IRQ_DOMAIN_HIERARCHY
 	select TI_SCI_INTA_MSI_DOMAIN
+	default ARCH_K3
 	help
 	  This enables the irqchip driver support for K3 Interrupt aggregator
 	  over TI System Control Interface available on some new TI's SoCs.
diff --git a/drivers/irqchip/irq-ti-sci-inta.c b/drivers/irqchip/irq-ti-sci-inta.c
index b83f5cbab123..a887efba262c 100644
--- a/drivers/irqchip/irq-ti-sci-inta.c
+++ b/drivers/irqchip/irq-ti-sci-inta.c
@@ -743,3 +743,4 @@ module_platform_driver(ti_sci_inta_irq_domain_driver);
 
 MODULE_AUTHOR("Lokesh Vutla <lokeshvutla@ti.com>");
 MODULE_DESCRIPTION("K3 Interrupt Aggregator driver over TI SCI protocol");
+MODULE_LICENSE("GPL");

-- 
2.34.1


