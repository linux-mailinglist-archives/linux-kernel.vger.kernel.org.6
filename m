Return-Path: <linux-kernel+bounces-518871-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B296EA39596
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 09:38:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E186916FF52
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 08:37:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36C5F22B8D5;
	Tue, 18 Feb 2025 08:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kwokSjzo"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F87122D4CE;
	Tue, 18 Feb 2025 08:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739867788; cv=none; b=FYX4uKZ6kcR1WshHJbXFuUEz2/NWlsZXGpwwlptbwWPCAdcNDx0TcXRQcmosJHGXLoF/mmRLK2cuReGEbj8Q/znILMM1Vrp4E6QNIEd0YkoVtLU/lxlor2Bm36fG2Yy5yCEOPlZ2hgqM1rYUEzyPEvfQZ7OvX98NpRYxblcIafw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739867788; c=relaxed/simple;
	bh=oJ6cbXoYl9+xunmruMkgIaSkFKo0J5EOCYIf9ToUJeU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qpEXD4EdHAriHikl6wLOH9BRBKRnYnELhxS0R8N7fDYlnRfIsxCE37zDBOYAGhLcqQxSzUr7XBI9vCAjHwCD4/SL0pKlOLiOgoZS6iE+38HiyMSDoo58okt9E5SJI4YoCNofCFyAoO3oxX62RDdmRX3LM9DvFpPnlC24CXVSJLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kwokSjzo; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-22113560c57so46574595ad.2;
        Tue, 18 Feb 2025 00:36:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739867786; x=1740472586; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=84WsiJ5ph/+RUwszy0qEmqgYeEni4YLdWQm6ihbjNcs=;
        b=kwokSjzoO2ZlEwpbfHpt9CEvBVPoVggh1LkJ19kcTGIPhGo4mqqYBQmy+0QbLPXlNP
         NOVHfOVjAsAGJAJ25YccT1wET5oT3nNyVNHZAKP9lDBMKwQSWlPY5EHcnB2Sq+FZmxSB
         01rnfiquIyR1NORM7WApaITZFj7MJA7CpmPBy+YDYmCxZJkk3GY4rv7EBMVT4hbl4ZBo
         qHRFuhSfk2uz9nlLEK3Q2kB63GYrk7cLPWRQdyLkhZ2RvnllgKA6kiDFPZu0tOgEpqzz
         owxLHq6fM5xEA7IEKoDspZY5n2IRjEui3hMsN2qxDI87N/Jzf2jazo3gX8hJbrxZQKy9
         kNaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739867786; x=1740472586;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=84WsiJ5ph/+RUwszy0qEmqgYeEni4YLdWQm6ihbjNcs=;
        b=p5/xHE8ey8TOIPjty0r85QI5Ls7/WzZ0hFNN+/tVGBq4Yt49rjqU8kFJLVGA+H/RIE
         S6fysAfYHb/tJ8v/864DSU0GDKrKYDvnEdW1MwRuTEFegkPiLFqTvEGO/treB4FRiaYJ
         7HTDo5ud2cixXMLOyg2Nq3jeNaiRpb+zl6rPrSVQGRmz5+clYe+GaB8pczz4pG0KxMze
         QDvgLGrgaF12YF1jmj8JIaQ0xTNVoLYp0a8wThInqf2GW1cUb52LAASlqg6vZfhabOJV
         FFuaGSmvutWVh6hrGL/vR9pptmxSFtnCSefoDuTlBXida8aNTy7hnB7TCpG4QyNHAAiO
         AG/Q==
X-Forwarded-Encrypted: i=1; AJvYcCWFcDN2XaTobdLlAgC3LT97VCBGk+dhY9fjouUktLkus3jn+QaWvNjuc0BMNIs68lk6JSOPDD7moyN6LKpq@vger.kernel.org, AJvYcCWozOAddHLRrYQyDV5xBiCPj9bmNbcfWsK4L/AwpDLpCixU3E1MJC14Adza1JKqZFveJotYGIFKO2zH3EY=@vger.kernel.org, AJvYcCX3X/1Rb/p03ABVlNQNKZnUkODzcxAirkf2DxatKj+PpQ6mEN2twKV9dsdzvN1rA8riYgu1MwLwcieFA3c=@vger.kernel.org, AJvYcCXZKhGFHTa4fs1MTcTo6aW4mdpZqhO5+K+FG7JJkV0lmB6P1/6WrLYpUgHfFCfoOPzcN3AnQnLTRDCu@vger.kernel.org
X-Gm-Message-State: AOJu0YxksFlaftCOmH1vJBzxwv3MwOrNYTRSmqJPkTu8kihlL2B9404m
	bzsxlQAp/jzRKfhvgr8zRl8BkXrpjG84qgyiLJebDvMjDNTkyn3L/TyBo0Eq
