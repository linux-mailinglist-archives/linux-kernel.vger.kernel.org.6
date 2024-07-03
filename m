Return-Path: <linux-kernel+bounces-239226-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 96E60925829
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 12:17:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 32FF2B22AD6
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 10:16:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D77313A3F0;
	Wed,  3 Jul 2024 10:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fpDFUNvi"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2096615B54F
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 10:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720001778; cv=none; b=GlauOCwpA4w5RWXtbFy5bRnaM9R8LYr4Oe34ZKAWQaWMSnuHQKA9m0S+8th2COhRbI+m/8hIzBeNtQSCqa93kViwriBD52w0NJUeXZ8FpW61eFr8P8+Rcs5m3pdchy7NGT6wwliKwAtlHcQiFdfU6vnH4d4x4e/Oi5Uz67eB9ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720001778; c=relaxed/simple;
	bh=Nwe0xlKfiyDOaLPbyz9qVTptKB4D1oRYsTHNGpFlOMk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eHMfTpgAf0xjrY1GBMhX7dLe8HvM9Ysqv+iJdh/yP/ETkO+TAakUMYZyT9F7oI3R9cKxi9FHZ/qsohla3DACUXgkVYrX27AWeIGwYPZu94MyhaK4thSivFGFZS+AjkrK4e84dnqVkWVICIeYzLUMtJu3u8HHPSjHD+Y296lBTso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fpDFUNvi; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a7252bfe773so545880066b.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2024 03:16:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720001775; x=1720606575; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GfTnFwv4IUNzXvE0oSrrhVXmiYatYs6QJJBq0PCSPdk=;
        b=fpDFUNviq+b3wo6sKTOesLro1HINIIjoY5Gv7bTn6QfFMXC1vjv1XChsA3PcuXC76n
         TsPECAE4Z6dme5HPXQ9hwT31FVo4isH2yWFtcX6blt2+YYjl9PlSePmyl/kXAP2tdi0o
         iz0eZLy4OvOoxus9XADJ0Fp8618+LR208+R3vydLi3iyrDAcGdfmplBnr0z/BdvSuJpz
         IS7+Lk/c0o6rE5EtkjJaG/esXlZnOd0bqcBHI27Q86EdWCCFNOOB/xFUQEubVq8SJ9S1
         NZc47zxLJ9orGhfn2BlK7uS1YMGDA6E5TpZeIiBbkRzb9kogfNRS/qyG9GRns3O13kzm
         BJRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720001775; x=1720606575;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GfTnFwv4IUNzXvE0oSrrhVXmiYatYs6QJJBq0PCSPdk=;
        b=tK9Le8XNDyuqIvdhV47SZzTshkkzKozuQU4F+TgI5IoF5fDbGCvOJWG2hfVweGY64Y
         0j0gP+qRsMn7khLmn+3fXK/COaOTgjZu/tZ6ocdrzFrCixvEXBLXwrD01/Nj/k66EF89
         vbspAc4H9lMeqApt+jsdluuTw24HcRqiShYy4bwbjT7cbgvzOaOpt6YvSuGhnniyTuoK
         LF3a0SMGB4fYdwSDV44KKJ+f2Gb7OeUEuzvw34zkm/JjnncpeoYlYuTpRBhmpzN+kp+P
         54GvF45rLTZ/qv3RtM6mQRiZuEMEJaLV/yCTgil5L51vZ+JvjaqyIkhWPuYckUIzf2CG
         wI/A==
X-Forwarded-Encrypted: i=1; AJvYcCU9XdW5oi3wuFv/+0FeStv/6lHs/kTIuVKZ2kZ0vJGlfYnjGdBuM9AJvAz1+/R79mfrKXFDnzPPoXOPRS8gacmLA3giEgPU5BNikHqm
X-Gm-Message-State: AOJu0YzTavwQzb7iklfA+th9Fn6WwkvYinoDx0RwSD137gKVtPToHtMs
	ZnqYwSZPRDeKQRLOYKSmywt1tflgtEAON6IwpRidbZCNTvL9hpRJLYKSm26UlE4=
X-Google-Smtp-Source: AGHT+IHEpkDA1cTbqIue4QyD+vUx5qAFNk1xfrPOtv5WQ36h5sxJbjzXsmByi+3O7e+BsSkBPh3SRg==
X-Received: by 2002:a17:906:3106:b0:a6f:5609:9552 with SMTP id a640c23a62f3a-a75142d873cmr807100666b.10.1720001775533;
        Wed, 03 Jul 2024 03:16:15 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.137])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a72ab06565csm494291466b.103.2024.07.03.03.16.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 03:16:14 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Wed, 03 Jul 2024 12:15:55 +0200
