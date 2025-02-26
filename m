Return-Path: <linux-kernel+bounces-534731-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F4027A46A80
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 20:00:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A65751889647
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 19:00:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7E4F238D38;
	Wed, 26 Feb 2025 19:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EU9j0MnR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39F19238D50;
	Wed, 26 Feb 2025 19:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740596417; cv=none; b=SqRIG7xFN0v5GVrjLJJ5EKVTtXmmki3l6vknxAAgxfS2EhXeL9a+UqGKCpCUIqqkvUMmbA9DmNxQlvCQ5X/dVt/KDMbnjmGiKEbNOnWFr+QkwEtQnpqXbjaUaHEyIxuRxRDR2NNc1JlsffAmvPDhow7+QJno5C62B5C2Aa2lZTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740596417; c=relaxed/simple;
	bh=efHDZc+VZMO22pyTz8bbQ9t4hJW8gBFp6rwM21UYaFs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Tm7fR499AuBo+jhAai/ldKaXtKhJxPjzrpjqgLMeAF+QUyfviUwSdL7cI0UEGDMPEcIR3kDHzkkNd8Cri1aSFsS9vgAd5qvZenG5qQgv7T87FliCGmnJDuSWezk/T15uhVlxRgmjOYFFpVbfW7r9/oDB9YY61ZtD1YTsEj3PcBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EU9j0MnR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D0313C4CEE9;
	Wed, 26 Feb 2025 19:00:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740596416;
	bh=efHDZc+VZMO22pyTz8bbQ9t4hJW8gBFp6rwM21UYaFs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=EU9j0MnRwNITYvf2vonhEdW+AF/04yg+zg83Laf8oCZOio0b3At/PjT12zGaunr/Z
	 zojBhs71rA9JH1hn4TXzI/vWIKoHZ0Ojaftr36PxqV1JxyY7zfbWB/0M27f5C6yHhW
	 DItVmuXkrOJwPvwyaEyvjXFhLFQu0E8MxngF4++2EznzWdzonwiLu6Ae8UfX5ToSY0
	 zX3q9N4hmWJiluYsETNGD/ls5zckpYgHdHln+FYGZwsABsxZ92lY+EsDPleHedbrg9
	 9GJhyKGlXKkIbMlBXbmYFKzJ8im1AJhdoiGAgBhrgfBwVU4nUniuCZivUoVeP1IJX6
	 eL8xlmxogW0BA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1CFFC19F2E;
	Wed, 26 Feb 2025 19:00:16 +0000 (UTC)
From: Sven Peter via B4 Relay <devnull+sven.svenpeter.dev@kernel.org>
Date: Wed, 26 Feb 2025 19:00:05 +0000
Subject: [PATCH v2 3/4] soc: apple: rtkit: Use high prio work queue
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250226-apple-soc-misc-v2-3-c3ec37f9021b@svenpeter.dev>
References: <20250226-apple-soc-misc-v2-0-c3ec37f9021b@svenpeter.dev>
In-Reply-To: <20250226-apple-soc-misc-v2-0-c3ec37f9021b@svenpeter.dev>
To: Alyssa Rosenzweig <alyssa@rosenzweig.io>, Janne Grunau <j@jannau.net>, 
 Sven Peter <sven@svenpeter.dev>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1203; i=sven@svenpeter.dev;
 h=from:subject:message-id;
 bh=iv/ffBDDwqiEAfuhFDw9qjf225eWoJ8zsBxA5fDCkeQ=;
 b=owGbwMvMwCHmIlirolUq95LxtFoSQ/r+lL3ym1uNXD12Pz7lKsp732r7wsbyZdIKzy6Lftwfw
 eaf9uddRykLgxgHg6yYIsv2/famTx6+EVy66dJ7mDmsTCBDGLg4BWAiC7sY/vD822NWt4O9RlY2
 wcvXTDr+S7PNTd2k+712/2q0l3nUpjD8FT3rNT9ZiCOGR6NbYEdr/lO/0+uE3L93uGoteFP0XU2
 VEwA=
X-Developer-Key: i=sven@svenpeter.dev; a=openpgp;
 fpr=A1E3E34A2B3C820DBC4955E5993B08092F131F93
X-Endpoint-Received: by B4 Relay for sven@svenpeter.dev/default with
 auth_id=167
X-Original-From: Sven Peter <sven@svenpeter.dev>
Reply-To: sven@svenpeter.dev

From: Janne Grunau <j@jannau.net>

rtkit messages as communication with the DCP firmware for framebuffer
swaps or input events are time critical so use WQ_HIGHPRI to prevent
user space CPU load to increase latency.
With kwin_wayland 6's explicit sync mode user space load was able to
delay the IOMFB rtkit communication enough to miss vsync for surface
swaps. Minimal test scenario is constantly resizing a glxgears
Xwayland window.

Signed-off-by: Janne Grunau <j@jannau.net>
Reviewed-by: Alyssa Rosenzweig <alyssa@rosenzweig.io>
Signed-off-by: Sven Peter <sven@svenpeter.dev>
---
 drivers/soc/apple/rtkit.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/apple/rtkit.c b/drivers/soc/apple/rtkit.c
index 7e7b4f64ab17..4b78463dd5a1 100644
--- a/drivers/soc/apple/rtkit.c
+++ b/drivers/soc/apple/rtkit.c
@@ -696,7 +696,7 @@ struct apple_rtkit *apple_rtkit_init(struct device *dev, void *cookie,
 	rtk->mbox->rx = apple_rtkit_rx;
 	rtk->mbox->cookie = rtk;
 
-	rtk->wq = alloc_ordered_workqueue("rtkit-%s", WQ_MEM_RECLAIM,
+	rtk->wq = alloc_ordered_workqueue("rtkit-%s", WQ_HIGHPRI | WQ_MEM_RECLAIM,
 					  dev_name(rtk->dev));
 	if (!rtk->wq) {
 		ret = -ENOMEM;

-- 
2.34.1



