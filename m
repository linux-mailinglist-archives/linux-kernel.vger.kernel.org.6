Return-Path: <linux-kernel+bounces-176463-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BFDC8C304C
	for <lists+linux-kernel@lfdr.de>; Sat, 11 May 2024 11:05:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EA3CEB213A0
	for <lists+linux-kernel@lfdr.de>; Sat, 11 May 2024 09:05:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C57D453373;
	Sat, 11 May 2024 09:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="hof7zviL"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F40142045
	for <linux-kernel@vger.kernel.org>; Sat, 11 May 2024 09:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715418326; cv=none; b=D03kjZ3nWltc8L8pmynQuRKxvXHmENQYRcFx4+OgKp/hseNlRjNL8uI12yuPxj4QuVLph1VwlldUtQ886W+ua+HpvIQtGuzRMAxybVz27OeTgK0EDD5pEk0o6F97moV9ZZlxJfmi68wEkVh6lOP5zGNo4qt7xWIvnoH+xz8RKQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715418326; c=relaxed/simple;
	bh=EUxaiApsNK6zh7PGenlNCHnyPfCDjkWN62rs+PnisIE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=j1HhgEiezfddZ/krQjjfuFAqUvY0UnTqjIsHi5TdURgk9zkMkrJvfUhJ7WCUUs9aPalQtUD/QLLjvPaRXuZGpnuJbgAye3Y4FMXvsUJG49meoWcRQp/glO1raYujj7H5nScJTW5P6PsCJPQbYlJlC7BFZMX8vr8HfU/6rEqNW44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=hof7zviL; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1715418315;
	bh=EUxaiApsNK6zh7PGenlNCHnyPfCDjkWN62rs+PnisIE=;
	h=From:Subject:Date:To:Cc:From;
	b=hof7zviL4nbxgdHC2oKynsxbyFFFtVFN1erSYAMWC0Cf5nr3mZD1s2Y9uhdLrlv5z
	 gyko8+lLNXIj7XpKUZ9W+ZuLE2a95Dj1fkUvzp8i60Rtz1OLBg5eDL1aLDQnyHe6Sm
	 N4+/3wR5wSpOiVcpKwgU1zWneQyQdxB0H4ucYEac=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Subject: [PATCH v2 0/2] cros_kbd_led_backlight: allow binding through
 cros_ec mfd device
Date: Sat, 11 May 2024 11:05:11 +0200
Message-Id: <20240511-cros_ec-kbd-led-framework-v2-0-b20c48109e46@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAMc0P2YC/42NQQ6CMBBFr0K6dkxbRNSV9zDEwHSwDUrNDIKGc
 HcrJ3D5XvLfn5UQBxJ1ymbFNAYJsU9gN5lCX/c3guASK6vtThe6AOQoV0LoGgd3ctBy/aApcgc
 lWTrkpsHyiCrtn0xteK/tS5XYBxkif9ar0fzsP9XRgIGmRaz3R21yZ88TBRFB//LbngZVLcvyB
 RpcXNLHAAAA
To: Lee Jones <lee@kernel.org>, Benson Leung <bleung@chromium.org>, 
 Guenter Roeck <groeck@chromium.org>, Tzung-Bi Shih <tzungbi@kernel.org>
Cc: chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Dustin Howett <dustin@howett.net>, 
 Mario Limonciello <mario.limonciello@amd.com>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1715418314; l=1459;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=EUxaiApsNK6zh7PGenlNCHnyPfCDjkWN62rs+PnisIE=;
 b=aP8fvKaYXjODjTH2ODPYM54KB3RhOuXBAaFyF8Og/Nds6iRsZ0NqAgnu1ladY7R7WuDOKlPl5
 sT+5Jvm9w1TB/WqOYCgdT60CisTfNS+7AwG75HNG8GXG4KgfF/wvMqU
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

Extend the cros_ec MFD device to also load cros_kbd_led_backlight
when the EC reports EC_FEATURE_PWM_KEYB.

Tested on a Framework 13 AMD, Firmware 3.05.

This is based on
https://git.kernel.org/pub/scm/linux/kernel/git/chrome-platform/linux.git for-next

The helper keyboard_led_is_mfd_device is a bit iffy, but I couldn't find
a nicer way.

* driver_data from platform_device_id is overwritten by the mfd platform data
* Setting the driver_data in drivers/mfd/cros_ec_dev.c would expose the
internals of cros_kbd_led_backlight

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
Changes in v2:
- Fix build with CONFIG_MFD_CROS_EC_DEV=n (kernel test robot)
- Split out mfd registration into own commit (Lee)
- Simplify keyboard_led_is_mfd_device() with mfd_get_cell()
- Link to v1: https://lore.kernel.org/r/20240505-cros_ec-kbd-led-framework-v1-1-bfcca69013d2@weissschuh.net

---
Thomas Weißschuh (2):
      platform/chrome: cros_kbd_led_backlight: allow binding through mfd device
      mfd: cros_ec: Register keyboard backlight subdevice

 drivers/mfd/cros_ec_dev.c                        |  9 ++++++
 drivers/platform/chrome/cros_kbd_led_backlight.c | 36 +++++++++++++++++++++++-
 2 files changed, 44 insertions(+), 1 deletion(-)
---
base-commit: 2fbe479c0024e1c6b992184a799055e19932aa48
change-id: 20240505-cros_ec-kbd-led-framework-7e2e831bc79c

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>


