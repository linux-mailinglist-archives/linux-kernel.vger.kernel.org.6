Return-Path: <linux-kernel+bounces-289962-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 48718954DBE
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 17:33:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB7001F22E4B
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 15:33:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C59B1BDA9F;
	Fri, 16 Aug 2024 15:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="a14Z0ROV"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF77C1C0DF3
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 15:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723822329; cv=none; b=tbRZASl/iDFPrHImGriH4zci6FNhFNIO+OtenoKYdvcYQVza+eoV/cZcnVdqEfo1CXu0vnQTwPJlfKSrHiJ+rKCiU27Inibu6ToVMmz/kpa5ygfbHDXQY/AFtA9Wzb/S/mRmNqfPiCMusUL3SvF5k+fdw/582BozhEaEst5ggFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723822329; c=relaxed/simple;
	bh=gN/N7MTnfesRcU0ZUz+5FDMsGWVo2Qy6wwU3HvO2nBU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kj35QFp4Ykt7C+efnwSM10ee/6MVHfJibn2LYDhai6NhK6GqO7STYiuYBUv7RXFTz5S9YjPprAvQ2IFIoZbN0VJdRHKIJQ6+kq2UraHb9Ssk9cd310TpXrTz01iah/otI8y5CZvUR5LMivepnn4Rx25vFZb6EVzbbjpYlJhu59c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=a14Z0ROV; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-371a13c7c80so98570f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 08:32:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723822326; x=1724427126; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bO9KX3t0CameG4s7E8ol/+1HoTbso6o0yUSmdA3MC9U=;
        b=a14Z0ROVNTMFCtz5/KnYCCTsImukXJxImZhQ8+le03PpQDDYnPZV89UF7255DPpjul
         iT+7f5QPf5kF4CaaN4P8cuyoiBHq7DXF36NjVlqQWcOrCYbIos5VTgZtQl7QEdE47XAS
         gtCldn/5renLmjVmulJmmfp2Hj6Xh7B4XCUC2xIaQHIcOXGm4w/QTyUhp+0IvUwkKqR+
         4DR1LLW1bP2OcO/oCNgJDTNEbrzzfnNzMnt3IeS+bHdCr5b3uzTZFI/rKVVs3+uP6qv6
         C5+Hnzv4VHCQ0ADuvPOIifZLVBdE+PfRai6GrDH7DAE7q5LHxEwvew+lPukrkAcg4EX9
         QE4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723822326; x=1724427126;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bO9KX3t0CameG4s7E8ol/+1HoTbso6o0yUSmdA3MC9U=;
        b=hBypDsn26vAzwjj72eW0Aytz6fB1F5VBnYb0jFqrtGksw/ZoAtZQCb7gly4XKSyc3f
         tgisIObhwMAg1TuCo5i/MlD8IdyuBFKKc3ft6e9fnI3t9gXZniXanOjOd4vldRJ/6Qum
         IyhjREJGy3ieSSPEa72TzTuX3+qwgbKtBqUeBwBOxwkH3MQ3CHaPrp3OynIED9BRnCKn
         +sMzhhojqqjq/DrRct9O+Cq9me1V7uxx+X2HDP/9KAEXt1B2dfmkMbsBHBff3AVHVcO3
         W8hJZtMJ0ZCX5wgnV/RiHINPfMJv5nVPl2etv4Bvf7wMy9VqxhvzUPLWxil8F2hKXHQw
         Yh7g==
X-Forwarded-Encrypted: i=1; AJvYcCUele1Hg8ubq9P1mmyuAlSUpU2f70aBZa8EHEghS5oXQeQ7uOpxsuOrDtu0MXsccyRNsWtqx8tHxVvmkdmFQT8+pgpKSgO2zYym3ZnT
X-Gm-Message-State: AOJu0YwDRkfQ222QuMItYHVLamG7LNArWBxiFV6W8glk7DE2V1739h+t
	AjqlyhWCi/eoPH4lYbupW/0JJf9XRrFvhnHRziclXU7zk/trP0k6CQIemHGP7fM=
X-Google-Smtp-Source: AGHT+IFO6DlpkZlrb7PQDXCCkwkdt1PkYJMksByyV9gy/3kYvIXYmOf5Fd1cqFTrDNfriARDeJMtyA==
X-Received: by 2002:adf:e6c3:0:b0:365:aec0:e191 with SMTP id ffacd0b85a97d-37186d740a7mr5074245f8f.21.1723822326272;
        Fri, 16 Aug 2024 08:32:06 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.215.209])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-371898497f0sm3853661f8f.39.2024.08.16.08.32.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2024 08:32:05 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Fri, 16 Aug 2024 17:31:40 +0200
