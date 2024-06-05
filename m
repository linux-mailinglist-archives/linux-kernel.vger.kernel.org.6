Return-Path: <linux-kernel+bounces-203211-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 18CCF8FD7ED
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 22:54:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B22D21F2144F
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 20:54:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B027167D96;
	Wed,  5 Jun 2024 20:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BxaJBtzk"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EB43160873;
	Wed,  5 Jun 2024 20:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717620741; cv=none; b=ddVdw/xCuKqbFyECbIz+qNPq8QOtH7rJTzpdkQd/TL58I52eRET1ZGdhkXVMsI3OvBCB+AuxHbd6IkD4Emu+2cFWP6bflCRVqOw3yPpYdKx9eSVn4IxU2RsLTzKqCNcwwyQsrOOIcOnfBw+pclQgPZPDPxpcVEGmP2NLUmw0CRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717620741; c=relaxed/simple;
	bh=0hQOg06m6hCRZq4aIk0CQ3974f7/WXPRwvQqm4cuKP4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FAU0dWd96gS3Rq12yl7nJnohnRkmFFGADgntQgs2HPEwrg6qfSga+Hh7mUumDiRpeDoNrNzOPM5/vOxwHRqNI9JmYr2Nyow1SRPsgb0fDRc4Dsq2EMA4pcnt9aAnKDN0rYUn07AtDhC2/XrnECVl1NZPYJXxUELVOSgNeKurTmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BxaJBtzk; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-57a23997da3so227932a12.3;
        Wed, 05 Jun 2024 13:52:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717620738; x=1718225538; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fk9rPd7/DZbkWMr4RLdz9e3yLOVFGIh3KC1NJKidnyE=;
        b=BxaJBtzkK9VIT87tBH6H1UwIdp5nKeienqxaI41O7zhC1Q4uR1HoRKX0zUtCFNyP+X
         51PidTRS+jPftr+GzLQ1qnGfFDHyMGRvbDpMSs38rOeCjXvFXseSzsIiBEvHBl8VWnSz
         dIN0JVKlrC43GJc7KBMGYWS5yaKVugRvbJzPVyt0hdRmEqMdbjao53v/y9qNt1BM7YHJ
         QIXZEsuK94qg/5wyWzYieFZ9Qj11ZYLGSH1mINKm5De0sHUtDKhVB4vorGIAoYzASLSh
         VFU3qsbh4QWo2OAVqC3OGgtMxhsbhTAz0WGt8+dhyQ+oHmzuuaQ484zNuKyUaaetAMqM
         1oLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717620738; x=1718225538;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fk9rPd7/DZbkWMr4RLdz9e3yLOVFGIh3KC1NJKidnyE=;
        b=E+5PbKyIJ7FCo/2Ch/V6HtUyRyJ378Y9q0Z9w2N6FQpzvmuFF3C4Kx3VezhYY8Dv1W
         d/tY7wMHvnt7rCnH3Pm71RL162Z60sWT3UwrGDAJvp8acHkXM24P80gkhnXHmB5vHBV8
         Y64vizUG7yX7pkaUNjooBOliB0ocyIdSkRKiryuMKZi4E2eyeFGUyDRUo7Tm3MmMk5qn
         q7VqhWO6I5L5y/g999HkBdcogi8AcXrTzfcHY0UCsUppyeqTeUYgEJVL54uHrdsWLYA6
         DhUHq/JQw8uiTe4Lyr+8FhagKd5bLqv/GXFbbWY+Thrpmll9qdMyHJAEnSszSjXO4AKB
         sCNg==
X-Forwarded-Encrypted: i=1; AJvYcCXqBCA7vLD5TJZrWBtmk3jlUIQjjqpbB+UcWJ/v7Qn264Ha5NyB2Yy32EZKgtkKGRT06DRvjAVTclFpF/Vx8CynmxYxV1VT4K5pK0jCRTkkkoJh1ygz07T4gduEG3YEHrbYmgo7SV6PVTkqihZcfQ2ep+oHqsP113MkkTpDOnBAlsh3hg==
X-Gm-Message-State: AOJu0YxO+Uda6BoqJYAgVjRsjR1UCs3+CE9/RWf8h1bdR1P8okSn7ez/
	u9vMJpeUDZi7QbuNwKn637MrdAhItdhLa8D182kLX4/BHGDxrN0=
X-Google-Smtp-Source: AGHT+IFxk01mOm2Vvy86LGflkR3CoOnXMk786Ch4vDnYvFK7m+z+sREVwOABFmNJem1shA1DICE29g==
X-Received: by 2002:a17:906:c10:b0:a58:a0b8:2a64 with SMTP id a640c23a62f3a-a699fab8c78mr229435066b.5.1717620738250;
        Wed, 05 Jun 2024 13:52:18 -0700 (PDT)
Received: from U4.lan ([2a02:810b:f40:4600:5211:58fe:dfef:c48c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6c71bb5affsm72265866b.147.2024.06.05.13.52.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jun 2024 13:52:18 -0700 (PDT)
From: Alex Bee <knaerzche@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>
Cc: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org,
	Alex Bee <knaerzche@gmail.com>
Subject: [PATCH v2 4/5] clk: rockchip: Add HCLK_SFC for RK3128
Date: Wed,  5 Jun 2024 22:52:08 +0200
Message-ID: <20240605205209.232005-10-knaerzche@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240605205209.232005-1-knaerzche@gmail.com>
References: <20240605205209.232005-1-knaerzche@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The SFC IP exists only in RK3128 version of the SoC, thus the clock gets
added to rk3128_clk_branches.

Signed-off-by: Alex Bee <knaerzche@gmail.com>
---
changes since v1:
 - none

 drivers/clk/rockchip/clk-rk3128.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/rockchip/clk-rk3128.c b/drivers/clk/rockchip/clk-rk3128.c
index 40e0e4556d59..7c3d92af12df 100644
--- a/drivers/clk/rockchip/clk-rk3128.c
+++ b/drivers/clk/rockchip/clk-rk3128.c
@@ -553,6 +553,7 @@ static struct rockchip_clk_branch rk3128_clk_branches[] __initdata = {
 			RK2928_CLKSEL_CON(11), 14, 2, MFLAGS, 8, 5, DFLAGS,
 			RK2928_CLKGATE_CON(3), 15, GFLAGS),
 
+	GATE(HCLK_SFC, "hclk_sfc", "hclk_peri", 0, RK2928_CLKGATE_CON(7), 1, GFLAGS),
 	GATE(HCLK_GPS, "hclk_gps", "aclk_peri", 0, RK2928_CLKGATE_CON(3), 14, GFLAGS),
 	GATE(PCLK_HDMI, "pclk_hdmi", "pclk_cpu", 0, RK2928_CLKGATE_CON(3), 8, GFLAGS),
 };
-- 
2.45.2


