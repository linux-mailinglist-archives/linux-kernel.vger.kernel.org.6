Return-Path: <linux-kernel+bounces-263353-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 104FE93D4CC
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 16:11:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25A211C23467
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 14:11:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B62D101E2;
	Fri, 26 Jul 2024 14:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ALCVqZPz"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFCDF7494
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 14:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722003061; cv=none; b=RO/fUC6khxmAxJB9xz9sgjlkCtUaWlPWnmrs5jYYiK7tSY0Zo0kInhMDDMs3dS2jjt0BAaTvZuuo07KDhcW1zlGsvNKB3CsZIzU8tFdDDvvyC68qsTXMgCu8VbZioMIJEZxjRcNharT8eibGN4dhRRAfe+eh+2Gbumrutr+1EvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722003061; c=relaxed/simple;
	bh=U0iQgUf77isNWPz5wSO/QalnZ8ymeec3WHS6WdettZs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eUWkfJX5LwgpiU/mO+pr+fZmu/DKYgPi357RLpvbLvAhzy6PVuasXJiAZUO7+9uRggzCRi8YJORlZEnGd6Kne3zlGcElDfavIdebWHoRZ5SangUsDdOQUy56Hj4W9g4o7IvUQArNail7v/ex1omEfLGvbDioWY7t9rP80U/dbwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ALCVqZPz; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-42802de6f59so15525335e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 07:10:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722003057; x=1722607857; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vEkK+be/9njUC3Is9y04g3ij2793OMGUHZjC8ZIJXBo=;
        b=ALCVqZPzjQ7Dn0u2cgQa9zAwxf8ZZ+aJFmNknjQyum6Cm3bXlyIXeeGs3OdwtwQ3ST
         Sqa6QferPSzs7am+Kf5afxWV4c8mTTEOL7kypiV/Q3J0/HjhD46iH2x52uU/a4/i4mtX
         hDATLep18wBYCNJttR/GmRNUe5B6AEfEa86I+0e3PuNB6fminA+PW39uSOAuH5zyCg+T
         7dWTHlqJ+YLb2iW0ZSFRhAwCkfpE9EcM7O1yeeTd7M4zVweTnZqU7oPMohogn3x+fBPD
         CtWXt5e7xfgm5pMrIbCnB0vJupPU7K3LKjkx9tFVLTL1VMQi+EylJ6cc6fHD/n3se1mR
         M2gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722003057; x=1722607857;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vEkK+be/9njUC3Is9y04g3ij2793OMGUHZjC8ZIJXBo=;
        b=u2GOw9poy7/4Nen6v8EcBxhWDAGKPISHWuSOLuoRznsXC1G91P6wxJcGE7i3d2xFEw
         IBfyLyQOo6nBMconEZHuMJdF0TF0yB6lfjQGKiAzlAvEtfwmgX0Anh3Rg9wRRFMvtRua
         NIsdt9JEEOxlt096PUgv0MlfPXcc/3KOexFHkY8XCmtPkIOMP6DrOZnUCQd1rW8V1OPW
         1Yq6k99E5hs1kw9nwaBHc4SNT75GTjA7SgEBrrcDVdfyHZAVe7pvuc48vHRTis3gXJoh
         aaqJHA59VPcxgHI3OMl5vOb0DFQZbOOct4tVRcWezpa6smIZeHR1rTVHB/g+EYaPdk2e
         mmnQ==
X-Forwarded-Encrypted: i=1; AJvYcCVl9S6AiYUtaaBVde/lLJG47V0/9oj3Zbk3bx2yR3Pb1IOAMsupenxg5eDyXyhnBTQdxRUn9omykDkvFsrzKXutikybsevkvbbXfrdJ
X-Gm-Message-State: AOJu0YymDBXsBe+K/eTTk36OrEzTNtvCQ0xp19tDramZcklgNobOU0pk
	AaVdams475NNLa3/67wSPyAIxytHbwrtsKg7OecJG7F8UxX2yzpKxXnYyYJVIX4YAdVn/jBXzvT
	W
X-Google-Smtp-Source: AGHT+IFV/ZpujOQQuNU4y5xUkqHK9TT5v4LwDRDBL4tAqj/tx/FvrWYNs9CZlkMnnbNmp4SxPWDCKQ==
X-Received: by 2002:a05:600c:45d0:b0:426:6945:75b8 with SMTP id 5b1f17b1804b1-4280579e92cmr43011845e9.31.1722003057369;
        Fri, 26 Jul 2024 07:10:57 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.137])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427f941352asm120841115e9.41.2024.07.26.07.10.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jul 2024 07:10:56 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Fri, 26 Jul 2024 16:10:41 +0200
