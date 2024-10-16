Return-Path: <linux-kernel+bounces-368595-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BD969A11D6
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 20:43:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5B551F2535F
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 18:43:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80EAE2141A1;
	Wed, 16 Oct 2024 18:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b="PBMqGe+q"
Received: from mx17lb.world4you.com (mx17lb.world4you.com [81.19.149.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35BA820E03C
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 18:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.19.149.127
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729104226; cv=none; b=dtW24r9WhH3R7iazc/2imPyunKyKbzqy/H4UFX1DJr2rmEqB6KYslcid5+hJoTkfPJiGjxyoiRmzre0E3MKi/GsDogEcf8mckU8saFb7QCmTNj2iSAiUw5R6H4SUmXXZivkwwif2dJhgmOLQITASUBku3qYvMMOu1VzUPt6iNow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729104226; c=relaxed/simple;
	bh=hYjmThN6SUSYTCIGIP8eJSu77ciYCEjB73VI/oQNeYI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=S8WD54Lu6BnzUHgzz+IZU8YdVf1yQKN0hyVka0t1l4MKOsJG8MLZnV6eGeoKH4d3HiGbwMboc8oIuLFfjaVhXPEa+Fh8C2gp+7SEkcUSzinPlgQefywTqgxQ0XFpdHy6NB/LxFzIi9x9Gq0wwLS1NQqON+/PymY3GLpW7y52EmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com; spf=pass smtp.mailfrom=engleder-embedded.com; dkim=pass (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b=PBMqGe+q; arc=none smtp.client-ip=81.19.149.127
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=engleder-embedded.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=engleder-embedded.com; s=dkim11; h=Content-Transfer-Encoding:MIME-Version:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=4YofAPeCvIzWhsaSsk/9R9mPUDB1Ufcr02ei0atBfwI=; b=PBMqGe+qv0m8gWAtzrJ8Mfv034
	a1pMKb4xmhqPLKINTZkDOdYBsXm8qZk+aqaRbgG0IYH8p9eZ9KhoL/KRAjpo4FE3H7bRx49Ogzhof
	17u6DD2yqf3vZ3SPbt8wRbUF+IzUoc7SUepbMj6A+k7HEeXfXJ2lfIRlXz+eq/BOSXK0=;
Received: from [88.117.56.173] (helo=hornet.engleder.at)
	by mx17lb.world4you.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <gerhard@engleder-embedded.com>)
	id 1t18kd-0000000029O-2ile;
	Wed, 16 Oct 2024 20:28:03 +0200
From: Gerhard Engleder <gerhard@engleder-embedded.com>
To: linux-kernel@vger.kernel.org
Cc: arnd@arndb.de,
	gregkh@linuxfoundation.org,
	Gerhard Engleder <gerhard@engleder-embedded.com>,
	kernel test robot <lkp@intel.com>,
	Gerhard Engleder <eg@keba.com>
Subject: [PATCH] misc: keba: Fix missing I2C dependency
Date: Wed, 16 Oct 2024 20:27:51 +0200
Message-Id: <20241016182751.10457-1-gerhard@engleder-embedded.com>
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

Kernel test robot reported a build error on csky:

drivers/misc/keba/cp500.c:287:(.text+0x1c0): undefined reference to `i2c_verify_client'

Add I2C dependency to fix build error.

Fixes: 794848300103 ("misc: keba: Add SPI controller device")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202410130817.NXBCxx4q-lkp@intel.com/
Signed-off-by: Gerhard Engleder <eg@keba.com>
---
 drivers/misc/keba/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/misc/keba/Kconfig b/drivers/misc/keba/Kconfig
index dc27b902f34e..08c8970d8d58 100644
--- a/drivers/misc/keba/Kconfig
+++ b/drivers/misc/keba/Kconfig
@@ -2,6 +2,7 @@
 config KEBA_CP500
 	tristate "KEBA CP500 system FPGA support"
 	depends on PCI
+	depends on I2C
 	select AUXILIARY_BUS
 	help
 	  This driver supports the KEBA CP500 system FPGA, which is used in
-- 
2.39.2


