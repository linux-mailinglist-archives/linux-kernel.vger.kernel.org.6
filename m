Return-Path: <linux-kernel+bounces-300449-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 15F3495E3CA
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Aug 2024 16:14:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C807F2818B3
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Aug 2024 14:14:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 011C3155CB5;
	Sun, 25 Aug 2024 14:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PltZezpS"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F7C213D625
	for <linux-kernel@vger.kernel.org>; Sun, 25 Aug 2024 14:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724595277; cv=none; b=W8nY2P+l1FjyMxHqTg+BjKr2tzhG8xx+o+2TlTRIdOLgw7+mqBxYOa6UrMe5IJ0x1C/q8TCoJxiypKTzFmrXs9furkO2VfaoNFclSVciGZZUBPmpizEAnOO2DYWpsFiiGs2JXAazY1YX1o9gjgsHAyePNiUkcBnt49MAjzq6g3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724595277; c=relaxed/simple;
	bh=joVnS8DmY0g4Y+2gErHi2Nv91aaUMO657tgyX7t8ZFA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=F2gZqjeTQrsLfBadNq9kTMWNCo81IQ+o85ymwnC30paX9v5nuSiUoicHtak97nw4xOB/DTRYWcRYEHALb8X9hd5d/NMYWUDXgu4CCiPtj2xEeuCUBELlC7cP+6VmQSKwpHCCSZpogFhwsHkrsqWuutH0ZYy8ybYFHkknQ1STyqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PltZezpS; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4280ef642fbso4330305e9.1
        for <linux-kernel@vger.kernel.org>; Sun, 25 Aug 2024 07:14:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724595274; x=1725200074; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3V39aJFJWv5Ox+8nMTcg04luiBvVyWT65eor5O85K80=;
        b=PltZezpSb1SdUjA3B/jtGKfWQ1q8sErWwsqu3hbdQ0Zv6T+0r6ePRVBLoUdv83sVd+
         HqzTUGbAthNmOASZBiwpC1Yk0JDuY+Y/R7P+ds3gzBxguW9UFAEYp5PPuwTSVWe/WYMC
         raZ1OH+6qXstLrZsPX5EEOrrw7WiXt63FWzlKRfg5DHdwGHFIJ5q7dMZx9beFBKTIxSr
         uKqiCYsrmqO/QdKPryPjXLLn9tF5e9/3xxmNqUK63IfucS5SnIl4HOSZ3Vvtfp0zGTn7
         JnTXCyCLzayKUwjgkdpXSRuGGon2hn5D/U2tJCiyxac8ZUIwB1+Damgyb/G9WdF66R4w
         gq9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724595274; x=1725200074;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3V39aJFJWv5Ox+8nMTcg04luiBvVyWT65eor5O85K80=;
        b=Fofk3vftFEX5/M7oFeXbGd70HJPsXf4sjR+ESriUAvVQpUb//JwXofscPKylXe+HPy
         N+V52FJbj9hn0A1AHJIabCtrzElReOaTa8Qb3xw6qYFsQIoFaMLzCZDng8xi1JMB2lSj
         JRBihTLvckhUg5FBatmZ7BTy5TQsEEwy1yjbghTaCuAV3wbprDoP8rp8iYU0HXfcq5Yh
         hfLKbyHmHdnnnkTR1bDoc4a/IQiN/pTD1HyHS/5yBLWtqbPJJZrLLM4GPOqCyiTzcjHQ
         gAwe8/14lWQEtPCEsmtK8mds/pDbPjpzMxeGai4Dr9dgUeM/QSiC3d/u7wz76OCm0UeT
         6CqQ==
X-Gm-Message-State: AOJu0YwqFMERaK/Cb9v8AEZ0Gp/8IMiTjXxm0LAae2bWGdrHXKPmmxNv
	benJgumfaYYPoSeWmwTHvusG/8vlaKtAn21Zr/CwMEClT7Hn2wDVYfZeZ1e1OsE=
X-Google-Smtp-Source: AGHT+IGxaU5SPPeM8id8GkXJPuRmYySTf3YFVPhWqsLL0MARUSWhix2AIa7U5LEypfPKdiEqh4SA5A==
X-Received: by 2002:a05:600c:3b8b:b0:426:67e0:3aa with SMTP id 5b1f17b1804b1-42acc8d50f1mr32658585e9.1.1724595273921;
        Sun, 25 Aug 2024 07:14:33 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.222.82])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42ac5162347sm122556045e9.23.2024.08.25.07.14.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Aug 2024 07:14:33 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Sun, 25 Aug 2024 16:14:24 +0200
