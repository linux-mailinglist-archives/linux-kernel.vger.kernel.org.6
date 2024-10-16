Return-Path: <linux-kernel+bounces-367718-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FA949A05CD
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 11:41:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 376E0283F8A
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 09:41:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EE4D206046;
	Wed, 16 Oct 2024 09:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="H2Wwdbe3"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04199205E11
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 09:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729071692; cv=none; b=biIZkpvdX12/IFeH/PbU8iFTCouHfJPezfbOMmrRt9f8IlVho3nhLSsNPXaywHllak2O8FnoSAuNL/JS2hAP2kN7kmA7AvEQqbRicb3QdYo1swPiq+TQqLso4jbSM+0f1BbTPJbCgten3PeJky0bb3U0jr8liRt+TFJ8SuqDWzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729071692; c=relaxed/simple;
	bh=XaIM/rFjfd8OG16y/Nikmp9b2iW0zB8E8uS8AQG/h4g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=USJ1NKMZgFbJdl0EX3bQmexpmHt7Vn1DPQZgj0ndPeA9bvHY7cza6HZ6gDRPAq96P9VHdQRW9+BIhhjmR95BJfDEH5SqciBXqeWhtSigsaqST5pIQ1mkU/3C63SRscci+dV/4M6+4KbfP8DmfTgURz+tY+SOIjRiSw6qJ2FkegQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=H2Wwdbe3; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-43111cff9d3so48130745e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 02:41:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1729071689; x=1729676489; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f7lfgvZIb1YenbVpidy5yYoPzUObJFuBK63jpMu7KcE=;
        b=H2Wwdbe3Wv/WmkqdzRWTvLHKevjeMqLePqkD3sTm2n1okhX7oAf9iuQIVfmVoUy+3I
         6d4rauesf1Q4ufL+9Dfx7BUSKAygn7T6zNBT2qSFQisPtJQjxWhJtJgM1YyLxy/hTCvq
         W8h+NTtvUG+jjgDAXTO0u7AwXIyUmcIo1MEn9K6hm8ey7nngNDCNDXwyPEl0SMsp8TGv
         q8EEPAwPbNyqpCIlrj5BNbUd3+1sRxB0b/dHunCSz2KQlpFiGkyaZmWgR3Ll03yotUqu
         y1HPYyx15uT1KVEfuGS5GSQtAl5MJeiqswcUy9NDGkhbn/cgt2PeyaxikCl8nqIGV8c3
         Akxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729071689; x=1729676489;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f7lfgvZIb1YenbVpidy5yYoPzUObJFuBK63jpMu7KcE=;
        b=a+yS8ewYM6/4QntPuyS/3BGwFJZUlWK7HT8dzj5O2SXAzNFvrfpsNrwofe0/bBp6AY
         1y3aqSsJtqv6aKChCxuZuwAsDTRTXn08p97ZbTB4DejSqOoFkiBn/2v5TYf47ICsmSJT
         DZTmI1Njah1wmt20FhYUbD/rT3WcKll1BO2/RduXJcbych2QhX+JG0JgEXKvPPhiIX0S
         gMPvacC1VjL9JA5Ah3niTw3De/VCVwSMGuoDH2bQNH9PCv0YF+xslFizEvO79A0hChaU
         Y5RVY5sO8uhhYh+sCBBJADcMUw6fOdksV/20ZRISIuFlxT2m+Tn/87yzrrbQeTJFUYex
         6iYQ==
X-Forwarded-Encrypted: i=1; AJvYcCUuV7RM9nD/vbDD1wM9umYS0VmgKSApruFS1nHT6grNsM1EnBAAaPKBv44rCMtWONREplWMVF9uOjKUwXo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqsIP0QfQqzPBOya4sgT7E0yf8VkQdN7fwbRABWaoM4fwB/WU1
	4uQfvol96o5XDU3woowYEUmwSxtJa5Xxpm6SXnbqJV0c9ucKdJ17BnwOLgp4zwXREppRGwnmf89
	p
X-Google-Smtp-Source: AGHT+IHwFqtmKM8A0lRCwrdLulv4mevKVbMVD+7jZsLahbKkNMAMM/eN9mnfnqFlfRXJnm/u2LsGLA==
X-Received: by 2002:a05:600c:4514:b0:426:60b8:d8ba with SMTP id 5b1f17b1804b1-4314a362525mr25267905e9.28.1729071688994;
        Wed, 16 Oct 2024 02:41:28 -0700 (PDT)
Received: from [127.0.1.1] ([2a05:6e02:10a5:e010:472a:1760:2b0d:11e9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4313f56998fsm43654735e9.16.2024.10.16.02.41.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2024 02:41:28 -0700 (PDT)
From: Guillaume La Roque <glaroque@baylibre.com>
Date: Wed, 16 Oct 2024 11:41:09 +0200
Subject: [PATCH v3 1/2] irqchip: Kconfig: module build support for the TI
 interrupt router driver
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241016-timodules-v3-1-fa71091ade98@baylibre.com>
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

Added module build support in Kconfig for the TI SCI interrupt router
driver

Signed-off-by: Nicolas Frayer <nfrayer@baylibre.com>
Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>
---
 arch/arm64/Kconfig.platforms      | 1 -
 drivers/irqchip/Kconfig           | 3 ++-
 drivers/irqchip/irq-ti-sci-intr.c | 1 +
 3 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index 6c6d11536b42..393845a3ae5c 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -135,7 +135,6 @@ config ARCH_K3
 	select SOC_TI
 	select TI_MESSAGE_MANAGER
 	select TI_SCI_PROTOCOL
-	select TI_SCI_INTR_IRQCHIP
 	select TI_SCI_INTA_IRQCHIP
 	select TI_K3_SOCINFO
 	help
diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index 341cd9ca5a05..a958731404e9 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -533,9 +533,10 @@ config LS1X_IRQ
 	  Support for the Loongson-1 platform Interrupt Controller.
 
 config TI_SCI_INTR_IRQCHIP
-	bool
+	tristate "TI SCI INTR Interrupt Controller"
 	depends on TI_SCI_PROTOCOL
 	select IRQ_DOMAIN_HIERARCHY
+	default ARCH_K3
 	help
 	  This enables the irqchip driver support for K3 Interrupt router
 	  over TI System Control Interface available on some new TI's SoCs.
diff --git a/drivers/irqchip/irq-ti-sci-intr.c b/drivers/irqchip/irq-ti-sci-intr.c
index c027cd9e4a69..b49a73106c69 100644
--- a/drivers/irqchip/irq-ti-sci-intr.c
+++ b/drivers/irqchip/irq-ti-sci-intr.c
@@ -303,3 +303,4 @@ module_platform_driver(ti_sci_intr_irq_domain_driver);
 
 MODULE_AUTHOR("Lokesh Vutla <lokeshvutla@ticom>");
 MODULE_DESCRIPTION("K3 Interrupt Router driver over TI SCI protocol");
+MODULE_LICENSE("GPL");

-- 
2.34.1


