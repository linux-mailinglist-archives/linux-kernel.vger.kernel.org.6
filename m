Return-Path: <linux-kernel+bounces-406982-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 44C6D9C670C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 03:04:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 64B52B29369
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 02:03:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05AD8433CB;
	Wed, 13 Nov 2024 02:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZYJwWxKW"
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25C921E492;
	Wed, 13 Nov 2024 02:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731463386; cv=none; b=eI4AAq5FXjYId5bRmxeihEle5qp+X6JpE1m2NaoaW84uwJY2eqPHR+NkxNbECjvsM66aVr6jYvfy7ZpkaHU3fYpSmnaUB/tb8KODQXfkxN1u5FzeyXfEji0JEWJ6itIhDh5dM8R6L2Rt0cYMD1Y3992Ll3edN2r6pkl6K5Aa5vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731463386; c=relaxed/simple;
	bh=+VIgjIJOirlo5MrVPcyFsmx8bky0o60JNc3JpzBhMwg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iYWQ0r7ip2YIREK+dG3ASg7p7b6xblaGrFWK+6sYSZ53qOmZx+n/JcKoNRNn3Ae1Cgd6IenZD1BhcPwDgRjE81lgPoHxs3/eUSqZgY/uXLmw+MYRbg/1iIcirHAPjnMkB0aJUOQsowP8vzwyHeKsc0rraRJLrKewIis3VRn5JaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZYJwWxKW; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2e3fca72a41so5105720a91.1;
        Tue, 12 Nov 2024 18:03:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731463384; x=1732068184; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=svAueh5ZWoiZMcD0xRpT+XvBXqQWeB+3wuT5pYyYv+Y=;
        b=ZYJwWxKWN4ZmmVzKCmBjpWm3oUS3v56RBs3/4zROUhesfw6jucusvWmn6+Hgfd7GXx
         Y+WKDqlRgBLVmAv2ZTvPO4o4znUgvxm8jzerdHed1xXUQVTCyILNxW+4hHV9nRHGQuX4
         p254ks64YIHZokwimfGplPse2zJ2lhKq6cWrdYqepuSCK6bdl4ep58wZxw4HWbV25Jyt
         klWGFljXPiheGMNCGXs974U5kRWRdrFrw/2CfqreUWC7azQNgxPq79GSr6bVeHRr3tcT
         uXWugjvyyaKYwF2LDYRh9Aiy4IxFBqjr53KV5uM8q0qnD1YTAD6y0pOcV2ejd9Ue6vZ0
         AbyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731463384; x=1732068184;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=svAueh5ZWoiZMcD0xRpT+XvBXqQWeB+3wuT5pYyYv+Y=;
        b=bO7NLkwLR3AN45VUC6bMzITqTOncKnPl2Jxff1E2VYiXkCiU2+Vv9uO4bkhlSjKLXW
         nScUN+sU3tt9tNSmwrLe7B0ChI3nVWJRfM4Shw13FZukxGU32BklQAaFbPiqh0nC3ECT
         LB9MUtOpmjuY6/Y2tMr+ZAORVKzeu7ax7xT/xCPSM63EWhduTHfocpFwPlk8VRB2bo+o
         fs/VcIbrxgi1yt9II+GlT2N7ojbKZT5nI+BSt/EArOuLAYv1iDxdObPImjJ/xekRkNGD
         790M3vM7VM9aNrBAcQO0dkMYoqrAdWto9JeeRbjYE7qGX6Jl2XHgYSodD9D9SZLCNISq
         ESIQ==
X-Forwarded-Encrypted: i=1; AJvYcCWQSDlgqRgk9Ij9KKM+b0AKGS4jpYXQKcnmilB9YGFjtlAISvzx8jfCljyQ9LABHakUyzO8fozFk/RLjN8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyDdg/y0jMcvJ57ZZu/b48Vkm5guKlvAmJkFhNjYCbXFqkOHpM
	X7UAxwqJtV+nDymQIRa7ZaYAiQNcUl91o1hnwXBotTD1B73D8Q88
X-Google-Smtp-Source: AGHT+IHC3Uk5Mw6fa8aAvfMN66RKnEDpnVe78zcdp2V3UKYV6391335t55cRjD8qkrbTVJ7UBo0aDA==
X-Received: by 2002:a17:90b:1dd1:b0:2e2:ba35:3573 with SMTP id 98e67ed59e1d1-2e9f2c900b7mr1566916a91.20.1731463384264;
        Tue, 12 Nov 2024 18:03:04 -0800 (PST)
Received: from localhost ([38.141.211.103])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e9f3eca101sm273582a91.14.2024.11.12.18.03.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2024 18:03:03 -0800 (PST)
From: Ragavendra <ragavendra.bn@gmail.com>
To: mturquette@baylibre.com,
	sboyd@kernel.org,
	unicorn_wang@outlook.com,
	inochiama@outlook.com
Cc: linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ragavendra <ragavendra.bn@gmail.com>
Subject: [PATCH] clk:sophgo:clk-cv18xx-pll: fix unitialized u32 variable
Date: Tue, 12 Nov 2024 18:02:33 -0800
Message-ID: <20241113020233.3646527-1-ragavendra.bn@gmail.com>
X-Mailer: git-send-email 2.46.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Initializing the val variable of type u32 as it was not initialized.

Fixes: 80fd61ec4612 ("clk: sophgo: Add clock support for CV1800 SoC")
Signed-off-by: Ragavendra Nagraj <ragavendra.bn@gmail.com>
---
 drivers/clk/sophgo/clk-cv18xx-pll.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/sophgo/clk-cv18xx-pll.c b/drivers/clk/sophgo/clk-cv18xx-pll.c
index 29e24098bf5f..04a0419cab4e 100644
--- a/drivers/clk/sophgo/clk-cv18xx-pll.c
+++ b/drivers/clk/sophgo/clk-cv18xx-pll.c
@@ -87,7 +87,7 @@ static int ipll_find_rate(const struct cv1800_clk_pll_limit *limit,
 
 static int ipll_determine_rate(struct clk_hw *hw, struct clk_rate_request *req)
 {
-	u32 val;
+	u32 val = 0;
 	struct cv1800_clk_pll *pll = hw_to_cv1800_clk_pll(hw);
 
 	return ipll_find_rate(pll->pll_limit, req->best_parent_rate,
-- 
2.46.1


