Return-Path: <linux-kernel+bounces-422072-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3AC59D9427
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 10:22:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A94D1163A6B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 09:22:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACE3F1CDA1A;
	Tue, 26 Nov 2024 09:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="bNOjl/S5"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3C031C1F02
	for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 09:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732612875; cv=none; b=uSRxBh+bOzirpUEtLDY/72n0cIUCxIxXNT1wrzWmOfybqiAFc7acCTeNughgU1aYX/l1TtMP0Yu92c6GbCPHZ9yxoMOfJyXJ8dnodPcYKBHWaF05zEeI6B78SD8mamKE8liZmiD6am74/ujcghk8KDMC6TCo/NXNiFIlyWQa9uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732612875; c=relaxed/simple;
	bh=okZZML2tc4SYJzj0YGY5NcNIBGhTp8dqg/vTqnmY3SY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=T+EN7X/vUCThaVmipDAk8z6SJTwnxtz4NzXFlCiUwaepTbDBP7i3rBSOUcu9mnDGuN6SJEJREs1vyS/O8ptA+B4dGDNcGcy+rN+WG0f6sd3SGZYUxTSdFO4UF86lJAGwL9NuulMqyQY5dHdImgHxdW6unwXPkUE9ZcFPq4bd35w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=bNOjl/S5; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4315c1c7392so49620785e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 01:21:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1732612872; x=1733217672; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VDINqiI7eZIxSdpV6EMx/C3NNutYl7b6+j2YZ5M4Qvg=;
        b=bNOjl/S5uwPrg6QR9r4uvpJWWI/onLN+H2g5+ab6xGa7jvGAwqhfeW4LzMiewJbo15
         boAuzeEnL353Hth/rk2rk3Hu7A5Jaz3I9yPDzy0d+Gj8wZSpNQ+1qo+++ZnJMPQ6R/J+
         j3FcQnBaPbyd4/OD1QzY7DzDaWM5wa47YZUOtc+mnqYxAZhPdLrTm05A56/Wu6gG9Lxu
         HPGHABZJmxVeB96ztwfaPEfVKqkXedrvb77nFrAt+bcaZYzOUsx1SoW8rsxRwSwFNUrJ
         jx1+La3RJ3+eIzKd6dCEZCvX2aXPCT7a7So76dgSyVn9K8kwmCrf92IXtk8LcaQKr/Zk
         X2nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732612872; x=1733217672;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VDINqiI7eZIxSdpV6EMx/C3NNutYl7b6+j2YZ5M4Qvg=;
        b=q07Y7dno9JO9dWQSeaaCr4IvADIaHJtx1lbNXgwqLX3nC37EFflMBe4jxinSJW6CY0
         Tu1eb3DNMYSm1FW3SC5lZsdyo9EPNmjQeAuccZE8axPz0Ybv4q+tkjO24wJZrMki8WwC
         gCVH77CmTR3BhKq71438R+SrToCQnZ9rPgxooJV9DzxVELGaSfmrGdoNHS61xxhSyBs9
         Pd1a6M2PaUnCW8/e280qAZuPK/O0cSP08FWOcrTwOalPnciOK5ubNh83l+0/NpNfpD7S
         InJLvrbScrspMYj1EHhE1GPCRqTJWYE6DeG5xrcpztFcCsEQ1860GxuPvTinA9QI49AU
         aldg==
X-Forwarded-Encrypted: i=1; AJvYcCVhjiObRFFNhA4k4kJBdViuYbl/alTkCuBfMyvQwxNyVWUk9Y4w6VKjCPNjcBrhnLb4dYZW99nbG4/cXx0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrZ8s6E6AKLlyuWz5dqIElLSDM5IbH5XRHx8mpPAgSW+WNcpWv
	mahehOvpLa2I29/KyDitU0nO/MKgtGW89i/fzvJufZ0OhGSNV12GhX1vKjTU3uY=
X-Gm-Gg: ASbGncu0b/fFzE9yxyUB7si+0OiA45cB4pNLDU7V794d7Si3qsm8fRUbmP14XNcu+4w
	Us+1Z9V2SCNRmp40dZgQRuDouEchArc72NyW63b5xI+wNf3bNQdXFNmq6ZizF2Q0cb+cuW7C4uo
	ln92WI+d74p9CDC8+3x0esrZEVJf2BBgLs1bMeBWbKxjt3zRUtWcJvsN1XVIN5LvJmrNMABKNkS
	EfxVlV+Rx08i8NlwoQVERlRHoz9YKjAczlwJ5kK3SYxDCZPwTtG97YsQwmJ9IXXv6wQHGW4DZ83
	W/A=