Subject: [PATCH 1/6] ASoC: codecs: wcd937x-sdw: Correct Soundwire ports
 mask
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240726-asoc-wcd-wsa-swr-ports-genmask-v1-1-d4d7a8b56f05@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1998;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=U0iQgUf77isNWPz5wSO/QalnZ8ymeec3WHS6WdettZs=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmo65oM7TrQ4WPQo4XevW2lOaGA4R95dKCpZlv6
 wW46Z1aQP+JAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZqOuaAAKCRDBN2bmhouD
 1/fvEACZejwshy7ORBUx21bbMgVsL7J/sztl10qJqNBoJeYs/gzMUsbENWm5JgO41XERX3/pfSo
 njQhapIsqRFLzlnen+Ok8TM/VRFoJUcXy5ttXSSOeSg/VRqNXO3op1XZQVgQkthRMruMwLtpQfv
 p7Ioldc0W1i2+muv17N+dtEVTsiVqQHDeMxTLZyUehIqIh0ujJG3Epa/uY+L49uSDoDKmpDPfQN
 Kb+BGzsuOCNeSorxevLNxmXad8la64bfdRXcxA29XsM5dht0wps8ECiIa4UEJRKowxISObJp/Wi
 ssDC4gmOguXoqxa/d1b7jCpx+6CnGgAWr85xitDbo0u/eJcBtJJuabta0yinmIHEjs34mRAae6X
 IT4p8mC7im5Ci/ErNcqoSwu1P2KrF0Hj3NyhrKBQ0UKUfgl1KyBk5xVHpLXEq4lLP4hpJMM+pZI
 XXKqLLfLc9owJQYBlFp0i/E4pq8xUpQOPTUAPBDnwoPe9tG0LXpApktVOEbv1EOCkMcelM1MitR
 zx6dHe1tFQ4WrJxFcx50DYUrsg3AVxtgH0HHPNC3w3Uy3ymLQc9RMGR7eTML5ZuqbMFf1gtzMjG
 R7VzVUxbGQomk/JoXeagI4n3whtWwoR3JUgTD3Bkx6oIpEqJHsIUYcdbaKuNM9S4TuyGGxPartk
 vl9HRMjVQGz3lGw==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Device has up to WCD937X_MAX_TX_SWR_PORTS (or WCD937X_MAX_SWR_PORTS
for sink) number of ports and the array assigned to prop.src_dpn_prop
and prop.sink_dpn_prop has 0..WCD937X_MAX_TX_SWR_PORTS-1 elements.  On
the other hand, GENMASK(high, low) creates an inclusive mask between
<high, low>, so we need the mask from 0 up to WCD937X_MAX_TX_SWR_PORTS-1.

Theoretically, too wide mask could cause an out of bounds read in
sdw_get_slave_dpn_prop() in stream.c, however only in the case of buggy
driver, e.g. adding incorrect number of ports via
sdw_stream_add_slave().

Fixes: c99a515ff153 ("ASoC: codecs: wcd937x-sdw: add SoundWire driver")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Not adding Cc-stable because I don't think the issue can lead to real
out-of-bounds read.
---
 sound/soc/codecs/wcd937x-sdw.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/wcd937x-sdw.c b/sound/soc/codecs/wcd937x-sdw.c
index 3abc8041406a..0c33f7f3dc25 100644
--- a/sound/soc/codecs/wcd937x-sdw.c
+++ b/sound/soc/codecs/wcd937x-sdw.c
@@ -1049,7 +1049,7 @@ static int wcd9370_probe(struct sdw_slave *pdev,
 	pdev->prop.lane_control_support = true;
 	pdev->prop.simple_clk_stop_capable = true;
 	if (wcd->is_tx) {
-		pdev->prop.source_ports = GENMASK(WCD937X_MAX_TX_SWR_PORTS, 0);
+		pdev->prop.source_ports = GENMASK(WCD937X_MAX_TX_SWR_PORTS - 1, 0);
 		pdev->prop.src_dpn_prop = wcd937x_dpn_prop;
 		wcd->ch_info = &wcd937x_sdw_tx_ch_info[0];
 		pdev->prop.wake_capable = true;
@@ -1062,7 +1062,7 @@ static int wcd9370_probe(struct sdw_slave *pdev,
 		/* Start in cache-only until device is enumerated */
 		regcache_cache_only(wcd->regmap, true);
 	} else {
-		pdev->prop.sink_ports = GENMASK(WCD937X_MAX_SWR_PORTS, 0);
+		pdev->prop.sink_ports = GENMASK(WCD937X_MAX_SWR_PORTS - 1, 0);
 		pdev->prop.sink_dpn_prop = wcd937x_dpn_prop;
 		wcd->ch_info = &wcd937x_sdw_rx_ch_info[0];
 	}

-- 
2.43.0


