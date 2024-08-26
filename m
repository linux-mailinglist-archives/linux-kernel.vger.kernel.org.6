Return-Path: <linux-kernel+bounces-301879-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EA78895F6CF
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 18:39:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9496F1F22816
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 16:39:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D185319755A;
	Mon, 26 Aug 2024 16:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hc5oACqr"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D54C2F870;
	Mon, 26 Aug 2024 16:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724690324; cv=none; b=fP2XILAcWHK9gkJTtINN8H3+IixUYrTJ1ZjcOZWTuhGYZgojTKnidEnMIf48ucRdIpQmwCXhIWglmIpYc4aQdhTMgh8n4SC5CJi2pKJMyGCHBr6Ho00ZnqNWk1lCGSPkxqKG980HHYca64sln6u7BHuY8W5NRA+Dc+okfNeBcXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724690324; c=relaxed/simple;
	bh=unU6Yo1ydDutqZQye9P93W1jBxzIgooTFj+TraDA7cw=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=H8aOlw2TbVGlIBgg0DID6JRCFRfYeXIo3AiLQp4idX+2FKvrj+Nzmka08kj/1W3NBPbVmqUb1ltAp+qWZVnTAge2VM4lgknkDOWdVIH9IbRDukXKR5R2756LkzveRi14mVblMaPxVqFZUNDcZ9fgUYmSME4CRkN3one+2n/c3OU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hc5oACqr; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-533446e53b5so748138e87.1;
        Mon, 26 Aug 2024 09:38:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724690320; x=1725295120; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=752Mrptz3EsbmUrr2Glsdy9heW92gw97tgRdBEx4Wo0=;
        b=Hc5oACqrvopAY2w2aV1k88njEzTiHlWGp9pGEyJoqSbGwAb+XDj5zqCwIXZxS7KDMG
         9opjSnYXKqz9iXLS07rr5YHdwo2xZdRVG+TdMsYilw3dAOtYr9UZiLtQpJb92AKG0K7W
         hoAuVrHul+Ut4P1K4r/3ZBT1ECcSEKbGD2TU0m4k0gyWIKORH2n0eCNUhNdSnG7DI9mT
         LUdIPgU0ASPViFw+7JTsKAJlf3l8lZkMV5KfHApbUve3mMS3w1aYUsc73Hy3yudsRttd
         /Bnj2Nmlgduwv6Jmqxq6vzxlEjYbTzVayvaUcghOQN5vJvL7nSD505tvNldnbrlQdx5I
         vjVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724690320; x=1725295120;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=752Mrptz3EsbmUrr2Glsdy9heW92gw97tgRdBEx4Wo0=;
        b=pkkMXjcHYD7MbXtuHM5DG6a7/HnKZQxPeM0Xo2gROWv94tVqqlUB4VkZMSb++EO32u
         rJCGwLTngg29ql+Tx6JuatNJZ95FofRCwpz+Ix+JSpX1DTGw/EUjkh0WWHGLnH+Bz/pp
         SG0ABlFQpQR4KH7MdlzJZOmn1vhcr4S0044Ahp2aXZZsaOGw32EKSEpILQgtcxaASknT
         KyTzW2uqt0DXk8ORMjNO6Ss0AM1OkcMJ9RXnQKtSeC8c+xpm8ZFv8uoJQa8GFPAqSYCv
         DrxNALN9om7AymlehVNDdGU2R8IullrTaSfhz7hJYiSokSGW/+iLT9imyHh9qHXZ6xL+
         MS7w==
X-Forwarded-Encrypted: i=1; AJvYcCUiuY+N7hmlPiHXT80CVTaLPjg2x08N7+v5GpSmgbhayXKxi0qQkLfXgm5mU6jn9PEwd9nlHEP+DHb3@vger.kernel.org, AJvYcCUk6BOotUghcQp9D7WvnAcBwwbr1Zd4xKG2t5f1kj8HPRpuyELrSnMJyp694o55+0kop9oO90yf2G3Crzm9@vger.kernel.org, AJvYcCVjz3vBKbR+h35KWgeJiEbrqOCd9i+8UDKzrb9pRiSELXo0DtWZ95D6RaqG/QpES5aIS1Jiyf/OfSuG@vger.kernel.org
X-Gm-Message-State: AOJu0Yzcjf1sb31HBhNTkW76gO7lUDxhyomklFnQdzaRuW07w/+8SVA+
	u2JikxMCv3uyXYf+q0eoCw96xQxhs8guNsMB5GKhdbk7zsX8/G41
X-Google-Smtp-Source: AGHT+IGc/UAzFSmVQIQ+Hglo1jjzZjGNfHpwVXB7AZL+IUlmod8yK3tbxu7FQIRBiL9BAjkK0n1CwA==
X-Received: by 2002:a05:6512:b11:b0:533:dde:bf07 with SMTP id 2adb3069b0e04-534387be364mr5038397e87.5.1724690320147;
        Mon, 26 Aug 2024 09:38:40 -0700 (PDT)
Received: from ?IPV6:2a02:a449:4071:1:32d0:42ff:fe10:6983? ([2a02:a449:4071:1:32d0:42ff:fe10:6983])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a868f484b29sm680320966b.162.2024.08.26.09.38.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Aug 2024 09:38:39 -0700 (PDT)
Message-ID: <2ee6f0a5-a1bb-4b62-ae6b-8f3828f8eccc@gmail.com>
Date: Mon, 26 Aug 2024 18:38:39 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v1 3/9] clk: rockchip: rk3228: Drop CLK_NR_CLKS usage
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
 drivers/clk/rockchip/clk-rk3228.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/rockchip/clk-rk3228.c b/drivers/clk/rockchip/clk-rk3228.c
index 7343d2d7676b..ed602c27b624 100644
--- a/drivers/clk/rockchip/clk-rk3228.c
+++ b/drivers/clk/rockchip/clk-rk3228.c
@@ -683,6 +683,7 @@ static const char *const rk3228_critical_clocks[] __initconst = {
 static void __init rk3228_clk_init(struct device_node *np)
 {
 	struct rockchip_clk_provider *ctx;
+	unsigned long clk_nr_clks;
 	void __iomem *reg_base;

 	reg_base = of_iomap(np, 0);
@@ -691,7 +692,9 @@ static void __init rk3228_clk_init(struct device_node *np)
 		return;
 	}

-	ctx = rockchip_clk_init(np, reg_base, CLK_NR_CLKS);
+	clk_nr_clks = rockchip_clk_find_max_clk_id(rk3228_clk_branches,
+						   ARRAY_SIZE(rk3228_clk_branches)) + 1;
+	ctx = rockchip_clk_init(np, reg_base, clk_nr_clks);
 	if (IS_ERR(ctx)) {
 		pr_err("%s: rockchip clk init failed\n", __func__);
 		iounmap(reg_base);
--
2.39.2


