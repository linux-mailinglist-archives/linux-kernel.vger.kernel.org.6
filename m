Return-Path: <linux-kernel+bounces-536238-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BA939A47D18
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 13:13:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B0F2165DEC
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 12:12:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 074F923371B;
	Thu, 27 Feb 2025 12:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CagpZrqH"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BA5922FE02;
	Thu, 27 Feb 2025 12:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740658196; cv=none; b=gN+805SE2ok65kHlshFngtYFgEk3sSxbQ1oocJLRoEbI/4/je2YC+LgNnBuBtdfoDtbJQKs4uCzoge6ouUOWvOSzvGUxJC9nALunX5NsKNg0eLTVb3XORYvK9RMVJISmehzl32P/aNc26w21cUeM/Wh+uwbL/b7vX1uzlkEBFEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740658196; c=relaxed/simple;
	bh=HT+SDIfQlIRms8FxF8pg1Dd1jnfWIMjWKWXnYtBy3qs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ICHhVqrdhP5+nhtDsCvO9srq+4s4eLV8oBB5e+2zYxb8UCqJw8+upoxk2Zij3WYfl2+RHgxup8JdaJ5IDVMwjOY0jTvJDXS4HE8mTe3PzvDuCxVs/huTEvd1VnZWF/5uh7IiIRP0a9ybJqFNFuMm9UNaLR/2IAAQrEzdU3qNeB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CagpZrqH; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-22185cddbffso33991755ad.1;
        Thu, 27 Feb 2025 04:09:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740658194; x=1741262994; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0GY7dlVupIydN6arxqzciNDGAGAOkBdBUMtuBEAPCp4=;
        b=CagpZrqHA4XYYzAho2K/Bpwuw+bNhGjaSlobOTdgCZbknB+cT/f0FZd/Rz5OZPBMxA
         +jBODvaAeSm5TE9sYjwOcpV8SgU3xJHNwT/lSeSHUb1g41XmiC8r5f5A+wrmvULzaE84
         xxLZR9lTkVsj59zF0ToYZTzJFm/igk294VeXPGAcpzr+qkDUxLYCFz/sGgblhJyFMZ7H
         IR1ywuWWdXFt8TcXe3AI3YWAQ1YWhOLOSUhUpn97fU2qf5LitlRuU7w44XANUqdN9SPU
         C+99Es4A19IVOL1dhEPMK6brsm+miKAQEynO89dWNP6POkxjGfh7OxuczczAXqHW5n3U
         /seA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740658194; x=1741262994;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0GY7dlVupIydN6arxqzciNDGAGAOkBdBUMtuBEAPCp4=;
        b=aqNfKgGos5zujCtUDWM9zXMAp+jsYOskMd0i/h7J/sTBscDxKxQEAfCcadTRAUFr9H
         /D7l7PuN6QLMIVDH1KLaDHI8PIF5aP5OVoLRV5J4TEFqVZYN9vPUYu7ieWz4FuOHstow
         LXwkoTgudh92g9gTeg15DHYnUYQmeNDyKM4uc1mY6BA+b7MNDzFvtIOZYz5yQuiTqV4n
         N6tH8OA4eO7uKWkgHdN6/pR5SrGuk631xj6O+n0qMw/wVsIYskDSJK4JJhULZLqNRYJf
         xkZV0JQEC0XQR7YedocprDE5Puqm54FmQbC38mw/U6XxqCyf2rKpEl9JmU9L2JiRiEBn
         USZA==
X-Forwarded-Encrypted: i=1; AJvYcCV0qYQLyjO0WIZVlVAsJkj2qRvl52N+fz/ZSClbbf4SraC9t/geFJKxEP9VjgJH55wdzNeeFuBAD2Xn@vger.kernel.org, AJvYcCWvO/dsNK4iVQ3nyCOJXAOtfVxNta9CCx4rMDGe0EHbrRZpEnmxgpueYNjctrkuRxodoJW8NAAgorY3RKVu@vger.kernel.org, AJvYcCXDVrKoYcDbaPPCi4XkSp/KaC5crYkd9fHoSGdDSZSaKAkFxpZPuCGdN3lqxQrEwDhnjFV7aeOv7Xk4r4Y=@vger.kernel.org, AJvYcCXTIBRBUDPnwQR/Tai5ENLGS+VLQTXBg8+d9TJ7Ur+ng//S1GUfO5+V53jWIVERMSpkZA+TKhw/PMXmM+M=@vger.kernel.org
X-Gm-Message-State: AOJu0YwH31Jyfva8YIreKoZMQlTah8aslhFlQ9DcljVmwnjUozNDtfLb
	xK0vLKrSNfSDjuHOTT71oB2G+RbdK6LcZ1qzzJIseOwaz+t/EFQ5LDTtRjtJ
