Return-Path: <linux-kernel+bounces-331155-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D23BE97A93B
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 00:30:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 114481C21EF7
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 22:30:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ABC615ECDF;
	Mon, 16 Sep 2024 22:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rosa.ru header.i=@rosa.ru header.b="IQt9GVjK"
Received: from mail.rosa.ru (mail.rosa.ru [176.109.80.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E93BB200A3;
	Mon, 16 Sep 2024 22:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.109.80.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726525797; cv=none; b=smXPOimRkKPgjvwPRsLI8ZQO+XsQ4Sz7WlQ556CJ2T01GBy+x9s+lxGYxZFqhH+UA/L7C/DoA0NR4eoOCjxsj+wjnnOwAXiqQ+UodmA8yGm4e7qc+Jrlx5aHn9Wb+4wNwMBw81BQeNK8eIC0sNUNdLcUh1+Jhlbi8rI+JvFPrfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726525797; c=relaxed/simple;
	bh=1SdDV+XTgvFpvWxNWjRysSQtrRUjupuoiIhyYFH+kmM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ErTSCMyPqQjqAjGMsggDXpMbdgcN5+XYxmXo5tEyBdtEKpReSJbhKAiYLhW5FyqF0WhNO7u3uM1tDK8V4blo2tkKNg1VUgvgQIsn9V6d50WykksiEawPZWLN2UuPr5edT7YGYxjJIQj5OPcjVsmaHMw1bPTzn16+Eli34MBdXXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rosa.ru; spf=pass smtp.mailfrom=rosa.ru; dkim=pass (1024-bit key) header.d=rosa.ru header.i=@rosa.ru header.b=IQt9GVjK; arc=none smtp.client-ip=176.109.80.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rosa.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rosa.ru
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=simple/simple; d=rosa.ru; s=mail;
	bh=1SdDV+XTgvFpvWxNWjRysSQtrRUjupuoiIhyYFH+kmM=;
	h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From;
	b=IQt9GVjKYpZB51h/sHTk28oDAb5asKcDXSBImWBu05Rr+3GUycYYzjUwf+sBhs57ZgpUFArsGpG
	yV36gPMv1b0+Uv21DvCxitpL+NyL1idIvRHWj5+RUItWPefMY0c7svGFy9CB7QQe+DpfpZFslXGmT
	+OVl4z1OKxw3bZ+Wwp0=
Received: from [31.135.99.32] (account m.arhipov@rosa.ru HELO localhost.localdomain)
  by mail.rosa.ru (CommuniGate Pro SMTP 6.4.1j)
  with ESMTPSA id 131315; Tue, 17 Sep 2024 01:29:40 +0300
From: Mikhail Arkhipov <m.arhipov@rosa.ru>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Mikhail Arkhipov <m.arhipov@rosa.ru>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Felipe Balbi <balbi@ti.com>,
	Ben Dooks <ben.dooks@codethink.co.uk>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: [PATCH] usb: gadget: r8a66597-udc: Fix double free in r8a66597_probe
Date: Tue, 17 Sep 2024 01:29:37 +0300
Message-Id: <20240916222937.12878-1-m.arhipov@rosa.ru>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The function r8a66597_free_request is called to free r8a66597->ep0_req,
but the pointer is not set to NULL afterward, which may lead to a double
free if the function is called again.

If the probe process fails and the r8a66597_probe function subsequently
goes through its error handling path. Since r8a66597_free_request is called
multiple times in different error handling sections, it leads to an attempt
to free the same memory twice.

Set r8a66597->ep0_req to NULL after calling r8a66597_free_request
to prevent any further attempts to free this pointer.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 0f91349b89f3 ("usb: gadget: convert all users to the new udc infrastructure")
Signed-off-by: Mikhail Arkhipov <m.arhipov@rosa.ru>
---
 drivers/usb/gadget/udc/r8a66597-udc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/usb/gadget/udc/r8a66597-udc.c b/drivers/usb/gadget/udc/r8a66597-udc.c
index db4a10a979f9..43b81cae7d17 100644
--- a/drivers/usb/gadget/udc/r8a66597-udc.c
+++ b/drivers/usb/gadget/udc/r8a66597-udc.c
@@ -1952,12 +1952,14 @@ static int r8a66597_probe(struct platform_device *pdev)
 
 err_add_udc:
 	r8a66597_free_request(&r8a66597->ep[0].ep, r8a66597->ep0_req);
+	r8a66597->ep0_req = NULL;
 clean_up2:
 	if (r8a66597->pdata->on_chip)
 		clk_disable_unprepare(r8a66597->clk);
 
 	if (r8a66597->ep0_req)
 		r8a66597_free_request(&r8a66597->ep[0].ep, r8a66597->ep0_req);
+		r8a66597->ep0_req = NULL;
 
 	return ret;
 }
-- 
2.39.3 (Apple Git-146)


