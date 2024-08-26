Return-Path: <linux-kernel+bounces-301877-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1721E95F6C9
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 18:39:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 83A55B22163
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 16:39:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92895198850;
	Mon, 26 Aug 2024 16:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CIorsOZf"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A049194C69;
	Mon, 26 Aug 2024 16:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724690296; cv=none; b=Kj0FCmDahldxJMJnJ3ip8mqfZQfXQWKPtEHjX03yOZxFocqKv0VG9fWR19MP7v/MNyHM7Y8X6K0nmK7QaiWkFa1PxYuvBZadzgh62hs/DwIEbk93nux08ISppEfaeFalsb0II8tD6whji/I3Y5+7+/E6V5ILPRJQ4HHI2h1TdaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724690296; c=relaxed/simple;
	bh=z/anmOnVsGpNJHpaJn7B9xGUnXLvQ0PBCafTWMT0nIE=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=Wp2WQsDLOrNqw5ldgXpPym/qKBksTgbyhSR99tSYzT69XQGK1NuIQHQ9RBdW21CfddPblurtk69TxpQyV6Q8cQpzxk7eg5CvxDTc25mIcPFKNEMznWOzWExAFYE+ZUMA0JVjY3/y+ha553IcS0SFa9YXWUzXmVjU33SYNcN21gI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CIorsOZf; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5bec4c3ace4so761362a12.3;
        Mon, 26 Aug 2024 09:38:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724690293; x=1725295093; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=aDq9hlxq5SKiY7D4NwdJ+sg4GlIHm5Ue+KqwIBMJ4ck=;
        b=CIorsOZfAgwrHx/gUHU/gnrBZ2cjwwa+/G3Ak4YiSMpl7pALzBiTX68EelmjYI3UI9
         1r98BUZqslqr2iSX1Tf4O85+g1JAFejBMUZPwi842omrRxGSwDOb/sISEUOzW8ZB4Ies
         XoNkBbutdmvqk4Kl24kmdym4peL+d9jKFrw8tfqiEzL4V4hiYHzBUW8sqCVXqkgLrlmY
         xGZLqt6NGXTgyzV2I0PhVinipzBlofF6roE8tlfEyo4m5xQ+Fm+uCfrVUZPwoU2Cg2Xq
         xrg7JTKsufmJyTp7ux2HsAlvEp6WBKML8ihCHuH+6HjGHMhrnId69Y45t+//7UxtSQ+h
         xDZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724690293; x=1725295093;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aDq9hlxq5SKiY7D4NwdJ+sg4GlIHm5Ue+KqwIBMJ4ck=;
        b=ZbR4ju92QO35/gye7zJNRvjSzfV3K+6YiecffHlQmFCSu/m9Dj8gEhECIfd7S9W5WM
         1cyYFrKhr2xnYZJ88pzCkiBBZTSiDcQ3b0iA3ICicscYcIqkMW79gMbezKJQIZuQ2A2I
         F5LoGOfRkGag66BVze35g2A5+LdHD6qw4oPMrximC8AmmeHDOF1f8PtqFzwASuMrRnOj
         P2Y0C2DSMINv8h+bo8b9fWkMAJEj70Oe2Ht1AHKgXA15tsWhRpiw3VhD8JFXcToSP2M4
         sVKsUfUhEpXC5brIAgLzH3OeADsCLj1tuQUw3xm9+YCCqrGb5AVa3c5av+AbCK6NXA2z
         HqFA==
