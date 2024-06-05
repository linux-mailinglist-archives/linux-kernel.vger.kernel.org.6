Return-Path: <linux-kernel+bounces-203205-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CDB168FD7DC
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 22:52:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E39461C23A95
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 20:52:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 532B915FA90;
	Wed,  5 Jun 2024 20:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O0GG6IiM"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16C4D15F304;
	Wed,  5 Jun 2024 20:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717620737; cv=none; b=Grf3h+Ho0T6B9PFAQy3QLnDgGFzeeGGDokQEbFMblhYd6XQrcsrUI0/cOJPVBf5vIEqDO6zMf2fva4mbVsLidbifF4bbfRNlXjPB0rpUYyfIXJz5qg0YMwb8LExB9ySUK90xJSVf/+TJW5mWtO2gneD7axgObPTscZRLAxcbSN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717620737; c=relaxed/simple;
	bh=Au9iWsVMPpWPvAI260SLmfTKId8+c/JwL4nXeMKMoC4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=omUwvJCI8eBlMZZ+Ni2pjCc1COxfaH1NJ3DB7zuq3dG5Xf/zuXAu5HPi2iF2E3Sr9TytsV6qwu56Be60CmpRbIQpKhv16OoNN/lEpB/ducjrYjwnF6KhvEIkZ0nOrK4bp1RL5UIuDrolvn8gHxX4UoRaZeMqM+Ztaw2qWrWz9rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O0GG6IiM; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a68b54577aaso27430366b.3;
        Wed, 05 Jun 2024 13:52:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717620734; x=1718225534; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x5DqSnKeWsYvEazcs2KZiewpru7ofXBIBVWU2Z9PCjs=;
        b=O0GG6IiMTNPAZcYVEiDjCmPADOhmb0PV3lbhWvydV6pE61pYWPNh+BqeK+r345x3KF
         TZDNoVgUyECu3YBRe1/jq6PHvK19i1o43ag6ZOMrdlMfZKenGfZeVzLuVX81gX/w9tRv
         3w3TfXIN/CqXFv4y16nQ3l20ZdNZ+/MJvZW0X99D/WpUP1rJE2COVqLcF2xf39YgU5gF
         JLa9Ea7ND3PHBVYiqttYZ095/YooaGm+PmUvDuE9/7M39f6rqM5s5oU7GtolBt5i6tEB
         WmRa0u75Sl4tACHk5ftWKvMY67N4p/32zStDmmtCu2fOkVwbsNKLPlja0un4LGCcDMvF
         Cc3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717620734; x=1718225534;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x5DqSnKeWsYvEazcs2KZiewpru7ofXBIBVWU2Z9PCjs=;
        b=DabfBQ8AmS9887fKMJiZ038E2b3oNpS2h42g2NILe6vtva/3BDXMzdlxat3mTRgZAv
         wlT+okYaodD46UhJ+BB1Jtw76PeQrs2nXc4FD2Pk1FJpJYCwS0xqiOGfSZYGDK4GEYhR
         sCNzf0Enn4GduGUIYVP3iwj4isp2Na+6qYcTZVZOD2+YU1y0XavFMH9DzQm9pqgn40Mr
         DE3nL1/SsgK2zsB43KkbjKqGVCLOOD9aKcKPWTKM3NNYd4th0p1MFTLiMXiCmqxgWIFk
         ex37wW4sph36UPwsvyefpqstwwp5Q8+Ca+0mTnOgM0wqj8308AOm24YxhrSJVLgCtHR0
         YgjA==
X-Forwarded-Encrypted: i=1; AJvYcCUlTGhoxZpYlTp51N2U4Rh+9eyv2NhPs6i1OWXXd+fzEygrkdeHk1QGkF/uk4J6BBXUUZvWMawCf8LaqOgx5mBm8rSXcEnubp+dfCbaxbY9watwiStyTrtYkSrWx00616XwYgwev4Vsomk61cGrI2rMb+xfTxgpkbr1qW30F5DX3jj/FA==
X-Gm-Message-State: AOJu0YyD8vPHbO1bwMqIf0aL+c/qbYHolx2M12qT2B2Duoc81ItOtI9n
	uqznUIznrCPrjfwEu6uQyh5rhPYdzY1vnkrvpOYZnsm4+f3PefA=
X-Google-Smtp-Source: AGHT+IF+x4ragnpopQytYvP+V4rZUBOA1cYWVwClyFdv0u225FZrcMfyOsFfMVyB5JJ7IkfFk4MVtg==
X-Received: by 2002:a17:906:368f:b0:a68:fbdb:728c with SMTP id a640c23a62f3a-a699f55f75emr196312666b.21.1717620734296;
        Wed, 05 Jun 2024 13:52:14 -0700 (PDT)
Received: from U4.lan ([2a02:810b:f40:4600:5211:58fe:dfef:c48c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6c71bb5affsm72265866b.147.2024.06.05.13.52.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jun 2024 13:52:14 -0700 (PDT)
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
Subject: [PATCH 4/5] clk: rockchip: Add HCLK_SFC for RK3128
Date: Wed,  5 Jun 2024 22:52:02 +0200
Message-ID: <20240605205209.232005-4-knaerzche@gmail.com>
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