Subject: [PATCH 3/9] soundwire: amd_init: simplify with cleanup.h
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240703-soundwire-cleanup-h-v1-3-24fa0dbb948f@linaro.org>
References: <20240703-soundwire-cleanup-h-v1-0-24fa0dbb948f@linaro.org>
In-Reply-To: <20240703-soundwire-cleanup-h-v1-0-24fa0dbb948f@linaro.org>
To: Vinod Koul <vkoul@kernel.org>, 
 Bard Liao <yung-chuan.liao@linux.intel.com>, 
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, 
 Sanyog Kale <sanyog.r.kale@intel.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1703;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=Nwe0xlKfiyDOaLPbyz9qVTptKB4D1oRYsTHNGpFlOMk=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmhSTkpUkUyMw//T6vaBK4PU7FEkGwJPparyv6X
 fM0Zahd6duJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZoUk5AAKCRDBN2bmhouD
 18xzD/9s6VRQ9i414HlaH5OFxg36sEnNg9LfehqxzJuG0E7kt3XaAmMcYoA2rR7Ffn83iw+4AJu
 5ItCS9iNlNtl+pXecAinp547m3YU6QH1PiZCNXpIfF7ETnnj7tbP3D442qaKDJ1Q96eOpO73EkY
 dSDeTNjC9wr6k4vgLpUqr4Rz5Y63SBEZm9E5WBHcCgTI3Zu0ha5hOuKGd1Z1qRuQCpN8UWWZt0F
 hn1NOznUQ6VPaZTkkCyv1RQWyncGN5t74p65+LRuPP577dlgq1gH9OQLEin9e1zCF72Rz/iyvxq
 KFTu69tQpmmNfSVh3rpOl81860NqcReO9+DQnBPSeKLxHSn1H/cM4RavuXiEozPfyQaJaTdufRr
 tstL3LTVrdanQrVXR+d8uLH0q/Ylu4ESxP8RJqGTeomCgkVdxD+/9JBvFM7LExRuW6bUlMeyCfu
 tvu7tx6CKGuv6CRwLEHIguOp1ZrXuoIB+YMvM3Q1ii5ZFflcKOXHINYDfzEjUWrnTt071E0csmC
 oun40ZtnuDT0yUI9Ll+DilLTcM/aIAkPp2YMtYlrsf/NLs/O0sxanFychJhb+0ZFxVR8veVRgaS
 rKvmhypzuD+87RRhi5Z4fzp6Fu3ox+wAg2N+8PTw6eHp3qKty+v30+ZCm5U5d4uWX7og5ZssvXo
 l9JutBGgyHSEYmg==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Allocate the memory with scoped/cleanup.h to reduce error handling and
make the code a bit simpler.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/soundwire/amd_init.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/soundwire/amd_init.c b/drivers/soundwire/amd_init.c
index 4cd26f3a21f5..db040f435059 100644
--- a/drivers/soundwire/amd_init.c
+++ b/drivers/soundwire/amd_init.c
@@ -8,6 +8,7 @@
  */
 
 #include <linux/acpi.h>
+#include <linux/cleanup.h>
 #include <linux/export.h>
 #include <linux/io.h>
 #include <linux/module.h>
@@ -69,7 +70,6 @@ static struct sdw_amd_ctx *sdw_amd_probe_controller(struct sdw_amd_res *res)
 {
 	struct sdw_amd_ctx *ctx;
 	struct acpi_device *adev;
-	struct resource *sdw_res;
 	struct acp_sdw_pdata sdw_pdata[2];
 	struct platform_device_info pdevinfo[2];
 	u32 link_mask;
@@ -104,7 +104,8 @@ static struct sdw_amd_ctx *sdw_amd_probe_controller(struct sdw_amd_res *res)
 
 	ctx->count = count;
 	ctx->link_mask = res->link_mask;
-	sdw_res = kzalloc(sizeof(*sdw_res), GFP_KERNEL);
+	struct resource *sdw_res __free(kfree) = kzalloc(sizeof(*sdw_res),
+							 GFP_KERNEL);
 	if (!sdw_res) {
 		kfree(ctx);
 		return NULL;
@@ -132,7 +133,6 @@ static struct sdw_amd_ctx *sdw_amd_probe_controller(struct sdw_amd_res *res)
 		if (IS_ERR(ctx->pdev[index]))
 			goto err;
 	}
-	kfree(sdw_res);
 	return ctx;
 err:
 	while (index--) {
@@ -142,7 +142,6 @@ static struct sdw_amd_ctx *sdw_amd_probe_controller(struct sdw_amd_res *res)
 		platform_device_unregister(ctx->pdev[index]);
 	}
 
-	kfree(sdw_res);
 	kfree(ctx);
 	return NULL;
 }

-- 
2.43.0


