Return-Path: <linux-kernel+bounces-542541-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 41C07A4CAEB
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 19:23:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3589018950A0
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 18:23:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C07BB22CBFC;
	Mon,  3 Mar 2025 18:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="OqdJEGuF"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC05622333D
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 18:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741026217; cv=none; b=qR3dnMk7Z2xDvH9DGcpjEgpJgyaJ7ZRncGxePUPgz8dFrgQtgbXJ/9ZtvSAg5LxS0PNA7EZzMiBgjuOLeT/d41ewZsyNa6cnAbt674WedKOvoO5u8Gwj3uF/c/fAcw8o9S9PziWgYZoAZ/ZLo0pWUXaOIPf0Xb367tqCmqQUSJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741026217; c=relaxed/simple;
	bh=MGaV//WwdnnKj503r22dI/wueaGMzFgGAg2wrFodR9M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YsK/WL/go5Tcw2+Sg+0mdw223zj594pQ2D996ACJEwNLczyYSl1mXO7/C+DQky5IlOim5dp4SuNe7QJ8dXahczmvjr+2px4HeKGSJAEap8ewFkfi5fnSrhr9DppKcFQ2ZAcL3CGElsWGw80bz+HNRLcmjFu2gcr21PLd3IL/EXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=OqdJEGuF; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:
	Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=QvI3uoBBtrY63GFuz2BimKRrjmSrRphcFh9ZV4VWtho=; b=OqdJEGuFkISnTQKehCqXxKXvmh
	uZ04gWRn0+rtOAGZCya4mZwIiXOlB5i4E6iwYg7+cQBO5tabqR2KE6NvctV11i8WGc9VCjLMeODIX
	76ZvKuE0kbs4JYvmgWyvaw0JDZ+EVZ9Hri82Z1jC8XD0T7OWmJrbyMgDLrK00qd0Cw5a3puvNWm4f
	584M3qNk7hihHXiLrS3u9vuKdWnySxKugk2dqMO9PScKBdX+0KJy6qJ2vf1YQAlwB3XgIMourmhfq
	ESj3b/Tlcl2a/e7NhMIlA0f2RDBz2/bh9R9zRAReyAXpAj3mctqU5v74WsC+wKAygO4jgiqe1S3NM
	L+IlP4AQ==;
Received: from i53875a38.versanet.de ([83.135.90.56] helo=localhost.localdomain)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1tpARX-0004dM-8j; Mon, 03 Mar 2025 19:23:07 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: heiko@sntech.de
Cc: hjc@rock-chips.com,
	andy.yan@rock-chips.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	dri-devel@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	kernel test robot <lkp@intel.com>
Subject: [PATCH] drm/rockchip: vop2: add missing bitfield.h include
Date: Mon,  3 Mar 2025 19:22:56 +0100
Message-ID: <20250303182256.1727178-1-heiko@sntech.de>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 328e6885996c ("drm/rockchip: vop2: Add platform specific callback")
moved per soc configuration code to the other per-soc data into
rockchip_vop2_reg.c, but forgot to also include bitfield.h for the used
FIELD_PREP macro. Add this missing include.

Fixes: 328e6885996c ("drm/rockchip: vop2: Add platform specific callback")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202503040135.fgoyWdLB-lkp@intel.com/
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 drivers/gpu/drm/rockchip/rockchip_vop2_reg.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/rockchip/rockchip_vop2_reg.c b/drivers/gpu/drm/rockchip/rockchip_vop2_reg.c
index 0afef24db144..f86a30df94aa 100644
--- a/drivers/gpu/drm/rockchip/rockchip_vop2_reg.c
+++ b/drivers/gpu/drm/rockchip/rockchip_vop2_reg.c
@@ -4,6 +4,7 @@
  * Author: Andy Yan <andy.yan@rock-chips.com>
  */
 
+#include <linux/bitfield.h>
 #include <linux/kernel.h>
 #include <linux/component.h>
 #include <linux/mod_devicetable.h>
-- 
2.47.2


