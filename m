Return-Path: <linux-kernel+bounces-523141-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA210A3D29B
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 08:48:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9ADF217871E
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 07:48:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84C491E3DF7;
	Thu, 20 Feb 2025 07:48:49 +0000 (UTC)
Received: from laurent.telenet-ops.be (laurent.telenet-ops.be [195.130.137.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43B923FD4
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 07:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.137.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740037729; cv=none; b=bBTQnqwDocuFu3xmvVSeyl9K9bf08KO7ISnoqelT9bojvmVFbc6WKnXXjIWUIm7K1hnAM+dVW/T3XaTw0OTvxr89xtcgiWa9Lwn9RbyaputxVY5c+c3HTopA3ivwBMM4kJItn4bHbqjfoAGj8A66O4EBUP2Y6Xzr8nz2wVVnzgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740037729; c=relaxed/simple;
	bh=DSnEd5UZ1Qf3o4+UXzpqW0P67NbAVPVclrnhI5Js0i0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UJIBgMX3f3LMUcGQQNlRa8ngO0zlzFsdWrQoxH7bbNLjG/GGAVbDGTrXqCt8NBDIdKNkcDLGSjsjZNmbQ4h0g64t9FYSa/HS5mzYdD1R3cBFszUP7ubuA4Eeh1OkKFUWDkQX7yyQwLlzKB2cimq2QBY9UzI5rEdPVXk/KM2110Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.137.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed80:b586:2686:e976:446f])
	by laurent.telenet-ops.be with cmsmtp
	id Fjoj2E0093dp1uk01jojNW; Thu, 20 Feb 2025 08:48:43 +0100
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.97)
	(envelope-from <geert@linux-m68k.org>)
	id 1tl1IF-0000000BD0n-2z4t;
	Thu, 20 Feb 2025 08:48:43 +0100
Received: from geert by rox.of.borg with local (Exim 4.97)
	(envelope-from <geert@linux-m68k.org>)
	id 1tl1IZ-0000000CbNr-1DFU;
	Thu, 20 Feb 2025 08:48:43 +0100
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Andy Shevchenko <andy@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH v2] auxdisplay: MAX6959 should select BITREVERSE
Date: Thu, 20 Feb 2025 08:48:42 +0100
Message-ID: <11603b392e2899b44fce61bbc8626a1aaa32b8f0.1740037706.git.geert@linux-m68k.org>
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

Fixes: a9bcd02fa42217c7 ("auxdisplay: Add driver for MAX695x 7-segment LED controllers")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/202502161703.3Vr4M7qg-lkp@intel.com/
Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
v2:
  - Do not sort selects.
---
 drivers/auxdisplay/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/auxdisplay/Kconfig b/drivers/auxdisplay/Kconfig
index 8934e6ad5772b4e0..3b588318e8b5700b 100644
--- a/drivers/auxdisplay/Kconfig
+++ b/drivers/auxdisplay/Kconfig
@@ -505,6 +505,7 @@ config MAX6959
 	depends on I2C
 	select REGMAP_I2C
 	select LINEDISP
+	select BITREVERSE
 	help
 	  If you say yes here you get support for the following Maxim chips
 	  (I2C 7-segment LED display controller):
-- 
2.43.0


