Return-Path: <linux-kernel+bounces-289957-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7394954DB3
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 17:32:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 899EB282B90
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 15:32:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67E4F1BE853;
	Fri, 16 Aug 2024 15:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zt64dWwG"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C74AE1BE222
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 15:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723822322; cv=none; b=T2DXmmGvlSq1b8lNVP7i/ZIQl6mXViwbYDvFRieFN25wd5ZVfzsAhBjEku2uxSoE7uWtdsFMpXx6r6UMZFDUof8YB17jPI7jzC97BbNQHZbnD2Il0Nr+TWdUy+4UPInAVWB1beuUteptff8E64NGg4oM1t43fuzrWz3ZANPxwrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723822322; c=relaxed/simple;
	bh=5KMyb/0ghZiWoNxxGIN0+j8uXXpKKlWx7oozmJ4CEcs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TE2HqLJiZimDwPIKyohJzFC4qlaRE7G6W7TuPbVuGlYZw4R0Q6jbIDqFdfzN1eY9jbucC8LQXjp4yxc4dCrtzLrugxOfltxDq6ziTyUqH2ZZ5JhbecyQJvTXgcJLdN6NF5fgSpLYxdECRmnLkvJXi+iL6/sSwfvpQXaXQRga/yA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zt64dWwG; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-428085a3ad1so16722785e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 08:32:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723822319; x=1724427119; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CMXjCi1nWSGJw2HEGXaKpvGQBWqmSFyvM6Rv3lJzOnk=;
        b=zt64dWwG53OErxxJWStMAjFLyyARIxX/Jv6p7wzrz1N2ilL3sWJNDPWifXZZZ3Ep6m
         tjlxXpi3DgmGcJcS5z2vOU1ywAmObQZnY5WNa2urETMWGTW76fv7fRw2523NrOOoug1w
         935xV94efRPZEPh91ba5Ed3bzQL1B2OjGNioiuvAZo0wcIPhiddfLqrGIX/CJQY1zT/0
         NvX4gAfeIVn+8qaeer0sfG7b9oypNhPOAhfvYQFRU8x5dunuHEGu4yZGYOhEsLDjNsaY
         p7EQU8EO7krBUw1QdfX383jfS5zIyCuYjc/MVRZcCsTY3bj7jOVY52V1ZAZjEGlSUwai
         K9IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723822319; x=1724427119;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CMXjCi1nWSGJw2HEGXaKpvGQBWqmSFyvM6Rv3lJzOnk=;
        b=w9zzLkxGD/wia8N/p1GpZtjn2n8936tUwlvW5Vyftq8gyvxnVW7t3GZo1xnT+b58dW
         MtI4uh3c1O3N2kx+ltjNSTdzt8N9YgTiF9VQRfwCHIqcQtjxDRLmUNLYIX5/MarQolPL
         pela3ia3L1+03UZJfEtu0/KXCfBKMtdf9dWrmk48myuoIEKaIL0DEkn01ZiCk5Mneq6e
         Sxm8MAeMofntfljmcacMcxhF0upLRddXGMMFs8VHvkjfZPJTzlUmXt5T01EAlEECarSz
         2rKslUSbCvUxAdNN2BQfNbLT0+eve8LXj7+1KUMVKuCEiwN21fIuOTAg1+0BB7A4tu2B
         9uSw==
X-Forwarded-Encrypted: i=1; AJvYcCWIfwR1L1orHybAeOdzRe0XJ6AnKCui54NtbfNpX+drf/L/OpGmuUwfqKPerMksC1yYwifbDTs7BoevkSn+QhyTlx26lfd1iGdbiE/m
X-Gm-Message-State: AOJu0YyvCNjZ2K4CabMDrM7XDTAbENdlX+gjw1wM0oytU1OCM2ruiLrs
	sVv7qCGuFRpYTcL6XFy8K73njVdSEmbDKhUiAbz3KeZ+NEE2qvVNdNY6rEKJ9NU=
X-Google-Smtp-Source: AGHT+IHQVp9RMVKnFXRmolzPy8dcbt7NmXN/jroL6chg+fDJWYg7uMIzfeBfP3NPtNgAOQVI5RxN+w==
X-Received: by 2002:a05:600c:1987:b0:428:9ba:39f with SMTP id 5b1f17b1804b1-429ed79e212mr21385555e9.11.1723822318959;
        Fri, 16 Aug 2024 08:31:58 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.215.209])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-371898497f0sm3853661f8f.39.2024.08.16.08.31.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2024 08:31:58 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Fri, 16 Aug 2024 17:31:35 +0200
