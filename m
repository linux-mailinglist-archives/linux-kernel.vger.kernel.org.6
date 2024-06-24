Return-Path: <linux-kernel+bounces-227139-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 703A19148F7
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 13:40:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CED8283D32
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 11:40:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6BF413A878;
	Mon, 24 Jun 2024 11:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A+WCQ/Oo"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3788513A252;
	Mon, 24 Jun 2024 11:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719229208; cv=none; b=KvL3u6V05Sc1YHDh/6GAcpInIbQ11SDjcHFmuejMtNS1gqBd1N1lNygI+wm26+/GWqhFGEfOI5byj2zFNZxW9XUyJSSFUZpqWb+w15VR4tgtD/KucDPTzU5vnUo0Ve13w0jlqSnk1wYZbcFyeRuqNNqSEB6c2wkn3T8EI/E3JXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719229208; c=relaxed/simple;
	bh=mLExQpEyH9EpHpOLkBEcwJgkvJOZidD8fSxj0EaqoFY=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=HCfkQg82t7d8QfJQ8XGnblyPV2Fv+JXuA/bRbleturET1/N1Apa9CQt983FSvR77q4l4ZyjlXVqL1XY9TkILDD529uLZ4gI0ZEQPN6pajns4N5VTwKUuJDp/CEyf5c8REUfZ2IyU+4pxIR3vHPmTqRJ2lL6l76rjK9rki0qXM5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A+WCQ/Oo; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a725282b926so116318666b.0;
        Mon, 24 Jun 2024 04:40:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719229204; x=1719834004; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x2nxtEYTMtc39GIl327PDzD9Ljyt5YP8MxnbXGhepIY=;
        b=A+WCQ/OoGOumlQzD9l9iKjcvMdKCQbW1wJBrsqsD+JQgg5ohVI4tdNk/Y4UMIA8Zk8
         LJGj7JoWIuRLtPX3fnT7Ipv8zL5BXGtsSZIa1gvzy+E5Ydx/iAo1Gr68dnS4/WlToNut
         o1wETDFhdS6fflpmikfWJR8VXohUyIW+LdAp40sV2jtIHPXeb10O/a1Y8DXx/ShIVplK
         jK4Egbb9madUZW61NLyCzk5t4AiQtH1LKR/4a0xpxfRGOfm9dr36FOsOo3wIfVPPeo66
         V2Hbw/DXb0a6V8IewxwDYN+HkF2xD+AlAsofwjZvliOI62NrdI2jWQC5c9M79QmJ5kSQ
         5aJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719229204; x=1719834004;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=x2nxtEYTMtc39GIl327PDzD9Ljyt5YP8MxnbXGhepIY=;
        b=s6dNg/nIxsXOZvgQ7YQ/EVXIVY8wC1wqnnIFKH/BSkilTK+A6HhsU4GdRvwIXUGM7W
         HRYFzCN9WL0uBMUz+FdDfF4XQJ0YMuK/uNLcwg0nsrrme3QoG4M3NFt7//x7dTWBk2BW
         KtM3guoaumkmCShUPPeFI44xGBGmRmPlklDIN46qOvUKbKpUgXH0GPhtU0KlFrDaHoWt
         mxm2gb3d5U8mCeO6wT+O3+s8fpUhtiKzALMqLTmxt2qxEgXN7W4UQQ9s9i9vnHFhKIF0
         uRYy+S/z+zBKulfgLdEC4cYj0CNuu4TAf9yB8/cApjExixba0Eg4ZXTQRJhwS1k8Y94O
         WMqQ==
X-Forwarded-Encrypted: i=1; AJvYcCXh88REoXBAm5lui8AXGD0hOe9hzreyxD0fqWM05LK7kiu9UFeaCgydrJUnvAv+BKq+YRjhs32Z3jxOEAqzYIUium/ukHeIL/fE0Y+/IFds1dEPgH65IRrR/UblTTw/FbOFhVrEsUm0
X-Gm-Message-State: AOJu0YyooXwWmOE0wqY5HoRh7s1h93dAUnaK/KCdlJ6IeKniUTNHJPV6
	E7cXe/l3sqwba9CiZLsbLE+3TQt3k9Ml+eM0kYkHQWyeNxfded4x
