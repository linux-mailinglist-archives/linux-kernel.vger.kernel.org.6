Return-Path: <linux-kernel+bounces-263354-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 200E993D4CF
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 16:11:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C93D42860E3
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 14:11:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85F0F1400A;
	Fri, 26 Jul 2024 14:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="M83Rsn7z"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A064BA42
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 14:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722003062; cv=none; b=a9jmKMOdLrpWqFXwDJTB97tu0b1QfHhT/yS+GpVBhr9CfBvaVRkjt90fFFBuXcr9w3HjIG+TLP7kDTRQyDCKck2vjT2HhlLuAsNrum1LLwKVM6UFPRCNLADaIBGLRq/o1x2rub1pUIrD97eUAQnoMIt6S/x07Cn6pZHZlN4wVx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722003062; c=relaxed/simple;
	bh=cGgEjpzzxGI973pctJv1X1Xqrenmzkw5jm4bI9/CPUs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JZIdKNc1M/bsf+vY+q9cHx0D3xkXKvF0TDKrl8jCgWZ4Zme3vLYL/UwKg6M0yqWb5n7Nv56rcfDO/1bK+act9md8K8zLbUQRP2bSWGSdR4kY71FDjhYL0bjkX3i0cEKjtDhgG87uQcdZkkcnds7vtwGyqrtxhOy9Pr/HRk3Ep+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=M83Rsn7z; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-427d2c8c632so15552145e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 07:11:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722003059; x=1722607859; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kTGsbAfRUm3WZ5fb53jExCzdO/XEBE/ZTI+TszbFHcE=;
        b=M83Rsn7zZwZCX83qbij7qoBpsyFsLhWEL+xk+iUQS4Qsp2A+N3dBkewHJjLGmIUn/x
         Anv3HRDysxHEFpMHjF2aEKtN9znYS5Z23QWbQeaDrtRcHawVqhbO++mgLNh3fj90m37v
         uRNg6w7hWwIFj6WHeJiiJuFJ1Z8KNo2k2nLG/p1M5+twMDSCUiJJ6kQJST4Ob5JD1n4Q
         PXcLgCLpKjbdu5/+5b4ko7xzN8Zk3XdJZxTtxvzNWhi7SpxCLP0y8k8Jrd6lKV91w0Wr
         GqoJawioIpvmKjNADqFN/YndQcBcqrl6OqD+/tUDKzJYaexugzzrqVfqKkFGg4zGmLDq
         /frA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722003059; x=1722607859;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kTGsbAfRUm3WZ5fb53jExCzdO/XEBE/ZTI+TszbFHcE=;
        b=KvWhZiQfWIr4TmbPbqI1OhGB9SA3NMmSYWdY0ubAlVcwiAwPa59HmRvjSRdY43/oRZ
         WCzuIECN33Bt/+WUPMgV8Ckf9L+CM2y5QTxHlEz4PZK3zw2+j4K9ytvD3Q8+TRrU1/5m
         HMXuGKjb1+dkZ3gAOO9Fiqdo0DBYaeIj5263HA22Ywb3I0ltWGkPo95IXQYIEMYbqE5X
         EJlzUJiA8ntoIKG1gUL2amaIcq7KqRY1cIOU1yzrIlLmmZuUhu3GJJ3WInZ7OKlnhyg8
         XpI4oXKMJn3p7sgbkmVbByoHcd84MwRJO1gTdH9LKhkdcwDOEvlaZwxOH12ol7upEnaO
         +e1g==
X-Forwarded-Encrypted: i=1; AJvYcCUpuo3OLeZ1esPTwTGIyxVEzkqcmdEZIPz0GNYeEbsrvqVJAfMbYzSSW3q9vSB8s1lYC66cRl0mUyiYR/ZZ0UmkLWI2hwmNF7t0Hv7c
X-Gm-Message-State: AOJu0YxBb2bg6L3l3IH4s6fKkmZwSKLVAILS7TQmiFsAwAKdfL6tkmJJ
	jByHpJRBMNxme4+Hgdfl9mGEZgBSRyxjL23FQUT7xUo2Gj2B6HL+4d9arECbMmrecGGg/v8kY9o
	4
X-Google-Smtp-Source: AGHT+IFz/JUl+8u/JK2MqcXdpWEoos3z2kzWUCjz3VughnmpNQSqc2rMtp7GCgrM4Xlo9AdJw/qt2A==
X-Received: by 2002:a05:600c:5253:b0:426:6320:7ddf with SMTP id 5b1f17b1804b1-42806bfe266mr35213265e9.35.1722003058921;
        Fri, 26 Jul 2024 07:10:58 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.137])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427f941352asm120841115e9.41.2024.07.26.07.10.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jul 2024 07:10:58 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Fri, 26 Jul 2024 16:10:42 +0200
