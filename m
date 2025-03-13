Return-Path: <linux-kernel+bounces-560295-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCB88A601FE
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 21:10:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4574F3AF748
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 20:10:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A2371F4604;
	Thu, 13 Mar 2025 20:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WKuhx0i/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 686901F4160;
	Thu, 13 Mar 2025 20:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741896635; cv=none; b=a484eI5FIc2z5jyOyFuuJlkRog8HBTjaPaYeN/rRJGKnPb3Xt9suzQZbGYzhLl7ky9QsIKwIJWdrAHufIcbMuxCP1pSCWkqO8pChM7x38c7vKyVgzYB50UDhg83G0oJ7/icIqGjz+aA2xCP+evGg3CBA+7dGlAAwFcAuqmXnZh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741896635; c=relaxed/simple;
	bh=T0rWpFRosU3djnuMSSt9rEefSFjjppoUppZgCBq2n3A=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=LyPBFXi0gk0n2gA6gXfZvMSYWLHHu9JmGjtjOwfBhDwfNP+NNXDh8uMWcRBF0a3rhbMj0eiRf8sH5faMU/S6W1N3j/ZzSXsKr73vP9IFFC+fJysMznqRDlbXkHI9vvS0sf9efqg37KnFFl4nTQZl9SbdD3OgcYLbt6fvKtAkPbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WKuhx0i/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id DF986C4CEDD;
	Thu, 13 Mar 2025 20:10:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741896634;
	bh=T0rWpFRosU3djnuMSSt9rEefSFjjppoUppZgCBq2n3A=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=WKuhx0i/lT16+dcLM9EDBMVPZjIkHwu6abdmqEKxiGytulMnts60iTVLxF/Qdg7wN
	 l1h/729Fs7s7Esr+gZxHSXm+nG+sc5bFWjluDdPSfTSCZzegjsvGlWblxUGqTzYbt6
	 5QhQUkKnvph735m5YqF0LaEqUkOdDtyqX1XIWQvrrMrxwYIEPFP/icLs2zsEc6F4KE
	 4nU3MrPW/ARK6BXBwut9Z/6v9KsT1XWvkS/IamoxVk1sYLgaZYIqoq3HNaN/7XJlRX
	 lna1VvF7O8T8M+gfSc4iFiAKABd/UQnrpDtm3iRCt0dVBvsCHMHwcBsBCkBtPIY0si
	 x42tQMi/edWSA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3C0AC282DE;
	Thu, 13 Mar 2025 20:10:34 +0000 (UTC)
From: Cryolitia PukNgae via B4 Relay <devnull+Cryolitia.gmail.com@kernel.org>
Subject: [PATCH v6 0/2] hwmon: add GPD devices sensor driver
Date: Fri, 14 Mar 2025 04:10:29 +0800
Message-Id: <20250314-gpd_fan-v6-0-1dc992050e42@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIALU702cC/3XMTWrDMBCG4asErasyM/p1Vr1HKEWyRo6gsYNdT
 Erw3asEio1Ll98wz3sXE4+FJ3E83MXIc5nK0NdhXw6iPYe+Y1lS3YKANDi0srumjxx6aVxW0JB
 qvdeifl9HzuX2LJ3e6z6X6WsYv5/hGR/Xv40ZJUilwWBKDgPYt+4SyudrO1zEozHT1rnVUXXZR
 cc2Npkw7p36x6nqfHKcI5JV0e2d3jq/Ol0domWjFYYm896ZX2eAEFdnqrPgsyZjMjBu3bIsP72
 6Rvh+AQAA
X-Change-ID: 20240716-gpd_fan-57f30923c884
To: Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, 
 Cryolitia PukNgae <Cryolitia@gmail.com>, Jonathan Corbet <corbet@lwn.net>
