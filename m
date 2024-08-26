Return-Path: <linux-kernel+bounces-301880-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EC2E95F6D2
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 18:40:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8A1B1F22623
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 16:40:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83ACB197A98;
	Mon, 26 Aug 2024 16:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hBpgNaKz"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 391B62F870;
	Mon, 26 Aug 2024 16:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724690335; cv=none; b=W2s4+vdwkCx4xktW+h4XnEiDvcADEyjwWnQjwEsUreZf7bfOEeQF8VeynekGrZYZHIQT32OcKdpVRhnAf2qeym2D5vLCz+PnU2sF6qhgOdOoBkZmws/cDft0arlbPXjcn0jH3b4dIqRgEOvbx9NtpglFsQ2uVsF6ViWXML3n2ZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724690335; c=relaxed/simple;
	bh=wrmyHvHv2nyWcRmmlY5SaB6oRq7gHzJ3hZhhm8EeiLg=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=ptKlCK2ETeRp/ayRF0B9LpYY1EPqm/NllfwoBAND/XiWWEvZcFCpcywRZHhG8LmMXUAzBzA0ppvyjqeIpAbbResS3lgeh/9rkoZ1BqxuwB0kjrI1zEjy4fVjgwmC9t9p+bDXIB6Lqm/l1RMfWaD+G2HMaNOF8OKrX3vWClRz5q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hBpgNaKz; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5bef259a71fso652241a12.1;
        Mon, 26 Aug 2024 09:38:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724690332; x=1725295132; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=EZu/jBjd1Q70dpjtoHTLkvik+k0qgpVx09i6KQH3MDg=;
        b=hBpgNaKzhxfbJXALjb8sXQbGWSjPV8n9YzzhiarcEb+2f6vAiJrb8hguCbKXCZ4mnl
         E0i/YdGO+6ZOFPdN7IbaceA3AZKvvF4yJz+torQstC/ieiYcseSfbTwdcbvvW+HaTs5o
         rq4wVmNrON5b7L/rP6oRxrAbUBXNcEDuE/RgKR1AfimmjbPfeJ/bFHK4FSjgptyD0DFv
         KdBcq0i4tLk8Wy83LjbAriFgjoG1ikVhofAWZj/Yyr7lpTC//jp5v+mR7VZlSJYwWD3a
         FWg8r4TjYVPzqn45K2pv1r8wNjYTauPMjYU0ZEhB22H3VT1FZS1To0xa/w0t20wnx2v4
         ODYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724690332; x=1725295132;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EZu/jBjd1Q70dpjtoHTLkvik+k0qgpVx09i6KQH3MDg=;
        b=wgmkgE1zcyiHNUtAocq05jGr+B3l/jayezfk5N9/z3UPKaQP52mg6fSc936YyXb5hH
         P8+NAu+bk/Qs5CNKBTStC4lXD+noOD2hKnNwUqJDGOWeDKJD1UNd4K7f5epaXWLYTlbi
         /a+BdTKG/oQ+farJHsN9bx8/KeNGCznWVgIyZdQ7YVcFKe3mVtkqzPGDlJdaRzBqa6by
         /l+KqIMl65ybWaruqUnpmgT5h/yB6FW7AkGlTg2dHRHHiOSJ9KoYOMovhDUmAuO9D8vZ
         ZNgpdLSzqpdLUFYpFJfFIKcSLICPZlK375EAZ6j2TlHIwvZB74xGRO/q62UbdmKu2MBF
         iQ9A==
X-Forwarded-Encrypted: i=1; AJvYcCVgKXmwwA/J4fv65u+06cdocUyPRs9EudPqXrqhyHvFwKpe2kIlVJc7qF2qbn9m/CTwH+MSHqyYR0RMim1/@vger.kernel.org, AJvYcCVo6T4TbyTEnB9wJLk+0ioOIzd7ZHV1wymGrR7z5IDB6Zo7EQAOJrPevylj8bjJ8+EpPaAElyv6S3FA@vger.kernel.org, AJvYcCW15XqY4/SoSV4LgneWVi2L1Rgyynq/bVlNLgeUU20gaRZaqgIwzBqEnfujmA4ch60S9YD5d2kn0tjw@vger.kernel.org
X-Gm-Message-State: AOJu0YyPhCDum0xXXaHOrx6PbVP3zy//bhjktbkza/NOoN9SBzRbULAj
	vnZ8FUddQmH8Jsh+RKF0KnePeUvQQ9w7jxrH+QxjvXl2sIZNTNLp
X-Google-Smtp-Source: AGHT+IF5/mm796lJvJrh2R57EkeRqBcf4GBAINfr26Gtc7NdeyL4EuQ0tSkGoqsTXngxQRCUC4zWNw==
X-Received: by 2002:a17:907:9724:b0:a7a:9f0f:ab1b with SMTP id a640c23a62f3a-a86a54bb7e9mr373585766b.7.1724690332196;
        Mon, 26 Aug 2024 09:38:52 -0700 (PDT)
Received: from ?IPV6:2a02:a449:4071:1:32d0:42ff:fe10:6983? ([2a02:a449:4071:1:32d0:42ff:fe10:6983])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a868f4363b5sm684267966b.133.2024.08.26.09.38.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Aug 2024 09:38:51 -0700 (PDT)
Message-ID: <af141286-7994-4e3f-93e2-6ee4e718ef8a@gmail.com>
Date: Mon, 26 Aug 2024 18:38:51 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v1 4/9] clk: rockchip: rk3288: Drop CLK_NR_CLKS usage
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
 drivers/clk/rockchip/clk-rk3288.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/rockchip/clk-rk3288.c b/drivers/clk/rockchip/clk-rk3288.c
index baa5aebd3277..90d329216064 100644
--- a/drivers/clk/rockchip/clk-rk3288.c
+++ b/drivers/clk/rockchip/clk-rk3288.c
@@ -932,6 +932,7 @@ static void __init rk3288_common_init(struct device_node *np,
 				      enum rk3288_variant soc)
 {
 	struct rockchip_clk_provider *ctx;
+	unsigned long clk_nr_clks;

 	rk3288_cru_base = of_iomap(np, 0);
 	if (!rk3288_cru_base) {
@@ -939,7 +940,9 @@ static void __init rk3288_common_init(struct device_node *np,
 		return;
 	}

-	ctx = rockchip_clk_init(np, rk3288_cru_base, CLK_NR_CLKS);
+	clk_nr_clks = rockchip_clk_find_max_clk_id(rk3288_clk_branches,
+						   ARRAY_SIZE(rk3288_clk_branches)) + 1;
+	ctx = rockchip_clk_init(np, rk3288_cru_base, clk_nr_clks);
 	if (IS_ERR(ctx)) {
 		pr_err("%s: rockchip clk init failed\n", __func__);
 		iounmap(rk3288_cru_base);
--
2.39.2


