Return-Path: <linux-kernel+bounces-523672-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F36FDA3D9DB
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 13:23:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A48E17D91E
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 12:22:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F9FC1F5425;
	Thu, 20 Feb 2025 12:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DS1flgh5"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 817401F4632;
	Thu, 20 Feb 2025 12:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740054149; cv=none; b=hQXyU0lSfSO+8JnRE5WD9kX2UlZ5W5FQ1g/Tx7UxlYgC+z0XbnqfUqfLdfmzxKsFxcuWBFaGVUkaNQAFKOqQL+7d0MiptgJRVEjKTcBciZJzu8Gu0GJsqjKGNRzm26wb7fAdWR4z+Rap6vWRi9zE0LY7hCOEX3EqHhL/a31Hi5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740054149; c=relaxed/simple;
	bh=x8vUs23nLD376IRPtFWOy/bkius73HrUEIt6auOclws=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=kpAmbAd25uwho/AvcDeWVnjcW8mTqRmECmtD+hU3YieVyu6Mm0uz17OX/iOOGpQg6kWpCCsjg8SVPQN06aRJy4jL1G/mCdMxMyMkOj4bSSftts7NDJaXc0bW76rFPu3pjcoKV1qzjyQ3ghJgN5TIgQXq1Sp8/wCF7uJdhXcNYDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DS1flgh5; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-221050f3f00so16218295ad.2;
        Thu, 20 Feb 2025 04:22:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740054147; x=1740658947; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PxoHLUi1TIyVjtHTj1O4KVcJUPyjk0t7xM63xGaqPFA=;
        b=DS1flgh5Kl6sqaWmS5ej0Vz4sqUlrXcOKF32dCwPwlRYes9qXobjfKmXFYE/rr09bf
         3dGRvRsaT6LNROE4KZqGKWg2Kfym3PpMdir0w+U/W3DO+ZTQfzTKo6EjNIVGKb/HDnih
         0YzS8fhes9T+5nYlP9Di+E9RW7k5evHhecHDAJdBaXcsmYK/Y7MKfjxDO9mqwuJ5ZQnU
         TLumqgVlKPVLg3See5aEyU7zujTAjsEmnDbsscmcujgpQx4oxyIjlKMaacmquswPAoQ7
         qzW01kTiD6vHpImwq6xrPQVgzkMm5lsZFJWPWZojQlRFBkfaGQrd6NOC/pZ2QwUKgmqa
         T7tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740054147; x=1740658947;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PxoHLUi1TIyVjtHTj1O4KVcJUPyjk0t7xM63xGaqPFA=;
        b=N3v0etign3OgqIrO6LCGZrc1EzI2qj6J3hM2K/wEpHdYlKnqpWRSSjZn6eJitytADL
         CJSErfnJLUVw5c+6CTkroLmMvDrsLXG7YaBq922vwhN6QCkVvDjnBa1ERKCS/Y4xdXj7
         e3Hv5BCF4ZliMlKpWtNM9mOmGiHpPduXTk/9WphzskW7C76VL2uqB2erA6I2MTvsTJDR
         sJ25vqRCdFLfg1ECVWQnZ5+nc6lGleleR45yA/P341odDATf5xgcUf0HvnZ256oeWwwp
         ceAJ4EWps3jhOGpCh75YS2ztkq7XPvoQirzb4UdJ3ruUwn356TY9kRuemr74dKcfcj5l
         5FDA==
X-Forwarded-Encrypted: i=1; AJvYcCUfro3gbqOR4fgwpp+fokvvupIonmTATcjEQ/EI+cQwHolSkCTVeRP16aP0Zir2FrNR2M/Ru/mG/37g@vger.kernel.org, AJvYcCUwVymTgL1qr9ElXHSjd6Pw8cORcV20BFLb4RVBuxZNBzYFXPjJWnEIYXicg3KlKU2YAllMru0K5+6hAwjN@vger.kernel.org
X-Gm-Message-State: AOJu0YxpFZh+N4YE3e8YuQ7/Ww8rJULLwBLQomZ1JuWUr3sG0WdkZT1d
	uYCiHrN0uxbxiMfJpXhlfXzMdbCEZCzYnLFGBHCcuh5fvKN1OqT/
X-Gm-Gg: ASbGncvUzMwRkvQ8gBNqwLLHBG/LFt0ifqd7MOMaxnkSWfvOVZ54OiRBPgBa63Zankx
	B73ello4K0YCUpbocT6k9b5NZG2avfz3ZiRauvuWlxMfxFE4DhfPBFQDz7hJbkDmAsnQatpkxbd
	HxnYLb5vQf5Le+AvivtWTN6y8AvbOS5KEAwLhT+H+YuVV3e+L29vLqyugjl2zu1hGDNB0baFe6S
	N0zR/v1ua6+GMjQ+dQVHOVU22DzY+XnRw0/i+2tPzNjtN5k2Mov/QPngm1I8d/ZTs0Gt7oKnvTR
	+XpG9LsSNc0v4N67Mw==
X-Google-Smtp-Source: AGHT+IFPQJbD8Y0DfSGbKnFh8OFeQduLpjR2nCX2HZ+uxq5kUCQXB763DW1dJpfmXDKj/IsrLgKhzA==
X-Received: by 2002:a05:6a00:1903:b0:730:888a:252a with SMTP id d2e1a72fcca58-732618c1eb9mr32642016b3a.15.1740054146231;
        Thu, 20 Feb 2025 04:22:26 -0800 (PST)
