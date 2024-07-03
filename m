Return-Path: <linux-kernel+bounces-239230-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 19635925830
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 12:17:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8AB581F214FB
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 10:17:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0BAA17335C;
	Wed,  3 Jul 2024 10:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="P4g0sMs6"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57464172773
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 10:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720001783; cv=none; b=oHFa5P5/Ul09X2ewrGIRMJsryMvi//z//W6WCU7ess96VIovRABk26gXVD4DsKqrb64Z//VXpMjqYsBHiUqWD0WidNp4M4oeedKA6pI2S986pYg3AsU3HjvoG+0TFcr+uM+M405K3MAHFaL6BLu7RsuHV58sJP6O/fqsNCjkflE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720001783; c=relaxed/simple;
	bh=IY1oPHTeYFkPAQIumDC8e25FwPrkJ2qyVDIkUd9B5LY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=acco1UCvkdhGOzDLc+dcexh65xf4hHnkD1x6IFXyIEJrjFFRWbA4B0Wll9gdnNCJHNYYAlsaeKjQuWShc/kqHUQzAAJ9HFzsFj564GaPrpBr/RW34SbFIdF9gTpeUMFwH25AjSzxz2+4dR7++PPUEfRgOoi7suCc1MmyxzHVGDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=P4g0sMs6; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a751ed17b1eso77783366b.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2024 03:16:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720001781; x=1720606581; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VrtpT+q3ugRzypCVgwmAVgi8FHiU6FE6B5vA8wJQ87o=;
        b=P4g0sMs68BTO8/fU/dfJdDuVVhfatMjOSkVZdQSXNJmtg9HLgN8aydQ3ImZf3OfAGH
         SfYr+ZXgnX1VVOFMIpzK/yOOpw3G0z6h3/UZGfffSMVa/YYeyxuDk09fAeq118XdPxgX
         HezSHa9Dp3yr8hgWHs4ItYk0UR6r4PqSTRNo0KypwXXRkZvLLnpugS1BOD1+DXuss/++
         eQK7UmyX4n6TeqovpiybvVG2qb1vKN5IBWMYRmQAuz+oEJ4n1LtPxsJmv4OCAh4Vbsyx
         Ml3/aT3lt7wNR80xyXcRdJVfZi7a9fjDCUS54q38zdRNhi1qQj9ZBy+8sdENw0k36Nx7
         jdGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720001781; x=1720606581;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VrtpT+q3ugRzypCVgwmAVgi8FHiU6FE6B5vA8wJQ87o=;
        b=oz9o+a7q8JKHgPmTPmN72QXp+rURTjPKMDto8NpuDQ6bvFeJc2un+lAgn27Y6+SV5e
         IvtcT4sIsIGpe6HAnnlKzCWX+LrjVyySOGfusuhMZlePfDwyM5V5Xx5V5DZThTLAYoQb
         6ufacAoMy/bfJzQRGuDhH4AG7qycAD8ASIp+4wMbzi3CIb7LneY1P8xGzksYjJk9wrzh
         /7sLpUxSrZgLC68Z2Bdwp/XU/qUnruAuNY3+DINnkAH1m5+H7R77k1uhWXYRDDY2W9Lw
         qiI51KVpwHqlOcQOK6BU9NSN5BoLYd5pM7zoYONuJ6AbW6WnfpplXzqUNyiqq1CyHFbJ
         9cZQ==
X-Forwarded-Encrypted: i=1; AJvYcCWDtcxXIdBBDiqPnMegnxYx7NVB1HFW0Ya/R8X2VBCMyiiar5OaPrLhiSFRALA6MSMzWHRg/3izP5xNFJBcfh67kFSwB9YH3DOs7K3k
X-Gm-Message-State: AOJu0YxF0rUqsNfEiB/omdxn22Jg0eEJVWjudnng3V6+vfvUCiBrkBkz
	mc9fJlN0sLcThKkOc5b+c3OzfDfJsdEYejm7lPsNJfK73xki3vujjLs1mplz3A4=
X-Google-Smtp-Source: AGHT+IEtZoY5JzZntBzNzE4Y9+mfHfz4VIjEoXHHcvOnPR9dBqvKKOQoXhvwcg0LzXPqeLC+5E0HGw==
X-Received: by 2002:a17:907:3681:b0:a72:7736:9e14 with SMTP id a640c23a62f3a-a77a2441768mr102819766b.20.1720001780715;
        Wed, 03 Jul 2024 03:16:20 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.137])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a72ab06565csm494291466b.103.2024.07.03.03.16.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 03:16:20 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Wed, 03 Jul 2024 12:15:59 +0200
