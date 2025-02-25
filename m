Return-Path: <linux-kernel+bounces-531129-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 39318A43C9C
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 12:02:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86ACA3AF5F9
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 11:00:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6A76267F4E;
	Tue, 25 Feb 2025 10:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="SQFfGtrq"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EB94267B71
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 10:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740481165; cv=none; b=iAZis7tAMoi5c8wANMLoZgYf7BVcw/yBBIRhR0wiUYpQvHmXy60Clm6fFGxRVs9QPfWla6P3AIAzzs3dr4Z9apt/D6nnIG56pRUzSacK560qnfj4GEaX6OB/upeXIqO0xcPc+5HuYn8PuWL5D6YALf8i1arpjNBGNTg9svG4Ddc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740481165; c=relaxed/simple;
	bh=LfDfyXvE/k/3wAGzTHexcKD+CL/7mAcO9M0iYyr9AMk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VdC+mBKPEB6E7vqEzoU+sijqryx+Ibvuq1wLCDahfw0p400Ole5Dd5Pcgc75PvDJKO978dlDKe2cBlc7jERvokD1Qe4qmiQzcTR4YomOyCkJ6drQ+Oiryb+S09ELnC3lam6ZjaZ3d0yTvGXFJNRTsZAxW5DFlnFbovXZFR04ODA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=SQFfGtrq; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-43998deed24so51470215e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 02:59:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1740481162; x=1741085962; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SvjAeJYy02UXwEIBH2Mapc2zFP4oPiRLlb+kj3I0bAc=;
        b=SQFfGtrqStETV0emOtuM5j6SAPam0pIRGci1TVIYL/ZilkOaLL/AvIJUjp3j9/h6St
         BUVRTOoXi8K+sfWfAqzjZ4OSrti9af3657dYNjbAVMeaBIon5lIQJUDsMffMTDdw3yWw
         SLN+EKHmWuXtIxZ1QMsHgeqMQYWeIMB9LWNk6AShlFfDzQE19FS9/MpX3m+MSNTvibrE
         AgK6uirXm20xX12yPsaLMJlMFFkh5yU3l4H7hclPUa7zwQaxJ1TNBJoxH9/xg890mrT+
         rDsUbtIz+q66ljha1zLXONPjJa6qx4A7Chinr2cZJ2MPa98oJoKuqixIk3kPbmX7kbpU
         ny3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740481162; x=1741085962;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SvjAeJYy02UXwEIBH2Mapc2zFP4oPiRLlb+kj3I0bAc=;
        b=kjzILJMoODYXgvwKSfdHHer1XFuqnl1AKWerTR2TlMNpBHhnEdUvBdwmRQrbqV5TQt
         oo1PrRVXJ+CTMkVoAXKQNoGjYm6L48GoszVTbd0Sov+YXOfKSd2I46DvdSZnQWpf7B5M
         ecQlV2UOQ5QEo+b1FfY34rHO9iS7h8nTAVuOGUyOAXILse289xZ9cxfcO1khrkUBH0j1
         RcbXsVW1FsmimCvv1wiog2GclVip+1xpw2jtkpXsd9U6AT398s0MEbzn7LqXgToHGoYL
         oLFVKjYUsfXjDQ00ocgQqnFdEwFg6uXeADbKTvc01lJ4ZXNaHGTz3TNWbwc4hIzFutC8
         TcUw==
X-Forwarded-Encrypted: i=1; AJvYcCWGEowL0IXw9Tm+6/FR9jhPirJMk7VbLDpJU+/R1wz/9gfzPSn6kJpiFxrhkfJnPeGCVslUnrzTP4xjufs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw71wJLS4UxjmSORGvFfQCThs2FqGuzuX0+aKrm4VOd4fT8YiIn
	u9pJ8FSGJMTrFu9/4pnFnPFhTJhHAH+zcaYIeZe7Q4ktRz/+ujTc1IrqXFfgHKA=
X-Gm-Gg: ASbGncvUZN4+diR4WrleSsfQY63XbsspyjfP+xEc1H0bE8h/t7xX0bc5G2Gk7HFY1QL
	R49KJ+MdRMq2/jFMYOArrSB4ydN325F12z/wrLr+I4O7Voje7M2CHXwWdiiWNi7ssjWK/z7TBPN
	fn6TyvNORez+7VGbJ7VwsQKAxFDiS/pe249jm8A2tyHSXDT1Ak+3e2Ay3JuMM2W34gbfRZTG0VL
	F00pSpLMt7jVYJx34mhcgeATaE56T990T+a8yCIAvnLRg8sb0jfUnBDLc8zon7cRPeV9L5iUn+Z
	KHfrRXV/HeYDWjdiFGDFpdBsO+k/c7nyIhYPnVqyYdA+Teg6KVfR2FM=
X-Google-Smtp-Source: AGHT+IHJusFfOvPLQ/wSNXmqs3trKdVlwIwzvO0DcaifSitYECfthSTp3FPUoDPwRVwIMqUgzX4gfA==
X-Received: by 2002:a05:600c:4592:b0:439:94ef:3780 with SMTP id 5b1f17b1804b1-439aebe4a26mr165557195e9.30.1740481161783;
        Tue, 25 Feb 2025 02:59:21 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.25])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ab2c50dcfsm12588815e9.0.2025.02.25.02.59.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 02:59:21 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: yoshihiro.shimoda.uh@renesas.com,
	vkoul@kernel.org,
	kishon@kernel.org,
	horms+renesas@verge.net.au,
	fabrizio.castro.jz@renesas.com
Cc: claudiu.beznea@tuxon.dev,
	linux-renesas-soc@vger.kernel.org,
	linux-phy@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	stable@vger.kernel.org
Subject: [PATCH v2 5/5] phy: renesas: rcar-gen3-usb2: Set timing registers only once
Date: Tue, 25 Feb 2025 12:59:07 +0200
Message-ID: <20250225105907.845347-6-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250225105907.845347-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250225105907.845347-1-claudiu.beznea.uj@bp.renesas.com>
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
Reviewed-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Tested-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v2:
- collected tags

 drivers/phy/renesas/phy-rcar-gen3-usb2.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/phy/renesas/phy-rcar-gen3-usb2.c b/drivers/phy/renesas/phy-rcar-gen3-usb2.c
index 21cf14ea3437..a89621d3f94b 100644
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


