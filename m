Return-Path: <linux-kernel+bounces-278025-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 83DDB94A993
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 16:13:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 400882856F9
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 14:13:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FDAE78286;
	Wed,  7 Aug 2024 14:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="w1LATSfC"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC8975D8F0
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 14:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723039975; cv=none; b=fkGeWzg1dgbmUX1WBsu2I27NILNCgs8JAtiBm6bMCeUiD/0Q/rH2wUb0n6qLH/WcV92zmDSlFbhGgXCenUVQ9Iuch7KVv+CNjtlgWhngupUleHsSvM1iGXc/8t5pFB+8qjnyPPSybAL8f5HLNbHLisBe0uWaTsRcHoOgpdNAWF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723039975; c=relaxed/simple;
	bh=e9Jc2sCWqNGEQJxc1zAjMLSN7zhY899ZX891bxlRIFA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VHqFpe/O3qO0AxG0epz9apJS6TlaO7mLRDEyCz0HwwDBvf1bje02cLZbnsjswUL+r9hQcNRyTWFJul/zwrkXx4G9pzykuw++OQl0VSZzP63so8z97I/iwxCcUfo4JM7df3dXudCVL8z2YuBHH7ibi0zfOVM4d3lkDHizls/m+lQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=w1LATSfC; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5ba482282d3so2473251a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2024 07:12:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1723039972; x=1723644772; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oKla0TikiRVuhRSfUT0bnjb0mFUM6MzVyHzb7uGiohw=;
        b=w1LATSfC1cDKgdDqOGwe3eDw9Mp9RG252mLySZfJImFljP1OOFTgA0wxCA6NSTeuET
         bLyYU2r6iJiEcYLCAaJJK1ISp6OGpqMNFoffi/MsabY6tnOJDdm7N9/2LpEUCvzgkrFJ
         4efDk6BCnRM2OpgSVkNlqXgJq8zNMNgzG+/PLOvyEwz7dCU8T95PeAaxfElW1f11bDr7
         IvjkamYeEOZXN3xJnvpu26gxBQ71rjfOOe96MCoDVWFqqkqh0/m5/1MwqIzjKW/CJmpy
         Ee4RNKc9pCPeinesdVg04djl5zH45vZHYzGvmJufOJuC9FLkE3vizvnLlF+ziFSfpDbn
         Buig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723039972; x=1723644772;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oKla0TikiRVuhRSfUT0bnjb0mFUM6MzVyHzb7uGiohw=;
        b=h6c+y9xPvQlFMnBpMGHYopfFKbBHbK3RpjawBpYLTVEabNVHTBS1ouastU9AtiXM+R
         sovX34Q/4WavPNFigGWgaO7VjZWhrU6wU9FWo18q1u8Hto6DYoGyWmATVRAKMZkM/VvO
         P81X7z77wkjbBnUjI7XrF8fgD5n9UGhypXNh8D2yIXAUJZZkW38hLgTYqTbKmARiNWjh
         s9XF5kqPUnevlfnZ5nA7EYUL6uOTrUBsuRi6jqKt2jwAa0+piWQtBj0sE7x9T2zygUtR
         c5o0f8fE/3EqkIt25/t6Cn5cgxaK8R6B8dKq4pc6dh47+bfgcv6T+sWHftMCImdWKHoe
         MnWA==
X-Forwarded-Encrypted: i=1; AJvYcCWAsO4D9YvYbESXN40hxYrSA5Dl8a58GNHIIZ1dBPYJbqNccSldZa5GEOZ/sMKVQ2Ll0sT6G+mpM0RlEiGNSeZyKB3lqHyvzIUr5hwG
X-Gm-Message-State: AOJu0YyFf0JJBidyVuxyrJfBoPozpOsveY/hpXrK/DsxmuXB8beaI2wG
	3XcT+ZQ3jfJjxQm/vk3BaaQ04Nx6/INhIjzj4i5SM8uEufUh+fJJVKBpJzNuByE=
X-Google-Smtp-Source: AGHT+IFTtDrHzcEyJfrxQSsx9wYYXZfPjxj1fP6zwRtDfyoo6YHEvanfv08xhTEKIkVOKBpqh5fwkA==
X-Received: by 2002:a05:6402:542:b0:5a2:37e0:1e88 with SMTP id 4fb4d7f45d1cf-5b7f39e0ac1mr12617987a12.9.1723039971875;
        Wed, 07 Aug 2024 07:12:51 -0700 (PDT)
Received: from blmsp.fritz.box ([2001:4091:a245:8609:c1c4:a4f8:94c8:31f2])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5b83b92cbccsm7057525a12.68.2024.08.07.07.12.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 07:12:51 -0700 (PDT)
From: Markus Schneider-Pargmann <msp@baylibre.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Markus Schneider-Pargmann <msp@baylibre.com>,
	Tony Lindgren <tony@atomide.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Ronald Wahl <ronald.wahl@raritan.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Thomas Richard <thomas.richard@bootlin.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Udit Kumar <u-kumar1@ti.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Vibhore Vardhan <vibhore@ti.com>,
	Kevin Hilman <khilman@baylibre.com>,
	Dhruva Gole <d-gole@ti.com>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH v2 3/5] serial: 8250: omap: Cleanup on error in request_irq
Date: Wed,  7 Aug 2024 16:12:25 +0200
Message-ID: <20240807141227.1093006-4-msp@baylibre.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240807141227.1093006-1-msp@baylibre.com>
References: <20240807141227.1093006-1-msp@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If devm_request_irq fails, the code does not cleanup many things that
were setup before. Instead of directly returning ret we should jump to
err.

Fixes: fef4f600319e ("serial: 8250: omap: Fix life cycle issues for interrupt handlers")
Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
---
 drivers/tty/serial/8250/8250_omap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_omap.c b/drivers/tty/serial/8250/8250_omap.c
index 02d4f3073696..01d430de9c64 100644
--- a/drivers/tty/serial/8250/8250_omap.c
+++ b/drivers/tty/serial/8250/8250_omap.c
@@ -1587,7 +1587,7 @@ static int omap8250_probe(struct platform_device *pdev)
 	ret = devm_request_irq(&pdev->dev, up.port.irq, omap8250_irq, 0,
 			       dev_name(&pdev->dev), priv);
 	if (ret < 0)
-		return ret;
+		goto err;
 
 	priv->wakeirq = irq_of_parse_and_map(np, 1);
 
-- 
2.45.2


