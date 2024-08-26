Return-Path: <linux-kernel+bounces-301885-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A10D95F6E0
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 18:41:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 405141F223DA
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 16:41:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9BB11991D8;
	Mon, 26 Aug 2024 16:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aK8xZiPb"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96FBB1991C8;
	Mon, 26 Aug 2024 16:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724690370; cv=none; b=JaAiSJE9DvUP74wLEhlCt8nErVd7+S4ofgP9gME+Yrr5/0iZhx+CPfM95y3R4bIff91d/KGrzPSPrytwQvWGtWkuN40rHef6w7qG/XLkCwT0K+2tTyblrKdEdKcUbnn4zy2E9FZNKr76I1yUFL4mmOvTfdK46DI9cpVKUhXhv2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724690370; c=relaxed/simple;
	bh=m0hxTzUnctUabw93oQO8xh0FVMtNJj7oRl3IZXmIAzQ=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=QY7LK02hXlSI4OE/boPVh3kb0AvCm/c+jNxDdcfneo/lQ/+lLD1UjrGGN5PeUxMVQpTmYznAlxVFoW1RMq5w29gD87ET4BTtPqJ9lNvGCV/Rq3qaDL7OR6ajkRG+Ew4+Ai333z+P4VGGG7OzutKAMWWQxcYzsl4L4SMB5iElqpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aK8xZiPb; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5334eec7485so832505e87.3;
        Mon, 26 Aug 2024 09:39:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724690367; x=1725295167; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+i2AlGYsoxr4BsaWm8n7FjsczEQSUj3cbbi624qx9q0=;
        b=aK8xZiPbpQvduItmIP9VzrO4pTkSYAQIT/cqiCUMyrPsqjwEZQr2hhtM0ptOUuV8o5
         alDtq6eINAcT88z6+rnwNfqnVl6/K9eMA45x1MDPSm8RWP/14C5ssPjYdBEFWHB9Jj0U
         C9gAYWCu/LPfT8H1gZTCvCq94wRk5ZiiLWeOILqhSWzNTotHnNNWFPXllbhaDJ0i594N
         pG3RlTzDBhD3qp57OYL3Z1H/rx1xOXKEqLZDSG1Q+wC7ZFCGo1y8yJPRzonry8m5RMVD
         q9aURZ2BbDkWp22zFNB34xpst6mLi6X9BithiNhOUZV0yUMHG84r+LR31ENoqbItTN+K
         0Okw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724690367; x=1725295167;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+i2AlGYsoxr4BsaWm8n7FjsczEQSUj3cbbi624qx9q0=;
        b=MGPDxnilVFGjHrUj873VfF33wLxWfLS+2vWbyRm4jhUlwdJXh9hyJ6sbBvAuRhAXTX
         iq7FYgsUIqXYc/PtXqnV6C83IJH5wOxRd0Gi9ayTBUqJwLn245ianm3Gx75/oHJkXTSv
         BEYh7r6IXYYGkUjVRapu4/12W7fPNQrJf9ltZk7/kiKQxiYG5X2ebmymbEnRjYbCRcul
         /B4sA0K+FPvfQPypy4Jmpxy7oZ3NtjwUnQmJMlW7V+dLQMFPi/xA+ilvM8FCwRBUlWtj
         8TgEz6O3wMCBcHycrT869KetxBg6HUK8TH3jghxOK6FUVZYg2NQiVv1TQfwn96/bUcs6
         rh0Q==
X-Forwarded-Encrypted: i=1; AJvYcCVLI+0aorlsOl0Jfd1ZgCODBEJX8EPGj4cGh2onNLPeWUkahccNtR7hbdrRCRVGFjXlkZQjTCsgs0ix@vger.kernel.org, AJvYcCVWyCUPRdCAUGKQm1K+VQl/2XzRQBm4PV018Gs9BJlAXx6SdBDB7VVIqYeOpO3oZzFNQ28NDE+NZdrd@vger.kernel.org, AJvYcCWR00kOWCcNBkgw9qgXajREligocOh6yAR1ghbH0/85IOUim5Ld2kL/yZIDcrL7xXXLCs/liGOyEVEsR3XP@vger.kernel.org
X-Gm-Message-State: AOJu0YyB2zKtKR6e8bfjtI8yrpY39C93evoBA5UUVmIGCnb5McjROakd
	q9m/dr+CkNViLDz5xFDdqUZIJUVIIrLDQ56wQgYSoh4ZydwIuceua+N65A==
X-Google-Smtp-Source: AGHT+IFlY9yEz9cwzKGmpwql9VSj73wxFguXPTKKyguV45o2cj0X7EvoITq5F+dR8W084K0HOgqukA==
X-Received: by 2002:a2e:bea3:0:b0:2f0:29e7:4dc2 with SMTP id 38308e7fff4ca-2f4f4944d49mr48761801fa.5.1724690366281;
        Mon, 26 Aug 2024 09:39:26 -0700 (PDT)
Received: from ?IPV6:2a02:a449:4071:1:32d0:42ff:fe10:6983? ([2a02:a449:4071:1:32d0:42ff:fe10:6983])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c04a3cb0b2sm6101451a12.22.2024.08.26.09.39.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Aug 2024 09:39:25 -0700 (PDT)
Message-ID: <2a19c3cc-5f4d-4d03-90b2-e0bb13b0502f@gmail.com>
Date: Mon, 26 Aug 2024 18:39:25 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v1 7/9] clk: rockchip: rk3368: Drop CLK_NR_CLKS usage
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

In order to get rid of CLK_NR_CLKS and be able to drop it from the
bindings, use rockchip_clk_find_max_clk_id helper to find the highest
clock id.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 drivers/clk/rockchip/clk-rk3368.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/rockchip/clk-rk3368.c b/drivers/clk/rockchip/clk-rk3368.c
index 2c50cc2cc6db..04391e4e2874 100644
--- a/drivers/clk/rockchip/clk-rk3368.c
+++ b/drivers/clk/rockchip/clk-rk3368.c
@@ -866,6 +866,7 @@ static const char *const rk3368_critical_clocks[] __initconst = {
 static void __init rk3368_clk_init(struct device_node *np)
 {
 	struct rockchip_clk_provider *ctx;
+	unsigned long clk_nr_clks;
 	void __iomem *reg_base;

 	reg_base = of_iomap(np, 0);
@@ -874,7 +875,9 @@ static void __init rk3368_clk_init(struct device_node *np)
 		return;
 	}

-	ctx = rockchip_clk_init(np, reg_base, CLK_NR_CLKS);
+	clk_nr_clks = rockchip_clk_find_max_clk_id(rk3368_clk_branches,
+						   ARRAY_SIZE(rk3368_clk_branches)) + 1;
+	ctx = rockchip_clk_init(np, reg_base, clk_nr_clks);
 	if (IS_ERR(ctx)) {
 		pr_err("%s: rockchip clk init failed\n", __func__);
 		iounmap(reg_base);
--
2.39.2


