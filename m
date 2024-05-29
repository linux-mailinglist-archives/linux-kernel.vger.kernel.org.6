Return-Path: <linux-kernel+bounces-193507-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 617EA8D2D32
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 08:27:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 931401C227DC
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 06:27:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AF4515FD1A;
	Wed, 29 May 2024 06:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="mxRI20Ab"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34F3738DE8;
	Wed, 29 May 2024 06:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716964043; cv=none; b=ZIHaraCM2N8hKxyi7coV5EugIisXwCtfAKsZAum99iczggKJEhuauJXpW8XGKM8GSov6Q9V/phF3cNB3dvqvKPCLRsAsTl7/z7x/VD8qDj26RvU80n57Gbm3Gk0wF7Yut5u6wQ3qCV7DWmj4t+X3kNqYF1R8Hwk3LjT1XZgWdLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716964043; c=relaxed/simple;
	bh=dG6+vHBr5BNz0npKbHGTIBr20hPfJ/e4zMa9XaBnm8s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Yev5ZffkpY+lY57qPyJ6VJPAsS1cp7G0hYYD0E4F8j2p9W49hviTooSHn2wHNsJZYCiVVsMzpVuY7DbOnm39mD6kcfDgsAjpH9oOwGqxkVz3Y5yGyl8StEY82pRLYl8QIqokYoSfZWN0yj7FP9DOpOm5MVECmUmAscYYDBSDZNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=mxRI20Ab; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1716964039;
	bh=dG6+vHBr5BNz0npKbHGTIBr20hPfJ/e4zMa9XaBnm8s=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=mxRI20AbKTr+5nqv4YbTPKtN302ncy+R8nfFK18JnghFiTjMFKKcCLfpkKGjuBRVm
	 /3YLF3zPaMbvYlDbyPcsESqO+N3J3sQX0Y7OxOJb3njvZj7aomIUQjbR44wbY3zoMG
	 IjeWsQM8O4JCLrFfTcIW3r7QBQDY1CadUyaeKQZQ=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Wed, 29 May 2024 08:27:13 +0200
Subject: [PATCH v4 3/3] mfd: cros_ec: Register hardware monitoring
 subdevice
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240529-cros_ec-hwmon-v4-3-5cdf0c5db50a@weissschuh.net>
References: <20240529-cros_ec-hwmon-v4-0-5cdf0c5db50a@weissschuh.net>
In-Reply-To: <20240529-cros_ec-hwmon-v4-0-5cdf0c5db50a@weissschuh.net>
To: Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, 
 Benson Leung <bleung@chromium.org>, Lee Jones <lee@kernel.org>, 
 Tzung-Bi Shih <tzungbi@kernel.org>
Cc: Guenter Roeck <groeck@chromium.org>, linux-kernel@vger.kernel.org, 
 linux-hwmon@vger.kernel.org, chrome-platform@lists.linux.dev, 
 Dustin Howett <dustin@howett.net>, 
 Mario Limonciello <mario.limonciello@amd.com>, 
 Moritz Fischer <mdf@kernel.org>, Stephen Horvath <s.horvath@outlook.com.au>, 
 Rajas Paranjpe <paranjperajas@gmail.com>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1716964039; l=672;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=dG6+vHBr5BNz0npKbHGTIBr20hPfJ/e4zMa9XaBnm8s=;
 b=JMv1OZh/Sj3Nld6VzjSeFdwMR4dGvnIOFEc33cEK1nhz0w0y3D3WSrmVMrLQ/w6UIgC1r4U1p
 eAzwsGqrmWODqgy94p3q+YpW/eHGwwZ89H956xlNia5I2bVtP4Uy6Rw
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

Add ChromeOS EC-based hardware monitoring as EC subdevice.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 drivers/mfd/cros_ec_dev.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mfd/cros_ec_dev.c b/drivers/mfd/cros_ec_dev.c
index a52d59cc2b1e..1262d1f8d954 100644
--- a/drivers/mfd/cros_ec_dev.c
+++ b/drivers/mfd/cros_ec_dev.c
@@ -130,6 +130,7 @@ static const struct cros_feature_to_cells cros_subdevices[] = {
 static const struct mfd_cell cros_ec_platform_cells[] = {
 	{ .name = "cros-ec-chardev", },
 	{ .name = "cros-ec-debugfs", },
+	{ .name = "cros-ec-hwmon", },
 	{ .name = "cros-ec-sysfs", },
 };
 

-- 
2.45.1


