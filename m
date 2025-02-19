Return-Path: <linux-kernel+bounces-521991-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85B99A3C4A4
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 17:15:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3AC8C167D43
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 16:13:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BD571FE46A;
	Wed, 19 Feb 2025 16:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="Gf0T/rmG"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED91F1FDE01
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 16:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739981568; cv=none; b=pcnVBbr0UN/knobfkserGSTzD9o5CTN79XvONG7JxHaLUMv7IHmMRXo58BhsAFy+0h/fSjTRoppbuL8E5Czt7YL9X857SeY15TMIXFs7c56Q4kqn/88pilQ2y7Ih52+OHMqBFcO/p/R6m2qoc1QfpUe7SA0EtFewWbZ9jjWPyzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739981568; c=relaxed/simple;
	bh=ocze8YqnRMaWZsMl7gofFidYX1Ww5q1qO93+l3/0JDY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=StlTTn4CNgRAhyDM9qISf48IeIjUBMvacLL7cZwqqqMjTY+kWnVi6ahghRQa4dMaVjCf5rDwIb8VgFzNr+sQTZTuyzOZ7rpRZsv73MySjCqRBKB+fSeqE+1TFTQ/tpsqS87WNx2fDkHRiIfvbPGZyum9nLa5lVjIY0WtGvuzusc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=Gf0T/rmG; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5e058ca6806so3179861a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 08:12:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1739981565; x=1740586365; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G9x4mlOjAiy9oa9aITlEsW4n3OXG4Pm6mlTbu2Zgyrw=;
        b=Gf0T/rmG5zo9EJO0MsPcMDlvUNVJIp7er8PS+YlAS9prxMIcZ283F87fscWXGayGVS
         VNMBkXOSrqViMScZAUkYY4Y9Vg+uG5ua+fefwtx1Ag15gsAGtcKYXi+UUrHM+iNGGQT9
         36gshRLUcQ+bVfTgxEpFbhbhCQJmCxf48dJMfUqEDsw9ZAdHxTh557Fla8QnFNf/5hos
         51sQwEft2RuXGXfIl1u4oYyAjv/K9To0vyL/hvJ/qgHWOmkTdbIBshMxSAcbcpJku49p
         TigllHdYFxjYLCB9vfo1HCG2Eru8wsCuO3Vb4v0/LKc0aeFbZoZyu1qllb4SwDZxoMhp
         ZoFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739981565; x=1740586365;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G9x4mlOjAiy9oa9aITlEsW4n3OXG4Pm6mlTbu2Zgyrw=;
        b=cAMx54zSzUJ/OcGvfmeOKp3gZ5ScqgNVF/5jkdvsKYWz+KSdEGCNN41te5W5qle3MH
         xlzZhAGI9HVTOCw2Yh6xapGxP0X5CJ+a8bgxLJy4W8pQeUkkH5qlAU5qkY+h48TkrOQ+
         xvmzSi7gvkWVBxuGpNwQbEgTABbrQ/Mz/9KNOU2zd/hwCxAGsV1ye6mTTD6dmhdleXdd
         ca3s7EgFP6KcRlJ3BsvPR0OnpBPrS9bU+YZG6bQVjaKGLBWFxChYGwRcES3WHGGvgEp3
         a6Ey4zYSnPKH7tNs2PQS89F4bV4Hqx5rNfQTg7iyT7WWdNR6MQrdRpFxUdUvJmyMf2kL
         RIAQ==
X-Forwarded-Encrypted: i=1; AJvYcCXjsrEXNP4ZN748FXMCeKJUGeCCmyJl7znc7e6yZEpnQaFLOI2BStYrZN+Xao2QPjgmrEyHA4qWht56vdc=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywng2yScXQvXeg1XLbgptDPl4OS8jzNCYev2uo5Cej556gMp+RK
	xGU4Dlg0QswylJRt9uHspmTW43a9/VVap8QrN4PbCd+3yRpZvtWeSSNiLS761Ko=
X-Gm-Gg: ASbGncuA1LoWVK3pmqjtxra4rrdmO45d0ny346v/LUpg4pvzE1rPkkfbslyRCeDY1vB
	eLolix1g4k/70JEToZ3vgnQoQhEDLOPjPMz6OEBGtBPu3dU5yGJuYBhJfsWGM1gmPIp4lHLIhyi
	Yw0qyUMMtfQi2cgAwNbuCeKe2j+vgqbqdCMeddHRHllj5lDLrZP+Y4b6niDUsnjOcyz+VWuf5vR
	RhhBEgFyFWFj4tfCJ7COQXp+MhRMC5p8+zFWNBPh/ekLWZih7bdyo7yTd7t7gytEHVmFCHnodxL
	EZkT//LViXCtm13w6txa8mRgN3WT/6qbxD2mXZ4gDyDp
X-Google-Smtp-Source: AGHT+IHvs3OSrAg6bwYOEo9sxXJTxipss8uEVegwbkp3y3giamb686DwVqQEfGye9BT5zFj7d6ma9w==
X-Received: by 2002:a05:6402:a001:b0:5e0:4408:6bcf with SMTP id 4fb4d7f45d1cf-5e04408718bmr13432366a12.10.1739981565279;
        Wed, 19 Feb 2025 08:12:45 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.25])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e07f390626sm2548881a12.30.2025.02.19.08.12.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 08:12:44 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: gregkh@linuxfoundation.org,
	biju.das.jz@bp.renesas.com,
	geert+renesas@glider.be,
	yoshihiro.shimoda.uh@renesas.com,
	laurent.pinchart@ideasonboard.com,
	phil.edworthy@renesas.com,
	balbi@ti.com,
	kuninori.morimoto.gx@renesas.com
Cc: claudiu.beznea@tuxon.dev,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	stable@vger.kernel.org
Subject: [PATCH RTF 1/3] usb: renesas_usbhs: Call clk_put()
Date: Wed, 19 Feb 2025 18:12:37 +0200
Message-ID: <20250219161239.1751756-2-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250219161239.1751756-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250219161239.1751756-1-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Clocks acquired with of_clk_get() need to be freed with clk_put(). Call
clk_put() on priv->clks[0] on error path.

Fixes: 3df0e240caba ("usb: renesas_usbhs: Add multiple clocks management")
Cc: stable@vger.kernel.org
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/usb/renesas_usbhs/common.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/renesas_usbhs/common.c b/drivers/usb/renesas_usbhs/common.c
index 935fc496fe94..6c7857b66a21 100644
--- a/drivers/usb/renesas_usbhs/common.c
+++ b/drivers/usb/renesas_usbhs/common.c
@@ -312,8 +312,10 @@ static int usbhsc_clk_get(struct device *dev, struct usbhs_priv *priv)
 	priv->clks[1] = of_clk_get(dev_of_node(dev), 1);
 	if (PTR_ERR(priv->clks[1]) == -ENOENT)
 		priv->clks[1] = NULL;
-	else if (IS_ERR(priv->clks[1]))
+	else if (IS_ERR(priv->clks[1])) {
+		clk_put(priv->clks[0]);
 		return PTR_ERR(priv->clks[1]);
+	}
 
 	return 0;
 }
-- 
2.43.0


