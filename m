Return-Path: <linux-kernel+bounces-198170-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F33A88D7469
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jun 2024 11:04:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AEA0D281EB6
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jun 2024 09:04:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D4003A8E4;
	Sun,  2 Jun 2024 09:02:58 +0000 (UTC)
Received: from fgw21-7.mail.saunalahti.fi (fgw21-7.mail.saunalahti.fi [62.142.5.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6792381BE
	for <linux-kernel@vger.kernel.org>; Sun,  2 Jun 2024 09:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.142.5.82
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717318978; cv=none; b=hFFJgzsad1xIDHfkI6j1Z6F57UizAprbcSC32/lJseIesSK33X0vnJjRVlgB5lC0l03A4lr5xnYQ0iY6XNeh1JK2OFPUD6VIn0Um2hkayfuArue34wbVhhjtM/J6gA5o0miQq5JgbNCTuLqag5oFuzKEshU39fHNrdTfD2XL1Z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717318978; c=relaxed/simple;
	bh=UgAuMHpFIkncb10bX6YzLxaitjoHyiUwEFu7OS+KpA4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fP63z0pIosjje7hX/tKHbc2DEjTEg0wrQUjshL/SQ+HyS6WrrS1x2Z2P/pEGfVjVjGG2fo+/C3GtrqAgfGMfAgSS0xPp9LX5qBCkwCGYuBk1YEbqvTXAgR1wjAM8xsavvBNP7r1+vc0j3jRgm8ob8YHj7oGrrSUXDAxHBkVOQnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=62.142.5.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from localhost (88-113-26-230.elisa-laajakaista.fi [88.113.26.230])
	by fgw22.mail.saunalahti.fi (Halon) with ESMTP
	id e585c43e-20be-11ef-8e3d-005056bdf889;
	Sun, 02 Jun 2024 12:02:53 +0300 (EEST)
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
Subject: [PATCH v1 6/7] platform/x86: thinkpad_acpi: Use 2-argument strscpy()
Date: Sun,  2 Jun 2024 11:57:59 +0300
Message-ID: <20240602090244.1666360-7-andy.shevchenko@gmail.com>
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
 drivers/platform/x86/thinkpad_acpi.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
index 397b409064c9..f269ca1ff771 100644
--- a/drivers/platform/x86/thinkpad_acpi.c
+++ b/drivers/platform/x86/thinkpad_acpi.c
@@ -7416,10 +7416,8 @@ static int __init volume_create_alsa_mixer(void)
 	data = card->private_data;
 	data->card = card;
 
-	strscpy(card->driver, TPACPI_ALSA_DRVNAME,
-		sizeof(card->driver));
-	strscpy(card->shortname, TPACPI_ALSA_SHRTNAME,
-		sizeof(card->shortname));
+	strscpy(card->driver, TPACPI_ALSA_DRVNAME);
+	strscpy(card->shortname, TPACPI_ALSA_SHRTNAME);
 	snprintf(card->mixername, sizeof(card->mixername), "ThinkPad EC %s",
 		 (thinkpad_id.ec_version_str) ?
 			thinkpad_id.ec_version_str : "(unknown)");
-- 
2.45.1


