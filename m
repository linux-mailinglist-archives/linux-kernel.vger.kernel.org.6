Return-Path: <linux-kernel+bounces-249197-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 43EB792E857
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 14:34:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D5A43B217B4
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 12:34:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27CA815ECCA;
	Thu, 11 Jul 2024 12:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="reIq8+ku"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE23D15B964
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 12:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720701254; cv=none; b=ZxO3mMPS/SneqSqEhdQpu5pfVR60xMmZfeAOB57H36pluHKM0jaE/quh42RRR7XqNjN8i2MwgIWglyUf1nCmWb0eMpV39Wn64+ECcHQSZVm/nUhFZFXVPyErDXXJmZsaGjhg37eiOPT/tH+Pa3gcmN9kpO1VHRSJ9CmKXSMWrsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720701254; c=relaxed/simple;
	bh=dY61pVfeYdptbpc1CWeooXje6VkidAQD5fhpL0AyjXQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ISx0n7qxeyqPClbg1+esQTjXZAuHR2ELJixP+r9pMf6GuKETGbBFKZHgKAzQHCf1bVOv9xAYBrXPdJT5pWhejIhPLj4+qIRKI1lhzpjqFtBWgobfKccUNeHH4j6yiNWh4javS+ZS6JTSR9xZ3QOaksh7icKM+JzuKDqGA8hN+N4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=reIq8+ku; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4279c10a40eso2140385e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 05:34:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1720701251; x=1721306051; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LAFQBuBHIxkQvbv8fOdzuOd5saHrgFyg5FB8jBW+qBE=;
        b=reIq8+ku8dLPzXdOR/+4yeP7tX03CHvSovobC+OsHWrzWNRNjY3DGIMRuqSjgQ+EjH
         MuSjdLH/DcBKYJi854NYsUwPEtnN6B7ItGztFkO3A3w+MGMJagKrj01xeLFOnWMCdBkK
         cDAQ46yJ/3PCht9picOteYdOa1djQ0AfbvEYMlb414R0GoBdtnuIdIs8wNBmMy+pek+M
         xblNvBLLziD+/cLsslUlaaK/qrDmXahyBkcFqS3jXvbgMAOmis5rDcRoMhTwTDbXO6Fb
         h/cRu0g19QqlpvQDcTNtfZ7oppzE89pwhCGoqVh242BPzj2SCxHTAxTM1D5UKJAweH50
         g31A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720701251; x=1721306051;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LAFQBuBHIxkQvbv8fOdzuOd5saHrgFyg5FB8jBW+qBE=;
        b=YNN5JWFMtXAKZ6hEVCrjOiuL6C62bf1NifgQNNVUBQvOIpxpXVs+qA1bJB0NIHyorq
         M3K6UohCpYwFnl65fqFAF3PNpCoTec5SS4UEeAa/QTsAevBXoua4vCwY/qm7XZHR6pJa
         KOFqMrgmwWSgiRfHGCuV9pVTKFP+2nzTyp0xGD7X4ZoM858c+rKMCcEeTz1WimavPD2H
         S/MisV14JZaYOqWU6EH4M3gyhs81PAOhuofMeZa8rVkjVbzjpS5epOAMabYIPmWteNHY
         3hL1G1QZ5o9ikziru5oAAtrPsbB1jPq4zi0CBrfZVOZx1XvPnAHqn34m/xk5MIZYtafR
         FnKw==
X-Forwarded-Encrypted: i=1; AJvYcCVmB5osc87PvQqtTj3XTvP80IAWIVqI8B9bh+dHI4Cv1NfYH0Gh3W2QIQFX4as/qV0+GttVawDZqKCPGML5D9MtWCqWoAj7unQNcVM8
X-Gm-Message-State: AOJu0YxULrpsJmMN2GklD4NOA/Y8J+VZM5t3LaXKBrGADQZVI2/NMj2f
	LeHU8zoR0M/BguKqOnAwLS5Zo5I5LTyA8ahrp8inkw9ZRd2V2Hq2OCYI4lcOnPE=
X-Google-Smtp-Source: AGHT+IFpavZbQE94svJyuAh6eTlEt3fIERDL3R/CcPSJlAFPUb9Zk6IvoUXtrZbD2FDIq2wriausKA==
X-Received: by 2002:a05:600c:6d4:b0:426:6b85:bafb with SMTP id 5b1f17b1804b1-426707db6e7mr45894665e9.20.1720701251335;
        Thu, 11 Jul 2024 05:34:11 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.171])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4266f741fa6sm118583955e9.45.2024.07.11.05.34.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jul 2024 05:34:10 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: vkoul@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	geert+renesas@glider.be,
	magnus.damm@gmail.com,
	mturquette@baylibre.com,
	sboyd@kernel.org,
	biju.das.jz@bp.renesas.com
Cc: dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-clk@vger.kernel.org,
	claudiu.beznea@tuxon.dev,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH 1/3] clk: renesas: r9a08g045-cpg: Add DMA clocks and resets
Date: Thu, 11 Jul 2024 15:34:03 +0300
Message-Id: <20240711123405.2966302-2-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240711123405.2966302-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240711123405.2966302-1-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Add the missing DMA clock and resets.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/clk/renesas/r9a08g045-cpg.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/clk/renesas/r9a08g045-cpg.c b/drivers/clk/renesas/r9a08g045-cpg.c
index 1e471426d4af..8a3ec5780722 100644
--- a/drivers/clk/renesas/r9a08g045-cpg.c
+++ b/drivers/clk/renesas/r9a08g045-cpg.c
@@ -193,6 +193,7 @@ static const struct rzg2l_mod_clk r9a08g045_mod_clks[] = {
 	DEF_MOD("ia55_pclk",		R9A08G045_IA55_PCLK, R9A08G045_CLK_P2, 0x518, 0),
 	DEF_MOD("ia55_clk",		R9A08G045_IA55_CLK, R9A08G045_CLK_P1, 0x518, 1),
 	DEF_MOD("dmac_aclk",		R9A08G045_DMAC_ACLK, R9A08G045_CLK_P3, 0x52c, 0),
+	DEF_MOD("dmac_pclk",		R9A08G045_DMAC_PCLK, CLK_P3_DIV2, 0x52c, 1),
 	DEF_MOD("wdt0_pclk",		R9A08G045_WDT0_PCLK, R9A08G045_CLK_P0, 0x548, 0),
 	DEF_MOD("wdt0_clk",		R9A08G045_WDT0_CLK, R9A08G045_OSCCLK, 0x548, 1),
 	DEF_MOD("sdhi0_imclk",		R9A08G045_SDHI0_IMCLK, CLK_SD0_DIV4, 0x554, 0),
@@ -233,6 +234,8 @@ static const struct rzg2l_reset r9a08g045_resets[] = {
 	DEF_RST(R9A08G045_GIC600_GICRESET_N, 0x814, 0),
 	DEF_RST(R9A08G045_GIC600_DBG_GICRESET_N, 0x814, 1),
 	DEF_RST(R9A08G045_IA55_RESETN, 0x818, 0),
+	DEF_RST(R9A08G045_DMAC_ARESETN, 0x82c, 0),
+	DEF_RST(R9A08G045_DMAC_RST_ASYNC, 0x82c, 1),
 	DEF_RST(R9A08G045_WDT0_PRESETN, 0x848, 0),
 	DEF_RST(R9A08G045_SDHI0_IXRST, 0x854, 0),
 	DEF_RST(R9A08G045_SDHI1_IXRST, 0x854, 1),
-- 
2.39.2


