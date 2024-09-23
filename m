Return-Path: <linux-kernel+bounces-336290-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A833F97F1A1
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 22:20:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5FE461F21DB4
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 20:20:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 483A21A0BC5;
	Mon, 23 Sep 2024 20:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rosa.ru header.i=@rosa.ru header.b="HMrNRSep"
Received: from mail.rosa.ru (mail.rosa.ru [176.109.80.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F35415E88;
	Mon, 23 Sep 2024 20:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.109.80.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727122829; cv=none; b=UBbogO+cBCpiLaFqSpQDB8LI1bahcRegS10mfecXHkChz6enD3AAPo63U49Vme1A0uia45RNoeATHtnoqKWm9ewVHd0wXgX4qT+DjcB5AjKZlWH9CGWJ83mJgqqGoAIXSRbaFoTx1FkQcE48JfF218pB7FmB0ezl6asz4WVi460=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727122829; c=relaxed/simple;
	bh=lGwAoI+n9Yo4xnfmF+vllGL8FK8LhqfP38H5u6NnS6I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=PZIbk9udHm+YwYZlbEWM1bZZ49XYcqHJ6NaXYXdO/s7i0ZSoLosMd2oIhas0yZJScwwhugDUV1MzbeuxiEbRrRv36BzJqC9JeEn17zSk2fVkNubMzda0w5b00H1rCrmtan3NdnA99Vo0MQc8TPXMJX773KzUaoDfCaI3TmCP8yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rosa.ru; spf=pass smtp.mailfrom=rosa.ru; dkim=pass (1024-bit key) header.d=rosa.ru header.i=@rosa.ru header.b=HMrNRSep; arc=none smtp.client-ip=176.109.80.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rosa.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rosa.ru
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=simple/simple; d=rosa.ru; s=mail;
	bh=lGwAoI+n9Yo4xnfmF+vllGL8FK8LhqfP38H5u6NnS6I=;
	h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From;
	b=HMrNRSepcaCMaLVvg7L2bfmUgxUNGnRd65MhvZXu5PfDK6P0SSiAbV8vfms7rUQOfT3lrgWRAzb
	nbVDJGcEvrqgJYchQ80bOclSeZ2U1xKKg1SuIMXO8SB2HOVUOumbCuoBQOOGe+e7uFiye1AJDSgn3
	mzt5Kfb6nODlHrrdpQ4=
Received: from [194.9.26.89] (account m.arhipov@rosa.ru HELO localhost.localdomain)
  by mail.rosa.ru (CommuniGate Pro SMTP 6.4.1j)
  with ESMTPSA id 135313; Mon, 23 Sep 2024 23:20:21 +0300
From: Mikhail Arkhipov <m.arhipov@rosa.ru>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Mikhail Arkhipov <m.arhipov@rosa.ru>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Felipe Balbi <balbi@ti.com>,
	Mike Frysinger <vapier@gentoo.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: [PATCH v2] usb: gadget: r8a66597-udc: Fix double free in r8a66597_probe
Date: Mon, 23 Sep 2024 23:20:19 +0300
Message-Id: <20240923202019.37875-1-m.arhipov@rosa.ru>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The function r8a66597_free_request is already called in the err_add_udc
block, and freeing r8a66597->ep0_req twice may lead to a double free error.

If the probe process fails and the r8a66597_probe function subsequently
goes through its error handling path. Since r8a66597_free_request is called
multiple times in different error handling sections, it leads to an attempt
to free the same memory twice.

Remove the redundant call to r8a66597_free_request in the clean_up2 block.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 0f91349b89f3 ("usb: gadget: convert all users to the new udc infrastructure")
Signed-off-by: Mikhail Arkhipov <m.arhipov@rosa.ru>
---
v2: Remove redundant call to r8a66597_free_request in clean_up2 block 
instead of assigning r8a66597->ep0_req to NULL, as suggested by 
Sebastian Andrzej Siewior <bigeasy@linutronix.de>.
 drivers/usb/gadget/udc/r8a66597-udc.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/usb/gadget/udc/r8a66597-udc.c b/drivers/usb/gadget/udc/r8a66597-udc.c
index db4a10a979f9..a9b82f371abb 100644
--- a/drivers/usb/gadget/udc/r8a66597-udc.c
+++ b/drivers/usb/gadget/udc/r8a66597-udc.c
@@ -1956,9 +1956,6 @@ static int r8a66597_probe(struct platform_device *pdev)
 	if (r8a66597->pdata->on_chip)
 		clk_disable_unprepare(r8a66597->clk);
 
-	if (r8a66597->ep0_req)
-		r8a66597_free_request(&r8a66597->ep[0].ep, r8a66597->ep0_req);
-
 	return ret;
 }
 
-- 
2.39.3 (Apple Git-146)


