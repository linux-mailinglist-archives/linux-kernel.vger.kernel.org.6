Return-Path: <linux-kernel+bounces-301973-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CC9595F828
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 19:32:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4EF591C21D76
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 17:31:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 311BB1991D4;
	Mon, 26 Aug 2024 17:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="bUW8wJz1"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDB941990B7
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 17:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724693485; cv=none; b=d4kTvyO2RP7xgaQjnA+CDBZFu0feVO6y8QMJcfC7d4J9t9WYKCEEo4beBf03ZosYFc9yWEGmf1QzvAJtbHPCMUIsX5e90AR/D/4g3upQfF/zCKqrfAgmDZ1CWpsI2fhWvH72XB2X9h6SQUhYbJMYM40ocsZnXqRwD0rRt5oCX+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724693485; c=relaxed/simple;
	bh=QTmsTIDi7cKHIzyRh0s31HScPPVZAg2pITfHlR5Hw1c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hM5Q7z0/n3IGz6W811pEayNWHFe+Z2QgDfT7Pj9e787nKUmp4Hgsnb+CsfdPtyGTsfT4Vvmz8sBYsqY3msNlfy+8/okwtvoyX9OSXGfoc82+eh0ouYxI4+9MqbnF8aY5/xNASxFzSvnURSarl344Dke/L19mjMRmvjhGypG7zdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=bUW8wJz1; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a83562f9be9so417295866b.0
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 10:31:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1724693482; x=1725298282; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=biOUpzjklUMw3DeHF9ZmoaEFGQg/45j+i/IYEf+/2DU=;
        b=bUW8wJz1zrX7dPe0/eoqW/d0gxEG0Z0dt2Yl1t7EhnpvaWm+Si2YW6lbTqzdTejivU
         MhaU1Fu1MX6I6Sxq3WTt9GiQeJqN5Ly08qYy6UbDDnZLO/ES0F209Bcj763LK+hWqRkx
         eK1Zs/WFnPTjQL9xoEfePGXKuSHUY7ZUvC/fhtT6YlWCzxD6ydz13SwM+7R25q+HqH7Q
         Zr1sn1QRaE4olMnhLC9KzWlJMqcNOosCAdVc/oCKcakfQZNBintCaGEt12bTvl6m5tfG
         9W+sKGzijiNB50bW4zGlyK0Kj3uGAd+wyuvg63khQsEdl5MEtjAqTk+wiWhqq2bzKAUy
         z42Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724693482; x=1725298282;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=biOUpzjklUMw3DeHF9ZmoaEFGQg/45j+i/IYEf+/2DU=;
        b=YQV+SlAIPLLOfxH9BLP0LIjHTcXKQgb9vICgrFfLO7u8guMSVoixuQ/qZZDkOZtmMo
         YCHNJtfEqeHeDqUKaXgYO7kn5EPBiWbse9QWQNsDQu0UkpU/2tea47s/jG34aB4dFe2G
         hgThHrbhs6VLPCHCTv3cl9+NVm7zLiztNZvb1CLxGSCYIiDlM1HIW/a6Pt3oi6GO0T5i
         O46+qNG5QksTPjiMEowNNOrJblerM6ZCDbeUfIvQN9KGCa+B9KROQ0P5hSKGaoKuurDO
         Iz5jsu83owfaWG7StaxYoJW66R6ZRSHtHavxyScyfmmLJbvOIelznyQy3L47RTKibvL9
         h5Qw==
X-Forwarded-Encrypted: i=1; AJvYcCVdmzn/Slak7PYZqDobwAon11i8FJolZSgWNaG5q65ObQerZeO078ICG9XlNm0JvhuhzIM/1hEkXDL7Pp0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7AQjcE9h7aoIugg3jTKphj97sl0rADcERgVD+tdeH3GQUtvbW
	4ycHqFIQ9tTmi9vFumXOREFwwL9lPidXorAI9eJYOBhmKqXJBCNVOnSX7LOuVm4=
X-Google-Smtp-Source: AGHT+IHerndDsRmrDan/43wV4cMl++NdUbzuQbGoEd/HEOURC+hfMLYMkk8BUPcq8vD5t9RBTqrNoQ==
X-Received: by 2002:a17:907:6d20:b0:a72:6849:cb0f with SMTP id a640c23a62f3a-a86a54cf6c0mr651740866b.62.1724693482233;
        Mon, 26 Aug 2024 10:31:22 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.144])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a86e548781csm446566b.28.2024.08.26.10.31.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2024 10:31:21 -0700 (PDT)
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
To: nicolas.ferre@microchip.com,
	alexandre.belloni@bootlin.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	mturquette@baylibre.com,
	sboyd@kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>
Subject: [PATCH 1/3] dt-bindings: clk: at91: Add clock IDs for the slow clock controller
Date: Mon, 26 Aug 2024 20:31:14 +0300
Message-Id: <20240826173116.3628337-2-claudiu.beznea@tuxon.dev>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240826173116.3628337-1-claudiu.beznea@tuxon.dev>
References: <20240826173116.3628337-1-claudiu.beznea@tuxon.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add clock IDs for the slow clock controller. Previously, raw numbers
were used (0 or 1) for clocks generated by the slow clock controller. This
leads to confusion and wrong IDs were used on few device trees. To avoid
this add macros.

Signed-off-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>
---
 include/dt-bindings/clock/at91.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/dt-bindings/clock/at91.h b/include/dt-bindings/clock/at91.h
index 6ede88c3992d..99f4767ff6bb 100644
--- a/include/dt-bindings/clock/at91.h
+++ b/include/dt-bindings/clock/at91.h
@@ -55,4 +55,8 @@
 #define AT91_PMC_GCKRDY		24		/* Generated Clocks */
 #endif
 
+/* Slow clock. */
+#define SCKC_MD_SLCK		0
+#define SCKC_TD_SLCK		1
+
 #endif
-- 
2.39.2


