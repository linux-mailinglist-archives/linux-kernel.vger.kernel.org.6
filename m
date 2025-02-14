Return-Path: <linux-kernel+bounces-514596-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 67DDAA3590E
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 09:39:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1296A167743
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 08:39:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2F0E225784;
	Fri, 14 Feb 2025 08:39:05 +0000 (UTC)
Received: from riemann.telenet-ops.be (riemann.telenet-ops.be [195.130.137.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66FBF1F8908
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 08:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.137.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739522345; cv=none; b=BhB38qwIsJyDb+Hkhq50mk9uVZ5DkRkcHaLoABvNSpZovCLf6NDqL45arOlWgmzeuBLCaaSpTGQpIb4HUDqWDua7FzffiQ4YxuL14wos3k6PX4yaMOmp199rY/o39kseHbluj3H7Z/SVHexzmvo141hYpf6yN5qS4L6/jwaCoFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739522345; c=relaxed/simple;
	bh=m6LOnvLdqGNrtosOeyS1DMd9La0cHs0pnyRYZ2ICHvI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fLEN5BabRf/Qkb9t6y8n+vcliGRGtY/uRxmTxirQ/hhSYtcuNxfxFYvPmLY1os3iLHMyXHYDDoi8UZ8MigcBpLAsb8fQ7tSKJgRnGt+3a9ln9rmMmzsKy/s9Zvxl8KqlyRx7p5TmZkFFE+PC0mQGgqITMwq2OGO4MJ7uh7Pf250=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.137.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from michel.telenet-ops.be (michel.telenet-ops.be [IPv6:2a02:1800:110:4::f00:18])
	by riemann.telenet-ops.be (Postfix) with ESMTPS id 4YvQJB36Stz4x0c1
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 09:31:38 +0100 (CET)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed80:6395:73cc:7fc4:4cab])
	by michel.telenet-ops.be with cmsmtp
	id DLXW2E00l1MuxXz06LXWSh; Fri, 14 Feb 2025 09:31:31 +0100
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.97)
	(envelope-from <geert@linux-m68k.org>)
	id 1tir6P-00000006SBp-20fI;
	Fri, 14 Feb 2025 09:31:30 +0100
Received: from geert by rox.of.borg with local (Exim 4.97)
	(envelope-from <geert@linux-m68k.org>)
	id 1tir6g-00000000SHk-2rkW;
	Fri, 14 Feb 2025 09:31:30 +0100
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Andy Shevchenko <andy@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v3] platform: cznic: CZNIC_PLATFORMS should depend on ARCH_MVEBU
Date: Fri, 14 Feb 2025 09:31:29 +0100
Message-ID: <7dbfdcd1eff8429d0744215c1adba09d5a92c4ed.1739521792.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

CZ.NIC's Turris devices are based on Marvell EBU SoCs.  Hence add a
dependency on ARCH_MVEBU, to prevent asking the user about these drivers
when configuring a kernel that cannot run on an affected CZ.NIC Turris
system.

Fixes: 992f1a3d4e88498d ("platform: cznic: Add preliminary support for Turris Omnia MCU")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v3:
  - Drop redundant MACH_ARMADA_38X, as it implies ARCH_MVEBU,

v2:
  - Drop PPC_P2020 from the dependency list.
---
 drivers/platform/cznic/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/platform/cznic/Kconfig b/drivers/platform/cznic/Kconfig
index 49c383eb67854173..13e37b49d9d01ec3 100644
--- a/drivers/platform/cznic/Kconfig
+++ b/drivers/platform/cznic/Kconfig
@@ -6,6 +6,7 @@
 
 menuconfig CZNIC_PLATFORMS
 	bool "Platform support for CZ.NIC's Turris hardware"
+	depends on ARCH_MVEBU || COMPILE_TEST
 	help
 	  Say Y here to be able to choose driver support for CZ.NIC's Turris
 	  devices. This option alone does not add any kernel code.
-- 
2.43.0


