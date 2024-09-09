Return-Path: <linux-kernel+bounces-321531-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 08CCF971BC1
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 15:54:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A85211F236EF
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 13:54:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 440EB1BC092;
	Mon,  9 Sep 2024 13:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ERrNHWWu"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E45711BBBEA
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 13:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725889914; cv=none; b=D6ABpPoAs/qqJk5dH9xIGploz7LiNq48qATjYtNvakmL7vMIfIy9S2LKbz+YMNHec5z+GqmhKV76MpzFUG8AYcBP1lhI+XO5mh6GUiho2hqsOGbJZYLLVc1vIaHi+keH+a78j2ydaoL7mQ6l7DUb28rokqDhunL9li5Yh+Yy8b4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725889914; c=relaxed/simple;
	bh=rxHbd8ZN2Gnll5CmN6olaVIKBgECJTgaQrtvW4I7hxI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CmdWQ4VdtehxRGQiKQoEJ9HZAl3jmFfSNL4i4cGfu8XTsPa432tjO4naJMM6+i3ehHSVgkjsM7mpqic77O8fd0y5ad/T896Do3UyYXVwBF1GE+AFf0RNtHqfOPaNC85SVEqX/wMk8C/I3AtqRnM9tCkWVZudZlRBGO+09KC70YQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ERrNHWWu; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a8a765f980dso26499066b.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Sep 2024 06:51:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725889911; x=1726494711; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e4nMk71Ror4dDuFejQdNMVkNcSGmGkDbOfs0S0Gk4o4=;
        b=ERrNHWWueLsdsvtS7r7ye4oD1Ovlq1L0rsPrl0lhIT8tG1vLMdWtC8cITRo0joMD2Q
         03lx+VTi1MGh2rK1LzMUpGJTpo8gClL6UpwkC9f8OPdqTimvBZcBzJ8ku7N+gBmHsfYo
         54znMtOzzxMrHrh3qZDFXBG9Qqfcb+ReVIeKLZXRyxdx+DjbF9yh1XTuDKx53+Hnav0K
         N98LPXgHA9/OC9QDtp45mKMiMMtqpYo9pVEFdy8/yrmvfFIE5xCO7l75VPH1BmtXDyPg
         XT/6PP4VBD8nEtUtmO4l6HG2pHT5XOLlm/kKmhVjaVls+v58QZkvijmD3WM/c7xp8okX
         WnlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725889911; x=1726494711;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e4nMk71Ror4dDuFejQdNMVkNcSGmGkDbOfs0S0Gk4o4=;
        b=TmKEBEwtw+psAmvs43H+3qsUzk9O9A1ICGSOP4m/1Ht4hszea0z9ba3K4T86j8l6fA
         WQ52W+Jf2tva7Ib85nZC2PwUn1prVXGfdCkV5/wc3tyo0V2YPHii7BbXkFgBjC3s8uZ2
         ziwWKeqRsA/RwbvXupjNg83wLuCSjWNuTUhBTbYIXrWGZkRcoYCdDj+9Ov/7vSoxF70q
         kdUxc74VjdwVnIhbojTF6f3TXxPHizup5DiNutwggJbWbrHZF4SELmqWljVugm0gsr0+
         hyEyXnS3Kw8Wp5NITrC+mm2hi5hlcOuk1/i6HbAqi1x/TYAYYdPCt06K5NH3CUG6IFIP
         foFA==
X-Gm-Message-State: AOJu0YzdApfzyLV4vEYQ85A5s6+GQvF6BeUEy+L6uMLscqIY6IGDdoul
	l9RN1q5gOkIVWWG6oLyEBls1Pz2WpnpI00bMsiD+FhMYsF6AogFDZZ68jPypWns=
