Return-Path: <linux-kernel+bounces-212195-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B58A6905C97
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 22:12:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43DBD28573F
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 20:12:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 635A584E07;
	Wed, 12 Jun 2024 20:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YcyBl6ma"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09C6B1C14;
	Wed, 12 Jun 2024 20:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718223143; cv=none; b=AdaIgr0GwVEiEipOz/lB7Q82EFpeyxdt59gYFy82NUC/LOKwkCQqrANYh7/SPF6i4II+kOP79JGRhuOXwvMkbONLAvIWPEdqNDOqvSjErrfJwNSnUPUksqbvqr0G9M9hlNfmVC3hEgBYOGuX7NR5DrZ2onk+qJs9t/k5C+7iC1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718223143; c=relaxed/simple;
	bh=vTRvMcmQ67qBx2Si3u2LtonShyXfmrbl+BRv5Bd+fyk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=H9/5lwMXLcmrvUWfOAAoWW7EAUiVR8nfUUbNHKwercZmfguReuSe69E/ihAOMT0fBZYrSBLFrDazEMhrgBHhrR1qXRn4FQWJsmb/xL9DZa3OzyMMSMFK6EuThONWPef3Rsu0gMmG3FMonmXNsJerwUDQXf+vewuKA2gklYhVTcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YcyBl6ma; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-35dc1d8867eso294761f8f.0;
        Wed, 12 Jun 2024 13:12:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718223140; x=1718827940; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1eed+2CfpyC5UVd4nAFeDZB/9Ij+Vk+m/v76FicPbdk=;
        b=YcyBl6maGy5+TEcKzFrBYqIusHBay3y2EIdhfvuxrRSXpARF9zy+CYZYDOLyh22JEc
         EslbmIzinX26BxjDRK3IVpyocqt3dVO+a0WziOtCbMiZOUwLyjC505jUl5NtyYaxsPsM
         pAkRK1B50+IcTM17zhPPksprYa/S93njUsPURjvwFZo9HXugNWFMID3ciTkM+FBxy/7u
         pgNN81e6BpMi9llWU/OhyAFLh0RPlFKXockCmlFq0qDYwkTAIkJyObb4Kk5yjpxe+b+I
         +f/XsSsQJYUofpnV43tSu6CMZJJ+VpLFMcjvoLM4sNISnSCScTRVkr4TBU9GXAXaW6Hx
         FFCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718223140; x=1718827940;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1eed+2CfpyC5UVd4nAFeDZB/9Ij+Vk+m/v76FicPbdk=;
        b=G0xr3OUb9yOPaMcN7leQPtPy1m2LcIs2EZpMmaUYW9D/ZVXUdFhIrsyjTjfSu+D7Cv
         WgCc3KGzbpEjU6nOJPeTZ8ZRc6oqdE2DQFq0WBhEQrp1Jh7XiEOdXvvnNXxsn49IZmGe
         htZ4Cken7Hg0BUNVHEUVyNBGeb6Ff+q1y/zuqz6PDWt019b4NmTjvUNvGdct72wR/b3M
         Kv3q5aPo8WcogUpupLTj9MCdwN8sX1Iz7wK/V6bDrN5sQg4l26fXXOWUYP0OfQg8Bf+a
         ufVKSCOI4hdfpfetx6aiTGsnyr9GG+cWYLMXhKaG+jT9EZeJGwPy3MVZkZ4faC5cOC87
         68XQ==
X-Forwarded-Encrypted: i=1; AJvYcCU/u6ZnL2u7CVq5yknKala52wGaGdz/wVzh5EtgLN6FPYhF2QHrcU0rgDQfqTfTioX63zRp/Zd5qP27yNRH0L1t8Dudc57xgPNSM6kgkvTOfVxebY0DtL7CLMaER5sDyTCJI/INlA==
X-Gm-Message-State: AOJu0YyPd/9dkNVJ6I8er1Skp9afEyQSamvsYQE/Ys89DEJU2KUbhL1u
	gynhfyyOIFuKtrd/SmqjEwygX4rXubI+rICIl58uP4hHjGi4h4RH
