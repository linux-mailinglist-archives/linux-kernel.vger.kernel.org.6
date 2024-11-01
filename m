Return-Path: <linux-kernel+bounces-392623-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3026C9B9665
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 18:19:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D05031F21D4F
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 17:19:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE2D31CB514;
	Fri,  1 Nov 2024 17:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oIa6f0uL"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B34F1C9DF9
	for <linux-kernel@vger.kernel.org>; Fri,  1 Nov 2024 17:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730481567; cv=none; b=sY94FOhACROR5k5303F9p0cKziZ5Tn+7kAKPo3BQSb/okTgwO+30icHT8AznmkQcfKXyv1S325331bLZAd7iYb4QxCQForcKId6O0gYYj4Tn6dj7zC1gbmLj9kHGEK22arPPyMhTPwjj2DzvPPqKBNnujnz+6ywgIXMHxJKJ5tM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730481567; c=relaxed/simple;
	bh=rt8kjqYI4hECPN+GbzUP+TlVy0J28k2Oz2llBOlBl6I=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=MM5e7HnFMgzQ0bEMbw3OXv3mmrY17u7JOiw/2UXyr5f+LBzYbPvnOmc4iAxpc9msr5NIQkuAzBFHiCp2dbKrYRi32XQBljWoV1VNq748aJEyqoTtBpY7Furoqs0C8YuAIM7b19vAHlcFZpYs/KXFOzsYpfzeHbW4mmjG4bu22Rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=oIa6f0uL; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-43155a6c3a6so2187065e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2024 10:19:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730481564; x=1731086364; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yyz45xnW9rVPfU/62f8rIc8WFlRolqjmAGKe3fVtKbg=;
        b=oIa6f0uLQal1DUglT/A85Pwxw1SfB+/TZnQsduZmT1q+WwCvVQwMnxTBUqiPyIIzmw
         1aUrtE01fm3c8R6RqjiuJDqtSJ6xHgdAl6ypqvno5NHHOPfvPHuBfRIHmw7B47bv/UZY
         CFi1DOjRG+NpzGH/FJxR+WytV/Ja0SxtoY7J1XAJlqmIKnmNDLubqBIgaws3CMi2KhQW
         3BKpnU4wCinRjt+oOXFXTKxBts6LRSldj6iSYd4j33q6O0D2XPn+1cemFNSVcrYbzzlB
         o8LMOS5Z1fMwnslTSP2Bj49wo5uRwvl4NDtbit+sOFrru11ecEnjKtQ1DnBYxOKlmMHK
         Oo5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730481564; x=1731086364;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yyz45xnW9rVPfU/62f8rIc8WFlRolqjmAGKe3fVtKbg=;
        b=BDTBL+ReQ6MjpJi0MeKFuGykdQ0hNrrSdc6Z0OabDq8TJPAP//RCdpEP90xRZP02U2
         jrZC4rtnXm/4dU57obn/y8Vq1fA8r9t5fScDf/kDqkReS9girYp0Vg+03Z2/E/k2y1/f
         2pNZQES9HYjdsA7Mk7VVZkVQHNjYLxUPfWHcGxQXiLi/Io1Gy6rRfp/SNSKRYalzsMX+
         rgZRBj2wNV4jFMSszE/aowdKzbjMg5XhEaP8MXzNcyGncBpujF+rjPsR9qYDKheNnZjK
         QBxhDjBmjQ3QocmGtEoj81Hr08INsTnh94RF7rM9uEhhMCVfwcLEFEb0mDTIxAzzydv9
         D6Ow==
X-Forwarded-Encrypted: i=1; AJvYcCXqtEoFdB5eqge3sx3q+6pa9mCfSwb4sMLPduy8wR39UWfFvhf/xqNvTrIM9vaUQiCb8dGLpRcD1w9hwWc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZlCdC1JyNfhtOhQDj2GwNbnc11X7Ssg7HNcis1iiKQ8NmPN6L
	37Slv0nWXJdTDaiVPS5XwdUKN96QUjUzwkTxQ1AxiMq4YYnyx8UHnTKvVgtVWB4=
X-Google-Smtp-Source: AGHT+IGyPwXyvUs9k5FWzP5oA9fjobpRUwqCYaIqND9lEL4Ls9AMutUr54tuWclkLAuV5EP1fHzX8w==
X-Received: by 2002:a05:600c:1c91:b0:42c:b9c8:2ba9 with SMTP id 5b1f17b1804b1-4319ad2b318mr90729495e9.6.1730481563682;
        Fri, 01 Nov 2024 10:19:23 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.211.167])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4327d5ab305sm68536785e9.7.2024.11.01.10.19.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2024 10:19:23 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 0/4] arm64: dts: qcom: sm8750: Initial audio support (not
 yet complete)
