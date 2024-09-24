Return-Path: <linux-kernel+bounces-336897-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A774984242
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 11:34:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4657D1F2268F
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 09:34:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6479115539D;
	Tue, 24 Sep 2024 09:34:25 +0000 (UTC)
Received: from laurent.telenet-ops.be (laurent.telenet-ops.be [195.130.137.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C4EF1422C7
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 09:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.137.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727170465; cv=none; b=UAe0/pv9weVVP48zAW0v8DQSk8+AxwUkR+Ssq11ZVC72KWiVSO0Jzd0E0SCNja8PaKXkdphuIIrvjofbibv4FFko2BYCEB20xBlxcOE18cv8d60aQ1Oo91qd03C3pP9CzYHKZQScNKZcRTRJBPoA9Ty3Vla8cZHr0nkE17FDAMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727170465; c=relaxed/simple;
	bh=CARFp6th4DbUiUuXwF6L9Sn0d4QvR0it2mvCHoANL24=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=NaHMBtozOccptdCAp6kkPTjbs7SX26e3+eX/vyO4aRIndkc7TTvhFUaK2cNZ6IerghtC4seAGVZmfeU2NsfOaG/0vSMxt5R6iFWYQ2swk4p5AgYXwbV6M8dgRSejs1392OmtxEes9/YgG4bsbVnQAdvnFAjt/vDnlWNBCBCSstU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.137.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from ramsan.of.borg ([84.195.187.55])
	by laurent.telenet-ops.be with cmsmtp
	id G9aL2D0071C8whw019aLnn; Tue, 24 Sep 2024 11:34:20 +0200
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1st1w0-000Shr-1q;
	Tue, 24 Sep 2024 11:34:20 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1st1w3-0015Xd-Ui;
	Tue, 24 Sep 2024 11:34:19 +0200
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Andi Shyti <andi.shyti@kernel.org>,
	Gerhard Engleder <eg@keba.com>
Cc: linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] i2c: I2C_KEBA should depend on KEBA_CP500
Date: Tue, 24 Sep 2024 11:34:18 +0200
Message-Id: <39a6ce50b152c8e435c78825ab56aa714b54fce8.1727170404.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The KEBA I2C controller is only present on KEBA PLC devices.  Hence add
a dependency on KEBA_CP500, to prevent asking the user about this driver
when configuring a kernel without KEBA CP500 system FPGA support.

Fixes: c7e08c816cd2fdf8 ("i2c: keba: Add KEBA I2C controller support")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/i2c/busses/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
index 0ea437c76167ad2d..229b8166ccc03803 100644
--- a/drivers/i2c/busses/Kconfig
+++ b/drivers/i2c/busses/Kconfig
@@ -782,6 +782,7 @@ config I2C_JZ4780
 config I2C_KEBA
 	tristate "KEBA I2C controller support"
 	depends on HAS_IOMEM
+	depends on KEBA_CP500 || COMPILE_TEST
 	select AUXILIARY_BUS
 	help
 	  This driver supports the I2C controller found in KEBA system FPGA
-- 
2.34.1


