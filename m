Return-Path: <linux-kernel+bounces-207864-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEF2E901D28
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 10:41:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9313E2837D2
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 08:41:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 489896F314;
	Mon, 10 Jun 2024 08:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lexina.in header.i=@lexina.in header.b="EJ3IuO7Z"
Received: from mx.adeep.su (mx.adeep.su [185.250.0.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AC6A4D8A0;
	Mon, 10 Jun 2024 08:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.250.0.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718008874; cv=none; b=a8xzv8l+pJ1QCK6hceyOsRyuh3Elc4/l6J3PQladZp0gxodiyvfZwa51QLdXkTphgIvyWfSNZiBj0gYcMWZKXn+xy7PYEyZ/+B+yySSJcHq0WoP11JhJxzLQ+8m8WOPZR8pURK71d0cnXaUgdT1mlKjMhSb5EIB7CqWYjc0qpHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718008874; c=relaxed/simple;
	bh=MnVsMmU7g3peA9glJLlU6ZcqIz63HdOceSwauMxgJ9o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FFakBYv4doghYHwN3HQd1HcrgmQv1mc0+QQ+mkKGNTwC3kJsEm6LqVJH3WK8kmF1K+ex+xpMNBjGUnLvqvj9dudef7LQ7gRZ3pI9mnSPc5C54ptD0mmGQSTP7jG6MiITIKQuMWz/keFqBmP39lj6sfOAXtBrUdHZ9Cov6/KXYRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=lexina.in; spf=pass smtp.mailfrom=lexina.in; dkim=pass (2048-bit key) header.d=lexina.in header.i=@lexina.in header.b=EJ3IuO7Z; arc=none smtp.client-ip=185.250.0.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=lexina.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lexina.in
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id DDC5AFACA4;
	Mon, 10 Jun 2024 11:40:44 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lexina.in; s=dkim;
	t=1718008860; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=KX0WP5RREiDGDx3/PUkOePlvWq8o7D3HqgRLqhu8168=;
	b=EJ3IuO7ZXTkFnLeqgnsSL+LWgwJVOHnqXujoQN37ycugx5R5+OFSVDaLw0rtmexW7rmeAo
	eNMqCN9t324oj9IkTOd3s4+AWD+OjlFxnTN9P42f4YvcoNQ/2WTssF5zVYBGVi0Pa5SFcP
	5U9CBPhwpIQRx+LGohte99gjM2N8PpZCJwXu9gyX2+PrO4p9Uare87/VCPy/83IJCh6IzY
	F8/m/km/2EwbUbI/QnAbDsh+g1YrNvzjKx4ex9JiI1T31aYYvpGGmmdBKkSbityqVR7rm/
	R1ZK5+ErcA5FfacM0fgMOuHn/8rVEXB9tnErOioBo3NsLl7U/dFIMibwHYfUxg==
From: Viacheslav Bocharov <adeep@lexina.in>
To: Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-amlogic@lists.infradead.org
Cc: Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org
Subject: [PATCH v5 0/4] soc: amlogic: add new meson-gx-socinfo-sm driver
Date: Mon, 10 Jun 2024 11:39:46 +0300
Message-ID: <20240610084032.3096614-1-adeep@lexina.in>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

The Amlogic Meson SoC Secure Monitor implements a call to retrieve an
unique SoC ID starting from the GX Family and all new families.
But GX-family chips (e.g. GXB, GXL and newer) supports also 128-bit
chip ID. 128-bit chip ID consists 32-bit SoC version and 96-bit OTP data.

This is next attempt to publish data from the Amlogic secure monitor
chipid call. After discussions with Neil Armstrong, it was decided to
publish the chipid call results through the soc driver. Since
soc_device_match cannot wait for the soc driver to load, and the secure
monitor calls in turn depend on the sm driver, it was necessary to create
a new driver rather than expand an existing one.

In the patches, in addition to writing the driver:
- convert commonly used structures and functions of the meson-gx-socinfo
driver to a header file.
- add secure-monitor references for amlogic,meson-gx-ao-secure sections
in dts files of the a1, axg, g12, gx families.


---

Patch based on top:
- add new A113X SoC https://lore.kernel.org/linux-kernel/171766521601.3911648.2220702176918701226.b4-ty@linaro.org/T/
- Add S905L ID https://lore.kernel.org/linux-kernel/171766521524.3911648.14792995642693649032.b4-ty@linaro.org/T/

https://git.kernel.org/pub/scm/linux/kernel/git/amlogic/linux.git (v6.11/drivers)

Changes
 v4 [1] -> v5:
 - split patch for A113X SoC id
 - fix warnings
 - add dt-bindings
 v3 [2] -> v4:
 - rebase
 - fix double free of pointers, thanks to Krzysztof Kozlowski

 v2 [3] -> v3:
 - rebase
 - update dependency in Kconfig for MESON_GX_SOCINFO_SM
 - add links to secure-monitor in soc driver sections for A1, AXG, GX, G12

 v1 [4] -> v2:
 - create cpu_id structure for socinfo variable
 - create meson_sm_chip_id for result of sm call
 - remove shared functions
 - move from funcs for bit operations to C bit fields


Links:
 - [1] https://lore.kernel.org/linux-kernel/20240516112849.3803674-2-adeep@lexina.in/
 - [2] https://lore.kernel.org/linux-arm-kernel/ZfMJ_Z07QkwFbOuQ@bogus/T/
 - [3] https://lore.kernel.org/linux-arm-kernel/20240221143654.544444-1-adeep@lexina.in/
 - [4] https://lore.kernel.org/linux-arm-kernel/202311242104.RjBPI3uI-lkp@intel.com/T/


Viacheslav Bocharov (4):
  soc: amlogic: meson-gx-socinfo: move common code to header file
  soc: amlogic: meson-gx-socinfo-sm: Add Amlogic secure-monitor SoC
    Information driver
  dt-bindings: arm: amlogic: amlogic,meson-gx-ao-secure: add
    secure-monitor property
  arm64: dts: meson: add dts links to secure-monitor for soc driver in
    a1, axg, gx, g12

 .../amlogic/amlogic,meson-gx-ao-secure.yaml   |   4 +
 arch/arm64/boot/dts/amlogic/meson-a1.dtsi     |   1 +
 arch/arm64/boot/dts/amlogic/meson-axg.dtsi    |   1 +
 .../boot/dts/amlogic/meson-g12-common.dtsi    |   1 +
 arch/arm64/boot/dts/amlogic/meson-gx.dtsi     |   1 +
 drivers/soc/amlogic/Kconfig                   |  10 +
 drivers/soc/amlogic/Makefile                  |   1 +
 .../soc/amlogic/meson-gx-socinfo-internal.h   | 128 ++++++++++++
 drivers/soc/amlogic/meson-gx-socinfo-sm.c     | 190 ++++++++++++++++++
 drivers/soc/amlogic/meson-gx-socinfo.c        | 140 ++-----------
 10 files changed, 352 insertions(+), 125 deletions(-)
 create mode 100644 drivers/soc/amlogic/meson-gx-socinfo-internal.h
 create mode 100644 drivers/soc/amlogic/meson-gx-socinfo-sm.c


base-commit: 9584e2b31432a608bf29d074ac39e855eeee2207
-- 
2.45.2


