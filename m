Return-Path: <linux-kernel+bounces-232342-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 08A5291A71A
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 14:58:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 896591F26012
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 12:58:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED6591849E3;
	Thu, 27 Jun 2024 12:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rHChTwNA"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB76E179965
	for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 12:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719493049; cv=none; b=gWfov2poB4UWyF1Xkn2F3XNG2tedYscCx2GEQVdSQi4tB7z89cZ2fyimUV4gxhXA53OlXtKqraDP3veKbwxPVBa3O0N3nTckeR/ixgs5yAr3jXwJOlazAsJa/5I1hri8SHKWdNHlvcGYZDtpEGZC5a5a83jtzdcJQk4KCZPmbp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719493049; c=relaxed/simple;
	bh=NyS3TLZdFohVfLQ5bqtioaXNOjd/oLz6cpJ7e11ZJ7U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NV0yu14XSIU4pZ3PjvxF3QL+HZ4tU+YGwhoYEzxlAmCreJ6Gol72n2zVpOQS3ubUiYXzGQFER0KKSN/DzczolEpYwdCPYFkyqBqHYOLkUxhD2c2pJ8juyz1QYmQhxtsc6+6RxzkhJ7ciEbQl6vkspmVmnT0Oi4s31vh2Ro21aYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rHChTwNA; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4248e28de9eso40815865e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 05:57:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719493045; x=1720097845; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Te6g76k8XNkEaZHqMN4hQzbVVFxq2CbJOANJNvJMA+w=;
        b=rHChTwNAwEgYdw0OG3LW66N95OHxH6baL/u1XKNaSBEX/UAMjRxcP2m/+4IegV040q
         DdOR/fbWvLIbP9/rT01GoiSLY6qavZ4K8vYhrN2whoeSiTWMi8qKG1VwKapKFi+TX9eN
         RE1H32xAufRPFc6xJIHvDSK8rc1dBWlxFHU6YI0aacZMvqsOaUkBuPUXapbHp/f7TFKp
         hBkCjoE/1VDblTj+7m/cd/d5oYzsXJ/WsMcfog/5iu4qXqTMLu1cie6Kvpl7058HsdU1
         imf8MnQQsWZVBjgmi1EydvWkMxbOGWYaO70XO8Lhpb4EaOVq5MfMIDDKnZmXNQWTLO1C
         /LuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719493045; x=1720097845;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Te6g76k8XNkEaZHqMN4hQzbVVFxq2CbJOANJNvJMA+w=;
        b=FylgtEohUMFkj4OIPaqDiJWtUrBWDh4VZ4+WkbyNsmIxBrQ6VpStR4WKfgRH+3aGSV
         TqSN6rVXui1qvrO4hCyxsUzeG0zPQaoafNzqk4PpGBnbmQQRVVHIIAsA/qWyMuYmvJuv
         SSIQGJyVJcjZu4w9MnAJ2+cd4eaKRSXWD7SifPF/EMngQcd4eXQEK4k96NI1dcpbklsi
         vI8az3HAZjOIJpdUgfbEjITkru3NbA3oNw3iTPMadS06hUWvdgc6aJxcehtwrLmj0WXZ
         nqrn/U72fRFgaK40GR1MDD1jzuPtxTxyrOaNctfRB8RF67B9UtQ8GILEjpRGm5EcwOA1
         P3yw==
X-Forwarded-Encrypted: i=1; AJvYcCV4dSDwinP7sUNXfcovQsa8hmGpPVCNmqSzTQK7dd3tMU5ZyGxQXGa0Ku8I6lR8OAge7RiNaRuJfL1ydzO2Tx8C+0VONKjese4yisfA
X-Gm-Message-State: AOJu0YwmjApqKhi5480fH3FfE6sHGJzbrnXjyp/jgxFBoH3gwnnqTwOi
	NaUwT7l7wY7ZfzuzOquiYpiwZXLhrHmSo0AtVezfb4SUvOEVFnnX8Db3KLL2uBOmkYXBvVB7tXS
	FNFI=
X-Google-Smtp-Source: AGHT+IFBnAk/qN/L3JWjCwHZN/xfyMXbj6Qd6jXyAHhIu3H2hS3NCKaHjU/ZqsHMpoDfIu2ZxGcesQ==
X-Received: by 2002:a5d:5f8f:0:b0:366:f41f:8cc7 with SMTP id ffacd0b85a97d-366f41f8d56mr9555673f8f.46.1719493044795;
        Thu, 27 Jun 2024 05:57:24 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3674357fcecsm1800752f8f.26.2024.06.27.05.57.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 05:57:24 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Thu, 27 Jun 2024 14:57:16 +0200
