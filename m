Return-Path: <linux-kernel+bounces-193758-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 49C588D322B
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 10:50:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E9A04B2D886
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 08:37:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 153E7171E64;
	Wed, 29 May 2024 08:33:26 +0000 (UTC)
Received: from baptiste.telenet-ops.be (baptiste.telenet-ops.be [195.130.132.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D76F16191E
	for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 08:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.132.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716971605; cv=none; b=UeHHdFy46MHZAPYS73q83f0iv2uCjmRDDKFvuuQZiwZJ8uOnHbEyAl0l6hjBlxXW6M4jY9Ot5eiGuBGFgUmb7fvBFCyZ66T28B2BnKUpjnAmgJSd5lgKRqJyw+3DFn3ZLlMIGSyPsLpqACAxczRVPRQ4CMc17BmOcKfpxzKdoF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716971605; c=relaxed/simple;
	bh=eMzrml96pA8Rq5XFAWlTKhSLVds9dUPcBcITLrRcHS4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YnlIATIMyEzt9GHUfFA/MBNv7rV7hkNGnIHQjTbDPTDhEjbkyBukJdvy3Hl8kIxbYkRTX394eg1gK0rmJ4xH7pi/5C/A/IfeVAF23tjkrU7iMjY0VF1uSTYj6TJzngZHpoqX8hrcZvtnJbicLHyJk9rieBpaFnhGq9wRjfJWPoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.132.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed80:1b01:1838:131c:4de4])
	by baptiste.telenet-ops.be with bizsmtp
	id UwZE2C00S3VPV9V01wZF93; Wed, 29 May 2024 10:33:15 +0200
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1sCEjI-00G8ig-Bx;
	Wed, 29 May 2024 10:33:14 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1sCDlm-008nYK-Mv;
	Wed, 29 May 2024 09:30:46 +0200
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Cristian Marussi <cristian.marussi@arm.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Jassi Brar <jassisinghbrar@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] mailbox: ARM_MHU_V3 should depend on ARM64
Date: Wed, 29 May 2024 09:30:45 +0200
Message-Id: <e00498fccf6dcbcf63bd24a137bfc7abd1b98345.1716967720.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ARM MHUv3 controller is only present on ARM64 SoCs.  Hence add a
dependency on ARM64, to prevent asking the user about this driver when
configuring a kernel for a different architecture than ARM64.

Fixes: ca1a8680b134b5e6 ("mailbox: arm_mhuv3: Add driver")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
The MHUv3 documentation is unclear about whether this can be present
only on ARM64, or also on ARM.
Googling 'site:arm.com MHUv3 "aarch32"' shows no results.
Googling 'site:arm.com MHUv3 "aarch64"' does show results.
---
 drivers/mailbox/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mailbox/Kconfig b/drivers/mailbox/Kconfig
index 3b8842c4a3401579..8d4d1cbb1d4ca625 100644
--- a/drivers/mailbox/Kconfig
+++ b/drivers/mailbox/Kconfig
@@ -25,6 +25,7 @@ config ARM_MHU_V2
 
 config ARM_MHU_V3
 	tristate "ARM MHUv3 Mailbox"
+	depends on ARM64 || COMPILE_TEST
 	depends on HAS_IOMEM || COMPILE_TEST
 	depends on OF
 	help
-- 
2.34.1


