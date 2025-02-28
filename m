Return-Path: <linux-kernel+bounces-538750-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DB1FA49CAA
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 16:03:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 83869189AE59
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 15:01:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D5341EF366;
	Fri, 28 Feb 2025 14:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="i27F/Wzk"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 273121EF367
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 14:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740754792; cv=none; b=ndVAUaSIDgxCW94MMeuTCPSvBPGqiUEXCH00I65kZl/9yObSltc78C75jZlbcSSeS2R4RPMIgKfhF3GKcvNRFNxsBGJQfdRzeFVschuJD0R7wVSCWj/RwDZBc9cSmiUEHI8mhON46D+QAx6e9LhB4u3/Hk35cWGqIWbT61gQ/7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740754792; c=relaxed/simple;
	bh=DN3OR3UNLTVv3BZYUZUuzBf8MA/QbjKRmT91vw7vVlo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=sFGpZGvGoTRWvfjtbhMsVvc7UI9ws4GkB+NKQCZ4b3hTnvM7rTIlSFf9JUguvLTaYFqOm7P3lN872FMay0YsSnZhSwSoOLGK/ZKWGqBwLfrZ3R//OCB+LWTad6ggnX1Namw2LwoOJ8cIE/tsU6qvKcU2J2kQEXw2ayh0wD6UsrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=i27F/Wzk; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-390ef13838cso89471f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 06:59:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740754789; x=1741359589; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Aw1wgbpjG14q+kZJA/ykHz++iHt5asV20YBMvXwJ2LA=;
        b=i27F/WzkROLOKEHfVdRS1fFV/cbCMIa7zqgFyFi50Qh2Bi+Iq/0Dv1byuL+lK8bKg1
         CJZj/a/O7IcbXhLooDPY7Go2ssKZ4P45PeE2FKlLd6xUMnmZ+4Ta7FTVzSnFDU1Xf+nB
         S0p6oB9NRSQ40aTlHzZHd8q18aygfLyEDPYRl9OzL07g/LclUVpHn8gUmor3uptTQxN4
         pbewcdmETaLJkyEGeogtiFT4/tqidJlRbLNT4TGZ8cBnRSB8gEMnEcDWHET/1P0KXPVb
         D6x22rB/v0AsWrzFqDFfqPoWj7CUv2oawyj8B0u1Qk1xwUVKsLz/6eq4hnZM73ppczrv
         Km9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740754789; x=1741359589;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Aw1wgbpjG14q+kZJA/ykHz++iHt5asV20YBMvXwJ2LA=;
        b=TDbQr1z9krdy3Fx9i3MfB0kn40P0xj8/l44i0xW/xT/NbDDXB0n9LXIaJr6p/DdLnm
         b1iZhWDbRFftoaCHLcvacyFaTPcJRNXuyfsBP4pQJAWlbmVq140M8rjNDsdOB5YDyuPM
         3D3edwcXyVqQt1EadPDt/f9TnTbo+G2sfK4b5NSXJrs+IbMp+E0bwZRKLRcPlJXOFBZO
         e38ljkJCzGZkMXH94WbdNO6QaBZ2GivGhX4Y56M9DzOXq0BimAR4fkCpmUQLBy/+ApwM
         BJNmF6EYek7ZuSLjmxwWvchWk89RXHYFa6MtYe5tdCZDdpDOGcjzTO5oqBg1rCvkC+dS
         nPAw==
X-Forwarded-Encrypted: i=1; AJvYcCWW2cs52OQ1yFy3mkqB/RLxY20pEWhu9RJQ9sGN15lFo1xJJiQwmrg4aldD57eaSxxCODmoO8cnRMolev4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyN3QKCufcRtHbUqz/iiJS91IDPpr2j3MEX1p91SlyN5i047+96
	oPYS5X6YXpzHXQDGbVo1v3/zeBIMii4sTr7vVfGbWUgNgIwWGIaOdrV+CqPBjnNdXq9aqKU4Zwp
	k3T4=
X-Gm-Gg: ASbGncvm1V7Brl70WhXWGVGKPvLoB9947EoYNSPnFGwXoG8oDpELJQUCvnIyWtQdKfZ
	t906gM5tqDdkpNa6brxFTV9lmwbGY0Y51NWdjmk7g/gl0mDAif+BKK+8OFzPMCRPcBFWYzEA0Il
	e3X4V+LwJ/+X22neWcpcxED0SkXDS6A99GlN2+Fou2F/mq5f2SWQH0xDZQg1MKxfh/uPJEKu2YM
	13dMcvr2/WXb1jCH16OOpcXEkc4gwXziBlKad6fG27pyKhr4JvHejcry+Znai6D1NlMbZAnuCQh
	z99G7j1Ogfm+f8Y4IAlSNSqVhNmQoVPrfwOmmdlgXw==
X-Google-Smtp-Source: AGHT+IGdH2qmH4oSCKqIKPqOphvmigtP0oYR69hECCBe35mqJksQQnWDr1GbP2Gygro+ZUA+rzOu2Q==
X-Received: by 2002:a5d:598f:0:b0:38d:be5e:b2a7 with SMTP id ffacd0b85a97d-390eca89669mr1148746f8f.10.1740754788946;
        Fri, 28 Feb 2025 06:59:48 -0800 (PST)