X-Google-Smtp-Source: AGHT+IFiAn9ufP/2lxYbOVs5nw6bxrcqi6yQ6uQejelWxHdSz9crLVthGd227EDJ3fiqmZHYRLomqQ==
X-Received: by 2002:a05:600c:1c23:b0:434:9e63:faff with SMTP id 5b1f17b1804b1-4349e63fe62mr73118195e9.2.1732612872339;
        Tue, 26 Nov 2024 01:21:12 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3825fbc3a47sm13027694f8f.73.2024.11.26.01.21.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2024 01:21:11 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: vkoul@kernel.org,
	kishon@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	p.zabel@pengutronix.de,
	geert+renesas@glider.be,
	magnus.damm@gmail.com,
	gregkh@linuxfoundation.org,
	yoshihiro.shimoda.uh@renesas.com,
	christophe.jaillet@wanadoo.fr
Cc: linux-phy@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-usb@vger.kernel.org,
	claudiu.beznea@tuxon.dev,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH v2 04/15] soc: renesas: rz-sysc: Add SoC detection support
Date: Tue, 26 Nov 2024 11:20:39 +0200
Message-Id: <20241126092050.1825607-5-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20241126092050.1825607-1-claudiu.beznea.uj@bp.renesas.com>
References: <20241126092050.1825607-1-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

The RZ SYSC controller has registers that keep the SoC ID data. Add
driver support to retrieve the SoC ID and register a SoC driver.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v2:
- this was patch 05/16 in v1
- changed patch title and description
- added SoC initialization code in its own function
- addressed the review comments
- introduced struct rz_sysc_soc_id_init_data and adjusted the code
  accordingly
- dropped the RZ/G3S SoC detection code (it will be introduced in
  a separate patch)

 drivers/soc/renesas/rz-sysc.c | 72 +++++++++++++++++++++++++++++++++--
 drivers/soc/renesas/rz-sysc.h | 18 +++++++++
 2 files changed, 86 insertions(+), 4 deletions(-)

diff --git a/drivers/soc/renesas/rz-sysc.c b/drivers/soc/renesas/rz-sysc.c
index dc0edacd7170..d34d295831b8 100644
--- a/drivers/soc/renesas/rz-sysc.c
+++ b/drivers/soc/renesas/rz-sysc.c
@@ -14,9 +14,12 @@
 #include <linux/refcount.h>
 #include <linux/regmap.h>
 #include <linux/seq_file.h>
+#include <linux/sys_soc.h>
 
 #include "rz-sysc.h"
 
