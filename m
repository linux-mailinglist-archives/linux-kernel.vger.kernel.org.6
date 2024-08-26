Return-Path: <linux-kernel+bounces-301878-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E5CCE95F6CC
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 18:39:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C0C51F22898
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 16:39:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3968195809;
	Mon, 26 Aug 2024 16:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Au9b6wT7"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67110191F78;
	Mon, 26 Aug 2024 16:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724690310; cv=none; b=GRSU5FqkZljENxuzE313rvCmOU5FfS17/t69J89htfzJEnHZA0pDNsjHz+ZJeETbo52Xjxvz+iFohLnIDLBdD/a6jc3a+WvNl+iOzJPvRoOBXHBzipwt6DgeiNQ7DraOokZN+OyWsx5pyfOXFdhXDba7iJris7tcu7Om15QjFA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724690310; c=relaxed/simple;
	bh=KldMEYNpuc1fUqRb0YPV/CoQkolzt3ozzhaQ3kQiz18=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=o+0WFG/dZpsFohsS/uHTvRqcKtwdIK9D+Kq30L4NDxz4rSYHOkIy6Yov/XhD/Ejt7/kho4CBhFE9+48sli242uCNeyJql8Uq+XazFbEBLKuW/x58rN7UQeOTnfcFfKY/KXb1yi6Lf/GsNhLQA2xKtmRIpy8ZshA2I99qkGjPmF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Au9b6wT7; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5beccb39961so713499a12.3;
        Mon, 26 Aug 2024 09:38:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724690307; x=1725295107; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yhq/9WJku/9EgEbho9+8mkKwaS95Mme88p8ubN0Cp18=;
        b=Au9b6wT7YtTQ191laYQF3AiEThKzfgBpHd251TJuRDgWc7eOD94kJ1RSF0Ehb+DiVR
         umzfdQD4qgj1NvIrQalnt583NIEqOCfKDA41XiDBiRs3SuLXyi7aT0uVlsuVis5/ZCUG
         bCHhZlfVrXLiGfFAdFDSNqpJeW5WWG0C7yzWpI78iditzQDehQmLtlFAUxR6/kCDHjMd
         b98u5HizYwQezSGdEQD92itiHxlDycdrh2/Q4WfKET5CS6WHxLrByjFaMc4qeTyO/nMJ
         GYZPqvcinRNnya3y0sLcemVgWOTdmWE3Ab2RIgYdJANxdocgTluKr8gXqGnFdbZ969Hp
         0P1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724690307; x=1725295107;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yhq/9WJku/9EgEbho9+8mkKwaS95Mme88p8ubN0Cp18=;
        b=bAuEqKu4GibvvdryXKEDvd21/3TdTG9QSsx2xvjix53l30GwBlsXXTXp59Vcx5o2xZ
         lvtQBVRmm3ciTTFWduVvxLGgDxOp0OFd1cAuYNmFM+5W2cCD8A3jtA/bHiAVZPjrEux2
         BozKvM4dNe+59slP1DVpsg7nmwpF5sptikazhnEzSpG0Rebi8Bzx/jGW5fNJnOPxZvrE
         OW/ThLgLJ6f9ao1eeLdFXOKBGDlAtUwPC/p2E36bPuDAXZoR+HNOJI4ALPAcCPR/4t0u
         7onQVNaeLWjL7lOo60RFJrLD0oOgGlyz1KqTh9xv8mBLbefzuJekFFGlK7KlpRYFVOMO
         J7LQ==
X-Forwarded-Encrypted: i=1; AJvYcCUvok8/Dbou++kMQ9bJGgaKrTZFkNQaJEXJxTd7z8vzQRycQWmqZ6W73A1zDDnt2j7xU8xLiMlfHVbm@vger.kernel.org, AJvYcCWkgDX2VQCe7LdMToOTEieM4mRTGvB50UiKPiqWvgej/xqTLFsNLeCeOyAXnNVK5R+iDL53fork1J9PvRo/@vger.kernel.org, AJvYcCXjphZg9ioOgMAFxDGoSN3rz4TuGqlEDARvMKu6nGyvDSzABN8yhHxLhzzQnqJxUj36V4IoST8ZkqsL@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9l7NWiIyDBePkxER1ivB0EK20Jvy09FUKWwz/e4PnHeGSP2LH
	EgTp2z4v/SALr4SjT5oqugAEZio5wqqgor2YdMFXtanNt7Bwe3n0
X-Google-Smtp-Source: AGHT+IHJJKkoN0mudLhREuJFqK/RBwRijj8qeEa1gtLmFiRUc9gIA1e33tIg7ucKuVXcnXRqVW0BTA==
X-Received: by 2002:a17:907:7d91:b0:a80:ed7a:c114 with SMTP id a640c23a62f3a-a86a4ea63cemr395278666b.0.1724690306550;
        Mon, 26 Aug 2024 09:38:26 -0700 (PDT)
Received: from ?IPV6:2a02:a449:4071:1:32d0:42ff:fe10:6983? ([2a02:a449:4071:1:32d0:42ff:fe10:6983])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a868f4361c3sm682266466b.114.2024.08.26.09.38.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Aug 2024 09:38:26 -0700 (PDT)
Message-ID: <c8e73847-f472-4473-ac55-068cb28b98f6@gmail.com>
Date: Mon, 26 Aug 2024 18:38:25 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v1 2/9] clk: rockchip: rk3036: Drop CLK_NR_CLKS usage
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
 drivers/clk/rockchip/clk-rk3036.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/rockchip/clk-rk3036.c b/drivers/clk/rockchip/clk-rk3036.c
index d644bc155ec6..d341ce0708aa 100644
--- a/drivers/clk/rockchip/clk-rk3036.c
+++ b/drivers/clk/rockchip/clk-rk3036.c
@@ -436,6 +436,7 @@ static const char *const rk3036_critical_clocks[] __initconst = {
 static void __init rk3036_clk_init(struct device_node *np)
 {
 	struct rockchip_clk_provider *ctx;
+	unsigned long clk_nr_clks;
 	void __iomem *reg_base;
 	struct clk *clk;

@@ -452,7 +453,9 @@ static void __init rk3036_clk_init(struct device_node *np)
 	writel_relaxed(HIWORD_UPDATE(0x2, 0x3, 10),
 		       reg_base + RK2928_CLKSEL_CON(13));

-	ctx = rockchip_clk_init(np, reg_base, CLK_NR_CLKS);
+	clk_nr_clks = rockchip_clk_find_max_clk_id(rk3036_clk_branches,
+						   ARRAY_SIZE(rk3036_clk_branches)) + 1;
+	ctx = rockchip_clk_init(np, reg_base, clk_nr_clks);
 	if (IS_ERR(ctx)) {
 		pr_err("%s: rockchip clk init failed\n", __func__);
 		iounmap(reg_base);
--
2.39.2


