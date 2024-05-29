Return-Path: <linux-kernel+bounces-193887-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8022A8D33AE
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 11:51:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A2E11F29662
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 09:51:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8644A174EE2;
	Wed, 29 May 2024 09:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qn9mLs/h"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C829416F0DC;
	Wed, 29 May 2024 09:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716976214; cv=none; b=rdAEJXQ/Y6aZccGDik0MS+nGRy8VSOoN4yqOxA4cDjxBCuMxMJlzbiVsqPAj1l//O27W2dGfVs6NJDpIfbM2ygoGa/zqcz2stW4B6gIi0cvlBOvtNoGleu7y6zNfxaQZrIGzWHaIFN3NhgXYcct9xuyvpUpe/64w9bh7YJzsTDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716976214; c=relaxed/simple;
	bh=XDTCDKbgbSdFikKLYa4k25CQJsfLSgfbo73V66b6G+U=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=X1dLD1ToQbuUF8MgszNHEigqci6jlpbmbrBh5yA2SpghfPuBeSbI4jzW+HhZh4y0V73v7PFh/L7/BsbQ8xMPvaOiruJSahZZo5cd4eL2kCh2sgJ0cxb2Gybn4jh9GGVgx92DN/QG6nFlVLhtTUShdJQ9OnGsdGnqxYvOKXMvCy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qn9mLs/h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD39CC4AF09;
	Wed, 29 May 2024 09:50:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716976214;
	bh=XDTCDKbgbSdFikKLYa4k25CQJsfLSgfbo73V66b6G+U=;
	h=From:To:Cc:Subject:Date:From;
	b=Qn9mLs/hbrBsdMC+8aNznAml0LfQq1U38SCiFU/dmfyoYUwPKkAXKVDe18wXDM34B
	 WeoM2NapLrOS/zszVUrQMBzsT2WFvIDaWlvT1nwfT2rvmVXt8Ml3FiLVJiMV7dgBRP
	 5aD8cIKTYmoOKDc/GgfUnhupXtkPpWLJX5c6rpk6/GeDxQP4Kk8520Q3/IGoQTT7Wc
	 2TnTAbUjavVbq4frUscC0R0ecvAUWxYiyYV4MvZHIRzEDKj3ZrU8efYVjCAUUDNIu2
	 QjIzVegNX8cDD3lJpB7KUj5Zj7gcMh/xK5hXSTWCdfFZhvtML8Gw79Jms/ubWeYvUo
	 51QDJ6SN49gSQ==
From: Arnd Bergmann <arnd@kernel.org>
To: Daniel Scally <djrscally@gmail.com>,
	Hans de Goede <hdegoede@redhat.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] platform/x86: int3472: make common part a separate module
Date: Wed, 29 May 2024 11:49:55 +0200
Message-Id: <20240529095009.1895618-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

Linking an object file into multiple modules is not supported
and causes a W=1 warning:

scripts/Makefile.build:236: drivers/platform/x86/intel/int3472/Makefile: common.o is added to multiple modules: intel_skl_int3472_discrete intel_skl_int3472_tps68470

Split out the common part here into a separate module to make it
more reliable.

Fixes: a2f9fbc247ee ("platform/x86: int3472: Split into 2 drivers")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/platform/x86/intel/int3472/Makefile | 9 ++++++---
 drivers/platform/x86/intel/int3472/common.c | 7 +++++++
 2 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/platform/x86/intel/int3472/Makefile b/drivers/platform/x86/intel/int3472/Makefile
index 9f16cb514397..a8aba07bf1dc 100644
--- a/drivers/platform/x86/intel/int3472/Makefile
+++ b/drivers/platform/x86/intel/int3472/Makefile
@@ -1,4 +1,7 @@
 obj-$(CONFIG_INTEL_SKL_INT3472)		+= intel_skl_int3472_discrete.o \
-					   intel_skl_int3472_tps68470.o
-intel_skl_int3472_discrete-y		:= discrete.o clk_and_regulator.o led.o common.o
-intel_skl_int3472_tps68470-y		:= tps68470.o tps68470_board_data.o common.o
+					   intel_skl_int3472_tps68470.o \
+					   intel_skl_int3472_common.o
+intel_skl_int3472_discrete-y		:= discrete.o clk_and_regulator.o led.o
+intel_skl_int3472_tps68470-y		:= tps68470.o tps68470_board_data.o
+
+intel_skl_int3472_common-y		+= common.o
diff --git a/drivers/platform/x86/intel/int3472/common.c b/drivers/platform/x86/intel/int3472/common.c
index 9db2bb0bbba4..8e4a782b2c35 100644
--- a/drivers/platform/x86/intel/int3472/common.c
+++ b/drivers/platform/x86/intel/int3472/common.c
@@ -29,6 +29,7 @@ union acpi_object *skl_int3472_get_acpi_buffer(struct acpi_device *adev, char *i
 
 	return obj;
 }
+EXPORT_SYMBOL_GPL(skl_int3472_get_acpi_buffer);
 
 int skl_int3472_fill_cldb(struct acpi_device *adev, struct int3472_cldb *cldb)
 {
@@ -52,6 +53,7 @@ int skl_int3472_fill_cldb(struct acpi_device *adev, struct int3472_cldb *cldb)
 	kfree(obj);
 	return ret;
 }
+EXPORT_SYMBOL_GPL(skl_int3472_fill_cldb);
 
 /* sensor_adev_ret may be NULL, name_ret must not be NULL */
 int skl_int3472_get_sensor_adev_and_name(struct device *dev,
@@ -80,3 +82,8 @@ int skl_int3472_get_sensor_adev_and_name(struct device *dev,
 
 	return ret;
 }
+EXPORT_SYMBOL_GPL(skl_int3472_get_sensor_adev_and_name);
+
+MODULE_DESCRIPTION("Intel SkyLake INT3472 ACPI Device Driver library");
+MODULE_AUTHOR("Daniel Scally <djrscally@gmail.com>");
+MODULE_LICENSE("GPL v2");
-- 
2.39.2


