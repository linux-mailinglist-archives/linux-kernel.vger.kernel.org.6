Return-Path: <linux-kernel+bounces-250984-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3103292FF32
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 19:12:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8936BB2405B
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 17:12:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCC8E17920A;
	Fri, 12 Jul 2024 17:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="j0e0W9M2"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29450178CC3
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 17:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720804189; cv=none; b=ng4z57XRfYXoekRzMeGztUvz+i1EfH+ChdUihfNsHFHywL/ATuaWrrjbSF0BXW3hNOjsZMTStZt/z9AKM+kXyrnumIkDoF0C42QQP1xF4Ddu5vCjg4wRHfs+KuWTEYmYse/vWmwvORH23E1/DcN32yo60z+8AVLh5M0cghC8KBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720804189; c=relaxed/simple;
	bh=bSuhaMRom2cOObZWO5sZ0z5SXM43/G/at3phYRV+d3A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iHoP9Ac3XFOT6FJ/6/E/Jj+0/SMkwWdOWYwMY0K8R7eeir0AQcXRXmN1ghkJClVerVkWB3Sd24RXvnaKB+Gi697wkpMZsdYwFchpL8DE1Qnwm3BS61T+nr3/axUYPEWK0EuyXr24BZ/Qgogw8qWrrvxoCMDGr8jbqZy91FowCYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=j0e0W9M2; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a77c2d89af8so291271566b.2
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 10:09:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720804185; x=1721408985; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oV5839hmVClg70c+3TJ1+3UQGJnal/6xSUyTsvV9VcQ=;
        b=j0e0W9M2sjT9AJ3H9DQG1Yp2zQKHsyqhw/2eQZnlSppZrG+oOX04uT6LiwE49nCy+w
         TKgHQtKZSxFIjfWTdk9Zi7u6YE6MAiMdlD5rJEPQn7r/5STckStcyAGDNVipEsgHkDTh
         XgHM4KenKEwoFgtGcbSBvv8V+1p84ljjjHiSaQQD0JgIuSkSnJLYFtoPXuv2tefXtNaQ
         9k5jP9c+78R0swbdoyxlUxF66U+quuzFKe8bqOs6zhugiDgtGRi6J2QoZNtNpWp4x4V5
         2FVzTyVT3eqb1Jg+N7JYIsdUT7yD5hWmec0b0rBWbM/HkDn050xtnw5RnX+tB/+zPmmq
         5Axg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720804185; x=1721408985;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oV5839hmVClg70c+3TJ1+3UQGJnal/6xSUyTsvV9VcQ=;
        b=ProM+0S+Zoj41/RPY66aoAfPnQwiGt3+8ivVVWV3N1yp2yWbFSxGx7Iwb2tB0TcDgP
         zGiPY5dlXNfmg+nFL5NPF90DySdDJM2eQj5PClOoVJvlsmkdcKcK4i8VJeoPXciYoaIc
         7S21TcbPG3VNaoqZm5d0qBwAz3DO0R78U0e+siIdAwlY/F8MnZsl/F1b8u8YrE/cjQ5g
         esNG1517jnPhzAS27eYei8s63tvJLsUe7MzHNKZjdHheKKW1iMhgd3pXa6IHBl9/lDks
         Zirg8kbwSifreDjeqlfOoK2s1T9EBZa2EV5z1MQLpR68M7YMlCmNnsMRuQeAPw4UV6IO
         2urg==
X-Forwarded-Encrypted: i=1; AJvYcCVXPYCW4a/nThxQT3yCbIjh9anxLln7XOqZn8di+zMfZtyDovpGOEGSXwmy9lUuaXPb20ztxw1x97yu9TpRCVHvjBQkcMlfekfSaG8C
X-Gm-Message-State: AOJu0Yyirp1sLZpEnvx0E1pjyGEApyObNdXgbbXVHyVvtSJUswQC0hPd
	JXT63ticqn5IkD245xe5tLtgLEZ8U7QLyNOqAQ252ocKV07DqrtH1Q3/JDtEbPw=
X-Google-Smtp-Source: AGHT+IE0X62zA1SBHKfJXtmQHhmzvuqxC+xWaR1cQ47oVYBeYJTjmS0OEYuGETVV0+yrZAnB2M1JfQ==
X-Received: by 2002:a17:907:ea1:b0:a75:110d:fa53 with SMTP id a640c23a62f3a-a780b885565mr1041251666b.49.1720804185474;
        Fri, 12 Jul 2024 10:09:45 -0700 (PDT)
