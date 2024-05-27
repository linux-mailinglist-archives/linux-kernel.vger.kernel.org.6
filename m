Return-Path: <linux-kernel+bounces-191409-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DCDE8D0ED8
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 22:59:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCBBA282678
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 20:59:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 925A41649C6;
	Mon, 27 May 2024 20:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="td8k/b9Q"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A46E381C7;
	Mon, 27 May 2024 20:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716843533; cv=none; b=V/ByXC6ZlqpvtwNxHiZ5JVZ5vnKcQ3mBtxdRt+R67tA3nbCqTU/i9WQ5afDS1gwOZRdRKGIHtgGXeLACIaA5poTpKd7hoMtmSqe/4aZejt2SrLPGzGT5JHN0X4lOG9NbcS00Z7gzJ1lnxbj/+LkamsXhtL6CIU7LT+8+Q5eE8Pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716843533; c=relaxed/simple;
	bh=dG6+vHBr5BNz0npKbHGTIBr20hPfJ/e4zMa9XaBnm8s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oKdqWI7sqJ5FBrq0E2vvu7jul7w9imsHjsGjbOQ4b9H7Yr4ZtifxLgBQOwpdpAju4PbqJpX0ap1e7mExKFVcbOHvS70GmPX4U2Gr9bWUPwPEUFDrS1ukvpM86OiYmDI3lp8bBRuLGrwckOBr3y2xcHqkVcVLdfiJlYZficuBndU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=td8k/b9Q; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1716843529;
	bh=dG6+vHBr5BNz0npKbHGTIBr20hPfJ/e4zMa9XaBnm8s=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=td8k/b9Q0wYX0kej9HBZanQlprStHOz2mERIZXimJ+/eipiRXbSGfmVKpPxYLCAfi
	 JZN/5Xf9mQK0y9k13QumdhEvENM51Xq9nezhHgez5Li+yN3RDPl0u/QrobvDF2FLXu
	 4K1bHnDsmHSjV18kyq07z5lJaBjqDlQJ7rBdkCd0=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Mon, 27 May 2024 22:58:33 +0200
Subject: [PATCH v3 3/3] mfd: cros_ec: Register hardware monitoring
 subdevice
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240527-cros_ec-hwmon-v3-3-e5cd5ab5ba37@weissschuh.net>
References: <20240527-cros_ec-hwmon-v3-0-e5cd5ab5ba37@weissschuh.net>
In-Reply-To: <20240527-cros_ec-hwmon-v3-0-e5cd5ab5ba37@weissschuh.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1716843528; l=672;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=dG6+vHBr5BNz0npKbHGTIBr20hPfJ/e4zMa9XaBnm8s=;
 b=tXpX2u/asWUM1lSYk4cM3maBLzyjEFTneQ6C5r9RPpQ75zt9WZpVJ3wTuUL0vrERL9YvLw8KT
 IA6MVvREWmEAQw5I/UsL5l2WJYbkqMr553e98wT7P/NZdxT0fjjH0Sv
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


