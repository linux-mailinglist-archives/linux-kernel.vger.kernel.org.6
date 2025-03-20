Return-Path: <linux-kernel+bounces-570316-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 69C05A6AEC9
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 20:47:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3238B3BC3E4
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 19:45:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35C7C22B8C2;
	Thu, 20 Mar 2025 19:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="YF5vrJ+1"
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EFC922B590
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 19:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742499901; cv=none; b=mxZE8C/PHGPoLe15wrh8NRn2hgMhoIAbWH2sP/JWBACldIX/2TENfMoiQGxMxlSu9Crp68NKEkWSZ2YdvEYRjTo9r3BoUs2tFlnbUF3plsDtqjDUpxXnLdKaUgaDD7sxJVMDRd/GH/8Vv9t1ew7sXy98I94OVTza6lpYvX02FVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742499901; c=relaxed/simple;
	bh=lhzOWVrb/W5aWFiPKapeZ+c2qWJP4p7yGhuyvcKYsOY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f/uouWxqTxHWJUx9LMoTDmeW9woH8rC3yasEbc0foHM0aA576q3S9oqoZrq8K+PtnvADxwlp3gDMi+TfPwmzDfRUpZVDE+Ddbm0+IwQbo2rJrmDlUu75u1sK95AJg+Fdc1ViogO/kPDrdBZrqd2jNKlxrcdIpL5jbLfAnTPJjiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=YF5vrJ+1; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-85afd2b9106so115428139f.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 12:44:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1742499898; x=1743104698; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dlzkhyp/izF78g6ftxTkpFnLH1O8eZPqCB+owD+Ogvs=;
        b=YF5vrJ+1tURKY0daScOOk/sUXKdCJzd3oS+bVbHbI3L0uKalrD5UzinkDD+ol658uW
         m1U8ZHo5Z3c10/bK6LzdbO7+WKIdbKYQ8QAcM3Xwr/Z72RvFuj2hJeJwpYv7Zpjfe1aU
         R1ExE6u986ftRA+jAWx00HTpUwVxp4Hf4GZ8Zk+gQP2S8ISC8tW7Hl+04Q6WsBYiHtvx
         1QhFBu6gTIusSRbyzNmWmZ7xJgDwbXEgtRkencHOGCGBbnb56dTBh7RQeI4I+j0SdiWA
         NEtitv0N1aTftsy6MyKub8Ix9A5uteRjsf5tz220YbdKA1xwRU7+N/KbZRvhgVnAYNlO
         yhXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742499898; x=1743104698;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dlzkhyp/izF78g6ftxTkpFnLH1O8eZPqCB+owD+Ogvs=;
        b=AzqnJGkREsdreXhKVKUdFGJT9fX1BTUNdrykGnIcSlu8aQdYhYTwXYOo1WHCKXEVwX
         chuT4MjG/7+uk+ZSyjU9VkpGRydYhRxWBKPUGtDy1a0TOm3iFDb/suSeHET90ln3IRAr
         12tefaAJNkjii7QgaZBHEeUK227XYBN4VsFvdaNGqO0igw4wnNK6CNzed8v0GqU1N51n
         5kAeAiyCUIuLjj3Tkx6fEvn5RenRfr5lo0S193Ozrbzu/5YcJcCOaeFpJx81wVCnkaoV
         /dd1kw3hT3J4vMIO1qV7wmMLijDAF1ojebmPw0IQAY5EDpZC5c4nmZCoPgtORTh9ysWN
         cUrQ==
X-Forwarded-Encrypted: i=1; AJvYcCU06IoxiqWklD9tKFmAZC0AyIfZU+yihYooEk9Yc04TpuduoocwlY3xGL4M0XSZodW5XckqrDDJYXjnom8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzetHYCcE/nwEgPML3V+AUNy6Ws2KchWMTP59qzRvDighKmJo+l
	u+IpKgfa/cX70t5VIiQAad4ktaFzwN3DbhPsHNm6KozBuVO0z3q0bQ2Nn3RWzG4=
