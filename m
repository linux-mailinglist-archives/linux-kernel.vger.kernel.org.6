Return-Path: <linux-kernel+bounces-438687-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DB6A09EA462
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 02:30:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 054321882049
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 01:30:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFE09148FE8;
	Tue, 10 Dec 2024 01:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jl+35DYE"
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A61AE70821;
	Tue, 10 Dec 2024 01:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733794231; cv=none; b=Hbc123+OK2A6mmy5vW9fvrX/7sbbbufyYFY8iSdNxaffvzW5l6lJh1vvu+o/WJ7EPz4rpYdh4enSggl0y0xPBsfhtM8sUU+Z0XdTKeV/tkdFYdetG4sOp+Lg0xb7ciaIVQBu8MJo2dc79njiH+lk+OoGOufzHpilmEGH/WRi0N4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733794231; c=relaxed/simple;
	bh=Dzs3B7MIUzasS8NT6pMEAG53wjk3aUUcR96wcHK22Hc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sf9wb8yn7y+RQGDemdbFmHyFHQZGtbULPP0m6y6Hd5AUGLjLB6hAeShLYFu+Uu2hXQqBCPgtUV5CROtFWHBZ1mIjE5UjyH9/l2ki3c+lAQyOzDwlM852zzO8+ySf9r7m+qrEPZgx38X+KFTlEylM5NIGHGxbfHHrXGgjWwUIczY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jl+35DYE; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6d87ab49423so49438976d6.0;
        Mon, 09 Dec 2024 17:30:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733794228; x=1734399028; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZbMZ1XEGG9+iR89acIoDRWlRdmkKPe5qHYKAcY8LBOk=;
        b=Jl+35DYEfVogm58CPyz4HUdFoeeovtj0hJgIAbi0VKU/TnS0nke2YVhQrN5daU2j1d
         cqnrvFYG3fKuH9MNLqwHcWMXbt5N9HBL06dyEMQCF0nc1qS4AXn+6kyXEkK6l35mn5yZ
         cg3Qf8LlwOedF+0chwR6xICTHd8YQk4VENe6VxUz3YZFylakUo+uaWjt9v3A4roMoICq
         gK05EjWBKt6Vpu4OLqzhHUrHHe6Tp2yXJ5kOG3o7ddwZD2iJWvjzuxc4p/qy5bh8IWE9
         24lfVpPGxzcYOAP3IdrBgde6dSaPV00jpxltD1HkzwqyZRlaW1zWy7acJV5EbLj6+9jq
         vvlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733794228; x=1734399028;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZbMZ1XEGG9+iR89acIoDRWlRdmkKPe5qHYKAcY8LBOk=;
        b=qI6nWCMwkeYc2jnC3B5o7l/ySeDhqNvYCt5w+Vc4iMJ5BuS1Yc8Xcp/oBCmSMu7EG9
         dIzW2UqFKNyTbItavSjXMHTIhojWMWDlOYP2UEMOkd6/ODWqHNJBKPC9Yx3Rn76HcpIP
         81cFvJwzmA0gwrdXTKY1zrPvTXUdY71saqdraLg71eShdqhDoEs7rCE6XZHQa92Utodn
         NjmnUmFoPzftzgQdihzPu9kyLZFbJMBXxZrWqfBxPsxHY2qRBKpu7Ch180a8+zOmK+p/
         LGGQFYLh3Rz77bpO6ACp5ikgMGfgZ7gmPZCslbp70cMoN7BwQGuBmXvKeUS/+jlPN0dC
         ibvQ==
X-Forwarded-Encrypted: i=1; AJvYcCV0vE1LX2dseg+J5zsObQXkIu9nuo1l9TKBdW6O8OHQR526BlIVABdba79amMz18ZXGJ4pXeRHwgcc=@vger.kernel.org, AJvYcCXOH4diWMiKhLV6QJctv1sjBR+fmYn6MEJo1eYFIp+TXn4wpg74S/2Pyl7XZ8TOuBqOGhw/QKT1qCxZDkwm@vger.kernel.org
X-Gm-Message-State: AOJu0YxMN5r0zqp2yJa2xzU9uh3zZubIg87H1sAzzlPInuGfptjtdy5/
	EAGMMvaKj1WXCYIUEcWEal0q5c/eblf4NTMZiBMf2m8FWmwP3AjzKGMQSy1e
X-Gm-Gg: ASbGncseXRyoLBVFWE8R3RVw2cwWhEnN5M8molpFbwd7lVZjEXBhkGrfbYzay8sAvAm
	vK9PzeLf8M+T+POONFyTSnsXTIaSkeJwJvWLfCSKP0NQfpQfh0F6g2Fom+Iw46dV3nTWiGBtxGX
	GyI2/rZ5XPQ98jIC94SMf4gMHDEBtRCoJIt/gEqCVeZ/a1P9ndOuTudTQgDqbQEZ45/n1f2ClXH
	ijJ0JQuBT1f5e9Vn3JeNu8wDqNa6HU3V5PjpOctH5nHoyzATPnzH7m1nPJDRjBB4g==
X-Google-Smtp-Source: AGHT+IHtWOPd4M5xIQAtOFMGvJ2WXw5oVrlCvjGb1M5Y3tJlywOZoegb0SMUWVqBgkFNZkQZZVQ7Og==
X-Received: by 2002:a05:6214:d06:b0:6d8:850a:4d6a with SMTP id 6a1803df08f44-6d91e2d2bf2mr47042826d6.1.1733794228302;
        Mon, 09 Dec 2024 17:30:28 -0800 (PST)
Received: from master-x64.sparksnet ([204.111.53.234])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d8f429a79csm36834346d6.72.2024.12.09.17.30.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 17:30:27 -0800 (PST)
From: Peter Geis <pgwipeout@gmail.com>
To: Heiko Stuebner <heiko@sntech.de>
Cc: Peter Geis <pgwipeout@gmail.com>,
	Elaine Zhang <zhangqing@rock-chips.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rockchip@lists.infradead.org
Subject: [PATCH 2/6] clk: rockchip: fix wrong clk_ref_usb3otg parent for rk3328
Date: Tue, 10 Dec 2024 01:30:06 +0000
Message-Id: <20241210013010.81257-3-pgwipeout@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241210013010.81257-1-pgwipeout@gmail.com>
References: <20241210013010.81257-1-pgwipeout@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Correct the clk_ref_usb3otg parent to fix clock control for the usb3
controller on rk3328. Verified against the rk3328 trm and usb3 clock tree
documentation.

Fixes: fe3511ad8a1c ("clk: rockchip: add clock controller for rk3328")
Signed-off-by: Peter Geis <pgwipeout@gmail.com>
---

 drivers/clk/rockchip/clk-rk3328.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/rockchip/clk-rk3328.c b/drivers/clk/rockchip/clk-rk3328.c
index 3bb87b27b662..cf60fcf2fa5c 100644
--- a/drivers/clk/rockchip/clk-rk3328.c
+++ b/drivers/clk/rockchip/clk-rk3328.c
@@ -201,7 +201,7 @@ PNAME(mux_aclk_peri_pre_p)	= { "cpll_peri",
 				    "gpll_peri",
 				    "hdmiphy_peri" };
 PNAME(mux_ref_usb3otg_src_p)	= { "xin24m",
-				    "clk_usb3otg_ref" };
+				    "clk_ref_usb3otg_src" };
 PNAME(mux_xin24m_32k_p)		= { "xin24m",
 				    "clk_rtc32k" };
 PNAME(mux_mac2io_src_p)		= { "clk_mac2io_src",
-- 
2.39.5