Subject: [PATCH 3/3] arm64: dts: qcom: sm8650-qrd: add port mapping to
 speakers
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240627-topic-sm8650-upstream-was-port-mapping-v1-3-4700bcc2489a@linaro.org>
References: <20240627-topic-sm8650-upstream-was-port-mapping-v1-0-4700bcc2489a@linaro.org>
In-Reply-To: <20240627-topic-sm8650-upstream-was-port-mapping-v1-0-4700bcc2489a@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1742;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=NyS3TLZdFohVfLQ5bqtioaXNOjd/oLz6cpJ7e11ZJ7U=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBmfWGwOJO9+ISZb4i5cZ9u+tTfMObpcRWR5nBDMMS9
 oSn5o8KJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZn1hsAAKCRB33NvayMhJ0UMnD/
 0Rpuro+D1aA8cM4/FNDFr2dRklfDJDjISR9dxszySGW1J/7E0jO54HEbwZmtXYBSB2Jclu533WMB+u
 JF/ZBlFyo2TxUnIu+2P5RMYeoQUFr2B7fDG8aM3ROQw9MjnO1TOb3lYVJcKjSyL58Pl+F6Z8NNyS8b
 VAb3N3CeSrTpaITIkpMYNcLo9rgKFXxD/8/J6yMavlfKPY2MQEtPBvIZ8WOwKwI3n2tGhSqHD5qZ+L
 9Mik1uwBpeAthGtEPRvaGHWOEkUS+PnD+adqLm6yv9qhbBQRcZkxABGa8dxMf0ktGD31+2F7E5WiPn
 h1LsC1y3/KIB/6G12QQUnVbmsw4Yx7yveirKR1u9isQNqVD0QFVC+eZmL8rjd9JQJhv8fAuA7hkCdf
 TsgIhIrZCE2UcqUkZJaRUxuujgBOmxk6MYEQ4XFxK1UXSzNp5lPB/8rqbCy/fYGKDhgXRnh70JKVpr
 XqFZppJC6NMouInC1ZK3hJdlsR2Hdt0GygRRRMDrHYXgp4NsinS3ncHP+9uKI5CPBzme/Xt2SWBZGs
 sHkEOXexD7jr8RLhny7Hk6swWn/xvaajpqUtyzmb6avbanYApWXBm1O1B+20qMoNvZ5PWyA9yK2z8v
 AXseo6hH9+zDVlvoKTH9LNO4ILPy5A0p0ADAgZtiKeLCzwrw9h2euKxPF/lQ==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

Add appropriate mappings of Soundwire ports of WSA8845 speaker
to correctly map the Speaker ports to the WSA macro ports.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8650-qrd.dts | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8650-qrd.dts b/arch/arm64/boot/dts/qcom/sm8650-qrd.dts
index 6e3c4d8dcc19..b0d7927b708f 100644
--- a/arch/arm64/boot/dts/qcom/sm8650-qrd.dts
+++ b/arch/arm64/boot/dts/qcom/sm8650-qrd.dts
@@ -1089,6 +1089,16 @@ left_spkr: speaker@0,0 {
 		sound-name-prefix = "SpkrLeft";
 		vdd-1p8-supply = <&vreg_l15b_1p8>;
 		vdd-io-supply = <&vreg_l3c_1p2>;
+
+		/*
+		 * WSA8845 Port 1 (DAC)     <=> SWR0 Port 1 (SPKR_L)
+		 * WSA8845 Port 2 (COMP)    <=> SWR0 Port 2 (SPKR_L_COMP)
+		 * WSA8845 Port 3 (BOOST)   <=> SWR0 Port 3 (SPKR_L_BOOST)
+		 * WSA8845 Port 4 (PBR)     <=> SWR0 Port 7 (PBR)
+		 * WSA8845 Port 5 (VISENSE) <=> SWR0 Port 10 (SPKR_L_VI)
+		 * WSA8845 Port 6 (CPS)     <=> SWR0 Port 13 (CPS)
+		 */
+		qcom,port-mapping = <1 2 3 7 10 13>;
 	};
 
 	/* WSA8845, Speaker Right */
@@ -1102,6 +1112,16 @@ right_spkr: speaker@0,1 {
 		sound-name-prefix = "SpkrRight";
 		vdd-1p8-supply = <&vreg_l15b_1p8>;
 		vdd-io-supply = <&vreg_l3c_1p2>;
+
+		/*
+		 * WSA8845 Port 1 (DAC)     <=> SWR0 Port 4 (SPKR_R)
+		 * WSA8845 Port 2 (COMP)    <=> SWR0 Port 5 (SPKR_R_COMP)
+		 * WSA8845 Port 3 (BOOST)   <=> SWR0 Port 6 (SPKR_R_BOOST)
+		 * WSA8845 Port 4 (PBR)     <=> SWR0 Port 7 (PBR)
+		 * WSA8845 Port 5 (VISENSE) <=> SWR0 Port 11 (SPKR_R_VI)
+		 * WSA8845 Port 6 (CPS)     <=> SWR0 Port 13 (CPS)
+		 */
+		qcom,port-mapping = <4 5 6 7 11 13>;
 	};
 };
 

-- 
2.34.1


