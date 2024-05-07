Return-Path: <linux-kernel+bounces-171485-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 293F28BE4F6
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 15:57:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D90DE2834CD
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 13:57:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A47FB15F326;
	Tue,  7 May 2024 13:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="Vz4iGHg7"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26A7315ECDD;
	Tue,  7 May 2024 13:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715090251; cv=none; b=fIAvHgBWgbcMeeYYKWWzuxlsRs+g4RPtDnsB9yvvVYcggGrKv78Lq+65AQoBXosDREYZrqDBQIiwjvKLqOlX6A45B6slFwMrbjpOnxCyCIPWS7I7FA5vWLLeuUlJenT91MHhtERhFVudhqGENXaudWdw3fMrDfrYLaaWpuCnlmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715090251; c=relaxed/simple;
	bh=CtbVsaAWGVPtKOnSGhlvMhVfqRtNMnCw7MAcBD0skng=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=iRAFY6H8GBidim0u6pjZwWN2BexVdKQly1wD4ElQ10nJ4NTMiewOGBpUDubTvNmnt1i1Gs4oenWGArIOMjD2jGE4DSC/R+l8E9vEkXiBgVTPDG+45qK2g68HXydb/mXabfxvOjqb+q1IEdulU6OGsBoezBEgFmIrHqTLXFqjgQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=Vz4iGHg7; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1715090246;
	bh=CtbVsaAWGVPtKOnSGhlvMhVfqRtNMnCw7MAcBD0skng=;
	h=From:Subject:Date:To:Cc:From;
	b=Vz4iGHg7drjKVl7d7EcyvXo83nonOFwB5y6lH/5NvWV61VrAswtaDwBI4AFC4TR5v
	 ZvhbBJjYwepLgF7DCkA3dL+rv+ubFIbQpH9e6ztZIHLs65RIYggo/YnrvHnrlFOcy0
	 9rVJUYuol2etOoYhsbThfGNnldad7OI8pGv2OOkk=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Subject: [PATCH 0/2] ChromeOS Embedded controller hwmon driver
Date: Tue, 07 May 2024 15:57:23 +0200
Message-Id: <20240507-cros_ec-hwmon-v1-0-2c47c5ce8e85@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAEMzOmYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDUwMz3eSi/OL41GTdjPLc/DxdIxMzY5MkA/PkNLM0JaCegqLUtMwKsHn
 RsbW1AGFFcgNfAAAA
To: Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, 
 Benson Leung <bleung@chromium.org>, Lee Jones <lee@kernel.org>
Cc: Guenter Roeck <groeck@chromium.org>, linux-kernel@vger.kernel.org, 
 linux-hwmon@vger.kernel.org, chrome-platform@lists.linux.dev, 
 Dustin Howett <dustin@howett.net>, 
 Mario Limonciello <mario.limonciello@amd.com>, 
 Moritz Fischer <mdf@kernel.org>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1715090246; l=1624;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=CtbVsaAWGVPtKOnSGhlvMhVfqRtNMnCw7MAcBD0skng=;
 b=PnxbvT1dqivcDWo2rkJkvaTA8qizq977AD1ZU/4fP2zcQBn8+V8jD1fdAH4zKrH58JAvPFdId
 tLu+/z+L7xlBu5JLMKqWeQRcHzz2qSGNUNy1+EVpPG/QQM06y4tdTwJ
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

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
Thomas Weißschuh (2):
      hwmon: add ChromeOS EC driver
      mfd: cros_ec: Register hardware monitoring subdevice

 Documentation/hwmon/cros_ec_hwmon.rst |  26 ++++
 Documentation/hwmon/index.rst         |   1 +
 MAINTAINERS                           |   8 +
 drivers/hwmon/Kconfig                 |  11 ++
 drivers/hwmon/Makefile                |   1 +
 drivers/hwmon/cros_ec_hwmon.c         | 279 ++++++++++++++++++++++++++++++++++
 drivers/mfd/cros_ec_dev.c             |   1 +
 7 files changed, 327 insertions(+)
---
base-commit: 2fbe479c0024e1c6b992184a799055e19932aa48
change-id: 20240506-cros_ec-hwmon-24634b07cf6f

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>


