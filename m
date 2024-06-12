Return-Path: <linux-kernel+bounces-211758-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A25A790567B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 17:11:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A337286F18
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 15:11:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 991D3181B84;
	Wed, 12 Jun 2024 15:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PfaolSLj"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7541A18131B;
	Wed, 12 Jun 2024 15:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718204854; cv=none; b=S2PrExFGaeTE+p+AbMyS2kutFO/tsyB6EUzKynHDXI2c0Z8VqwgX06VZTBGvL8HZ3lf1ufgWLLFmKRAjemdHW1Bpsws5AeZTsDJyhCh0crvgSZNqANa6L+CkTwplBSSzIgX7whhLCvQxgJARfsVGJepcbYN3q4vs7MLOUZqy1uQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718204854; c=relaxed/simple;
	bh=AEdp41grZ7smqjvikNgkrPlZJz64+dxMSUEJtvA8Se0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=Jrc7GmSeZbXcKC/SZ7oioAHXIAYwBM1yruqjNClXtabRu6We9jMgtlmc4MPiJwjKOcix8LbNZ7wb8OeacinuLPb34ZhL9shwwMqeIqzF0eIX8Z6aqJ3QRSqmyE/S897QC2+3Lf9wMOqkkE24h2n9wKyHzI96sXg6jeQt63hxl0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PfaolSLj; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-705c7e2d31cso194408b3a.3;
        Wed, 12 Jun 2024 08:07:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718204853; x=1718809653; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=de53VCSP+1Fk6NTgs8BHySBUMjOfP3GoW+uQPcFGoBI=;
        b=PfaolSLjoi1XUQpj8Ka8DiB0tNqvpgyXm0J7e8k5ryQtQndAYX8pi30D0QEGtuD1Rn
         tJyv1Pfcuewxwj/9hm/4YWn55Bd0Fb1+6h1JbMlasA3dKzoag2dJ/RqdXBPnaPOMFK1S
         hUKdon4f7Am/ukT+8D/XWu5gSD6M9PpgMydvgJ5A7Q+2RIaAAr6S1/V0NW9jJcrsbQ2t
         ElOwicvM5hOHbi0B0AFHTHXceV2h/Xj04qXxkhHY+aDTepUN2HTjpeQOPoahoRioFnt6
         qmHG2yux39qe4xOulawpKXg6SCJnjAyeYq+Bjdv1+7PE0G9p+Ej0Q4OepNheZ9B78J5u
         2aPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718204853; x=1718809653;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=de53VCSP+1Fk6NTgs8BHySBUMjOfP3GoW+uQPcFGoBI=;
        b=aUuUT6g5oUReuUZmryeO4CoIODzqvs+Q3lJsXW022I0mqY/tUGv6pq2u4oN8ok0ivY
         CccqOJ0zMq106zXy09QgCTGAZiTlywI0e1aB4ow233obLsJI/DmZ0zstabtUwfcvXNd7
         3EKFTbhfYxxA4CTAxHzYY45EZVXydOu8xcR19BnR0lk2x/SxO8GN9fE3r1hkp9pN6fao
         VgtdaXVIzMChANbpRrWY81v4u7Dkdc76DR7AuUwlcHbHvu9FC2GIRqTtUZ8C+u95j6Be
         YUofn3Hc+rhA+zge6eXoZH41IGx0Z0Lw/K+A6JO8D3+aS5O827DJOa7vo8zzwcQjRsA/
         DEXg==
X-Forwarded-Encrypted: i=1; AJvYcCWTDMKgS850iBVinDxcEEOvU9C7iEtqGIxgmVgGXeFVOgLXzUteHf9oLDfx4CIkZFwZOs/1Epw+S95YuYlTGUL9Im+INX1VuSfkIR3DwLNdsVwcG4BiKVW6I6IMqEqzwn0uw5PZUUm2
X-Gm-Message-State: AOJu0YwShuVFtEXCoSE0fq1l2DubVdsyiYVMcswIeuBljOHZRnnimfQK
	YAgmdox+zOMpm1QPasAwW7q6vHI4MSe1yp/1iKXEEmGgIsL0Db/J
X-Google-Smtp-Source: AGHT+IGET+0saUfgwHn28NUAEnP9WP1y5seckJICErXi/Wa7YOBOPkCo6NoqKYKrE6XVsc2GzRTBHQ==
X-Received: by 2002:aa7:8888:0:b0:702:65de:19e5 with SMTP id d2e1a72fcca58-705bcf032aamr2484369b3a.33.1718204852569;
        Wed, 12 Jun 2024 08:07:32 -0700 (PDT)