X-Gm-Gg: ASbGnct+iGHZJE9tPk1irTCph8SAqdpM+5SWjD64pJz6gCb8OoPidPr2g6nwVmzTqXs
	GOdia5TwVweT4DHNlpdeInzomc8lv8EbCIr1cCz5c7burQpqa+c1rOaJEZFzcTwkqgjTzMVkjcV
	YNYEbt1SoMUtGfl8UFYx027X920u9LHP0YmbROsPQkFzcp+RMcgIeWDEaf+R/k6leHW6p9BlgbF
	1edovZ8vO8ZD49Us73gh4Ym47UNLYWi/ifRDhGoQYxwfDafH2/UfW9ksG+1Vq3+sQU6duH3do2N
	OXaqEA9iFx+czFVsQjKo/1/1ta5XoBy+GGBe4SFC5KDhdDFIkBWwto7lqEjvXd4fpEFW5LqViNL
	9jFOIW4KILamNuqlxU7BWlsMx
X-Google-Smtp-Source: AGHT+IF5Um4wxnf1VBR2WUaWHAuuXv8maMmB3T9J09ThCkD0kILxqdXmbC6BUXhNgpO/3CkQqObwKg==
X-Received: by 2002:a05:6602:399a:b0:85b:58b0:7abd with SMTP id ca18e2360f4ac-85e2ca35536mr78053339f.1.1742499898515;
        Thu, 20 Mar 2025 12:44:58 -0700 (PDT)
Received: from zoltan.localdomain (c-73-228-159-35.hsd1.mn.comcast.net. [73.228.159.35])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-85e2bd8c40fsm8341439f.32.2025.03.20.12.44.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 12:44:58 -0700 (PDT)
From: Alex Elder <elder@riscstar.com>
To: p.zabel@pengutronix.de,
	mturquette@baylibre.com,
	sboyd@kernel.org,
	dlan@gentoo.org
Cc: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	heylenay@4d2.org,
	guodong@riscstar.com,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	devicetree@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/7] clk: spacemit: add reset controller support
Date: Thu, 20 Mar 2025 14:44:44 -0500
Message-ID: <20250320194449.510569-4-elder@riscstar.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250320194449.510569-1-elder@riscstar.com>
References: <20250320194449.510569-1-elder@riscstar.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Define ccu_reset_data as a structure that contains the constant
register offset and bitmasks used to assert and deassert a reset
control on a SpacemiT K1 CCU. Define ccu_reset_controller_data as
a structure that contains the address of an array of those structures
and a count of the number of elements in the array.

Add a pointer to a ccu_reset_controller_data structure to the
k1_ccu_data structure.  Reset support is optional for SpacemiT CCUs;
the new pointer field will be null for CCUs without any resets.

Finally, define a new ccu_reset_controller structure, which (for
a CCU with resets) contains a pointer to the constant reset data,
the regmap to be used for the controller, and an embedded a reset
controller structure.

Each reset control is asserted or deasserted by updating bits in
a register.  The bits used are defined by an assert mask and a
deassert mask.  In some cases, one (non-zero) mask asserts reset
and a different (non-zero) mask deasserts it.  Otherwise one mask
is nonzero, and the other is zero.  Either way, the bits in
both masks are cleared, then either the assert mask or the deassert
mask is set in a register to affect the state of a reset control.

Signed-off-by: Alex Elder <elder@riscstar.com>
---
 drivers/clk/spacemit/ccu-k1.c | 93 +++++++++++++++++++++++++++++++++++
 1 file changed, 93 insertions(+)

diff --git a/drivers/clk/spacemit/ccu-k1.c b/drivers/clk/spacemit/ccu-k1.c
index f7367271396a0..6d879411c6c05 100644
--- a/drivers/clk/spacemit/ccu-k1.c
+++ b/drivers/clk/spacemit/ccu-k1.c
@@ -10,6 +10,7 @@
 #include <linux/minmax.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
+#include <linux/reset-controller.h>
 
 #include "ccu_common.h"
 #include "ccu_pll.h"