X-Google-Smtp-Source: AGHT+IF2PjCN56jaALnPx3R93ZXhQvgFBd1aE1EAodWyw/lW7I8GsseYFB7PzSZqIjBvJb78EvrSWg==
X-Received: by 2002:a17:907:3da7:b0:a8a:81ec:f731 with SMTP id a640c23a62f3a-a8a885c3265mr378374066b.2.1725889911134;
        Mon, 09 Sep 2024 06:51:51 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.222.82])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8d25cf3ad6sm345344566b.148.2024.09.09.06.51.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 06:51:50 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Mon, 09 Sep 2024 15:51:20 +0200
Subject: [PATCH 09/17] regulator: max77826: Drop unused 'rdesc' in 'struct
 max77826_regulator_info'
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240909-regulator-const-v1-9-8934704a5787@linaro.org>
References: <20240909-regulator-const-v1-0-8934704a5787@linaro.org>
In-Reply-To: <20240909-regulator-const-v1-0-8934704a5787@linaro.org>
To: Support Opensource <support.opensource@diasemi.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Bartosz Golaszewski <brgl@bgdev.pl>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=991;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=rxHbd8ZN2Gnll5CmN6olaVIKBgECJTgaQrtvW4I7hxI=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBm3v1gk6LT/h4VMebCtZMbJoCRkBZvx8KAMANRf
 n9s9srNC/uJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZt79YAAKCRDBN2bmhouD
 161kD/9Lp6g4Ua2xpAlNHKFc2J5G5EkSOmL9wRmeRWCqsIzq5Ao0p02ZQ/8kTCNSxibJ8bPQuIK
 m64QJ0LFlP7nWIYw91ctKvfqnOy9UrHRju3r8U7TXRUYNFab/vQ3BrceR6gpzcLhFXvfTX5En9+
 JRGMtRd5J5AiGl5VBp5TIig09DqDdVkFCEpKDBn9zj49laVzNo+V3xue8dnGynTAxW9z2buAKmw
 gMI3QvQEEk3fqKFNxGFJExDUoC6NHK5qBENhj4+JjHPbYN+gS0KSxwYT3EfTxhE6ufKfpoQzaOX
 2bvZ9kMCCaaayjeO4s/J0YlxHCdjAnFy0iTRQ3Q+lWkWbCoYT8KKOU54FAEfvqVZl1M1lCQ6OeG
 lg/enr2QZKSc3XG6+Qld8the0DM7gOehFJyT02OTsv7Q4Mk93qun+f38yHQOuxZxJCcBmIZCRDr
 1udf/OsmXR9Gl0qG/QEslImmSd2+1Kw1McycPnPgPWMGc9hhQtxycEKTzCqDDS/+Pq8rgBZ23em
 Ck/jxoX3WTakTQHwWJBUqXjZzFeBhpEWY+yGphtd7kJMlyHZoHCbUfloX27j8SAas98RNlyQxpM
 Tt5GlM0LkHrEzEyWqRpdSva0G/5/lYGNTKtPDYZWm+xvCXgM4jEa5Zx8VCwN0F7GpxQwPiL9omy
 hTqm9UKegqYPonQ==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

The max77826_regulator_info.rdesc is assigned once and never used again.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/regulator/max77826-regulator.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/regulator/max77826-regulator.c b/drivers/regulator/max77826-regulator.c
index 5590cdf615b7..4b656a694108 100644
--- a/drivers/regulator/max77826-regulator.c
+++ b/drivers/regulator/max77826-regulator.c
@@ -153,7 +153,6 @@ enum max77826_regulators {
 
 struct max77826_regulator_info {
 	struct regmap *regmap;
-	struct regulator_desc *rdesc;
 };
 
 static const struct regmap_config max77826_regmap_config = {
@@ -246,7 +245,6 @@ static int max77826_i2c_probe(struct i2c_client *client)
 	if (!info)
 		return -ENOMEM;
 
-	info->rdesc = max77826_regulators_desc;
 	regmap = devm_regmap_init_i2c(client, &max77826_regmap_config);
 	if (IS_ERR(regmap)) {
 		dev_err(dev, "Failed to allocate regmap!\n");

-- 
2.43.0


