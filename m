Return-Path: <linux-kernel+bounces-511869-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A544BA330D6
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 21:29:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69DD916801D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 20:29:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62042201271;
	Wed, 12 Feb 2025 20:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pZwKHqBt"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 078C120103D
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 20:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739392168; cv=none; b=BlMh0uc1CZn7iSllmw+ykPu1AaXoSjIEmcwfePxB+QGtb/goIE7XIIptfDpeFsKzhVx5Ln05BaD23+1QYNQN+mTdLVF4OqaBoJ+h70p0MQflrKuXUTAAmTBETcFHf5S04nUb5/a+mzlMufwpXO0SAjABvmP+zMypkV7pXznh/yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739392168; c=relaxed/simple;
	bh=fMzZBQwz2zarejgNGL4Eghd7LeFJHEGwlkIQxCyakHM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=S+FoukvKGLfnh0YgXcN9Iy7RfnknvwF2GzVicYoXyNNXhy3/ks/0+ZTe2nMPayeQxjsletKHPFysR2HzLnvCmp7JBFx7PK/6hO28iNzURpbK2yoC8+QZRRBZZlFmoUmLH0gmUg3bHsj+JMZV25qSCyh85wDYTHvU6ykB69FC6Vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pZwKHqBt; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-38dfeb84a39so14866f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 12:29:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739392165; x=1739996965; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=P4Xly9Z4ajTEnrRhuPY7JmSmoF3/UWXiSM6R6mhlLyA=;
        b=pZwKHqBt58QGRlSwPZ1jlpmJZljAA1vRhplovav1qTgBp8PCam6l50AmQ4tvA+Z9Hi
         3mR+IL3Ru8VBt4GrZJ/1tglzvEg1TksiefXvwt6zmZGP6+hZn1vYG9gvOzcpNjrSle+d
         cW4xfKT7nX0N5PkQOZ/AxcP1/KCxQYf867RXtV0Y7qApyr/5plWm47TfRnfPyW16RxXv
         jGLS2c2c+w91bk1+s3hPYn0160jxHqIZ305KLZLJLx3Fim9iPwxkvFl8VK0NOkWacjg/
         J6e7tJtyQ2gdnezZtkjAtssgaqJJEcEthTSzaZ9zta+g0gFxPAEfm7wSRRkSR78+cWga
         NTgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739392165; x=1739996965;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P4Xly9Z4ajTEnrRhuPY7JmSmoF3/UWXiSM6R6mhlLyA=;
        b=NfcZdpBejWm8mNb7CCOwmmY2qbK5lvfRQbePR4rAwncQ6qVgZ5Uod9IBBHKH2iffiw
         B3LqVig4N95DhxSFirYPxW2vRLS2Wz6VZkLLdCUdDupJpAILDOzYj357KvlFUs/1w3Se
         3ahcTl4p5iJ/A9DScKgBPUpJdA74u1kXM9lzHbKIkMerp2DL7ImZ/+HNDKbm4Emyt4Uy
         rDr5GgnBQRNCOskUPJZy7MNkoT5EE63QumEMgphspVIES+3FeytkT8C8JL1SxEqTBukw
         LDhRhktL6RB3UtRwrSct1e7QvpsQfcr9V3zNGhggeM85P4O5JdQGYDZKdT7XH16E3z/E
         JWYg==
X-Forwarded-Encrypted: i=1; AJvYcCX3CH6uIklUbsWxwHFyUUMVT4cORwXsQnR3tR1qY8eOBDyz4kumiCxAIO7FTklVeq8WZ2Hcf6Piw7pRC4U=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvFmDYSsNKchkCmrzzUCFGmE6vaGuc3Zl7z8w/c2kmDpOLjTR0
	YoUtqrnNpgy4M/jo6UPPiC03sS0Bkj9ZfQisIjpRRdyZUj41f0Xk9pdigc0my8k=
X-Gm-Gg: ASbGncvWZZ+R60eSbwMOzb1ASyCS+q2vH7v9Myb2mvywTqOcgtsykxC9d3YT7jvV/zL
	6UyBqSUVJi5qJAaHouyBec5vUGLXfVV04XZ63qy6UESnHNluFkKOUmfORe7z7MYX8e6vG6qiwyI
	h8yy7HIngfUAIlnA3qK5RpKe5O0ulVAEacinQXySvOKoNxAiOfWh0tTjuEveC7Ccu03XzImjSD8
	T9+IIDfxl/PyUUeer8sch/bDhjLN+XwgKzL7pXorH5pmH160ZXtCJ8F1FGqndCNZutO64cb0FIF
	ZTK5Vhl1qC+7Vs8ByBoziKtMwT8Eeg==
X-Google-Smtp-Source: AGHT+IEIX04KbEhnC59jF35sJIWxiziJxxlj7+Pxs6uWKXoNxjH3yyR8TvsCk1zSJHtc3g87I5swYA==
X-Received: by 2002:a05:600c:3585:b0:439:6103:d2de with SMTP id 5b1f17b1804b1-4396103d503mr656295e9.7.1739392165041;
        Wed, 12 Feb 2025 12:29:25 -0800 (PST)
Received: from krzk-bin.. ([178.197.218.144])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f21ea3246sm1454554f8f.81.2025.02.12.12.29.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 12:29:23 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2] USB: dwc3: Use syscon_regmap_lookup_by_phandle_args
Date: Wed, 12 Feb 2025 21:29:13 +0100
Message-ID: <20250212202913.23443-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use syscon_regmap_lookup_by_phandle_args() which is a wrapper over
syscon_regmap_lookup_by_phandle() combined with getting the syscon
argument.  Except simpler code this annotates within one line that given
phandle has arguments, so grepping for code would be easier.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Changes in v2:
1. Rebase (drop of_node_put)
---
 drivers/usb/dwc3/dwc3-am62.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/drivers/usb/dwc3/dwc3-am62.c b/drivers/usb/dwc3/dwc3-am62.c
index c158364bc03e..9db8f3ca493d 100644
--- a/drivers/usb/dwc3/dwc3-am62.c
+++ b/drivers/usb/dwc3/dwc3-am62.c
@@ -153,11 +153,11 @@ static int phy_syscon_pll_refclk(struct dwc3_am62 *am62)
 {
 	struct device *dev = am62->dev;
 	struct device_node *node = dev->of_node;
-	struct of_phandle_args args;
 	struct regmap *syscon;
 	int ret;
 
-	syscon = syscon_regmap_lookup_by_phandle(node, "ti,syscon-phy-pll-refclk");
+	syscon = syscon_regmap_lookup_by_phandle_args(node, "ti,syscon-phy-pll-refclk",
+						      1, &am62->offset);
 	if (IS_ERR(syscon)) {
 		dev_err(dev, "unable to get ti,syscon-phy-pll-refclk regmap\n");
 		return PTR_ERR(syscon);
@@ -165,14 +165,6 @@ static int phy_syscon_pll_refclk(struct dwc3_am62 *am62)
 
 	am62->syscon = syscon;
 
-	ret = of_parse_phandle_with_fixed_args(node, "ti,syscon-phy-pll-refclk", 1,
-					       0, &args);
-	if (ret)
-		return ret;
-
-	of_node_put(args.np);
-	am62->offset = args.args[0];
-
 	/* Core voltage. PHY_CORE_VOLTAGE bit Recommended to be 0 always */
 	ret = regmap_update_bits(am62->syscon, am62->offset, PHY_CORE_VOLTAGE_MASK, 0);
 	if (ret) {
-- 
2.43.0