@@ -134,8 +135,26 @@ struct spacemit_ccu_clk {
 	struct clk_hw *hw;
 };
 
+struct ccu_reset_data {
+	u32 offset;
+	u32 assert_mask;
+	u32 deassert_mask;
+};
+
+struct ccu_reset_controller_data {
+	u32 count;
+	const struct ccu_reset_data *data;	/* array */
+};
+
 struct k1_ccu_data {
 	struct spacemit_ccu_clk *clk;		/* array with sentinel */
+	const struct ccu_reset_controller_data *rst_data;
+};
+
+struct ccu_reset_controller {
+	struct regmap *regmap;
+	const struct ccu_reset_controller_data *data;
+	struct reset_controller_dev rcdev;
 };
 
 /*	APBS clocks start	*/
@@ -1630,6 +1649,48 @@ static const struct k1_ccu_data k1_ccu_apmu_data = {
 	.clk		= k1_ccu_apmu_clks,
 };
 
+static struct ccu_reset_controller *
+rcdev_to_controller(struct reset_controller_dev *rcdev)
+{
+	return container_of(rcdev, struct ccu_reset_controller, rcdev);
+}
+
+static int
+k1_rst_update(struct reset_controller_dev *rcdev, unsigned long id, bool assert)
+{
+	struct ccu_reset_controller *controller = rcdev_to_controller(rcdev);
+	struct regmap *regmap = controller->regmap;
+	const struct ccu_reset_data *data;
+	u32 val;
+	int ret;
+
+	data = &controller->data->data[id];
+
+	ret = regmap_read(regmap, data->offset, &val);
+	if (ret)
+		return ret;
+
+	val &= ~(data->assert_mask | data->deassert_mask);
+	val |= assert ? data->assert_mask : data->deassert_mask;
+
+	return regmap_write(regmap, data->offset, val);
+}
+
+static int k1_rst_assert(struct reset_controller_dev *rcdev, unsigned long id)
+{
+	return k1_rst_update(rcdev, id, true);
+}
+
+static int k1_rst_deassert(struct reset_controller_dev *rcdev, unsigned long id)
+{
+	return k1_rst_update(rcdev, id, false);
+}
+
+static const struct reset_control_ops k1_reset_control_ops = {
+	.assert		= k1_rst_assert,
+	.deassert	= k1_rst_deassert,
+};
+
 static int k1_ccu_register(struct device *dev, struct regmap *regmap,
 			   struct regmap *lock_regmap,
 			   struct spacemit_ccu_clk *clks)
@@ -1675,6 +1736,33 @@ static int k1_ccu_register(struct device *dev, struct regmap *regmap,
 	return ret;
 }
 
+static int
+k1_reset_controller_register(struct device *dev, struct regmap *regmap,
+			     const struct ccu_reset_controller_data *data)
+{
+	struct ccu_reset_controller *controller;
+	struct reset_controller_dev *rcdev;
+
+	/* Resets are optional */
+	if (!data)
+		return 0;
+
+	controller = devm_kzalloc(dev, sizeof(*controller), GFP_KERNEL);
+	if (!controller)
+		return -ENOMEM;
+
+	controller->regmap = regmap;
+	controller->data = data;
+
+	rcdev = &controller->rcdev;
+	rcdev->owner = THIS_MODULE;
+	rcdev->nr_resets = data->count;
+	rcdev->ops = &k1_reset_control_ops;
+	rcdev->of_node = dev->of_node;
+
+	return devm_reset_controller_register(dev, rcdev);
+}
+
 static int k1_ccu_probe(struct platform_device *pdev)
 {
 	struct regmap *base_regmap, *lock_regmap = NULL;
@@ -1710,6 +1798,11 @@ static int k1_ccu_probe(struct platform_device *pdev)
 	if (ret)
 		return dev_err_probe(dev, ret, "failed to register clocks\n");
 
+	ret = k1_reset_controller_register(dev, base_regmap, data->rst_data);
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "failed to register reset controller\n");
+
 	return 0;
 }
 
-- 
2.43.0


