Return-Path: <linux-kernel+bounces-198171-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A737E8D7472
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jun 2024 11:04:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 463761F21A6A
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jun 2024 09:04:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 678963F9D2;
	Sun,  2 Jun 2024 09:03:03 +0000 (UTC)
Received: from fgw22-7.mail.saunalahti.fi (fgw22-7.mail.saunalahti.fi [62.142.5.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 548883D971
	for <linux-kernel@vger.kernel.org>; Sun,  2 Jun 2024 09:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.142.5.83
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717318983; cv=none; b=Ibv1jhseMY2VqMwuAzSGaIdv6lFWxilm3+/Z6qrgUvzJsmXXgTUu6Jipqk3aDh5pT1kLG9nHZ2JVPV5r2ltOhtPyn8YJHv+SHqgAHkwebgc2jSXHWx3n2H1JU3wDLcOUU3lXgWUee05GTBpW0z5CPTLTaQ944H5n1jy5ftkVerw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717318983; c=relaxed/simple;
	bh=Zev7O1OaJPuWxSkFHl6udbLp67nkr4VjyCzglGcW7E0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Lxr3N80Kn1wpDLhIBPTfhMmEDE1Ev/60/6xQAWNPr+O+FCMx2djeXGHmd0HE5No2lZpjL3KNRzOBUvg4wLqKsVSJLbaCOU3+5gz3EV+uRoozSu/d/COx1Vi3ybFlIF4CibQlutSpyMYMbqJc3hjkgpb9Z/Jx0P5jtnorLUiOrjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=62.142.5.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from localhost (88-113-26-230.elisa-laajakaista.fi [88.113.26.230])
	by fgw21.mail.saunalahti.fi (Halon) with ESMTP
	id e4aa8b06-20be-11ef-ab01-005056bdd08f;
	Sun, 02 Jun 2024 12:02:52 +0300 (EEST)
From: Andy Shevchenko <andy.shevchenko@gmail.com>
To: Hans de Goede <hdegoede@redhat.com>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Jorge Lopez <jorge.lopez2@hp.com>,
	Li Zetao <lizetao1@huawei.com>,
	Simon Trimmer <simont@opensource.cirrus.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Mark Pearson <mpearson-lenovo@squebb.ca>,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ibm-acpi-devel@lists.sourceforge.net,
	linux-input@vger.kernel.org
Cc: Corentin Chary <corentin.chary@gmail.com>,
	"Luke D. Jones" <luke@ljones.dev>,
	Mark Pearson <markpearson@lenovo.com>,
	Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: [PATCH v1 4/7] platform/x86: serial-multi-instantiate: Use 2-argument strscpy()
Date: Sun,  2 Jun 2024 11:57:57 +0300
Message-ID: <20240602090244.1666360-5-andy.shevchenko@gmail.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240602090244.1666360-1-andy.shevchenko@gmail.com>
References: <20240602090244.1666360-1-andy.shevchenko@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use 2-argument strscpy(), which is not only shorter but also provides
an additional check that destination buffer is an array.

Signed-off-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
 drivers/platform/x86/serial-multi-instantiate.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/x86/serial-multi-instantiate.c b/drivers/platform/x86/serial-multi-instantiate.c
index 97b9c6392230..3be016cfe601 100644
--- a/drivers/platform/x86/serial-multi-instantiate.c
+++ b/drivers/platform/x86/serial-multi-instantiate.c
@@ -131,7 +131,7 @@ static int smi_spi_probe(struct platform_device *pdev, struct smi *smi,
 
 		ctlr = spi_dev->controller;
 
-		strscpy(spi_dev->modalias, inst_array[i].type, sizeof(spi_dev->modalias));
+		strscpy(spi_dev->modalias, inst_array[i].type);
 
 		ret = smi_get_irq(pdev, adev, &inst_array[i]);
 		if (ret < 0) {
@@ -205,7 +205,7 @@ static int smi_i2c_probe(struct platform_device *pdev, struct smi *smi,
 
 	for (i = 0; i < count && inst_array[i].type; i++) {
 		memset(&board_info, 0, sizeof(board_info));
-		strscpy(board_info.type, inst_array[i].type, I2C_NAME_SIZE);
+		strscpy(board_info.type, inst_array[i].type);
 		snprintf(name, sizeof(name), "%s-%s.%d", dev_name(dev), inst_array[i].type, i);
 		board_info.dev_name = name;
 
-- 
2.45.1


