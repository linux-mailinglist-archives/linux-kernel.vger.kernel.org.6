Return-Path: <linux-kernel+bounces-269099-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CCEC942D97
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 13:57:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB83C1F24920
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 11:57:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7224A1A8BF4;
	Wed, 31 Jul 2024 11:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lWPQFkdf"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AFCB8BFF
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 11:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722427020; cv=none; b=YG4/+j5usb+IjRhrB6rneukCI3vZkzweiLd7sytT1Q0S0Moq8UqGhexW8sc1H8rW1AGYmxHxhqEGPRr1VDVcIE9myGrt7AV7uOUVQR3GUN1XKLg1URm8hJEpWkh0MqEPf08Cz811pmWDY2iZphO2CuGOAHgM3vA3WYAQrjhgBgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722427020; c=relaxed/simple;
	bh=Qs32DugEbUtTid4Jfkr2SBkGin2nQ+Ig2mACeMrdLsk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HTUVhMOZu54Ao9FzBgP9R4Tj5+EgfW8xoRsfXMyKzMSXiAbejVIUij5qiG6m+L6usirDKCv/CzfnvsjtMXnpRFhXfh2L97MNMF5XMhYiLzhHljTBpOY0oBC/n4338b14Qz81l1uu/k7vNm7HZizGAxwhjIy3+iNH7tq9Mf77s2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lWPQFkdf; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-70d199fb3dfso4768119b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 04:56:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722427019; x=1723031819; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dD4/LuujpP9SBy4N2qvay9vEiTkzSElUnCkU/leHG9k=;
        b=lWPQFkdf9c7jLlc9wXJajA313Z9eNZS0pe8XclqGwLKtKBv4PI8R7Dg0C4CJb0QTee
         V/UBujtGagddvNkHARRrQ7s8d751dintxQmW/tGeYsSvkspLocMiLB3AhzgrwDXlCQsq
         qCWz8K9+A/vSbK0Zd3XtTdHFiliT8aeDdhf8x+bx31/mpp2eBrl4aF6UNbgmFlDVd6ag
         9YNbbthBeDqphGferHqV2vkNx1iIXhjlONJ5gTwoLS389iQrSyObVSq9gLh1bTy97WAh
         SQzc07395jE+PegeAo8wvX8DIHa43lb/d16ve4RjPXC0KrA5bq37z2ODLlOCZUye4anI
         k/FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722427019; x=1723031819;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dD4/LuujpP9SBy4N2qvay9vEiTkzSElUnCkU/leHG9k=;
        b=bTWpN7AbCf5OXF3Rw8w+ZslI6lVR/pgXt7nLlr4NDcTGZg4CAJkYJy6Q8oXgC5N6KC
         6hIYz1Rrwr/5IVQEBRv8tv0/N0yyzZi9gHfe6K8WpkhUOnijPd544SQNR18hu0EQ11eA
         NMB1zTPr/X2piHUd4UC9lgF+qij7doVkP/8fzNiZGDqVk9vnS7DsHttWnFRP9bnTu63g
         LuPnW74mUVFIqJgkE6NPPYbGtdp002Emj5nCiVi3BOaZaotiL19hQNAg0Up/roXMrBtj
         DJJ2fDH5+M8SnulZHCc0ypDE1nIhWxKhmoafIpi3045xRYV4VuUrImrzwIblrIa1VA0S
         /CRA==
X-Forwarded-Encrypted: i=1; AJvYcCVA3Df0zAKszAUUbjsY5SulCYGsmZcPVQ25A8Rd5TYRHQrVQ5Jnr4Jdg+nI9seKjJrMW5g8dQdeH+B1zoXIip8A5jIuAMgxgGmAVMYM
X-Gm-Message-State: AOJu0YyMkba5KqUxeGh5Lw8PqirhXp0dtXECB4OcK9L/qZtV86uz9G9Q
	L/U217PRt3esiU/TzxDjbhvd8dXXJQhl+7WH/Fl24IU25Zfgmlv2BnxoK5ZKcA==
X-Google-Smtp-Source: AGHT+IHhzrMk8ZPLRuUWHt897/wD7XphiJN5ikAlVgi5bi29bcgDtMwJdyVOk9U+AKsWzI3Hh3MYYg==
X-Received: by 2002:a05:6a20:6a98:b0:1c4:23f0:9665 with SMTP id adf61e73a8af0-1c4a1321bd5mr12592532637.29.1722427018525;
        Wed, 31 Jul 2024 04:56:58 -0700 (PDT)
Received: from localhost.localdomain ([120.60.134.159])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2cfdc4a94c4sm1138242a91.42.2024.07.31.04.56.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jul 2024 04:56:58 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: vkoul@kernel.org
Cc: kishon@kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-phy@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v2] phy: qcom: qmp: Add debug prints for register writes
Date: Wed, 31 Jul 2024 17:26:37 +0530
Message-Id: <20240731115637.90351-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These register prints are useful to validate the init sequence against the
Qcom internal documentation and also to share with the Qcom hw engineers to
debug issues related to PHY.

Sample debug prints:

QMP PHY: Writing Reg: QSERDES_V5_COM_SYSCLK_EN_SEL Offset: 0x0094 Val: 0xd9
QMP PHY: Writing Reg: QSERDES_V5_COM_HSCLK_SEL Offset: 0x0158 Val: 0x11

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---

Changes in v2:

* Modifed the debug print to include reg offset

 drivers/phy/qualcomm/phy-qcom-qmp-common.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-common.h b/drivers/phy/qualcomm/phy-qcom-qmp-common.h
index 799384210509..40beb413328f 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-common.h
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-common.h
@@ -9,6 +9,7 @@
 struct qmp_phy_init_tbl {
 	unsigned int offset;
 	unsigned int val;
+	char *name;
 	/*
 	 * mask of lanes for which this register is written
 	 * for cases when second lane needs different values
@@ -20,6 +21,7 @@ struct qmp_phy_init_tbl {
 	{				\
 		.offset = o,		\
 		.val = v,		\
+		.name = #o,		\
 		.lane_mask = 0xff,	\
 	}
 
@@ -27,6 +29,7 @@ struct qmp_phy_init_tbl {
 	{				\
 		.offset = o,		\
 		.val = v,		\
+		.name = #o,		\
 		.lane_mask = l,		\
 	}
 
@@ -45,6 +48,8 @@ static inline void qmp_configure_lane(void __iomem *base,
 		if (!(t->lane_mask & lane_mask))
 			continue;
 
+		pr_debug("QMP PHY: Writing Reg: %s Offset: 0x%04x Val: 0x%02x\n",
+			t->name, t->offset, t->val);
 		writel(t->val, base + t->offset);
 	}
 }
-- 
2.25.1


