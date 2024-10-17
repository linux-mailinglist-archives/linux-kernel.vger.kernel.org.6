Return-Path: <linux-kernel+bounces-369893-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 117639A2417
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 15:38:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A10FEB2716F
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 13:38:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E132C1DE3B3;
	Thu, 17 Oct 2024 13:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="YoEVG+BO"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E8951DE4FA
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 13:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729172236; cv=none; b=QthOTGrB7sbWSZWDOKK7I5LsJue8ZLJYUmhnXwH2Gmxex7H5meC9SIRsy5cOL8Vhn6eN9K8rv4Pk6JqYd2JWuK5xr8EapjPQwoX7gCazO3/1IxZYYUomrHp3dW6cCxDSkQugukpdvaqyfD9MuPP2nyZST/sQmQQkx+RAyC7/Ty0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729172236; c=relaxed/simple;
	bh=dS4uASWxwyiXNL8/Q5N7rvqc7RgiswAf7xz30dE+mG0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fAKVqhcD6Pw49I0c1YsggfpBEJzgZZUMYcq77rcfOIlfjrk4t0yP/PfrW0AcoqIkCJ010KU2x6N/Eowx1ykfRipW96FBTTjTUoCMh1U94MouFSV9cRUgAlgwvCCQWejTEHIaW3z+REqfGVdcV4lN5HnIyFqGrCiyI/oJrbAchq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=YoEVG+BO; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from umang.jain (unknown [IPv6:2405:201:2015:f873:55d7:c02e:b2eb:ee3f])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 61390195A;
	Thu, 17 Oct 2024 15:35:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1729172114;
	bh=dS4uASWxwyiXNL8/Q5N7rvqc7RgiswAf7xz30dE+mG0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YoEVG+BOTSGL884vjYG7dq5gaa4M1CKbduLrPRFnRCRfi/k8ztEkvVyigrKVkukft
	 4Ne3Oi+l8CUwe9G7mJuYnj1GFrruq8eg50oLfERjRQkTf9sxDXreTD2WadzMAgz14/
	 QTP6mhs4lWLAx02vm4/gAAndF5+/HTDhFGMKu57Y=
From: Umang Jain <umang.jain@ideasonboard.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
Cc: linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Kieran Bingham <kieran.bingham@ideasonboard.com>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Stefan Wahren <wahrenst@gmx.net>,
	kernel-list@raspberrypi.com,
	Umang Jain <umang.jain@ideasonboard.com>
Subject: [PATCH 6/6] staging: vchiq_dev: Drop userdata local pointer
Date: Thu, 17 Oct 2024 19:06:29 +0530
Message-ID: <20241017133629.216672-7-umang.jain@ideasonboard.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241017133629.216672-1-umang.jain@ideasonboard.com>
References: <20241017133629.216672-1-umang.jain@ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The 'userdata' local pointer can be dropped which is set to bulk_waiter.
We can directly pass the waiter->bulk_waiter pointer to
vchiq_bulk_xfer_waiting().

Signed-off-by: Umang Jain <umang.jain@ideasonboard.com>
---
 .../staging/vc04_services/interface/vchiq_arm/vchiq_dev.c    | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_dev.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_dev.c
index f56057e17963..6a9685d9fafc 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_dev.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_dev.c
@@ -289,7 +289,6 @@ static int vchiq_irq_queue_bulk_tx_rx(struct vchiq_instance *instance,
 	struct vchiq_service *service;
 	struct bulk_waiter_node *waiter = NULL, *iter;
 	struct vchiq_bulk bulk_params = {};
-	void *userdata;
 	int status = 0;
 	int ret;
 
@@ -331,9 +330,9 @@ static int vchiq_irq_queue_bulk_tx_rx(struct vchiq_instance *instance,
 		}
 		dev_dbg(service->state->dev, "arm: found bulk_waiter %pK for pid %d\n",
 			waiter, current->pid);
-		userdata = &waiter->bulk_waiter;
 
-		status = vchiq_bulk_xfer_waiting(instance, args->handle, userdata);
+		status = vchiq_bulk_xfer_waiting(instance, args->handle,
+						 &waiter->bulk_waiter);
 	} else {
 		bulk_params.uoffset = args->data;
 		bulk_params.mode = args->mode;
-- 
2.45.2