Received: from puffmais.c.googlers.com (8.239.204.35.bc.googleusercontent.com. [35.204.239.8])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a780a871f0esm363750466b.194.2024.07.12.10.09.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jul 2024 10:09:45 -0700 (PDT)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Fri, 12 Jul 2024 18:09:44 +0100
Subject: [PATCH v4 2/2] clk: samsung: gs101: don't mark non-essential
 (UART) clocks critical
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240712-gs101-non-essential-clocks-2-v4-2-310aee0de46e@linaro.org>
References: <20240712-gs101-non-essential-clocks-2-v4-0-310aee0de46e@linaro.org>
In-Reply-To: <20240712-gs101-non-essential-clocks-2-v4-0-310aee0de46e@linaro.org>
To: Peter Griffin <peter.griffin@linaro.org>, 
 Krzysztof Kozlowski <krzk@kernel.org>, 
 Sylwester Nawrocki <s.nawrocki@samsung.com>, 
 Chanwoo Choi <cw00.choi@samsung.com>, Alim Akhtar <alim.akhtar@samsung.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Sam Protsenko <semen.protsenko@linaro.org>
Cc: Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Will McVicker <willmcvicker@google.com>, kernel-team@android.com, 
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
 linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
X-Mailer: b4 0.13.0

The peric0_top1_ipclk_0 and peric0_top1_pclk_0 are the clocks going to
peric0/uart_usi, with pclk being the bus clock. Without pclk running,
any bus access will hang.
Unfortunately, in commit d97b6c902a40 ("arm64: dts: exynos: gs101:
update USI UART to use peric0 clocks") the gs101 DT ended up specifying
an incorrect pclk in the respective node and instead the two clocks
here were marked as critical.

Since then, the DT has been updated to use the correct clock in
commit 21e4e8807bfc ("arm64: dts: exynos: gs101: use correct clocks for
usi_uart") and the driver here should be corrected and the work-around
removed.

Link: https://lore.kernel.org/all/d45de3b2bb6b48653842cf1f74e58889ed6783ae.camel@linaro.org/ [1]
Fixes: 893f133a040b ("clk: samsung: gs101: add support for cmu_peric0")
Signed-off-by: André Draszik <andre.draszik@linaro.org>
Reviewed-by: Tudor Ambarus <tudor.ambarus@linaro.org>
Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>

---
v4:
- the earlycon issue described in the commit message in previous
  versions of this patch is gone with "clk: samsung: gs101: allow
  earlycon to work unconditionally", so no need to mention anything

v3:
- add git commit SHA1s (Krzysztof)
- add link to wordier description of earlycon issue

v2:
- commit message typo fixed
- collect Reviewed-by: tags
---
 drivers/clk/samsung/clk-gs101.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/samsung/clk-gs101.c b/drivers/clk/samsung/clk-gs101.c
index 429690757923..a6fc4d7e47fd 100644
--- a/drivers/clk/samsung/clk-gs101.c
+++ b/drivers/clk/samsung/clk-gs101.c
@@ -3951,20 +3951,18 @@ static const struct samsung_gate_clock peric0_gate_clks[] __initconst = {
 	     "gout_peric0_peric0_top0_pclk_9", "mout_peric0_bus_user",
 	     CLK_CON_GAT_GOUT_BLK_PERIC0_UID_PERIC0_TOP0_IPCLKPORT_PCLK_9,
 	     21, 0, 0),
-	/* Disabling this clock makes the system hang. Mark the clock as critical. */
 	GATE(CLK_GOUT_PERIC0_PERIC0_TOP1_IPCLK_0,
 	     "gout_peric0_peric0_top1_ipclk_0", "dout_peric0_usi0_uart",
 	     CLK_CON_GAT_GOUT_BLK_PERIC0_UID_PERIC0_TOP1_IPCLKPORT_IPCLK_0,
-	     21, CLK_IS_CRITICAL, 0),
+	     21, 0, 0),
 	GATE(CLK_GOUT_PERIC0_PERIC0_TOP1_IPCLK_2,
 	     "gout_peric0_peric0_top1_ipclk_2", "dout_peric0_usi14_usi",
 	     CLK_CON_GAT_GOUT_BLK_PERIC0_UID_PERIC0_TOP1_IPCLKPORT_IPCLK_2,
 	     21, CLK_SET_RATE_PARENT, 0),
-	/* Disabling this clock makes the system hang. Mark the clock as critical. */
 	GATE(CLK_GOUT_PERIC0_PERIC0_TOP1_PCLK_0,
 	     "gout_peric0_peric0_top1_pclk_0", "mout_peric0_bus_user",
 	     CLK_CON_GAT_GOUT_BLK_PERIC0_UID_PERIC0_TOP1_IPCLKPORT_PCLK_0,
-	     21, CLK_IS_CRITICAL, 0),
+	     21, 0, 0),
 	GATE(CLK_GOUT_PERIC0_PERIC0_TOP1_PCLK_2,
 	     "gout_peric0_peric0_top1_pclk_2", "mout_peric0_bus_user",
 	     CLK_CON_GAT_GOUT_BLK_PERIC0_UID_PERIC0_TOP1_IPCLKPORT_PCLK_2,

-- 
2.45.2.993.g49e7a77208-goog