Subject: [PATCH 2/6] ASoC: codecs: wcd938x-sdw: Correct Soundwire ports
 mask
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240726-asoc-wcd-wsa-swr-ports-genmask-v1-2-d4d7a8b56f05@linaro.org>
References: <20240726-asoc-wcd-wsa-swr-ports-genmask-v1-0-d4d7a8b56f05@linaro.org>
In-Reply-To: <20240726-asoc-wcd-wsa-swr-ports-genmask-v1-0-d4d7a8b56f05@linaro.org>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Mohammad Rafi Shaik <quic_mohs@quicinc.com>, 
 Prasad Kumpatla <quic_pkumpatl@quicinc.com>, 
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Banajit Goswami <bgoswami@quicinc.com>, 
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 alsa-devel@alsa-project.org, linux-arm-msm@vger.kernel.org
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1776;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=cGgEjpzzxGI973pctJv1X1Xqrenmzkw5jm4bI9/CPUs=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmo65pRGgV5B1JytKHlbz6JcNxoIZORTr8B+r6k
 1jeQWWl6hWJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZqOuaQAKCRDBN2bmhouD
 15dOD/9vCxKIo8VXq63ApLgbGCqko0MTCPw7y8OqbfI6J7s/NmZYrKzQ/Giyked/yjhq88hfeDs
 /RgAzAEvfZDgX2gBzrp5kdyXpudEXxJje5tyKU+CVkRrV2VD7eX25Ffs4+ecdvv9sIK75G48OX7
 c//034fCz8FAPfACs1ME0OphEyX3rH7y74bMuDIZjUS02lt7wZ+EHZfEdf202e7Nj0WFg8RL+uj
 RIzDibfyrF6AKyzk8gg+taa42qLJwcw0CgjHCWzvk2bEEnJ8XZ1uYZnXIN3d1BaKDp+jte46aT8
 vPYiQKGciYt0habUV9R7GWkKnEEp9MMmZ7NO1UmOG17oALbMjZ6bFFLk4qjlDlZTIrKH2UiOx4s
 nh8nB+OvGcvHarLpE8zWQt25mN80ziz6ECGGKUHrOucr7A6v8KgdKRGecYqZGB8H7q9ymJrKPtw
 MBFt3alHXQSitx4eQxWePlb4k9XZdtBj2gvfzYjEcRrhQyLOfbVNWnQqIAgD6vBDm9bXgO8a3d4
 LFlkOKmtA7iQi6MZ262xykI/maLj+BD5R/27gnZQa+MLAOQyr51RAFSKjxUoQ506+3BMSOcnHKu
 hgLTmA0b01zEIxmHsqxSPr5Nz+N4Mbu9HIGTX5qOg+99eZFGhzh7MIgc5WUYJRDnXThdrv5JxoC
 F7LCmf/cGx29Emw==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Device has up to WCD938X_MAX_SWR_PORTS number of ports and the array
assigned to prop.src_dpn_prop and prop.sink_dpn_prop has
0..WCD938X_MAX_SWR_PORTS-1 elements.  On the other hand, GENMASK(high,
low) creates an inclusive mask between <high, low>, so we need the mask
from 0 up to WCD938X_MAX_SWR_PORTS-1.

Theoretically, too wide mask could cause an out of bounds read in
sdw_get_slave_dpn_prop() in stream.c, however only in the case of buggy
driver, e.g. adding incorrect number of ports via
sdw_stream_add_slave().

Fixes: 16572522aece ("ASoC: codecs: wcd938x-sdw: add SoundWire driver")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Not adding Cc-stable because I don't think the issue can lead to real
out-of-bounds read.
---
 sound/soc/codecs/wcd938x-sdw.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/wcd938x-sdw.c b/sound/soc/codecs/wcd938x-sdw.c
index c995bcc59ead..7da8a10bd0a9 100644
--- a/sound/soc/codecs/wcd938x-sdw.c
+++ b/sound/soc/codecs/wcd938x-sdw.c
@@ -1252,12 +1252,12 @@ static int wcd9380_probe(struct sdw_slave *pdev,
 	pdev->prop.lane_control_support = true;
 	pdev->prop.simple_clk_stop_capable = true;
 	if (wcd->is_tx) {
-		pdev->prop.source_ports = GENMASK(WCD938X_MAX_SWR_PORTS, 0);
+		pdev->prop.source_ports = GENMASK(WCD938X_MAX_SWR_PORTS - 1, 0);
 		pdev->prop.src_dpn_prop = wcd938x_dpn_prop;
 		wcd->ch_info = &wcd938x_sdw_tx_ch_info[0];
 		pdev->prop.wake_capable = true;
 	} else {
-		pdev->prop.sink_ports = GENMASK(WCD938X_MAX_SWR_PORTS, 0);
+		pdev->prop.sink_ports = GENMASK(WCD938X_MAX_SWR_PORTS - 1, 0);
 		pdev->prop.sink_dpn_prop = wcd938x_dpn_prop;
 		wcd->ch_info = &wcd938x_sdw_rx_ch_info[0];
 	}

-- 
2.43.0


