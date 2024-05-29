Return-Path: <linux-kernel+bounces-193510-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 437388D2D38
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 08:27:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D456F1F236E7
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 06:27:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6B79161B4D;
	Wed, 29 May 2024 06:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="jsBgKBfa"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34F8215B99C;
	Wed, 29 May 2024 06:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716964045; cv=none; b=cUVX58pDQZL9iF/LA9YjyJG52uCqBSjE+9CDj6ew52D1tWwzFa+nrORtvUYe+rLNYqVUHd6t2thfmA40UJKg8GUyOQ3T4vc12GywE48bhm3sv7allC+/5gvZLsrushaeOaPY743b/ZWXdVsNFCjKUHzOYzbCsYSfUXjzzUDBDXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716964045; c=relaxed/simple;
	bh=/qkFRUhNoy5tpCX40rtxxef0GjehgEsAFGDIUTr+/OY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=DCqFKoF3Yc7IK5UvSyldcCKMrlBQzhztOaH3xzcFTXtSj4ck4hQVh6T4TGhg3hUDdn3gHbolTH/a9zrj9U9lsdBCqGnNH1iKJ2VTlaVH8CjlB8juF+oXbxH4AXA5GRsQykVOivhdtdTmaAUsVFbbH1rKs53tzrZZtKpENM7JEuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=jsBgKBfa; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1716964039;
	bh=/qkFRUhNoy5tpCX40rtxxef0GjehgEsAFGDIUTr+/OY=;
	h=From:Subject:Date:To:Cc:From;
	b=jsBgKBfaMstqcJW43Mra5SM4GjqbbhgTmnMY4j62NE0AEjOI6mcvb9L/vRYJnHCQx
	 bCf0lJSWwtdElBqo+E+wjTLIeUrfYRvmDdTjdPRusTofvlj1IDzQylLkqLSpfTHaTA
	 AEWlKuNm84a2bL41D2GE/vpHTa4pOwqZFf6ojdmo=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Subject: [PATCH v4 0/3] ChromeOS Embedded controller hwmon driver
Date: Wed, 29 May 2024 08:27:10 +0200
Message-Id: <20240529-cros_ec-hwmon-v4-0-5cdf0c5db50a@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAL7KVmYC/33M0QqCMBTG8VeJXbeYx81JV71HRMzjWdtFGptpI
 b57Uwgio8v/B99vZJGCp8j2m5EF6n30bZNCbjcMnWkuxH2dmoEAKZQoOIY2ngm5G65tw0EWuay
 ERltYlj63QNY/Fu94Su187NrwXPg+m9e3pL+kPuOCA0qNCqmkUh0G8jFGdHe3a6hjM9fDXwISk
 QEAKotGWP2TyD8IWBF5IkhhrUylKpOviWmaXu6Bjt01AQAA
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1716964039; l=3297;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=/qkFRUhNoy5tpCX40rtxxef0GjehgEsAFGDIUTr+/OY=;
 b=+xsNB+ZSA9FsJ4I7ELvsAzE01r5HXo9Tnr0AcYS1MJGRFEVEI2dKRHpa7AKDpaKrWBVhVkFCH
 y7MDOaw8AWGAW76QWToC89mpnm5cvxklEnl94KhEpWwWFQJtBdS7kda
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

---
Changes in v4:
- Don't try to support variable-length reading in cros_ec_cmd_readmem()
  (Tzung-Bi)
- Stylistic changes (Tzung-Bi)
- Return -EOPNOTSUPP from read callbacks by default
- Use nested if-blocks in read callback
- Only allocate priv data after checking thermal version in memmap
- Simplify calling protocol of _read() functions
- Replace cros_ec_hwmon_read_temp_sensor_info() with cros_ec_cmd()
- Link to v3: https://lore.kernel.org/r/20240527-cros_ec-hwmon-v3-0-e5cd5ab5ba37@weissschuh.net

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
 drivers/hwmon/cros_ec_hwmon.c               | 286 ++++++++++++++++++++++++++++
 drivers/mfd/cros_ec_dev.c                   |   1 +
 drivers/platform/chrome/cros_ec_proto.c     |  27 +++
 include/linux/platform_data/cros_ec_proto.h |   2 +
 9 files changed, 363 insertions(+)
---
base-commit: 2bfcfd584ff5ccc8bb7acde19b42570414bf880b
change-id: 20240506-cros_ec-hwmon-24634b07cf6f

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>


