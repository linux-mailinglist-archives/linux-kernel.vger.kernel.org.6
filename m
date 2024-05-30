Return-Path: <linux-kernel+bounces-195583-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C48A68D4ED6
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 17:14:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 624501F25D8C
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 15:14:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D66418756C;
	Thu, 30 May 2024 15:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="my013GmM"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 089C318755D;
	Thu, 30 May 2024 15:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717082056; cv=none; b=A+pYBfImtomNG+qod+f4ggHOR/8EhLFM7EWhVUBCuTGXSHiHm96Dofkzq+8PB5YYID4J6AIOxvhWdU+Ww366+C42T+CZ4yiYl/m3syZfUPGu8zoVxvP8WOHpez84LdDEJHuOSnpXMBuaGaGItQ1VwIdyKduwy4FS1tQYFl+Jvsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717082056; c=relaxed/simple;
	bh=WIbbh2QIEse26jjLM2QZGcRptTEmJwSZHC3dc6xVXTI=;
	h=From:To:Cc:Subject:Date:Message-Id; b=PXzITOVziOh43Dv2zM3ygVcrTBgNXIoXDMelGv4tmbyF8PwVNkuy7RHVNAeJkFdqZI+ZtTE128EyZS5AP6HOfbCq1L0wRA9FooHJwVaqilPydm+7gVpK9JS/7cAoMmJsJzUAXF7eEpPkgPHQvXsEvfM/C3tXSYJNiiKhRJJLNns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=my013GmM; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-70231ac9093so743276b3a.3;
        Thu, 30 May 2024 08:14:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717082054; x=1717686854; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=POWEYsGteFBsH2FZNkJsEWH+VNGD5DA1v64fZi4BMrU=;
        b=my013GmM7FWATseWx6v6ZmgH4OZZAsT9IztuiSkjPRmr8mtjqIBzUL0NJK68YHcyZF
         mzmJLT5io1neE+MLPiqBHTIkFxY093L2XPaIICTmUHso1Vbqu0PyPriENO4tM09id7No
         Sr3S95yk3A0D5JvaoWxD2MIq/BK18gCEn5Spg2iKjxFajcNuHzd64wb2DZem8dlQNIYI
         P3ssaNd2TYeh2RTFZ4EnR46H/Mrt2Sve2jCO32WTgczDQf8NMVGMvvrdYxG9A5c37Kml
         wRbe/8tLdaTodctr2vAxYeKZrw6yXKfOzGVgRGdo7yq7VYMSo9nDUME7OYr6963X8vVv
         /YmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717082054; x=1717686854;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=POWEYsGteFBsH2FZNkJsEWH+VNGD5DA1v64fZi4BMrU=;
        b=WXzPRtsaAfE8PwHx1m5LAa5gosND8vOh97qeAHSA9coN9hN6nDyEpXFL+52l/6jwCx
         XG9vbfXsO2HAAJ4hBI2tFT4JF9xQztD5dPX+eZMvaMhBpzU9BOvjHU4M1xRhJRGxnOQy
         NutqU/Phkb2lB29DkyUpEjwC5Q/yZnza4A7Q3bRYOVaA0EAyjkYl3QSmANuK0x1Gf8jg
         OVyRMJ0RqQOpGQOQnUBY5rORf6bYYyxFsE17SK0r+lRA/hTZ9dnBw11aA3GpAAeaN+2p
         6mubsYyhVHAySsNRIeRMFI3pK7SSk3wPAslUHpwnaxw/ZocakY+ue74gm2Vbgq76OQlD
         uNxg==
X-Forwarded-Encrypted: i=1; AJvYcCUI6qbZnqzAhK9P8DeBmVfJv5NVquVklfNK7CIDKBm2s5pDGiU1KzsPK9mywJvRSOwvqP4zVV1fkPs3Q7MgdUhdmlJA9E5gFB0eWglMW8D5IPmRHIclr1CCKjDunjCqALTeM7Qu8kYi
X-Gm-Message-State: AOJu0YzYqgHBSaYX1tkwTWsi+NEr4PiZqcB2sH7HrrP+4p3eYCROoxcG
	gYZU/uC8QYUq0dw+Y2CNp6xCjtZMhZCBmQ5ONIz7v7KOke04Adtu
X-Google-Smtp-Source: AGHT+IGICTP5sklLFqbs/ZwVa6ppaEurwlGt53+Midop+1P6fL/wAwqHWhlksi7i6tSOKUtz3E7Y8Q==
X-Received: by 2002:a05:6a20:104c:b0:1a7:7ac1:a3ba with SMTP id adf61e73a8af0-1b26460b783mr1963623637.53.1717082054022;
        Thu, 30 May 2024 08:14:14 -0700 (PDT)
Received: from localhost ([36.40.187.183])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-68226a133d0sm10738538a12.62.2024.05.30.08.14.12
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 30 May 2024 08:14:13 -0700 (PDT)
From: joswang <joswang1221@gmail.com>
To: Thinh.Nguyen@synopsys.com
Cc: gregkh@linuxfoundation.org,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	joswang <joswang@lenovo.com>
Subject: [PATCH] usb: dwc3: core: workaround for hibernation D3 entry timeout
Date: Thu, 30 May 2024 23:13:39 +0800
Message-Id: <20240530151339.45572-1-joswang1221@gmail.com>
X-Mailer: git-send-email 2.17.1
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
GUSB3PIPECTL.P3P2Tran0K=1. However, note that as per PIPE4
Specification, direct transition from P3 to P2 is illegal.

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


