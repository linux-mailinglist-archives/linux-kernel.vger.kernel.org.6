Return-Path: <linux-kernel+bounces-301886-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C722795F6E3
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 18:41:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 72FB41F228EC
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 16:41:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51F1119538D;
	Mon, 26 Aug 2024 16:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OKYHC2yS"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA7E3194C71;
	Mon, 26 Aug 2024 16:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724690380; cv=none; b=mv4Hm0GGG/iZSkXpWVdsvE3NvP4WrMK8gq0/fBcFOs3N1ZqkWaLli1dLM4t9PG2nYiTKk0FN+NDXNonhgzBuguXUgIlS3C5JzBDhsWBH968nSP7JLvv7hlQIcm4Ht6aFusoTLlDQK7Gu3iC1rsxYCCNi2UeAlBK45EGtbloEmUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724690380; c=relaxed/simple;
	bh=PU1oYZO2QUCbnR03v7Saw0Q95PWuMfc5sU43sLrvbmo=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=dcVf1V7u2j5wxKSPpPpPeqUmHpz8vWeDcbk5/9NzS6rlSoPoxu8J1YwumI+3Fs0egpt3Y9cI8iYNUf1UTWkVt0q3sMTx1KRhdS89qeVmd/DJleQVM31UUd0gu83EeLAh9L0WcTLkMesIpCH/SWmrUireKCnQ5aAButFwJsORcr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OKYHC2yS; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a866902708fso23035966b.2;
        Mon, 26 Aug 2024 09:39:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724690377; x=1725295177; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FLEI1Cb2UP4A1vC0h0p4/XVr36pqAHZWOGV9GNwqygk=;
        b=OKYHC2ySwBaF+9W0LIfOTBfV2sCRRA0cVCtN9ocrsI/nalDreX6zqKcnzRf+YBDzaJ
         pzZxCm42rk2wPmW3HqMkJviUtJ224dlTvCoii0yh9/OzuVsiiBRytAV6C2lPbYNav6Hs
         hqDEMf5acFFT0mduzDs+vzyXqtBlvLyKJRxBu4bwo9tR5we10LooqI3HR7wgPx17VQtw
         JYHKBEm3Bnz2AELDDyjLvl7A7jLDuoJcySjKi7N8JZNSfXPbIj6PFx1MYOsCOAJfmGGH
         vy6eKnwaWvkYECxwqzHFeJBNLyV4YmZQ8pHnB8h9wW4QRtTC48/ot6uxPRIG4TwWRfSa
         1cig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724690377; x=1725295177;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FLEI1Cb2UP4A1vC0h0p4/XVr36pqAHZWOGV9GNwqygk=;
        b=nIOSSoXPtzpcIDOwbwPh1CwyE6aDLFoJZL+sHulgpBfwanX8boFaeYl/4qMCHgxT03
         Xt55coMk/ZY5yrGWQzoEvIGKLBeerUb0nG1E9Z7TE21QrkXTEtMTePbdTjWkxavdQLk1
         F+jUYhLxHkDL2AZ+ilLUSz3YFz+vhKQ9bWTOEgaEHJCe9/Dt00gh88DuVWptpw22ajxs
         XouPFtHB3RUvSvBCZ9hA6M7/flVBCmU+q9scIZqjAT4k5C2XLlWCxdLojrg5/D+fbYgr
         NO7Lmbp47EVdOtQS4+RCeVIh9ET/Fv5PymKryp86BxitJluOId/efB3sE10XcFqicz8l
         3c7g==
X-Forwarded-Encrypted: i=1; AJvYcCUZEXmyFjIaqssyZDc8dka7nHIwdiWRaadDDUPT63r1cwrUMBEaLS9j6GCUtkTW1vjH4SYsvIGcH4uo@vger.kernel.org, AJvYcCUaJ9N5xxrTKhKEBE30r7z5CqZcuKmetqKTrnlTHpN/Ka4JKfhKvxArZ8E7MvBsFhQ3rv3ZFS7i2+NJQhy4@vger.kernel.org, AJvYcCX7gjg9t9tFwffe6hKqNZOUyr793Wxm1LB1TYyaCF9JyE+qJIjVn550jpkpJToa01hPNJaCpxklDGTg@vger.kernel.org
X-Gm-Message-State: AOJu0YxLFGaNiQ5MXsxVhIcJoriN6jrxJQIWrUM/xVRyoUTGfXC3EDn7
	BcuoJ0/pDEu/9JOURPMqcHt7RVuimazPnlAH166gX/AkRsyT9J/EZLgH9w==
