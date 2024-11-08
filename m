Return-Path: <linux-kernel+bounces-401841-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F5809C200C
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 16:09:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D51A81F24061
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 15:09:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 260F81F5825;
	Fri,  8 Nov 2024 15:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="purw+VUj"
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25B411F4702;
	Fri,  8 Nov 2024 15:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731078540; cv=none; b=WHK9bnN59pu7ZVzAuMdNqSEkudTbMa3mMqVSgH8NgqSAaNAjgY49WB2psqVz36rjfAO7lmUC+slQ+dOM45pmV50Xcfuk+4+OoIs5L37wHDGAHEuqMfIHCgLWb4cerJ7NEANjX4539wZJQ4cd2tlV5Na8t4AYpAsE3BkdwNimpZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731078540; c=relaxed/simple;
	bh=gRwhlyf/2DdEGELPpUcGdjTanah2nSvW6Ry1ETe3P2I=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Ek41n+4QEeAJ229vTTFLWSVtWApie+W9EU4aeUopS3Zcec7hjK4bc3bOLYrYE9BykVAWKotKyImcV2/bK0W4j0eHXKjbf3lOY6e3suLJKPkWDkwaQhYDxIImBE/gzbS9NJHTWrJBTcin/Lg4BEV4iK8+XN9J73+YdPMuJeibyoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=purw+VUj; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id E752B20008;
	Fri,  8 Nov 2024 15:08:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1731078536;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=6z6N6MS2IrSq64I2YYr9dqdQedW4NZ/480SQrwmjR/Y=;
	b=purw+VUjbf2ADLbsRytqacTj7IgpSmKMA+cmZ1oG2aZjfgYb5M/c0Ad5nLhHSQ5XgOn2hk
	Ce0tl4eyNTtBln/EwQqZ+qKE5OR1XcUakAuzqCY2n5eMsydfc7XyUOBI/uDGd4kPUge/15
	MirSy6IXza0qWKJo+17g8X7Y4RVDRFTNoyK1nXVmcq05RZ0qvvvUveuEFn8P1n9Q98EEA6
	ruYQiRlG2RwwUONK6vhCtwM8MkQ6MW20/rljuUWWh2SxQMTuIXx9rJN6eJVZuJWjAwKbU4
	51vw2WhWMIiytejjs0rFiDIimZLOg1k0F2O30umnBCqpDZeyCoh3nc2QfdzfCg==
From: Thomas Richard <thomas.richard@bootlin.com>
Subject: [PATCH v2 0/2] Enable sensors support for the Congatec Board
 Controller
Date: Fri, 08 Nov 2024 16:08:50 +0100
Message-Id: <20241108-congatec-board-controller-hwmon-v2-0-16e337398527@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIIpLmcC/4WOTW7DIBBGr2LNulRgMIaseo8qC37GMZINLRCnV
 eS7FzsH6G7eLN73nlAwByxw6Z6QcQslpNigf+vAzSbekATfGHraC6qoJi7Fm6noiE0m+wNrTsu
 CmcyPNUWCGiX3ehg959AsXxmn8HMufF5fnPH73obq6wnWFGyedQ310rFpQkfVIMdJ9NIwN2iOl
 CtnvJPMetdOK+QIh2sOpab8e8Zv7JQdnYxR8W/nxgglamQonB+0V/hhU6pLiO8tBa77vv8B/Yh
 ivRwBAAA=
To: Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, 
 Lee Jones <lee@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org, 
 thomas.petazzoni@bootlin.com, blake.vermeer@keysight.com, 
 Thomas Richard <thomas.richard@bootlin.com>
X-Mailer: b4 0.14.1
X-GND-Sasl: thomas.richard@bootlin.com

This is the second iteration of this series which enables sensors support
for the Congatec Board Controller.

The main change in the hwmon driver is that now a channel id always refers
to the same sensor. So in0 is always "CPU voltage", temp1 is always "CPU
Temperature", ...

Regards,

Thomas

Signed-off-by: Thomas Richard <thomas.richard@bootlin.com>
---
Changes in v2:
- hwmon: use unsigned int type instead of u8 in struct cgbc_hwmon_sensor
  and struct cgbc_hwmon_data.
- hwmon: in cgbc_hwmon_probe_sensors() no need to request data for the
  first sensor as the Board Controller returns data of the first sensors
  with the number of sensors.
- hwmon: fix typos in comments and improve them.
- hwmon: remove dead code in cgbc_hwmon_read() and in
  cgbc_hwmon_read_string() (deadcode was the 'return -ENODEV').
- hwmon: remove useless platform_set_drvdata().
- hwmon: channel id always refers to the same sensor.
- hwmon: add a enum cgbc_sensor_types.
- Link to v1: https://lore.kernel.org/r/20241104-congatec-board-controller-hwmon-v1-0-871e4cd59d8e@bootlin.com

---
Thomas Richard (2):
      hwmon: Add Congatec Board Controller monitoring driver
      mfd: cgbc: add a hwmon cell

 MAINTAINERS                |   1 +
 drivers/hwmon/Kconfig      |   9 ++
 drivers/hwmon/Makefile     |   1 +
 drivers/hwmon/cgbc-hwmon.c | 314 +++++++++++++++++++++++++++++++++++++++++++++
 drivers/mfd/cgbc-core.c    |   1 +
 5 files changed, 326 insertions(+)
---
base-commit: 1ffec08567f426a1c593e038cadc61bdc38cb467
change-id: 20240809-congatec-board-controller-hwmon-e9e63d957d33

Best regards,
-- 
Thomas Richard <thomas.richard@bootlin.com>


