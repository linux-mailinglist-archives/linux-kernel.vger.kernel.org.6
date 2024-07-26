Return-Path: <linux-kernel+bounces-263358-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7957093D4DB
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 16:12:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 054AB1F242DC
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 14:12:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6E4317BB2F;
	Fri, 26 Jul 2024 14:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BXFfClDl"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 674409461
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 14:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722003069; cv=none; b=aKsHqwH1c0zG242yY+0UPXHteXEesyyAzHWsuh+BdeuqLcybVaaiCJZSwc8CPPLvv8PdcrrLJ9YKLYRFbpNJqLc9ZT8dLSq3f6vx4LoSvzAawRenRoQ+wr99kHCqcsFohcg4EDI8n8hsLo8SZLYd/Anppi0rGotiPmRzf3DxnLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722003069; c=relaxed/simple;
	bh=vYWYuVN4lK3XkrzlF4N+aA8raJCbc8inqKOksPmsXIE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KnXyMFznioWZBis08ateP3CCEgdB3dG2uI8uEAl5rvOpmWUQqDSI4eFUd/Tpf1W7bNXENOxKEgkUetsSWynVom0ucdi3Mc78mkbdDUaiWl2l0vgI0fINFfkDYtbKOatySmMrLMlNzuDjBZkcQnwB8LLFhwHPIXeVHTVIXDxVYb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BXFfClDl; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4280c55e488so3955325e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 07:11:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722003065; x=1722607865; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zm4i9m/ncQZPuov6nCVEVOfcxXDmdJCtPoFsZxzq7VE=;
        b=BXFfClDlHaDjbaV+jhg+EztBMz3iP926ns3sAeX1qJFGouN5CjlY9NBUqJ2QSkWtAA
         KQ+KFbDbr2uUtmxvyC7SBE9kSZ6GuWXgRFFmQnv5e0XD3NViQlxDqRmwYIy21NkieHLa
         Xf+7IGH6ltgqgHPZrTQhZ5HNIkaL7JYdMG6knwZjsXjtCd6d7tJArZ5D5Ilt0/LKGNO6
         SLuM7b3RspAxGEYbL6NL2gyUrxXUWR64sO3BGCgc55iGj1tGhKZHv1/yIUQpUE2forB4
         sxKbdg/3WRQe9pJt/I2kCdkasyqYu2E7uuWsWVGQBGCv5rDkbrgQjEaOk7CpV3ywqBpB
         0cTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722003065; x=1722607865;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zm4i9m/ncQZPuov6nCVEVOfcxXDmdJCtPoFsZxzq7VE=;
        b=esgFlqLt4C2g5w4P63fP2nmLH9roNWsA6BgdRjAVkcrsvCfdZBMWbk4Gm6pzErnew1
         De4VSBJGJoTQsTwm8+ykrTiKIH/Le9F9zh8PVc4ZDeC/8qE9tLx9lzREJ6rsVEsEsxqh
         neGGejIT2iJVNs1pfzmreVM/D3slYq7USM3ySxNXxTkrwFymkJ9jWEHy2DNnJVXNasMZ
         yIlxXmaoT1UbK01Fty8ANUtCNKT/YsQGcfiZe2iSlSiQrORupYfyA61aD5dpj8Ca2dv9
         tfmiH1tk/G++Wth0TsPEEZZycgHmj6qmreYNyPN3wzDxKPg0z18u4JPJdQFxjOLCFNwp
         y2dA==
X-Forwarded-Encrypted: i=1; AJvYcCVQIXLQl+ERzpHL/JFTQjc+aBy/g7HWCrQD1JAV017Ohq3iWQGVrsK9XXKHxdXZZ3KtHDUYWwCUQgQbEonJyH937c5z6uIoHGSO258w
X-Gm-Message-State: AOJu0Yx3b+ycFX/z9oh/b5z6uXOtF3EVabphqX9DEikW9cV+oTBDvWWZ
	297umhBTKq4GJ2WwxjGXdPUtx6L/A6uF0rjt9xQdICu+u//YSLDY/1DxtpSqzKehnv8p9+uL6ce
	y
