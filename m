Return-Path: <linux-kernel+bounces-554197-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6B30A59477
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 13:29:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99835168135
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 12:28:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79EDC22A4FB;
	Mon, 10 Mar 2025 12:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iL4HlbPh"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A618227E80
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 12:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741609676; cv=none; b=tiRfbeGFoQeBzeniqM81nNOq6MWz9599RX7TsARX3l6T8Xia/o87OYZwbXd9um35t7UJP4L1yOe5TNAVHKsx2UNbi5dg2mquPApsSKZg5lIDLbaLMxeLfvjj7nyWzYUDdgfwgvjFsdEJ4NcJ69WWpfNi516/DxT1f4xBX4ABc7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741609676; c=relaxed/simple;
	bh=Zy2fJh3cTHOqRs4mkjI77HUqzP8JFc4VAdL+NBQchrE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HYHCv+ZmuvlQbRKl4+34X2fr5UYoycfgix0WuxBIW2omquep7rDS8T0pQU+0MwcplosnlPEIK2rZCemozzu9TkXo5l52wTEYaLNN60XNHrb9H/B1zpefUmosb6FYRWnU95K2wQTPjIgVnLdBHAOQa3gzacVjB+C5rTkVklve8pE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iL4HlbPh; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-43cfa7e7f54so4392655e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 05:27:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741609673; x=1742214473; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pP5AGd49889Z3JFGOGRHgkg7HKkdewQ+Zwhw794fEIw=;
        b=iL4HlbPhDqcg69x6dbhz6ymy9OQPpsErBzXCNa0PCRSylZf3AMCwRGngS8Hazjnu8t
         e7EPJG86IGMb8vOIbzJI0U6nkl1RmjUfEo031ftqgGp25BiOJRJJKZj2YQKQJkL4zft8
         uvpEcMJv44z1vZ9Ltz09MrsV9Rgp1j8+L1rgM4E+1oRxzP/awuT8wKWidmRd6Gpvbmt1
         UKrqAq2YiZ5kSCrc2/d5IdW7KbDxAv2HqVUHotxYqUXDJCR+ljyFlrBIr0u9U4Sicrxw
         QfOiV/n1CDIBYw8+H1YMXe5HOR14DXhnEhaaeM18njiyMetuo6pf3w3JoLtyJsoIDFwX
         LuoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741609673; x=1742214473;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pP5AGd49889Z3JFGOGRHgkg7HKkdewQ+Zwhw794fEIw=;
        b=mj+cxPTcTPYeTGm4wKUcsXnXNOL9QvAuBf3qjm0WIlM/1aIXqrZz2t9260M2BNVC1o
         QRQKOBb32tNjNSY/4/ctOdV1VZZvMpjFJXjQAiLJoj3d6lTg2otDHyzzEGSh3zt1+l20
         teARSIYoDOVBcCSx3KA8VJtpDsXdBGNzA4TJfk2TA/Z7Tbf+4zEOlWW4LUOhctgOy0mZ
         TbQynfGRHi2ZmyQQmf1n/cmfOScPbOpg2WQ6unqEPhEwrtADaJ5z2vmTkrFt8/httCaF
         6DwZxUO8Q/STvmr8SSVxHOsjIcrNrMCoOlQ9QkjmX2BTCpiJzBFlLMjgAfjWMQAROhZG
         zuYA==
X-Forwarded-Encrypted: i=1; AJvYcCV0zySk8lyrz9/f6UziTh6XUdwgifr0nSxttAmAvP3FyPB3oJYoduECNeNlRSB3cRKG6DO49W475/zyhXg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxmu4nHF31pSxRDOzHv8OULzrowGL3KvOX0ikK5c5yNwZnfO8tk
	48mAbmRh8QfC+DijC0/zKim7OiAJG/GmEsoe3JNSILchmSaweLzs
