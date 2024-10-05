Return-Path: <linux-kernel+bounces-351783-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 97EE09915FE
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 12:31:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23A4D1F23B92
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 10:31:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3142114F9D0;
	Sat,  5 Oct 2024 10:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XKnMFfsi"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE75914A0B5
	for <linux-kernel@vger.kernel.org>; Sat,  5 Oct 2024 10:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728124275; cv=none; b=ARZBItxIzQlj2cuLZ7vFo9NNAXzq5OQJvOUg5iwbkHwoLpWBRLFw8LgzHlDFLdIz5V4+aUdGZNI+GlhZ/M7rg+InR2+gjHdr5fJFFYM8zhHTvKpdphU+Qs7vPAG0Fuf3r51B4yMQzgUFQGlRemm5xgFXNs2tNHu+1XCmKU5JA1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728124275; c=relaxed/simple;
	bh=KuJYhS6BLwFHq2M3BsUApExs70W98G5/TG0tISRMP7Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=B/hp5vft+tTlrPPwaz/USdQ3XvkBMuYgw97tmCUdLo4CYlxO0WJAqoEpzHeZyD9zvwsFwHDzBmOQ93tlNd9PdIdHwGSyreF5N/uRBwbl52wUw+nkpM7ItVGTneNROLAqDLwSwuNZpDDJX7MLaCnEDQn/ytXimRI7nq/T5wSlIWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XKnMFfsi; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-42cb57f8b41so37315305e9.0
        for <linux-kernel@vger.kernel.org>; Sat, 05 Oct 2024 03:31:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728124272; x=1728729072; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wDWnOefZjmiIEjMknhotah0eI13dQMdxoD4kz7zvhSU=;
        b=XKnMFfsiTHJjgIdseT6Kn5dvPFbvqggbHyJftH7ZvxhXGplPDShhe+XHWLjnnyYxyz
         IZmMwHvssoiJLsrlI5/sviWLLrXUJwUX4FNbAMVxxQcd8Sq35HDqStZ73j2+LelQJDQM
         LavjZP+vjwimN+JJXvkrQmVMBEcIgNjA75IP1S98azEfdBPtZTYN1BaimRgj6rySbNYW
         wlo0pH1LyAfndEZkXCpU7AJlwRw0Vlp9rUykGTy6KWBBjuMpMCi9D6rcSonvAs/IkHxD
         8zGdwjQOU0sMGnsRQq3qWrG/adZsWYXRYzyHeIy3GMRAdPSgPdiURTgZllYZDFGxqSsH
         QhGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728124272; x=1728729072;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wDWnOefZjmiIEjMknhotah0eI13dQMdxoD4kz7zvhSU=;
        b=JSQ+zRk8ImpS2nBXVXKVjUWyO1l5pput86Fu6+uMs+CRCZoKVx7qW5S3ppRCEhp9Vq
         tnolsDScyZTCzhaCwXA20NUdkSo1DqaEyLut8+Pw89TSTaLRUOQ3rBrjXdL1czIsA8TL
         bwuHElqvIXN0xxmi9YpRxGHNbG+WOT8UOq8odoRdF6KLuM6d8oBgGz3+Kttys5OpFd7r
         4dnK8mK3pOBVKbbB8k1sGwMygbZWo6ck50KtFg5q8iLOb3vwRjjzRFqVIVqM8DN84Zso
         2snd9xFLaLqdzYZBzmTWz6PcRGQ+TCatCHczUR8Aj4Vr7km/PDwKcKcttsy8lDiph1Q+
         WEkA==
X-Forwarded-Encrypted: i=1; AJvYcCX3qLJSacA7557+mNVu7zMxHW9frGgzvS6VPQyVnwDgQW2/anE3q6PNlvHNdhU0l11bxeqHOE7IhkHvbLc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRz3UcmNXAUVCWhHOMTl0oxv4B/Y6+OOyt0KsjV9nlV6PBw2l+
	/oYIS+oouUGrIZvmVUIc0eHL//9xbAay2KjQQsHFeIBUJ5wbD/AnN2bZlxLJf+A=
X-Google-Smtp-Source: AGHT+IFTJaGLuVeiz/URrKiFMl/ObSaOX7rTRCjs+ik5O7L2vVG+w8UUYNMwtTMYka30+t859f4IYw==
X-Received: by 2002:a05:600c:293:b0:42c:b802:47bc with SMTP id 5b1f17b1804b1-42f8db3e896mr4351935e9.34.1728124272164;
        Sat, 05 Oct 2024 03:31:12 -0700 (PDT)
