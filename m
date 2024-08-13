Return-Path: <linux-kernel+bounces-284863-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 503EE95061A
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 15:11:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74BCA1C21D40
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 13:11:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3BBA19DF69;
	Tue, 13 Aug 2024 13:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xoLyesT0"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7162B19DF49
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 13:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723554621; cv=none; b=O3qaHUhMK6ZvQQfjnOJDxOheewaRjccB8vbCTMp1ws1AejS57C8+K06hQwtLrQ72a1u+kGlG0Jl8jpF+3Xrrt5gSRHBeI+Qlu5y68odQawAFLEwbXJBa+fScdl9ZCp/Pz7kbPfDo39Eq9s6waWh5wn+e67iZA3fhBSKzUUTXsNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723554621; c=relaxed/simple;
	bh=2cwE07vpiCyGBrhyTLV34EZJb7Hk/Mu8zBy8VUuQNto=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Bi1E2aDyFdUR3/r83FYQmtrIHgFNNkRXACZi1CiOmLo6HNxoQHGF8HsjkoQuINf12CfBIIJaCKHTnV3sP4xiztJOV5F/+KQkyTFWNa0nAbol9CQZv/Db+RLJGwholG3zWP0dJOguWmzheY/yanYzYwoavKdveP9XS4A4d06AI4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xoLyesT0; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3684eb5be64so3052554f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 06:10:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723554618; x=1724159418; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mP8c2gbWyRGgea+bz+7uGbaKYyoVwEycZmklOCGi8GE=;
        b=xoLyesT0Sz/+NSSubmN9u+b5ybKkEz1lKXc0JYxDijE3uqMmzxAus2VZ9icMNGMXxZ
         fPoTC4uFFfE3+BpO+HxrX934QKHsjFtEy/PNFXevcPspqUH1bn9h0MlBqdf3/wL9hRgc
         RALbS/bYNM3KqN3DM/TVGsRmFd0EwAay0B0Q5Ft3PZWeSW9BjZmg9kt0ZLX7grfu1pdG
         /g6RPkPKYl5HcaEWPtqvhcNtqB7MRKICBDwoheyAkdTJ70H39PK7WBVq+7ZNgeK/73HS
         rWk9Mhelz8adRd8jqERSNBsct76vjFDqTppgIl40reR6htDoGAdMp9byQtIdsrSxo4Gy
         JFpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723554618; x=1724159418;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mP8c2gbWyRGgea+bz+7uGbaKYyoVwEycZmklOCGi8GE=;
        b=mHxXhcGX0H7ixOOypBRLnsXpcKaNnuNgGnsxnO5b+2M3ri+sydJMPWjJbCR0egFrnj
         VzCX4GzGs9GOe1DNiV7NHYb79TnChol7w4ipqh/h8qI1pAzgLQmdB9hPRmbzLWVtY2EN
         qAkZtzjJwwuiFyGTKWRV/GCLY1yX8rTwLO4NwMwZXKlsGVznojT+0PFCAOZsFY0H6u+D
         cnBNh24xJDLCTzlw2Mt7CyFVP7upvPkf005jdnag3Zq+MZjNfv5VGUdALRi6wn5+D8+P
         i0qCeikJnLCKPFJbn/eZirNmm2Gm5+WFaZUSU22qeqlNjaa+FAQi7H35PiXJeS+byc/d
         7p3g==
X-Forwarded-Encrypted: i=1; AJvYcCUrRFY0XaMbqYqbh7BJDFAV4Hc4+8oZJmTuCsSIGL5w7hoEzRMYzVw6mo5DEIbUKiQzffrN/NoEs9VUMj1QjOgiR4SUCKvUpoo07zLa
X-Gm-Message-State: AOJu0YzsGnVjKPU3DHDovhPdCszc5hQfkYp18f6j7FoQ5Xz7wTWNFSDo
	UPjc/AQy1LoJNjV4f+KaW/J9mUEk+wmDaBu2MApONwSYS6yeTO+rr4ACE19Trpc=
X-Google-Smtp-Source: AGHT+IEDchtCCXZEFTjTv7KCKp+KTGrJNg4Wo5BxMZL+yOQsb/AR6j4g5GGlBRSIedjp6ch6nbqYkQ==
X-Received: by 2002:a5d:4481:0:b0:367:96b5:784e with SMTP id ffacd0b85a97d-3716cd28208mr1973169f8f.50.1723554617874;
        Tue, 13 Aug 2024 06:10:17 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.215.209])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36e4c938280sm10305003f8f.36.2024.08.13.06.10.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2024 06:10:15 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Tue, 13 Aug 2024 15:09:52 +0200
