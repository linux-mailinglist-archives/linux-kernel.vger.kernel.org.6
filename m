Return-Path: <linux-kernel+bounces-199168-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 84FA08D8362
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 15:04:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C6071F277DC
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 13:04:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F86D12D759;
	Mon,  3 Jun 2024 13:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QbSaRR89"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71A57548F7;
	Mon,  3 Jun 2024 13:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717419696; cv=none; b=qSW1HyeeJcj0bpSeshOqHHy/ODCHOYw53fYos42pOc7+wswI9YXfAOSre5APZm7G0ZGhCz8Jm0a6RROfAS07tgnM1K2FG/W2S5H04Nogc9P9TXcoZnyybmEdVdQT79dYs374rMOVKYuKPau2O3I5JVkIVm9NULjvAU1uOhTAci8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717419696; c=relaxed/simple;
	bh=PrLCp0GMZR2AicoILi5xjZz0ZaYXxDiO5O/INT0TxmA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=dcklFj4nSTZSQ6E55v8HtF0Rcw5BZgvuWTTm5HGC6pdzhgkChRSPQ5N+khbyyhrAT9TnqZIDJ+rBXjCbncVG9nE7RaHJw4s+yeMzeufoGeEuOrCuwaUVxe7oPx8GkMQmWiiiepxS+aX8C0yNtye/MoaR4ftLTAa0pbMCqNB8E/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QbSaRR89; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1f32a3b9491so32440925ad.0;
        Mon, 03 Jun 2024 06:01:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717419695; x=1718024495; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=V5Eco+bAOpNwEo9sPBF5nVVnr6HX74idMy7ovbj8FmQ=;
        b=QbSaRR898pF7X5tztDKirq8cjB+WK3mPMb5Wn7uspcCNC7HS+dcY+k9n+sQiXUiN6B
         qCspKCnsOD8vSA8W2RgZfa+Z2cCkBIhRPnFoJDjz1J9ovfoOIbO/bPRnn3zgQPjgg5NF
         SHT7i8ZQQBueLIxc+8yZLdtzJ1WrO2gIlfNHnlsMMlSzlmP3ZX0lMIC6UiE2yJE9ZAa2
         tOLNeV+0jyN6H1AyLqYMV2ZcEaYzVgJmUyrEmoUj2oXmumP9oFoDlFtxrhT1tIHeMXxh
         IiDmYxuFMYCmYxfwDMBCfysWXG3knwsSx11Q2t8K/APsRVXiQQ02Gf4cOkXSvwDcjduY
         Ylhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717419695; x=1718024495;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V5Eco+bAOpNwEo9sPBF5nVVnr6HX74idMy7ovbj8FmQ=;
        b=JaigiFGiH8ScJhpt7L7ZxDmkc19c8cKRvrBeL+q1h5wqsFd0kUMI9+mWSVID9W8HJE
         kEw8x00tKl2kmrHT1Ub3qVxkoEz3RNzxHDbbEcmtdLtHWeKO7UdAdeN7d9S8yjQKz89W
         umxsDtcLYDhUjaRNCTrIKPAB8OJhRDxtihfMSLDY9+D8CZ5Z/eXaF1nxKsiqi0GjN/My
         VXv+V7PnFw1oI8+TdszG3OyBi2Ls40r0Kyrj3cvebLa+qNs/J06uc5KFlIyHMGlxu2BQ
         JhFSH3Ie57vGBGW8ZKdGojbtJrkLyPxQE/ewHrFK42YOJXiGKxFd3jTnafRu6FX31o5X
         OrlQ==
X-Forwarded-Encrypted: i=1; AJvYcCWP9oKU1BF250OHQJL0+QZnrCzwOwijR2/52mgCigtKLyLebGjfjOtkE7apAZB61/NcTYLW0whEb0x8Zd8juQTCuP52RXJIoaQTI6UI7xUUZtTyhUjIWo6OasCODB7kwlaxunB3Q2+Qe4thGaUMuJqUspDJad26GVzQerAddV6LrgoxYQ==
X-Gm-Message-State: AOJu0YzbWiw1RqvP1LYrDcmRqiZToryV/KrqX9w4kFwsBf31yFOtr+KR
	Pr3+9tUvGMpgGyCkOs0xPHvG/gEXZZowH8tz4VN9CQtOs1OaSIv1y64sFmESrTo4Cg==
X-Google-Smtp-Source: AGHT+IGu0uqO6bboZ3ylaYT0xnOgZ6BdrPSrQAS6swrdZEy0eKPDV9aF2els8oTYVPJ+mYkovbwpPg==
X-Received: by 2002:a17:903:41cd:b0:1f6:6ef0:dae9 with SMTP id d9443c01a7336-1f66ef0dcbfmr39640165ad.42.1717419694383;
        Mon, 03 Jun 2024 06:01:34 -0700 (PDT)
Received: from localhost ([36.45.244.211])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f6323562b6sm64138665ad.73.2024.06.03.06.01.32
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 03 Jun 2024 06:01:34 -0700 (PDT)
From: joswang <joswang1221@gmail.com>
To: Thinh.Nguyen@synopsys.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: gregkh@linuxfoundation.org,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	balbi@kernel.org,
	devicetree@vger.kernel.org,
	joswang <joswang@lenovo.com>
Subject: [PATCH v2, 2/3] usb: dwc3: core: add p3p2tranok quirk
Date: Mon,  3 Jun 2024 21:01:26 +0800
Message-Id: <20240603130126.25758-1-joswang1221@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240601092646.52139-1-joswang1221@gmail.com>
References: <20240601092646.52139-1-joswang1221@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

From: joswang <joswang@lenovo.com>

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

Signed-off-by: joswang <joswang@lenovo.com>
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