Received: from [127.0.0.1] ([176.61.106.227])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a992e7856bfsm116315566b.138.2024.10.05.03.31.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Oct 2024 03:31:11 -0700 (PDT)
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Date: Sat, 05 Oct 2024 11:31:05 +0100
Subject: [PATCH v5 3/4] media: ov08x40: Rename ext_clk to xvclk
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241005-b4-master-24-11-25-ov08x40-v5-3-5f1eb2e11036@linaro.org>
References: <20241005-b4-master-24-11-25-ov08x40-v5-0-5f1eb2e11036@linaro.org>
In-Reply-To: <20241005-b4-master-24-11-25-ov08x40-v5-0-5f1eb2e11036@linaro.org>
To: Sakari Ailus <sakari.ailus@linux.intel.com>, 
 Jason Chen <jason.z.chen@intel.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Sergey Senozhatsky <senozhatsky@chromium.org>, 
 Hans Verkuil <hverkuil-cisco@xs4all.nl>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, Bryan O'Donoghue <bryan.odonoghue@linaro.org>
X-Mailer: b4 0.15-dev-dedf8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1588;
 i=bryan.odonoghue@linaro.org; h=from:subject:message-id;
 bh=KuJYhS6BLwFHq2M3BsUApExs70W98G5/TG0tISRMP7Q=;
 b=owEBbQKS/ZANAwAIASJxO7Ohjcg6AcsmYgBnARVp5Gj1nry9lNTa8Pb3pZfveRm/Y1XwWca4P
 l80hK1hq7+JAjMEAAEIAB0WIQTmk/sqq6Nt4Rerb7QicTuzoY3IOgUCZwEVaQAKCRAicTuzoY3I
 OhsREACsz83KNPTLwh6GOaVyVHVFSyU+OW6Ws4BItgxBfGhIxAygKNKYlFt3ZakuK90k9s6f82V
 co152IJh6OfHhgGnAxcBA01TU+IrYnC2b4eUkLryXSq+jk/XRZdbWI2xsWTIJBNm2gUcbTjQtiZ
 rjX0a/GfjD0vv+TUZyX/JrnH13oO31GesrqdLtaBSh5dbHl2yudou3//+rqGil1xL8tMbhsMKY5
 8jpoJI6MmQiGYm98UIn36eBeBE6lBnPF6J80UVfBs0ce96Zrg8ZWmhM1w86XRKKZYJwThgKUXFN
 Khl8ifOzXpBirKsMCrJxNVJS0uh/cKkgjRVF/5uM5+XXV08m07G32apN+xvCxMAK67LAoFCuxSA
 8W9X394by5pTS0n1Ty82AqI4U+xKHrhp4H0xkaL1LilkPuTulq2WQsz906ziUmoXTA8V4C60Jf2
 cngUSoN3oVDh6tVx7v390/7LYACheVZgV+gx0mMsjVYGf61WLRBPs+tc+/xYo7gqvqRSfzxFzWg
 Ifc0vURWgRuHdtYQP3esDXcobsI1v6qNd5GE+y1MLV0b036exW0TuzvtW3xZkUWkEsX+2n3Uw2n
 PQqQUdMLO5Mh7nSwZxseZI+goV3+KeaP8dGBuzaiYyYxyOOrtzhNM4dlMrLCZiPY1PEg2HiQYOu
 uzotZ/poXcPbEUA==
X-Developer-Key: i=bryan.odonoghue@linaro.org; a=openpgp;
 fpr=E693FB2AABA36DE117AB6FB422713BB3A18DC83A

The data-sheet and documentation for this part uses the name xvclk not
ext_clk for the input reference clock. Rename the variables and defines in
this driver to align with the data-sheet name.

Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 drivers/media/i2c/ov08x40.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/media/i2c/ov08x40.c b/drivers/media/i2c/ov08x40.c
index be25e45175b1322145dca428e845242d8fea2698..3ab8b51df157af78fcccc1aaef73aedb2ae759c9 100644
--- a/drivers/media/i2c/ov08x40.c
+++ b/drivers/media/i2c/ov08x40.c
@@ -1215,7 +1215,7 @@ static const char * const ov08x40_test_pattern_menu[] = {
 /* Configurations for supported link frequencies */
 #define OV08X40_LINK_FREQ_400MHZ	400000000ULL
 #define OV08X40_SCLK_96MHZ		96000000ULL
-#define OV08X40_EXT_CLK			19200000
+#define OV08X40_XVCLK			19200000
 #define OV08X40_DATA_LANES		4
 
 /*
@@ -2081,21 +2081,21 @@ static int ov08x40_check_hwcfg(struct device *dev)
 	struct fwnode_handle *fwnode = dev_fwnode(dev);
 	unsigned int i, j;
 	int ret;
-	u32 ext_clk;
+	u32 xvclk_rate;
 
 	if (!fwnode)
 		return -ENXIO;
 
 	ret = fwnode_property_read_u32(dev_fwnode(dev), "clock-frequency",
-				       &ext_clk);
+				       &xvclk_rate);
 	if (ret) {
 		dev_err(dev, "can't get clock frequency");
 		return ret;
 	}
 
-	if (ext_clk != OV08X40_EXT_CLK) {
+	if (xvclk_rate != OV08X40_XVCLK) {
 		dev_err(dev, "external clock %d is not supported",
-			ext_clk);
+			xvclk_rate);
 		return -EINVAL;
 	}
 

-- 
2.46.2


