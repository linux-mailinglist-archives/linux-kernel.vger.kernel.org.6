Return-Path: <linux-kernel+bounces-239225-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2829492582F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 12:17:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D80C28FFB1
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 10:16:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E19C616727B;
	Wed,  3 Jul 2024 10:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oC3emajg"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8137B142903
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 10:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720001777; cv=none; b=M90oKh4b0O3CCDi4ngp/4+wM+41eoXvP+sNv/m8/MIcn3t4uUWuTqrCj08+IbQBOZqGSQKHTS85etrDgzKrX+JpUf30shKA2fG0/U92NMRFWE2ESNPiCWJpVsRplXm8+TJX7oqNArDU9tlm+yEBmp793qoQ8jYxcB7EnGrorC4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720001777; c=relaxed/simple;
	bh=Ol678uS9dQ4xA1iTWHOJsbF5rd2bR0cJ9zqotT/ChuY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bQzvEs5t8XqOaJmlWFHfKzGzo2+ZG/LzR0Zg+GyuVFOeyZ6+gkjY6VQKdz8nUXoUwAvdBPdy1WA9L7jQFyGkAiTKniKgQh9LrTxLzHA4qAlC2ItFankYjwdaoaAxMoRyR15zEb43XfP2DQF3jjzUdeFZugjvf4BechCFlF5ptQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=oC3emajg; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-58b447c5112so2210854a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2024 03:16:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720001774; x=1720606574; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Eewbky52yFyCjHy8tFMyxq78GyiBRf7ePSPsH7UZe34=;
        b=oC3emajgFYnSOKB/DkpgNdwcVvXU0nBisrYeqG3jCh5trONvJpgqOT1zSw5ySIuCjZ
         KXEbW8q6CF4/AEREVpGNNBeXtyC/yyMoMEoOOsrPG+zx8KzYEMB6UxDUg/8Y3Hg9wOI8
         33Et9RiuY7xx3aqPXrYAgRNVbSi51hDmzn3+/bEx4E1FEMYvTY8ytorhgw4Ajq5CzOHc
         LkDBpaZ2wbxKuBNRoQqKZBv/Z6ZhjiXDqL1FLPh+Vir6xL/usXjzxzqtHMTidRpnsQd2
         FPURj//Fa9QD8qlutx1JiD/LZJtAwa2k2xBasXLjNoYV79MLzPZBErZNqISi898LQUmM
         FBVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720001774; x=1720606574;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Eewbky52yFyCjHy8tFMyxq78GyiBRf7ePSPsH7UZe34=;
        b=nWZTyjD83wp/eYPyK0hTwGB7sxC7NjUJwi09XDXIUzX5xCUELGaxRKiDq1QWYaO0Wz
         +vvYechxRdk/gUSHa8VP0OGxoolPI7KABjTAJukFAwYC9hMw8cLK2JQ1V8wc74TGcfdZ
         ouq+ghqvI9MeU986iwri058LFatRTENfPrWKSZuQKOlTWgBVVlA+mxaCs9Y9UoMiSyR/
         Vgq5DIZ0sbYF3GU6ile2fhRdxVjdn3ANmsYutEQct9BvIXmCrrr6bQ6D5Wxfx4KZjuns
         XVRFl0Jmj5DxQz3/THnEaSYcdF8grxWNY2Nw+4fhrPSFCqeJH7narNoTPOPVwlD1+MyO
         xQtQ==
X-Forwarded-Encrypted: i=1; AJvYcCVRr+vgzpcD0EW7M97phbfBM0swiKQPVX5sycVX3fodasDQ0H928y425BzpXSr/yzjh4r0nBzVul5mD9AhWxHEjrxIz7JsT2wjqtkl7
X-Gm-Message-State: AOJu0Yx6scjp5eed4/R+SS7mbXUKlHb825u1G6UwBuRKR+4Zl4mCZfpL
	CQ8+2MqPWHNtAnapdlJiRI+xjy1MkxjrcQm6+LaYlEQVGQqV+Qjhi0cmuobS/Q8=
X-Google-Smtp-Source: AGHT+IHmjbSzPCX5JxTEYJT9gZmcA5MeHmQoPhQv3t1ZxolhjaIIPWitPETXciwwLMO8r6zR017fKw==
X-Received: by 2002:a17:906:229b:b0:a72:4281:bc72 with SMTP id a640c23a62f3a-a75144dd493mr756319266b.63.1720001774022;
        Wed, 03 Jul 2024 03:16:14 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.137])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a72ab06565csm494291466b.103.2024.07.03.03.16.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 03:16:13 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Wed, 03 Jul 2024 12:15:54 +0200
