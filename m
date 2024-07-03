Return-Path: <linux-kernel+bounces-239228-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 060CC92582D
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 12:17:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4C641F2126D
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 10:17:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5D2E171E66;
	Wed,  3 Jul 2024 10:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BBAwI0x6"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82B4B16F84D
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 10:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720001781; cv=none; b=B309AXCMv1oJlYdZln9E4ZLOsrK2dvOv6PYmRXEZYeH+2wrh3nYdOByE191xmDJOkBm+Ak9f1fhNFnpo04l72EjSAEf+4ZOK/pZIk0mgbH3Q9NJ2l/hCmTq4Z2U635ZK4E4RC6e1MFJ9yIgU5wh1OwXSliLRts3d60Ho9LKst/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720001781; c=relaxed/simple;
	bh=cOn7ju16wjK6pDolLwYz3MYYA0UeyCHv7oicnzceFGM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GrlxijYO1bS3Lj2oitL0yoWKbkAymLn5SWLrZ+kaldx4p11YjIDDuxGdJJQw4tSBBeEFjxvT+0EVg3Cz7QlLIyIUk+WmBNXqhlNumxPs3Z5mOsaQs1LdKz7JqyA+Szh4uV9W4ugWm/KDwiffGSRAAxW8BMNJ/x8PHJn+23XGVw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BBAwI0x6; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-57cc1c00ba6so3519352a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2024 03:16:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720001778; x=1720606578; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q1gM5YfJ5m/5Sqzk9+V5O7T+yd7cVFhUsmikU//os+Y=;
        b=BBAwI0x6uLgJygeUJ9QbPkFFvtNggu56WDoXZsgTy26PEd6jhIM1+suil4QPkF9SvZ
         hCI4wL9CHyaQvxIVyn9Pm2PMffVedW8BEO7cxzI0mQxR2Pcm40bCtwOh71jtpXA2bXeb
         4oUOXtINA17dVn9DNY4G85JqY2oN082UgDHXrkxAzT4RXrWIOKysbqXWGYd06u0dA8Ec
         a+aX5ks+p/jdLS17BvjRUBfLvTkMUalxBD8y3jycZi4bmZ2s962jZz0tLhlTs6MJkduk
         eJnYGAncoLy9+M8sKXzXxRoX1oDpR4NW+10/k3L2NsJrg8TvOKxA3kYhoL+sV+tRPNbz
         jgbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720001778; x=1720606578;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q1gM5YfJ5m/5Sqzk9+V5O7T+yd7cVFhUsmikU//os+Y=;
        b=kaJ4qHntPHrtlNaTPdHdnV7fLGuox02I8aOtVUuweha9hWmHSCLIS+5NjD/KKRqSTz
         uLO+LnPB1QVP7bRRz2ojEjof3iPhITC+I2hjEnT51ncwPVeDTpWTMi9D1PHUG9M+P/9T
         TnQ+Rm9YGMoxvurIEJmyLSt2AbYeKDPahrVmK6xL7CFU3La+A353eJBJsfAfWikuinKB
         m27JRdT+x7nx82ku8OjXQsi2jiohXTNf5k6dIQLNxFEWNjaOAHI5ks54UinXGwxinFAk
         aHM+O+LahNie5Ye1U7TZxJFqJZI6zvlXTpe4vuHkEcrK4S3R5ysJreInWfzofq/qTHvp
         PJVw==
X-Forwarded-Encrypted: i=1; AJvYcCXVt0WNSP88bPbez863F4jllMcFM91uwgUHntk6WLic9xbIcdQEp/aE+MTNDndbKb2dJhwVXEZUIElaSV0xYAF0UWc9ldKPj6GVZbAa
X-Gm-Message-State: AOJu0YzGHQR1YxFGIdzJ6urCzZAw1eDzgys4TQrRQl/UQqwXJ6+SU4Es
	eAff/Y5PNIka8P9N9QzZQQg4XwuFYyzdLlTIeqCH+UxndXAoouLJ0p3yn82Rlcw=
X-Google-Smtp-Source: AGHT+IHu4HDX7PNB+RrIZabjL3r10C6WAGWLrBJ/SniR7QXeM4+uEi1nx8/QXXKaEFa8XSm0LDA0qQ==
X-Received: by 2002:a17:906:3716:b0:a6f:1dbb:d38b with SMTP id a640c23a62f3a-a75144309f6mr639801266b.28.1720001778032;
        Wed, 03 Jul 2024 03:16:18 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.137])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a72ab06565csm494291466b.103.2024.07.03.03.16.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 03:16:17 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Wed, 03 Jul 2024 12:15:57 +0200
