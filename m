Return-Path: <linux-kernel+bounces-536229-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EF18A47D23
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 13:14:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CD02A7AA213
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 12:09:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E83E22D4E6;
	Thu, 27 Feb 2025 12:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gLAKsci8"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9348F22CBC9;
	Thu, 27 Feb 2025 12:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740658143; cv=none; b=fk9L+99fwO3FgBxoGRNPb97HKS0OXROI8mdh3rHF0uHQ96dw+0qkME3Yla19TfbHNWbOwYqPZjSbCvc0xubhqrdSWaNcyHEqc7QeIJPDss/pTzsn2UpHFG5b3x5RS9qE3mdogZpBXlw3vOpAOqJMwaSCDeX1ZksdHaZ3BbxPIz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740658143; c=relaxed/simple;
	bh=XHik9mYL+2R8oi63Ob2TqU9Gy251Jz/Rt2dJan9+2QU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bD26xZLJSx1HisOI73PFDFk6AtlKeuF94mmIwPdA3t8NP34MI7IqjVV+gU3lU+HKS2nRfi3XoOQZ/493p7YmaVb8g3DpW+9AtaNZHbRWc/tYjprl2fGkNF3EN/ISF/57e4L7BmJUWyXcQGSyZlroSS+wcs59LjDLRjIkXvX6bwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gLAKsci8; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2210d92292eso20199085ad.1;
        Thu, 27 Feb 2025 04:09:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740658141; x=1741262941; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CM/hSNgGpTABnTd1mLn5ynew+5ys2Any/2l/ODxMfjU=;
        b=gLAKsci8HAEhSwp+3avoXx/1Ky6oSOiNcaXLS/uKsJ/29ZCBHv9ebkvEgbqk8afXap
         MPTTZvv5MIp1ro1jMLjOd65Ke1PVIcTcstcn7QRTh/8iK/LA5rky8Mj2LafW5ezydqHT
         hTn1qar/yvEaMYmjfDRxvfWy/p2TUGKxWxMUwjrjum3r8o7Z75ol+8c+JkQw+2XM7Gom
         nKcP2tNgYhXuXBHDngEcuWGjujv5JjmqA3U1xMDkBkVcmYGFW5Qj80iGwCnyAenYzZGt
         fEfdDBmeECFp1qRsxgPQPhVZbhFH5NDadR9dpJiMEskC32MVC2rETKAMU85+XnOQ85g7
         23qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740658141; x=1741262941;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CM/hSNgGpTABnTd1mLn5ynew+5ys2Any/2l/ODxMfjU=;
        b=a8lzSpTDfubedqxcbqeuR4GsFhveHezzjLtFkoGQoailboe5oeXnUjOlbLkQAMtiPy
         blU8fgM8Ck38EVI5pGkIdZW3mPIdeMFL40WwbTo3t3IYcuwLB7j1sYdRft4LK7zCDXNR
         dP87ygiMcCebZ3WTbCT3BEYZLv8I9AfSkpFcOblzY37VoY3BPWcPVIf0Q4LVZpVLgMuD
         1QA1xu/JpB926BVg8LUHgQ0MRTLuwuTbfhsQvlvt8PKPJfW2/r3PR93rKWYw788sJ5B8
         clkbZMoFKfBicqYcRNCMByw4oNrBw1cfJvivOi0F93lG+oG7NuoOXd8KwuwHva64V7Jf
         MrQA==
X-Forwarded-Encrypted: i=1; AJvYcCVwFSSKxbYlGy+4ERTyOvK8ITMGwOSCBR0UcEG1xtnj4o1VKZ+1mWMeBvwexFII2Q/kRdOSj6isLRKAeDo=@vger.kernel.org, AJvYcCW/0kSVhEdNzn4NDFH5wKkuVdAGOf9FpRo/9xeuchPuJWyIonPWct0krudjwppc1yWbqMxRD1E2lKyTOwvw@vger.kernel.org, AJvYcCWjh072El4dvYHzlSTCGDrPW6Bk9oYb3YCc9N9dwUpq9iGWthuNr264i8KDLU8HJEgXgFwqj8qfdS0Z4/Q=@vger.kernel.org, AJvYcCXyKPCbOiHS0M5ayvUdFQZkseZpfrG9mbtT3fvbVNTb6ynEJag1pNjADhtqif/yt3P8Jvmtjtj7PDuT@vger.kernel.org
X-Gm-Message-State: AOJu0YxIxSzAsgS+vnLVpgxx8KMsgAM0zBaOT1FCAfoO0nLSa42dQUyp
	mYG2QaGXI65ObODlha0mz6Nf59vGAjPb4xbjLf5/0MrI7j0dsWPk
