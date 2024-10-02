Return-Path: <linux-kernel+bounces-346930-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 17D5A98CB26
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 04:20:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD8A428630D
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 02:20:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 571F01759F;
	Wed,  2 Oct 2024 02:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pITeRcQj"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 260D7C8C7
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 02:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727835625; cv=none; b=vBMCBS2xzUJwBhZpQSGz0BJJ3ZOSXaW/4uR+zYLdwSG981Rg1nMCAsq0svXUotpMpot2hrteytKENnLnhBoZUe1e+ooZSpoMgpx53KA8cjl6xwKPcdH9JmL7061HFG68sXGcBzrnCScaWUAktPBgoVsP76D/wu2P7Mckaq4wADU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727835625; c=relaxed/simple;
	bh=h+nCwsYfs5sYx3LuwElbokrzjS36O6h6OKiN8mmmqqo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WVqk7VLqMg+yV1BLC1hZrjePRdWbk//DYglPxJzvVB0jraWUJjm1NaqKPsUceXDNJjaaxX9flivpienpTQvb0+QIBzcNu2XhHnOZm/wtqT2763mTQN9s+NvriZ6DLeZl9PHKRFMakyzJv57DYMmEcIYpBJj/GfgDHXvgpSt5dVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pITeRcQj; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a8d51a7d6f5so802089366b.2
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2024 19:20:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727835622; x=1728440422; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n9xIAfbz7fjBNidtmDjZcASh4YKSIa46CQvlQ26gYQA=;
        b=pITeRcQjnYf9+YkWuin23jKW+/tCOe2nCQx7lzIh0dDNSD/CTucHVsXXZSRGbQQLyX
         4OD+AIk5Uohwjlc3nLdEgvX77Za/DSMmLa3StS+7Hl6hQgG2DKR6w4tGnEEqx7snyaue
         j7Cuw8JdG7++OrGhmO7rNhSGPhY65YiBNbAxrXa2Ct4hL7DJOGdnYwDFLnTWUbew1/ty
         2ByJBF8mKagUrJYaYwFCxdZ1kilR6oYadAtYn4apMQB556LaeY2B8SzEsmGxYGtwCDRs
         AE9vRyVaLSPEewLhuELEb2qk0hst+o8uJVrGf8N7evzrY+7MOsJHZ67+RHV4sq1wHN3l
         SBSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727835622; x=1728440422;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n9xIAfbz7fjBNidtmDjZcASh4YKSIa46CQvlQ26gYQA=;
        b=iaZMg3a0AVX79MoYkYad92hWS6BgIEU0NDK98ndIIK8TdzAALDNFQqlnFgdoroaa8a
         GIhhpaIn1JN6EjiZBtRklqpqUarOyaJi6bdmQPDrEnrNdyCE3x8DwFrrvXgk1kUqpfGA
         U/1FmCDNZfcHuK7VSYXS4k2GiQzVZ3NIdX7utGvuLchBQzXDRu7LBAofWe7dQ0BFaa6n
         L/Ja0wHZwkdCbu1n6hjafh8jIqVvX9NnPxAOx9H6UwN/xWxXgd5thGqC8Mo42I3C2o76
         1WIhBJ/qP3UctIGrwXjy/I/EGFdirkJEHBT4JhYKlAdSJ7FdsBe/RLwaT7NArTCXFl0b
         qBlQ==
X-Forwarded-Encrypted: i=1; AJvYcCXJlnFZWftRqsvje03mbOG7+icaIQZYRvTnjkjZ5GsT+iYO8YS+of45AmXVdu8rqNqf7q01lLRudky1HM0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxG1tKz5sW8SNEBLG19xNkWYNwhZF1FDwbXmzQX8a6iEOnxWwBw
	NTILvt7hIp8Llnay0/CXtNfTYUK+nOp/Ea/gYxrEjC4Xrdw19aV3XQwK01GAk0I=
X-Google-Smtp-Source: AGHT+IFLmq+2mwLJhF5wcOOkF3bdVL/ltt9sQiXECke/uv9VIlvSNZdfCfyEy1s8dICY8l0J/ILy0A==
X-Received: by 2002:a17:907:268c:b0:a86:82e2:8c6d with SMTP id a640c23a62f3a-a98f839d3ccmr130606766b.62.1727835622420;
        Tue, 01 Oct 2024 19:20:22 -0700 (PDT)
Received: from localhost.localdomain ([2.125.184.148])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a93c2945f2esm787518866b.117.2024.10.01.19.20.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2024 19:20:21 -0700 (PDT)
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
	a39.skl@gmail.com,
	alexey.klimov@linaro.org
Subject: [PATCH v2 2/7] ASoC: qcom: sm8250: add qrb4210-rb2-sndcard compatible string
Date: Wed,  2 Oct 2024 03:20:10 +0100
Message-ID: <20241002022015.867031-3-alexey.klimov@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241002022015.867031-1-alexey.klimov@linaro.org>
References: <20241002022015.867031-1-alexey.klimov@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add "qcom,qrb4210-rb2-sndcard" to the list of recognizable
devices.

Signed-off-by: Alexey Klimov <alexey.klimov@linaro.org>
---
 sound/soc/qcom/sm8250.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/qcom/sm8250.c b/sound/soc/qcom/sm8250.c
index 274bab28209a..19adadedc88a 100644
--- a/sound/soc/qcom/sm8250.c
+++ b/sound/soc/qcom/sm8250.c
@@ -174,6 +174,7 @@ static int sm8250_platform_probe(struct platform_device *pdev)
 
 static const struct of_device_id snd_sm8250_dt_match[] = {
 	{.compatible = "qcom,sm8250-sndcard"},
+	{.compatible = "qcom,qrb4210-rb2-sndcard"},
 	{.compatible = "qcom,qrb5165-rb5-sndcard"},
 	{}
 };
-- 
2.45.2