Subject: [PATCH 2/9] soundwire: amd: simplify with cleanup.h
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240703-soundwire-cleanup-h-v1-2-24fa0dbb948f@linaro.org>
References: <20240703-soundwire-cleanup-h-v1-0-24fa0dbb948f@linaro.org>
In-Reply-To: <20240703-soundwire-cleanup-h-v1-0-24fa0dbb948f@linaro.org>
To: Vinod Koul <vkoul@kernel.org>, 
 Bard Liao <yung-chuan.liao@linux.intel.com>, 
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, 
 Sanyog Kale <sanyog.r.kale@intel.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1555;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=Ol678uS9dQ4xA1iTWHOJsbF5rd2bR0cJ9zqotT/ChuY=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmhSTjzmj5Rr2bqkWjyjn3muBzm30I9Ht2Qp4oK
 8nKJxeL+OeJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZoUk4wAKCRDBN2bmhouD
 1y66D/0fKO4gzBi5mD4kXweROjCrsgr94HyHuatSkmOW3tA8yr7ADL+1MGVFenX3CB99m3Gm70l
 NY0xWe5alMpLkQbelrBouC402XM7AHvM7m9epYbZjFjMT3mjZwweYcwfoQhQqq0j6g+xh87mL7t
 bMnnl8UWMlW6ipJciZsNQvh5weMNCkPawFUQPzy1wb+LmDX1Tzk3SN0NnXAAf0oz6wJU6PE/V7M
 hFE4hJ+SQzmWuDPykGrCRi+nxcT4FI4APLYoctY/kTxpD1IPSvYuu4n4jnc6+D0UqdLgWqkOesh
 dC5ECkcu6fzWdbGSMNkLyxcpScB1RjsNGChYAi5kVxIb0uSDqjIlveUOYFSzT96yu11HZ36kdZC
 dsRbP6BoKv1st4oV9na3f5lNADHUIEp2Rbn7xigza3o1Dey13i8ce1UNYp8HITxK7A4DGg6HaTt
 qc3Zhd7kLWksAuPlDVXI6QtMzY9nwvSGynRMNcVj/WiqixBElXJ8pdHnVIU/h3pjOLEtWzO0Eyw
 os/K+v6q907S3H481NDaFYj3PHMlmcr2PEOk3z3WzC1DVWaC+M+28uyT3CkNWR+fst9QaBVESA0
 xgav4X5dmMRz0OXimVABXLLjYQPpt9zNEKy1lgrqzfHmvrmPyfREPioPwPTnqM74t3jfasBhGEG
 D/zwGI5F4jvh55Q==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Allocate the memory with scoped/cleanup.h to reduce error handling and
make the code a bit simpler.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/soundwire/amd_manager.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/soundwire/amd_manager.c b/drivers/soundwire/amd_manager.c
index 4470fda83c5c..0d01849c3586 100644
--- a/drivers/soundwire/amd_manager.c
+++ b/drivers/soundwire/amd_manager.c
@@ -6,6 +6,7 @@
  */
 
 #include <linux/completion.h>
+#include <linux/cleanup.h>
 #include <linux/device.h>
 #include <linux/io.h>
 #include <linux/jiffies.h>
@@ -603,7 +604,6 @@ static int amd_sdw_hw_params(struct snd_pcm_substream *substream,
 	struct amd_sdw_manager *amd_manager = snd_soc_dai_get_drvdata(dai);
 	struct sdw_amd_dai_runtime *dai_runtime;
 	struct sdw_stream_config sconfig;
-	struct sdw_port_config *pconfig;
 	int ch, dir;
 	int ret;
 
@@ -626,7 +626,8 @@ static int amd_sdw_hw_params(struct snd_pcm_substream *substream,
 	sconfig.bps = snd_pcm_format_width(params_format(params));
 
 	/* Port configuration */
-	pconfig = kzalloc(sizeof(*pconfig), GFP_KERNEL);
+	struct sdw_port_config *pconfig __free(kfree) = kzalloc(sizeof(*pconfig),
+								GFP_KERNEL);
 	if (!pconfig)
 		return -ENOMEM;
 
@@ -637,8 +638,6 @@ static int amd_sdw_hw_params(struct snd_pcm_substream *substream,
 	if (ret)
 		dev_err(amd_manager->dev, "add manager to stream failed:%d\n", ret);
 
-	kfree(pconfig);
-
 	return ret;
 }
 

-- 
2.43.0


