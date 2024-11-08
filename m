Return-Path: <linux-kernel+bounces-401751-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F9F89C1EB8
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 14:59:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C16B2284780
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 13:59:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A16311EF0B9;
	Fri,  8 Nov 2024 13:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b="p91l2LD6"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A7561F4295
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 13:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731074346; cv=none; b=Ux6/z8Tz4aVR3fRPMBN9ZVdovvrqD6BNZ0e13yWF0lDVBxLEd9vGPRBC+2KegM4BrFfrCMZgvmyxXk4sh5L2XRza3MvPqHEyOysJ1o6BghnU3Xfd3caucVkotaVBF1genTgi/XDtPMUQeYeoWtXeT+D8gKJ/DoCeZJX86dICygY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731074346; c=relaxed/simple;
	bh=lMfKsf12S0K48wHK6+KFJJk1kLie0pg7opOx+E+fnpM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i+oI0SG1cRhZ1u+sRmEQ9PFTY0wTHJv4yUW/kePWufTg1XkJ4WWimUldEIfzjMaPInH01QB32vZALch3dGEQISEaDrXDCEzZkPlgmNPKjE75PB6hJcX/tK7gVaOzXPo+I39lPI1m1GqauI+bt2+eQRf+TZ5Ff08SWQ6oCsdaB54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr; spf=pass smtp.mailfrom=sartura.hr; dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b=p91l2LD6; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sartura.hr
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-43193678216so20233285e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2024 05:59:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura; t=1731074343; x=1731679143; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kn7pAJeAjAQBKS7X66mfb/roOZgIjXWBw7c3PZeLLVI=;
        b=p91l2LD65/zeKJSp3NqA217xyOxsdoy3xjpGG0x+tQenow19F8kkXXOelVyL1pfESx
         XWwin1nT48J35Qwg44h/H/oiyKsAdGiWDvwxmlx5WFA2nbx+uLLMNWbapVeUCDK2+4Nm
         c+Ylstf0JKBEa6yo2/7FYmNQ+Fv6SYkPBpXQ/0ke5z154IL5U7OMjxRWTIUxjkoRET5s
         ovvYTphw2f+JDFYNY9WIRDC+8ctbR84nkskLRrFqmZ0gAk3b4OHjz62yrpPIZVYmi5Lw
         O0+phbzeVoeTN/y6f1EVNg2a+/wZO0NSpJhn3U3eFnM8MXbkAw4uuSPo07niyA6Cg7oA
         mtDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731074343; x=1731679143;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Kn7pAJeAjAQBKS7X66mfb/roOZgIjXWBw7c3PZeLLVI=;
        b=si2n+6BtrsKl8jCpuBWe+jy3zv6rjDm9LcDpBoCNNrtxilrsv9sjVXO4bVgjhqTexE
         bkR2KvT8ssnnxzMkIIk2tr7XR4SXqVkgS0hl+8aD6hA6zwH2ShHPChyFBLzQdQ84/ZhB
         fRvnbq3KeG/2XN74QFoUCr6PO3ZWQRqYH4TuEH3mekAzdxEcz/dlYdpHgY6FZICl27Px
         MUwuLHFjuHUT8AgRZ56S6gE/wpTvN/fmgVVwGf8bmpi1ghH2rDoytP9Uto3lEoCc8DGW
         //DD73OH/1MaMTA+zvO99rynlBfc5qcswIY2dFIt4+kTPhEM0K89T9nHCNwHzelzYiyT
         Dy0w==
X-Forwarded-Encrypted: i=1; AJvYcCWB+KMqEtN87+y59AD05YCEI4MM6POu+4h8Gf46oKgTwm655NBR2r9gp3rIPpiYmuhIyk07TJkI99u3vTY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdhBxkxWZgN6xFOqA7Avw62g7q/wvauQVA3AxErM6Zj9X0Co3q
	ybADclI/0WFbk5msQfkONhGg1GbtGuCvSxkiFDdxshCKA6Pwe5iouqU9bgJOCk8=
X-Google-Smtp-Source: AGHT+IHrDQs0PBQTgCK63DboffAmrhsTnn7i995FZLXxkWto266aljsAzoWEwTEOFu6My3noEjNsLA==
X-Received: by 2002:a05:600c:354c:b0:42c:ba83:3f0e with SMTP id 5b1f17b1804b1-432b74fcb3emr24421625e9.7.1731074341213;
        Fri, 08 Nov 2024 05:59:01 -0800 (PST)
Received: from fedora.. (cpe-188-129-46-99.dynamic.amis.hr. [188.129.46.99])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-381ed97cd97sm4924431f8f.27.2024.11.08.05.58.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2024 05:59:00 -0800 (PST)
From: Robert Marko <robert.marko@sartura.hr>
To: catalin.marinas@arm.com,
	will@kernel.org,
	mturquette@baylibre.com,
	sboyd@kernel.org,
	lee@kernel.org,
	gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-serial@vger.kernel.org
Cc: luka.perkov@sartura.hr,
	Robert Marko <robert.marko@sartura.hr>,
	Nicolas Ferre <nicolas.ferre@microchip.com>
Subject: [PATCH v2 3/4] mfd: at91-usart: make it selectable for ARCH_LAN969X
Date: Fri,  8 Nov 2024 14:57:33 +0100
Message-ID: <20241108135855.129116-3-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241108135855.129116-1-robert.marko@sartura.hr>
References: <20241108135855.129116-1-robert.marko@sartura.hr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

LAN969x uses the AT91 USART IP so make it selectable for ARCH_LAN969X.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>
---
Changes in v2:
* Pickup Acked-by from Nicolas

 drivers/mfd/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index ae23b317a64e..f280ba28d618 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -138,7 +138,7 @@ config MFD_AAT2870_CORE
 config MFD_AT91_USART
 	tristate "AT91 USART Driver"
 	select MFD_CORE
-	depends on ARCH_AT91 || COMPILE_TEST
+	depends on ARCH_AT91 || ARCH_LAN969X ||COMPILE_TEST
 	help
 	  Select this to get support for AT91 USART IP. This is a wrapper
 	  over at91-usart-serial driver and usart-spi-driver. Only one function
-- 
2.47.0


