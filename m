Return-Path: <linux-kernel+bounces-447359-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 986B29F3129
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 14:07:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47352161EE6
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 13:07:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2C94205E09;
	Mon, 16 Dec 2024 13:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LwsrWjjO"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BD992054F0
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 13:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734354391; cv=none; b=u83xCv9MBhNtDq1JbqeEfAgVv1QJNT/gVBzlsIXgI57uAhKD+cqzZMMas9vLBziS2IF7TrMK/DZp07fOxLN7NAR0B6pQFIY//Ib2KyqEJ44t0BLE6ljXYdvoERH4IPM20Yk3N/mq87gGJqiTzxZad+8XTRhUE33Mi+b4NtSX1pI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734354391; c=relaxed/simple;
	bh=Svf/2mTvMUzm93AJ73j/lWNGd+x0CmjdkKQDOXkCs1s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=G3notXEM5yhg9b0mEOKszg2PmYaNTeEPOkDlzQrs2tAEj+EvqctuPg+oPT11Nk3XRoWA09E0SYrqTn/m0jMCPqxymGjCswUB1VZfxs65Iad5IhyczeQtns5nujnb68hRorir7FOPhs7XqPAjdY9zD5vXQcAQGIKs0ATWwPl1b8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LwsrWjjO; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-aa6997f33e4so634795766b.3
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 05:06:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734354387; x=1734959187; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Exe9dwySnGZoKQ0X6jvc3tMxyy8NWCLxusuFPVGkXUc=;
        b=LwsrWjjOTWs4+8a5LK6xrzZ6Lg5HUr5s6BsWYVFTm9j1d3IEjkqz0UfWE0JmIXS+Ow
         l7CJhyAaQYfZrr3nl3dqhbiBhCxPw3uRFNuK+5la200MHsjxUTgcErkLmTk5YSZsmXB6
         D1JDyMKMOGvASxbHHX73R6l/eZX3q7+AOJgZ7tR4uFFXmt7uYxgMvZUX/cdhFsA87O/k
         M5SqI2j6potMouVo4ze12cEisoSHX6BvOYwrH5sgu1Dn7hCnzDVAlmBK3WSKytFh724K
         T0OBgtoHKHH81W/jKDQy5lI7+6x3XYv+8fgzOeBODtSndrzYLPR5YRNN9d/N0fC/OH70
         NjAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734354387; x=1734959187;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Exe9dwySnGZoKQ0X6jvc3tMxyy8NWCLxusuFPVGkXUc=;
        b=Fgj9WwfVWtH7yIAoDSpPBZYSUujsp3EZ9YlCoqAmwtJlbfzwmGDzY881xkjVcRTAsW
         ddAR4AI7K2int6mQa/cUofQ0Y9TmkNEUp3ebYPRUWOkH9RkxK55k7RVNtOXNCl18yAKc
         6Ymiu7qFmUILHUNdk8yU3YTB89jU1ztOJrT+DqhP/lrqDrn8jsJGSKgtX42TsC4/r4w1
         3mOJncTu80Cnc+arglgqYzg6fq2Gf1SUy4Ygore7KDvY9pLUcobzPi8e/54P3vssYpn5
         3lSdDF0IDODFPG4wI4EeNGWFO2hde0qCiIqj4B66GO0dLmwNzGS/L4R3OqJxUA9QcLju
         7opw==
X-Forwarded-Encrypted: i=1; AJvYcCUdGjih3VDEO9cA5vXRITY1pnZYvNoFMPgFW5I5ob2RvugUx851D6Cfesd5MpbN83NkTht6CaeMzE7QM1g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwG/+6sSqCl97Rl00+iBNxe98bMmW8GeYOxA9Wywzk1610T4UAg
	1LDiuENmzyJ1DU1uMMeBeUoJgck1JzKPsoqwtOH9mn/+C2/EV+czFsbsVKod8P0=
X-Gm-Gg: ASbGncvEe+QK4uz3/onAobH9f8rt/5k2PrMDP1BZ+AXw2pRFnOQPLkGMUeTWcGQKvg+
	+WXTSlrmWP1CBws0GGZMN1ZYY/XF9uGzbfF8RNRz3X7ONcjK2hU7N88BBmEQKjWJEGn01ojCif5
	80nvwG0gX+VuQcbrP/m3oVXJ1tRGB9FnhL0JTaOeHPFZCQfOLqRgl5k9qZ8tkqrevQJ+4ReIdT3
	YTy/M2wMTX9HsuLYqBj0YrB5ecDb20/KriJaVkh90EQpyDxhMdK3vWoeQi1RwqZdQD+/9V2rK80
	5iwk/6JFQBIJP4Z2grQd5fah1J/tJJGh8soP/r7B
X-Google-Smtp-Source: AGHT+IH7g2VjztEudNhKR5bGxsFAdjhgJPghCK5aQefPDo7GYqFTFAnMVFJ8tAQLM6OtNQ2IyoaP1Q==
X-Received: by 2002:a17:907:94cd:b0:aa6:8a1b:8b74 with SMTP id a640c23a62f3a-aab77ec424cmr986404166b.53.1734354386928;
        Mon, 16 Dec 2024 05:06:26 -0800 (PST)
Received: from puffmais.c.googlers.com (64.227.90.34.bc.googleusercontent.com. [34.90.227.64])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aab960681dbsm326648666b.52.2024.12.16.05.06.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2024 05:06:26 -0800 (PST)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Mon, 16 Dec 2024 13:06:26 +0000
Subject: [PATCH 1/4] dt-bindings: arm: google: add gs101-raven
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241216-gs101-simplefb-v1-1-8ccad1830281@linaro.org>
References: <20241216-gs101-simplefb-v1-0-8ccad1830281@linaro.org>
In-Reply-To: <20241216-gs101-simplefb-v1-0-8ccad1830281@linaro.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Peter Griffin <peter.griffin@linaro.org>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>
Cc: Will McVicker <willmcvicker@google.com>, kernel-team@android.com, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
X-Mailer: b4 0.13.0

Raven is Google's code name for Pixel 6 Pro. Since there are
differences compared to Pixel 6 (Oriole), we need to add a separate
compatible for it.

Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
 Documentation/devicetree/bindings/arm/google.yaml | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/arm/google.yaml b/Documentation/devicetree/bindings/arm/google.yaml
index e20b5c9b16bc..99961e5282e5 100644
--- a/Documentation/devicetree/bindings/arm/google.yaml
+++ b/Documentation/devicetree/bindings/arm/google.yaml
@@ -34,10 +34,11 @@ properties:
     const: '/'
   compatible:
     oneOf:
-      - description: Google Pixel 6 / Oriole
+      - description: Google Pixel 6 or 6 Pro (Oriole or Raven)
         items:
           - enum:
               - google,gs101-oriole
+              - google,gs101-raven
           - const: google,gs101
 
   # Bootloader requires empty ect node to be present

-- 
2.47.1.613.gc27f4b7a9f-goog


