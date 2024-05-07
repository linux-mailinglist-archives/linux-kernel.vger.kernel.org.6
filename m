Return-Path: <linux-kernel+bounces-171068-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC3628BDF69
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 12:08:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 094411C21A6F
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 10:08:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A058014F123;
	Tue,  7 May 2024 10:08:19 +0000 (UTC)
Received: from weierstrass.telenet-ops.be (weierstrass.telenet-ops.be [195.130.137.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ACE614E2FE
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 10:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.137.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715076499; cv=none; b=S9Lm4ihiWCF5BanqKdZcHB/8bNk1oBgE+Npnhv4zXlqEkWwiM4UvRAbQJBC95u9PCbguLAYgS0S0+an5QKjzD2fu1Nj8Y5gq8X0X9xKJUQiGz+jl1NTJBnXGzLYBZeVu390fYOg9r5Cml+RkOfqtNpb7ivtv6BBsIOxveSH/Gqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715076499; c=relaxed/simple;
	bh=f4d9Fh8eoRz2byJ+fQ9qpBft/VuDQjnlCNF03HfpbmI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GYXkl/yy7iz2aYIyJGjeWMjC/nkbEAYImQo5/6uUzUUB3zt3wsXXBqbu1u9lMLWWE+cFLF8yVH3rWwmSOWxYeQNoENGvTxP+/BmfY7R+/uCmaXAfamsF3O+ItQzffRf26Cc1zNMdmzKgMQs05+SQJlrHzmob8Dm7l+qXFdbH+Jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.137.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from andre.telenet-ops.be (andre.telenet-ops.be [IPv6:2a02:1800:120:4::f00:15])
	by weierstrass.telenet-ops.be (Postfix) with ESMTPS id 4VYYr901Pvz4x0K9
	for <linux-kernel@vger.kernel.org>; Tue, 07 May 2024 12:08:09 +0200 (CEST)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed80:398:903d:bd3d:c943])
	by andre.telenet-ops.be with bizsmtp
	id LA802C00409Bz8w01A801o; Tue, 07 May 2024 12:08:01 +0200
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1s4Hj5-00C50P-TE;
	Tue, 07 May 2024 12:08:00 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1s4Hjs-00DhCc-1x;
	Tue, 07 May 2024 12:08:00 +0200
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Mark Pearson <mpearson-lenovo@squebb.ca>,
	David Ober <dober@lenovo.com>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>
Cc: linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] watchdog: LENOVO_SE10_WDT should depend on X86 && DMI
Date: Tue,  7 May 2024 12:07:56 +0200
Message-Id: <58005595a05ef803b454b78d3ae9b8ee0675bd5d.1715076440.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Lenovo SE10 watchdog is only present on Lenovo ThinkEdge SE10
platforms, which are based on Intel Atom SoCs, and its driver relies on
DMI tables.  Hence add dependencies on X86 && DMI, to prevent asking the
user about this driver when configuring a kernel without Intel Atom or
DMI support.

While at it, fix the odd indentation (spaces instead of TABs).

Fixes: 1f6602c8ed1eccac ("watchdog: lenovo_se10_wdt: Watchdog driver for Lenovo SE10 platform")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/watchdog/Kconfig | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index 24dfecbb30157fff..f002e9627c076f1f 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -255,14 +255,15 @@ config GPIO_WATCHDOG_ARCH_INITCALL
 	  If in doubt, say N.
 
 config LENOVO_SE10_WDT
-        tristate "Lenovo SE10 Watchdog"
-        select WATCHDOG_CORE
-        help
-          If you say yes here you get support for the watchdog
-          functionality for the Lenovo SE10 platform.
-
-          This driver can also be built as a module. If so, the module
-          will be called lenovo-se10-wdt.
+	tristate "Lenovo SE10 Watchdog"
+	depends on (X86 && DMI) || COMPILE_TEST
+	select WATCHDOG_CORE
+	help
+	  If you say yes here you get support for the watchdog
+	  functionality for the Lenovo SE10 platform.
+
+	  This driver can also be built as a module. If so, the module
+	  will be called lenovo-se10-wdt.
 
 config MENF21BMC_WATCHDOG
 	tristate "MEN 14F021P00 BMC Watchdog"
-- 
2.34.1


