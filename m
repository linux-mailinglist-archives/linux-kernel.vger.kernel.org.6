Return-Path: <linux-kernel+bounces-244774-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B88A292A944
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 20:50:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 54173B20DF4
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 18:50:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8357F14A0A5;
	Mon,  8 Jul 2024 18:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b="STsTX3G/"
Received: from mx08lb.world4you.com (mx08lb.world4you.com [81.19.149.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0191E17C9E
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 18:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.19.149.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720464645; cv=none; b=rO/MLN9iM3GOj70ZKyulmggsQ3qcVekH0u78VB293K9zYKJflgK485Z7dIXSXBf6zrH9gCJJQnyfCE+jFeuOX01FF/oQnbaa++ebvTtD5j3e8XLCxpDk8mh7W1lMedn4pAEUrKXFTAZ3bc2kyGYgHVx+Q0PSFqipAizLOSZ0Dt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720464645; c=relaxed/simple;
	bh=winQKMGuvNdLl6WdgnVc6k94z9C2+8e7xKaerNY0kXs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=eRDSYm6tXOxWo4+dOwoThLJF0i3yDY3q5wD9XofD5hEY6CQmGexvLkHBTBThMpq+xERdvtxU4ar6qJNUQyc4S7m7PPznJMTm3eg8fD1r6buvEJwUaZ4jwGHHy00zlzsTQ232pv+meP50qCdlvb7zpAugEbbAZeb+kww2MGgbJf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com; spf=pass smtp.mailfrom=engleder-embedded.com; dkim=pass (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b=STsTX3G/; arc=none smtp.client-ip=81.19.149.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=engleder-embedded.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=engleder-embedded.com; s=dkim11; h=Content-Transfer-Encoding:MIME-Version:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=ShYrzn5OFHNuni1VEHn8e2Tyiq1tmox7vYwiqxSvtDc=; b=STsTX3G/ht7wlf0tEPQ4Fc16AJ
	y+KuiZ1o41UHSo2klLzjVNuPXxHVPURX3Ty831lJ4BQd0ABJs/49Q8WrCT/jzIhBoIBpAtC9UFQEq
	w+FxF6dEI8lNaPjPiKturl81bf2BXbwsMkglDEZB8zFiX5DJTj+AJnWMDMT2CW9RyEGk=;
Received: from [88.117.61.57] (helo=hornet.engleder.at)
	by mx08lb.world4you.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <gerhard@engleder-embedded.com>)
	id 1sQsfh-0004hQ-2I;
	Mon, 08 Jul 2024 20:01:06 +0200
From: Gerhard Engleder <gerhard@engleder-embedded.com>
To: linux-kernel@vger.kernel.org
Cc: arnd@arndb.de,
	gregkh@linuxfoundation.org,
	Gerhard Engleder <gerhard@engleder-embedded.com>,
	kernel test robot <lkp@intel.com>,
	Gerhard Engleder <eg@keba.com>
Subject: [PATCH] misc: keba: Fix missing AUXILIARY_BUS dependency
Date: Mon,  8 Jul 2024 20:00:49 +0200
Message-Id: <20240708180049.12713-1-gerhard@engleder-embedded.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AV-Do-Run: Yes
X-ACL-Warn: X-W4Y-Internal

From: Gerhard Engleder <eg@keba.com>

The cp500 driver creates auxiliary devices. Kernel configs without
CONFIG_AUXILIARY_BUS lead to warnings like this:

cp500.c: undefined reference to `auxiliary_device_init'
cp500.c: undefined reference to `__auxiliary_device_add'

Add missing dependency to AUXILIARY_BUS to KEBA_CP500 Kconfig.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202407081327.2DR4Ltu9-lkp@intel.com/
Fixes: a1944676767e ("misc: keba: Add basic KEBA CP500 system FPGA support")
Signed-off-by: Gerhard Engleder <eg@keba.com>
---
 drivers/misc/keba/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/misc/keba/Kconfig b/drivers/misc/keba/Kconfig
index 0ebca1d07ef4..5fbcbc2252ac 100644
--- a/drivers/misc/keba/Kconfig
+++ b/drivers/misc/keba/Kconfig
@@ -2,6 +2,7 @@
 config KEBA_CP500
 	tristate "KEBA CP500 system FPGA support"
 	depends on PCI
+	select AUXILIARY_BUS
 	help
 	  This driver supports the KEBA CP500 system FPGA, which is used in
 	  KEBA CP500 devices. It registers all sub devices present on the CP500
-- 
2.39.2