Received: from [127.0.1.1] ([59.188.211.160])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-73242568146sm13653149b3a.47.2025.02.20.04.22.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 04:22:25 -0800 (PST)
From: Nick Chan <towinchenmi@gmail.com>
Subject: [PATCH 0/9] arm64: dts: apple: Add CPU cache information for Apple
 A7-A11, T2 SoCs
Date: Thu, 20 Feb 2025 20:21:41 +0800
Message-Id: <20250220-caches-v1-0-2c7011097768@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFUet2cC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDIyMD3eTE5IzUYt2k1ETTFGOjNEvDtCQloOKCotS0zAqwQdGxtbUAg5z
 SUFgAAAA=
X-Change-ID: 20250220-caches-bea5d32f91fb
To: Sven Peter <sven@svenpeter.dev>, Janne Grunau <j@jannau.net>, 
 Alyssa Rosenzweig <alyssa@rosenzweig.io>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Nick Chan <towinchenmi@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1554; i=towinchenmi@gmail.com;
 h=from:subject:message-id; bh=x8vUs23nLD376IRPtFWOy/bkius73HrUEIt6auOclws=;
 b=owEBbQKS/ZANAwAIAQHKCLemxQgkAcsmYgBntx568W0BJpT5y33IzqtpAl5xiNefECBeocdaA
 G3h6DdBr9iJAjMEAAEIAB0WIQRLUnh4XJes95w8aIMBygi3psUIJAUCZ7ceegAKCRABygi3psUI
 JJ2mEACU7xnn3GkLol4g6uNkJmYfTXbvOFRtGSPksAHFzpaPYHeF6tCJ+QOL2JxMqXjJ2z58uM6
 eI97d1zgxWGEcPbGOh5jVJGjXzZxqJm8KPNtF3DMfRKMYUmjZ0Lmih1ghU7l+BAwKMcW37B3s0q
 0eKbwQVfrWHt7AGSumZXWnYZ/PeNLbvW1f+q5zk/EnVCRjEXp9hbYfLbvYk2Au+d1t0XD/79gp0
 teTwCARVArcj33NMB360pVAJW+NaiLBdJWRwJVqr0hEpeHSq7DSgaQQm7Jp4JbabpsaevpM/PnD
 lKjUJO5Gql8AQBeqt2CtoLJiereJ1RBpn8LW6c/jWoxh4+HqR69liJxkknq4jL/TmSKvOdNzG8q
 lNhxXt/Cmf8Gow5qtPdR2tLfaIHMgiwLupckugNj5cxisnrWMhyIqaNdbmq8XLGC9sxP2cUYvT1
 aFFry5dp3kAwof5raujuJSGOPvhyQiUOUWOoEUHaoAOmZSzh6Fe4N3iLQhLuYQc3sXWXHqFtlpx
 jBQCLj+IgeaMeGb5eqDr4jJsIcRA7+eAiBnBHyRsVMGeZbkNJL6kP8iDYy8RzCNF27FSHKtfFPL
 GfFLtCHP8kdqAW8ObzUIwJ7Vt+ZxZv8Rrigm4kQ2O0dcqx6o+p0Uc553mjCQQolg9Wt896+vm2z
 imvAjodSIWFfQxA==
X-Developer-Key: i=towinchenmi@gmail.com; a=openpgp;
 fpr=4B5278785C97ACF79C3C688301CA08B7A6C50824

Add CPU cache information for Apple A7-A11, T2 SoCs. On Apple
A10 (T8010), A10X (T8011), T2 (T8012), only the caches in one of the
CPU clusters can be used due to the "Apple Fusion Architecture"
big.LITTLE switcher. The values for the P-cluster is used in this
case.

Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
Nick Chan (9):
      arm64: dts: apple: s5l8960x: Add CPU caches
      arm64: dts: apple: t7000: Add CPU caches
      arm64: dts: apple: t7001: Add CPU caches
      arm64: dts: apple: s800-0-3: Add CPU caches
      arm64: dts: apple: s8001: Add CPU caches
      arm64: dts: apple: t8010: Add CPU caches
      arm64: dts: apple: t8011: Add CPU caches
      arm64: dts: apple: t8012: Add CPU caches
      arm64: dts: apple: t8015: Add CPU caches

 arch/arm64/boot/dts/apple/s5l8960x.dtsi | 13 +++++++++++++
 arch/arm64/boot/dts/apple/s800-0-3.dtsi | 13 +++++++++++++
 arch/arm64/boot/dts/apple/s8001.dtsi    | 13 +++++++++++++
 arch/arm64/boot/dts/apple/t7000.dtsi    | 13 +++++++++++++
 arch/arm64/boot/dts/apple/t7001.dtsi    | 16 ++++++++++++++++
 arch/arm64/boot/dts/apple/t8010.dtsi    | 13 +++++++++++++
 arch/arm64/boot/dts/apple/t8011.dtsi    | 16 ++++++++++++++++
 arch/arm64/boot/dts/apple/t8012.dtsi    | 13 +++++++++++++
 arch/arm64/boot/dts/apple/t8015.dtsi    | 32 ++++++++++++++++++++++++++++++++
 9 files changed, 142 insertions(+)
---
base-commit: 3febe9de5ca5267618675650871a626d0901f8cb
change-id: 20250220-caches-bea5d32f91fb

Best regards,
-- 
Nick Chan <towinchenmi@gmail.com>


