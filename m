Return-Path: <linux-kernel+bounces-440053-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AD9FC9EB7F7
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 18:17:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00EE7165B23
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 17:16:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E818623EA8A;
	Tue, 10 Dec 2024 17:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="hwotXmKx"
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42EF3230270;
	Tue, 10 Dec 2024 17:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733850827; cv=none; b=l3xKdIVUtMbH+E5YDExtUlpclbMIRc8RqE37wVo41pe/hE7kd5QVa2dNWIiQbgMDkyGbvh4puxovsGeismwfcCSgm6leky7l0Wp4L1xl/1LbbU0bcg5ZUEeFODBkbVP+rK7dut6+/6kyaXGvHJ4BPRqaW0FTs8X7ldEGzoBjof0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733850827; c=relaxed/simple;
	bh=mdJ4Yl47PnEzv9c2hypcphFiiwdt7zCFBGbUseQ4OSY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ApYvaIAA3hxR1WV7zIbPcMDdsxRwc3eDNdyEbrI86F1NIa9tXIFHgWuAKljgX7UmAP5ij547lYY7ZIrJZtqrsxhFhLmGX+qet+25wEeje8kpdTgLBkBBEBgmKzIBkqSCVHzrVQt+X33sgnSEaJfTXqRmvQISl0oNvrkTNKUED7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=hwotXmKx; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id AF5E22000D;
	Tue, 10 Dec 2024 17:13:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1733850818;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4QOmrfIdw5tljAsHY3LWcjFY4d7/dE+fB5Plerk04QQ=;
	b=hwotXmKxcHubbrw+/mwJjp9xXtP+TIE4y3J2xJ6/TjbpdcCyPpMXoVaMJWLSrreMpiyCfc
	QAzGD8A9D7ngLZ33jWRnVL5e8pbdS/rnEg32Kzo8i7kAZNrvJ4LGoauyelux++SBHtEPS4
	ujPWRroGbqA4s0WitecLd/XrfD0UXT3wyqtEGPp1JXEso/qXqZCuwt4ysQQ2sKeExVgsZU
	DRaN8vtYoocZO7/VnDPgKxyH17ZmOMr2f4+xTSNW0sd1r758HSANwP2E29MqSh7jtbXLcj
	FJFDcWMgYy+X9jauwVxq8cCjxC7KCbg4dfPzIqaHMD8z9aoF7lnLRRr47oeGng==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Tue, 10 Dec 2024 18:13:37 +0100
Subject: [PATCH v6 3/5] usb: cdns3: rename hibernated argument of
 role->resume() to lost_power
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241210-s2r-cdns-v6-3-28a17f9715a2@bootlin.com>
References: <20241210-s2r-cdns-v6-0-28a17f9715a2@bootlin.com>
In-Reply-To: <20241210-s2r-cdns-v6-0-28a17f9715a2@bootlin.com>
To: Peter Chen <peter.chen@kernel.org>, Pawel Laszczak <pawell@cadence.com>, 
 Roger Quadros <rogerq@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Mathias Nyman <mathias.nyman@intel.com>
Cc: =?utf-8?q?Gr=C3=A9gory_Clement?= <gregory.clement@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, linux-usb@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
X-Mailer: b4 0.14.2
X-GND-Sasl: theo.lebrun@bootlin.com

The cdns_role_driver->resume() callback takes a second boolean argument
named `hibernated` in its implementations. This is mistaken; the only
potential caller is:

int cdns_resume(struct cdns *cdns)
{
	/* ... */

	if (cdns->roles[cdns->role]->resume)
		cdns->roles[cdns->role]->resume(cdns, cdns_power_is_lost(cdns));

	return 0;
}

The argument can be true in cases outside of return from hibernation.
Reflect the true meaning by renaming both arguments to `lost_power`.

Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
 drivers/usb/cdns3/cdns3-gadget.c | 4 ++--
 drivers/usb/cdns3/cdnsp-gadget.c | 2 +-
 drivers/usb/cdns3/core.h         | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/cdns3/cdns3-gadget.c b/drivers/usb/cdns3/cdns3-gadget.c
index fd1beb10bba726cef258e7438d642f31d6567dfe..694aa14577390b6e9a98ce8c4685ac8f56e43ad4 100644
--- a/drivers/usb/cdns3/cdns3-gadget.c
+++ b/drivers/usb/cdns3/cdns3-gadget.c
@@ -3468,7 +3468,7 @@ __must_hold(&cdns->lock)
 	return 0;
 }
 
-static int cdns3_gadget_resume(struct cdns *cdns, bool hibernated)
+static int cdns3_gadget_resume(struct cdns *cdns, bool lost_power)
 {
 	struct cdns3_device *priv_dev = cdns->gadget_dev;
 
@@ -3476,7 +3476,7 @@ static int cdns3_gadget_resume(struct cdns *cdns, bool hibernated)
 		return 0;
 
 	cdns3_gadget_config(priv_dev);
-	if (hibernated)
+	if (lost_power)
 		writel(USB_CONF_DEVEN, &priv_dev->regs->usb_conf);
 
 	return 0;
diff --git a/drivers/usb/cdns3/cdnsp-gadget.c b/drivers/usb/cdns3/cdnsp-gadget.c
index 4a3f0f95825698f0524cace5c06bfcf27f763149..7d05180442fb94c5d1aab3d8ef766e365685f454 100644
--- a/drivers/usb/cdns3/cdnsp-gadget.c
+++ b/drivers/usb/cdns3/cdnsp-gadget.c
@@ -1973,7 +1973,7 @@ static int cdnsp_gadget_suspend(struct cdns *cdns, bool do_wakeup)
 	return 0;
 }
 
-static int cdnsp_gadget_resume(struct cdns *cdns, bool hibernated)
+static int cdnsp_gadget_resume(struct cdns *cdns, bool lost_power)
 {
 	struct cdnsp_device *pdev = cdns->gadget_dev;
 	enum usb_device_speed max_speed;
diff --git a/drivers/usb/cdns3/core.h b/drivers/usb/cdns3/core.h
index 57d47348dc193b1060f4543c2ef22905f464293b..921cccf1ca9db27a66b06c7c7873b13537c74b05 100644
--- a/drivers/usb/cdns3/core.h
+++ b/drivers/usb/cdns3/core.h
@@ -30,7 +30,7 @@ struct cdns_role_driver {
 	int (*start)(struct cdns *cdns);
 	void (*stop)(struct cdns *cdns);
 	int (*suspend)(struct cdns *cdns, bool do_wakeup);
-	int (*resume)(struct cdns *cdns, bool hibernated);
+	int (*resume)(struct cdns *cdns, bool lost_power);
 	const char *name;
 #define CDNS_ROLE_STATE_INACTIVE	0
 #define CDNS_ROLE_STATE_ACTIVE		1

-- 
2.47.1


