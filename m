Return-Path: <linux-kernel+bounces-233219-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D54C91B474
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 03:07:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B1B15B2170C
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 01:07:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FC9418046;
	Fri, 28 Jun 2024 01:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Xt7IEcWa"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D76813FF9
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 01:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719536841; cv=none; b=M1WjZ4qSCAWV3Cs8Rsk2yKws8hRd+oxdum6NvfLWoT0HKMQCBTqjXDTP+dRGdfKNF9SV73W+x7v3c67HiiTFa+Y+mTzcd25rdFOBeVpdFVuGPLT78TJ5BB3yfgKRKHaeq/7Ee4Sz2pg+svOR9zrMoe2PDQ5OMfezhmO79++mwG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719536841; c=relaxed/simple;
	bh=qJXIxi00JGv1u1BKGWLBWZ9NoQ0XPM5g1tXOS5qbSFs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WPGaR++vIIQJGZUmMUJHQOmsuBsaJVP5YGr0a0oTkc4aHFW3k96YplKdVlA2J2rQgZFgUOoM/7ALYtdKuDOpFd63G4SPmSQXV7eYfOgX8uB17tWVeZ2sz5tAXUWPCES1jUDvIfIKqWnUv8CzAG2oJuTAn2b5WckFEK6QJU88PXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Xt7IEcWa; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3674e1931b7so27400f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 18:07:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719536838; x=1720141638; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QHuNYRVa9MaRtF3OqiAH8vWk9W7tt+JmVEYKJVNFQi0=;
        b=Xt7IEcWa4ZOgpufQNUtIQALZudmR2T4IN9b2TsrGPvkCwP/Hy5ag87ksyWQMMkjCnT
         ytLk9l0HRP3ku1ruXW+RePhADzDP1ftYk+PlZ4jV2mvW/4bnA9xxgtan+Z+nfzX30F47
         EIHoSWQ4GiNByTR3fcyc1Xc2H8Ss72iPAoihxM1Fykz3Vy2uhz5ehv/hqjhkvM1TvMCh
         haw/f1jWG8JTSFW2S/KE1eONCw7hIlMBJn3n5jdyihgp67Shhkq+x0CIE81V9zrRW3km
         TMpEsI5yiJzoGhzVXqjvrzpGIp+di/IG+UJJ6mugPuG3VvK1pmEdT+rMhG7VhiUgZLMt
         9RjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719536838; x=1720141638;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QHuNYRVa9MaRtF3OqiAH8vWk9W7tt+JmVEYKJVNFQi0=;
        b=s4XGBi0FSQZcgTV18RztDCmFlwZ8gUGvK91B/YNAcJzU8CdxDOYcqVMUJX0Uh6ZqYq
         nRjPcMCab5kMcyEMfC9TMSTpR89yzX+bf95CP1wzzbcm6O2sTLhUo6iub/zQOdZicR6c
         JoaSEpSVtRrZPIVssdcsv1cHaaArrEz7LNgzEtABOW6NZQtWkr0mSA2epvRWtQCcXCxR
         1AFTSuXm1FBsNPg7Sn7gDeBVuDpJrVrN9DN5mub2v8kTgUUC9QuDW+2dYnArBSnpwJTa
         7V6Lfl7cWMzXpXZ2zsclwDo4MpXuGgmUST5r7uVttXQ3gLAO5NOtLwUjMA/gxw1pw19o
         rgng==
X-Forwarded-Encrypted: i=1; AJvYcCWWLFMxhPp8ii+tnzdSerQj6AmHy836P30EyD+BFHqBm5NuKI402pZac89iDYG+P2LnJjozndyXuxLxIHmDB5pYOkKWFsncHJG0iNbi
X-Gm-Message-State: AOJu0Yz4aunzQugPvUQpMdBfsQTCyLSZPghs8JFAw6w438IJweHe3oQi
	bzwgDMv8+rdOw6xMDFwKHB+yNNFUgCz2HsxRjV3jqsMg3eYV0DxeYynIfD1M/w8=
X-Google-Smtp-Source: AGHT+IF3udj+skoJjmirIovH98gez1HrbmQEfLVlULNbdY3lNe98fjyToQ/tPdf9UZvUlx/d+JRROw==
X-Received: by 2002:a5d:44c8:0:b0:362:4dc7:dc7b with SMTP id ffacd0b85a97d-366e965298amr9542604f8f.58.1719536837965;
        Thu, 27 Jun 2024 18:07:17 -0700 (PDT)
Received: from fuerta.Home ([2a02:c7c:7213:c700:2cd1:b0e8:abb:540])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4256af3c27dsm13075805e9.7.2024.06.27.18.07.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 18:07:17 -0700 (PDT)
From: Alexey Klimov <alexey.klimov@linaro.org>
To: linux-sound@vger.kernel.org,
	srinivas.kandagatla@linaro.org,
	bgoswami@quicinc.com,
	lgirdwood@gmail.com,
	broonie@kernel.org
Cc: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	andersson@kernel.org,
	konrad.dybcio@linaro.org,
	perex@perex.cz,
	tiwai@suse.com,
	linux-arm-msm@vger.kernel.org,
	alsa-devel@alsa-project.org,
	devicetree@vger.kernel.org,
	elder@linaro.org,
	dmitry.baryshkov@linaro.org,
	krzysztof.kozlowski@linaro.org,
	caleb.connolly@linaro.org,
	linux-kernel@vger.kernel.org,
	alexey.klimov@linaro.org
Subject: [PATCH 1/7] ASoC: dt-bindings: qcom,sm8250: add qrb4210-rb2-sndcard
Date: Fri, 28 Jun 2024 02:07:09 +0100
Message-ID: <20240628010715.438471-2-alexey.klimov@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240628010715.438471-1-alexey.klimov@linaro.org>
References: <20240628010715.438471-1-alexey.klimov@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add adsp-backed soundcard compatible for QRB4210 RB2 platform,
which as of now looks fully compatible with SM8250.

Signed-off-by: Alexey Klimov <alexey.klimov@linaro.org>
---
 Documentation/devicetree/bindings/sound/qcom,sm8250.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/sound/qcom,sm8250.yaml b/Documentation/devicetree/bindings/sound/qcom,sm8250.yaml
index b2e15ebbd1bc..a92ac8501138 100644
--- a/Documentation/devicetree/bindings/sound/qcom,sm8250.yaml
+++ b/Documentation/devicetree/bindings/sound/qcom,sm8250.yaml
@@ -31,6 +31,7 @@ properties:
           - qcom,msm8916-qdsp6-sndcard
           - qcom,qcm6490-idp-sndcard
           - qcom,qcs6490-rb3gen2-sndcard
+          - qcom,qrb4210-rb2-sndcard
           - qcom,qrb5165-rb5-sndcard
           - qcom,sc7180-qdsp6-sndcard
           - qcom,sc8280xp-sndcard
-- 
2.45.2


