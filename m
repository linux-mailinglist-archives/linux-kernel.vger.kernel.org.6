Return-Path: <linux-kernel+bounces-377909-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65B729AC878
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 13:05:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94E7B1C21F86
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 11:05:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E95BF1AA787;
	Wed, 23 Oct 2024 11:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="OuRe4Wnm"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABB841A725E
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 11:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729681489; cv=none; b=kVAbfXpi8KH2SlwLXsX7TmJtC/OW6VBh4mUjh1E2wZrwC4YUrH1DgvlsQOJVACjZiYK4zHj6jhweP6GzXR1W8cRLUxxiSRWsxgFlo2Bb5I3KrbjFH53h0Bm7bH+I5nIXeVENYEcc21SkjDw+tUMcDtEg5lQTdcTrbTOXElUTcJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729681489; c=relaxed/simple;
	bh=2LKSIF262z/emv06K71fxiLrd5T72VZ1UM2x5FZ8PVM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NEQ7+8tn7RZ/0trL2lHG+SwXMG9R/D7Yu234dm2R49wOCWPpxpOAVrP2jbjnCSbOuqCv3LQlPqu/RzfjKi9syxTmnKWtWb9N+bUGiInVImQglwf5sJBibMKSUlEka4gqXGvyV6047IdQOtKrdZFXD1ZVaell4UP+CmMzHvHiLiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=OuRe4Wnm; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from umang.jain (unknown [IPv6:2405:201:2015:f873:55d7:c02e:b2eb:ee3f])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 2533B8A9;
	Wed, 23 Oct 2024 13:02:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1729681379;
	bh=2LKSIF262z/emv06K71fxiLrd5T72VZ1UM2x5FZ8PVM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OuRe4WnmVkamiuzriOZgOd7R6iiohfea88k3o3pLCUXILfP9oZyLvYM4H3RFMtzD8
	 NB691linWt1Nk7YtH7hMTkwLj0kK3BaEKbamSytFcDBbT302RKsr4RZXOzd5eHNfKh
	 m1OWc4dXO5v1ruJ1zmjLJqCzGz6ELUFomU2vM3vk=
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
Subject: [PATCH 1/6] staging: vchiq_arm: Rename a struct vchiq_bulk member
Date: Wed, 23 Oct 2024 16:34:01 +0530
Message-ID: <20241023110406.885199-2-umang.jain@ideasonboard.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241023110406.885199-1-umang.jain@ideasonboard.com>
References: <20241023110406.885199-1-umang.jain@ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rename the struct vchiq_bulk's 'data' member to 'dma_addr' for
better readability. No functional changes intended in this patch.

Signed-off-by: Umang Jain <umang.jain@ideasonboard.com>
---
 .../vc04_services/interface/vchiq_arm/vchiq_arm.c    |  2 +-
 .../vc04_services/interface/vchiq_arm/vchiq_core.c   | 12 ++++++------
 .../vc04_services/interface/vchiq_arm/vchiq_core.h   |  2 +-
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
index c2e7c2bd5071..f23d98a1b960 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
@@ -587,7 +587,7 @@ vchiq_blocking_bulk_transfer(struct vchiq_instance *instance, unsigned int handl
 		if (bulk) {
 			/* This thread has an outstanding bulk transfer. */
 			/* FIXME: why compare a dma address to a pointer? */
-			if ((bulk->data != (dma_addr_t)(uintptr_t)bulk_params->data) ||
+			if ((bulk->dma_addr != (dma_addr_t)(uintptr_t)bulk_params->dma_addr) ||
 			    (bulk->size != bulk_params->size)) {
 				/*
 				 * This is not a retry of the previous one.
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
index 9e56e34ca4d9..90ab780b7e94 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
@@ -1369,7 +1369,7 @@ notify_bulks(struct vchiq_service *service, struct vchiq_bulk_queue *queue,
 		 * Only generate callbacks for non-dummy bulk
 		 * requests, and non-terminated services
 		 */
-		if (bulk->data && service->instance) {
+		if (bulk->dma_addr && service->instance) {
 			status = service_notify_bulk(service, bulk);
 			if (status == -EAGAIN)
 				break;
@@ -1751,7 +1751,7 @@ vchiq_prepare_bulk_data(struct vchiq_instance *instance, struct vchiq_bulk *bulk
 	if (!pagelistinfo)
 		return -ENOMEM;
 
-	bulk->data = pagelistinfo->dma_addr;
+	bulk->dma_addr = pagelistinfo->dma_addr;
 
 	/*
 	 * Store the pagelistinfo address in remote_data,
@@ -1807,7 +1807,7 @@ abort_outstanding_bulks(struct vchiq_service *service,
 				service->remoteport, bulk->size, bulk->remote_size);
 		} else {
 			/* fabricate a matching dummy bulk */
-			bulk->data = 0;
+			bulk->dma_addr = 0;
 			bulk->size = 0;
 			bulk->actual = VCHIQ_BULK_ACTUAL_ABORTED;
 			bulk->dir = is_tx ? VCHIQ_BULK_TRANSMIT :
@@ -2112,7 +2112,7 @@ parse_message(struct vchiq_state *state, struct vchiq_header *header)
 
 			dev_dbg(state->dev, "core: %d: prs %s@%pK (%d->%d) %x@%pad\n",
 				state->id, msg_type_str(type), header, remoteport,
-				localport, bulk->actual, &bulk->data);
+				localport, bulk->actual, &bulk->dma_addr);
 
 			dev_dbg(state->dev, "core: %d: prs:%d %cx li=%x ri=%x p=%x\n",
 				state->id, localport,
@@ -3081,7 +3081,7 @@ vchiq_bulk_xfer_queue_msg_killable(struct vchiq_service *service,
 
 	dev_dbg(state->dev, "core: %d: bt (%d->%d) %cx %x@%pad %pK\n",
 		state->id, service->localport, service->remoteport,
-		dir_char, bulk->size, &bulk->data, bulk->userdata);
+		dir_char, bulk->size, &bulk->dma_addr, bulk->userdata);
 
 	/*
 	 * The slot mutex must be held when the service is being closed, so
@@ -3095,7 +3095,7 @@ vchiq_bulk_xfer_queue_msg_killable(struct vchiq_service *service,
 	if (service->srvstate != VCHIQ_SRVSTATE_OPEN)
 		goto unlock_both_error_exit;
 
-	payload[0] = lower_32_bits(bulk->data);
+	payload[0] = lower_32_bits(bulk->dma_addr);
 	payload[1] = bulk->size;
 	status = queue_message(state,
 			       NULL,
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h
index 186b1395d3a2..9ba4a2295dc3 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h
@@ -115,7 +115,7 @@ struct vchiq_bulk {
 	short mode;
 	short dir;
 	void *userdata;
-	dma_addr_t data;
+	dma_addr_t dma_addr;
 	int size;
 	void *remote_data;
 	int remote_size;
-- 
2.45.2