Subject: [PATCH 08/17] leds: bcm6358: Simplify with scoped for each OF
 child loop
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240816-cleanup-h-of-node-put-var-v1-8-1d0292802470@linaro.org>
References: <20240816-cleanup-h-of-node-put-var-v1-0-1d0292802470@linaro.org>
In-Reply-To: <20240816-cleanup-h-of-node-put-var-v1-0-1d0292802470@linaro.org>
To: Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>, 
 Sean Wang <sean.wang@mediatek.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Riku Voipio <riku.voipio@iki.fi>, Orson Zhai <orsonzhai@gmail.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 Chunyan Zhang <zhang.lyra@gmail.com>, 
 =?utf-8?q?Marek_Beh=C3=BAn?= <kabel@kernel.org>
Cc: linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1287;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=gN/N7MTnfesRcU0ZUz+5FDMsGWVo2Qy6wwU3HvO2nBU=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmv3DfPgJIiHDC3hZ2bkc5m7qeMomLAN1W2uZDq
 zxZ4A5tqh6JAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZr9w3wAKCRDBN2bmhouD
 18UJD/9O2BpM8SXiXEcgj51PM7x8myw6JvKSH40bF5oY9mhYIhkrZpWkbw+Q/7QL7B2EcIXbGwo
 LrmxiMbQvg87Z7lN78d8yf0GJr2ja+HX25WLRTCfL9lAoXbHMGotJD66V3I3D4I/NRdUbQTDzMa
 GHxvligWU2jeLN1qjSSE4Z5ZXQcFGaQ22RBOgL5IhzzmHNjVyaQ0I7YMKWJ5UcwIh88EXJikd90
 9Mj5JYSJO5GCunLxqgi5x20aMYuVoCPdhfrhykPvY1/WrKKcA/qfmrjY5VrzSJv06q4CRJ0xQqD
 MMTkyJKgY4S7pwZuJA3SsLEgggw4C2Mcdut6XkUdyiYwmWIk5T9sd2U6qVhDGyzw3GoTtyfvkdh
 3bv18L9qH84cqiM2E9uvA5HGw0+tNVVqcfAaA73pn3TugUj2UBQw0ZACpoNU61mgPROTd9zjE8g
 2ljGiXGegvDG5Lc3FdUQ8NMq27W6vFFcZ7fqUFh9ifzKYDwuU20YsvxySGmH2DbOdhc/wTDNhdD
 ErXZc8VIuCFnfQrbciDcVUluC73s8YaaAMVICIhZNMluBx0SGWut77qF8+CCA/yBy86CXrd1Be1
 mbGNuNEztzvTIQQeX55KCYhBtgdSnordy28kcn6S2dP5p29AGcaoNW3aG83jOWEDjwSyBfuAJ6b
 aRt8rutA2xi1+dw==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Use scoped for_each_available_child_of_node_scoped() when iterating over
device nodes to make code a bit simpler.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/leds/leds-bcm6358.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/leds/leds-bcm6358.c b/drivers/leds/leds-bcm6358.c
index 86e51d44a5a7..51fcff2a64fd 100644
--- a/drivers/leds/leds-bcm6358.c
+++ b/drivers/leds/leds-bcm6358.c
@@ -147,7 +147,6 @@ static int bcm6358_leds_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct device_node *np = dev_of_node(&pdev->dev);
-	struct device_node *child;
 	void __iomem *mem;
 	spinlock_t *lock; /* memory lock */
 	unsigned long val;
@@ -184,7 +183,7 @@ static int bcm6358_leds_probe(struct platform_device *pdev)
 	}
 	bcm6358_led_write(mem + BCM6358_REG_CTRL, val);
 
-	for_each_available_child_of_node(np, child) {
+	for_each_available_child_of_node_scoped(np, child) {
 		int rc;
 		u32 reg;
 
@@ -198,10 +197,8 @@ static int bcm6358_leds_probe(struct platform_device *pdev)
 		}
 
 		rc = bcm6358_led(dev, child, reg, mem, lock);
-		if (rc < 0) {
-			of_node_put(child);
+		if (rc < 0)
 			return rc;
-		}
 	}
 
 	return 0;

-- 
2.43.0


