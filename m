Return-Path: <linux-kernel+bounces-197786-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 017DA8D6F1F
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2024 11:27:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 708EF1F22811
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2024 09:27:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0DD014E2F8;
	Sat,  1 Jun 2024 09:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZkIf7dQ9"
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C48D014E2E7;
	Sat,  1 Jun 2024 09:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717234019; cv=none; b=WTFbBTcS/+iQaMRtQ0qKQBruSNx1wzMNOy5il8oEafxh5u5/ermMaEN/Ot4+HvEZ5S3SSNzDwHE/JR0gLXfhEsizhyqihsYOY2QbsFZK2DWRyOuW/3mdByIxh8i+E/wYaMpp6eSxVjYYKrij912ASPDKJd6mXzO6b8PB/c3xxxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717234019; c=relaxed/simple;
	bh=WIbbh2QIEse26jjLM2QZGcRptTEmJwSZHC3dc6xVXTI=;
	h=From:To:Cc:Subject:Date:Message-Id; b=WN7IJGz4VKxnMX1NbuqGtMaqiEmOkG5731NJvGmO5dssnjUP69N6IqFm9Tku5G8Xk+fx4stt8fwvDF0vSYkPAUrqBh5kCF4UNU46Cu+eOMdwYaYtSQ2igESxdn/9VcwZI4LI4cG7oc7NJU6IA6GGdJkUUY4E1lRtWU4J6PpaIz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZkIf7dQ9; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-6f855b2499cso1766074a34.1;
        Sat, 01 Jun 2024 02:26:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717234016; x=1717838816; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=POWEYsGteFBsH2FZNkJsEWH+VNGD5DA1v64fZi4BMrU=;
        b=ZkIf7dQ9zBnSp8379Cws1L3jbXb7jXT20xLWjwkQopbk9WvFeDmZbkaEyKoyRpv26z
         s0H47FprefKadK2jlFbIlIvBNa/oKjmmobtT1OohwAJAg2QetFkqzNm6jaSNv19o262j
         o+V2LwYPTG3b7HEYgFgcVOiUscwPaGwdmwKe+7EOohzjsgotOx+p1NkKoymseJ7FdeGb
         TF4Y7NSpwJa+IUjThLYkS+V1h8Xwr0ViTtTXgBExqcAgiUOoLGhHhgY3UUmsLXhRt7lN
         MbK8Bz3r6xZWvoPc3+/RU6jU+EwrbY1E1yyzHQkXsmaeP52wpWj8ohj0CGv+TZnJJ55u
         RV3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717234016; x=1717838816;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=POWEYsGteFBsH2FZNkJsEWH+VNGD5DA1v64fZi4BMrU=;
        b=WOqoy5+WMLSDgcscGFphwsrEK9mKaWDKdUZmMNoHOqyIVXR/9shUmOreIMUhCdSqOT
         I8O8tHSrNSfVQufLqXacboDESYgnthkWGOzPHN/OzA70gzO+j2CuBjaZZ2x/p7el5Tjl
         ZZ7wiYCY0F6uOfgdmzs9EiW7S38OkVPa+3MD1q+eYOERZm4Oi8duUt8KxlC31Csy3Ozq
         nlTwtgU9vRn7DDYY7qaqxjr4Z0B1CAivkxOomnz92a9eQwL1i9afgrflqMCUeCYTqlgH
         2H8ZRk7hWw3ZAftWMibaMry2b8/PZb8DSDU8mKKugs6GdNLHHnYpRWcgX9iYLLPWpCPp
         4oFQ==
X-Forwarded-Encrypted: i=1; AJvYcCXx4HlH03JcZnrFRKs2jw52+21sf5+rlEufXlGZEgclEJNky8ofMfAIcIOd+gtJDa77jXo2ADU8JH8kW/kZGAApeuSQNMiB51jNdYL1MjKE5ik6+W8enZE8Tk7tPMcBU/Qh9ZkrlgaG
X-Gm-Message-State: AOJu0YxXqYllL+URW+lkKAc6DZakKmODDS14TfqpIy0F0LbbdjqUhtgt
	t8BCn09jqj7nycXkvYoTeiEhrmQLNhMX5Rw8v/gHk+05AccFpMdUny6VBrwxHQ4=
X-Google-Smtp-Source: AGHT+IGtlKmP8b1TTPHLk8+wYZaiUOWCgZoPi/0gYX+coLg5+FhXw5YVYCXxurITDbPyYoJSBYHEFQ==
X-Received: by 2002:a05:6870:a11a:b0:250:7913:170b with SMTP id 586e51a60fabf-2508bc5cd0dmr4711729fac.55.1717234016396;
        Sat, 01 Jun 2024 02:26:56 -0700 (PDT)
Received: from localhost ([219.144.1.218])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70242c26bafsm2562979b3a.219.2024.06.01.02.26.55
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 01 Jun 2024 02:26:55 -0700 (PDT)
From: joswang <joswang1221@gmail.com>
To: Thinh.Nguyen@synopsys.com
Cc: gregkh@linuxfoundation.org,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	joswang <joswang@lenovo.com>
Subject: [PATCH 1/2] usb: dwc3: core: add p3p2tranok quirk
Date: Sat,  1 Jun 2024 17:26:45 +0800
Message-Id: <20240601092646.52139-1-joswang1221@gmail.com>
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


