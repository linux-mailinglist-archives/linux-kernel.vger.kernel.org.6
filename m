Return-Path: <linux-kernel+bounces-255890-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B82D934649
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 04:22:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 43CBC1F22749
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 02:22:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0141F29413;
	Thu, 18 Jul 2024 02:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WCpVsSHj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3854915C3;
	Thu, 18 Jul 2024 02:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721269349; cv=none; b=khoaQw3FrRWQztcIv8d/WCLzm8B6Kews6JjK5qhbG2HFph643LPfYvTC7PeEljsEOp0UL2y2uWdvwRpTYTQLfS8Q1Lp1LMhsPnTc3fXUv10chjjHn891+K6cb+QYQZvUd7MNV1434MfI45HTkuPP546es7BbeKxEXNSg9+j1DB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721269349; c=relaxed/simple;
	bh=LVaqsqmGIy9CINW58oVHBqj5bVtiVxWM9b/S4sE4Wpo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=cho7ZBlyKvhhK1PuEkGqNGYby1lrqZTOZ2PKwsXfBSc9yRrxJTD5eKcPgmGnXh4Nue6X/L7dHHPpuNu4ACIFUCYiBbed5rRYYofprI9a53BGVFjwMZgicdMp4PbBwn3P6niAAEfaZt6O035jlz1CGzpLZIsn/88IV2S50mRE13s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WCpVsSHj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C2FCAC4AF0B;
	Thu, 18 Jul 2024 02:22:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721269348;
	bh=LVaqsqmGIy9CINW58oVHBqj5bVtiVxWM9b/S4sE4Wpo=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=WCpVsSHjtEgKfraWjAqYbWeVqyczSUmRue9cPzCKp47MgXoYRQ9yH7Gyog241/tLI
	 f10xljkPo6DsVrBkCXpQfmz8tjBKN/+gAdwIMk+N3WyJTiR4QkaeQfFAH8DGUYW+1q
	 0v6XuxoX+7mf5oUEyb8AXL5QWfs3bpBFdADh0fv7iv7rzNOvwAFVeyTO+LiDtoN/Qd
	 4rRK8/QK1X9uLqb4ugF6B1jFAORP+VIdMny/jYPc5fEUsV8VT6RzjZj53SABU222l6
	 rfOCGI5X88yvawG2/VG6KQwvtvnzatUZqUZdIZWahcAEvhkOM+XcmJWRGQU2mtzu/h
	 QXp0mL77n4DMg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADFDEC3DA60;
	Thu, 18 Jul 2024 02:22:28 +0000 (UTC)
From: Cryolitia PukNgae via B4 Relay <devnull+Cryolitia.gmail.com@kernel.org>
Subject: [PATCH v4 0/2] hwmon: add GPD devices sensor driver
Date: Thu, 18 Jul 2024 10:22:22 +0800
Message-Id: <20240718-gpd_fan-v4-0-116e5431a9fe@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAF58mGYC/3XMSwrCMBSF4a2UjI3k1dzWkfsQkaRJ2oB9kEhQS
 vdu2olFcXgu9/tnFG3wNqJTMaNgk49+HPIQhwI1nRpai73JGzHCBAEqcTuZm1MDLsFxUjPeVJV
 A+XsK1vnnVrpc8+58fIzhtYUTXa+/jUQxwVyQkhoDVBF5bnvl78dm7NHaSGzv4ONYdg40WKlrx
 6j+dvyP49lVBqzTlEmuYe+WZXkDP8DMAQ4BAAA=
To: Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, 
 Cryolitia PukNgae <Cryolitia@gmail.com>, Jonathan Corbet <corbet@lwn.net>