X-Google-Smtp-Source: AGHT+IFzhJSmsSeyPWsFkquVLF4ZsYUhdbk+Ko+VxAggBeLczkroAq1sV7RZSMvKVmWBaruhdXyaWg==
X-Received: by 2002:a05:600c:4590:b0:421:a1b4:c1d4 with SMTP id 5b1f17b1804b1-422863a8ce8mr28675025e9.13.1718223140088;
        Wed, 12 Jun 2024 13:12:20 -0700 (PDT)
Received: from ALPER-PC.. ([178.233.24.52])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42286fe7670sm38110205e9.6.2024.06.12.13.12.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 13:12:19 -0700 (PDT)
From: Alper Nebi Yasak <alpernebiyasak@gmail.com>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-mediatek@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <robh@kernel.org>,
	devicetree@vger.kernel.org,
	Michael Turquette <mturquette@baylibre.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	Chen-Yu Tsai <wenst@chromium.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	linux-clk@vger.kernel.org,
	Alper Nebi Yasak <alpernebiyasak@gmail.com>
Subject: [PATCH RESEND v2 1/2] clk: mediatek: mt8173-infracfg: Handle unallocated infracfg when module
Date: Wed, 12 Jun 2024 23:11:00 +0300
Message-ID: <20240612201211.91683-1-alpernebiyasak@gmail.com>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The MT8173 infracfg clock driver does initialization in two steps, via a
CLK_OF_DECLARE_DRIVER declaration. However its early init function
doesn't get to run when it's built as a module, presumably since it's
not loaded by the time it would have been called by of_clk_init(). This
causes its second-step probe() to return -ENOMEM when trying to register
clocks, as the necessary clock_data struct isn't initialized by the
first step.

MT2701 and MT6797 clock drivers also use this mechanism, but they try to
allocate the necessary clock_data structure if missing in the second
step. Mimic that for the MT8173 infracfg clock as well to make it work
as a module.

Signed-off-by: Alper Nebi Yasak <alpernebiyasak@gmail.com>
---

Changes in v2:
- Rewrite patch subject for consistency

v1: https://lore.kernel.org/lkml/20231108213734.140707-1-alpernebiyasak@gmail.com/

 drivers/clk/mediatek/clk-mt8173-infracfg.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/mediatek/clk-mt8173-infracfg.c b/drivers/clk/mediatek/clk-mt8173-infracfg.c
index 2f2f074e231a..ecc8b0063ea5 100644
--- a/drivers/clk/mediatek/clk-mt8173-infracfg.c
+++ b/drivers/clk/mediatek/clk-mt8173-infracfg.c
@@ -98,7 +98,17 @@ CLK_OF_DECLARE_DRIVER(mtk_infrasys, "mediatek,mt8173-infracfg",
 static int clk_mt8173_infracfg_probe(struct platform_device *pdev)
 {
 	struct device_node *node = pdev->dev.of_node;
-	int r;
+	int r, i;
+
+	if (!infra_clk_data) {
+		infra_clk_data = mtk_alloc_clk_data(CLK_INFRA_NR_CLK);
+		if (!infra_clk_data)
+			return -ENOMEM;
+	} else {
+		for (i = 0; i < CLK_INFRA_NR_CLK; i++)
+			if (infra_clk_data->hws[i] == ERR_PTR(-EPROBE_DEFER))
+				infra_clk_data->hws[i] = ERR_PTR(-ENOENT);
+	}
 
 	r = mtk_clk_register_gates(&pdev->dev, node, infra_gates,
 				   ARRAY_SIZE(infra_gates), infra_clk_data);

base-commit: 03d44168cbd7fc57d5de56a3730427db758fc7f6
-- 
2.45.1