X-Gm-Gg: ASbGnctJcei1F2e+eMhZrAy8uoI5OE8n/hSXQ/Kn10fgxyZHMyPBgmhu6crxXH6M/Vv
	50SL68DfdjqsCs7JbFROwvP7RMIiNoAU0L5NaANvbib25rLYDDTOZF5YuKpShX704gX70OYG3/E
	zmlJWw76M6o305wSyaTtOza8Iv/EO3zPnLcEyoRtpupUIsezSY4vQNxBtCWoK0gG1+31TIfNzQN
	ALajoo2UKCA2yGiUMNYYhDfl+Imzh9omO/GS5267aQhcm4+suVlKfscMZ4eBHidjly7Jj7DkMLU
	rJfFq+PE+X8gCxueElfFQYFNTmSoSl/82ioVhP2lrsmwWkU+1Koi71MYCDGNvdg5tn9sNcUskVf
	+uHa8sXJHjg==
X-Google-Smtp-Source: AGHT+IGLXFZbwDTW5xQcdsp+acfAsOzwEHRxRGOygcsKN3a2K5ubX6cgUllQPxBgV8283AinHTIRAA==
X-Received: by 2002:a05:6a20:158a:b0:1ee:cb08:d0a3 with SMTP id adf61e73a8af0-1eecb08d345mr1969132637.21.1739867786295;
        Tue, 18 Feb 2025 00:36:26 -0800 (PST)
Received: from [192.168.2.3] (2403-580a-80ed-0-4835-5a07-49e7-f115.ip6.aussiebb.net. [2403:580a:80ed:0:4835:5a07:49e7:f115])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ae1ee4febb2sm787325a12.51.2025.02.18.00.36.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 00:36:26 -0800 (PST)
From: James Calligeros <jcalligeros99@gmail.com>
Date: Tue, 18 Feb 2025 18:35:38 +1000
Subject: [PATCH v2 04/29] ASoC: dt-bindings: tas2770: add compatible for
 TAS5770L
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250218-apple-codec-changes-v2-4-932760fd7e07@gmail.com>
References: <20250218-apple-codec-changes-v2-0-932760fd7e07@gmail.com>
In-Reply-To: <20250218-apple-codec-changes-v2-0-932760fd7e07@gmail.com>
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
 Neal Gompa <neal@gompa.dev>, James Calligeros <jcalligeros99@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=778;
 i=jcalligeros99@gmail.com; h=from:subject:message-id;
 bh=oJ6cbXoYl9+xunmruMkgIaSkFKo0J5EOCYIf9ToUJeU=;
 b=owGbwMvMwCV2xczoYuD3ygTG02pJDOlb3OKTeATfLCqot53+MVCEJ/Mzj6aZjNEN59abEuavZ
 h3gXmvbUcrCIMbFICumyLKhSchjthHbzX6Ryr0wc1iZQIYwcHEKwEQ4Kxj+Svss8bjf7Sy05Vjt
 lu597kd2ZX0UE/q/dvWME5vYXcM3+TMyHEwV63Lm+hW0Z3bjDftNYkuUyvN+6R8oy5Itq1t2L6G
 NGwA=
X-Developer-Key: i=jcalligeros99@gmail.com; a=openpgp;
 fpr=B08212489B3206D98F1479BDD43632D151F77960

A variant of TAS2770 known as TAS5770L is found in Apple Silicon Macs.

Reviewed-by: Neal Gompa <neal@gompa.dev>
Signed-off-by: James Calligeros <jcalligeros99@gmail.com>
---
 .../bindings/sound/ti,tas2770.yaml       | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/sound/ti,tas2770.yaml b/Documentation/devicetree/bindings/sound/ti,tas2770.yaml
index 5e7aea43acedc0f7d8c22e36debfe805c7ebe74f..8eab98a0f7a25a9c87d2c56fd0635ff8ecee17d0 100644
--- a/Documentation/devicetree/bindings/sound/ti,tas2770.yaml
+++ b/Documentation/devicetree/bindings/sound/ti,tas2770.yaml
@@ -23,6 +23,7 @@ properties:
   compatible:
     enum:
       - ti,tas2770
+      - ti,tas5770l # Apple variant
 
   reg:
     maxItems: 1

-- 
2.48.1


