Return-Path: <linux-kernel+bounces-533059-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE3E6A45547
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 07:08:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 693493AC011
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 06:07:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D677267B8C;
	Wed, 26 Feb 2025 06:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="ZVeud/vh"
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30E5D2676F1
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 06:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740550078; cv=none; b=d/rCixtEaL4wlmDYWEPR46VMACGT6YLtlpEnSD9qRkhRlz9S2IUrIVAzFx9Tg8n5JkhhO5wiyTDPtCzSdHpAoaaQmnymCTBpPbPUXm70w6deTYsqB+CWDJDPVvl45OCHUf7nEPWrGGhfXCTLx+e5sv8LdgGshE2mGODROTokWOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740550078; c=relaxed/simple;
	bh=fWzUrYTgV/wkqfEfRgamQ/cX79EECnU/IgMQ8Q0sjW4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=S/33P2VAO8MfCeFmc/KQgzVsxgOrXDQOg3cgIrUBVBIC8CgwonGgaR9FG4wGEMvfZBp9XMVGbeBDfZxcARYuThd7Mtk8N8ChUjaPbZ6ft/sA9H9fOgN5WBDD3ZLwE/fdbx4XMCtb3u9FfC/ipsK7XPQkvMJ1W7OWSfV+N4hv2pM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=ZVeud/vh; arc=none smtp.client-ip=115.124.30.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1740550067; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=TRolnCN3rTtJQxrW336J3gSU5hfuVtg1DupPkCZXpkA=;
	b=ZVeud/vhqQrR55sdsbE5ZPaLhLSYK050Zr4ixQR+Dd4BHKjvTiJXo7pD+4sRtzbG+bt9VMCY3Ty64G5MHDNnW7QlShTh7D1lGmCjJc977hw7iwXTWEjHU3FRV8whgQryZh4clHIuaFZKMG2+FeanHLimAxSkFJIqhoEnPTIlxPc=
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0WQH5E58_1740550064 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 26 Feb 2025 14:07:46 +0800
From: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To: dpenkler@gmail.com
Cc: gregkh@linuxfoundation.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
	Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next 2/2] staging: gpib: Remove unnecessary print function dev_err()
Date: Wed, 26 Feb 2025 14:07:35 +0800
Message-Id: <20250226060735.7484-2-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20250226060735.7484-1-jiapeng.chong@linux.alibaba.com>
References: <20250226060735.7484-1-jiapeng.chong@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The print function dev_err() is redundant because platform_get_irq()
already prints an error.

./drivers/staging/gpib/fmh_gpib/fmh_gpib.c:1426:2-9: line 1426 is redundant because platform_get_irq() already prints an error.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=19059
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 drivers/staging/gpib/fmh_gpib/fmh_gpib.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/gpib/fmh_gpib/fmh_gpib.c b/drivers/staging/gpib/fmh_gpib/fmh_gpib.c
index d62c83368518..613bdcac12d1 100644
--- a/drivers/staging/gpib/fmh_gpib/fmh_gpib.c
+++ b/drivers/staging/gpib/fmh_gpib/fmh_gpib.c
@@ -1422,10 +1422,9 @@ static int fmh_gpib_attach_impl(gpib_board_t *board, const gpib_board_config_t *
 		(unsigned long)resource_size(e_priv->dma_port_res));
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq < 0) {
-		dev_err(board->dev, "request for IRQ failed\n");
+	if (irq < 0)
 		return -EBUSY;
-	}
+
 	retval = request_irq(irq, fmh_gpib_interrupt, IRQF_SHARED, pdev->name, board);
 	if (retval) {
 		dev_err(board->dev,
-- 
2.32.0.3.g01195cf9f