Received: from [127.0.1.1] ([178.197.206.225])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e485d785sm5450770f8f.83.2025.02.28.06.59.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 06:59:48 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 0/4] clk: qcom: Constify 'struct qcom_cc_desc'
Date: Fri, 28 Feb 2025 15:59:37 +0100
Message-Id: <20250228-clk-qcom-const-v1-0-611ab80d45e4@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFnPwWcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDIyML3eScbN3C5Pxc3eT8vOISXRMjQ4tkEyNzQ4NESyWgpoKi1LTMCrC
 B0bG1tQC4PRM/YAAAAA==
X-Change-ID: 20250228-clk-qcom-const-4218c42710a9
To: Bjorn Andersson <andersson@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1409;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=DN3OR3UNLTVv3BZYUZUuzBf8MA/QbjKRmT91vw7vVlo=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBnwc9blSazgMczCJY+a4uFENOuZleWk2vJAA/pf
 +hHkFsdDNeJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZ8HPWwAKCRDBN2bmhouD
 1zmiD/4+Kk7fGDoVklFFYQFk7elu4O4WZHQsWx2P0xeTLS8VoRAwjq8yenRESg0YmawIb1u1Zka
 Z77ZJaKWc5fysGYLRrYktBXYK//RfdwU3wCFOgAl8uenBC2m+xiCCIueSQuAWGJrsee0Bi7fOWE
 GWOVs+bL3/ZAPlRJp701WzC/o39QWxFPuDDwlUD40Asia2gGAV5iaXJEMW4UzPSF4EotaddYGyr
 e0rOUaaQZPpHCWhlx+p+ucayKTAggcLnADPoPDEBrKfTmAO0OAUzDylkWPucqOLLXb6Fdj8ELfy
 5pxTP7S/eARVJJbRyRssQNFaT/0nJbVdfdwjUUX2yrr0h7Zx+U4coCgnkpc1Io3X6m6mVw4teTa
 HXqXCkn4HvOuMNbuRy8hvLgHQb32wGekUop8JQ9XAgwX7GsYeDTwA06In07DIa7f0oEiMIoqmqU
 m+l2D7wge8x5lAZIHZ3U0cTwGdNegpNAO19P+c4woJMH3SCzp2PxqkZaqovwNmrPfu2XS9RQFZn
 w2siDi//Xn6nb8VR6qy2T/M4CUHufUdDCwjDW1DG+XHedznJsCUh9XxXubn3+wcK69y3AHQV0m4
 KhT2BDV5DUZQx5otspMy2SnT2FasDwcRmwf49YBewfbf4H65du/dfzO77nGH3nMxJA8RDX/aEp+
 qKaSMuOTQSodFMQ==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Make static 'struct qcom_cc_desc' const.

Best regards,
Krzysztof

---
Krzysztof Kozlowski (4):
      clk: qcom: camcc: Constify 'struct qcom_cc_desc'
      clk: qcom: dispcc: Constify 'struct qcom_cc_desc'
      clk: qcom: gpucc: Constify 'struct qcom_cc_desc'
      clk: qcom: videocc: Constify 'struct qcom_cc_desc'

 drivers/clk/qcom/camcc-sa8775p.c   | 2 +-
 drivers/clk/qcom/camcc-sc8280xp.c  | 2 +-
 drivers/clk/qcom/camcc-sm4450.c    | 2 +-
 drivers/clk/qcom/camcc-sm8150.c    | 2 +-
 drivers/clk/qcom/camcc-sm8550.c    | 2 +-
 drivers/clk/qcom/camcc-sm8650.c    | 2 +-
 drivers/clk/qcom/dispcc-sc8280xp.c | 4 ++--
 drivers/clk/qcom/dispcc-sm4450.c   | 2 +-
 drivers/clk/qcom/dispcc-sm8450.c   | 2 +-
 drivers/clk/qcom/dispcc-sm8550.c   | 2 +-
 drivers/clk/qcom/dispcc-sm8750.c   | 2 +-
 drivers/clk/qcom/dispcc0-sa8775p.c | 2 +-
 drivers/clk/qcom/dispcc1-sa8775p.c | 2 +-
 drivers/clk/qcom/gpucc-sc8280xp.c  | 2 +-
 drivers/clk/qcom/gpucc-x1p42100.c  | 2 +-
 drivers/clk/qcom/videocc-sa8775p.c | 2 +-
 drivers/clk/qcom/videocc-sm8350.c  | 2 +-
 drivers/clk/qcom/videocc-sm8450.c  | 2 +-
 drivers/clk/qcom/videocc-sm8550.c  | 2 +-
 19 files changed, 20 insertions(+), 20 deletions(-)
---
base-commit: 8936cec5cb6e27649b86fabf383d7ce4113bba49
change-id: 20250228-clk-qcom-const-4218c42710a9

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