Subject: [PATCH 03/17] leds: max77693: add missing of_node_get for probe
 duration
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240816-cleanup-h-of-node-put-var-v1-3-1d0292802470@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1838;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=5KMyb/0ghZiWoNxxGIN0+j8uXXpKKlWx7oozmJ4CEcs=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmv3DbVDkrgpNCWbqNPXUp9YCFjKcR3EI+TV8pk
 PJEmPek6O2JAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZr9w2wAKCRDBN2bmhouD
 16uRD/9jJHb7kLUKzwpJD2ZWds7O67ALfXb3ZP6DUa7effzfaE+ihgB7WVZpKDFSz4Ynnq+GhzC
 SD7hYFMiD1dlIU45EiowQ6w17hk6OGGckkc4oS5UDLJHqO38ddcLxZMtxjHDGR8DPAIRHYRRSCV
 aeJF3qb6rx4DHfiGx+7HuYGQahBxc5wQO7aUmpD+tKb30AdRIIpxWoRL34DC3QyNlAkpBwXC34u
 S8wYpbf1rQQxBswNLYYVojtvNJmVa+/7G4urNcX3L2t5N9Ocz78wJ2KXKaJ6PmByMd996E0Wi2c
 zM3+rJPt//QRSatrCP+YBcu9vxG86z9Ssu+7kV3vDNkYop/8zteJ8ZUPHPgVNxvBuFt0JLzL8QR
 39T+Se5p7DgKy2U7tH/cp8FZ8cwH87/8uXrGiwhgi5r6tn9THegbdFj1ZwKt6Q4phJpPKJxglY6
 bWKZfin1lyWgHMxA++9MV8mY7GtZ+lh8kRrvMJWq+Y9eva4qZJlXBk9O+Fu6OLzi+fHGL65R2LX
 JTUkAzxdPa/proprkZCnXopEdTizjxhet3j0QeFnBB5lAtMSuUttFIZKMxZg0OE96gq4JtVmGMy
 56lHesBi9ptFlDGB2uRlD2OAXJ0+NmuyD0GOY548/WByuED2YjR12ECGeD4jD7KlanlFHSgqIAE
 FqnXEfx8WMfK5ig==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

At beginning of probe() function, the driver iterates over OF children
and assigns found device node for later.  The code uses
for_each_available_child_of_node() which drops the references on
children on each successful pass, thus the probe function operates later
on the device node without holding the reference.

Fix this by increasing the reference count for found child node and
drop it at the end of the probe, because it is not needed further (the
V4L init code takes its own references).

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/leds/flash/leds-max77693.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/leds/flash/leds-max77693.c b/drivers/leds/flash/leds-max77693.c
index 9f016b851193..16b169e658de 100644
--- a/drivers/leds/flash/leds-max77693.c
+++ b/drivers/leds/flash/leds-max77693.c
@@ -649,7 +649,7 @@ static int max77693_led_parse_dt(struct max77693_led_device *led,
 			return -EINVAL;
 		}
 
-		sub_nodes[fled_id] = child_node;
+		sub_nodes[fled_id] = of_node_get(child_node);
 		sub_leds[fled_id].fled_id = fled_id;
 
 		cfg->label[fled_id] =
@@ -968,7 +968,7 @@ static int max77693_led_probe(struct platform_device *pdev)
 
 	ret = max77693_setup(led, &led_cfg);
 	if (ret < 0)
-		return ret;
+		goto err_setup;
 
 	mutex_init(&led->lock);
 
@@ -1000,6 +1000,8 @@ static int max77693_led_probe(struct platform_device *pdev)
 			else
 				goto err_register_led1;
 		}
+		of_node_put(sub_nodes[i]);
+		sub_nodes[i] = NULL;
 	}
 
 	return 0;
@@ -1013,6 +1015,9 @@ static int max77693_led_probe(struct platform_device *pdev)
 err_register_led1:
 	mutex_destroy(&led->lock);
 
+err_setup:
+	for (i = FLED1; i <= FLED2; i++)
+		of_node_put(sub_nodes[i]);
 	return ret;
 }
 

-- 
2.43.0