Subject: [PATCH 1/5] reset: berlin: fix OF node leak in probe() error path
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240825-reset-cleanup-scoped-v1-1-03f6d834f8c0@linaro.org>
References: <20240825-reset-cleanup-scoped-v1-0-03f6d834f8c0@linaro.org>
In-Reply-To: <20240825-reset-cleanup-scoped-v1-0-03f6d834f8c0@linaro.org>
To: Philipp Zabel <p.zabel@pengutronix.de>, 
 Antoine Tenart <atenart@kernel.org>, 
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, 
 Damien Le Moal <dlemoal@kernel.org>, 
 Palmer Dabbelt <palmerdabbelt@google.com>, 
 Vladimir Zapolskiy <vz@mleia.com>
Cc: linux-kernel@vger.kernel.org, Damien Le Moal <damien.lemoal@wdc.com>, 
 linux-riscv@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1147;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=joVnS8DmY0g4Y+2gErHi2Nv91aaUMO657tgyX7t8ZFA=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmyzxCjY77hkWpo20MJfyjjnVxsKR95SKAeU/iu
 Y3zJ4/suN+JAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZss8QgAKCRDBN2bmhouD
 1/knD/9qX7o6/PZtVNH2lJW8W33eM3FNJFkdfkdS5NFkRnuq3XXEzDEAZLSSv6V/pWOYUEuiS0n
 OO6zl+0bae9XYGJi++SiuGPQBh8B6+5oRMSq2NNF+xcAkq18NJzU7HMi1wR2G6O9qauYQfvL+UD
 JR8TFFHdo+8DEObsVCOEA2ODYNY1+T4ABgXQqfOICeeQyWedx3g7BQ+Wn1ixGEQtvOjACRMjJ6H
 bKo3D7lFjZQ4sMrVTvkRv5UDVx82kBcS+g7QaTMefWaT6V4//kJojlV9rB3XmoOPSxHb1SEbdkr
 /+O5k2BFjG6wnjIwZhEKCBw5l25Y3IHD+ocwkt12CnOffinirDqQOiZ3yQlq2vQdLYxO9dT9hJl
 cysTeZ4B5BSfg2PpfjKB0ItoTeUldc2ZF+5CrO/8AgCxvyvumSAslG0SGGbpjeyX8bdx60Dxkxt
 iy843maH30+bYknaIMDKuY0lwb6p+fCtPR5/fnDhZp2j1wagrZmfZqux4PR3Cs8SUWAcyzH3/bR
 GwOdyZKbYs3Gqgt3kKrUdRs4rOpOhVHA2lsf846AVXufeF7FDtpYav5WtOTno+vngsU5cDeD1n7
 FV0UCpBnyGd61GcPxxbr1VvPpn+WnqXlRmZ4eCApcxWKPsDCn1TdmUg9Ib0+TTu7rEZ9/BJMBpH
 xTPG14fHg7JSC/Q==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Driver is leaking OF node reference on memory allocation failure.
Acquire the OF node reference after memory allocation to fix this and
keep it simple.

Fixes: aed6f3cadc86 ("reset: berlin: convert to a platform driver")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/reset/reset-berlin.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/reset/reset-berlin.c b/drivers/reset/reset-berlin.c
index 2537ec05ecee..578fe867080c 100644
--- a/drivers/reset/reset-berlin.c
+++ b/drivers/reset/reset-berlin.c
@@ -68,13 +68,14 @@ static int berlin_reset_xlate(struct reset_controller_dev *rcdev,
 
 static int berlin2_reset_probe(struct platform_device *pdev)
 {
-	struct device_node *parent_np = of_get_parent(pdev->dev.of_node);
+	struct device_node *parent_np;
 	struct berlin_reset_priv *priv;
 
 	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
 	if (!priv)
 		return -ENOMEM;
 
+	parent_np = of_get_parent(pdev->dev.of_node);
 	priv->regmap = syscon_node_to_regmap(parent_np);
 	of_node_put(parent_np);
 	if (IS_ERR(priv->regmap))

-- 
2.43.0


