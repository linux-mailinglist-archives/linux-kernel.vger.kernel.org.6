Return-Path: <linux-kernel+bounces-522080-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E061A3C59E
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 18:06:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D1221176811
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 17:06:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE096214216;
	Wed, 19 Feb 2025 17:06:08 +0000 (UTC)
Received: from albert.telenet-ops.be (albert.telenet-ops.be [195.130.137.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B1CE1FECAE
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 17:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.137.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739984768; cv=none; b=gNDR1Ch2z24AolaWe8X2onu5szjhLl1E+dZua2Qn7TR5YkjUT+/rLJSFu7HtI0ENLc9B3HKwE2og+f+TasR7Y7QyTNnv1OgpNCY0fJkz7sY0aAq0+VQeFfQQHp+huywCRSVtkUNPtLnE0OO7GFC4cwewto+Hfp1E8xH+kkhqUF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739984768; c=relaxed/simple;
	bh=36ccLlbWJO+r+/t+NW4Jb3CyLRhwWyV7v2PcqDwySiY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=neBywjEUZOzvo4z9sB2ohtkwMKHG0zdBi7cMN7+3ZQ8WVmCn7JVNzg8L15k9eheWuDP0d+SmAGDP28PPb8MYYKfw5M5ZYD+c4gKhcd9Heagkg6foLe2eoB512SztthIpGPIcoyf1xgipw5BUsvKTZFgaCA8EtfwmYD0ot+U5Oqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.137.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed80:47f6:a1ad:ad8e:b945])
	by albert.telenet-ops.be with cmsmtp
	id FV5x2E00A57WCNj06V5xDW; Wed, 19 Feb 2025 18:05:58 +0100
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.97)
	(envelope-from <geert@linux-m68k.org>)
	id 1tknVy-0000000B5eD-3igb;
	Wed, 19 Feb 2025 18:05:57 +0100
Received: from geert by rox.of.borg with local (Exim 4.97)
	(envelope-from <geert@linux-m68k.org>)
	id 1tknWH-0000000CXMh-24vk;
	Wed, 19 Feb 2025 18:05:57 +0100
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Andy Shevchenko <andy@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH] auxdisplay: MAX6959 should select BITREVERSE
Date: Wed, 19 Feb 2025 18:05:56 +0100
Message-ID: <cfc1b534f7f8953351614e6120103a866f732f3f.1739984661.git.geert@linux-m68k.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If CONFIG_BITREVERSE is not enabled:

    max6959.c:(.text+0x92): undefined reference to `byte_rev_table'

While at it, sort the existing selects alphabetically

Fixes: a9bcd02fa42217c7 ("auxdisplay: Add driver for MAX695x 7-segment LED controllers")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/202502161703.3Vr4M7qg-lkp@intel.com/
Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 drivers/auxdisplay/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/auxdisplay/Kconfig b/drivers/auxdisplay/Kconfig
index 8934e6ad5772b4e0..966a0e1c17e06f2b 100644
--- a/drivers/auxdisplay/Kconfig
+++ b/drivers/auxdisplay/Kconfig
@@ -503,8 +503,9 @@ config HT16K33
 config MAX6959
 	tristate "Maxim MAX6958/6959 7-segment LED controller"
 	depends on I2C
-	select REGMAP_I2C
+	select BITREVERSE
 	select LINEDISP
+	select REGMAP_I2C
 	help
 	  If you say yes here you get support for the following Maxim chips
 	  (I2C 7-segment LED display controller):
-- 
2.43.0


