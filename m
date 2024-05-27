Return-Path: <linux-kernel+bounces-191406-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 95E7C8D0ED3
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 22:59:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE81A1C210FD
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 20:59:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A770E5490F;
	Mon, 27 May 2024 20:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="NSlbaAyO"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D2064CB4B;
	Mon, 27 May 2024 20:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716843533; cv=none; b=MHloI4HsJsBLKdkaEjTCYk3GXjvlgYphdE1pUQ4SqiSfO4Y+rvQ4Gs3Z6Rb4uZq8v5+adocyKatxUoV2fvunUebBtLfJkwE0w6/AMfO9Eoc1EERhJ6txGIedmqnO+qTlWN+sAc7GKGU3Exoy4KbLdJ0LQSs5gciaBukUwy/810s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716843533; c=relaxed/simple;
	bh=DdNM+/xtasRS3TMXAogfc6wnpLVZnjD39yQ9DrOjLbY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=KCrZONslP5eqC5erPBORWMLxzCdJg9wTrbM/KXvd3wJNrWn4C1kNdxv4ZwZf9bgy7LdLdRwRcG/pc713qNzrK2Psmhq3jRUjJsrLembFcBRKHqFPAwkdJGl/0Ey/h9wtMpohfMLUJQd6Id5xHtoXDzzzHb90iUxJHnP6z9rikfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=NSlbaAyO; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1716843529;
	bh=DdNM+/xtasRS3TMXAogfc6wnpLVZnjD39yQ9DrOjLbY=;
	h=From:Subject:Date:To:Cc:From;
	b=NSlbaAyOTnDlCUIan/XD2zASVl2xUBjnC1HRmzJGrQW/Ll/p5BEwA6xlOg4hWgKao
	 aEaHMB9WNRwLbTp1GcUXdQzBgZDbu9BPMWXykBaIoFLewfe+uwoScScze0CxpmsslX
	 NeTiqvgxgOt6qsCvZd0nMGHi2D9F9mTLCVLy5up0=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Subject: [PATCH v3 0/3] ChromeOS Embedded controller hwmon driver
Date: Mon, 27 May 2024 22:58:30 +0200
Message-Id: <20240527-cros_ec-hwmon-v3-0-e5cd5ab5ba37@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAPbzVGYC/33MQQ7CIBCF4as0rMXQKZTGlfcwxtRxEBaCgUo1T
 e8ubeJGE5f/S943sUTRUWK7amKRsksu+BLNpmJoe38l7i6lGQiQQomWYwzpRMjteAueg2wbeRY
 aTWtY+dwjGfdcvcOxtHVpCPG18rle1o+kv6Rcc8EBpUaF1FGn9iO5lBLah916GtjCZfhLQCFqA
 EBlsBdG/xDzPL8BNWE+g/IAAAA=
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1716843528; l=3336;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=DdNM+/xtasRS3TMXAogfc6wnpLVZnjD39yQ9DrOjLbY=;
 b=f4XDCvcz440TWIren1etaYDNP3WdxUJ0EktzLuI4bfL1tNFBpD/S0dfWgsYAFbAImjQlApbhR
 Vb2OdBw/WdhCnWrMdoeqpKVLQyvqO+33etozfO+exKfGa3RIFP4+bNm
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

Add a hwmon driver that reports fan and temperature readings from the
ChromeOS Embedded controller.

There was an earlier effort in 2017 to add such a driver [0], but there
was no followup after v1.
The new driver is complete reimplementation based on newer APIs and with
more features (temp sensor names).

It only works on LPC-connected ECs, as only those implement direct
memory-map access.
For other busses the data would need to be read with a command.
Adding some helpers was discussed in the previous patchset [1].

The EC protocols also support reading and writing fan curves but that is
not implemented.

Tested on a Framework 13 AMD, Firmware 3.05.

[0] https://lore.kernel.org/all/1491602410-31518-1-git-send-email-moritz.fischer@ettus.com/
[1] https://lore.kernel.org/all/ac61bfca-bfa0-143b-c9ca-365b8026ce8d@roeck-us.net/

To: Jean Delvare <jdelvare@suse.com>
To: Guenter Roeck <linux@roeck-us.net>
To: Benson Leung <bleung@chromium.org>
To: Lee Jones <lee@kernel.org>
To: Tzung-Bi Shih <tzungbi@kernel.org>
Cc: Guenter Roeck <groeck@chromium.org>
Cc: linux-kernel@vger.kernel.org
Cc: linux-hwmon@vger.kernel.org
Cc: chrome-platform@lists.linux.dev
Cc: Dustin Howett <dustin@howett.net>
Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Moritz Fischer <mdf@kernel.org>
Cc: Stephen Horvath <s.horvath@outlook.com.au>
Cc: Rajas Paranjpe <paranjperajas@gmail.com>

Changes in v3:
- Drop Mario's Reviewed-by tag, as the code has changed
- Introduce cros_ec_cmd_readmem() for non-LPC compatibility
- Report fault state for fans and temp sensors
- Avoid adding unnecessary space characters to channel label
- Drop thermal_version from priv data
- Read fans during probing only once
- Don't include linux/kernel.h
- Move _read_temp_sensor_info to similar functions
- Insert MFD entry alphabetically
- Link to v2: https://lore.kernel.org/r/20240507-cros_ec-hwmon-v2-0-1222c5fca0f7@weissschuh.net

Changes in v2:
- drop unnecessary range checks (Guenter)
- only validate thermal_version during probing
- reorder some variable declarations
- validate thermal_version directly in cros_ec_hwmon_probe (Mario)
- drop return value from probe_temp_sensors as it can't fail anymore
- fail with -ENODEV if cmd_readmem is missing to avoid spurious warnings
- Link to v1: https://lore.kernel.org/r/20240507-cros_ec-hwmon-v1-0-2c47c5ce8e85@weissschuh.net

---
Thomas Weißschuh (3):
      platform/chrome: cros_ec_proto: Introduce cros_ec_cmd_readmem()
      hwmon: add ChromeOS EC driver
      mfd: cros_ec: Register hardware monitoring subdevice

 Documentation/hwmon/cros_ec_hwmon.rst       |  26 +++
 Documentation/hwmon/index.rst               |   1 +
 MAINTAINERS                                 |   8 +
 drivers/hwmon/Kconfig                       |  11 ++
 drivers/hwmon/Makefile                      |   1 +
 drivers/hwmon/cros_ec_hwmon.c               | 291 ++++++++++++++++++++++++++++
 drivers/mfd/cros_ec_dev.c                   |   1 +
 drivers/platform/chrome/cros_ec_proto.c     |  27 +++
 include/linux/platform_data/cros_ec_proto.h |   2 +
 9 files changed, 368 insertions(+)
---
base-commit: 2bfcfd584ff5ccc8bb7acde19b42570414bf880b
change-id: 20240506-cros_ec-hwmon-24634b07cf6f

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>


