Return-Path: <linux-kernel+bounces-203223-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E3768FD808
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 23:01:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2B9428788C
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 21:01:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C02AB3F8E2;
	Wed,  5 Jun 2024 21:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lTu2hcKz"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DEE515F400;
	Wed,  5 Jun 2024 21:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717621257; cv=none; b=EmwspRITSmbUlVXtxcpE02coaBC00FWrnNO0YEzIEZLBtxT7EXWIopnnx3fvfZZ0QzqH7oNlRduLsHUYKVb0+VLKQtH2eRUxW2ywPO3+t0068QrEGoKiNoOVW81ul9mC4vYmT7F5IS11s2DZRVWrLTy1gTEO3vjN5al3M1zInqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717621257; c=relaxed/simple;
	bh=0hQOg06m6hCRZq4aIk0CQ3974f7/WXPRwvQqm4cuKP4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aSBgVJl49XAnjMWZXwVEiuLUPv5GRR6leJqvx0D+5gIDXxMFiiBCSKxij4fHZqY7gPWw+hVp5SaA1ZefBqyNqtM8vdYOBC3BCxXwLtvfXtomqrldh5mOuItzRZtdCG+hK4Qlman2rNONOeMRsI+EIapReWmUDDWz7NRFD6V+BKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lTu2hcKz; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4213b94b8b5so3554835e9.0;
        Wed, 05 Jun 2024 14:00:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717621254; x=1718226054; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fk9rPd7/DZbkWMr4RLdz9e3yLOVFGIh3KC1NJKidnyE=;
        b=lTu2hcKzXakAfOwW0aTfK8jGax7t7UXlpsV7aFPSgmbviBpmNZ/BlUAgFn97NacqVZ
         Ef+M8MafmJJwHbkb7fOOelebCuH224PbwRLWWVnJJtuk0aah799bZeMgyr8Qilzx+Twt
         ATgHouTUPpeAu7Dy1ZT+4uc6fqr6BcjJDosJ5iMJbz8ZNXfOcElpmAt8764qzJTm/4kM
         2rsevwiL4pRdNhu4bdiTfxkynf8Wna5P9xqw80BVbeB7kuAoyFBell4PU3jKQ8cRONkF
         R3UFnhXcrPoPpLnctdkfqbLOeLtycDk9g/HXJPClCtP0/dB7YLf5/Qm0V3+k2COImg1s
         mEag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717621254; x=1718226054;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fk9rPd7/DZbkWMr4RLdz9e3yLOVFGIh3KC1NJKidnyE=;
        b=Yb58q80Mrb/g4MZv7znKg9Ly4mp3w6mItt51pGhUb+73xG0kJhi0pUZXgxiMFNyXQ8
         vctWTkKPAjTXWWTuaN2FyQISbHmC5ynH4Y6ex23gtj4Qyqb3H6UNPmwSTKM8YTIMVHfn
         PIB2VJvB70TjaS6DmnviJCWztqw0xDOWrA4ZIMmkixM+BkUZJhK7gsinNNO+3xXtPw6F
         mJPeblvYN1D6Qk75AqK5YIQi47WIgPpK8QjEdDsVHIXkMkJvPHxocU9XSEZlDFKAJrtH
         kCO+UG2qMJ3zWMrCu9YNZfCxupY/+djIIHz04wAtEOiFqfVOUcFQLhq7kX09ekHUHTTq
         7jVg==
X-Forwarded-Encrypted: i=1; AJvYcCVrr4GnhtTlCs12/c9Kk7u2RVjrX9o81g4NeBOMF4ly7K2Ja0NAysVGiIeWfh+BznLlBOwpYPZ6k0nZ9NHHe/RMvkBeduaHsPjBUAIaUzdw3IdvClyCgkpQkYEWPTVyysirmaUkukBY7dUyA3YqLmuwsWlrlmjMPSLqJsex+EFiPhPOpQ==
X-Gm-Message-State: AOJu0YzDQTR7ZO8Ov5d9daFut9T+GAUsXYoNMh+N8cbZlwn6jG+BARu+
	G0xF9Q0c2gvC2orAfkAc7A7LYp9cTaC+SJzJIOQVlWkSpMan7jE=
X-Google-Smtp-Source: AGHT+IEzFnF+ZiqUZD6IAFUBc9JkLG0/nVhzj+suO7W+KygvluwYQcTuVTP0MA1/SlsiCkafZG+2rQ==
X-Received: by 2002:adf:e847:0:b0:35e:f3d0:e10b with SMTP id ffacd0b85a97d-35ef3d0e34emr92878f8f.23.1717621253590;
        Wed, 05 Jun 2024 14:00:53 -0700 (PDT)
Received: from U4.lan ([2a02:810b:f40:4600:5211:58fe:dfef:c48c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35dd04c0d77sm15955721f8f.5.2024.06.05.14.00.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jun 2024 14:00:53 -0700 (PDT)
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
Subject: [PATCH v2 4/5 RESEND] clk: rockchip: Add HCLK_SFC for RK3128
Date: Wed,  5 Jun 2024 23:00:48 +0200
Message-ID: <20240605210049.232284-5-knaerzche@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240605210049.232284-1-knaerzche@gmail.com>
References: <20240605210049.232284-1-knaerzche@gmail.com>
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


