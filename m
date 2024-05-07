Return-Path: <linux-kernel+bounces-171486-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C3BB88BE4F7
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 15:57:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 799D91F216BA
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 13:57:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE5E515F3E9;
	Tue,  7 May 2024 13:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="VJYeApVk"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6017015ECC1;
	Tue,  7 May 2024 13:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715090252; cv=none; b=CNnNtZLrsmKIIIrHOqXNImFVSV29x3OUikrqAC9zmsY1QfDgSSKguVh9TTf41faEIQQcvQzLFZC/0DlS6gazjTUqCWnftVf6/wufj7Zelif764bS+EEegoLn1N/ZMO0Y+VvqGth7+DoaMJJuDWSFEyEoYxRSo2R4v2ac0fMOBtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715090252; c=relaxed/simple;
	bh=mbz66Nhq8rCEi0/koHdR2mvSb3h/Lz/Clxju/H9RWNQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JxDUJl1ng9cmQmvjggPI85d+wnpn0i2iwxosvRmXRmWXBNfusgaSMoT5RHtE+dECy28bGlR67oEkXoP2Hmz7Un9N3HKNrEykLFACJsEA22xi5KUSWuzrR+GNyPF97skbzQLUFDyi4QCkZEtfwB/GQQJouJG9I4vWhEoq140S5Vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=VJYeApVk; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1715090246;
	bh=mbz66Nhq8rCEi0/koHdR2mvSb3h/Lz/Clxju/H9RWNQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=VJYeApVkC4C0WmQNBZVOvv+86/Vs4OVFPg94AIORbkuysVmQtaKAi04LAuIK3UD9c
	 KhWpQmZ+7SY5qpvsT5gFFaoX7Vb9ouQljdMjV67NWTsWO9kInbvOdiSukSc87/PyJw
	 ul8EEbI5IOV3xljjXehW0pEIyRaUWJFuDWrrEFO0=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Tue, 07 May 2024 15:57:25 +0200
Subject: [PATCH 2/2] mfd: cros_ec: Register hardware monitoring subdevice
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240507-cros_ec-hwmon-v1-2-2c47c5ce8e85@weissschuh.net>
References: <20240507-cros_ec-hwmon-v1-0-2c47c5ce8e85@weissschuh.net>
In-Reply-To: <20240507-cros_ec-hwmon-v1-0-2c47c5ce8e85@weissschuh.net>
To: Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, 
 Benson Leung <bleung@chromium.org>, Lee Jones <lee@kernel.org>
Cc: Guenter Roeck <groeck@chromium.org>, linux-kernel@vger.kernel.org, 
 linux-hwmon@vger.kernel.org, chrome-platform@lists.linux.dev, 
 Dustin Howett <dustin@howett.net>, 
 Mario Limonciello <mario.limonciello@amd.com>, 
 Moritz Fischer <mdf@kernel.org>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1715090246; l=662;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=mbz66Nhq8rCEi0/koHdR2mvSb3h/Lz/Clxju/H9RWNQ=;
 b=2n4pgc0BzRxDFIOuf0OLW+kgF0vpHq5+4NbJyEvR7NayIvmxaonr/GTWdeYAs37GBLtIqehbs
 hp8wUm1eaJJCOeB8ctQxM128IByFEcetir5u3H+gg9s/e8wNiY8wWYx
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

Add ChromeOS EC-based hardware monitoring as EC subdevice.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 drivers/mfd/cros_ec_dev.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mfd/cros_ec_dev.c b/drivers/mfd/cros_ec_dev.c
index a52d59cc2b1e..ca30ca25fbf8 100644
--- a/drivers/mfd/cros_ec_dev.c
+++ b/drivers/mfd/cros_ec_dev.c
@@ -131,6 +131,7 @@ static const struct mfd_cell cros_ec_platform_cells[] = {
 	{ .name = "cros-ec-chardev", },
 	{ .name = "cros-ec-debugfs", },
 	{ .name = "cros-ec-sysfs", },
+	{ .name = "cros-ec-hwmon", },
 };
 
 static const struct mfd_cell cros_ec_pchg_cells[] = {

-- 
2.45.0


