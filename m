Return-Path: <linux-kernel+bounces-536250-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C68EA47D3B
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 13:16:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22B3D1893080
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 12:16:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E0D422FF44;
	Thu, 27 Feb 2025 12:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jyFM+l00"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A25A22E3F0;
	Thu, 27 Feb 2025 12:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740658266; cv=none; b=IIIp4+/k5V2eo/PAADhYFx4v9fsxw+jqpmIF+ew+OaHf+yp3fuX+tRZx3pvZ5bsxhG/YIG3Ou/rlWq5UQtm8+fFHeCYemRldwqlP4cAwOXLzMeWCoAMVvHxYowexHQxYhSSJdEixshiG6KoF6PWlm19ZuvcFJpxYgoQ6pz99SVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740658266; c=relaxed/simple;
	bh=/RBl/n6L6PnMSvwkD9NDOgKfGZgMZ6zIjb5wTfrd6qk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=H4oaK+OfEllYQwgTyhcfST3Wa1ZjmsPfFz548SStVuU2alb2Hu6u9C1520McHZNhsMKKosyZqk/KaN+GOcpS29K/KZmuTtC8jHPIKNIzsQFPO03XlXyqVA0rkxEcjvihhkQApGLdDWtWo6ZLuNrp61sgqFmZ57G/K/rmhQYPW0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jyFM+l00; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-220e83d65e5so13893715ad.1;
        Thu, 27 Feb 2025 04:11:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740658264; x=1741263064; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d0owHslE6nWanzH0GNiSDvqoqhw6dc3ByeCKi8kxRyA=;
        b=jyFM+l00iSjN6WHbV+UyROCkhFYZCJ20QxspOlh9KQji3lQ9nZx5d6ABdGG/AEKyyH
         zldUyownMN7SXngeghC1IZmdcnimB8YND6PuxbHmWX/ouHGxszYuZftygWAt9u7EctUX
         ZV/Tlfa+n7fp7lEsGanfBiuK/OshzvqPrCLWR6pAVGt0zRxdsFt5hbEDlydIIjWMcOAe
         bbSdQuIoMEdcDyYyW1+7bxXTX8XahEIbfqius/2+qqcbFKGGmhsT1ZBTbhfLXp4yfrks
         qXNh2exFp2EfmBup5j685RKKxjCfg0QLU7h10RYyvK+E6Y4lGNw44k8luCFOa4fGKI1k
         Zu4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740658264; x=1741263064;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d0owHslE6nWanzH0GNiSDvqoqhw6dc3ByeCKi8kxRyA=;
        b=Iy5X25f9dXycJv0Puv8B58GlnVM8WY0fDBnnVRudxT5RjfQbeEBc0jIOYIcYiY+tlF
         Wnk9yNPB23WgwCacqZkWjvIZTNw6olHiYh0ayWQHE7aPQOYij7VQ19hfiidFkZLt3XWA
         ranjrnv4+enFUqAif9GJ5ejVo4fhUQG3TxQ7Nxh2P4VVv3fGFZFt9pncR+kN9d5yDbN0
         +9O2veoA15oQB+kBHhdBbeKVR+lmBc1sWeMOMKvvAfP0BKY6KKvlwiFtFMU01p6Oodnk
         2a+C4dq1ZJtZp1e9yU1n8T70CwK+DnrwV0TGLFYGZtgNhdReMoQh+pA9oTX9vuzg8Z5y
         tUpg==
X-Forwarded-Encrypted: i=1; AJvYcCUQn7HZz1ysmqwxCxPuUT5uZQMJoBK4zaWQT/GSk4/bvixK+2yyRZsj4BuBJCWonSnmSTqFu1yVSO36b4k=@vger.kernel.org, AJvYcCUk2sNT8CJLTvJVWVeUbf6dhNWhGTdHmjmMt7cJHJe34dWTU8dxFOfC9/Wu0G0lBA+R3H4pMhNBuHFDTDA=@vger.kernel.org, AJvYcCV6O2yqHWi9HReR+IdJ3aRY0ih1ibFIMXGURMUWGUYWp24vf5L4MZoyqLYkM5GoHfOoCbB+naVOteJa5NAG@vger.kernel.org, AJvYcCVY4vHDsBUV9J0u0iEOFoKp4TyQ272qX1gYXvSQytlme+057fa5/oPswzcy5Cx8JJUrBaNoiEMgQDJq@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5UDfyfyIHttcxdGTCAWdLon8Ido2QGWub1lkWruGu5EGx9awS
	21oVZZe/lMflhyUZ2lPkfv9eMQNHdw/jhpcQMRlFNysc0IpTtGGLuvieNPkF
