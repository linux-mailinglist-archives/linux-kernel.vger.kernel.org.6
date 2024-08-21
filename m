Return-Path: <linux-kernel+bounces-295476-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 63B02959B73
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 14:15:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0ECDA1F22BCC
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 12:15:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4CD318990F;
	Wed, 21 Aug 2024 12:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="IEWPR/63"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2955166F28
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 12:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724242507; cv=none; b=YXmXtippD1rTmGrCzPlVrTdKRFfuoypQ/IVPXVVR895lO6ZK+htSAjmbH2nANxz0JEpO9aV8F3gNrN6EXEe8/wGMFFC1ee2p6MKp7a1VKr4f0Ew0Y8Lxg35xl7UshbhjjfaDHzphgHZpSH1q8IvQRFNTBZmjYshatc8gIXpycYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724242507; c=relaxed/simple;
	bh=8XDdi+wKeN16H5QYAJ149FGzvNNOIx3CUjldgIHNaPY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=REIIDQNW0vKGhfWSZ+xBiHkSfdEOSem69cagsu1jU/dr6RPzi8SEOUcF4qvM8IdtHyFKZ2gt24bKIcMdy607TBFDyooxrB5NjtfMsCYIMMpMIzm/1tCM43rvrpV6Vy1C/rk9T7W6+4Ni/az8/NIn0PYpGG8R1BvmK8VJ7wSLoJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=IEWPR/63; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-428e1915e18so51357935e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 05:15:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1724242504; x=1724847304; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xTz300t/luXT8zpf6sUHvk2i6OLc3SxIx0fProJbjig=;
        b=IEWPR/63I8bFdt7IJq/3BWLmrMi/wn6+aid+fDWkgy17oRZsSm/E1RrozMdC749IrQ
         +RJhk779W8yJsblfuBBQZ5cMiYfp+zWIZfgfzOVse/rSHtV46/B59Sap/o6vsp9urw9+
         FfGLaanszgBrbWUW+MLOOOkBf3Yv4GBmFDFW68eCOAQFtGgyWa9o0RslbP5SBVOE5eN9
         sWRfFQq7erlJyzXkwd5NwDrXFU7JXTUrIT7ojWQHMKCKREXsxRBQUybrblBaCpt5igUl
         fKppcd3ntthMZygxS7Zq64zTjZx4mtMWM6DwcODNNMTWRpuKpJpz0wVaEFbMmE4KiTih
         hNLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724242504; x=1724847304;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xTz300t/luXT8zpf6sUHvk2i6OLc3SxIx0fProJbjig=;
        b=tuu5V43qE7Bex2SZ6CdmEdZR8LML5z5fV1tnymxtCmv1TPC8nVcn/Q7R/z4SalGwCG
         ryh8tiiSSfqJac0q1ajeXU576jr99jHWc7X268MhIM/G6tfKbEvdK4jliYRKRxY1MdmR
         dUQDrNS678CtUYhMvTfE5I/gbVrjAAT27ZtHXVjWStLtz2acifPlsQsWAf4hpH+sWarq
         done9FfUAtb3bAMDXCN9frYs04WCxd2gn2xNjV0m0ZtNpfUmOMkZ+xJXlEYuP1Kr/RT2
         CLand0lmOyYFpEvewvv+Lad2+pBgjL44wfpJpEY4K34BsR+T2sZhAvWDVGUA93NvX/LZ
         +EEw==
X-Gm-Message-State: AOJu0Yyxa2e1napbXGozE7kmtWcNh5DhfKcij3cqCDNYikUEuyrMFx8k
	3MmmY8V2sRxAbcTYZIfEAUEvaPghiNboHeYyj5NXccKj5HokrnKxN8cc5qbCTLj7yiSlrnosm4y
	Mvm0=
X-Google-Smtp-Source: AGHT+IFNhN49sYxGRaKV6Ju/INhyn5+tc7rma2VMhAE1dPfKeHdY4KqapcmU/kumSKGI9L9AWQLO/w==
X-Received: by 2002:a05:600c:3d0d:b0:426:5c9b:dee6 with SMTP id 5b1f17b1804b1-42abd2449e2mr15984185e9.26.1724242503495;
        Wed, 21 Aug 2024 05:15:03 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:42a6:b34f:6c18:3851])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42abee8b43fsm23056595e9.12.2024.08.21.05.15.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 05:15:03 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Alban Bedel <albeu@free.fr>,
	Linus Walleij <linus.walleij@linaro.org>
Cc: linux-kernel@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH 2/4] gpio: ath79: add missing header
Date: Wed, 21 Aug 2024 14:14:54 +0200
Message-ID: <20240821121456.19553-2-brgl@bgdev.pl>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240821121456.19553-1-brgl@bgdev.pl>
References: <20240821121456.19553-1-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Include mod_devicetable.h for struct of_device_id and its helpers.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/gpio/gpio-ath79.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpio/gpio-ath79.c b/drivers/gpio/gpio-ath79.c
index be2952fdae3b..7f9e66d75c8b 100644
--- a/drivers/gpio/gpio-ath79.c
+++ b/drivers/gpio/gpio-ath79.c
@@ -11,6 +11,7 @@
 #include <linux/gpio/driver.h>
 #include <linux/interrupt.h>
 #include <linux/irq.h>
+#include <linux/mod_devicetable.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/platform_data/gpio-ath79.h>
-- 
2.43.0