Cc: linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org, 
 linux-doc@vger.kernel.org, Celeste Liu <CoelacanthusHex@gmail.com>, 
 Yao Zi <ziyao@disroot.org>, 
 =?utf-8?q?Marcin_Str=C4=85gowski?= <marcin@stragowski.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1481;
 i=Cryolitia@gmail.com; h=from:subject:message-id;
 bh=LVaqsqmGIy9CINW58oVHBqj5bVtiVxWM9b/S4sE4Wpo=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0VCYlFHUy9wQU5Bd0FJQVQ1ZEYzTDhpb
 zdkQWNzbVlnQm1tSHhnbGpjRlhLYnRNSzNOSWZjaHd0dzEyNmxZClF3MzVmRG5Rd1FaemZUdnY3
 RmVKQVRNRUFBRUlBQjBXSVFSME5XMHB5dmR3U0JGOENDWStYUmR5L0lxTzNRVUMKWnBoOFlBQUt
 DUkErWFJkeS9JcU8zZFpsQ0FDTDdWR1FXWjhaM054OXZFcHhpTlFtd290Y1ZBUFBuQ0lxZHlFNQ
 pNc0tKNjdSSWZwNW1YbWNLaWREdWJveVQ3ckZUOEk5a04rd0lDWlJ6UFNLbnNHQUZNTUhCU0kwc
 nFHdVM4QzZJCi94RnloWkpubzVhVmVBeUJPUEFYNHhobjVjOGhXV1RtVUo1WlNwMXM2N3RzRmpp
 bitiZXJHdmpyMVdzVWtQOC8KZllXK2xpV3VyUk1NZlNMYVpHSVhvUVhtTzZPWnFNendaWTFGdHF
 jSnIrbHZuSURidUFndjU0SjlUUXQ1THVZQgpVMytKNXk0clFYMUhINVNST2VnWk5zeGY2dVM2cl
 pBRGdtNis0VXg4ajA5U2cyL2Iycm1Va2NERlB1a2ZUK2xKCkRGVm9nWDJuMlJuRmJBMDZ2RGdQa
 UpXSHp2NHpPc3B3RnBZVmFUK0dnVHBGTkdlRgo9OTNCSAotLS0tLUVORCBQR1AgTUVTU0FHRS0t
 LS0tCg==
X-Developer-Key: i=Cryolitia@gmail.com; a=openpgp;
 fpr=1C3C6547538D7152310C0EEA84DD0C0130A54DF7
X-Endpoint-Received: by B4 Relay for Cryolitia@gmail.com/default with
 auth_id=186
X-Original-From: Cryolitia PukNgae <Cryolitia@gmail.com>
Reply-To: Cryolitia@gmail.com

Sensors driver for GPD Handhelds that expose fan reading and control via
hwmon sysfs.

Shenzhen GPD Technology Co., Ltd. manufactures a series of handheld
devices. This driver implements these functions through x86 port-mapped IO.
I have tested it on my device.

Tested-by: Marcin Strągowski <marcin@stragowski.com>
Signed-off-by: Cryolitia PukNgae <Cryolitia@gmail.com>

---
Changes in v4:
- Apply suggest by Krzysztof Kozlowski, thanks!
- Link to v3: https://lore.kernel.org/r/20240717-gpd_fan-v3-0-8d7efb1263b7@gmail.com

Changes in v3:
- Re-arrange code, thanks to Krzysztof Kozlowski, Guenter Roeck, Yao Zi!
- Link to v2: https://lore.kernel.org/r/20240717-gpd_fan-v2-0-f7b7e6b9f21b@gmail.com

Changes in v2:
- Improved documentation, thanks to Randy Dunlap!
- Link to v1: https://lore.kernel.org/r/20240716-gpd_fan-v1-0-34051dd71a06@gmail.com

---
Cryolitia PukNgae (2):
      hwmon: add GPD devices sensor driver
      hwmon: document: add gpd-fan

 Documentation/hwmon/gpd-fan.rst |  63 ++++
 Documentation/hwmon/index.rst   |   1 +
 MAINTAINERS                     |   7 +
 drivers/hwmon/Kconfig           |  10 +
 drivers/hwmon/Makefile          |   1 +
 drivers/hwmon/gpd-fan.c         | 683 ++++++++++++++++++++++++++++++++++++++++
 6 files changed, 765 insertions(+)
---
base-commit: d67978318827d06f1c0fa4c31343a279e9df6fde
change-id: 20240716-gpd_fan-57f30923c884

Best regards,
-- 
Cryolitia PukNgae <Cryolitia@gmail.com>