Received: from localhost ([113.143.197.225])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-6f75f3377f8sm2413661a12.60.2024.06.12.08.07.30
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Jun 2024 08:07:32 -0700 (PDT)
From: joswang <joswang1221@gmail.com>
To: Thinh.Nguyen@synopsys.com
Cc: gregkh@linuxfoundation.org,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jos Wang <joswang@lenovo.com>
Subject: [PATCH v3, 2/3] usb: dwc3: core: add p3p2tranok quirk
Date: Wed, 12 Jun 2024 23:07:23 +0800
Message-Id: <20240612150723.2299-1-joswang1221@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240601092646.52139-1-joswang1221@gmail.com>
References: <20240601092646.52139-1-joswang1221@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

From: Jos Wang <joswang@lenovo.com>

In the case of enable hibernation, there is an issue with
the DWC31 2.00a and earlier versions where the controller
link power state transition from P3/P3CPM/P4 to P2 may take
longer than expected, ultimately resulting in the hibernation
D3 entering time exceeding the expected 10ms.

Synopsys workaround:
If the PHY supports direct P3 to P2 transition, program
GUSB3PIPECTL.P3P2Tran0K=1.

Therefore, adding p3p2tranok quirk for workaround hibernation
D3 exceeded the expected entry time.

Signed-off-by: Jos Wang <joswang@lenovo.com>
---
v1 -> v2:
- no change
v2 -> v3:
- modify Author Jos Wang
---
 drivers/usb/dwc3/core.c | 5 +++++
 drivers/usb/dwc3/core.h | 4 ++++
 2 files changed, 9 insertions(+)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 7ee61a89520b..3a8fbc2d6b99 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -666,6 +666,9 @@ static int dwc3_ss_phy_setup(struct dwc3 *dwc, int index)
 	if (dwc->dis_del_phy_power_chg_quirk)
 		reg &= ~DWC3_GUSB3PIPECTL_DEPOCHANGE;
 
+	if (dwc->p2p3tranok_quirk)
+		reg |= DWC3_GUSB3PIPECTL_P3P2TRANOK;
+
 	dwc3_writel(dwc->regs, DWC3_GUSB3PIPECTL(index), reg);
 
 	return 0;
@@ -1715,6 +1718,8 @@ static void dwc3_get_properties(struct dwc3 *dwc)
 
 	dwc->dis_split_quirk = device_property_read_bool(dev,
 				"snps,dis-split-quirk");
+	dwc->p2p3tranok_quirk = device_property_read_bool(dev,
+				"snps,p2p3tranok-quirk");
 
 	dwc->lpm_nyet_threshold = lpm_nyet_threshold;
 	dwc->tx_de_emphasis = tx_de_emphasis;
diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index 3781c736c1a1..2810dce8b42e 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -327,6 +327,7 @@
 #define DWC3_GUSB3PIPECTL_DEP1P2P3_EN	DWC3_GUSB3PIPECTL_DEP1P2P3(1)
 #define DWC3_GUSB3PIPECTL_DEPOCHANGE	BIT(18)
 #define DWC3_GUSB3PIPECTL_SUSPHY	BIT(17)
+#define DWC3_GUSB3PIPECTL_P3P2TRANOK	BIT(11)
 #define DWC3_GUSB3PIPECTL_LFPSFILT	BIT(9)
 #define DWC3_GUSB3PIPECTL_RX_DETOPOLL	BIT(8)
 #define DWC3_GUSB3PIPECTL_TX_DEEPH_MASK	DWC3_GUSB3PIPECTL_TX_DEEPH(3)
@@ -1132,6 +1133,8 @@ struct dwc3_scratchpad_array {
  *			instances in park mode.
  * @parkmode_disable_hs_quirk: set if we need to disable all HishSpeed
  *			instances in park mode.
+ * @p2p3tranok_quirk: set if Controller transitions directly from phy
+ *			power state P2 to P3 or from state P3 to P2.
  * @gfladj_refclk_lpm_sel: set if we need to enable SOF/ITP counter
  *                          running based on ref_clk
  * @tx_de_emphasis_quirk: set if we enable Tx de-emphasis quirk
@@ -1361,6 +1364,7 @@ struct dwc3 {
 	unsigned		ulpi_ext_vbus_drv:1;
 	unsigned		parkmode_disable_ss_quirk:1;
 	unsigned		parkmode_disable_hs_quirk:1;
+	unsigned		p2p3tranok_quirk:1;
 	unsigned		gfladj_refclk_lpm_sel:1;
 
 	unsigned		tx_de_emphasis_quirk:1;
-- 
2.17.1