Subject: [PATCH 5/9] soundwire: intel: simplify with cleanup.h
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240703-soundwire-cleanup-h-v1-5-24fa0dbb948f@linaro.org>
References: <20240703-soundwire-cleanup-h-v1-0-24fa0dbb948f@linaro.org>
In-Reply-To: <20240703-soundwire-cleanup-h-v1-0-24fa0dbb948f@linaro.org>
To: Vinod Koul <vkoul@kernel.org>, 
 Bard Liao <yung-chuan.liao@linux.intel.com>, 
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, 
 Sanyog Kale <sanyog.r.kale@intel.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2107;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=cOn7ju16wjK6pDolLwYz3MYYA0UeyCHv7oicnzceFGM=;
 b=kA0DAAoBwTdm5oaLg9cByyZiAGaFJOWjVZRJlaE4+7o8j3BoA3vRf5jfJurtUc9fTi9oPNE2H
 4kCMwQAAQoAHRYhBN3SYig9ERsjO264qME3ZuaGi4PXBQJmhSTlAAoJEME3ZuaGi4PX+Q8P/1QR
 pWn/0I9oFGlPVBDkeUK+8ZgI+HK4gDCXUcmphuWo3fkkIISCmpdjU1CMhUIoxw0XJS0WCo4+cA7
 ftUEG6AjbJ1lt7tN+UQcgof4l1hADQ2wXlaW0CzC8Bw19MC61jGS1yJvIAGAboAYgKrQSfrsnFc
 XY3r4AyZc3gHF7uJIm4yqrXikozsOMttAHUoafi6f6feaTFi1a0A2ISoyT+AW+RHUfyweB1E6fg
 QDE2hu6HhT9ON7UzbcQgoVQkCjj1CdNOZOwBYVS6wrb/B7ORkgj3dB+WI5FnMnJM9iwLkK5QDZj
 LoFJzQ07N5Gi1i73wARhjBRw2b/4Oo1Mi2LL0m5N4rb4IbZtyCUfNALfhRIyu72agXKYAqzR6zI
 7Idc0TQZAN69ijTjxaYsaRFJs2SRoN7Z0p2hTMzk5Jr+vw0KpfS4eXaT81AJPXRx9gv8wXIBEfj
 Xe9LKrsmjmOV6ZgOu8O9RJK21kVII6uvktYyW4vkAVEA8conI6TgWIQKXI3TxTPAUmmhV8QO2d5
 OR255h+cU3rPAb1DtzI9iXXLTncjldmjDZyoPxA32JNyQS6fBUrEZxTt9PVlb88DKKYDBS+4Iw5
 u1hdypdpA5Dqlp6VHr/Lz/y9QpgZMEKfnflUiIGuux0zBtnOfNXP6/9gCRRGyYnAAXfDJZqL7rh
 omplR
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Allocate the memory with scoped/cleanup.h to reduce error handling and
make the code a bit simpler.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/soundwire/intel.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/soundwire/intel.c b/drivers/soundwire/intel.c
index b4449095b423..421da0f86fad 100644
--- a/drivers/soundwire/intel.c
+++ b/drivers/soundwire/intel.c
@@ -6,6 +6,7 @@
  */
 
 #include <linux/acpi.h>
+#include <linux/cleanup.h>
 #include <linux/debugfs.h>
 #include <linux/delay.h>
 #include <linux/io.h>
@@ -73,12 +74,11 @@ static int intel_reg_show(struct seq_file *s_file, void *data)
 	struct sdw_intel *sdw = s_file->private;
 	void __iomem *s = sdw->link_res->shim;
 	void __iomem *a = sdw->link_res->alh;
-	char *buf;
 	ssize_t ret;
 	int i, j;
 	unsigned int links, reg;
 
-	buf = kzalloc(RD_BUF, GFP_KERNEL);
+	char *buf __free(kfree) = kzalloc(RD_BUF, GFP_KERNEL);
 	if (!buf)
 		return -ENOMEM;
 
@@ -129,7 +129,6 @@ static int intel_reg_show(struct seq_file *s_file, void *data)
 		ret += intel_sprintf(a, true, buf, ret, SDW_ALH_STRMZCFG(i));
 
 	seq_printf(s_file, "%s", buf);
-	kfree(buf);
 
 	return 0;
 }
@@ -727,7 +726,6 @@ static int intel_hw_params(struct snd_pcm_substream *substream,
 	struct sdw_cdns_dai_runtime *dai_runtime;
 	struct sdw_cdns_pdi *pdi;
 	struct sdw_stream_config sconfig;
-	struct sdw_port_config *pconfig;
 	int ch, dir;
 	int ret;
 
@@ -771,7 +769,8 @@ static int intel_hw_params(struct snd_pcm_substream *substream,
 	sconfig.bps = snd_pcm_format_width(params_format(params));
 
 	/* Port configuration */
-	pconfig = kzalloc(sizeof(*pconfig), GFP_KERNEL);
+	struct sdw_port_config *pconfig __free(kfree) = kzalloc(sizeof(*pconfig),
+								GFP_KERNEL);
 	if (!pconfig)
 		return -ENOMEM;
 
@@ -783,8 +782,6 @@ static int intel_hw_params(struct snd_pcm_substream *substream,
 	if (ret)
 		dev_err(cdns->dev, "add master to stream failed:%d\n", ret);
 
-	kfree(pconfig);
-
 	return ret;
 }
 

-- 
2.43.0


