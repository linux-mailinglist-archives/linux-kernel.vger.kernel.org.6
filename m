Return-Path: <linux-kernel+bounces-543907-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CFF8A4DB52
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 11:49:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C849188FFC6
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 10:49:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4EBF1FCF44;
	Tue,  4 Mar 2025 10:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="GkcuVq+j"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E8E71FF1A7
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 10:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741085320; cv=none; b=N8OZPkKGvSFDSEhcoWMtInHoZvTrvzuF/vSFcRHDpCygUTnt2XByv5KNjZxsBXCr3VdH53mpwrEOeRWOCSfIEAGlWH7ADvW+UHJsT+w05IupNwyYzGDL2hW38CIGFPub3K4RtVVxE/Q1Gnpm/tgsW54wV7uAQi2W7XmMg+2G+pU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741085320; c=relaxed/simple;
	bh=Ed0whvbRiPMkWLTpCwW5FbR8zUZHMT6ELFO54H5wtf0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KRprJkstrHRtlvKK6dQggJ9tYFrf3l7nif+DbpxBKiSqcgjHGTuqqsLIx0nC9vWaFlFuYihPO0O1/o8giJdqQ4pm5sjaiviW78XzSCoED2GoVo4mSK+tvx88TIa/nHTWUqjIbfMahW+RGlKPClSz1hBfY1u2NEATmGIbg8aLYK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=GkcuVq+j; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-390e3b3d3bcso6490668f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Mar 2025 02:48:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1741085316; x=1741690116; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x5a4oKKcOuJdLssc/zk2DHBl5Am0SwZ1rfHw8fwtygc=;
        b=GkcuVq+jjfXFW83w2lqNS/SwZCCC6aWXX0sdUcMN/XfNXjin8ZefiNPxxQdc5GCOOG
         +zNOAygGIVSYD5GT+U85/S+eMB5D63kPI8+wnC1A9NHKmIG0IeqMP1Cpz/FI2VtrKx3l
         rTT5g3bPflVlNjuBQezjYIL/g3kkciomLBO4BGyb9FRY2EhUePJhFesAK/4rzEgs9vqG
         gFisLcdVJiTERnBtXXMN0/SKCUhaKFzFv2u94gjkzwRII8tJozlcWbkB3Gxv7wcMNOKR
         ln4j7p6BGDRxQpXKS4jFEynwnSX5uGjfsvR1RtFfS1CTizV1Z8JnbttSlrHTD0KKWoDH
         HhdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741085316; x=1741690116;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x5a4oKKcOuJdLssc/zk2DHBl5Am0SwZ1rfHw8fwtygc=;
        b=bfuZmZL4P19oUCiioriw4c23nlZJ6U2GlZwXJYsishjL+FdjaqVjHg1Fc+jOGt8bHB
         ZCjBy0XbrJrjukgp0nhFoupv57n2QPgGOLxaQULxQcoHT4o47CZL6FYzcW1bhjxSFyP/
         klPrwu+k3imIPZmFqHHqEkIGF2KMtLi4shmVfWu9Ib57ZVQPWXSZ2r4bGcXq0BG3bAtj
         f3LnQUl6utF7cachvAINCHCO65wyJVO91P5P5RuKkqwtNWAiSVShmZ48i7bzIAalFAXZ
         F6gqOLLjTX1HT0aD2CLoPq/wLKS5fog+Nw+pgYsWAVD5xPL+jUHPsKhsSOnRnUNG2YUh
         aSVQ==
X-Forwarded-Encrypted: i=1; AJvYcCVkwD33gs2n1T84+KtbXZIDr72/pqtr033ublae30a3f4KuSsnOtyTyMikYbV38tgt5I5bgfHDVOX+WC8Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGooHz1RNg7m7/MoP0xWsZxyLjThm+NYO7p4F4vT2NKW1wMyUM
	KlVIgGaHYlzJ/198+mhMEWTowUBrz+tG/C7hAvTcXr+uImHD0TadHiPFC2VclGI=
X-Gm-Gg: ASbGncuoYvpqHsgwdVuTx/L+h/tD52rEMiljuetg/PBxnJTK2NF8KsUps8vHAkmhWNk
	/2/ju5xyF1NIrHx1jFNhYAmsqKWhMdgwhEsJJ+NcUiekVgHqPpMQiNGdz/wJ0Fy5LCMpOBU7PLK
	khCB2JGC1Uti7lyUsAoMZGSXElsF/CtuSPferrdTP5EgZBaVUqQNKCFw1Pc81vbCfnReXL6g5HP
	CZPBINUST1led2ZQMwdsjlHRZyDzlCMGwo2nEfOZ6r1+f9B3iFWazCXhC43Cx0MTZurtWMEEPyD
	/8N5k1KaD7iUlhvqRm/AAMJydVzjVv2+2RxvmrjSIelnZ9tXFGD6psWpzvF6Qxx3TE4meIW5MCw
	=
X-Google-Smtp-Source: AGHT+IEe/y6XNr+Pufr0eUp0xR/8PGJhWQHFkFpwqwZ0egi8lWAzXxHeV34fKxnQfAGSlETNCc8Irg==
X-Received: by 2002:a05:6000:178a:b0:391:1458:5af7 with SMTP id ffacd0b85a97d-39114585b3dmr3675285f8f.49.1741085316629;
        Tue, 04 Mar 2025 02:48:36 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.138])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e4844a38sm17445161f8f.75.2025.03.04.02.48.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 02:48:36 -0800 (PST)
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
	stable@vger.kernel.org,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v3 4/5] phy: renesas: rcar-gen3-usb2: Assert PLL reset on PHY power off
Date: Tue,  4 Mar 2025 12:48:25 +0200
Message-ID: <20250304104826.4173394-5-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250304104826.4173394-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250304104826.4173394-1-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Assert PLL reset on PHY power off. This saves power.

Fixes: f3b5a8d9b50d ("phy: rcar-gen3-usb2: Add R-Car Gen3 USB2 PHY driver")
Cc: stable@vger.kernel.org
Reviewed-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Tested-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v3:
- collected tags

Changes in v2:
- collected tags
- add an empty line after definition of val to get rid of
  the checkpatch.pl warning

 drivers/phy/renesas/phy-rcar-gen3-usb2.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/phy/renesas/phy-rcar-gen3-usb2.c b/drivers/phy/renesas/phy-rcar-gen3-usb2.c
index 39c73399b039..c663910d6163 100644
--- a/drivers/phy/renesas/phy-rcar-gen3-usb2.c
+++ b/drivers/phy/renesas/phy-rcar-gen3-usb2.c
@@ -537,9 +537,17 @@ static int rcar_gen3_phy_usb2_power_off(struct phy *p)
 	struct rcar_gen3_chan *channel = rphy->ch;
 	int ret = 0;
 
-	scoped_guard(spinlock_irqsave, &channel->lock)
+	scoped_guard(spinlock_irqsave, &channel->lock) {
 		rphy->powered = false;
 
+		if (rcar_gen3_are_all_rphys_power_off(channel)) {
+			u32 val = readl(channel->base + USB2_USBCTR);
+
+			val |= USB2_USBCTR_PLL_RST;
+			writel(val, channel->base + USB2_USBCTR);
+		}
+	}
+
 	if (channel->vbus)
 		ret = regulator_disable(channel->vbus);
 
-- 
2.43.0


