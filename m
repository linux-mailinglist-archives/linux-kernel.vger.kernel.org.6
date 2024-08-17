Return-Path: <linux-kernel+bounces-290818-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B9DC95591D
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Aug 2024 19:08:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E8E5282336
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Aug 2024 17:08:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F02E2154BFB;
	Sat, 17 Aug 2024 17:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="gxLOxgT0"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C43E84FAD
	for <linux-kernel@vger.kernel.org>; Sat, 17 Aug 2024 17:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723914509; cv=none; b=a50ulErh4yM6SPPvn0VVtYEnOcbqZyhDrocE5ckYvGJevdGO3Qld617oTgnAYuTbNo21gu0fYYVNz1dZxaKPPg/v1F3jYESCa/b1+wz91kVG7W1+AQNpv8hY35c8T7sBRYMOASsI/KNSOmIvD3ScEuBcSaQLgdJ/JX7GazcBKLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723914509; c=relaxed/simple;
	bh=7TS+k1PRLwU3AEg6CEGNgwPyF3p3VvGZHnj12bkl9fI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PNESDmQcZ1vEnVlk+jAuusPcC155TkyVxQ6h817us3Sk7BEzr5Ing9PQMGluNY1Om4t/UZAxZRyRnOTp2JIBEmq+61jWCcmzCRzmkztz690or2fd232BsEFehm5hnfknAUkokkecgjTQ0cr3KUb1OFqVicoDtAgB9TL95VawrEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=gxLOxgT0; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-36d2a601c31so1644595f8f.0
        for <linux-kernel@vger.kernel.org>; Sat, 17 Aug 2024 10:08:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1723914506; x=1724519306; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=d+1eDU6pL8mMJapdvQIZCpIdrVaFZMCR1Rwjbr7DrUQ=;
        b=gxLOxgT0d4br/TITkqDsLKZgJm4bl9Y9XFa4qRmmExqHrs9AbURCrhZzCvqdOkiu5H
         Nxvg3AmsH/IFYAEFrOrqV74KWKWCOeqvOEPe7ZTD11l5yJQD8Do26ZJPCg+Nl0I6bQRm
         bk2eIdVwARAu2+n6KPts7+DFFmSzINFJwbkL0WBYD06oQcVVoNYFz3CtOD0SAcEFiQZ/
         tYNK6mQ1wcyZtKDfB3UiycUyalQlk7BBHuqBk7ubn+nVqQlIE0Phpzn0lxd8G+N/xBQC
         Uyqk2Rv1L5sZRjyiVf8SkDBYOJjRvZp0wjfOI1QQab+yeJH0QHlUsqCApVG8HQZgTpKh
         78PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723914506; x=1724519306;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d+1eDU6pL8mMJapdvQIZCpIdrVaFZMCR1Rwjbr7DrUQ=;
        b=gZ5sTKYRrV6TbsWM06aDgLF5h6O4qHLjviJvTQ8dirFL+QZPhpajELYuxOg29bP/Q3
         19q5Ej71W9nhuhX0epiCI/5GurkcePs7Hr0Ua9gAizfwlY1krdTtSQQkuGabJGje3/Tr
         GUg4a1e3C7arn7NyphrONNwUfBPZGxyv8APHj3QO1YaZNUxAd8C/8LtRMiw/jD6U5Qe/
         q4K3jIYGTazOUTjK4U1ldVJOvRwkteVWcELyUvVh5wYz31806lavyF/8NKZ8cXGxRMBT
         RrdcQ/6s9gK0ULEznZ7lrCl83oFL7g/TqDdGxx25zmc7/VKXRPNRDDgtF6jrmIooN76q
         ac1w==
X-Forwarded-Encrypted: i=1; AJvYcCXoDjudpPD8Y9ex+LYx7aehSJPRl0wqWR4BCPXNn3SwIO+n0FGxCt0nmIIP/9X+JgItBrYL3TzelUrbn3Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0tGhPt4NzQWjY7Wn8qH7fH0hdfVvTJy5X05DYfeoxa+rHb3M1
	sU09ayHmMmcSkZ+zTAE9etusXGJLPJ97bmAvedL9hTOJpuNlQ+xN6wOPdoijowM=
X-Google-Smtp-Source: AGHT+IE6b+7jzq7Estkt2Ds0gB54QWf9sQi+i/YVKv8R3zFoXTCBoiPafqZq06a1W6N57RJaY3yq9w==
X-Received: by 2002:a5d:4486:0:b0:371:8484:57d7 with SMTP id ffacd0b85a97d-3719444b7e0mr3926720f8f.15.1723914505446;
        Sat, 17 Aug 2024 10:08:25 -0700 (PDT)
Received: from fedora.fritz.box (aftr-62-216-208-163.dynamic.mnet-online.de. [62.216.208.163])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-371898aa229sm6256167f8f.88.2024.08.17.10.08.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Aug 2024 10:08:24 -0700 (PDT)
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
Subject: [PATCH v2] mmc: mtk-sd: Improve data type in msdc_timeout_cal()
Date: Sat, 17 Aug 2024 19:07:26 +0200
Message-ID: <20240817170726.350339-2-thorsten.blum@toblux.com>
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

Use max_t(u32,,) to simplify the code and improve its readability.

Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
---
Changes in v2:
- Address kernel test robot feedback and replace do_div() with a
  standard division
- Link to v1: https://lore.kernel.org/linux-kernel/20240815234602.59684-1-thorsten.blum@toblux.com/
---
 drivers/mmc/host/mtk-sd.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
index a94835b8ab93..950c60102bdf 100644
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
+		      max_t(u32, timeout, 255));
 }
 
 static void msdc_set_busy_timeout(struct msdc_host *host, u64 ns, u64 clks)
@@ -840,7 +839,7 @@ static void msdc_set_busy_timeout(struct msdc_host *host, u64 ns, u64 clks)
 
 	timeout = msdc_timeout_cal(host, ns, clks);
 	sdr_set_field(host->base + SDC_CFG, SDC_CFG_WRDTOC,
-		      (u32)(timeout > 8191 ? 8191 : timeout));
+		      max_t(u32, timeout, 8191));
 }
 
 static void msdc_gate_clock(struct msdc_host *host)
-- 
2.46.0