Subject: [PATCH 7/9] soundwire: intel_ace2x: simplify with cleanup.h
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240703-soundwire-cleanup-h-v1-7-24fa0dbb948f@linaro.org>
References: <20240703-soundwire-cleanup-h-v1-0-24fa0dbb948f@linaro.org>
In-Reply-To: <20240703-soundwire-cleanup-h-v1-0-24fa0dbb948f@linaro.org>
To: Vinod Koul <vkoul@kernel.org>, 
 Bard Liao <yung-chuan.liao@linux.intel.com>, 
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, 
 Sanyog Kale <sanyog.r.kale@intel.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1521;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=IY1oPHTeYFkPAQIumDC8e25FwPrkJ2qyVDIkUd9B5LY=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmhSTnkavgfEK5yCLUKTCxvvF4PXPL5NgXbOKSZ
 sWx7SD8R86JAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZoUk5wAKCRDBN2bmhouD
 1xwsD/9gMhWaZZjNTAwmFUzuScG1m2CPsqiZWoBezCyR5KEDWxWf69dUBsYBPLlAYXfSHIrm5xT
 M8P3yDHaE9MQGJaR39xrtArAoYt2Qm3DiaOaSaxXPSH/nqNJrb3wIS56tYPbVCXevejg+elOd8C
 XU0lrreoxsHeEF2QpHehJJYoVpx0BlOTYe5SoExvz3gJrDYCVEt+YSYWhUqSpRii1LC0WNuBTYz
 GM1/9ei9HhvvhdgsnK2TMfiaYSsd9w6TDxeosIy1fXtgSHyaVYev7CIhJi4EI3o1eunWtc0nwDZ
 6QtuoJGh4BMsA3jyc1Q5QxM05YkK2TzvEaaH9nnBhhfWGQYna0MiuYx4Z5uZgVdzKaxsSRbusWj
 nPERQk47di6YubUGrG5j1ezzyrr91UfHhW/PIvu//4uoGIytIEku+jVYdo7BSUWvl/+/kzBJkh8
 J6p/UxVp/kJU5Ioz4yTpGpMDX6Z6kCyC1G2zUSs42BXVMWY3er3FkWkLRzW0PfE1n34coDePDFT
 K0dylCRRUQqDY1jSZsSQpFv1MKGZUS6uxDXZcWifj9ThsOn7rvhKGHtyY2roqmP8TdkrgeABAtQ
 iLubbXCuFNg2eHpsURlbaq8gaeZmAaNe9tjHo/bGlI7nBzLOdjqS3O6lSdFgIC49kid3mb993xN
 dFiR2mEyDKGSEag==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Allocate the memory with scoped/cleanup.h to reduce error handling and
make the code a bit simpler.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/soundwire/intel_ace2x.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/soundwire/intel_ace2x.c b/drivers/soundwire/intel_ace2x.c
index f0008ff84ab4..781fe0aefa68 100644
--- a/drivers/soundwire/intel_ace2x.c
+++ b/drivers/soundwire/intel_ace2x.c
@@ -6,6 +6,7 @@
  */
 
 #include <linux/acpi.h>
+#include <linux/cleanup.h>
 #include <linux/device.h>
 #include <linux/soundwire/sdw_registers.h>
 #include <linux/soundwire/sdw.h>
@@ -310,7 +311,6 @@ static int intel_hw_params(struct snd_pcm_substream *substream,
 	struct sdw_cdns_dai_runtime *dai_runtime;
 	struct sdw_cdns_pdi *pdi;
 	struct sdw_stream_config sconfig;
-	struct sdw_port_config *pconfig;
 	int ch, dir;
 	int ret;
 
@@ -357,7 +357,8 @@ static int intel_hw_params(struct snd_pcm_substream *substream,
 	sconfig.bps = snd_pcm_format_width(params_format(params));
 
 	/* Port configuration */
-	pconfig = kzalloc(sizeof(*pconfig), GFP_KERNEL);
+	struct sdw_port_config *pconfig __free(kfree) = kzalloc(sizeof(*pconfig),
+								GFP_KERNEL);
 	if (!pconfig)
 		return -ENOMEM;
 
@@ -369,8 +370,6 @@ static int intel_hw_params(struct snd_pcm_substream *substream,
 	if (ret)
 		dev_err(cdns->dev, "add master to stream failed:%d\n", ret);
 
-	kfree(pconfig);
-
 	return ret;
 }
 

-- 
2.43.0