X-Gm-Gg: ASbGncvcUQ4IBqNxtDe3WpeicFh7JoHdrLmUEAKoTGOmCLUXk4LUJFRwo6zt8saikjK
	kIQPbc2eEQGPdrRCeEkKb4+ymjPYgloAZNEpiUNtUqJQ8ZuocV52/d/N8GYKGNx4AuvBzYZlldX
	YAjqoPAnpI+Au4JXfe+ta/pGHrPV+8xusZuMJCXRRBFjXlNpJI/BO6Hb6dXzLhH+JhLvx+JZfUQ
	8ikjpLkjmuP/ZW7A+QRtTiYGjLvEV9ngdOWQz0TdhnLWksopDJPraQV0in3MdoWJV9Up6KHWxrI
	ZYEMd13dmv7jlj5F7XjobAPg0Jq3ss7R/ila6G67zHSgotnoB9lyJ9gCph3ZFm5lOsJf3Wrfr11
	NTvXhF7kYX1HyHCwa
X-Google-Smtp-Source: AGHT+IHkdFXutwUlHgJUEeibLtGVxZ9e1BYhqaRmZdU3VrmHHopZkCNH9T65QpbRvqLO+DUNS6Gfbw==
X-Received: by 2002:a05:600c:1e08:b0:43c:f680:5c2e with SMTP id 5b1f17b1804b1-43cf6805d78mr26252335e9.13.1741609673265;
        Mon, 10 Mar 2025 05:27:53 -0700 (PDT)
Received: from eichest-laptop.toradex.int (85-195-230-40.fiber7.init7.net. [85.195.230.40])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43bd6530f26sm171963245e9.4.2025.03.10.05.27.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 05:27:52 -0700 (PDT)
From: Stefan Eichenberger <eichest@gmail.com>
To: vkoul@kernel.org,
	kishon@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	p.zabel@pengutronix.de,
	hongxing.zhu@nxp.com,
	tharvey@gateworks.com,
	Frank.Li@nxp.com,
	francesco.dolcini@toradex.com
Cc: linux-phy@lists.infradead.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Stefan Eichenberger <stefan.eichenberger@toradex.com>
Subject: [PATCH v3 1/2] phy: freescale: imx8m-pcie: cleanup reset logic
Date: Mon, 10 Mar 2025 13:27:03 +0100
Message-ID: <20250310122745.34947-2-eichest@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250310122745.34947-1-eichest@gmail.com>
References: <20250310122745.34947-1-eichest@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Stefan Eichenberger <stefan.eichenberger@toradex.com>

Remove the switch statement for releasing perst and reset since they are
already correctly set at probe and are no-ops for
reset_control_deassert(NULL). Call these unconditionally.

This does not change the behavior of the driver but reduces driver
complexity and allows for easier future modifications.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Acked-by: Richard Zhu <hongxing.zhu@nxp.com>
Signed-off-by: Stefan Eichenberger <stefan.eichenberger@toradex.com>
---
 drivers/phy/freescale/phy-fsl-imx8m-pcie.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/phy/freescale/phy-fsl-imx8m-pcie.c b/drivers/phy/freescale/phy-fsl-imx8m-pcie.c
index e98361dcdeadf..5b505e34ca364 100644
--- a/drivers/phy/freescale/phy-fsl-imx8m-pcie.c
+++ b/drivers/phy/freescale/phy-fsl-imx8m-pcie.c
@@ -141,15 +141,9 @@ static int imx8_pcie_phy_power_on(struct phy *phy)
 			   IMX8MM_GPR_PCIE_REF_CLK_PLL);
 	usleep_range(100, 200);
 
-	switch (imx8_phy->drvdata->variant) {
-	case IMX8MP:
-		reset_control_deassert(imx8_phy->perst);
-		fallthrough;
-	case IMX8MM:
-		reset_control_deassert(imx8_phy->reset);
-		usleep_range(200, 500);
-		break;
-	}
+	reset_control_deassert(imx8_phy->perst);
+	reset_control_deassert(imx8_phy->reset);
+	usleep_range(200, 500);
 
 	/* Do the PHY common block reset */
 	regmap_update_bits(imx8_phy->iomuxc_gpr, IOMUXC_GPR14,
-- 
2.45.2