X-Gm-Gg: ASbGncvzNqYebKx+fS0l35Zr8cXuRBq/amE0zrQASN1vAi5Gu2FzpxH4WqgVwfJW73J
	8jslg/B9M5q7H5avPUgfVjoaoXApOqpSdIF4MFMp/Fc6OE6b4hMSrjGIJ+F3U09S4J94URNirmj
	JfAHYy/4HEdL3+VGfmF1FL0soVn0oyMpH++XEkdVXOsGUUVwuHzEZrZ3mYdrVOIY3H046afDQEG
	SgX9zjXiMP59mviBx/pDbEk7bBQBp/h6sPzrrbxI2kzSpnDUuphvun2M0TP39EJYN0vbmRTVyGa
	oKD+QivO53xE043MouOxxIR9LJt+OP/lOzLnRBspMCY+94Y5ofHXLTCklkObzlvzHNEZNbfy1QU
	FW+KYsyXrOUXReOXpKibl
X-Google-Smtp-Source: AGHT+IHkNwkeCz1bkgth7yqq5OPbVsiQcDfZ+qpp4u+IIzvYKUCHV3sJOsMaIADyE1zAtG/2sg/OZQ==
X-Received: by 2002:a05:6a20:4305:b0:1e1:e2d9:7f0a with SMTP id adf61e73a8af0-1f10ae8e5dcmr13009072637.34.1740658139505;
        Thu, 27 Feb 2025 04:08:59 -0800 (PST)
Received: from [192.168.2.3] (2403-580a-80ed-0-4835-5a07-49e7-f115.ip6.aussiebb.net. [2403:580a:80ed:0:4835:5a07:49e7:f115])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-aee7de19cdasm1074217a12.24.2025.02.27.04.08.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 04:08:59 -0800 (PST)
From: James Calligeros <jcalligeros99@gmail.com>
Date: Thu, 27 Feb 2025 22:07:28 +1000
Subject: [PATCH v3 01/20] ASoC: dt-bindings: tas27xx: add compatible for
 SN012776
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250227-apple-codec-changes-v3-1-cbb130030acf@gmail.com>
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
 Neal Gompa <neal@gompa.dev>, James Calligeros <jcalligeros99@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=999;
 i=jcalligeros99@gmail.com; h=from:subject:message-id;
 bh=XHik9mYL+2R8oi63Ob2TqU9Gy251Jz/Rt2dJan9+2QU=;
 b=owGbwMvMwCV2xczoYuD3ygTG02pJDOkHQk++3N/P/ma/2cp+1imlUvwqe53lDsn8/LdXL3/Vv
 qIviUr3OkpZGMS4GGTFFFk2NAl5zDZiu9kvUrkXZg4rE8gQBi5OAZhIZj0jw5dHxaI/DtRX3pi0
 TmL6stf9dRx5rlKNZ1rMJ8qHn1wV4cvIcJF/d7vuvYaGVLUzd75/CZVtK3y6MFdKjNvy2clmkfQ
 gZgA=
X-Developer-Key: i=jcalligeros99@gmail.com; a=openpgp;
 fpr=B08212489B3206D98F1479BDD43632D151F77960

The TI SN012776 is a variant of TAS2764 found in Apple Silicon Macs.
It continues Apple's long-standing policy of getting vendors to
spin out subtly incompatible and Apple-exclusive variants of their
publicly available parts.

Reviewed-by: Neal Gompa <neal@gompa.dev>
Acked-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: James Calligeros <jcalligeros99@gmail.com>
---
 .../bindings/sound/ti,tas27xx.yaml       | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/sound/ti,tas27xx.yaml b/Documentation/devicetree/bindings/sound/ti,tas27xx.yaml
index 5447482179c14ee78885e5bee02f4549428694a6..fcaae848e78a1137e4d44f98258207bba68772b9 100644
--- a/Documentation/devicetree/bindings/sound/ti,tas27xx.yaml
+++ b/Documentation/devicetree/bindings/sound/ti,tas27xx.yaml
@@ -24,6 +24,7 @@ properties:
     enum:
       - ti,tas2764
       - ti,tas2780
+      - ti,sn012776 # Apple variant of TAS2764
 
   reg:
     maxItems: 1

-- 
2.48.1


