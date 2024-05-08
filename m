Return-Path: <linux-kernel+bounces-173844-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E2A58C064F
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 23:33:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE2D128162E
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 21:33:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83BA3131E4B;
	Wed,  8 May 2024 21:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="utts5TQ5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEB77823B8;
	Wed,  8 May 2024 21:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715204018; cv=none; b=Cb/qQaGItGZ7TEUJgIm+EFBgiVt3oqR38e74aiuZCDcrNMdVf1fz4VIeFIQS6NSe4qU5Z08mPjKEkA6yDELmhtHKYY1EVQ4nuXQ9vuemaYb5CtF0B7R94VTsQKDN4UUXfRzsna06881XUSDNdKnu+t4pnmfjDr9dE4zZMvhNZ3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715204018; c=relaxed/simple;
	bh=dBWydrhX02YbGnsnhGjSVobHD8eSb5gTySir8O5N8vo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BNh9eqnRANPH5n4eNEgBztWN+EzXkn1SUl1+nxP/XgSWHllINvALkFXFua8YXAifGhcU+bsX8fo77+F2PP4XNu+PMtSjw0z4aBObJmJ+aQ7OJhiq7Hvhw6cVvZgod5puZ1cayAxhjkbYAAKpFEMkHRKA8FqPYaP9xaYCskxHYYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=utts5TQ5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE55DC113CC;
	Wed,  8 May 2024 21:33:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715204018;
	bh=dBWydrhX02YbGnsnhGjSVobHD8eSb5gTySir8O5N8vo=;
	h=From:To:Cc:Subject:Date:From;
	b=utts5TQ5RS+8E+11XLTySWAdvK4SSvw6Fcf8WimRYrwV3dUWS0bywUbIU0gPtDq/9
	 BGmVjG/9bn/vvQ4sxl4RaTOfMpmwm+EnJpV8fHFoE2RB7u3tUmIAre9rq/ukZqUNOC
	 jT0X42kMPt2hn/Wb8QkWWXaBXA/4vsB5woKs/AUMiL/cRlJh1wtacHd5YCPm4El8r3
	 +Yk23RFbCpUvPnyP+1MAJBex8in3MI/yP1kqttFY6Z5wqB8lr/IQFRKSaCCean+x0C
	 g9GHHlwTgse3fE0/c7QZjMrfUhQQ37TxpFGFROLCaSyyIqqs9BDiRSSnciHq7eENBK
	 AkqNIXixhi2SA==
From: Conor Dooley <conor@kernel.org>
To: linux-clk@vger.kernel.org
Cc: conor@kernel.org,
	Conor Dooley <conor.dooley@microchip.com>,
	kernel test robot <lkp@intel.com>,
	Daire McNamara <daire.mcnamara@microchip.com>,
	Stephen Boyd <sboyd@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1] clk, reset: microchip: mpfs: fix incorrect preprocessor conditions
Date: Wed,  8 May 2024 22:33:24 +0100
Message-ID: <20240508-unabashed-cheese-8f645b4f69ba@spud>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2271; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=9+wMvAaSUGcoI1wTiaH0YmLJKrjarvzY4RrG23q3Gts=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDGnW75ewzlizuXVy2rGlP873xPRLm2z2t1DkfejikMyk2 Nfns/pIRykLgxgHg6yYIkvi7b4WqfV/XHY497yFmcPKBDKEgYtTACaiG8HwP1nthUDM8gdPq2tC ni892fC1XfnH5i07Fa6+k7O7rClx+QYjw+yLR7oM3YuvXy7NcbO4V3awQ6hP9Mya1ffNZZao3ud n5AEA
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit

From: Conor Dooley <conor.dooley@microchip.com>

While moving all the reset code in the PolarFire SoC clock driver to the
reset subsystem, I removed an `#if IS_ENABLED(RESET_CONTROLLER)` from
the driver and moved it to the header, however this was not the correct
thing to do. In the driver such a condition over-eagerly provided a
complete implementation for mpfs_reset_{read,write}() when the reset
subsystem was enabled without the PolarFire SoC reset driver, but in the
header it meant that when the subsystem was enabled and the driver was
not, no implementation for mpfs_reset_controller_register() was
provided. Fix the condition so that the stub implementation of
mpfs_reset_controller_register() is used when the reset driver is
disabled.

Fixes: 098c290a490d ("clock, reset: microchip: move all mpfs reset code to the reset subsystem")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202405082259.44DzHvaN-lkp@intel.com/
Closes: https://lore.kernel.org/oe-kbuild-all/202405082200.tBrEs5CZ-lkp@intel.com/
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
CC: Conor Dooley <conor.dooley@microchip.com>
CC: Daire McNamara <daire.mcnamara@microchip.com>
CC: Stephen Boyd <sboyd@kernel.org>
CC: linux-clk@vger.kernel.org
CC: linux-kernel@vger.kernel.org
---
 include/soc/microchip/mpfs.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/soc/microchip/mpfs.h b/include/soc/microchip/mpfs.h
index d7e612b5e22e..0bd67e10b704 100644
--- a/include/soc/microchip/mpfs.h
+++ b/include/soc/microchip/mpfs.h
@@ -43,11 +43,11 @@ struct mtd_info *mpfs_sys_controller_get_flash(struct mpfs_sys_controller *mpfs_
 #endif /* if IS_ENABLED(CONFIG_POLARFIRE_SOC_SYS_CTRL) */
 
 #if IS_ENABLED(CONFIG_MCHP_CLK_MPFS)
-#if IS_ENABLED(CONFIG_RESET_CONTROLLER)
+#if IS_ENABLED(CONFIG_RESET_POLARFIRE_SOC)
 int mpfs_reset_controller_register(struct device *clk_dev, void __iomem *base);
 #else
 static inline int mpfs_reset_controller_register(struct device *clk_dev, void __iomem *base) { return 0; }
-#endif /* if IS_ENABLED(CONFIG_RESET_CONTROLLER) */
+#endif /* if IS_ENABLED(CONFIG_RESET_POLARFIRE_SOC) */
 #endif /* if IS_ENABLED(CONFIG_MCHP_CLK_MPFS) */
 
 #endif /* __SOC_MPFS_H__ */
-- 
2.43.0


