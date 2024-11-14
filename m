Return-Path: <linux-kernel+bounces-409326-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 208AE9C8B77
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 14:10:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A65BFB2E762
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 13:00:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D4241F9EC7;
	Thu, 14 Nov 2024 13:00:41 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A95E327466
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 13:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731589241; cv=none; b=NXiiO3YHqMgyGaVJ+LgSsLcne08kCAFZSTkrZ4peV6jt+YX0KGMinWRLjYPOqwtd8C8HXAg7Q7Tik6VeFAjqRCAAsnwB44Qn6OqPimRFBnADsXSpSMIrJKnu73t8pHZf1De2zUrl/fRh1IWaeObipf/2BUGOzV5uarf0P8USz8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731589241; c=relaxed/simple;
	bh=nJnzXMn8qGYX3NE1FmjhIBHS5OBYAlw/svpNfPcocSo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=eqBsTcjD8qss7TzSTD+uwwZYY1qUjTtaoUzTy3j2Jh+bWvS1MmLI0p6OrLmOZjaqaFPaFBV7GiXqiE863q9/MOL8DRcFlnGuX46L4IFre7He/hMAFH60sREa2PXMSGUC3tvZA7pmqGYHA1yFALFgDN3e4J8qwqEklBMp63NWtV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from dude02.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::28])
	by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <m.felsch@pengutronix.de>)
	id 1tBZSb-0005Tf-6B; Thu, 14 Nov 2024 14:00:33 +0100
From: Marco Felsch <m.felsch@pengutronix.de>
To: linux@armlinux.org.uk,
	m.felsch@pengutronix.de
Cc: kernel@pengutronix.de,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] arm: gen-mach-types: don't include absolute filename
Date: Thu, 14 Nov 2024 14:00:18 +0100
Message-Id: <20241114130021.2802803-1-m.felsch@pengutronix.de>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:1101:1d::28
X-SA-Exim-Mail-From: m.felsch@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

Don't include the abosulte filename into the generated mach-types.h
header and instead make use of arm64 note. The motivation for this
change is Yocto emitting a build warning:

| File /usr/src/debug/linux-raspberrypi/6.11.7/arch/arm/include/generated/asm/mach-types.h in package linux-raspberrypi-src contains reference to TMPDIR [buildpaths]

So this change brings us one step closer to make the build result
reproducible independent of the build path.

Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
---
 arch/arm/tools/gen-mach-types | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm/tools/gen-mach-types b/arch/arm/tools/gen-mach-types
index cbe1c33bb871..fdc4805b9d98 100644
--- a/arch/arm/tools/gen-mach-types
+++ b/arch/arm/tools/gen-mach-types
@@ -24,8 +24,7 @@ NF == 3 {
 
 END	{
 	  printf("/*\n");
-	  printf(" * This was automagically generated from %s!\n", FILENAME);
-	  printf(" * Do NOT edit\n");
+	  printf(" * Generated file - do not edit\n");
 	  printf(" */\n\n");
 	  printf("#ifndef __ASM_ARM_MACH_TYPE_H\n");
 	  printf("#define __ASM_ARM_MACH_TYPE_H\n\n");
-- 
2.39.5