Subject: [PATCH 6/6] soc: qcom: smp2p: use scoped device node handling to
 simplify error paths
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240813-b4-cleanup-h-of-node-put-other-v1-6-cfb67323a95c@linaro.org>
References: <20240813-b4-cleanup-h-of-node-put-other-v1-0-cfb67323a95c@linaro.org>
In-Reply-To: <20240813-b4-cleanup-h-of-node-put-other-v1-0-cfb67323a95c@linaro.org>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, 
 Banajit Goswami <bgoswami@quicinc.com>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: alsa-devel@alsa-project.org, linux-arm-msm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1946;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=2cwE07vpiCyGBrhyTLV34EZJb7Hk/Mu8zBy8VUuQNto=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmu1sjJN14aYmlpr8rTr9yYtjfVVS+zWUS2l146
 f7fNMYMCtCJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZrtbIwAKCRDBN2bmhouD
 1xmRD/9h/P0Het6Jm2rGA3UM3LAszAgU3PyV5T6E96tiL7xRF6IrhT+P6GS1+HrZeLHZt/7/3v2
 xvbX4iYvn7yHnGp//K4u+6YB3isGbI0dSbliRFs8bqdp8MndfYQoMw77n9rZJbSBqLDI8NLKshS
 wUDaHY5WFF894y/XXeTDM/PRA5cD6BlzevUcWPmr8gDtvUH8+LgocW+2P2UwnCwmX2DgwN3ZeQM
 WqLLEiUQTen+QI37hpUg6TvRYCRMLFkr/VMs3/kbHRYir/fBuolFVZFawgeX6gP7BLNVmUQxEst
 ZfqX7RPXVbf3zxG6ZNz74mbX9zbRSw0QoJczdjKiHMGOipCWmR778oHi8igpEKH4eTsQdRJhFnY
 zK15u0Qs8HFOm8ALMDmYrhsUOQyfuwdBcpI23XBimnNl/yZPViJZREmTEZkfe390bmIpc7mTTgo
 nzFuLKquUdYF3T6nDfVXN8btg3tXea42nBTjwWdVR5l8wXJSJWZiMZf/tkl53OxOE0jRJtLehRo
 8lVeIsD4Fcs0OwUKubSHxP8JxytWepvza4Ay3hdomgSPOilOyZfspn4RQikAl02pnm393jTf9M5
 MSeWXlH4VsVFvDiWocSaYUlIMxbToTvHCjMFE1B70QBhw6ry724w2jy33jv+7Mb55dEb/lL0s29
 2YG/JDwEhwT04cA==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Obtain the device node reference with scoped/cleanup.h to reduce error
handling and make the code a bit simpler.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/soc/qcom/smp2p.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/drivers/soc/qcom/smp2p.c b/drivers/soc/qcom/smp2p.c
index 4aa61b0f11ad..cefcbd61c628 100644
--- a/drivers/soc/qcom/smp2p.c
+++ b/drivers/soc/qcom/smp2p.c
@@ -539,7 +539,6 @@ static int smp2p_parse_ipc(struct qcom_smp2p *smp2p)
 static int qcom_smp2p_probe(struct platform_device *pdev)
 {
 	struct smp2p_entry *entry;
-	struct device_node *node;
 	struct qcom_smp2p *smp2p;
 	const char *key;
 	int irq;
@@ -593,11 +592,10 @@ static int qcom_smp2p_probe(struct platform_device *pdev)
 	if (ret < 0)
 		goto release_mbox;
 
-	for_each_available_child_of_node(pdev->dev.of_node, node) {
+	for_each_available_child_of_node_scoped(pdev->dev.of_node, node) {
 		entry = devm_kzalloc(&pdev->dev, sizeof(*entry), GFP_KERNEL);
 		if (!entry) {
 			ret = -ENOMEM;
-			of_node_put(node);
 			goto unwind_interfaces;
 		}
 
@@ -605,25 +603,19 @@ static int qcom_smp2p_probe(struct platform_device *pdev)
 		spin_lock_init(&entry->lock);
 
 		ret = of_property_read_string(node, "qcom,entry-name", &entry->name);
-		if (ret < 0) {
-			of_node_put(node);
+		if (ret < 0)
 			goto unwind_interfaces;
-		}
 
 		if (of_property_read_bool(node, "interrupt-controller")) {
 			ret = qcom_smp2p_inbound_entry(smp2p, entry, node);
-			if (ret < 0) {
-				of_node_put(node);
+			if (ret < 0)
 				goto unwind_interfaces;
-			}
 
 			list_add(&entry->node, &smp2p->inbound);
 		} else  {
 			ret = qcom_smp2p_outbound_entry(smp2p, entry, node);
-			if (ret < 0) {
-				of_node_put(node);
+			if (ret < 0)
 				goto unwind_interfaces;
-			}
 
 			list_add(&entry->node, &smp2p->outbound);
 		}

-- 
2.43.0


