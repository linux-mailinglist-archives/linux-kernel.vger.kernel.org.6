Return-Path: <linux-kernel+bounces-432764-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 442929E4FF9
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 09:40:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C4DF168410
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 08:40:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E0AD1D514A;
	Thu,  5 Dec 2024 08:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qoSi1QZ4"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B76991D416A
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 08:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733388032; cv=none; b=Lf7fFKvqtkwSON9aP2A75etWuk7ZXoGizy7aI0KtCdb/tCq1GtmC6//QYVddQakazVi3c+4hYrXWg4SMBsk5jx/oZZhzMEK1fA9lDKUr44adGEA2wTmSQQMlNuO953yvR3cqM0whSGjsqo/dyIMbTi8rphz0XNiJN4QWrTMc/L8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733388032; c=relaxed/simple;
	bh=VXAHZgsFwE3gVMNHVJ2Z6U10+Ur4Mnaa+RQ8u3Z94VM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ii7HIIqNLhACxFc1KFhOV9cLrlvSRxr3wH016YnRYXOp/NzQmc8mggtcFnE1/UJNDvnLIYmFPcRevILs6Jv4aXveKeCh8dM+oUrA6hTs45z86b/FNdtyiG+i3AERgLQKTP/r05OrLpSrtjwIAFy4/8KmyNk3xSgsCCEi0hsP3XM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qoSi1QZ4; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-434a0300d4cso891295e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2024 00:40:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733388029; x=1733992829; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+OmUztXtNWohIcewPdYnom5QGJ43Ux3+mIBMeP3r1+s=;
        b=qoSi1QZ4WxgekJpcOJsJ6ILzm0WtBdDpLJqcDA4ZAPMN50JLwdtYNz0mR7fSnwkEwk
         ibfd7aG+qh3MOrmI2TiaeKSTKpmOV7KBVt7acaUSno3IV2Q+NT2qqbVs9mxMPFv98UAd
         3nnUXSnEBzvGawHet/SgEipOgGbbenVWwmOzAd48dTR2MP5TolLucl4KoXmmIMgwsqOV
         QU+LtzKbW68CQwqrpfQBF3+cQ8zD3dwfJcI3J5RQmg0wnumViv67FcHnl+C32Oo9pkqY
         Rri7gRWAZJAoLUB6sNyyYURpdh/XPAEzSKUeLxCVUj8RXNfcb2PZrystVTKE02HwK6UY
         46BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733388029; x=1733992829;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+OmUztXtNWohIcewPdYnom5QGJ43Ux3+mIBMeP3r1+s=;
        b=nb2+5B84Hlhp9xCu44sUVDGf4CsqWJgUlsf+bR00SjG3W/P/Rf7zUvAJjBOWCFkIbM
         MI9bQOdRON3H8hfa4gw6JEJJKXeGnV4iXatfPB0ovo9ltkgmzf1n7xskDY7hRNez0T5j
         S00ZskyjCXNwr77hYzNv/hCygk3gw9k6a43FymJxKSG4BWA9rzpCiuoL38RjuAUu8L2c
         KlXps6S22t98EDAG5tVT2/GqrnhTn1pueC9Xow3umcsh7l073PyIwPhfWVg7VXcTGPCl
         Egr3sWhW8uv8kPBKwlJ1eMFnPe7jLgGWtLneoetGEDBIQ9nMBqImTnkkysd19ydl/uyL
         pSBw==
X-Forwarded-Encrypted: i=1; AJvYcCVNfFGiu95eAbscG+HO9syhDSS0DhfFl6uUksL+dFQ3wnvTMnTFw7FSCWBSimicPk2c1+XTBpJhsuTOa70=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyb6JjjDitaY2GGVUggAAJsNyZT/6K66XDtJYDZZQj2ke6rV3jd
	aZRUCcZuqckZOR9ztCzZ4os250Dj8EAKBX5+h1tZabUZHDzgw0cptATlwM18bC0=
X-Gm-Gg: ASbGncvLcPyyxuYwELYv46SAroVvf79p/Yb658hjWClUVnGgBW+p/lHOUzH3sCEEr9t
	rk/6fNN/VDs23Ex4LWNHNkqvbxZLpNVKUdlsF6aQkMIX0huwZeeKF15B6hxzds63NQUUrm44ClC
	lD3xpsQtdGfsUX3GlyEZvHpvybjKc7E24jbws4MGSPUxecxpH5D9rClUkcMOK7VmYRQfxwdPY7s
	IxIORhC2HxB1oQWlpfLzao4loUOSNqNOhBFEv1vuBRrboZJNUAI6IXLEZXtMwZy
X-Google-Smtp-Source: AGHT+IGSkYgvAgwhu7WSyQqH3Y+yt4UQ2jGt9iuwru2727ErGBAZvYMWIUUnfNAP+kzH0fju4MoCbQ==
X-Received: by 2002:a05:600c:a07:b0:42c:aeee:80a with SMTP id 5b1f17b1804b1-434d11c7b9dmr31086225e9.7.1733388029090;
        Thu, 05 Dec 2024 00:40:29 -0800 (PST)
Received: from krzk-bin.. ([178.197.223.165])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434da0dab9esm15935965e9.22.2024.12.05.00.40.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2024 00:40:28 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	linux-sound@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Dzmitry Sankouski <dsankouski@gmail.com>
Subject: [PATCH 2/2] ASoC: codecs: wcd9335: Drop number of DAIs from the header
Date: Thu,  5 Dec 2024 09:40:21 +0100
Message-ID: <20241205084021.35610-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241205084021.35610-1-krzysztof.kozlowski@linaro.org>
References: <20241205084021.35610-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Number of DAIs in the codec is not really a binding constant, because it
could grow, e.g. when we implement missing features.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Cc: Dzmitry Sankouski <dsankouski@gmail.com>
---
 include/dt-bindings/sound/qcom,wcd9335.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/dt-bindings/sound/qcom,wcd9335.h b/include/dt-bindings/sound/qcom,wcd9335.h
index f5e9f1db091e..4fc68aeb9e04 100644
--- a/include/dt-bindings/sound/qcom,wcd9335.h
+++ b/include/dt-bindings/sound/qcom,wcd9335.h
@@ -10,6 +10,5 @@
 #define AIF3_PB                 4
 #define AIF3_CAP                5
 #define AIF4_PB                 6
-#define NUM_CODEC_DAIS          7
 
 #endif
-- 
2.43.0


