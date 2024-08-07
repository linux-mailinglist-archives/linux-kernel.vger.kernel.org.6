Return-Path: <linux-kernel+bounces-278023-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4179E94A98C
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 16:13:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D5EBF1F27334
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 14:13:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB36C5820E;
	Wed,  7 Aug 2024 14:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="y47iMReT"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42CD22BD0D
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 14:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723039973; cv=none; b=sOn7pgYIdzse7MaRd+b6k14SV6L+kjMXyTwWa2it2AhkDA3Y+e8q5Ku51M1ZsoULxUnTNA3S2fyiRZmaGOZwgc0AG4b6c522abdJ+xA1SKxn2tpkmOitSnbLW0LaK1yM1hjrKsOZcUBH45egNLzUDiur9lsteebci88L3C1DxkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723039973; c=relaxed/simple;
	bh=qaLIhY5a76Z3Df5j4EUrP5Uqp81Mo30nXZU+/Xwg6EU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PVPsSuZYQA+g0lM9MSsPdebTz2qz9sfGoXXVCMdgUhvdIaJ2PVyat5bsOzDJTcRUJboSQRRzGswOHWj4W54VJJisR0SAxhmigPrabVaHvjeFxHNx/kNYLTHY+I4JAAbR8+zm34KH4UpZGL8WjYw6ubP+27RKZD8vKWHR0/ljgl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=y47iMReT; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5b8c2a6135eso1126572a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2024 07:12:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1723039970; x=1723644770; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LPc8uL/JW9kq7vTw/l6UlNZzhd8kMKMZECX7hWsn11g=;
        b=y47iMReTM8VnQbFb+ijO1pi5Hm9vkUEp+WNV/IJ6bfloBBVqjsDsycwi/JxUkG1sLc
         oRlQHqnEx1KHXqYjTswg6pEJVCK8UW89A3I7TqHxLrLPmiWJROlQ4HwGYwpEUA7vFFhV
         qTpOHHPSZjmXqLshdqh1N3jXwL9FCR3miDldo+H8MqdS05E1Z3Dk6j9dChueN7Pqu3MA
         VOBg1kGJ4ofiX2aPXJZ2qkBauR8uEKGl6pXgSJco5tPcMbOykJ8UJvIK15Rp89Bb7sYB
         LkktYGnoxGepnGYVMVnPrw6wFWNy8h5DPCWCYEIAA5fs/BCapUOtdtyyc/qJ3nkz3Hbx
         Ht0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723039970; x=1723644770;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LPc8uL/JW9kq7vTw/l6UlNZzhd8kMKMZECX7hWsn11g=;
        b=ht1kxcRdG+38Y+1eVKOfLWM7xw6ReBAQV/ZySF9eKiBsNAjA2W6DH799HxIYfDMnT/
         7WuS0VuVEBVtXdIkgcmGzQ4DStAyI5Usb567VAATKYjSWOFdbjsqFrSij1XcoUXkYcG+
         PSqB3XgeBsoWaZkPDoV1qkmarP8fIu/RSqzp4L2yDhReHahJd1zxAaAik6eeZqUidf0e
         OtxG381JzgzN31QZk3LCirPvfAopTKylyASN2Lg8kVFH4Z6n4m0P1CJ/J++qq+3IWk0N
         KSBJQbJqvVEjcoSX5CfEyus53pAQnztgdNGeN8d1AktAYdpoyfTPNJJsv/eH3BBSDYDF
         0kMw==
X-Forwarded-Encrypted: i=1; AJvYcCXDpvORO+ZjiBDo45z5ECFDLIUIkP1Snt+Q61qEGhPKSQ5uOS80mWX6niUyXeV5tQX7CD22Fv8QbzwU2tARunKepPYq+WArD0WBHl/r
X-Gm-Message-State: AOJu0Yytix1fBGPHbnm+uIZdpoZRrHiN1Iy9svxccuWpvvYO1zaWYowJ
	mz31wXOCJvSLqA8w5AMTZZQJhnkUCcso2eIMmYpcp/S8qQZ3clKH0tb8IPzZXu0=
X-Google-Smtp-Source: AGHT+IEsUdOugcFq+1Zh+LgBNPD+cI5u68iHgjax1xg5KbxJ57PrjeQWrdQKQ2V4fRjbRDhrQZGJug==
X-Received: by 2002:aa7:ccd6:0:b0:59e:a1a6:11b9 with SMTP id 4fb4d7f45d1cf-5bba36774c0mr2032366a12.2.1723039969391;
        Wed, 07 Aug 2024 07:12:49 -0700 (PDT)
Received: from blmsp.fritz.box ([2001:4091:a245:8609:c1c4:a4f8:94c8:31f2])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5b83b92cbccsm7057525a12.68.2024.08.07.07.12.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 07:12:48 -0700 (PDT)
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
Subject: [PATCH v2 1/5] dt-bindings: serial: 8250_omap: Add wakeup-source property
Date: Wed,  7 Aug 2024 16:12:23 +0200
Message-ID: <20240807141227.1093006-2-msp@baylibre.com>
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

Add the wakeup-source to enable this device as a wakeup source if
defined in DT.

Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
---
 Documentation/devicetree/bindings/serial/8250_omap.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/serial/8250_omap.yaml b/Documentation/devicetree/bindings/serial/8250_omap.yaml
index 6a7be42da523..4b78de6b46a2 100644
--- a/Documentation/devicetree/bindings/serial/8250_omap.yaml
+++ b/Documentation/devicetree/bindings/serial/8250_omap.yaml
@@ -76,6 +76,7 @@ properties:
   clock-frequency: true
   current-speed: true
   overrun-throttle-ms: true
+  wakeup-source: true
 
 required:
   - compatible
-- 
2.45.2


