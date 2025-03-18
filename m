Return-Path: <linux-kernel+bounces-566731-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 14207A67BD6
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 19:21:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A483189E892
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 18:20:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CD12212B2F;
	Tue, 18 Mar 2025 18:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XRQfEUAS"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44154207A01;
	Tue, 18 Mar 2025 18:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742321988; cv=none; b=n/NeFQQTjoCY6YcRxrLT9TKzuuH5vMWaPo4cxCj6nwr9AQAGPyrhKKycRnDiC2SiieCDR46IrGylaPpz4kT6Enk3KMq8/1LdECq5GfKwr5BfnygWnealj7yoGgSFYpPyiavOkIz3HaNKtINttHCUYC7QbNNZuzLdXbw9ec+sZqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742321988; c=relaxed/simple;
	bh=om5KloElm17yZBaAIJbWQiWoso2TI7yNO59R6Nxlt48=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=f86ty7+sb1SfozY9TZJCnn1gWMrcKySDiMT/T8EfYw90CohvS5Pyko0fPmj6ueOe5n92i6GfghZTkIf5eMXHQW5wOAvZ4QBCvFtBsmNAqgaDLcl2VkgIsDzLBsWBp9EGUplz4URLle2vU0+gGSmzav6utp9f6UkdpLZPACj4++M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XRQfEUAS; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-223a7065ff8so21694505ad.0;
        Tue, 18 Mar 2025 11:19:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742321985; x=1742926785; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IWXXj2vpA8WsbFi0qPRvWIGgICG/QaRDC6OXeQOYQS8=;
        b=XRQfEUASBEjDRneQlzfhpssFTEuLqKhsNxW+XmP8ReImsfp7YXGfL8hadLMYMsbXD/
         OCuJgjqAoNGyIWHRzWZazk0J5ysmnPzKYKg8XFOPrYJomgpU8tblKk1m7WKvbwinZFRt
         hPbiP1pWMVgNClf88rYCqbmjgXB4ERdklc25cm3xkxCu3faB1bD1MBHp7Sv1Up/YYjn4
         vEIeTOBITgaGip2LrIOLtQQhJpC+Wz6p7SYDAzsLlJmyq34VV9QvghAsm/k2Adjb/zZo
         c3Zz8oLS80XIbCUv5KZ1U5H3bqzQL3RvO69EXaoZY6zHfFhqBtsM3pUYPenFAZ2gN5z5
         qxdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742321985; x=1742926785;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IWXXj2vpA8WsbFi0qPRvWIGgICG/QaRDC6OXeQOYQS8=;
        b=Ys2nyW2JDjOWLoG/IAd9y9KRA+8ORNvk4QygdX13QNE/KVE5hKjo1gGd0OV20YcQYL
         8RYoUvWn6yVq8DeGCcJvuxI3BNUC4+JrsZ8ZO9J8MmGOXU9JIBQk0vOk9H96wpzMhfOb
         25rnLvoFGt3vpLKly4OUYdvkhxJxlsFMQfr9nd/c4N5iLYwV9ySepGazf3P0cneikDQB
         EITGrfLKmuiShPMZJBsXvzgeerpfVPzhJyWEewQizTjlkFoH0zOE3929pEXeXPj96FmP
         j5MLT8L/re2Qr0hy30XMXeGQNK/zFMzFVZbUGEYpnnxDdONGCYgvBr7RYPr4ZQ8tHRpL
         MyjA==
X-Forwarded-Encrypted: i=1; AJvYcCU4RocOFwcuetneg0MfupIt49KLc3Px77xmnmS+PYpMLpBzUYx9B3dMf4kBW7dOpUYWa2GymTL+6c0=@vger.kernel.org, AJvYcCWUY4iPo0DhbELCntCEQCe2WrQwn+VGRcW25kD5MZr1vACT3iO8IQMmCJd0XBHj7kuRdelja45o8oCe/Dhy@vger.kernel.org
X-Gm-Message-State: AOJu0YwqWitjj6lbmCgTgNJcYdx2Lz3TvLFgM9tfEAhGRlR1SqDCETN2
	JF8vly4MSZeeAW6MWBJb8jg45RjLeqKnvbJOXCUi1Sv2KEybqEtk
X-Gm-Gg: ASbGncsVmjz0kvZ6L9VPh6hyClgRcSMwiPiVITuDa2Gelo0xiTyzvjZy33OxAdfS69R
	ntNG4T7PpeLmfP0Xlk9Jb7lefqt8vCTwHiUdqYJS6oQ44tAF33x73j6NuOO19dd7agbgKDptxpu
	chhfuLLRt+ywqg6U/KY6iczUEVFBJ8R5H82dzJZue7qKGwuSilz/iAB4lI6GBaKW42muHlcwNW4
	fyGA1Xa8fshkHqwYWVl1U8yu0AvGQ4xXpAjOs9gvw4AMfpOVMDsmMLNpq5nArRbMNiT55wlrcfD
	OyasRiymM+CXM3TmVPh3Vnk71IVc8V21zx97ez9qSyzHgr8=
X-Google-Smtp-Source: AGHT+IGy8HRi8t/4P7W6clWm8ulwpmfSGVobi9wvP1Uuzt6DNIeDr3OKASvL0ZL77QVKb0SOfKk4vg==
X-Received: by 2002:a05:6a00:b42:b0:737:e73:f64b with SMTP id d2e1a72fcca58-7376c10cb80mr179692b3a.1.1742321985193;
        Tue, 18 Mar 2025 11:19:45 -0700 (PDT)
Received: from anarsoul-xps15.lan ([2001:569:7d4f:2900::398])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7371167dee2sm9887838b3a.111.2025.03.18.11.19.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 11:19:44 -0700 (PDT)
From: Vasily Khoruzhick <anarsoul@gmail.com>
To: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	linux-clk@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Vasily Khoruzhick <anarsoul@gmail.com>
Subject: [PATCH] clk: rockchip: rk3568: Add PLL rate for 33.3MHz
Date: Tue, 18 Mar 2025 11:18:51 -0700
Message-ID: <20250318181930.1178256-1-anarsoul@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add PLL rate for 33.3 MHz to allow BTT HDMI5 screen to run at its native
mode of 800x480

Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
---
 drivers/clk/rockchip/clk-rk3568.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/rockchip/clk-rk3568.c b/drivers/clk/rockchip/clk-rk3568.c
index 53d10b1c627b..1c73e18a9862 100644
--- a/drivers/clk/rockchip/clk-rk3568.c
+++ b/drivers/clk/rockchip/clk-rk3568.c
@@ -89,6 +89,7 @@ static struct rockchip_pll_rate_table rk3568_pll_rates[] = {
 	RK3036_PLL_RATE(96000000, 1, 96, 6, 4, 1, 0),
 	RK3036_PLL_RATE(78750000, 4, 315, 6, 4, 1, 0),
 	RK3036_PLL_RATE(74250000, 2, 99, 4, 4, 1, 0),
+	RK3036_PLL_RATE(33300000, 4, 111, 5, 4, 1, 0),
 	{ /* sentinel */ },
 };
 
-- 
2.49.0


