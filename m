Return-Path: <linux-kernel+bounces-204492-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E46C78FEFC6
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 17:01:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D4871B2AC08
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 15:01:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0792A1AD9D8;
	Thu,  6 Jun 2024 14:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jfdAiXMS"
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0F7819D09A;
	Thu,  6 Jun 2024 14:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717684653; cv=none; b=jy0d/IHlnGTEeg3HLUa4iElwnaL9pKncqxRDHNCJKi+S6X5hmXmBGhOb9Cyjh168FTH7ClSwQ18cSJfZtQUijeCpE5BV7G50o+7jXmbN7FhaXpKsOeGLrFeh4z/DtR5nDbBKHMn3F7/rvDCYCBVKSq/SCK4MWhFQhuO6bETxesI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717684653; c=relaxed/simple;
	bh=0hQOg06m6hCRZq4aIk0CQ3974f7/WXPRwvQqm4cuKP4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dqVlyH8+IZc1JLiGBejSSMmPGOSGA01wXskr0HzXV7NtFXH0EPQNzaj05KN8+hJznoo+p+3lXLn7XTvt/t45npY7g2jgDtlhtP4YcFRoQsVdKvlDTDPCsyJZ+e0z4Yc2FlB3+88W3u9op5mPuVCkmYXDaOYfNvrdhGq98kzFI8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jfdAiXMS; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2eaccc0979eso12719931fa.1;
        Thu, 06 Jun 2024 07:37:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717684649; x=1718289449; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fk9rPd7/DZbkWMr4RLdz9e3yLOVFGIh3KC1NJKidnyE=;
        b=jfdAiXMS9jorhEntYNCVnh7L3neQg+sAAKsEdeGXQU8PC5zMdwLzJL7s0sAhIpuhh2
         Bd35zzyPoLEhDy9ODGTtDKnisetcL6J3ZA6KJvoVOsCTCGpWrmtxQ1yVPx0WbQ2+lDvy
         QniZZVYOvJKka51bDfCB7PzkqlIVheerrfYFYryUcA7WjYDYLLQTSmeKpdUXYNr0p8jw
         W9qAddvXOmx6icVz5Y10XI6sFG3+eMThdZ6Jr5RDBXs8v79tlrvLi0WdSTWOeJHOTj9X
         WKmuQ6t5MfbdzIP8KbvCJs6nMfbogyMvHMZonK7qLQjT/UT4kfL4xDK9kt3gxAjlDuYr
         rPiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717684649; x=1718289449;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fk9rPd7/DZbkWMr4RLdz9e3yLOVFGIh3KC1NJKidnyE=;
        b=xHmCn6g3teCc7pI2yHIOWTOSWHrXpHOzNrqTV9+gO+/okdo2glQSMan7MIbyuBOZDY
         ryjS9xspVhY3CpyU+6fNKN5v/F53ZeKIJ0qhfszR9+h7SfFCHiIW+OR40oOFNVFnBslR
         JlMmOFQwTjFDVwJeTU4v3WKqzJs0DqN/jcWJMMgf6Gu/DMP21QARadQ748xKoplu+zRM
         pOzbq9r3Vfl5+vhEeGdHFuZgzZlaxw51/4ncHTqU18tJc+HxDUyfFrSvUtcu7HdcnYq1
         4hEzKmgQX12TtCV9yqlpRpRnn9zIgaqOkcrRrekO5EA7f40Jz/FfURI9VKmsgC0HwnRY
         Y5zA==
X-Forwarded-Encrypted: i=1; AJvYcCVvTPpAVQPialERoBmKmwT4QS/G86wqpksWpPmZaFhu7bVJUPUzosB5gMElLdsfCmOxXgjes/F3QgvmFnmEUw+t8FgKgCfG+9yaD/pbq5d+SpLF5AZnsHje7Msfdhu8QAvow+nAhGn2VPBV0xEIYq9YvNbmo+onEBj1aDt7ZN3wne+iRQ==
X-Gm-Message-State: AOJu0YzgEWKvyB/gurhegjc1fZ+CVbQ6EjFgkP3uHghJufV21atK+4kv
	rnd/tB2iVN+mX5tcA2D1ww/FIsiwdCgJtTV1evNuF1wrj60qtMpWPQxn
X-Google-Smtp-Source: AGHT+IG8owqtLInvHSMcTogX+8tbyB5zZGMHSBrm8ZaQaQLzzEArYPr/Dm2UILk8RcGLuXsPT9EyTA==
X-Received: by 2002:a2e:b790:0:b0:2ea:cf86:c0a8 with SMTP id 38308e7fff4ca-2eacf86c218mr18265491fa.37.1717684649040;
        Thu, 06 Jun 2024 07:37:29 -0700 (PDT)
Received: from U4.lan ([2a02:810b:f40:4600:ed9f:91b7:21f2:3109])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57aae1008adsm1190925a12.38.2024.06.06.07.37.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jun 2024 07:37:28 -0700 (PDT)
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
Subject: [PATCH v3 4/5] clk: rockchip: Add HCLK_SFC for RK3128
Date: Thu,  6 Jun 2024 16:34:01 +0200
Message-ID: <20240606143401.32454-6-knaerzche@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240606143401.32454-2-knaerzche@gmail.com>
References: <20240606143401.32454-2-knaerzche@gmail.com>
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


