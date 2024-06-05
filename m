Return-Path: <linux-kernel+bounces-202972-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 01EFD8FD3E4
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 19:22:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 942961F264F9
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 17:22:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7392913A89B;
	Wed,  5 Jun 2024 17:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iBi/Bd3X"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F94B135A4E;
	Wed,  5 Jun 2024 17:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717608120; cv=none; b=q/pUyTCj/2xTNWn5OJ3A9Mds73fIlO9joV9LhPuNaQMddBpthZiOmp9sJxkaD3nNAcL5U3clOS82ovEdQO/i3ty4TC47e9dfz98z5CPpnYHLET0dCL0DAsY+aSpiaYGgxxNp4FK9G7VZyCIqvWkFbH7EPT7W4E5zq8exGcdKKvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717608120; c=relaxed/simple;
	bh=sKCWCjQzJ/5JDuC5yzwop0fiSfCOQHeNvImg7V06GKc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nGcCLn4BK7BlyDZv1eqC99d5+Y9w67OZF5uvNX4jni/gJjK/IhlcVmZ+ZZVXU+zxSxTkL/As4QRMArVunD4M50ilI8RhEknwAYniL6Rij2IMxVd8HaLInXFYEzSToUlvuzASFA0D1ZrCZzC5Ruiao5zoPTBS5GUCYvZGl1ylGWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iBi/Bd3X; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-57864327f6eso19855a12.1;
        Wed, 05 Jun 2024 10:21:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717608118; x=1718212918; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pVMnvdRLLOzxKbJxJDKn1/rJgxuovT9+MlU6y9jorGs=;
        b=iBi/Bd3XEzgtRWSCZyTn9c95ftftNr3h7YKmwqsqPugIueMdfpjsXrNbpDhM7DF0O6
         7sb3kvDiMFk2BslpEBIyua5eNz6G5u3QjEF3slL+CaPPeUa2uq4rZ6iUodec4AoAzjHE
         y5U7doci/agE5KjRFD5QOgdwGXK/tUNspzRbskg3fZccg1Ifj81RtdRugOycnQP1Zs6p
         7LJGpl/etYryN+gvYaaYf3Bs7iAlYGetkCzwGg0K2GwC5NV0LpwkfKfeQ+7/Gf5aIUMl
         J6YukIIfnHMyzFf4/RJB6Bt+JGCYeyudP9fcgt4Oj52qtT3MzKvuwXrmAmEypHs4fhmP
         X77g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717608118; x=1718212918;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pVMnvdRLLOzxKbJxJDKn1/rJgxuovT9+MlU6y9jorGs=;
        b=DokK7Zvcev53Hl5C6nE5G9osnT3gnTQoYaYyyNagEH4w7rGNszLZDJntKVO6LNgXqv
         jroVkNtnmKL9OsfH5TS8MTOqSdKcv1GOu8hx+yegxsCDnuezobTjzmXCLxRDFMNCJTFI
         8uduTdI6W11X5GjYGwxAdniXfCTaDm2KjlGWrqR2t5XWYarJTJOvyy8y/xAQR1BJ2hq6
         eYimTibsT7qg3NiYPzqY1NqMM2YN6bsi9KDGM0FTU1zFVNahprLRLryoYwJa0Gerte5y
         Xpnu7TFwI8GNytPPBviDQBfaUYRv5k6iXQcA+jwPB4FaadbPc7vzt+ttpS8NkuSjzGiH
         FHuw==
X-Forwarded-Encrypted: i=1; AJvYcCUeCofADER/qx+IWIX/TjUSY4hB7c2Y66CayHZTEpSNaEJHfNbnyX2aIpKDXMey7ZDv1a+i5pf3J0da+rGXxJmxFiwmW2FdKYHPO1wpBAr8++rpdEJUOK4H7u0yQOzCWXW45jrnBzxfa5N0jgMPn4m96r6jg8buLJpDgydLGsdVL928Gg==
X-Gm-Message-State: AOJu0YzQecFvBO+iadbC74/9kr9gVkSzE7sEDs1nuR6j5L35iWRHLrES
	IzIflIMjcBzjhnL5dEUnpI31UQTtFbZ0/stNLl0ABEWpB5WhwcA=
X-Google-Smtp-Source: AGHT+IGe9TdL6YWvc/w9P1sfcG22dIIUJ0rcy3GeY94VNXeYXkoTK6zLc64eyd2PWUCAXcw/orFicA==
X-Received: by 2002:a50:d74d:0:b0:572:b83e:e062 with SMTP id 4fb4d7f45d1cf-57aa53cd286mr276083a12.3.1717608117415;
        Wed, 05 Jun 2024 10:21:57 -0700 (PDT)
Received: from U4.lan ([2a02:810b:f40:4600:34f:df25:1c86:f2e7])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57a31c6d594sm9666663a12.69.2024.06.05.10.21.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jun 2024 10:21:57 -0700 (PDT)
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
Subject: [PATCH 2/3] clk: rockchip: Add HCLK_SFC for RK3128
Date: Wed,  5 Jun 2024 19:21:53 +0200
Message-ID: <20240605172154.193047-3-knaerzche@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240605172154.193047-1-knaerzche@gmail.com>
References: <20240605172154.193047-1-knaerzche@gmail.com>
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
index d076b7971f33..bc348fd0da92 100644
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