+#define field_get(_mask, _reg) (((_reg) & (_mask)) >> (ffs(_mask) - 1))
+
 /**
  * struct rz_sysc - RZ SYSC private data structure
  * @base: SYSC base address
@@ -211,6 +214,59 @@ static int rz_sysc_signals_init(struct rz_sysc *sysc,
 	return 0;
 }
 
+static int rz_sysc_soc_init(struct rz_sysc *sysc, const struct of_device_id *match)
+{
+	const struct rz_sysc_init_data *sysc_data = match->data;
+	const struct rz_sysc_soc_id_init_data *soc_data = sysc_data->soc_id_init_data;
+	struct soc_device_attribute *soc_dev_attr;
+	const char *soc_id_start, *soc_id_end;
+	u32 val, revision, specific_id;
+	struct soc_device *soc_dev;
+	char soc_id[32] = {0};
+	u8 size;
+
+	if (!soc_data || !soc_data->family || !soc_data->offset ||
+	    !soc_data->revision_mask)
+		return -EINVAL;
+
+	soc_id_start = strchr(match->compatible, ',') + 1;
+	soc_id_end = strchr(match->compatible, '-');
+	size = soc_id_end - soc_id_start;
+	if (size > 32)
+		size = 32;
+	strscpy(soc_id, soc_id_start, size);
+
+	soc_dev_attr = devm_kzalloc(sysc->dev, sizeof(*soc_dev_attr), GFP_KERNEL);
+	if (!soc_dev_attr)
+		return -ENOMEM;
+
+	soc_dev_attr->family = soc_data->family;
+	soc_dev_attr->soc_id = devm_kstrdup(sysc->dev, soc_id, GFP_KERNEL);
+	if (!soc_dev_attr->soc_id)
+		return -ENOMEM;
+
+	val = readl(sysc->base + soc_data->offset);
+	revision = field_get(soc_data->revision_mask, val);
+	specific_id = field_get(soc_data->specific_id_mask, val);
+	soc_dev_attr->revision = devm_kasprintf(sysc->dev, GFP_KERNEL, "%u", revision);
+	if (!soc_dev_attr->revision)
+		return -ENOMEM;
+
+	if (soc_data->id && specific_id != soc_data->id) {
+		dev_warn(sysc->dev, "SoC mismatch (product = 0x%x)\n", specific_id);
+		return -ENODEV;
+	}
+
+	dev_info(sysc->dev, "Detected Renesas %s %s Rev %s\n", soc_dev_attr->family,
+		 soc_dev_attr->soc_id, soc_dev_attr->revision);
+
+	soc_dev = soc_device_register(soc_dev_attr);
+	if (IS_ERR(soc_dev))
+		return PTR_ERR(soc_dev);
+
+	return 0;
+}
+
 static struct regmap_config rz_sysc_regmap = {
 	.name = "rz_sysc_regs",
 	.reg_bits = 32,
@@ -235,14 +291,15 @@ MODULE_DEVICE_TABLE(of, rz_sysc_match);
 static int rz_sysc_probe(struct platform_device *pdev)
 {
 	const struct rz_sysc_init_data *data;
+	const struct of_device_id *match;
 	struct device *dev = &pdev->dev;
-	struct rz_sysc *sysc;
 	struct regmap *regmap;
+	struct rz_sysc *sysc;
 	int ret;
 
-	data = device_get_match_data(dev);
-	if (!data || !data->max_register_offset)
-		return -EINVAL;
+	match = of_match_node(rz_sysc_match, dev->of_node);
+	if (!match || !match->data)
+		return -ENODEV;
 
 	sysc = devm_kzalloc(dev, sizeof(*sysc), GFP_KERNEL);
 	if (!sysc)
@@ -253,6 +310,13 @@ static int rz_sysc_probe(struct platform_device *pdev)
 		return PTR_ERR(sysc->base);
 
 	sysc->dev = dev;
+	ret = rz_sysc_soc_init(sysc, match);
+	if (ret)
+		return ret;
+
+	data = match->data;
+	if (!data->max_register_offset)
+		return -EINVAL;
 
 	ret = rz_sysc_signals_init(sysc, data->signals_init_data, data->num_signals);
 	if (ret)
diff --git a/drivers/soc/renesas/rz-sysc.h b/drivers/soc/renesas/rz-sysc.h
index bb850310c931..babca9c743c7 100644
--- a/drivers/soc/renesas/rz-sysc.h
+++ b/drivers/soc/renesas/rz-sysc.h
@@ -35,13 +35,31 @@ struct rz_sysc_signal {
 	refcount_t refcnt;
 };
 
+/**
+ * struct rz_syc_soc_id_init_data - RZ SYSC SoC identification initialization data
+ * @family: RZ SoC family
+ * @id: RZ SoC expected ID
+ * @offset: SYSC SoC ID register offset
+ * @revision_mask: SYSC SoC ID revision mask
+ * @specific_id_mask: SYSC SoC ID specific ID mask
+ */
+struct rz_sysc_soc_id_init_data {
+	const char * const family;
+	u32 id;
+	u32 offset;
+	u32 revision_mask;
+	u32 specific_id_mask;
+};
+
 /**
  * struct rz_sysc_init_data - RZ SYSC initialization data
+ * @soc_id_init_data: RZ SYSC SoC ID initialization data
  * @signals_init_data: RZ SYSC signals initialization data
  * @num_signals: number of SYSC signals
  * @max_register_offset: Maximum SYSC register offset to be used by the regmap config
  */
 struct rz_sysc_init_data {
+	const struct rz_sysc_soc_id_init_data *soc_id_init_data;
 	const struct rz_sysc_signal_init_data *signals_init_data;
 	u32 num_signals;
 	u32 max_register_offset;
-- 
2.39.2


