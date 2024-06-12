Return-Path: <linux-kernel+bounces-211801-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AD40905712
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 17:37:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D90E2860C1
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 15:37:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB7AC180A96;
	Wed, 12 Jun 2024 15:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JMBZUz1w"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6F8E1802D9;
	Wed, 12 Jun 2024 15:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718206615; cv=none; b=sGkxmkyE1k0FUz3UQXylXZr0YfK7A/CKIEDo8Bv2wLsSTVmsA3DjyMnyJEYrXASHpmGuyej9OR1D+duR/s8sxHSFcr/Dg63Cl245GfciI9gZXDBcd/0zgz4wa1qLFupwh2k5O1thb+uCegvC8UKzSN3tEELWdodCCH4LKeqeIMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718206615; c=relaxed/simple;
	bh=B2EJY2fdWyqPC/dobzAD2r4rS7Bv1HJFs4E5f1twlDw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=cYakpF0V2xFtz32O34rcGoYhWh/w/GeEQsXBNpRiEVjLD9KIa78SYXRLBE4LMQPwsvIyKqav+oSECqdrZbhT+FIUYK3sdf/nrcrx7ikuGzmW/CNaDizienAxKXADRCzOym8nW3kiU8ER7z4501tcOsUt2+UczzczF9cvGOO7aE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JMBZUz1w; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-705959a2dfbso878778b3a.1;
        Wed, 12 Jun 2024 08:36:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718206613; x=1718811413; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=XnDR5q/QFjNu5mCGyDWLErYmJ8MVjBhaUzMoGVIo8jk=;
        b=JMBZUz1wjMjrmAAD3HW7znzFUst9of2MdzN44C3AaxpMQjZUr6Ov652dKNNblW1gkS
         DiUxsgMnSJ3Rh5fX9Lb+TmdhzfzgdQjowfvcSMRmFtwTqIk9pMZk8KXn/eRl3dGdBtxx
         mGhMGKq33olyOZ3QYp91wt3AMamDjm002zWGPUtHBryphFi1ozk+FC2SjxDRjiZAZEDA
         88bNs+BLBPKi64d5ycFB9KK6SUl7i+J26mE/I99GEnBdMC8DYIF/R4cTINWr0LWrPxPk
         ZAyOtw/gnzs2JYSkEVwixWYiSfBXhJwtEFhMhao3ft+Qf91lbvbeIzW0xnIIX0hEIFGE
         q1GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718206613; x=1718811413;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XnDR5q/QFjNu5mCGyDWLErYmJ8MVjBhaUzMoGVIo8jk=;
        b=bzsto57HL19gaYqw2WGCVbWGvRbhvCLW8WKTJIFBME+4eveVsNOS1aeDWskY30HP57
         W082VcyV4AyuOis2ZGtKrYXxGlQdVNlphkthxnH8pnh0p56rshUtinJ0AGG2e1jJLbd4
         i0aHaOGJs4uKLN9hRFLHQHNdL16aahbdkaYSyljULFCbFmxq11PkSpnZlcyxe+TSTigs
         xwEK/1Z1wYiBYqQj5N9yl61hXaL48cSlWgfSRtPKHuSuoqPAyuq1hLL2d0ONRzjyHqpu
         dVwO5yJafKZUFkIfVymCD0xNZ89tB1497ypTIztgrcaYfZTq3aU88W3bUzJjOmANMuhZ
         3rRQ==
X-Forwarded-Encrypted: i=1; AJvYcCWqq1nzUqR47at+pyAAMRBdfsfmDQ2f2CSUMyZjlWkkC4YwPYo7qBOVHHE7zmGkKHTLPvBnFR7Wr5MS7vL2nrI2FjrSLQlP131H+PLckAwZAis4QAF6pN2aYn3jtulssqwyo0Fnk5ZC
X-Gm-Message-State: AOJu0YzxcvZHh3G+/kT5SR66/nhc+4n1jT0gaY2xUsIL5DhPtl73nFSO
	r4KVM/qGR8FoyEH43+4GwDMSMO1EJYzDY/ZlgV/hHit/iWP9hp5RFO2zJP/WRN1K2g==
X-Google-Smtp-Source: AGHT+IE/78o2hZQABwUKV2pzbe8Jz7OUiKWMrndcbFANDCxShjvxfPVjD/sUV5fsJnq+nTNDJIU11w==
X-Received: by 2002:a05:6a21:8181:b0:1b8:4486:fb74 with SMTP id adf61e73a8af0-1b86d375013mr6421591637.25.1718206612918;
        Wed, 12 Jun 2024 08:36:52 -0700 (PDT)
Received: from localhost ([113.143.197.225])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-6de279e1e20sm10223267a12.82.2024.06.12.08.36.30
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Jun 2024 08:36:52 -0700 (PDT)
From: joswang <joswang1221@gmail.com>
To: Thinh.Nguyen@synopsys.com
Cc: gregkh@linuxfoundation.org,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jos Wang <joswang@lenovo.com>
Subject: [PATCH v4, 2/3] usb: dwc3: core: add p3p2tranok quirk
Date: Wed, 12 Jun 2024 23:36:25 +0800
Message-Id: <20240612153625.2368-1-joswang1221@gmail.com>
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
v3 -> v4:
- no change
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


