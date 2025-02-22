Return-Path: <linux-kernel+bounces-527373-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 088B5A40A6B
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 17:58:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 021DE7A5EEC
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 16:56:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91A0120AF6D;
	Sat, 22 Feb 2025 16:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IR0MwCzv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E85792063FF;
	Sat, 22 Feb 2025 16:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740243448; cv=none; b=JHqHaM32336y1qgCMUjbDvMkXsVMMexV5OT3+fhcIBFOBnr/kMELXnwbm2cQ216qroISEpwPKKaHISEjBOgy4BLNMwRwu/K8Wpv+xMx2IVGZrbECjtHz6J0ta3RNIjFfL5glYnStKlX63xeq18gRVx3fIosuV/RmS/Z23JLfsJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740243448; c=relaxed/simple;
	bh=4E8KhD8x9nt6C1IAI/uulttC6xS9rKz68kPnusPtVyw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TqjWg7IRKnod05fmuyzUxwK3PmO3IUuv3i/SI6gQfvj7MITr9Omk4OeLPySS9I0SgnUy6REapzpuoTMZepB0/Gl6Ks2VA++HIq5JzA5k08UMBdvsTAA6y+2khAONaRPYSTV3gjcilt7sJMQ8yhvKr93s7BkmgnOJXo8Pd6+UyDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IR0MwCzv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8AD36C4CEE7;
	Sat, 22 Feb 2025 16:57:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740243447;
	bh=4E8KhD8x9nt6C1IAI/uulttC6xS9rKz68kPnusPtVyw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=IR0MwCzvfmIZL8eUiDV1QqMiWvmrCmjjJHl+6/xJmYkMIi6nq9Nf8o1RUQUUPn63/
	 sgncXMDTM7FbL7g3m6vD+2p+VZJH0Mm6iNft1QWpQTW8go3AAkJbCftw7rnMBh9JQM
	 2PiJZsoaRsGDN7mPGPn55oNUOrQ0TxTFVOfpFMJ8zdf8BVWTmnQnTRIwmSqHKMULHm
	 RF5xfP0GCkhyOhAj/Sro6R3Mo6U56obAsb4CdbG6EEqiXdV37driDiRvOYGg7w44Ew
	 df25mBlOuFwA4TWTr7RSXpVVWhvtOrEVvW4CE4EpPM1irwILkKR0knFQIb3ZCg9sC1
	 3OflukA2MQUvA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78667C021B9;
	Sat, 22 Feb 2025 16:57:27 +0000 (UTC)
From: Sven Peter via B4 Relay <devnull+sven.svenpeter.dev@kernel.org>
Date: Sat, 22 Feb 2025 16:56:48 +0000
Subject: [PATCH 3/4] soc: apple: rtkit: Use high prio work queue
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250222-apple-soc-misc-v1-3-1a3af494a48a@svenpeter.dev>
References: <20250222-apple-soc-misc-v1-0-1a3af494a48a@svenpeter.dev>
In-Reply-To: <20250222-apple-soc-misc-v1-0-1a3af494a48a@svenpeter.dev>
To: Alyssa Rosenzweig <alyssa@rosenzweig.io>, Janne Grunau <j@jannau.net>, 
 Sven Peter <sven@svenpeter.dev>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1148; i=sven@svenpeter.dev;
 h=from:subject:message-id;
 bh=OWy6VUyG9jq3qBr8MjUz+I6ziXX4V7f2D7Wm55EGjV0=;
 b=owGbwMvMwCHmIlirolUq95LxtFoSQ/ouxs93H4hIZT5ne2ZQsWnBzGt3WbYyLkm8nxZQvHJJi
 4DX/Au3O0pZGMQ4GGTFFFm277c3ffLwjeDSTZfew8xhZQIZwsDFKQAT4U1k+O/RLcbryXjg/Orw
 veyqdwO/i2vNv+2wa53plXtfVQ0ObVdg+J+Zu85u58aTu2T9ZL9N+uusLjtTvX2O1EY591X+ItO
 5W1gA
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
Signed-off-by: Sven Peter <sven@svenpeter.dev>
---
 drivers/soc/apple/rtkit.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/apple/rtkit.c b/drivers/soc/apple/rtkit.c
index 35734ae8c9ce..b7f4654c3341 100644
--- a/drivers/soc/apple/rtkit.c
+++ b/drivers/soc/apple/rtkit.c
@@ -695,7 +695,7 @@ struct apple_rtkit *apple_rtkit_init(struct device *dev, void *cookie,
 	rtk->mbox->rx = apple_rtkit_rx;
 	rtk->mbox->cookie = rtk;
 
-	rtk->wq = alloc_ordered_workqueue("rtkit-%s", WQ_MEM_RECLAIM,
+	rtk->wq = alloc_ordered_workqueue("rtkit-%s", WQ_HIGHPRI | WQ_MEM_RECLAIM,
 					  dev_name(rtk->dev));
 	if (!rtk->wq) {
 		ret = -ENOMEM;

-- 
2.34.1