X-Google-Smtp-Source: AGHT+IE7ua8tr4fotElRzbb9ZE9N9J2SRRVzmmEB5E2CwHxAW1trh0N00sZtAm2FzIZ7aoBdEw0yzw==
X-Received: by 2002:a17:906:a2da:b0:a6f:61c7:dea7 with SMTP id a640c23a62f3a-a7245ccdab7mr267050166b.18.1719229204264;
        Mon, 24 Jun 2024 04:40:04 -0700 (PDT)
Received: from ?IPV6:2a02:a449:4071:1:32d0:42ff:fe10:6983? (2a02-a449-4071-1-32d0-42ff-fe10-6983.fixed6.kpn.net. [2a02:a449:4071:1:32d0:42ff:fe10:6983])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7260566aaasm28542866b.18.2024.06.24.04.40.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Jun 2024 04:40:03 -0700 (PDT)
Message-ID: <1cd309fa-a4d3-4283-aa47-1330a40448a7@gmail.com>
Date: Mon, 24 Jun 2024 13:40:03 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v1] clk: rockchip: rk3188: Drop CLK_NR_CLKS usage
To: heiko@sntech.de
Cc: mturquette@baylibre.com, sboyd@kernel.org, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

In order to get rid of CLK_NR_CLKS and be able to drop it from the
bindings, use rockchip_clk_find_max_clk_id helper to find the highest
clock id.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 drivers/clk/rockchip/clk-rk3188.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/rockchip/clk-rk3188.c b/drivers/clk/rockchip/clk-rk3188.c
index 9c8af4d1dae0..30e670c8afba 100644
--- a/drivers/clk/rockchip/clk-rk3188.c
+++ b/drivers/clk/rockchip/clk-rk3188.c
@@ -757,9 +757,11 @@ static const char *const rk3188_critical_clocks[] __initconst = {
 	"sclk_mac_lbtest",
 };

-static struct rockchip_clk_provider *__init rk3188_common_clk_init(struct device_node *np)
+static struct rockchip_clk_provider *__init rk3188_common_clk_init(struct device_node *np,
+								   unsigned long soc_nr_clks)
 {
 	struct rockchip_clk_provider *ctx;
+	unsigned long common_nr_clks;
 	void __iomem *reg_base;

 	reg_base = of_iomap(np, 0);
@@ -768,7 +770,9 @@ static struct rockchip_clk_provider *__init rk3188_common_clk_init(struct device
 		return ERR_PTR(-ENOMEM);
 	}

-	ctx = rockchip_clk_init(np, reg_base, CLK_NR_CLKS);
+	common_nr_clks = rockchip_clk_find_max_clk_id(common_clk_branches,
+						      ARRAY_SIZE(common_clk_branches)) + 1;
+	ctx = rockchip_clk_init(np, reg_base, max(common_nr_clks, soc_nr_clks));
 	if (IS_ERR(ctx)) {
 		pr_err("%s: rockchip clk init failed\n", __func__);
 		iounmap(reg_base);
@@ -789,8 +793,11 @@ static struct rockchip_clk_provider *__init rk3188_common_clk_init(struct device
 static void __init rk3066a_clk_init(struct device_node *np)
 {
 	struct rockchip_clk_provider *ctx;
+	unsigned long soc_nr_clks;

-	ctx = rk3188_common_clk_init(np);
+	soc_nr_clks = rockchip_clk_find_max_clk_id(rk3066a_clk_branches,
+						   ARRAY_SIZE(rk3066a_clk_branches)) + 1;
+	ctx = rk3188_common_clk_init(np, soc_nr_clks);
 	if (IS_ERR(ctx))
 		return;

@@ -812,11 +819,14 @@ CLK_OF_DECLARE(rk3066a_cru, "rockchip,rk3066a-cru", rk3066a_clk_init);
 static void __init rk3188a_clk_init(struct device_node *np)
 {
 	struct rockchip_clk_provider *ctx;
+	unsigned long soc_nr_clks;
 	struct clk *clk1, *clk2;
 	unsigned long rate;
 	int ret;

-	ctx = rk3188_common_clk_init(np);
+	soc_nr_clks = rockchip_clk_find_max_clk_id(rk3188_clk_branches,
+						   ARRAY_SIZE(rk3188_clk_branches)) + 1;
+	ctx = rk3188_common_clk_init(np, soc_nr_clks);
 	if (IS_ERR(ctx))
 		return;

--
2.39.2