X-Gm-Gg: ASbGnctP81vM2WyDkMlR1gqK9aConK9etPcqZimPFDiTk3XQi60AYoiyGn2dfG7jjdN
	mMilq+HZCsGFOMEoovGyTosScVr/hdBCwTs5kCfuX/qYyQYwuk/SHLByU3kR/YvvXtOWtN6Otvz
	Y+l1al9K+FfHqplp3VwTsLOGu5M5Xl7T34NB8pqqMV/WP0+SitXm5xBfUrBoYKRsQmkPYSE12xQ
	p8zDRCn/CEpkb/p58z5Xfcpt4crBFyVoT77r3tfqzoUE/FWGaJR1vVCP/ay099eklGlfRa30arQ
	8wBiCsmmhbMlV2KGsJCfGgNBepuFL+WMsM1XSIUSLtPfszhs9c50miVOQL44gGhcF+flQQDeu8+
	gvUIywWD75ioh/TrYFdqq
X-Google-Smtp-Source: AGHT+IG1QYwei29YHGRdLB2VD8ypHlNGKmJouxhIvqFkj+dv5HEWcDyDzQ8liiu1IfHNMqF+VKMzNg==
X-Received: by 2002:a05:6a00:928a:b0:730:9204:f0c6 with SMTP id d2e1a72fcca58-7348be2cbbamr11394198b3a.16.1740658264560;
        Thu, 27 Feb 2025 04:11:04 -0800 (PST)
Received: from [192.168.2.3] (2403-580a-80ed-0-4835-5a07-49e7-f115.ip6.aussiebb.net. [2403:580a:80ed:0:4835:5a07:49e7:f115])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-aee7de19cdasm1074217a12.24.2025.02.27.04.10.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 04:11:04 -0800 (PST)
From: James Calligeros <jcalligeros99@gmail.com>
Date: Thu, 27 Feb 2025 22:07:44 +1000
Subject: [PATCH v3 17/20] ASoC: dt-bindings: tas2770: add flags for SDOUT
 pulldown and zero-fill
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250227-apple-codec-changes-v3-17-cbb130030acf@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1333;
 i=jcalligeros99@gmail.com; h=from:subject:message-id;
 bh=/RBl/n6L6PnMSvwkD9NDOgKfGZgMZ6zIjb5wTfrd6qk=;
 b=owGbwMvMwCV2xczoYuD3ygTG02pJDOkHQk9/DfJ+/pBN62LpLO0lSpqSr+M1O9MMgk3Upgrss
 Z57I/ZeRykLgxgXg6yYIsuGJiGP2UZsN/tFKvfCzGFlAhnCwMUpABMRjGdkOLj/tPffHnNVnkvH
 LzFOc9rz/8GTZWudZ1ueNq46G3oz9gjDH373B91r7Sb9aQ9frJ9QX7j5gpzphnJVq8drVrxU+3p
 RnQsA
X-Developer-Key: i=jcalligeros99@gmail.com; a=openpgp;
 fpr=B08212489B3206D98F1479BDD43632D151F77960

TAS2770 can pull down and zero-fill SDOUT when not actively transmitting
TDM slot data. Zero-fill is useful when there are no other amps on the
bus. Pulldown is useful when the chip is attached to a shared bus.

Signed-off-by: James Calligeros <jcalligeros99@gmail.com>
---
 .../bindings/sound/ti,tas2770.yaml       | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/ti,tas2770.yaml b/Documentation/devicetree/bindings/sound/ti,tas2770.yaml
index 8eab98a0f7a25a9c87d2c56fd0635ff8ecee17d0..3eba9bb34a581526f68b6bf2e8437e1f1e03d26f 100644
--- a/Documentation/devicetree/bindings/sound/ti,tas2770.yaml
+++ b/Documentation/devicetree/bindings/sound/ti,tas2770.yaml
@@ -57,6 +57,18 @@ properties:
       - 0 # Rising edge
       - 1 # Falling edge
 
+  ti,sdout-pull-down:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description:
+      If present, SDOUT will be pulled low when not
+      transmitting.
+
+  ti,sdout-zero-fill:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description:
+      If present, SDOUT will be zero-filled when not
+      transmitting.
+
   '#sound-dai-cells':
     # The codec has a single DAI, the #sound-dai-cells=<1>; case is left in for backward
     # compatibility but is deprecated.

-- 
2.48.1