X-Google-Smtp-Source: AGHT+IHL+FuBwtBkHSQziYl5NkPCUp/kCmo45U6Hon3dXAoeItbf4Y2lDeqQXqnhrhLcmTgJXrrRqQ==
X-Received: by 2002:a17:907:7e9a:b0:a7a:b895:6571 with SMTP id a640c23a62f3a-a86a550b68dmr508411966b.9.1724690377077;
        Mon, 26 Aug 2024 09:39:37 -0700 (PDT)
Received: from ?IPV6:2a02:a449:4071:1:32d0:42ff:fe10:6983? ([2a02:a449:4071:1:32d0:42ff:fe10:6983])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a868f220cfesm685727266b.1.2024.08.26.09.39.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Aug 2024 09:39:36 -0700 (PDT)
Message-ID: <45f83b1f-64f8-4ea5-bc93-ebf7507a9709@gmail.com>
Date: Mon, 26 Aug 2024 18:39:36 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v1 8/9] clk: rockchip: rk3399: Drop CLK_NR_CLKS CLKPMU_NR_CLKS
 usage
To: heiko@sntech.de
Cc: robh@kernel.org, conor+dt@kernel.org, krzk+dt@kernel.org,
 mturquette@baylibre.com, sboyd@kernel.org, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <416cdaf2-fef2-471d-a03a-837775d6e7dc@gmail.com>
Content-Language: en-US
In-Reply-To: <416cdaf2-fef2-471d-a03a-837775d6e7dc@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

In order to get rid of CLK_NR_CLKS and CLKPMU_NR_CLKS
and be able to drop it from the bindings, use
rockchip_clk_find_max_clk_id helper to find the
highest clock id.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 drivers/clk/rockchip/clk-rk3399.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/rockchip/clk-rk3399.c b/drivers/clk/rockchip/clk-rk3399.c
index 4f1a5782c230..c2b243d7a5e2 100644
--- a/drivers/clk/rockchip/clk-rk3399.c
+++ b/drivers/clk/rockchip/clk-rk3399.c
@@ -1531,6 +1531,7 @@ static const char *const rk3399_pmucru_critical_clocks[] __initconst = {
 static void __init rk3399_clk_init(struct device_node *np)
 {
 	struct rockchip_clk_provider *ctx;
+	unsigned long clk_nr_clks;
 	void __iomem *reg_base;

 	reg_base = of_iomap(np, 0);
@@ -1539,7 +1540,9 @@ static void __init rk3399_clk_init(struct device_node *np)
 		return;
 	}

-	ctx = rockchip_clk_init(np, reg_base, CLK_NR_CLKS);
+	clk_nr_clks = rockchip_clk_find_max_clk_id(rk3399_clk_branches,
+						   ARRAY_SIZE(rk3399_clk_branches)) + 1;
+	ctx = rockchip_clk_init(np, reg_base, clk_nr_clks);
 	if (IS_ERR(ctx)) {
 		pr_err("%s: rockchip clk init failed\n", __func__);
 		iounmap(reg_base);
@@ -1577,6 +1580,7 @@ CLK_OF_DECLARE(rk3399_cru, "rockchip,rk3399-cru", rk3399_clk_init);
 static void __init rk3399_pmu_clk_init(struct device_node *np)
 {
 	struct rockchip_clk_provider *ctx;
+	unsigned long clkpmu_nr_clks;
 	void __iomem *reg_base;

 	reg_base = of_iomap(np, 0);
@@ -1585,7 +1589,9 @@ static void __init rk3399_pmu_clk_init(struct device_node *np)
 		return;
 	}

-	ctx = rockchip_clk_init(np, reg_base, CLKPMU_NR_CLKS);
+	clkpmu_nr_clks = rockchip_clk_find_max_clk_id(rk3399_clk_pmu_branches,
+						      ARRAY_SIZE(rk3399_clk_pmu_branches)) + 1;
+	ctx = rockchip_clk_init(np, reg_base, clkpmu_nr_clks);
 	if (IS_ERR(ctx)) {
 		pr_err("%s: rockchip pmu clk init failed\n", __func__);
 		iounmap(reg_base);
--
2.39.2


