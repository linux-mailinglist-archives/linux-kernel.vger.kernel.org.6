Return-Path: <linux-kernel+bounces-286998-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E636B952166
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 19:39:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A34A42876DF
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 17:39:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A3551BC07A;
	Wed, 14 Aug 2024 17:39:15 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B63991B14F8
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 17:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723657154; cv=none; b=jzqPLe2KCb27h6OJRDiYiC0IIGvM1OxH5hRk1hDw182fNGlVxqBU5N0UJoKs9cz6BqEEhUqOcgF2Wjsbas/vPmdCZ5b2wOls37QoU1DfA+zISZgO7oKY26JoPrIt85XBsrfT6NTPvHPNG7lDd11G9ByGhAIbhPaFEI5pgeA3r4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723657154; c=relaxed/simple;
	bh=1RJxAnIQpaDu9oVTDIha64CMAfqUSWeUABz0wPFGVSY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=PYzdSolpWGi3PuxaRM3TjiaXouN1Mq9TVqdmWOGeM3hLq67j2OEE8xf5T2s+dc2FpzOnG0N4WapxmC6GjMKu1Fy8agdJNBxpjkpM0V4SPqWo66mKJmDdlVoeE9ItNXhf05sbqqylLcv6JV67SWHbbJ63pFdsKGrdxWNRBl313RY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <m.grzeschik@pengutronix.de>)
	id 1seHxj-0007OG-5I; Wed, 14 Aug 2024 19:39:07 +0200
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <m.grzeschik@pengutronix.de>)
	id 1seHxh-000PVL-Ve; Wed, 14 Aug 2024 19:39:05 +0200
Received: from localhost ([::1] helo=dude04.red.stw.pengutronix.de)
	by dude04.red.stw.pengutronix.de with esmtp (Exim 4.96)
	(envelope-from <m.grzeschik@pengutronix.de>)
	id 1seHxh-000cAQ-2y;
	Wed, 14 Aug 2024 19:39:05 +0200
From: Michael Grzeschik <m.grzeschik@pengutronix.de>
Date: Wed, 14 Aug 2024 19:39:05 +0200
Subject: [PATCH] usb: dwc3: ep0: Don't reset resource alloc flag (including
 ep0)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240814-dwc3hwep0reset-v1-1-087b0d26f3d0@pengutronix.de>
X-B4-Tracking: v=1; b=H4sIALjrvGYC/1WNywrCMBAAf6Xs2UDSLLT6K+Ihj9XsJZZdMYXSf
 2/qzePADLOBkjAp3IYNhL6s/K4d3GWAVEJ9keHcGUY7op0dmtySL40WK6T0MRGzn9w8ebwi9Cg
 GJRMl1FTO7N8+hUXoyevveH/s+wF1au72gQAAAA==
To: Thinh Nguyen <Thinh.Nguyen@synopsys.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Michael Grzeschik <m.grzeschik@pengutronix.de>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1563;
 i=m.grzeschik@pengutronix.de; h=from:subject:message-id;
 bh=1RJxAnIQpaDu9oVTDIha64CMAfqUSWeUABz0wPFGVSY=;
 b=owEBbQKS/ZANAwAKAb9pWET5cfSrAcsmYgBmvOu5mBfDcjeMxKuEZekeZqKaUwz96+1rXbJcX
 frL+prpAa+JAjMEAAEKAB0WIQQV2+2Fpbqd6fvv0Gi/aVhE+XH0qwUCZrzruQAKCRC/aVhE+XH0
 q2ROD/9xFI1rhYDInPnQInL2xUj3WRWjN1OsS3j6V5IJ+6Krkbz+g+Rm6YiVv/0pMJDYykBmScb
 v+XHVTQBvo8krfMbajRTUDkSkIM1XMucJ8IlTuKC3r05tAOBx5P7KwUmklOEDXaQOzKB3xo6N46
 Sp8UJN88h6+Um/+jX9mkxraNbmB3aTDG1/ZBHDxWs5FX9R0pQxYrYRhh2DFjRAqNKEelDtdsUSJ
 i18B6RZvJIHIBRFM8G3KJH2eQJUb8yH3G0kIEq1YKITcR2grxpOyguyha+l6du926XvoOBqT/tx
 L2Y8PuNmjYrsXuVwkTzFqfb71asYTwY0q2U6KDqk7Kqc4lAQCraQP5vbtNjpWj+Dxa3kx/iMp8w
 kpAMwmxcWq4P3ty2uuWDTbERKNEiZoxSTMmQ9YyNMnXMClakMXAHUWkdg2nzA3FtrPYUsswbQAJ
 1dg8FniOnEjwQ28+fUTQhQMqb/cveConcpn6IMipiIuUs86Tzjt2hQVfPD0sNoi0SKOjLC5sIWT
 wFCufIL2WjR93VXjqGNcIKEqWhC4qJbE2umISOt+NmhicVZxXl6UYc6eJUynjvU642XZqq4E/AO
 bfSIt35Qygd/OTEeS8t8XAQmMjsac5LyyIgOl2ppLI79RuZ7wtrg0JQlYp6KI6vdoIdKGIiNb8C
 1BvOQ3pwo0k0tIA==
X-Developer-Key: i=m.grzeschik@pengutronix.de; a=openpgp;
 fpr=957BC452CE953D7EA60CF4FC0BE9E3157A1E2C64
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: m.grzeschik@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

The DWC3_EP_RESOURCE_ALLOCATED flag ensures that the resource of an
endpoint is only assigned once. Unless the endpoint is reset, don't
clear this flag. Otherwise we may set endpoint resource again, which
prevents the driver from initiate transfer after handling a STALL or
endpoint halt to the control endpoint.

Commit f2e0eee47038 (usb: dwc3: ep0: Don't reset resource alloc flag)
was fixing the initial issue, but did this only for physical ep1. Since
the function dwc3_ep0_stall_and_restart is resetting the flags for both
physical endpoints, this also has to be done for ep0.

Cc: stable@vger.kernel.org
Fixes: b311048c174d ("usb: dwc3: gadget: Rewrite endpoint allocation flow")
Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
---
 drivers/usb/dwc3/ep0.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/dwc3/ep0.c b/drivers/usb/dwc3/ep0.c
index d96ffbe520397..c9533a99e47c8 100644
--- a/drivers/usb/dwc3/ep0.c
+++ b/drivers/usb/dwc3/ep0.c
@@ -232,7 +232,8 @@ void dwc3_ep0_stall_and_restart(struct dwc3 *dwc)
 	/* stall is always issued on EP0 */
 	dep = dwc->eps[0];
 	__dwc3_gadget_ep_set_halt(dep, 1, false);
-	dep->flags = DWC3_EP_ENABLED;
+	dep->flags &= DWC3_EP_RESOURCE_ALLOCATED;
+	dep->flags |= DWC3_EP_ENABLED;
 	dwc->delayed_status = false;
 
 	if (!list_empty(&dep->pending_list)) {

---
base-commit: 38343be0bf9a7d7ef0d160da5f2db887a0e29b62
change-id: 20240814-dwc3hwep0reset-b4d371873494

Best regards,
-- 
Michael Grzeschik <m.grzeschik@pengutronix.de>


