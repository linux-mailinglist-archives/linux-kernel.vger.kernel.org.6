Return-Path: <linux-kernel+bounces-301881-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69B1595F6D5
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 18:40:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C7D21C21EA7
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 16:40:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A691198E6F;
	Mon, 26 Aug 2024 16:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GVnrGYls"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0FC42F870;
	Mon, 26 Aug 2024 16:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724690347; cv=none; b=sre0gCN0VMgxsqXyy31YXrn6tW9xQOf98D3RHp8qG08Bxvjx6MRDgMAFrOZlTi35L1eBCpegT0B37XoPFT2iq1oPhwjiWqrqsSGkT5XjNWRagQqRFKUtH0F+tlAlN7gIoE6mVgpTvTiPoaWDQjiqYJ9j0NJ9bIoYEAswt3JQ9OA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724690347; c=relaxed/simple;
	bh=PEZnnBeiNVt3GdRDl4q/XrzlNfMfIl5dQkddY50cuY4=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=QoqS4wuJfvyYDQGCrNXaln2IT++N6A0zecIfMFCDnJrYT8mgDEMtm0PjEbecKK8XkYBVmWvjDPfMQSYKgJxwqUbkunRBoh6KrcjF9yYkSEaIO+ZuCDcW3vO2Ke6YIPAozBZ9/TMm3q/k5uUIepCs9m1Lmt0uNHCjxc31os8neqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GVnrGYls; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-53345fe848eso1019518e87.2;
        Mon, 26 Aug 2024 09:39:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724690344; x=1725295144; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0pQNjRvPbGFwIbtiuAF6ctUFukzjUNsN4+HfbcLCR3o=;
        b=GVnrGYlsv4MUaluU1+/GpHZVpMgEOZNYW88/ss3dvWnDK3w3RasaFOh7tMtxR3HPca
         t/nRD24olpCAJYiXQsgG5liqDxa3I03WB7W7sz3eRWAGe6FGG01/10+khjLV5emCsS3M
         1n406Lg89AHVJfjdWPukHEAQMPfMWP8ygNN/4DyfShhOEmsrhwewitoNORBMwew/Nwf0
         ilHEXf2pBS0RdRcabsNVTETruE0W/M6cGJAyijj1MH1LnT3LmxU5Trc7tDtJo1UTUsCX
         uCKRZ9WnpX/AHtGQLXOjTES9bANHSywOyAG5iSQ8b24epjCL+xgdGk1dF5VUIoSNO2g9
         lyyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724690344; x=1725295144;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0pQNjRvPbGFwIbtiuAF6ctUFukzjUNsN4+HfbcLCR3o=;
        b=RQKkBSJ8LWRqFqe10VmTAtgwQY1snx8Gz4lMFK9yHlJghLZ5pvaQuBDMMLCVA4/9Dn
         Hj1J0cfGIJyaB79B3zr+ru1mzHvBML2LlMOGdZouJWHtNa73f76m6f8xBZkzQdNylwgB
         odZdyClB7I01iidKx8QM34XAir7ufNSC4KHFbaHAz3TX1F+IBmx+/ls5juzNDzzg97UL
         NqSr+h0r4HM4dqnR1OBvKU4VD6JBmwykuozgGvyHY5ax7qF3Xc+WGEYvukmO7lL964ro
         QU0BVdZFPykiKJ2NkzAheyrr7mv1YIbLEwzx1qn9I9a6qS9XTVRuF//EGaQtsfRQdXJg
         OgEg==
X-Forwarded-Encrypted: i=1; AJvYcCVBu5IiEhgUc6tegKbydk3SB4RuFvclSFHX1HGiXxs/b83Bd9AX4f2YfvcouSF88H+QJ43ZHDSJ6WOj@vger.kernel.org, AJvYcCVL2ZbX3/w1NhCAMxTrLMNtaI5Jb7oJwZes2BaSAJcM5KJJEX4RSW8lxZEJnkmicGOlq7vXgjaP3b6P@vger.kernel.org, AJvYcCXeltbWjG2/3xr8t/dlE1gmRR1DFwvXsQnJ+xZszIsqCbIQ25nryxMI0ddienVF3WZ8ClAFMZ0aH/DILFxX@vger.kernel.org
X-Gm-Message-State: AOJu0Yypr60gSzIEMoyhJm8sJdvtR3SmRlSjQbyYtTc1a+pSm+OL/SjD
	kLOKGbYWYFWcODO098iQg88N8xqtVkF+0iy3c+WcppsQwgqhegA+
X-Google-Smtp-Source: AGHT+IEM7G/1hSJu1S8jVW53HPtYBrabXkywCD2sERfCFLDL6cK0F7718zBUberYt362t0n/nsDo3A==
X-Received: by 2002:a05:6512:1592:b0:52f:c142:6530 with SMTP id 2adb3069b0e04-534387c4976mr3999893e87.6.1724690343597;
        Mon, 26 Aug 2024 09:39:03 -0700 (PDT)
Received: from ?IPV6:2a02:a449:4071:1:32d0:42ff:fe10:6983? ([2a02:a449:4071:1:32d0:42ff:fe10:6983])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a868f484b51sm696457466b.146.2024.08.26.09.39.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Aug 2024 09:39:03 -0700 (PDT)
Message-ID: <9fbca2d8-f904-4913-ba05-8715e748a454@gmail.com>
Date: Mon, 26 Aug 2024 18:39:02 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v1 5/9] clk: rockchip: rk3308: Drop CLK_NR_CLKS usage
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
 drivers/clk/rockchip/clk-rk3308.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/rockchip/clk-rk3308.c b/drivers/clk/rockchip/clk-rk3308.c
index db3396c3e6e9..95a9512a41a3 100644
--- a/drivers/clk/rockchip/clk-rk3308.c
+++ b/drivers/clk/rockchip/clk-rk3308.c
@@ -917,6 +917,7 @@ static const char *const rk3308_critical_clocks[] __initconst = {
 static void __init rk3308_clk_init(struct device_node *np)
 {
 	struct rockchip_clk_provider *ctx;
+	unsigned long clk_nr_clks;
 	void __iomem *reg_base;

 	reg_base = of_iomap(np, 0);
@@ -925,7 +926,9 @@ static void __init rk3308_clk_init(struct device_node *np)
 		return;
 	}

-	ctx = rockchip_clk_init(np, reg_base, CLK_NR_CLKS);
+	clk_nr_clks = rockchip_clk_find_max_clk_id(rk3308_clk_branches,
+						   ARRAY_SIZE(rk3308_clk_branches)) + 1;
+	ctx = rockchip_clk_init(np, reg_base, clk_nr_clks);
 	if (IS_ERR(ctx)) {
 		pr_err("%s: rockchip clk init failed\n", __func__);
 		iounmap(reg_base);
--
2.39.2


