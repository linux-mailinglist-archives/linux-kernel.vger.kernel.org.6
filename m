Return-Path: <linux-kernel+bounces-295368-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 60CFD959A23
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 13:36:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9375F1C20A2D
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 11:35:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1D7C1B6549;
	Wed, 21 Aug 2024 10:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thorsis.com header.i=@thorsis.com header.b="rGG9LCDS"
Received: from mail.thorsis.com (mail.thorsis.com [217.92.40.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4008B134AC
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 10:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.92.40.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724237997; cv=none; b=RtEjRZwa0xYVmUdrOLy2YcBy8qYzt0Hfy6WoCArTernMVhwGngTnL+xk5bFzkgPgB45AGm/uZzZHSkJZVuJZlTRFR6V5gDV+pV1bGXfu3pGIsBl5h4i0JvsY8PkE0AuHLR/vFjdTnYMS3i7n0ElaFa58SVWY5vC2uKkSzhPep0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724237997; c=relaxed/simple;
	bh=aaL8W66lNYNlZ6TUB83q0Zo2UdqSMXWQj/xUy6d09UQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gyMjvXkKFl7pGEcDZUpgROPtMYkgg4j2DlMuPX8qXotttFUyjP+MCaTfAKrLlk0Wc3f+WOMVGJoPJco5ZwWPrO5M3N56KhJi+uO6eqXGADXtcQOXhgJtlosjKdyfV2s5DCbY6YM3NWHm3tDZ3O0M9Z7ZT4gbU6F4ISQ3Bcx8ZUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com; spf=pass smtp.mailfrom=thorsis.com; dkim=pass (2048-bit key) header.d=thorsis.com header.i=@thorsis.com header.b=rGG9LCDS; arc=none smtp.client-ip=217.92.40.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thorsis.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id DAD6F1483DF5;
	Wed, 21 Aug 2024 12:59:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=thorsis.com; s=dkim;
	t=1724237993; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=i/ckHEQYfw6TnDB+9CVHZLVZThux547JhXou9MWo738=;
	b=rGG9LCDSm0fkhl56SGjODNpBKWm1V8D5PrYK2UCtQV43tq4Nrps/v/0kiT85fvlCWA/pVe
	vSZgNKWIF5+vU4Qi1W57x/BRaPRQt6M022rPdRX6PNFrMD8VbRiYGLHU9aeJc8Kl1DwRz4
	mR9oQ+H3VpO5HxB2KVIgh4Ak2+yS+M7+xe3hh6d1W8GR22q7mNq48KBv8lFG+iKss4sn8O
	y3QbFqDKIgnIgUELUP1kBzwnd3Oy23gXGWXZKp3XDZArYqa8HB2NWqSfAu3y5SWTFoQp2K
	AMyITMJp+eSh+6cnAYMpbIHpsvtNGXoapzEFN4nGOCOczaZq+NaYyW0D3FDY1w==
From: Alexander Dahl <ada@thorsis.com>
To: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Cc: Christian Melki <christian.melki@t2data.com>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	linux-arm-kernel@lists.infradead.org (moderated list:MICROCHIP OTPC DRIVER),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v1 04/12] nvmem: microchip-otpc: Add SAM9X60 support
Date: Wed, 21 Aug 2024 12:59:35 +0200
Message-Id: <20240821105943.230281-5-ada@thorsis.com>
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

Register layout is almost identical to sama7g5 OTPC.

Signed-off-by: Alexander Dahl <ada@thorsis.com>
---
 drivers/nvmem/microchip-otpc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvmem/microchip-otpc.c b/drivers/nvmem/microchip-otpc.c
index bd3383eabdf6..b8ed7412dbca 100644
--- a/drivers/nvmem/microchip-otpc.c
+++ b/drivers/nvmem/microchip-otpc.c
@@ -271,6 +271,7 @@ static int mchp_otpc_probe(struct platform_device *pdev)
 
 static const struct of_device_id __maybe_unused mchp_otpc_ids[] = {
 	{ .compatible = "microchip,sama7g5-otpc", },
+	{ .compatible = "microchip,sam9x60-otpc", },
 	{ },
 };
 MODULE_DEVICE_TABLE(of, mchp_otpc_ids);
-- 
2.39.2


