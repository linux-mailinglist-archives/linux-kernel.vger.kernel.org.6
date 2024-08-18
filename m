Return-Path: <linux-kernel+bounces-291073-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FE12955CF2
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Aug 2024 16:24:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 610A01C209C6
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Aug 2024 14:24:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A979112C52E;
	Sun, 18 Aug 2024 14:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="bQbdcC6e"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1043D2BB15
	for <linux-kernel@vger.kernel.org>; Sun, 18 Aug 2024 14:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723991037; cv=none; b=bLjxWfz5+CwDJzKO/OGNlOijQOodP2YTKReTv49ze3pqBtS4eZC17RwsrptBrtmXOgpHSqLvbdTyCSiV2/zXHEg2mUsttW32AxOpcDF6SzmLnEeGN/giSPyraIqf+KZqtAfyQfgmmDWh250nM05UGjCqVSJtoZkxA7+8RrX5TlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723991037; c=relaxed/simple;
	bh=GKnvc5j9d3UGQN/RmRiNw1hnAhh8yCXMvbd2GnUbKL0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fZ4njKgDN241pFYis3FQdKtcZXKokhVb5lERSxSk/Jtxbck1A/Zp0v4w0OTQ26yT2DwL9l3P2pkH9rGuKw2w0WpIJZCmrDGZW0SANbqAmU3uQuoHFmwAjTSXW4dOK6ItopG4jf12HvVOBJPkrj/mulQ40NC9BOkwpbPiOTpdrFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=bQbdcC6e; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a83562f9be9so299042566b.0
        for <linux-kernel@vger.kernel.org>; Sun, 18 Aug 2024 07:23:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1723991032; x=1724595832; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=84N+5XgwWf1nwoq814fYSNnKDtDJw7Qd1tBkSaBztTo=;
        b=bQbdcC6e9MlohmJhxfy3W29nBlUm3cQ8eaKyEO7NcX4yLAgu8qlQF915rqFw3mYmK8
         KbeP71lZzVj/XMPLBRQiNY+JefVoy+df5Mu6Esu2UIWdFkOxlf60khlShHMCS2h4RRGz
         Xb6dYjJ57pOBwUvXPDf+tGgI4r3oUFqPHyIJOrm72vCeu48XAwGoefq5V1nEnW0rPv3U
         NFUBqZd9SrKoorwIDghF8nEamu0p2OHbRFSYsozLl1QuEayBF+FYG3twaB/Kz5LnxsQT
         3PmLQJ09J6/UgIzh9WJTOvLJ2i5JtTslpebA2R2nx0x/67pIaV2IgfGOhbjbEuR/vixs
         1e6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723991032; x=1724595832;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=84N+5XgwWf1nwoq814fYSNnKDtDJw7Qd1tBkSaBztTo=;
        b=lCLRO2SUEGCM+vKwKkf7eo+0eZ09tE9n0DIdkGey1yD1TGCrONPFRjKkmJvklBep69
         cHYaGGpuyU/hBOuqxYXVI3naLnP+O744WkjcfZFC4v8+aBCkA4Q7Q9Md0bk6nY+wWDs3
         RYbU9e1F/TjF0rmRpirEd5CJG3zqarFPNycoYAfHu2Xh0dT0hPf42vA5HRsJZNvQ0Rt0
         F5kiGU160WHY/muJ1uDmuF0mWDxN7S1WL2sSwifL0B2UKDSeZrl6uGmdWq/H9oao1RHX
         +Q/13X+sN7i+kBxQKJEzergboTD2jtZb+Tt0HSvsqExcvWPV29KF2r5oCYtGIuD2ADqw
         aTLg==
