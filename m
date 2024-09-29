Return-Path: <linux-kernel+bounces-343082-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F3C1989690
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 19:28:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E53A82848B5
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 17:28:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6497B54F8C;
	Sun, 29 Sep 2024 17:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="IUupnd4P"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 351ED43155
	for <linux-kernel@vger.kernel.org>; Sun, 29 Sep 2024 17:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727630877; cv=none; b=th4MZq6JRO8ohGzZoISbzBwQZr+QsbnudE60nz9/6blUpI1gYksD66ZUEVDyyT8CYWMCg4wtWE7JWt3S6Ftd/XI32ZHg5B2YuiS/DHTCiBZBcQwaJhnOotRD1826YL88o0cZKG0g1mQNl7lyi8t0OgFdbRe0Khg9uxbRhI+3WpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727630877; c=relaxed/simple;
	bh=KmBueEVKme5DtcuzYm7hl+dZKGVzspxJFWdpCrLNZgE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VGcA52qfpxfEl4E+oRa+aoBh1Wx1lPsoXfdALukCND/c16DNbgP8tmBd0D4fApyDdS3RxEd6u1ym0X+NiS7MwmtWdz5+79AuKw3UdGd+8PLFMt59X/1Y524A1T1+vQk0bNSREYN/+Jtv82UkOwXwKxhJcttdSpn+fpyHsX8PAu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com; spf=pass smtp.mailfrom=amarulasolutions.com; dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b=IUupnd4P; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-42cb57f8b41so45521315e9.0
        for <linux-kernel@vger.kernel.org>; Sun, 29 Sep 2024 10:27:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1727630874; x=1728235674; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2RymkxnNQTDpNcXN6Qg1uYxhHB5JeOGRw/tDAC3s4FE=;
        b=IUupnd4PrUUPWvwJRDPrF7T7+lSuegKjVHUHdWar8SElcBl/RpTjkNpyParfsj2s6T
         jCqicixOl1I+XY/keeDgml4nMyv9uhu/yq7wsLwBj5K/aXtX+7ZNx6bT6D/aES6NTd5s
         Kb8ZCkljrr5nmXtiS/3ZVFQ9XzWpGOX3tWOtM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727630874; x=1728235674;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2RymkxnNQTDpNcXN6Qg1uYxhHB5JeOGRw/tDAC3s4FE=;
        b=OijuYr6XQx/lFAbPY3M5GkQP4rtfWyuSEnUTJDmTG5GPJuhJ8vr5Y71UnJNilhfn3E
         j2BnlTgfh/uW8xPjdMnhweNhjIPx4OHu49e9RfX04vfgiKv/+9IsVmLo/PwMNrQ0pob9
         nmOix9FwDvEE3nsVcvIlgM5WZXQxFsD0oL5p5OBQ8fv1A1n8iRnTB7LdbOR7stMPA1/T
         40aAzuAr4hMgAJGeVlq4x72tWAuHRATzf8hB7poxQDtCVqBUNTpA103ulpRq+5HD6Lhr
         Pfnb3YfypVcynu0GdRndZ/bR1/mmKFD752B/Q/xVY6WEqDCH0WiZsy7UFKPhEYsczsh+
         GiTQ==
X-Gm-Message-State: AOJu0YwuMRcKjel8YmXWwqNBTujls58/XrSRpAdPoJHDaxiPoCZXS2Lt
	9ZawDNbd1sIjxreaAeduiycXTzRRhaEroYGAlhhbpQDUAc451vO4Kl2a1SrY9fAdV7nTYOPuyW7
	BqP4=
X-Google-Smtp-Source: AGHT+IGmvVmD7fNsIntJU4qP6HHyGpU2QLRfhh5X/ydqxCTIJfv/+WNCG9XNyNBpNOJz5bNihD8xgQ==
X-Received: by 2002:a5d:6886:0:b0:37c:cfa4:d998 with SMTP id ffacd0b85a97d-37cd5b1515amr8217224f8f.49.1727630874386;
        Sun, 29 Sep 2024 10:27:54 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-79-54-102-102.retail.telecomitalia.it. [79.54.102.102])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a93c27776a1sm403176866b.8.2024.09.29.10.27.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Sep 2024 10:27:53 -0700 (PDT)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: linux-kernel@vger.kernel.org
Cc: linux-amarula@amarulasolutions.com,
	Dario Binacchi <dario.binacchi@amarulasolutions.com>,
	Abel Vesa <abelvesa@kernel.org>,
	Fabio Estevam <festevam@gmail.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Peng Fan <peng.fan@nxp.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>,
	Stephen Boyd <sboyd@kernel.org>,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-clk@vger.kernel.org
Subject: [PATCH v2 5/6] clk: imx8mp: don't lose the anatop device node
Date: Sun, 29 Sep 2024 19:27:15 +0200
Message-ID: <20240929172743.1758292-6-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240929172743.1758292-1-dario.binacchi@amarulasolutions.com>
References: <20240929172743.1758292-1-dario.binacchi@amarulasolutions.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Setting the "clk" (clock-controller@30380000) device node caused the
reference to the "anatop" (clock-controller@30360000) device node to be
lost. This patch, similar to what was already done for the base address,
now distinguishes between the "anatop" device node and the "clk" device
node. This change is preparatory for future developments.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
---

(no changes since v1)

 drivers/clk/imx/clk-imx8mp.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/imx/clk-imx8mp.c b/drivers/clk/imx/clk-imx8mp.c
index 516dbd170c8a..b2778958a572 100644
--- a/drivers/clk/imx/clk-imx8mp.c
+++ b/drivers/clk/imx/clk-imx8mp.c
@@ -408,13 +408,13 @@ static struct clk_hw_onecell_data *clk_hw_data;
 static int imx8mp_clocks_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
-	struct device_node *np;
+	struct device_node *np, *anatop_np;
 	void __iomem *anatop_base, *ccm_base;
 	int err;
 
-	np = of_find_compatible_node(NULL, NULL, "fsl,imx8mp-anatop");
-	anatop_base = devm_of_iomap(dev, np, 0, NULL);
-	of_node_put(np);
+	anatop_np = of_find_compatible_node(NULL, NULL, "fsl,imx8mp-anatop");
+	anatop_base = devm_of_iomap(dev, anatop_np, 0, NULL);
+	of_node_put(anatop_np);
 	if (WARN_ON(IS_ERR(anatop_base)))
 		return PTR_ERR(anatop_base);
 
-- 
2.43.0


