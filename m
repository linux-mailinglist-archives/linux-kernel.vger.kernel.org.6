Return-Path: <linux-kernel+bounces-397780-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 046709BE04E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 09:20:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27C341C230A2
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 08:20:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8BF41D90DF;
	Wed,  6 Nov 2024 08:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="Cztf4RAV"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99E2B1D7E4F
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 08:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730881167; cv=none; b=Fz+p4cHeyn5XPCO6TT6r5V7MWjS8qHnPDK19fvShVb2vl9I+5kJQg2WRKlB74gYaRBVgTgYyUJzlsm94RrGePpjQrSyHXb7N7OL3sO2kQ7+rNvtAG98XnDKUM7FOaz/YRJaOPbsBqgJgmVI//F0Fd+94MSGLCP54yEovWk0XlYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730881167; c=relaxed/simple;
	bh=ezou/sUeO84m6Pbsno+iPPVK50t8DBnB/7+REwh8n3w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=p2hj7sz1SYuHIZKv1jGJBj6zXkbf34HDOgXmKNF6V2i5PqGlCt8cGy27F67WEDEOXYPttf7c7L494iyZJ5KDgH2m64Gq1gyFEIKkH2h2T676UmKbBNLggKRgMHO1D0zUG+6ert0amMq1e5bHyf9ZpF+L0pOjlWh8IETBsWc1NX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=Cztf4RAV; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a9a850270e2so1064036766b.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2024 00:19:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1730881164; x=1731485964; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z8PJplAj6BtFAbLsdC8Eyhh6kOprA91oDhfaq2lH0Kk=;
        b=Cztf4RAVILDvlTIr3EvU5LSdii2HWznjYLJl9lfT710JNBCXCAPWf27LD1sQ/bLVdK
         CIyDlq95b9LTbGz/emnuTFdvqbtA8wAlGgKL6fBu0p2EUJ6CMBGfjFDJTTNcKZ/34AIn
         C+ubnmqDDG2Wy3/weYh/GiJi1rio8c/1GJuh6xtjfU47LcFfW8XGNFaCxmAX+nzOoIm9
         HRdvonzW7iTzH3077xrWyk9uBYkxVUwA+kqwy6v61SuSrYqxI7NY1W83+If/M9z+JgFp
         b/l/XGXgqO3qIxgoN+n5gzE7G7FQ2zBIVpkXMlyR2bITfcer3on39fCB5EjAGstQ4p/2
         g4Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730881164; x=1731485964;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z8PJplAj6BtFAbLsdC8Eyhh6kOprA91oDhfaq2lH0Kk=;
        b=eNmsSkpkTbiH5yZzf26I5QQARUR3uWTPW+w3aEVj/xqjoXOsRIlFazKvi4ElwNXMxU
         jIrA5xqsx5g7DXVMSbZNWz/5p91JsdPFftDilAwa4OUMSexDmaDEnzeNaT5vs8qxc+ZM
         mJcw/e+0l4mUFA6r3d9RKucMpR5dDtDMCJUymZWBRINpzewhCf8MvqRuSv53H49SZRNM
         Stuz3AbnhLgwHQo0dTNVYKXn9/Aq/9/q1D2XWeS8+8tx+et0vnORM9Jz36kDFpb8w69N
         PptLZrFHIRhpXobhXZ/eGuRzjVJbTNGU4w4SG/JgvKdq1xb+znNVFxfI1U3Bi76rZaUr
         AESw==
X-Forwarded-Encrypted: i=1; AJvYcCXjUMdE76hJCbYTqcvAADHP9AUGOEiccglVnlUGk5oVWULA6YRERx3ZXXRnGlJOnBnBRxV5/bK38oH/rh8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVU4LhvotXE5jMdWq6JorcwUapwe3H1ZWeLWS6+iEMOJpR6w70
	VymP0CGxJVjE9yBmedRUE4xOEpTnbtfFka9Nn5AFzTM2GWsG854E9P1VZMAQGwk=
X-Google-Smtp-Source: AGHT+IFB/yilN2A9rr9tyTuVx/XGzqUm+PgC7mEHMgDPVnIg+6PoAyGzKyboc/+QMnJh+sxtq1GkWA==
X-Received: by 2002:a17:907:2d0c:b0:a9a:714:4393 with SMTP id a640c23a62f3a-a9e6557deb8mr1859922566b.23.1730881164026;
        Wed, 06 Nov 2024 00:19:24 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.28])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9eb16a2dbcsm241369766b.40.2024.11.06.00.19.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2024 00:19:23 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: geert+renesas@glider.be,
	mturquette@baylibre.com,
	sboyd@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	biju.das.jz@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	lgirdwood@gmail.com,
	broonie@kernel.org,
	magnus.damm@gmail.com,
	linus.walleij@linaro.org,
	support.opensource@diasemi.com,
	perex@perex.cz,
	tiwai@suse.com,
	p.zabel@pengutronix.de,
	Adam.Thomson.Opensource@diasemi.com
Cc: linux-renesas-soc@vger.kernel.org,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH 04/31] clk: versaclock3: Add support for the 5L35023 variant
Date: Wed,  6 Nov 2024 10:17:59 +0200
Message-Id: <20241106081826.1211088-5-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20241106081826.1211088-1-claudiu.beznea.uj@bp.renesas.com>
References: <20241106081826.1211088-1-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Add support for the 5L35023 variant of the Versa 3 clock generator.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/clk/clk-versaclock3.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/clk/clk-versaclock3.c b/drivers/clk/clk-versaclock3.c
index 1398d16df5d0..9fe27dace111 100644
--- a/drivers/clk/clk-versaclock3.c
+++ b/drivers/clk/clk-versaclock3.c
@@ -1133,8 +1133,14 @@ static const struct vc3_hw_cfg vc3_5p = {
 	.se2_clk_sel_msk = BIT(6),
 };
 
+static const struct vc3_hw_cfg vc3_5l = {
+	.pll2_vco = { .min = 30000000UL, .max = 130000000UL },
+	.se2_clk_sel_msk = BIT(0),
+};
+
 static const struct of_device_id dev_ids[] = {
 	{ .compatible = "renesas,5p35023", .data = &vc3_5p },
+	{ .compatible = "renesas,5l35023", .data = &vc3_5l },
 	{ /* Sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, dev_ids);
-- 
2.39.2


