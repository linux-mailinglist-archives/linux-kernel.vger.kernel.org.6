Return-Path: <linux-kernel+bounces-325739-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EDD1975D9A
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 01:10:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D86241F23B8B
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 23:10:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C36EF1AC899;
	Wed, 11 Sep 2024 23:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rosa.ru header.i=@rosa.ru header.b="OTikq7Lx"
Received: from mail.rosa.ru (mail.rosa.ru [176.109.80.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 212D22F30;
	Wed, 11 Sep 2024 23:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.109.80.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726096218; cv=none; b=Qis1DSzVi3ZWaMG/1mDJ8EuyEZyO4kZOssQ+hVlmJI4uEPGFCqb7i9urnI3SstpBSV6HntaZLhO7tjzxFZtI3PpHx1dMVdM9gMi7JiXahAKSnIO6PS5pvm/W+QahruemiAwI/KECmg9J+cg4Qax6s6FXroIT8jRD+JPRVc3GwRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726096218; c=relaxed/simple;
	bh=1hJMu9DLeokC/nbTuI8d+HfcTEk4y33TTTHXBH6FcYQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Hi+SJVp2Fq0QekoXnX92I1QOSVOo5x1B0prEZdLr9rF92qoG0R1rs184MOzroDGTauhnYLrHVDx9AKCwdcIPxAkdZlNDYdgNYO+Yah3YTt9mxIZSeEe8GAVn5q2y9wdWO9R7ohwsK1HgaiT7lAxyXGprFhf7you39CXsqUdYoJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rosa.ru; spf=pass smtp.mailfrom=rosa.ru; dkim=pass (1024-bit key) header.d=rosa.ru header.i=@rosa.ru header.b=OTikq7Lx; arc=none smtp.client-ip=176.109.80.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rosa.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rosa.ru
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=simple/simple; d=rosa.ru; s=mail;
	bh=1hJMu9DLeokC/nbTuI8d+HfcTEk4y33TTTHXBH6FcYQ=;
	h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From;
	b=OTikq7LxpQeZnZbcIsMUaWC4P1NSPlNlK5+phEIeXv0Z2uaVAI/onccQoKmG2pMdPU1Q7dVCC7H
	GxhH9Sb/LRMfDQSjS8p1hsuDO1ELipGw4LreEMtb4FJNU48sN46pQBd8A1sWblGVnxwYPRUj+ugQr
	BA2Q8Hes2BhUAlUGc3A=
Received: from [31.135.99.32] (account m.arhipov@rosa.ru HELO localhost.localdomain)
  by mail.rosa.ru (CommuniGate Pro SMTP 6.4.1j)
  with ESMTPSA id 129029; Thu, 12 Sep 2024 01:10:00 +0300
From: Mikhail Arkhipov <m.arhipov@rosa.ru>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Mikhail Arkhipov <m.arhipov@rosa.ru>,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: [PATCH] usb: gadget: udc: net2280: Fix NULL pointer dereference in net2280_free_request
Date: Thu, 12 Sep 2024 01:09:23 +0300
Message-Id: <20240911220923.13628-1-m.arhipov@rosa.ru>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When the function net2280_free_request is called with a NULL _ep pointer,
the function still tries to dereference _ep before returning. This leads
to a NULL pointer dereference and possible kernel panic.

This bug can be triggered when a USB endpoint is removed unexpectedly
and the driver attempts to free resources associated with it.

Move the NULL check before calling container_of to ensure that the
function does not attempt to dereference a NULL pointer. This prevents
the kernel from crashing when either _ep or _req is NULL.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Mikhail Arkhipov <m.arhipov@rosa.ru>
---
 drivers/usb/gadget/udc/net2280.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/gadget/udc/net2280.c b/drivers/usb/gadget/udc/net2280.c
index 1b929c519cd7..3e8280fa3207 100644
--- a/drivers/usb/gadget/udc/net2280.c
+++ b/drivers/usb/gadget/udc/net2280.c
@@ -582,13 +582,12 @@ static void net2280_free_request(struct usb_ep *_ep, struct usb_request *_req)
 	struct net2280_ep	*ep;
 	struct net2280_request	*req;
 
-	ep = container_of(_ep, struct net2280_ep, ep);
 	if (!_ep || !_req) {
-		dev_err(&ep->dev->pdev->dev, "%s: Invalid ep=%p or req=%p\n",
-							__func__, _ep, _req);
+		dev_err(NULL, "%s: Invalid ep=%p or req=%p\n", __func__, _ep, _req);
 		return;
 	}
 
+	ep = container_of(_ep, struct net2280_ep, ep);
 	req = container_of(_req, struct net2280_request, req);
 	WARN_ON(!list_empty(&req->queue));
 	if (req->td)
-- 
2.39.3 (Apple Git-146)


