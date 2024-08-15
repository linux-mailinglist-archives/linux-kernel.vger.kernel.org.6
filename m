Return-Path: <linux-kernel+bounces-288728-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D422E953E0B
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 01:46:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F187B1C21C74
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 23:46:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42F8F1AC898;
	Thu, 15 Aug 2024 23:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="Excd90TN"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00CCE1AC8B5
	for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 23:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723765584; cv=none; b=TOvzY8HCM+e9jJnT72g58kTqh4xCDTZTn55GKd2sCAAmbErnPen48OB1dZ1gaREnljXiKDcLfkFWo9pXwP5K/udpqLYYpgMCUG4nddUxmgtmNMAN6UdGD2qpJ1zq9eUHT4m2VdFLzdSJGLuvlhAxsNhwqW1FNmwFU930RoHF6OE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723765584; c=relaxed/simple;
	bh=pWOZpiEJi5e99UmqBc55zlFkPy0c6UxaE8RS1MSPNxk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QXEdIqqhtExrIl2xiSSN6Il7C6Fz23BSmENR0ApzM9AOJZN+nZ1xn88DmCKJFoZaXg0jPpv4XJE7/Vtx0iXW/Dg16qs9FKrs/c98mn/c9hNUb2yXgs7z+380HUJrwcrIcyAJrOI6mh85hBd75HFQZozAzQ5EVsRUgVnpAeOxCrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=Excd90TN; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-36868fcb919so687888f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 16:46:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1723765580; x=1724370380; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=owfkJECpaU/TFCIUAu7JVj1qFv5CTRrdg2Hqzlw/ab8=;
        b=Excd90TNlfxH0bAYz11PrIDAs7N+BLYGPEXq5XS8yedcsxGNWQAN53xSo/ETeMPvbb
         FSBkoz4UBB3eJPKUxlxIMLvj9Jj66z+89vKwadtLY1rFoE6GBP9GCUzLfcYWt3UXJ7UX
         W+n8tOI6Bq/nN4vNA5vOzcPcsAG23EDSqs0+9NuhioiFK60DzxbuDGpSLmeJS3pNTJvN
         SdppHkak0FrFQpP+oLGxr3Na35T4PLKKVxk1E2upmuDkVqVqL5NlvYcIHk1XKdhf0mX6
         QVRf3KVyEChVBDnjnDT2VBu8MYtepI6r6U2DPSQ0aK13k2mtrUsIy9RmeR3vLAv5nT4H
         GNpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723765580; x=1724370380;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=owfkJECpaU/TFCIUAu7JVj1qFv5CTRrdg2Hqzlw/ab8=;
        b=mmbcf5POGd0dTz/E7lTxIpaU0EDll93pKAZEsARsqs3vCLEvXs1pv9OA2OmT7boe5f
         VhWC1tq05UFM9G8JT2sgRu8zKuZA23S0mt9+OBO1BUu82xnHSMlAQ6w0529mLWi7HhYF
         FBfGxcrK/LD34BmKnIZzyNv3ANUmuO9X9FpxJkhxHC7yt/uiSu7z7plO9MtnLt40hGMl
         k1Y252P9cGgpx2ui3kBrXp62PJRo0tMMLBB7Lajy7JK9i1GTM9QGzJVzmi5en7qPurqq
         UwY2p2jbbQqRyxepTfZGz06x0VwT1Oe+GSXC9l1HJIxeDvQe64cCvTryp6qAk+OkeNtl
         0tWA==
X-Forwarded-Encrypted: i=1; AJvYcCXVryoQSpeWiE3ZfyHJclR2o66gTn9iBa5uM3DjExRyz8yYJTjMw3ngrC/PCBMkvRf3XD08+uMePzLjt0JD2iHWcpHQw0Hfzic6TiZq
X-Gm-Message-State: AOJu0Yz0B93ruGucJNGl79Gh30WVINdJcDUYcKOk9qjTVoEpJdc5Gmp5
	GMqPrXZ1EsyD6sKyY263su4XtJMq4dX+Np5qHVMCh7eOL44jbengiZ/rCF5vmFg=
X-Google-Smtp-Source: AGHT+IGDOw20u2BycUtGW9QSZG1vTwRyRmCNITyrrhP1+I6Jo05H/XiNgtOc7qVePSMPxECpCzgS9Q==
X-Received: by 2002:a5d:604f:0:b0:368:5858:826e with SMTP id ffacd0b85a97d-371946c6a66mr635372f8f.59.1723765579991;
        Thu, 15 Aug 2024 16:46:19 -0700 (PDT)
Received: from debian.fritz.box. (aftr-62-216-208-163.dynamic.mnet-online.de. [62.216.208.163])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429ded180dcsm60907175e9.4.2024.08.15.16.46.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 16:46:19 -0700 (PDT)
From: Thorsten Blum <thorsten.blum@toblux.com>
To: chaotian.jing@mediatek.com,
	ulf.hansson@linaro.org,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com
Cc: linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Thorsten Blum <thorsten.blum@toblux.com>
Subject: [PATCH] mmc: mtk-sd: Improve data type in msdc_timeout_cal()
Date: Fri, 16 Aug 2024 01:46:02 +0200
Message-Id: <20240815234602.59684-1-thorsten.blum@toblux.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The local variable clk_ns uses at most 32 bits and can be a u32.

Since do_div() casts the divisor to u32 anyway, changing the data type
of clk_ns to u32 also removes the following Coccinelle/coccicheck
warning reported by do_div.cocci:

  WARNING: do_div() does a 64-by-32 division, please consider using div64_u64 instead

Use max_t(u32,,) to simplify the code and improve its readability.

Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
---
 drivers/mmc/host/mtk-sd.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
index a94835b8ab93..329d7b3616b6 100644
--- a/drivers/mmc/host/mtk-sd.c
+++ b/drivers/mmc/host/mtk-sd.c
@@ -795,13 +795,13 @@ static void msdc_unprepare_data(struct msdc_host *host, struct mmc_data *data)
 static u64 msdc_timeout_cal(struct msdc_host *host, u64 ns, u64 clks)
 {
 	struct mmc_host *mmc = mmc_from_priv(host);
-	u64 timeout, clk_ns;
-	u32 mode = 0;
+	u64 timeout;
+	u32 clk_ns, mode = 0;
 
 	if (mmc->actual_clock == 0) {
 		timeout = 0;
 	} else {
-		clk_ns  = 1000000000ULL;
+		clk_ns  = 1000000000U;
 		do_div(clk_ns, mmc->actual_clock);
 		timeout = ns + clk_ns - 1;
 		do_div(timeout, clk_ns);
@@ -831,7 +831,7 @@ static void msdc_set_timeout(struct msdc_host *host, u64 ns, u64 clks)
 
 	timeout = msdc_timeout_cal(host, ns, clks);
 	sdr_set_field(host->base + SDC_CFG, SDC_CFG_DTOC,
-		      (u32)(timeout > 255 ? 255 : timeout));
+		      max_t(u32, timeout, 255));
 }
 
 static void msdc_set_busy_timeout(struct msdc_host *host, u64 ns, u64 clks)
@@ -840,7 +840,7 @@ static void msdc_set_busy_timeout(struct msdc_host *host, u64 ns, u64 clks)
 
 	timeout = msdc_timeout_cal(host, ns, clks);
 	sdr_set_field(host->base + SDC_CFG, SDC_CFG_WRDTOC,
-		      (u32)(timeout > 8191 ? 8191 : timeout));
+		      max_t(u32, timeout, 8191));
 }
 
 static void msdc_gate_clock(struct msdc_host *host)
-- 
2.39.2


