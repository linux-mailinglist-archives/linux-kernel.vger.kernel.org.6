Return-Path: <linux-kernel+bounces-410926-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 951119CF084
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 16:45:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B05528F7CD
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 15:45:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E5851F12E1;
	Fri, 15 Nov 2024 15:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ar0JnXH7"
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 028EA1D5AC0;
	Fri, 15 Nov 2024 15:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731685157; cv=none; b=W8QZboHJ/cFQVp3iCwMABF389hYUAqY9aGb/EfUOAvAoNIoPboo5nk9xXdG8LgTvH6FU99R94scFy2v5ObnG1y5FkRfQ1UKle73DqEJy8GZQnhNgqh96B72wyD7xpIscCFkjE575cCA/qBsgATOtHnA6baGCMmtTqvGFCClgQ3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731685157; c=relaxed/simple;
	bh=sdG3w+G9+OIVdjAMeB4TgelVxcnKeu3t8QBg4/G0eW0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=E0ffSQm6wdAIZbeG4eiDQuoS50QSLPj4AVLeWkoRSqBjhDQ+z3WYUXaqctjXPTzoE6dRAje9lGfLhCqATypE1ZtxcXx1IUgZTu4uMOs0bVFeDEQbL37nZgLRID9qd/4BT9TDFl11znxTIQO1imwv/B0wrzhxm7PrgpGS/TLCgc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ar0JnXH7; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id DE87D60006;
	Fri, 15 Nov 2024 15:39:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1731685153;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=mhhEC7K7kk9X7QSzMnKg5dPF5YFUOEw6hgnKOERbfU0=;
	b=ar0JnXH7A+g4vwgzpyWfRy8ixMfdNQhnWR2mEIRQ+4lwBSPnbb8qqk0J5kkcRUO7+BqAGe
	oUbjdOEqT0ZSy2zmcMim9hF704WaD/D1ln9gUhEGazpBcw9HfTmgHW5hDV3l0F3Y0OZbj2
	zDqC8jxFlVIyL6eFWFxfkMh0gp0rs2YmhS6vnymrgPS8EKDCeS0uDJ8QOZBgmKIy1wwgJE
	TGwdYFmm2nmbypVXLZKbXrKHWqybRxsTjKtkl24pU/Ykbkofv7nSTs/3r7+iGrb7XNnhya
	g7Xhuy3fJ+SiLiY8Ias/ybsnxcaRIvub9+YY1GF8Z3Atti76aXduXuNg/EcacA==
From: Thomas Richard <thomas.richard@bootlin.com>
Subject: [PATCH v3 0/2] Enable sensors support for the Congatec Board
 Controller
Date: Fri, 15 Nov 2024 16:39:07 +0100
Message-Id: <20241115-congatec-board-controller-hwmon-v3-0-1c45637c8266@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABtrN2cC/4XOuU7EMBQF0F+JXGPkfZmK/0AUXl4mlpIYbBNAo
 /w7TqaBarp3X3HuvaEKJUFFl+GGCmypprz2wJ8GFCa3XgGn2DNihAliiMUhr1fXIGCfXYlHbCX
 PMxQ8fS15xWBB8WiljpyjrrwXGNP32fD6ds8FPj57Ubs/kXcVurMsqV0GOo4QiJFKj4IpR4O0H
 Ag3wcWgqI+hn14ojQ5rSrXl8nOO3+iJHTspJeLhzo1igo2mIEKUNhp48Tm3Oa3Pfcqpb+yvaB6
 LrItUAeeaWyOZ/i/u+/4L4UACbG4BAAA=
To: Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, 
 Lee Jones <lee@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org, 
 thomas.petazzoni@bootlin.com, blake.vermeer@keysight.com, 
 Thomas Richard <thomas.richard@bootlin.com>
X-Mailer: b4 0.14.1
X-GND-Sasl: thomas.richard@bootlin.com

This is the third iteration of this series which enables sensors support
for the Congatec Board Controller.

The cgbc_hwmon_compute_curr_channel() macro which computed the channel for
current sensor was removed. To get the channel id of a currrent sensor
(from the Board Controller point of view) we just have to add a constant.

Regards,

Thomas

Signed-off-by: Thomas Richard <thomas.richard@bootlin.com>
---
Changes in v3:
- remove the cgbc_hwmon_compute_curr_channel() macro.
- Link to v2: https://lore.kernel.org/r/20241108-congatec-board-controller-hwmon-v2-0-16e337398527@bootlin.com

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
 drivers/hwmon/cgbc-hwmon.c | 304 +++++++++++++++++++++++++++++++++++++++++++++
 drivers/mfd/cgbc-core.c    |   1 +
 5 files changed, 316 insertions(+)
---
base-commit: 1ffec08567f426a1c593e038cadc61bdc38cb467
change-id: 20240809-congatec-board-controller-hwmon-e9e63d957d33

Best regards,
-- 
Thomas Richard <thomas.richard@bootlin.com>


