Return-Path: <linux-kernel+bounces-521983-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E1D2FA3C48A
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 17:11:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E86C189AC4D
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 16:09:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61580204840;
	Wed, 19 Feb 2025 16:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="Ehy0sari"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4F421FF5FC
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 16:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739981288; cv=none; b=WBREyzNifH17dCPdcx6yT5ggxKZwt9jzf6IEZSlSHqE+0XE1HyXCZ9DsLW1E8GrzkDM5kipuAoIfX7QPaD6ZUvQzGrsdymmvFvQ6P4cUXYGL2VI49p8Ufl33qAX7zOaDCmNNgGtG75pknlFeVUIXEWARU6VdaB0XGy3EVZBuMWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739981288; c=relaxed/simple;
	bh=Nu+B+aent9gnDnLeup0LX+XZtFmQ3i9h19QHH4qM5Yw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H1MGdbmh1X5aMqqFG7HtNiXmv3W6LjrzonCI1zAXJ8h3d2Y5vWFrCgt2soouMa6MzV3uThiC9MGUwtUg2YxI4+nqX6b2oDTXJ7gsmq2QWSIPoYFWNj93UqHtta8iVf4bK+i4rpYkVHaM9MY9qWXzvGh5eAP/tDunoZ7qsfwx3qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=Ehy0sari; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-aaf0f1adef8so1385585866b.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 08:08:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1739981285; x=1740586085; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BtGBoe5coeUnXZJpUlOcRLqzBSKuMVRJ9kwi5GgXX1M=;
        b=Ehy0sariCfO4XSF/zqmG1HB8+NOcqx3EyYI89+XO3YwUnm05s+gG6Z8o9zMG9X+13p
         OiBW8ElNlzC3y84Gkc/7SMswqUa6RkS+VH3/Hl6IdWySdOzMflAc5A3cKMGu+0QgiMEu
         RWWbFaUCyL1mtPdcnSXXOJDoeEho21NNwTzIIp3hk90zUiQyB0W/HC+POMOQ45Emgqgx
         Ut1EBEVjIQU4O9V5NIU9EzOBtD+YIydLuhQe5PjZmiAkbpNUQtpXLHNmuCqGBN/3++sb
         R1OiDmJcdaY1oq1g81gOYmhYr6AuNfvKD4XgWc5SNaa9oKilkwY2P5h1FqSHg9GlwnUg
         RyWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739981285; x=1740586085;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BtGBoe5coeUnXZJpUlOcRLqzBSKuMVRJ9kwi5GgXX1M=;
        b=BzhhrO0mqB/XUy5rbeW4SpmRyqIAGdIDjVNZuOmZnBGuAfoXLg+kxDchsbcxYW2UPp
         f4MB4rDmKMxXuXp4x3uEF/YekjUZumtQ+gW9cEcN/VrXPbtKwFiOuJQ8ldRiEeuzwqeN
         sxWpzenqT/K4MPVVHOiAG2T1rdTGN/lpujb1gg+S6PwxGacf8Y/NQx/D917+iTbz3wX6
         p5lgTBcG6nj5maxkRIEY5wlMu7EK85/GZiffjBx3qN+CUeKY8i05OVBpyiPka3LH/Wfc
         PncZ1c0Ouq0xyvUggm2P0ztdSwAxscDovrdU21PYSab/OBaZtNn2sifPXy83rYWtgjiV
         7Skw==
X-Forwarded-Encrypted: i=1; AJvYcCVcdifXjCtUElzqRmcg43+qpJjEBifMAvRLX3NVN9Ssl3pWbiFblMMr0zji5esvV/5zERrIy8R1XOVVZcw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzpnUjHI+HtZoov7KTLg3A9xq0kesbRXwP4JpdvUp0cbYINw1j
	blmRG/XLpz/2i0oLmnt9YGtQ0pkIMa5J96X+fKiTTs88laIrqPiN+pX9c8S2Bm4=