Cc: linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org, 
 linux-doc@vger.kernel.org, Celeste Liu <CoelacanthusHex@gmail.com>, 
 Yao Zi <ziyao@disroot.org>, Derek John Clark <derekjohn.clark@gmail.com>, 
 =?utf-8?q?Marcin_Str=C4=85gowski?= <marcin@stragowski.com>, 
 someone5678 <someone5678.dev@gmail.com>, 
 Justin Weiss <justin@justinweiss.com>, 
 Antheas Kapenekakis <lkml@antheas.dev>, command_block <mtf@ik.me>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2083;
 i=Cryolitia@gmail.com; s=20250314; h=from:subject:message-id;
 bh=T0rWpFRosU3djnuMSSt9rEefSFjjppoUppZgCBq2n3A=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0VCYlFHUy9wQU5Bd0FJQVQ1ZEYzTDhpb
 zdkQWNzbVlnQm4wenUyT0pEZDkrdVg1WEpmNzRURkhYelBsTDM4CjNXaEFueXd0dHJJNXVVTC90
 SmFKQVRNRUFBRUlBQjBXSVFSME5XMHB5dmR3U0JGOENDWStYUmR5L0lxTzNRVUMKWjlNN3RnQUt
 DUkErWFJkeS9JcU8zVHpvQi80ZytaeDh1Sk9CUU0rakJRNlo4T2tiY2ZjeFU3M1VjNHVFVDN4WA
 pBdi9la3lQYS9KN3NqYjFYekVLUjA0UU9iSFpKckJEWVdDTDFRbUNxWHFtTmh6bkFGSHkyN2Y1a
 VhMMHl5T0FRCnArb1E1eGZuU1lCMkRzQldsS2J1NWMrVWw0YngxMlZWRURVWTMxWUJiR0paQWw3
 VFFQc1hOanl0ZUxETUhteWoKRkJvSEdPT3FQUElZWFdFRXhLcHVndDdoRHhrOVNsV1c3RkIxZmR
 hM3FsTTcwM1VjMStjMWpuUlhDR2w1Q3J4awpmdDJJbVA5OXJIVEVMUUliQ21UU1ZCOEJZRmdJek
 xpOUtYY0tocEN3VGdoTkxSVW16OXYxUnRuRGhLT1piQ3FRCm5RcGhYcTdSd1UrdHJjVmQ5MHVuR
 3RaVGRPTVBWdlVCcFBnSldtVDdyZ2lrYklYMAo9U3paNgotLS0tLUVORCBQR1AgTUVTU0FHRS0t
 LS0tCg==
X-Developer-Key: i=Cryolitia@gmail.com; a=openpgp;
 fpr=1C3C6547538D7152310C0EEA84DD0C0130A54DF7
X-Endpoint-Received: by B4 Relay for Cryolitia@gmail.com/20250314 with
 auth_id=358
X-Original-From: Cryolitia PukNgae <Cryolitia@gmail.com>
Reply-To: Cryolitia@gmail.com

Sensors driver for GPD Handhelds that expose fan reading and control via
hwmon sysfs.

Shenzhen GPD Technology Co., Ltd. manufactures a series of handheld
devices. This driver implements these functions through x86 port-mapped IO.

Tested-by: Marcin Strągowski <marcin@stragowski.com>
Tested-by: someone5678 <someone5678.dev@gmail.com>
Tested-by: Justin Weiss <justin@justinweiss.com>
Tested-by: Antheas Kapenekakis <lkml@antheas.dev>
Tested-by: command_block <mtf@ik.me>

Signed-off-by: Cryolitia PukNgae <Cryolitia@gmail.com>

---
Changes in v6:
- fix: nullptr and label followed by a declaration
- cleanup: clean up code and rename some function
- format code
- dmi: add 2025 new GPD devices
- Link to v5: https://lore.kernel.org/r/20250211-gpd_fan-v5-0-608f4255f0e1@gmail.com

Changes in v5:
- Rebase on kernel 6.13
- Remove all value-cache related code
- Clean up code
- Link to v4: https://lore.kernel.org/r/20240718-gpd_fan-v4-0-116e5431a9fe@gmail.com

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

 Documentation/hwmon/gpd-fan.rst |  71 +++++
 Documentation/hwmon/index.rst   |   1 +
 MAINTAINERS                     |   7 +
 drivers/hwmon/Kconfig           |  10 +
 drivers/hwmon/Makefile          |   1 +
 drivers/hwmon/gpd-fan.c         | 681 ++++++++++++++++++++++++++++++++++++++++
 6 files changed, 771 insertions(+)
---
base-commit: ffd294d346d185b70e28b1a28abe367bbfe53c04
change-id: 20240716-gpd_fan-57f30923c884

Best regards,
-- 
Cryolitia PukNgae <Cryolitia@gmail.com>



