Return-Path: <linux-kernel+bounces-263356-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD11093D4D5
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 16:12:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4228CB227A0
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 14:12:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A27E9445;
	Fri, 26 Jul 2024 14:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="T8ZMbcaT"
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8D8818C3D
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 14:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722003066; cv=none; b=s1KB2tAxyYk1IkLXdC9Pz1NAFC1y3CV7qmp7J9ekykg7eMFs37bMnWogiQzOuG6FX1tjbMRYtnJLh/TQT/6T/Tv4KBj42aRLNgSJwn2lHl/vu7qzHuhF40ZkxhgmZwuPsieGaWFCvFOUc3EUGIosaNl7I9qFk/GQwhVJTVZ66TA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722003066; c=relaxed/simple;
	bh=Wl+tDBuyQMsKe2NwpZXMc/8shVbTUViF+5tNnWhiufg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Hv4mBUaLBPCtJWLSesXIZ+5ZFRPUmiUP38XsK3cje0dExOJoDJ9+oOHs5O6FfEEJx4Rx/u5H3TbzmY3s+npH/4oWREpG0UqMyOiSAtjs65FvGLdFeD0wmB7TpLV4HoyZj+sZPUR0LENfAB5SiK8jR0I0EsslaAbE8l9DEF1N4uE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=T8ZMbcaT; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2ee920b0781so14174471fa.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 07:11:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722003063; x=1722607863; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Brvms8JhmsVbDZotcc6ApH8ZnBoz//VNsdwEXVDTRv8=;
        b=T8ZMbcaTDFDAb1M7njuK8aj40JAft/Vhu5gvyZTqQkLQB7dLUN9bemklA9of8k506e
         1aZcBdUWT8+SQiSuNzi2W/0vNAp7Ergw92vd7+bnxCKQVnncAk6rs4zWmIe42de/jKYx
         hPOuQ0n0juOwF5eZkn2SIH/CkRr+39QvirbPehl3WHsj8a3COqZsLdQz8WNQy6oymZAs
         wk0N+Swzfvl98vMzs4IQL5+im/0hgQEAFT/YxCz38cbvV6bszugHYy2mcpyuD3Q4/5Z9
         16roi37Xz7PH4QZmn32spkKLJQ/Icg0BOLJ+xLKTacvOr+Fpuvio/iiaeOfVLZyG2ERv
         b5Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722003063; x=1722607863;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Brvms8JhmsVbDZotcc6ApH8ZnBoz//VNsdwEXVDTRv8=;
        b=kEqUFjmc6Qn21fhy61cnBYmsdYduZIIz8Y0tfSnSBT0hAIrOE0CHAE34qqBqZ2+yNZ
         26QjktgE33PkJH24OOAt7cAdKfaa48M5nOtsWRVsgqnwaKhhzjjekZN5X3napHJSI+mc
         CMuX9WcIDfeZSokvgiHHeXcnGogNk1N4mLaA1GBmgNxzAsGVooKWT0azBjELGxpQGwPj
         764U1VZGQwn1jeZBs3UBBTtRICzdYrQ4O9zyTto11p+cm7KmxOlMT+GAnRUTDQ7DpBox
         +q4WA979Dofd0hkPMMTpzzs0JvGEuRxQwq/DpPewxralEMCfNDw/OKftL9AInmDAVX2S
         cSqQ==
X-Forwarded-Encrypted: i=1; AJvYcCX0aJzdpXZFOb0iqh1tTlvIdLxGNDmUkCM5GfxVl/wkMuazWIqyl+4ONqmA4CYPZQElNzqj/Hi5PT179g9+sTcoTbA1l5ntDDZoB1iP
X-Gm-Message-State: AOJu0Yyck4Kp9Ljsffe21EZUK8Hw6AmGDITdx86qLTEQKkbca4+mbied
	mDzoNv8++eDzeqg1m6DIKBGuQ08/7PfVS6xtJDwm/JDODyUWLgqrISovG5UI9+SAPFAQYc83PXF
	r
X-Google-Smtp-Source: AGHT+IHoY8KGYJY7FAM0r57X/ZlrB/uyZh8XEYKyFteHSxqoB7xOthPewnXbTiP333EoAA8ogqWMIg==
X-Received: by 2002:a2e:7209:0:b0:2ef:564c:9b66 with SMTP id 38308e7fff4ca-2f03dbe906bmr35474471fa.30.1722003062486;
        Fri, 26 Jul 2024 07:11:02 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.137])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427f941352asm120841115e9.41.2024.07.26.07.11.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jul 2024 07:11:02 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Fri, 26 Jul 2024 16:10:44 +0200
