Return-Path: <linux-kernel+bounces-295364-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03D6A959A1D
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 13:35:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2012280D5A
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 11:35:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE7181B532A;
	Wed, 21 Aug 2024 10:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thorsis.com header.i=@thorsis.com header.b="qRaGUGE1"
Received: from mail.thorsis.com (mail.thorsis.com [217.92.40.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF0661B5310
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 10:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.92.40.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724237996; cv=none; b=jobNMmYCtXn9oJcjhH1KC0nWfy758+oCjtkHaxfOjB33mpCcGmr1PSVM9NhstfJ2mWlJT2xv3bqX9Ov9rX0b6wCuClClDpPoGKJH452O6kO6G6AhLLXpFdjJWPF2H8DdYtFLG35cJqccjsaa7V6JDc6Kg0D+AfBRFSWDABouo5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724237996; c=relaxed/simple;
	bh=Tb7mcQWNr9yNvFm4o+lSxpWxsHkML9cqEr8oE1gW1gs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kazC6p9T4UXgcO6xkjUYMD0+vTsT8bMNu6mgQVK+cs/XK3Rbd3B7As0BOCHftp80gi23l1yRZrwevTvSnq+AdHVazIk5TBPIZg280HNPY6eA3M4ZoXEbnN2rEcT7ftbhtYn3XikS9lcMzrNLCymQo9dbyvoH1avE1Od700vc4pI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com; spf=pass smtp.mailfrom=thorsis.com; dkim=pass (2048-bit key) header.d=thorsis.com header.i=@thorsis.com header.b=qRaGUGE1; arc=none smtp.client-ip=217.92.40.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thorsis.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 106881483DEE;
	Wed, 21 Aug 2024 12:59:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=thorsis.com; s=dkim;
	t=1724237991; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=crou9icPFQt6qy3frq3zWNsDVrBMyW0y4VXPpAGZ1pA=;
	b=qRaGUGE1xf+8Ul3ZG4giMuFfKzm0Ur44w+zplS6CK3K0tR1Rg40kPZbPFkaXPNMG597iw3
	FNo4ZWHVG+NgvzZiaYlYvstoscl+7CRgPtH+blxo6W87OCaNnVe4vZGvH2igzN2ZrzMB3E
	aobBwsu65a4qFAL9mlIhVXzvCCKGkMcn76HoEskvuR5yNCfVR77mu5fJmrMF6iV1QrwXrS
	aj+APQQOvlC/p2Jv7Rm5ZKmh+EJdEF0+tYOnwdBqbdRrl057mnRu7fhmPKXEES6ibcANLx
	a0nsNH1N4cMXy8vkOiLrY4xFdD2R2IXcnsR+dhkESfZVSZzPy71p0YzMBEaGtw==
From: Alexander Dahl <ada@thorsis.com>
To: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Cc: Christian Melki <christian.melki@t2data.com>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	linux-arm-kernel@lists.infradead.org (moderated list:MICROCHIP OTPC DRIVER),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v1 01/12] nvmem: microchip-otpc: Avoid writing a write-only register
Date: Wed, 21 Aug 2024 12:59:32 +0200
Message-Id: <20240821105943.230281-2-ada@thorsis.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240821105943.230281-1-ada@thorsis.com>
References: <20240821105943.230281-1-ada@thorsis.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

The OTPC Control Register (OTPC_CR) has just write-only members.
Reading from that register leads to a warning in OTPC Write Protection
Status Register (OTPC_WPSR) in field Software Error Type (SWETYP) of
type READ_WO (A write-only register has been read (warning).)

Just create the register write content from scratch is sufficient here.

Signed-off-by: Alexander Dahl <ada@thorsis.com>
---
 drivers/nvmem/microchip-otpc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvmem/microchip-otpc.c b/drivers/nvmem/microchip-otpc.c
index 7cf81738a3e0..03e60b99f2c9 100644
--- a/drivers/nvmem/microchip-otpc.c
+++ b/drivers/nvmem/microchip-otpc.c
@@ -82,7 +82,7 @@ static int mchp_otpc_prepare_read(struct mchp_otpc *otpc,
 	writel_relaxed(tmp, otpc->base + MCHP_OTPC_MR);
 
 	/* Set read. */
-	tmp = readl_relaxed(otpc->base + MCHP_OTPC_CR);
+	tmp = 0;
 	tmp |= MCHP_OTPC_CR_READ;
 	writel_relaxed(tmp, otpc->base + MCHP_OTPC_CR);
 
-- 
2.39.2


