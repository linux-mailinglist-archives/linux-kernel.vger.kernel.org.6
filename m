Return-Path: <linux-kernel+bounces-397797-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CC489BE0A5
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 09:24:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE3301C234C8
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 08:24:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBB621DEFF5;
	Wed,  6 Nov 2024 08:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="e0qDHqqK"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D24D91DED5D
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 08:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730881205; cv=none; b=f1PoZ8LG5nREEYafex8qjiVzKEZkT2yUR9OzEn/vrlCLclBXgPOt8EOr2cRuE21eSapJeZA+O0mUFfnxM3JrIdqP8y1915hNEt1JcwLAP6zKNYPIHLGeZcMdfYEs9vBI5QB/mxdnbw6GQVM6RUGZPZbkx3Klzxz0IADIm++Ih3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730881205; c=relaxed/simple;
	bh=xRr+e0E1CrRZ+YHQygMn9a8WYuFf1x3YFyuRTr3Y4vw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=m5hpjJTkDnL5rgGbe2WE8LZyz6Dh18QpG2v5MaaMMYleHHKmkRSg0/rI2gQ7j2Yd80RO6eP2yKC9rx53SXGlMxFL507LSIKd23d153LxaSZSDoAiv7Vcos5KJ0/vRjSJoFDf9Vk2wCWiDjiFgQxFHuBCSRHbPqAMNJE7WDt6A4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=e0qDHqqK; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a9a6acac4c3so1013399166b.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2024 00:20:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1730881200; x=1731486000; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oWDS+QzHb5R8GNTmjVWcTdkTeBoukg0Ylo47oa4wrXA=;
        b=e0qDHqqKetlEK/KeY7s+Lrcs7TQ++2f36V7BOI/Oyynv6B01CTV0HDd0+9tbWuCRXk
         4HwfcMSgyLFMZKUK6T+q/rUhmxcHAEgszc6UDyHoQBrE5HlP0h5gWzFdC4hCNFQIIPR/
         HyQyOKmq7PrS/G8hu5atO2i1gSUhH5aeRpFP9BZ33bafwrqBPCrRh1XMw+g7+5dwcX1y
         a2roHpUT0oxjFvMZ0iAb0La54QAen9BgsKCZ0yXoiCJ3pqtk6Ri0NTFbK3WU0Hvliug2
         TzhhqR054uB2Mg1wnuKzvyFr38nlnUOv8QUuFSCoFDM03TKzHf9e3XuiIxzD/7wFdU6t
         AO/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730881200; x=1731486000;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oWDS+QzHb5R8GNTmjVWcTdkTeBoukg0Ylo47oa4wrXA=;
        b=ROlvH5F/U3i/FLo47ksGneinr6sGC/P7L88c52ZSqFYBIWhgr2mkOUz4X+D/H2Oe91
         t2eWWRxsaunVgkcqjKmZvrhNY8LBk0UclNXgWNY6iwdvsPSvuQgQOR6PTXZhKDJtydZo
         CWNaPTUYKKE4xq6zl6AgeE5uk3GEWdzW0TC/lxtQTEXKD0q83cpO6P3drh12GGU2vIxZ
         AT0MQRQJTILT/jWcewpN9yetjNsw78oHwf9s3l0Xn9pqXPR/h0aMCH8CZRORkR73+eKX
         6iI2dJWY4l6yS6zjMCyHGKK+wGAoaDr9kBzDIslUY8HiPx5q2DxRBFZNa50QGDfUvCs4
         IptA==
X-Forwarded-Encrypted: i=1; AJvYcCXd3JCR/Mw4xRaCwaAOuvbcKbrW804vxp8Xz81aF3L1hLdUuK0kpdeVFB4ENyt/PxE1Fql64LAQQZvPTZY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsUCi0HejwhZuLZA0DUZT2tdI7wIcZhgAKDSTkfqxcdK4l4T+/
	7C0zyyKD4qZ5F5mdrDx+WXbRJ0FOLL0m8MO0TmOyf7rSfMvYPKX2i7XtOh5arkk=
X-Google-Smtp-Source: AGHT+IFq3M7EKWSQZDPTj/orvzmMKskePy+zdfGU3vkkTxev6C3c/lDfIf7i8VEOD92Ds53S7fFfiA==
X-Received: by 2002:a17:907:7e9e:b0:a99:61f7:8413 with SMTP id a640c23a62f3a-a9de5ed3f62mr3581394666b.23.1730881200372;
        Wed, 06 Nov 2024 00:20:00 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.28])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9eb16a2dbcsm241369766b.40.2024.11.06.00.19.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2024 00:19:59 -0800 (PST)
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
Subject: [PATCH 21/31] ASoC: dt-bindings: renesas,rz-ssi: Document the Renesas RZ/G3S SoC
Date: Wed,  6 Nov 2024 10:18:16 +0200
Message-Id: <20241106081826.1211088-22-claudiu.beznea.uj@bp.renesas.com>
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

The SSI IP variant present on the Renesas RZ/G3S SoC is similar to the
one found on the Renesas RZ/G2{UL, L, LC} SoCs. Add documentation for
it.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 Documentation/devicetree/bindings/sound/renesas,rz-ssi.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/sound/renesas,rz-ssi.yaml b/Documentation/devicetree/bindings/sound/renesas,rz-ssi.yaml
index f4610eaed1e1..cab615f79ee4 100644
--- a/Documentation/devicetree/bindings/sound/renesas,rz-ssi.yaml
+++ b/Documentation/devicetree/bindings/sound/renesas,rz-ssi.yaml
@@ -19,6 +19,7 @@ properties:
           - renesas,r9a07g043-ssi  # RZ/G2UL and RZ/Five
           - renesas,r9a07g044-ssi  # RZ/G2{L,LC}
           - renesas,r9a07g054-ssi  # RZ/V2L
+          - renesas,r9a08g045-ssi  # RZ/G3S
       - const: renesas,rz-ssi
 
   reg:
-- 
2.39.2