X-Google-Smtp-Source: AGHT+IHwl9iv5umoPhExYwiCZKYi87nvMtqxmxK8Rx49dM71Q/xYQD0kJO7Hzb+m82Le5VpchJQRlA==
X-Received: by 2002:a05:600c:5247:b0:426:526f:4a1f with SMTP id 5b1f17b1804b1-42803b5b181mr45562735e9.16.1722003065313;
        Fri, 26 Jul 2024 07:11:05 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.137])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427f941352asm120841115e9.41.2024.07.26.07.11.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jul 2024 07:11:04 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Fri, 26 Jul 2024 16:10:46 +0200
Subject: [PATCH 6/6] ASoC: codecs: wsa884x: Correct Soundwire ports mask
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240726-asoc-wcd-wsa-swr-ports-genmask-v1-6-d4d7a8b56f05@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1508;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=vYWYuVN4lK3XkrzlF4N+aA8raJCbc8inqKOksPmsXIE=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmo65te5MyhCVdZRhQoHqqUXph8EfgHYbDMktc+
 pR/3JMeV2eJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZqOubQAKCRDBN2bmhouD
 17QID/9o+ExG1syoZx5GLY0VzNCNteL6E5cuNOrA+OdQ1Nwtug1RHqQ17IoqY4nYjtU1xZuKl2i
 eU7iEHYb5Ak2H9DHF0jbUsWP7ymH9YOY1WsPCQ5Pe2bNj7iJpru18vvrFABFVrqP1bMjZt37vUb
 Okr+pWTx0kPweMewQCs8jwl2uzQh1dYoh+mutI3sZ1bZLXDD0RM+db37/KQU2Ptrqn28XU+pVIR
 i0svhkxEOoSQUgLAGwQXviUnOLHFB57YjBlwIh6bZ9B26xMEWDKsWVrIvwoxny5crwDJHPxskUS
 KGe6PlEErlhXGeDYueBPkTgNsAb5JGWGeL16VpeqVXKBu1N/xZKT7lHHk1cT7bQuYlC6GoDu77d
 sQzT/MM0h6aWxFF46cKn71HA5/7+Mf9v3Y6X5Oifc0lj6G87IAHxTIFmA0xaFXvMMOubh8HYDVW
 Q/PvTuMQKp6Pn0OD5Q182HtBc5VJYmmS2+SNAxqbPX57XKCjrzNaFOrVe+4QZp1do9y+ztGF1fJ
 ymixiwT3tNPclmBqOXqGvaik23plgrnrOde+GRei6PivJtCkBo+a1dnOoEWOkOVI7RzjdxVWi0q
 AUaQ3YXZuTLyzGaS4vALPi2g8flrO3ev5qKxZ4nLyJlXxUPqEXO6bssiPuO8RkfBf5yrbyfY/1B
 3fDQ1WwNDYRRw2g==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Device has up to WSA884X_MAX_SWR_PORTS number of ports and the array
assigned to prop.sink_dpn_prop has 0..WSA884X_MAX_SWR_PORTS-1 elements.
On the other hand, GENMASK(high, low) creates an inclusive mask between
<high, low>, so we need the mask from 0 up to WSA884X_MAX_SWR_PORTS-1.

Theoretically, too wide mask could cause an out of bounds read in
sdw_get_slave_dpn_prop() in stream.c, however only in the case of buggy
driver, e.g. adding incorrect number of ports via
sdw_stream_add_slave().

Fixes: aa21a7d4f68a ("ASoC: codecs: wsa884x: Add WSA884x family of speakers")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Not adding Cc-stable because I don't think the issue can lead to real
out-of-bounds read.
---
 sound/soc/codecs/wsa884x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/wsa884x.c b/sound/soc/codecs/wsa884x.c
index d17ae17b2938..89eb5e03a617 100644
--- a/sound/soc/codecs/wsa884x.c
+++ b/sound/soc/codecs/wsa884x.c
@@ -1895,7 +1895,7 @@ static int wsa884x_probe(struct sdw_slave *pdev,
 					WSA884X_MAX_SWR_PORTS))
 		dev_dbg(dev, "Static Port mapping not specified\n");
 
-	pdev->prop.sink_ports = GENMASK(WSA884X_MAX_SWR_PORTS, 0);
+	pdev->prop.sink_ports = GENMASK(WSA884X_MAX_SWR_PORTS - 1, 0);
 	pdev->prop.simple_clk_stop_capable = true;
 	pdev->prop.sink_dpn_prop = wsa884x_sink_dpn_prop;
 	pdev->prop.scp_int1_mask = SDW_SCP_INT1_BUS_CLASH | SDW_SCP_INT1_PARITY;

-- 
2.43.0


