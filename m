Return-Path: <linux-kernel+bounces-254448-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 89E67933358
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 23:13:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1EC391F22AB0
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 21:13:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BD1413A869;
	Tue, 16 Jul 2024 21:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LqhoPdTV"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88A107581D
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 21:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721164415; cv=none; b=GdMy0Wy4usaGogzI0ii/x/uRT7r7G7XFJeHr1jr85dAc55MAMbTtipNTuNyH0cNd9f5RJlsRU4JZevbLdkLNHfGmOFCFO3F4oyxK2krKglSVdE4FC2VItfYkguitrdfFLSRQlI0h8Wv/TFcXFKhNtKN0d+jeV3ghIaZpsgD0kLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721164415; c=relaxed/simple;
	bh=oYFSATYy2cz+awHbXPKrzYfSfacEsU8cpRnW8w/u85I=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=h2EjrkEodSdT7QBOtYQgfUs8cf1mn8OWUorWP2/LCwU9P62+6TpI4U+49b0OlRPthmE3Jab5d6hiMZ+rvjiQjE45LvquChLT/XZZJS8ipCgsj5AkR0Djco/5D+BKbkTx4g9Cohf7b4gKh+t8f5pCk8S6v94ODUahmf8yizbHBSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LqhoPdTV; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2eeb1ba040aso80984191fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 14:13:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721164411; x=1721769211; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=21z48SgdFNCL4/5aBShoAF8rReld+Z9kQ/DqL3jAoqA=;
        b=LqhoPdTV8EZK+5LYN6a7ULKr2Vijw2Q/FITno6z8EeTDTA/NPxyANk4bo38nyo/taF
         itppVACSKLzfYFuPFAK1mxNsQhBUec+DTzThQU+fRsQFWcVxkMGj5ZtQkHR3XQBUVMTT
         TmYTEfGxY3D4S/y6/rteTwigEftJqtULieV3QeD5oJYwDBskH2OoaUSsBQNWGg4DtgRw
         YISKy5dJBSbk4xZF/Qw5DTMoY3OLzA+fQawAfvCNl7UrYgWFcptbEoSmbVU1ASsBqUgy
         abqD1TDg62aOoT2D6qtZZW/9u6IhxR9DOpo6wh5h6pV4LVshyQesQr5m3/kWg128UAZo
         bicw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721164411; x=1721769211;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=21z48SgdFNCL4/5aBShoAF8rReld+Z9kQ/DqL3jAoqA=;
        b=LsbMRAAP7uYzbXyn9w4qFDULzL+c3S79CvoLMhxdbifcyuLZnrxYqlX1vJRvl+Pb9M
         WaGYocwcZtpjEcjAR3BV9Yot2Wa1hF2Vf6uqCE6AHZQ++WZZa8bK6JPpZxDHfiEg1zGN
         JobQUAW/DfukjdQPABi0A9ll2p1pvP8An34jfqwDD4MjXv9pnLjlyFiCATj3ELNEZoET
         j3Ej0bqad2V3xnHt6W4mfi0uGVBBxfvX9qVv3AhgBDhuW5w/SqxgJb1POScmzs5SI+yf
         6NuP/Zy5vM+FWfo7gWs9IKVRC5qj/atdrLndbCkQPX2353gzCNHI5c0tRoMtd/oPg6MK
         wX1Q==
X-Forwarded-Encrypted: i=1; AJvYcCX6W7aV2fVcnGXJiGwC6Vh0e4nMuDtZg+qSXg9lq9pcVoUQCfmCu4JOm6+e5ZcHn44HZ6s8VRQDyNrywG+aSaGN4Y5BQYZ19lqazU9K
X-Gm-Message-State: AOJu0YxrXwpfa3LBVkakOZjnsa0lL5sKr4JFG3SGola2wFBeuLFJsN9g
	An3QBHhwmRJegLSwY2YNXbskgRX83C4175OLvyHYtruRNxyA3mWSASLhPuqzXKUrAXGr7c3zLqu
	D
