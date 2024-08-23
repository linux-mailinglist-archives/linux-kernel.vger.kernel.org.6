Return-Path: <linux-kernel+bounces-299177-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 312BF95D130
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 17:16:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D59671F227D1
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 15:16:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA8B818C342;
	Fri, 23 Aug 2024 15:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="Q3DZFXpc"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C25AD18BC2F
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 15:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724426088; cv=none; b=hro9Adrnr2z3Lxcsaq/rOQmjkvMILJnpnX4DrNDGWYxsbQ6gYxOkQet3pUO6XqXl/zceO00BrpTbjuNGXvhdk5o2ixFz3/yPqCIiUVyRbOq4cSEhzTQk6lLUtGxeVsUkqNd/1HJNRsxJhwkcfPWBCFOKkTv5B1lLXlrhUscvToc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724426088; c=relaxed/simple;
	bh=ft5HmVJ271Ka/bJA/94LL3znx98d6bWSWFX0dUAPefw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=u9kI//vnz//tX3j9nkBPMtLPCuoLuNS2X+HaRtRsKS12dew2a1+HUSGyd1jlfdTp3ZXGuYC97ItAbAFFoAF+I79HGqYi/VX1nquszSYrOJBZslsvBTN0M3HSP8XnWy6VynQEBEBPfpdTnK3c8w70prfE1TKof2HAB8HWJw3hUac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=Q3DZFXpc; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from [192.168.29.25] (unknown [IPv6:2405:201:2015:f873:55f8:639e:8e9f:12ec])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 29C2F2D5;
	Fri, 23 Aug 2024 17:13:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1724426021;
	bh=ft5HmVJ271Ka/bJA/94LL3znx98d6bWSWFX0dUAPefw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Q3DZFXpclHdZ/+6e4Jd18ji1LPG6XHt6HoeugzKlc1vCDyuPyKukYEfbts7zoTRsJ
	 IMWj87TkkD21HmPnkkOM3XufvajTkaKTv73XwZGGQW82o5pDm3iCDoyPzAP08aGxRc
	 uYEopsfFomI9/abZflIW58K6KfGmX8enyjRpw9f8=
From: Umang Jain <umang.jain@ideasonboard.com>
Date: Fri, 23 Aug 2024 20:44:27 +0530
Subject: [PATCH 7/7] staging: vchiq_core: Pass enumerated flag instead of
 int
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240823-to_sent2-v1-7-8bc182a0adaf@ideasonboard.com>
References: <20240823-to_sent2-v1-0-8bc182a0adaf@ideasonboard.com>
In-Reply-To: <20240823-to_sent2-v1-0-8bc182a0adaf@ideasonboard.com>
To: Florian Fainelli <florian.fainelli@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-rpi-kernel@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, linux-staging@lists.linux.dev, 
 linux-kernel@vger.kernel.org, Dan Carpenter <dan.carpenter@linaro.org>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Kieran Bingham <kieran.bingham@ideasonboard.com>, 
 Arnd Bergmann <arnd@arndb.de>, Stefan Wahren <wahrenst@gmx.net>, 
 Dave Stevenson <dave.stevenson@raspberrypi.com>, 
 Phil Elwell <phil@raspberrypi.com>, 
 Umang Jain <umang.jain@ideasonboard.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1724426064; l=1116;
 i=umang.jain@ideasonboard.com; s=20240731; h=from:subject:message-id;
 bh=ft5HmVJ271Ka/bJA/94LL3znx98d6bWSWFX0dUAPefw=;
 b=706rLwU+aQ7hCnwi1dFxvBR3MCVDFdJxF5p7v54O82gJEHTRCNQvzEUFefEXbgDTezf176Ldi
 5FZTvpp/mEMDk9U3lAXJI0dnlAtyS/HHN9x78XUHnnRvtNZpX/iqfW3
X-Developer-Key: i=umang.jain@ideasonboard.com; a=ed25519;
 pk=7pvnIBNsDpFUMiph0Vlhrr01+rAn5fSIn/QtDeLeXL0=

Pass proper enumerated flag which exists, instead of an integer while
calling queue_message(). It helps with readability of the code.

Signed-off-by: Umang Jain <umang.jain@ideasonboard.com>
---
 drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
index 84631878f77d..54e21a4273b8 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
@@ -3146,7 +3146,8 @@ vchiq_queue_message(struct vchiq_instance *instance, unsigned int handle,
 	switch (service->srvstate) {
 	case VCHIQ_SRVSTATE_OPEN:
 		status = queue_message(service->state, service, data_id,
-				       copy_callback, context, size, 1);
+				       copy_callback, context, size,
+				       QMFLAGS_IS_BLOCKING);
 		break;
 	case VCHIQ_SRVSTATE_OPENSYNC:
 		status = queue_message_sync(service->state, service, data_id,

-- 
2.45.0