X-Forwarded-Encrypted: i=1; AJvYcCVUi+2xoqi32aXbixxsUb6YOTYR7hqE1k93nQx/1PnjuRrKjnTF+/yy9OczyhIYznnxKpAfgTNv53AfexGDn7X/08Hm3xtfxDhJEv29
X-Gm-Message-State: AOJu0YwtSNoDvj7aa6UugFKIgRzXXA/BsZmRsWVfjVF1s8m72ZAkJNFX
	10cYC72bgrEg/EdFiRCJXfsgAuihYsBgJxytPgJvtZf8mSxhRTYC9tcDL34go2w=
X-Google-Smtp-Source: AGHT+IGf2pCDxIA75jH/7/L+NTnSfTLwTcnLAynOVUmTnc/INCAsrC+TWCaYgIwOf2GFYNoBXz2Lfw==
X-Received: by 2002:a17:907:f1dc:b0:a7a:a89e:e230 with SMTP id a640c23a62f3a-a839295469fmr583647666b.30.1723991032263;
        Sun, 18 Aug 2024 07:23:52 -0700 (PDT)
Received: from fedora.fritz.box (aftr-62-216-208-163.dynamic.mnet-online.de. [62.216.208.163])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a83838d023dsm519702566b.64.2024.08.18.07.23.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Aug 2024 07:23:51 -0700 (PDT)
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
Subject: [PATCH v3] mmc: mtk-sd: Improve data type in msdc_timeout_cal()
Date: Sun, 18 Aug 2024 16:23:01 +0200
Message-ID: <20240818142300.64156-2-thorsten.blum@toblux.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The local variable clk_ns uses at most 32 bits and can be a u32.

Replace the 64-by-32 do_div() division with a standard divison.

Since do_div() casts the divisor to u32 anyway, changing the data type
of clk_ns to u32 also removes the following Coccinelle/coccicheck
warning reported by do_div.cocci:

  WARNING: do_div() does a 64-by-32 division, please consider using div64_u64 instead

Use min_t(u32,,) to simplify the code and improve its readability.

Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
---
Changes in v2:
- Address kernel test robot feedback and replace do_div() with a
 standard division
- Link to v1: https://lore.kernel.org/linux-kernel/20240815234602.59684-1-thorsten.blum@toblux.com/

Changes in v3:
- Use min_t() instead of max_t()
- Link to v2: https://lore.kernel.org/linux-kernel/20240817170726.350339-2-thorsten.blum@toblux.com/
---
 drivers/mmc/host/mtk-sd.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
index a94835b8ab93..edeab9a4a83b 100644
--- a/drivers/mmc/host/mtk-sd.c
+++ b/drivers/mmc/host/mtk-sd.c
@@ -795,14 +795,13 @@ static void msdc_unprepare_data(struct msdc_host *host, struct mmc_data *data)
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
-		do_div(clk_ns, mmc->actual_clock);
+		clk_ns = 1000000000U / mmc->actual_clock;
 		timeout = ns + clk_ns - 1;
 		do_div(timeout, clk_ns);
 		timeout += clks;
@@ -831,7 +830,7 @@ static void msdc_set_timeout(struct msdc_host *host, u64 ns, u64 clks)
 
 	timeout = msdc_timeout_cal(host, ns, clks);
 	sdr_set_field(host->base + SDC_CFG, SDC_CFG_DTOC,
-		      (u32)(timeout > 255 ? 255 : timeout));
+		      min_t(u32, timeout, 255));
 }
 
 static void msdc_set_busy_timeout(struct msdc_host *host, u64 ns, u64 clks)
@@ -840,7 +839,7 @@ static void msdc_set_busy_timeout(struct msdc_host *host, u64 ns, u64 clks)
 
 	timeout = msdc_timeout_cal(host, ns, clks);
 	sdr_set_field(host->base + SDC_CFG, SDC_CFG_WRDTOC,
-		      (u32)(timeout > 8191 ? 8191 : timeout));
+		      min_t(u32, timeout, 8191));
 }
 
 static void msdc_gate_clock(struct msdc_host *host)
-- 
2.46.0


