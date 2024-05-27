Return-Path: <linux-kernel+bounces-191458-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A2378D0F8A
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 23:29:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8A01282F8F
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 21:29:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53AD7169AC1;
	Mon, 27 May 2024 21:28:03 +0000 (UTC)
Received: from fgw23-7.mail.saunalahti.fi (fgw23-7.mail.saunalahti.fi [62.142.5.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06813169385
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 21:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.142.5.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716845282; cv=none; b=Li/fGM/Y5gPDT3DhAASzbprK9A+qYaez9Eds8n7Z+iq6LFQOgUpPw8QJSznsUrEQZUjJTaFKnuOEN9uMoaGuy+3wGiQmd4r2ViRjxHYE6eIUn+QA6jsoS3gYy8MwmJbwMWR7V9yyMrbkqi9hXwgLOEMKSwQEJrxJ8nptkdLBWPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716845282; c=relaxed/simple;
	bh=AtdSj8Gi5BjDdlTV9ZqdN7OUIGwv22hj9Vwr0vi/QVA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cmApdDfUO2uzerapx3+SFOGbsmXxancKTBUFIy6LrsAmNOyKco9Hc5T3OHBlg5gRjYj8XAS4ENL+OTj4NYLSfc/URvKOqcfXK/F4AgZkw9+uoBUebT42DSCr+IYJqF4+ARr+I9542CXovfEVuKgpK9rqEqQsosEpelXQqVscOgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=62.142.5.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from localhost (88-113-26-230.elisa-laajakaista.fi [88.113.26.230])
	by fgw22.mail.saunalahti.fi (Halon) with ESMTP
	id fd1a1bdb-1c6f-11ef-8e2a-005056bdf889;
	Tue, 28 May 2024 00:27:58 +0300 (EEST)
From: Andy Shevchenko <andy.shevchenko@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	linux-mips@vger.kernel.org
Cc: Dong Aisheng <aisheng.dong@nxp.com>,
	Fabio Estevam <festevam@gmail.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Jacky Bai <ping.bai@nxp.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Sean Wang <sean.wang@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Paul Cercueil <paul@crapouillou.net>,
	Lakshmi Sowjanya D <lakshmi.sowjanya.d@intel.com>,
	Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [PATCH v1 11/11] pinctrl: pinmux: Remove unused members from struct function_desc
Date: Tue, 28 May 2024 00:24:46 +0300
Message-ID: <20240527212742.1432960-12-andy.shevchenko@gmail.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240527212742.1432960-1-andy.shevchenko@gmail.com>
References: <20240527212742.1432960-1-andy.shevchenko@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

All drivers are converted to use embedded struct pinfunction.
Remove unused members from struct function_desc.

Signed-off-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
 drivers/pinctrl/pinmux.h | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/pinctrl/pinmux.h b/drivers/pinctrl/pinmux.h
index 9b57c1cc9d50..2965ec20b77f 100644
--- a/drivers/pinctrl/pinmux.h
+++ b/drivers/pinctrl/pinmux.h
@@ -134,16 +134,10 @@ static inline void pinmux_init_device_debugfs(struct dentry *devroot,
 /**
  * struct function_desc - generic function descriptor
  * @func: generic data of the pin function (name and groups of pins)
- * @name: name of the function
- * @group_names: array of pin group names
- * @num_group_names: number of pin group names
  * @data: pin controller driver specific data
  */
 struct function_desc {
 	struct pinfunction func;
-	const char *name;
-	const char * const *group_names;
-	int num_group_names;
 	void *data;
 };
 
@@ -151,9 +145,6 @@ struct function_desc {
 #define PINCTRL_FUNCTION_DESC(_name, _grps, _num_grps, _data)	\
 (struct function_desc) {					\
 	.func = PINCTRL_PINFUNCTION(_name, _grps, _num_grps),	\
-	.name = _name,						\
-	.group_names = _grps,					\
-	.num_group_names = _num_grps,				\
 	.data = _data,						\
 }
 
-- 
2.45.1