X-Google-Smtp-Source: AGHT+IEky1SYh9mUAOjrkje4plIfpU4OBd4a7Iba1A698RT0qe8Yj+LmmW9y8LaRj0VA9TS6wbUVlw==
X-Received: by 2002:a2e:731a:0:b0:2ec:51b5:27bc with SMTP id 38308e7fff4ca-2eef419d7a6mr22366781fa.21.1721164411374;
        Tue, 16 Jul 2024 14:13:31 -0700 (PDT)
Received: from umbar.lan ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2eee179e723sm12433871fa.24.2024.07.16.14.13.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jul 2024 14:13:30 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: [PATCH 0/7] clk: qcom: merge SM8550 and SM8650 display clock
 controller drivers
Date: Wed, 17 Jul 2024 00:13:27 +0300
Message-Id: <20240717-dispcc-sm8550-fixes-v1-0-efb4d927dc9a@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHfilmYC/x3LSQqAMAxA0atI1gZq7SBeRVxIEzULBxoQQby7x
 eXj8x9QzsIKffVA5ktUjr2gqStI67QvjELFYI11JjYBSfRMCXXrvDc4y82KwVH0XbJErYNynpn
 /UMZhfN8PAJtyR2UAAAA=
To: Bjorn Andersson <andersson@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1451;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=oYFSATYy2cz+awHbXPKrzYfSfacEsU8cpRnW8w/u85I=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBmluJ54lvK94XLaV48ee/dPqy+9oBsDwzf7uWml
 oYrW+YK6kyJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZpbieQAKCRCLPIo+Aiko
 1YoqCACcdzHYFr/KWyQNDs3v4kaflQNgqGziW1wksOP/wv+DdfZN0NC2ukz++7QOD783aFKCf78
 0lEWnilAdljwkhbpvpHAmHqLhvfRHrzhMC5uUxGYWf3352LWBBtTSjGHyJXxIrzLb7ps9WlCp8W
 9+YOyTe9OYDwmSVqPio7FEI4ivzlYC5XWwxa1EGW6sz8SIg1Hd7pgcGhqinyuRb2xd6oEBoo2po
 wA6Xkv80xwXqtCAUUzxJ2i6MrXMXfvNhJWrWuP03UovLmL1xGO/X+J9+Ft6OxL4KSzrzbyzL3pq
 v8kcqB19R5eCKotYqWVZGwZCZvQwqdjHSTQR9t3XzNY8i4iZ
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

The SM8550 and SM8650 platforms have nearly the same dispcc block and
very similar drivers. Seeing fixes being applied to one of them, but not
another one, merge two drivers into a single codepiece.

Depends:
- https://lore.kernel.org/linux-arm-msm/20240716-topic-sm8650-upstream-fix-dispcc-v3-0-5bfd56c899da@linaro.org
  (patches 1/3 and 3/3 only)

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
Dmitry Baryshkov (7):
      clk: qcom: dispcc-sm8550: fix several supposed typos
      clk: qcom: dispcc-sm8550: use rcg2_ops for mdss_dptx1_aux_clk_src
      clk: qcom: dispcc-sm8550: make struct clk_init_data const
      clk: qcom: dispcc-sm8650: Update the GDSC flags
      clk: qcom: dispcc-sm8550: use rcg2_shared_ops for ESC RCGs
      clk: qcom: fold dispcc-sm8650 info dispcc-sm8550
      dt-bindings: clock: qcom,sm8650-dispcc: replace with symlink

 drivers/clk/qcom/Kconfig                       |   14 +-
 drivers/clk/qcom/Makefile                      |    1 -
 drivers/clk/qcom/dispcc-sm8550.c               |  198 +--
 drivers/clk/qcom/dispcc-sm8650.c               | 1796 ------------------------
 include/dt-bindings/clock/qcom,sm8650-dispcc.h |  103 +-
 5 files changed, 111 insertions(+), 2001 deletions(-)
---
base-commit: 03a20d00e8fa44a58a0d363847e7113aab79ab68
change-id: 20240716-dispcc-sm8550-fixes-64d758c2dd34

Best regards,
-- 
Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