X-Gm-Gg: ASbGncut+msn0/KV7qin7PkDeCWuhdYFc/8XkQQHmA/aV02SB3gh+cB1TrcPguVVR9+
	lVoKMIN5FOJ7ABRCojQMPcobg5MBr7Tdtde0Lfr+r7A01K2I99u1FmKlYxisRXlL/Ka4YQxtiIj
	eItyN3yAaYouoV1mXpwLMCqwC8f93iYe7pxrmTWKkoTz/WPZaFX7tz6/Uw8HaECzI4wM0xQAOPj
	ay9Yau/XBy2CGxrrEna+Cv125B2G5CMPj2pRldbKMMp9wrjMWhSqQCXyP2u15DAKmSoKdWhkGvV
	nJeggp5NTXIUXhAJwkrKRcAxMyBW7JnH0xb3EDZy45mCBYbnbAaNosVdaB2hKJ8GSAj2lINFtk9
	ea3OUMWNOsJ9ckL3Nc5nY
X-Google-Smtp-Source: AGHT+IEFQRcfJpHWiQLgG25ggWIxdqRMPSAyoARJI+dYR0aKvDD/rhtwtZPwoj9aqVqXC7GAjuuXuw==
X-Received: by 2002:a05:6a21:7899:b0:1ee:d664:17a4 with SMTP id adf61e73a8af0-1f2e389ceddmr4438228637.10.1740658194534;
        Thu, 27 Feb 2025 04:09:54 -0800 (PST)
Received: from [192.168.2.3] (2403-580a-80ed-0-4835-5a07-49e7-f115.ip6.aussiebb.net. [2403:580a:80ed:0:4835:5a07:49e7:f115])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-aee7de19cdasm1074217a12.24.2025.02.27.04.09.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 04:09:54 -0800 (PST)
From: James Calligeros <jcalligeros99@gmail.com>
Date: Thu, 27 Feb 2025 22:07:35 +1000
Subject: [PATCH v3 08/20] ASoC: dt-bindings: tas27xx: document
 ti,sdout-force-zero-mask property
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250227-apple-codec-changes-v3-8-cbb130030acf@gmail.com>
References: <20250227-apple-codec-changes-v3-0-cbb130030acf@gmail.com>
In-Reply-To: <20250227-apple-codec-changes-v3-0-cbb130030acf@gmail.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Shenghao Ding <shenghao-ding@ti.com>, Kevin Lu <kevin-lu@ti.com>, 
 Baojun Xu <baojun.xu@ti.com>, Dan Murphy <dmurphy@ti.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shi Fu <shifu0704@thundersoft.com>, 
 Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>
Cc: Alyssa Rosenzweig <alyssa@rosenzweig.io>, 
 =?utf-8?q?Martin_Povi=C5=A1er?= <povik+lin@cutebit.org>, 
 Hector Martin <marcan@marcan.st>, linux-sound@vger.kernel.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 asahi@lists.linux.dev, linux-hwmon@vger.kernel.org, 
 James Calligeros <jcalligeros99@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1199;
 i=jcalligeros99@gmail.com; h=from:subject:message-id;
 bh=HT+SDIfQlIRms8FxF8pg1Dd1jnfWIMjWKWXnYtBy3qs=;
 b=owGbwMvMwCV2xczoYuD3ygTG02pJDOkHQk9ZPbvoOmHlxuaJDZfX8Trd8DLc4Bz8IH46h9P5+
 vvrY5/qdZSyMIhxMciKKbJsaBLymG3EdrNfpHIvzBxWJpAhDFycAjCR+k6G/zUTQotfiQo+yQvm
 5Hi5Y1p4ILN396dUp9dLj5aWKDDfCWD4HzZhlsL1snrfNYtM+x++1dF5LymzNXnbw7QF6Wrrpjz
 axwQA
X-Developer-Key: i=jcalligeros99@gmail.com; a=openpgp;
 fpr=B08212489B3206D98F1479BDD43632D151F77960

TAS2764 can be programmed to zero-fill/ignore certain TDM slots on a
shared I2S bus. Since this is a per-chip setting that is a consequence
of how it is implemented on a specific board, express this as a Devicetree
property.

Signed-off-by: James Calligeros <jcalligeros99@gmail.com>
---
 .../bindings/sound/ti,tas27xx.yaml       | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/ti,tas27xx.yaml b/Documentation/devicetree/bindings/sound/ti,tas27xx.yaml
index fcaae848e78a1137e4d44f98258207bba68772b9..d65a278c92873b00bf357fb26b430386e7860e54 100644
--- a/Documentation/devicetree/bindings/sound/ti,tas27xx.yaml
+++ b/Documentation/devicetree/bindings/sound/ti,tas27xx.yaml
@@ -50,6 +50,10 @@ properties:
     $ref: /schemas/types.yaml#/definitions/uint32
     description: TDM TX voltage sense time slot.
 
+  ti,sdout-force-zero-mask:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: Mask of TDM slots to zero-fill on a shared I2S bus.
+
   '#sound-dai-cells':
     # The codec has a single DAI, the #sound-dai-cells=<1>; case is left in for backward
     # compatibility but is deprecated.

-- 
2.48.1


