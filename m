Return-Path: <linux-kernel+bounces-564954-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C9D1A65D8D
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 20:08:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 883757A8892
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 19:07:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DEC51C5F3F;
	Mon, 17 Mar 2025 19:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Qk+G0POK"
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37F5E4A06
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 19:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742238477; cv=none; b=TT4HcHF9qRyg8HultS1J9BiUVYFsVrxSiTJcgFA/AYigpGdXNmKhRN/8/79GA955LNWkagXig/jjjSOKQ8YlK0treqdPHuUrOixSSp+7phDu+PuNE1gwrX+Qf81uOsJdVnn/G1HC2ZWb7uY1W9B9w3Q3zhRa5cyVG6eX9gTerAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742238477; c=relaxed/simple;
	bh=k5SCYYpsBRwFpf7Q6RTNE7sPrEry0r4DAVcFz5PIrUQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=hmQidwsFUR66W0kAeHTgi2T5Cf6hTUk33PMBE5bRMvQ4DwoNt15jXAoT8JMNKrOR0ndPPmrWafjXBdtnn1CJ4XwRQ2d3AhTCcNQOvFexifbXKBhbRb2R2WBY6YEQPEbFjihcKLxIjQraWogclh+ujmA0Ab6uVpnIeLXzThLiX+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Qk+G0POK; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 1E8AF44551;
	Mon, 17 Mar 2025 19:07:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1742238473;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=jaXa4qSjMxxtrTOqbAHbEPmRokgxUNkZQEd1dyxTX+M=;
	b=Qk+G0POKsriFz+zOgG3JvyQ0lf7BWm7yNyt6FJYGKXs6zjK6wQjQeUunim6Y5SkYtv2Bvb
	ZG8smw9+KSK/fxI+wgh6jfkazXEnoy0ocv+0v0+zFFcBQYmaEjFCYnKiDl+rs/LidOm9Et
	DNUSRRTE/aCsnFo6gPbqdEJDf2jOWsmKR2Ies3zDyj7ebNnUBaLA0p/1/S+cnKpgTIZ4va
	WFk54G4TpJv++kPmEwIdWzkEkLhQfMfZ3/3F0tSUQaA/vET7SO+EFn5Vv0d3PdQXZ+hxe+
	UR75Nv/L5ZTKYoNZTK9kD+IEcKgcoQRBvyad4iQTTUShi48RbIJDGe35YrDTUQ==
From: Thomas Richard <thomas.richard@bootlin.com>
Date: Mon, 17 Mar 2025 20:07:38 +0100
Subject: [PATCH v5] mfd: cgbc: Add a hwmon cell
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250317-congatec-board-controller-hwmon-v5-1-a83dfcb156a7@bootlin.com>
X-B4-Tracking: v=1; b=H4sIAPly2GcC/4XOy26DMBAF0F9BXteR34+s+h9VF8YegiXAqXFpq
 4h/ryGqlCoLlnc0Ovfe0Aw5wozOzQ1lWOIc01SDfGmQ7910ARxDzYgRJoghFvs0XVwBj9vkcth
 iyWkYIOP+a0wTBguKByt14BxV5Zqhi997w9v7PWf4+KxF5X5ErZuhOuMYy7lZ1IkKnD1F23Mf5
 5Lyz75uofv3NoRSIg6HLBQTbDQF4YO0wcBrm1IZ4nSqXbu+sEfRHIusilQB55pbI5l+FvmDSOW
 xyDfRC6m49oYp9SyKP1ESRvixKKrYdcpr5YRSzP8X13X9BXyWTw/zAQAA
To: Lee Jones <lee@kernel.org>
Cc: linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com, 
 blake.vermeer@keysight.com, Thomas Richard <thomas.richard@bootlin.com>
X-Mailer: b4 0.14.1
X-GND-State: clean
X-GND-Score: 0
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddugedtfedvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecunecujfgurhephfffufggtgfgkffvvefosehtjeertdertdejnecuhfhrohhmpefvhhhomhgrshcutfhitghhrghrugcuoehthhhomhgrshdrrhhitghhrghrugessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepieevfeeuieevffevvdeftedvhfekuedufeekuefffefgkeduleehieffudevieeknecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepvdgrtddumegtsgdugeemfhegtdemsghftddtmehftdehgeemtgeltgdvmedvudgtfeemudehieeinecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehinhgvthepvdgrtddumegtsgdugeemfhegtdemsghftddtmehftdehgeemtgeltgdvmedvudgtfeemudehieeipdhhvghloheplgduvdejrddtrddurddungdpmhgrihhlfhhrohhmpehthhhomhgrshdrrhhitghhrghrugessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohephedprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehthhhomhgrshdrrhhitghhrghrugessghoohhtlhhinhdrtghomhdprhgtphhtthhopehthhhomhgrshdrphgvthgriiiiohhnihessghoo
 hhtlhhinhdrtghomhdprhgtphhtthhopegslhgrkhgvrdhvvghrmhgvvghrsehkvgihshhighhhthdrtghomhdprhgtphhtthhopehlvggvsehkvghrnhgvlhdrohhrgh
X-GND-Sasl: thomas.richard@bootlin.com

The Board Controller has some internal sensors. Add a hwmon cell for the
cgbc-hwmon driver which adds support for temperature, voltage, current and
fan sensors.

Signed-off-by: Thomas Richard <thomas.richard@bootlin.com>
---
Hi Lee,

As Guenter applied the hwmon patch, I resubmit the MFD part with the
subject line and commit message fixed.

Regards,

Thomas
---
Changes in v5:
- hwmon: remove patch (already applied).
- mfd: fix subject line and commit message.
- Link to v4: https://lore.kernel.org/r/20250203-congatec-board-controller-hwmon-v4-0-ff6c76a4662c@bootlin.com

Changes in v4:
- Rebased on v6.14-rc1.
- Add the documentation for this driver.
- In Kconfig, fix a typo and improve the description
- Link to v3: https://lore.kernel.org/r/20241115-congatec-board-controller-hwmon-v3-0-1c45637c8266@bootlin.com

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
 drivers/mfd/cgbc-core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mfd/cgbc-core.c b/drivers/mfd/cgbc-core.c
index 85283c8dde253..0460e4e3f3c59 100644
--- a/drivers/mfd/cgbc-core.c
+++ b/drivers/mfd/cgbc-core.c
@@ -236,6 +236,7 @@ static struct mfd_cell cgbc_devs[] = {
 	{ .name = "cgbc-gpio"	},
 	{ .name = "cgbc-i2c", .id = 1 },
 	{ .name = "cgbc-i2c", .id = 2 },
+	{ .name = "cgbc-hwmon"	},
 };
 
 static int cgbc_map(struct cgbc_device_data *cgbc)

---
base-commit: 379487e17ca406b47392e7ab6cf35d1c3bacb371
change-id: 20240809-congatec-board-controller-hwmon-e9e63d957d33

Best regards,
-- 
Thomas Richard <thomas.richard@bootlin.com>


