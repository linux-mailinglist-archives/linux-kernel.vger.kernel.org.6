Return-Path: <linux-kernel+bounces-187124-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CE708CCD83
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 09:59:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 563A0B21A4C
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 07:59:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B323713D262;
	Thu, 23 May 2024 07:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="DSEsaT0C"
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95A7013CF93
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 07:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716451112; cv=none; b=A/4IIzu0xWaJGQcUAinXThhVWFGymvs/pXqjO4qYgI55WRkJ5KlZe3ukxDalJllDUoh8AM+uke17BaQAWRUqBehKv934S6j+KEvN6d4CXpJFY9bFQjWAon0VaXrfl8We6BqNLiSr9+2iQq2g9RJRnAOJvfudQ4U4N0W+OEku41I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716451112; c=relaxed/simple;
	bh=Iws/eTrVyDn5dkbNRe+ngWkLPY2GChSsQJLxObwKLVM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o7M7YLiA/y2FTNV9QZltTpVDGNPoThNWLRFAm5Q0Rm//Y4Q0FvEcTuH+mQ8W3BIlA+dDiFujpK+jpmREt50ezQNCb9rG52AVOOsBpl9j2TldZKL0I9CrIExCPaef3FVtetODSkLs+srbLmJexbZpU2VizM41wOaMhM6uEO81Nj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=DSEsaT0C; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2e3fa13f018so74075901fa.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 00:58:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1716451108; x=1717055908; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4dcME9c6ixaYcF3shVm7kMCcCObSATYl0aCrY0gY47w=;
        b=DSEsaT0CewPiZdtsjAYPQ+DHuM43Mz4jxdj3cbYt9veo/YzDvYQFLgk87LxMwdBDP+
         Ug4Xpdz1/YMM7SrlS8Se4oVPC1rwwaNFarsFBMtrONnornNLYUJBOA8nRlU/rW/9yYv7
         ktSQUWIG+CVu+PmkrM5IRIDT+ob1Dj9nKfvJd5lZbtEGNi3W1HdEWrhyfR93ZO/CW4sK
         lTAHCRNAzPwwBDDDI0yCWNumNYIPC3F7j9wChVpktj82aad6goomyUwlWtseg6bJk3Fq
         Dg1nyQs1xH0Kil4q6yMN6HmkjCd0KpuzoF/Pn11WMUhcJ5R0uFABbPtGi61qlio6sqc8
         /iNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716451108; x=1717055908;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4dcME9c6ixaYcF3shVm7kMCcCObSATYl0aCrY0gY47w=;
        b=ql5m/KU8i1ztliP4ovRoYyrRL1/mvV0+6OfC7YTudeXQNF6mt8Tud3pcDkyGtWmoSl
         1NZCnCCwWYG/smaa7/hVWKVQrgHSJ33z3gNTvla7mpj9CoHVeoItOj/AKWdT4xEh8yZ+
         S7QvXd9JHTSF7LiE6GZjgj2nQFhxuQ6JDDSXjrOxoOPecywjgsiQBgPteCuFig2Qa/Ny
         uPYnxJIsBjDrBFt2QaoAJcrx3+POSjdyuoug6Tu+X/zfiT5tbVVSVvyDVb0Aig72HrGT
         APCyJ1sYuc1d7kVtMxUaQ5EGCN8DogcqXSzpMvyTxmrSRgfTcnq/v8m8eYYReLZBUkDb
         vRJg==
X-Forwarded-Encrypted: i=1; AJvYcCVREgc8dq7OHgJsE5z9/bKe4YdlOXSsPav/HzfqcpVtEfHPT96JbrYO1OF5oV7H2hVSY8WCA1KXkOS4TRqpasyx/b42M7OXCu/N2drE
X-Gm-Message-State: AOJu0YzH8Wnelf6PIu/BL6CXWaM4L99euk0zDiyqiPJRTCJGieHx7zbb
	Z7aMnozwyWOEEzhSASQQR7tFxoOgqwYs1UG8UakfhLJOhvGonL0s9o2rDjSohRs=
X-Google-Smtp-Source: AGHT+IFpTa7+bTT/sd4yF+zlR91kFCGJP5zdGd3C9ipXu2fgsrBztORz8qI+fV4vZQJhbBvN91EpGg==
X-Received: by 2002:a2e:3807:0:b0:2e6:dd18:ac29 with SMTP id 38308e7fff4ca-2e9494c4841mr26332501fa.20.1716451107667;
        Thu, 23 May 2024 00:58:27 -0700 (PDT)
Received: from blmsp.fritz.box ([2001:4091:a246:821e:6f3b:6b50:4762:8343])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42100f01d7fsm17359125e9.1.2024.05.23.00.58.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 May 2024 00:58:26 -0700 (PDT)
From: Markus Schneider-Pargmann <msp@baylibre.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Tony Lindgren <tony@atomide.com>,
	John Ogness <john.ogness@linutronix.de>,
	Markus Schneider-Pargmann <msp@baylibre.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Ronald Wahl <ronald.wahl@raritan.com>,
	Thomas Richard <thomas.richard@bootlin.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Vignesh Raghavendra <vigneshr@ti.com>
Cc: Vibhore Vardhan <vibhore@ti.com>,
	Kevin Hilman <khilman@baylibre.com>,
	Dhruva Gole <d-gole@ti.com>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH 1/5] dt-bindings: serial: 8250_omap: Add wakeup pinctrl state
Date: Thu, 23 May 2024 09:58:15 +0200
Message-ID: <20240523075819.1285554-2-msp@baylibre.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240523075819.1285554-1-msp@baylibre.com>
References: <20240523075819.1285554-1-msp@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Pins associated with the 8250 omap unit can be the source of a wakeup in
deep sleep states. To be able to wakeup, these pins have to be
configured in a special way. To support this configuration add the
default and wakeup pinctrl states.

Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
---
 .../devicetree/bindings/serial/8250_omap.yaml    | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/Documentation/devicetree/bindings/serial/8250_omap.yaml b/Documentation/devicetree/bindings/serial/8250_omap.yaml
index 6a7be42da523..402e2ca81017 100644
--- a/Documentation/devicetree/bindings/serial/8250_omap.yaml
+++ b/Documentation/devicetree/bindings/serial/8250_omap.yaml
@@ -77,6 +77,22 @@ properties:
   current-speed: true
   overrun-throttle-ms: true
 
+  pinctrl-0:
+    description: Default pinctrl state
+
+  pinctrl-1:
+    description: Wakeup pinctrl state
+
+  pinctrl-names:
+    description:
+      When present should contain at least "default" describing the default pin
+      states. The second state called "wakeup" describes the pins in their
+      wakeup configuration required to exit sleep states.
+    minItems: 1
+    items:
+      - const: default
+      - const: wakeup
+
 required:
   - compatible
   - reg
-- 
2.43.0