Subject: [PATCH 4/6] ASoC: codecs: wsa881x: Correct Soundwire ports mask
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240726-asoc-wcd-wsa-swr-ports-genmask-v1-4-d4d7a8b56f05@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1526;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=Wl+tDBuyQMsKe2NwpZXMc/8shVbTUViF+5tNnWhiufg=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmo65rhZpKPZg3tmFrHEHfD9UhC5sv0LQAvnb3T
 NdSB7BEB1+JAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZqOuawAKCRDBN2bmhouD
 15JFD/0ST4V7oPsF2QmExiXjWppFCmdT+Au0ltznI674n979jfy3w7dDoF/hrPIbQN4GGQDNbN9
 S3cVrNumBB3oxJlQhf8SD3JJSXK36Ex9XQqnlMPH81jl/OK2mbo9ohD1yl6uzKct/Ml02cEfQHI
 igpQwBFOpxgMg2QjGBjtZcE4iLyLiXlKbU53oTM2F9UEPpIUA9t4ibtjo1Q+kOH2ksZGut6U1+L
 0IbIqM680Uzoz1gryxUSmsV2anr5Q16aXrSTzWPm2BYSvY9zCR7NIgOS9ZQA9Zvd1TvOUTqo5eg
 ryRpbnWzJ8t8BLKWupkqB+Kb1BYtqHcq8SaCM61uHyHoacuNZPwEKuVMMbCZVucPqi4G4m3LrZy
 urGvc6TRVsX5kOacMTT6LGATUkVlBA16jZGGkPbMD8fYi/pgJmMnIr4/i7gBZLzdC3oJxYM3f1w
 qfhjXpy5vSzIb7mvtytSDckrttVaI24rKbjNG/uq3xChVzmPpGJrqkjqHaxv4+UQ2xuL2yWkoXB
 PbNY5pDT4v+hcStu0NPuHGRxqqvFRrE7LIPNpAdDP4dSBgqmHh0SaBp234mSXmiinjliKVGCGeK
 XjzSrDy1t10bol85r0IbmGUtrKRc1KSa/9B73nJIlze+Y6iTSUeQN9UhUJitOacfQIv1/HcwI76
 0g6reVierLFUesQ==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Device has up to WSA881X_MAX_SWR_PORTS number of ports and the array
assigned to prop.sink_dpn_prop has 0..WSA881X_MAX_SWR_PORTS-1 elements.
On the other hand, GENMASK(high, low) creates an inclusive mask between
<high, low>, so we need the mask from 0 up to WSA881X_MAX_SWR_PORTS-1.

Theoretically, too wide mask could cause an out of bounds read in
sdw_get_slave_dpn_prop() in stream.c, however only in the case of buggy
driver, e.g. adding incorrect number of ports via
sdw_stream_add_slave().

Fixes: a0aab9e1404a ("ASoC: codecs: add wsa881x amplifier support")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Not adding Cc-stable because I don't think the issue can lead to real
out-of-bounds read.
---
 sound/soc/codecs/wsa881x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/wsa881x.c b/sound/soc/codecs/wsa881x.c
index 0478599d0f35..fb9e92f08d98 100644
--- a/sound/soc/codecs/wsa881x.c
+++ b/sound/soc/codecs/wsa881x.c
@@ -1152,7 +1152,7 @@ static int wsa881x_probe(struct sdw_slave *pdev,
 	wsa881x->sconfig.frame_rate = 48000;
 	wsa881x->sconfig.direction = SDW_DATA_DIR_RX;
 	wsa881x->sconfig.type = SDW_STREAM_PDM;
-	pdev->prop.sink_ports = GENMASK(WSA881X_MAX_SWR_PORTS, 0);
+	pdev->prop.sink_ports = GENMASK(WSA881X_MAX_SWR_PORTS - 1, 0);
 	pdev->prop.sink_dpn_prop = wsa_sink_dpn_prop;
 	pdev->prop.scp_int1_mask = SDW_SCP_INT1_BUS_CLASH | SDW_SCP_INT1_PARITY;
 	pdev->prop.clk_stop_mode1 = true;

-- 
2.43.0


