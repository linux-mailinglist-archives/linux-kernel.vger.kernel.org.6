Return-Path: <linux-kernel+bounces-206946-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 789B6901026
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jun 2024 10:13:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7952F1C20341
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jun 2024 08:13:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72EA1177990;
	Sat,  8 Jun 2024 08:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="fm50fgeh"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CBE5176AC7;
	Sat,  8 Jun 2024 08:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717834372; cv=none; b=eyQTZ1aTRVKtrKRRvc/P/D5HPjKu1ES9KH7mernv0ZH9hYCkn6ZavXPegH8qlpDvE8OieKLaEJEKDv8eOjWWa1NZ7NxrmxAhVECfckxTuHPs7ERlApz7vR5TXA8dEHSVSeguHxZZ8Q67r321CLmGXKLGnifZReLsIoUBtYAtHB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717834372; c=relaxed/simple;
	bh=c+uFpWCMZSQ7m/Mz5EU7dhzeC3k6SNmPxQRmuwxkvE4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=jC0Z6yF5e8j7Fmnfwjp00QwHXLNyccNfJ1JN7YqIrimvXihnhkjiaF0MbmEV7W/ztqqB8OTsUtcaE9H1tYdG7AIyNNTSEiEy7J7vHRNA9oqfODAT8KSZXuOVfjtaR5soRp1XfsRjtT+0JvdBabbk1Hycsz7UFfJxlkRBcvI1/IA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=fm50fgeh; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1717834365;
	bh=c+uFpWCMZSQ7m/Mz5EU7dhzeC3k6SNmPxQRmuwxkvE4=;
	h=From:Subject:Date:To:Cc:From;
	b=fm50fgehiRH9BsrP5fW4J04QmVMefFB2retvoLCwfq2MkCj140cQuJ0CqSXpMqQ08
	 kzkba2FtQYlB10N2JxJpeISl1voORZPN+UOeI0XFVnHeX5PfYuE9igMgOHnizbdTKi
	 MCs0CneMRezwRaxyuMvqYAv2dFL4FiSwGDno2YGM=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Subject: [PATCH 0/5] hwmon: (cros_ec): fan target, fan pwm control and
 temperature thresholds
Date: Sat, 08 Jun 2024 10:12:42 +0200
Message-Id: <20240608-cros_ec-hwmon-pwm-v1-0-d29dfc26fbc3@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAHoSZGYC/x2MQQqAMAzAviI9W6hDBf2KiMxatQc32cAJ4t8d3
 pJD8kCUoBKhLx4IcmlU77JUZQG8W7cJ6pIdDJmaGtMhBx8nYdzT4R2e6UBamNuKZpsBcncGWfX
 +n8P4vh/9Ya6gYwAAAA==
To: Benson Leung <bleung@chromium.org>, Tzung-Bi Shih <tzungbi@kernel.org>, 
 Guenter Roeck <groeck@chromium.org>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas@weissschuh.net>, 
 Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>
Cc: Dustin Howett <dustin@howett.net>, 
 Mario Limonciello <mario.limonciello@amd.com>, 
 Stephen Horvath <s.horvath@outlook.com.au>, chrome-platform@lists.linux.dev, 
 linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1717834364; l=1917;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=c+uFpWCMZSQ7m/Mz5EU7dhzeC3k6SNmPxQRmuwxkvE4=;
 b=4jzTKzT8wrfJoXc3/XsHoF+ibf+T1IlRLVbt8KY6ViDATww+JRaWiWiDD0SR2sFW6yLyQCBpy
 TLUja5j9ZpIBg/xxUIcAqrvfZqYyEAPlDQ0qwYtu2f0SE181uVI7oC1
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

Add support to cros_ec_hwmon for
* fan target speed for fan 1
* fan pwm control for all fans
* fan temperature thresholds (RW) for all temp sensors

The EC also supports tempY_auto_pointZ_{pwm,temp} but that does not yet
seem to be usable from "struct hwmon_channel_info".
Guenter, is this intentional, do you want me to add support for it?

Patch 1 introduces a utility function cros_ec_cmd_versions() which wraps
EC_CMD_GET_CMD_VERSIONS.
That is used as it seems inadvisable to call EC_CMD_PWM_SET_FAN_DUTY
during probing.
I'm planning on also using this utility function in my CrOS EC charge
control driver.
Also  there are some other places throughout the tree that could use it.

This series is meant to be merged through the chrome-platform tree,
as cros_ec_hwmon itself is only available there and because of
the new cros_ec_cmd_version().
To test it you *also* need
commit 27e669820c ("mfd: cros_ec: Register hardware monitoring subdevice")
from the MFD tree (branch mfd-for-next).

Tested on a Framework 13 AMD.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
Thomas Weißschuh (5):
      platform/chrome: cros_ec_proto: Introduce cros_ec_cmd_versions()
      hwmon: (cros_ec) Add support for fan target speed
      hwmon: (cros_ec) Add support for PWM fan control
      hwmon: (cros_ec) Split temperature channel params
      hwmon: (cros_ec) Add support for temperature thresholds

 Documentation/hwmon/cros_ec_hwmon.rst       |   8 +-
 drivers/hwmon/cros_ec_hwmon.c               | 284 +++++++++++++++++++++++++---
 drivers/platform/chrome/cros_ec_proto.c     |  26 +++
 include/linux/platform_data/cros_ec_proto.h |   2 +
 4 files changed, 290 insertions(+), 30 deletions(-)
---
base-commit: c8a4bdca928debacf49524d1b09dbf27e88e1f18
change-id: 20240529-cros_ec-hwmon-pwm-0dcc610ba0dc

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>