X-Forwarded-Encrypted: i=1; AJvYcCWuwdvlUFBeKMRcuoK4WY2oTiR5lHmfuaIASGu3MXNkMaa90EnPpzzO7ZSfQPtlnflpQrmK9uKee55X@vger.kernel.org, AJvYcCX6zZyh4+/0aDpUa/dVRO1axbxQR4NQyu4ztHbCxPm4Gah638WwB9A8eXqea1Y6sUHZyzfxDZspknqm@vger.kernel.org, AJvYcCXnDJaadUXI0v32dKoXwFtEw+d1QGo3I3534AFRNMrfOWQXhinpbeUR0EWh6ceYhuS46BMpFizV3ksQdRma@vger.kernel.org
X-Gm-Message-State: AOJu0YwQnc9OruFTK5Ulv/blK7i9YyVooAVyDdGplBQJoOkdGVUBCMQF
	qMynt/0gmMa8slqwO7GqYKGZJFqurv1cYim8zkahzgqAPbzeGpEI
X-Google-Smtp-Source: AGHT+IHLIDKav6SmXKB/LiGyu/BHEreiTXzj+YTCi5/nF4P/IeOMyHMupH0woRlDT69S6BqXYTtVag==
X-Received: by 2002:a17:907:3da0:b0:a7a:acae:341b with SMTP id a640c23a62f3a-a86a550a4eemr453225566b.9.1724690293070;
        Mon, 26 Aug 2024 09:38:13 -0700 (PDT)
Received: from ?IPV6:2a02:a449:4071:1:32d0:42ff:fe10:6983? ([2a02:a449:4071:1:32d0:42ff:fe10:6983])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a868f436bc7sm685795766b.116.2024.08.26.09.38.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Aug 2024 09:38:12 -0700 (PDT)
Message-ID: <5ad12808-61f5-4e3b-801e-85231375b6a6@gmail.com>
Date: Mon, 26 Aug 2024 18:38:12 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v1 1/9] clk: rockchip: px30: Drop CLK_NR_CLKS CLKPMU_NR_CLKS
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
 drivers/clk/rockchip/clk-px30.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/rockchip/clk-px30.c b/drivers/clk/rockchip/clk-px30.c
index b58619eb412b..caf7c0e6e479 100644
--- a/drivers/clk/rockchip/clk-px30.c
+++ b/drivers/clk/rockchip/clk-px30.c
@@ -1002,6 +1002,7 @@ static const char *const px30_cru_critical_clocks[] __initconst = {
 static void __init px30_clk_init(struct device_node *np)
 {
 	struct rockchip_clk_provider *ctx;
+	unsigned long clk_nr_clks;
 	void __iomem *reg_base;

 	reg_base = of_iomap(np, 0);
@@ -1010,7 +1011,9 @@ static void __init px30_clk_init(struct device_node *np)
 		return;
 	}

-	ctx = rockchip_clk_init(np, reg_base, CLK_NR_CLKS);
+	clk_nr_clks = rockchip_clk_find_max_clk_id(px30_clk_branches,
+						   ARRAY_SIZE(px30_clk_branches)) + 1;
+	ctx = rockchip_clk_init(np, reg_base, clk_nr_clks);
 	if (IS_ERR(ctx)) {
 		pr_err("%s: rockchip clk init failed\n", __func__);
 		iounmap(reg_base);
@@ -1043,6 +1046,7 @@ CLK_OF_DECLARE(px30_cru, "rockchip,px30-cru", px30_clk_init);
 static void __init px30_pmu_clk_init(struct device_node *np)
 {
 	struct rockchip_clk_provider *ctx;
+	unsigned long clkpmu_nr_clks;
 	void __iomem *reg_base;

 	reg_base = of_iomap(np, 0);
@@ -1051,7 +1055,9 @@ static void __init px30_pmu_clk_init(struct device_node *np)
 		return;
 	}

-	ctx = rockchip_clk_init(np, reg_base, CLKPMU_NR_CLKS);
+	clkpmu_nr_clks = rockchip_clk_find_max_clk_id(px30_clk_pmu_branches,
+						      ARRAY_SIZE(px30_clk_pmu_branches)) + 1;
+	ctx = rockchip_clk_init(np, reg_base, clkpmu_nr_clks);
 	if (IS_ERR(ctx)) {
 		pr_err("%s: rockchip pmu clk init failed\n", __func__);
 		return;
--
2.39.2


