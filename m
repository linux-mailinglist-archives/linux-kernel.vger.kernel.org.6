Return-Path: <linux-kernel+bounces-301882-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 22DC495F6D8
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 18:40:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CEE4E282CF3
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 16:40:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6971198E81;
	Mon, 26 Aug 2024 16:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="drN+7WB5"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 608682F870;
	Mon, 26 Aug 2024 16:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724690358; cv=none; b=MB2xndnqjHMHB31JLDUfoi1/eDIHrS831u6OdAsiA2DumAWHlLOj4wVokEVAdfPxJPNODqw5Yn3K/suh0gxeX3it9PIcbPajCXOf7/r2Za0WY94koowsaFdX64FlSxUtJ9NFN6nZnK8ENOXnXUTgB6lIUkUUJXntc9ZWmp0pkQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724690358; c=relaxed/simple;
	bh=paO1IvGljZA9aHYuoMtlHqMiQEvGSGHGysSKkSAx6bU=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=mWdNotnASVHh9G5ZgPMzzNz/AF5GY0jSFwxSW7SUuFfDTiXpGGVKdXHYqZ2X8T93wh+RB3WvFw3zwNW+LJX8vPpCbCcc907pGI5ZF2AgwZRaMgZRPHoOe3CsF9tI500tYDF6dY3Oi/0at5USn2chfevhVyPiLDZH28iKjfar+yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=drN+7WB5; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5bec831d77eso652144a12.0;
        Mon, 26 Aug 2024 09:39:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724690355; x=1725295155; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=tOSmg+U9ko9Cd03A5hlrj+MTA2zfydTPh5GQ0xhJtAk=;
        b=drN+7WB54cBA0YRCyhM0/Q1r9kvfA6p/s2qAU1W+01j1SR9c+kmhLQSwuG+J3DCXYX
         VLvFj8psnEDW6JmJrwwfDdEOU1SSMxUs7yd8LiixUdctNO4vD1Hvnd3/W6yAn0dX/3AL
         YaKHMd8mXedZRjqe7muxiatRX9ftSDxv3VA8jCQTkeYP7RlQ/qijpVeogMrrqJwBDUjR
         CHbVnGsp3rwrzH8mg/AvmhnAQxQEEHlYxFab0YPIRng3L4MFd8yYaiCGmr8nl/i57Rfh
         DA4OYP4Dzd5PtQXshjTRNvIen288PpWXI+WgigISu3/jrEHzi0n8x71z2OcJTgWBRR0L
         43AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724690355; x=1725295155;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tOSmg+U9ko9Cd03A5hlrj+MTA2zfydTPh5GQ0xhJtAk=;
        b=GfmHrxT+LLUBVzXEwCFU1rbCD1I1GUsHj1v7bVtPxrYLjm+eyfLtWXncxViof8q3Ji
         f9/ffK1ywhFhRKIpg9DDRG++KwTcYk95L5deU3GUDaCvVk/nZv0XPVJDez+KpQBwnJGT
         6dd3lsBnVTtHstoVd/fVoiuWXEDxSkVEokshXFG7h1XkSFfZ1xDhrMBzClrwDCFOpCCs
         DX7j+s68DmgJ0ju1bn+fDpkVE+rBlzJUEAaUeWJtoL6YaBuZfWxlGs4ui/X+PWLX1vTj
         l3GgR3X17djiQKpU/CDLQ8Qp3Q4lohMrcixqAm5Tf++p1v1RsJoT+9/mMQ6MkuHaGdU1
         qlMQ==
X-Forwarded-Encrypted: i=1; AJvYcCVfQnFbtQqKRpc1oNTEAetXGY5XBxzc9ZlNBpRBKu36F1nwOjsFEzvmwrVp3vXyrHKs1ssA3wIB7qxQ@vger.kernel.org, AJvYcCWlLjG6xQ5XKk3qj5KRZLwzL/4H4c5U/S0kk154HDL7lOB4KVyrsiOxNIHfIIF5IMVApSASZhV2f6AZwiSJ@vger.kernel.org, AJvYcCWvqM9ldsXCBn93B40To30IpERhB/0cKkxfodcffzPD+vtpj6OmzE+CJHObj2uLe3WYaEV7YWVCXPHf@vger.kernel.org
X-Gm-Message-State: AOJu0YyxHrEgiiqKHY7hymezXce/EztoW4B0TUkG/A+2DYLhqroEwp7O
	uXEbDZapAzzTXa+t3PG4hn3LhF8wq0/esJFJrw/A/6zPKvYcwkg8
X-Google-Smtp-Source: AGHT+IG1NTXW7GOuJLnWfkEVMy5ehfNd0YoEsMP2KyOoOKtU5dmeMYDV86OyxSCX9fEeyld4pF2lcQ==
X-Received: by 2002:a05:6402:4307:b0:5be:9bc5:f698 with SMTP id 4fb4d7f45d1cf-5c08910dbdemr4226209a12.0.1724690354491;
        Mon, 26 Aug 2024 09:39:14 -0700 (PDT)
Received: from ?IPV6:2a02:a449:4071:1:32d0:42ff:fe10:6983? ([2a02:a449:4071:1:32d0:42ff:fe10:6983])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c0515a961esm5781754a12.83.2024.08.26.09.39.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Aug 2024 09:39:14 -0700 (PDT)
Message-ID: <38ea6be0-3596-49ec-8de9-aef9c7f2bbb6@gmail.com>
Date: Mon, 26 Aug 2024 18:39:13 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v1 6/9] clk: rockchip: rk3328: Drop CLK_NR_CLKS usage
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
 drivers/clk/rockchip/clk-rk3328.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/rockchip/clk-rk3328.c b/drivers/clk/rockchip/clk-rk3328.c
index 267ab54937d3..3bb87b27b662 100644
--- a/drivers/clk/rockchip/clk-rk3328.c
+++ b/drivers/clk/rockchip/clk-rk3328.c
@@ -881,6 +881,7 @@ static const char *const rk3328_critical_clocks[] __initconst = {
 static void __init rk3328_clk_init(struct device_node *np)
 {
 	struct rockchip_clk_provider *ctx;
+	unsigned long clk_nr_clks;
 	void __iomem *reg_base;

 	reg_base = of_iomap(np, 0);
@@ -889,7 +890,9 @@ static void __init rk3328_clk_init(struct device_node *np)
 		return;
 	}

-	ctx = rockchip_clk_init(np, reg_base, CLK_NR_CLKS);
+	clk_nr_clks = rockchip_clk_find_max_clk_id(rk3328_clk_branches,
+						   ARRAY_SIZE(rk3328_clk_branches)) + 1;
+	ctx = rockchip_clk_init(np, reg_base, clk_nr_clks);
 	if (IS_ERR(ctx)) {
 		pr_err("%s: rockchip clk init failed\n", __func__);
 		iounmap(reg_base);
--
2.39.2