Date: Fri, 01 Nov 2024 18:19:10 +0100
Message-Id: <20241101-sm8750-audio-v1-0-730aec176459@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAI4NJWcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxNDAyMj3eJcC3NTA93E0pTMfN0U41TztCQzczNzQzMloJaCotS0zAqwcdG
 xtbUAb67ME14AAAA=
X-Change-ID: 20241022-sm8750-audio-d3e7fb676716
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Melody Olvera <quic_molvera@quicinc.com>, 
 Satya Durga Srinivasu Prabhala <quic_satyap@quicinc.com>, 
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1645;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=rt8kjqYI4hECPN+GbzUP+TlVy0J28k2Oz2llBOlBl6I=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBnJQ2TmiZvkJQoDkX55Rjiwz/a1WrAk0xdH5zwN
 b6sQi/nhTKJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZyUNkwAKCRDBN2bmhouD
 1zSTD/9tONy9wEoWga1J8kwKe1bn3QgaK2JKnnaS8CppKnO3/HadhLdKAxLT6aTLhCFSHvmySsa
 R5QtDNh5BB6U1j3EaSe1lBr9NGgYm663x3Qvnzv4+gDbm7a2vi2kgmwAeL7QHrW4uATSZVdepuv
 GsG7obxrc8+GFVyCaeuXc4hN5EONNGxBMD6hUnJ0CLQouzRUJRegeZbnZR1U0fTYbfoVnVBil0s
 Bl81s7Mpyx6/pYJRmhjjeiJ1HhbqZDVox+O+rTVkgvnF4SZ0QSbnwVPvZTLD6OVh/qOBE2DO7dG
 nESk8KZHAfTcg9al6f4ZGOg4L9CUyKIto2ryTHWoAIwvnlxUUCs5kLJnfUKKOEyh4eTZfaq4Ru9
 VLmX0klNXIU4iMRZfxwEE3xpJYJn+swuTAw8wyAoP3r/VtkZAEPj4/hWZVxAzTYzolacnh+rt5S
 7M/cs+9Fon0wTm9kr7R2LE4I9QD/KR8E52D0Zz2tkWHxPeCKRXadXNsej/zx0h+1k4zq5+WWlAp
 FHo+PbkcGD10G+fQU3BI6+3uhZOyg92NuqOiG+OQgZTJH6ve/f7N+E3b2Zg0Tr9qesnTIFcRL1q
 dBHkMn2ll2aqBMK3tTQGHc29BAGC1MpPEs/UC3CFC+w9y14M0h+GSDWsSVhA8nmy6XHptMQgQ7P
 kS4FQpJT80B0C/A==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Hi,

Dependencies
============
Depends on: https://lore.kernel.org/all/20241021232114.2636083-1-quic_molvera@quicinc.com/

Bindings for these
==================
All DTS added here have corresponding bindings, on the list:
https://lore.kernel.org/all/20241022064238.22941-1-krzysztof.kozlowski@linaro.org/
https://lore.kernel.org/all/20241101170309.382782-1-krzysztof.kozlowski@linaro.org/

Applied bindings:
https://lore.kernel.org/all/20241022064214.22868-1-krzysztof.kozlowski@linaro.org/
https://lore.kernel.org/all/20241022064155.22800-1-krzysztof.kozlowski@linaro.org/
https://lore.kernel.org/all/20241022064245.22983-1-krzysztof.kozlowski@linaro.org/

Description
===========
Add necessary SoC components for sound on SM8750: ADSP and relates
blocks, LPASS pin controller and macro codecs.

This is an early release, as I don't have sound yet fully ready, but
speakers and DMICs work with these patches on my WIP branch.

Best regards,
Krzysztof

---
Krzysztof Kozlowski (4):
      arm64: dts: qcom: sm8750: Add IPCC, SMP2P, AOSS and ADSP
      arm64: dts: qcom: sm8750: Add LPASS macro codecs and pinctrl
      arm64: dts: qcom: sm8750-mtp: Enable ADSP
      arm64: dts: qcom: sm8750-qrd: Enable ADSP

 arch/arm64/boot/dts/qcom/sm8750-mtp.dts |   7 +
 arch/arm64/boot/dts/qcom/sm8750-qrd.dts |   7 +
 arch/arm64/boot/dts/qcom/sm8750.dtsi    | 342 ++++++++++++++++++++++++++++++++
 3 files changed, 356 insertions(+)
---
base-commit: 79a3183ceb8e6f3607f138733786b5022dc2001e
change-id: 20241022-sm8750-audio-d3e7fb676716

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


