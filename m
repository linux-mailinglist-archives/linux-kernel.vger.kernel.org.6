Return-Path: <linux-kernel+bounces-180950-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BDFAE8C7554
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 13:36:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 763941F2140A
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 11:36:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8728D145A00;
	Thu, 16 May 2024 11:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lexina.in header.i=@lexina.in header.b="egHtQ4F+"
Received: from mx.adeep.su (mx.adeep.su [185.250.0.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 387B314534B;
	Thu, 16 May 2024 11:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.250.0.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715859395; cv=none; b=WqH4haqhTri5luV3RPhuLXN/Ypq439HvRVOOAJxsLRZc8cwa+LeVmpjJ1I43bU+vZgT4tCr+yoBS01H1uSkWgaO2D1eCQZGqi60mPgjabOnBvFNnx/tpxoevzI4S44ZXki70UaR81t6lLhlI0ZKgR2uvRKpDeEpkUslvjKrhbyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715859395; c=relaxed/simple;
	bh=jRAplkMGZAxRl+YlUVuwSaTujLUc2ybmBsqv8xVkotA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=b4JNuiFODEAvEv4vJdr3TpEmNYWXzSWT8hcTpEgFfiGNvKB9NGtGbXq7sTGDgWNvz3OQp0FKO62bnD5DCZ/8zhcyROCdS2WM+rs2/uWFDkaUXbY8G6xDoBhgCwG3ckLv9Y0fz9qRvvGlJBdxSbX75MXbwW/yhqTFJSrFmYQFNy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=lexina.in; spf=pass smtp.mailfrom=lexina.in; dkim=pass (2048-bit key) header.d=lexina.in header.i=@lexina.in header.b=egHtQ4F+; arc=none smtp.client-ip=185.250.0.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=lexina.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lexina.in
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 6932918170C;
	Thu, 16 May 2024 14:30:50 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lexina.in; s=dkim;
	t=1715859059; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=sUG/HeDQDW4dy64C0qHQoZwiODpoUoBXq67d+LqK3k4=;
	b=egHtQ4F+dV+UXp3/kecB5/+VfV45KSAUR30fC10xz/2JaZE1/uLf2qOoxDeUq3CvvVoANB
	z6CgefUJJBUUGDwHkQEGbNuBmw4RJW/CPdIGKd8lncyzwhIul13hrw7ZpBAn642wlb54Pb
	7zvk/fjDw+KfNGvCTIsdH8bOlcRI29oOieoRb7KHYJ10ep+PZbL6ZP1xQ7j9fbh69Hii25
	KrJtfJvqHFbmt2IJahBXG6387HBHh8RDdRai1xw+g5cZVe9z4E6VqFioHkt+ikCy5iENdV
	PP5e7u1I/njjpcrqmUJSwbZHzs6bLsAGNZ/7NGB7tD86eRlm+lJdIPg6iFsReg==
From: Viacheslav Bocharov <adeep@lexina.in>
To: Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-amlogic@lists.infradead.org,
	devicetree@vger.kernel.org
Cc: Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Subject: [PATCH v4 0/4] soc: amlogic: add new meson-gx-socinfo-sm driver
Date: Thu, 16 May 2024 14:26:45 +0300
Message-ID: <20240516112849.3803674-2-adeep@lexina.in>
X-Mailer: git-send-email 2.43.2
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

Changes
 v3 [1] -> v4:
 - rebase
 - fix double free of pointers, thanks to Krzysztof Kozlowski

 v2 [2] -> v3:
 - rebase
 - update dependency in Kconfig for MESON_GX_SOCINFO_SM
 - add links to secure-monitor in soc driver sections for A1, AXG, GX, G12

 v1 [3] -> v2:
 - create cpu_id structure for socinfo variable
 - create meson_sm_chip_id for result of sm call
 - remove shared functions
 - move from funcs for bit operations to C bit fields

Links:
 - [1] https://lore.kernel.org/linux-arm-kernel/ZfMJ_Z07QkwFbOuQ@bogus/T/
 - [2] https://lore.kernel.org/linux-arm-kernel/20240221143654.544444-1-adeep@lexina.in/
 - [3] https://lore.kernel.org/linux-arm-kernel/202311242104.RjBPI3uI-lkp@intel.com/T/


Viacheslav Bocharov (4):
  soc: amlogic: meson-gx-socinfo: move common code to header file
  soc: amlogic: meson-gx-socinfo-sm: Add Amlogic secure-monitor SoC
    Information driver
  soc: amlogic: meson-gx-socinfo: add new definition for Amlogic A113X
    package
  arm64: dts: meson: add dts links to secure-monitor for soc driver in
    a1, axg, gx, g12

 arch/arm64/boot/dts/amlogic/meson-a1.dtsi     |   1 +
 arch/arm64/boot/dts/amlogic/meson-axg.dtsi    |   1 +
 .../boot/dts/amlogic/meson-g12-common.dtsi    |   1 +
 arch/arm64/boot/dts/amlogic/meson-gx.dtsi     |   1 +
 drivers/soc/amlogic/Kconfig                   |  10 +
 drivers/soc/amlogic/Makefile                  |   1 +
 .../soc/amlogic/meson-gx-socinfo-internal.h   | 121 +++++++++++
 drivers/soc/amlogic/meson-gx-socinfo-sm.c     | 189 ++++++++++++++++++
 drivers/soc/amlogic/meson-gx-socinfo.c        | 136 ++-----------
 9 files changed, 339 insertions(+), 122 deletions(-)
 create mode 100644 drivers/soc/amlogic/meson-gx-socinfo-internal.h
 create mode 100644 drivers/soc/amlogic/meson-gx-socinfo-sm.c


base-commit: 1b294a1f35616977caddaddf3e9d28e576a1adbc
-- 
2.43.2


