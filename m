Return-Path: <linux-kernel+bounces-289925-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C047F954D64
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 17:13:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E30A2869D6
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 15:13:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA3231BD4EA;
	Fri, 16 Aug 2024 15:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="s0aSfQci"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81A1C198A3E
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 15:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723821228; cv=none; b=dFNZmckaxE4EqFAO7RKEssMRmmvCxXKCk+iNo5NDTGD9uPu0y9shWb+o4BSx/EGFJrqNpbq7gHBTb/0Sra9pInE3tGPryhBfhJpVPPtQmo5Zi7xf+JYResQvEutekCi6LWIPhA+F3h9Ds/vjBc6NBWbmnoNjr0s+8AnP1ZnTZwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723821228; c=relaxed/simple;
	bh=XdX9TFTmAztBFpprLFXuMb8FszwPT5OGoKC3R6HmiE0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=D8SrVzC7Nq6ZmVj6BSTDUOxsNVxIzCgwDBKLtjP0FaK7lr+EII8kQNH5TaXP8j+0zpKa0g9gXMiUA9GxBJjh8kteDHWFQpUHGnWeX8F03KpFFXvJQ4Pe0yS3pFk9Jl+YexB+gX+QXPEMhUmFs32XOQrE347d573ocbV8z7zpAa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=s0aSfQci; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2f032cb782dso19439241fa.3
        for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 08:13:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723821224; x=1724426024; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ss5iRyP+GViMYSXSV6/9YpYWRY4hwPc+O4Zp1rAHqvE=;
        b=s0aSfQci58PxvrSQy152ZVpO+6OOIon7eZLJssFRxBXFdRwKwrgkW/AbJuC9cqNw5D
         fTnRaHHzN3zWDBZDMyiLawaDlU/1cmVtVbo1rfoJ+HCPndXdu+C9LGAUgnXDpa1CM8PU
         m9SzDCveqnGnX833dDvpFu0o8phFQlStarXAEX/2mVHxp55FbmMTMg7+kMoer/e+4kGO
         TRyW8eVF1L8mMKW55vo6E6sfOEZk2bHAQbAlFPyIm+8LMnyZNGmQc+vXWrMWHD3WO+/4
         aLZXUDWamPLZiaUEO8RjEnSWsdcMFNKB3vIsuSGmwutHTAzJ7GBAuWoBfnbAgBZG347b
         /YVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723821224; x=1724426024;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ss5iRyP+GViMYSXSV6/9YpYWRY4hwPc+O4Zp1rAHqvE=;
        b=xSZ3tldFkjNf77F3I/vK0XBYaiUxzWS1tOSBocmf/bGIXUcRNSOQMwqznxh+cB0uN4
         fZFEmw+aneZSxblxbGyGu8vE+2lolJD1clPA89wDccbMemWW1IRM/GjE1Aukv4mI1kTg
         qFgsARMLRMwdoly8DzNBdSyiWPB6cLw6mbpfesvOO+GBgN6ySrb+FS5ccUKXf2q58ac8
         uJriK7RdDqvl01FbfZAWg6wEG72JU8v2evcbDLEkF5RsP+AfeGYscoq35DLMDm5SyMz4
         OKfjWc8rsueeki6/009uYfLZYos9NrSHRnkPvzQJgwB7Hmw7z4QYk86eL7IvBoYvZR8g
         xGCA==
X-Forwarded-Encrypted: i=1; AJvYcCVvhc7Nk4F82yPwG4kYLcZg1ZES/hoZdZYIW7RO6MnNKTXtVeAmEO7gDr/L/mjny9I8D2m3byJIsrVc/ScgCPns4jxC5lxq4tB7pIFL
X-Gm-Message-State: AOJu0YzPC7sMwUV+UX0N8R6gzcksM8Z1JDNHU2DJP3EWKo2QGx7fNRCt
	9t2oP0JkIR2UaQFsfGnRMPkZ9bXFje+IM1gkaL+86CbUi6Io6lTDuL35WKvu9772KI10amF3J4r
	o
X-Google-Smtp-Source: AGHT+IENaJHmCWMCAiFDXiDCFYY5vetxC5fst5EKVjwRV83jh6OIzG2gQxGx/vK6egR/TndNLUxLUQ==
X-Received: by 2002:a2e:a990:0:b0:2ef:23ec:9357 with SMTP id 38308e7fff4ca-2f3be3df688mr30264741fa.0.1723821224246;
        Fri, 16 Aug 2024 08:13:44 -0700 (PDT)
Received: from krzk-bin.. ([178.197.215.209])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429ed649019sm25425415e9.8.2024.08.16.08.13.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2024 08:13:43 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] i2c: simplify with scoped for each OF child loop
Date: Fri, 16 Aug 2024 17:13:40 +0200
Message-ID: <20240816151340.154939-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use scoped for_each_child_of_node_scoped() when iterating over device
nodes to make code a bit simpler.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/i2c/i2c-core-slave.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/i2c/i2c-core-slave.c b/drivers/i2c/i2c-core-slave.c
index e3765e12f93b..faefe1dfa8e5 100644
--- a/drivers/i2c/i2c-core-slave.c
+++ b/drivers/i2c/i2c-core-slave.c
@@ -109,15 +109,12 @@ EXPORT_SYMBOL_GPL(i2c_slave_event);
 bool i2c_detect_slave_mode(struct device *dev)
 {
 	if (IS_BUILTIN(CONFIG_OF) && dev->of_node) {
-		struct device_node *child;
 		u32 reg;
 
-		for_each_child_of_node(dev->of_node, child) {
+		for_each_child_of_node_scoped(dev->of_node, child) {
 			of_property_read_u32(child, "reg", &reg);
-			if (reg & I2C_OWN_SLAVE_ADDRESS) {
-				of_node_put(child);
+			if (reg & I2C_OWN_SLAVE_ADDRESS)
 				return true;
-			}
 		}
 	} else if (IS_BUILTIN(CONFIG_ACPI) && ACPI_HANDLE(dev)) {
 		dev_dbg(dev, "ACPI slave is not supported yet\n");
-- 
2.43.0