X-Gm-Gg: ASbGncvYbm7F2YULN1c8crBh4QZiuDViOjft4dF5wXBSl86PjjZiZwje6Lvt8MzBVfy
	f557LIxMJ91Vr5Hny6uo4QdkTQvwmK9oadLWkQmjxhICLOfhlX9WaDfuYlqYyVdsszM5TXw0Ci7
	8yD07Jm/P6yNdTkQjT1rplG7w90G+5eWK0F6pRhrEQTPyXS5/h7qnvpo0luCjeKbbs0go8k+Qpm
	PaHKDj2nxKr4vuSlERN0DO679ZZN71RzSFTBm4hfacrRF0XVG4JDya/ln3ApDj25eg5mNfW09va
	I2Gn9axCNdp4HdP73piViuhPHEsgDokjpoTcMrlYgqHo
X-Google-Smtp-Source: AGHT+IHxe5ZyQ3C/l0BujyjIhZwXC57yvWHfxRUBHLFeh5ZxtlbAM5sS46OrKTP8YZUtyZ2rOwWbYQ==
X-Received: by 2002:a17:906:9b4b:b0:ab7:c3c9:2ab1 with SMTP id a640c23a62f3a-abbcd0d1b4emr437963966b.50.1739981285101;
        Wed, 19 Feb 2025 08:08:05 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.25])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abbc0d0b882sm327791066b.109.2025.02.19.08.08.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 08:08:04 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: yoshihiro.shimoda.uh@renesas.com,
	vkoul@kernel.org,
	kishon@kernel.org,
	horms+renesas@verge.net.au,
	fabrizio.castro@bp.renesas.com,
	robh@kernel.org
Cc: claudiu.beznea@tuxon.dev,
	linux-renesas-soc@vger.kernel.org,
	linux-phy@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	stable@vger.kernel.org
Subject: [PATCH RFT 5/5] phy: renesas: rcar-gen3-usb2: Set timing registers only once
Date: Wed, 19 Feb 2025 18:07:48 +0200
Message-ID: <20250219160749.1750797-6-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250219160749.1750797-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250219160749.1750797-1-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

phy-rcar-gen3-usb2 driver exports 4 PHYs. The timing registers are common
to all PHYs. There is no need to set them every time a PHY is initialized.
Set timing register only when the 1st PHY is initialized.

Fixes: f3b5a8d9b50d ("phy: rcar-gen3-usb2: Add R-Car Gen3 USB2 PHY driver")
Cc: stable@vger.kernel.org
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/phy/renesas/phy-rcar-gen3-usb2.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/phy/renesas/phy-rcar-gen3-usb2.c b/drivers/phy/renesas/phy-rcar-gen3-usb2.c
index 087937407b0b..8e57fa8c1cff 100644
--- a/drivers/phy/renesas/phy-rcar-gen3-usb2.c
+++ b/drivers/phy/renesas/phy-rcar-gen3-usb2.c
@@ -467,8 +467,11 @@ static int rcar_gen3_phy_usb2_init(struct phy *p)
 	val = readl(usb2_base + USB2_INT_ENABLE);
 	val |= USB2_INT_ENABLE_UCOM_INTEN | rphy->int_enable_bits;
 	writel(val, usb2_base + USB2_INT_ENABLE);
-	writel(USB2_SPD_RSM_TIMSET_INIT, usb2_base + USB2_SPD_RSM_TIMSET);
-	writel(USB2_OC_TIMSET_INIT, usb2_base + USB2_OC_TIMSET);
+
+	if (!rcar_gen3_is_any_rphy_initialized(channel)) {
+		writel(USB2_SPD_RSM_TIMSET_INIT, usb2_base + USB2_SPD_RSM_TIMSET);
+		writel(USB2_OC_TIMSET_INIT, usb2_base + USB2_OC_TIMSET);
+	}
 
 	/* Initialize otg part (only if we initialize a PHY with IRQs). */
 	if (rphy->int_enable_bits)
-- 
2.43.0


