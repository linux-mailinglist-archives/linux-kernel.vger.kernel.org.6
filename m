Return-Path: <linux-kernel+bounces-362776-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A71B499B932
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Oct 2024 13:22:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F14B0281EB6
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Oct 2024 11:22:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5E7213D899;
	Sun, 13 Oct 2024 11:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="W8xU7gJ5"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BADC4145B2D
	for <linux-kernel@vger.kernel.org>; Sun, 13 Oct 2024 11:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728818507; cv=none; b=JjwGDBfa57CcFEgraYdbYZfkES1AFMhvPXdXtUM8jIZsnTT4oreGsHVgIPVY7+N1nHtjaHRvcXMQ3p8PYgWg5tvd/841EdDDrzWR1QdpI0BARNP1iss6akY1oEValYOT7qSNaDdiFPL9QiYvKng/t/4/lIAh8AKnXmh27Gyem/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728818507; c=relaxed/simple;
	bh=ksnZnuSUTgdb9waIQ/ooIx0Ymbh3Ba5Bc6L4/3YnmzA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sOsNRGFnWLAUXSVR/d8ivxmLq+ElNDU4JFB60JcNL2/sibxHbRP26bnbY7A2T54VXPqM4TYLo79fjn66v9E/xRkYY0XqLqDW94Q0CDBEHufTqd+ldQotpbcSFA+sn8m29YlOyYObq4X1qZ2FRL8dsbw+owVmmB3QFgv2fWxaPyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=W8xU7gJ5; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from umang.jain (unknown [IPv6:2405:201:2015:f873:55d7:c02e:b2eb:ee3f])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id A57499EC;
	Sun, 13 Oct 2024 13:20:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1728818404;
	bh=ksnZnuSUTgdb9waIQ/ooIx0Ymbh3Ba5Bc6L4/3YnmzA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=W8xU7gJ5dgDUkPxUTx7GfzGBAv6NTqQ1dCAjGzONb7Sru0h2ZggRycOpT7jOqhc1b
	 yDkwNV0uZ6JgqZ4DKR74DRILPRakUvpwPoD+Ud96oRTrte+KpzwFtMR64DuKhqzuRv
	 eT1Od3Qso1hXyYhqGcpvlXUqRXPaR9L8BK9HUXKs=
From: Umang Jain <umang.jain@ideasonboard.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
Cc: linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Kieran Bingham <kieran.bingham@ideasonboard.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	kernel-list@raspberrypi.com,
	Stefan Wahren <wahrenst@gmx.net>,
	Umang Jain <umang.jain@ideasonboard.com>
Subject: [PATCH v4 4/6] staging: vchiq_core: Refactor notify_bulks()
Date: Sun, 13 Oct 2024 16:51:26 +0530
Message-ID: <20241013112128.397249-5-umang.jain@ideasonboard.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241013112128.397249-1-umang.jain@ideasonboard.com>
References: <20241013112128.397249-1-umang.jain@ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move the statistics and bulk completion events handling  to a separate
function. This helps to improve readability for notify_bulks().

No functional changes intended in this patch.

Signed-off-by: Umang Jain <umang.jain@ideasonboard.com>
Reviewed-by: Kieran Bingham <kieran.bingham@ideasonboard.com>
---
 .../interface/vchiq_arm/vchiq_core.c          | 71 +++++++++++--------
 1 file changed, 40 insertions(+), 31 deletions(-)

diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
index e9cd012e2b5f..d7ddbc97207a 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
@@ -1309,6 +1309,43 @@ get_bulk_reason(struct vchiq_bulk *bulk)
 	return VCHIQ_BULK_RECEIVE_DONE;
 }
 
+static int service_notify_bulk(struct vchiq_service *service,
+			       struct vchiq_bulk *bulk)
+{
+	if (bulk->actual != VCHIQ_BULK_ACTUAL_ABORTED) {
+		if (bulk->dir == VCHIQ_BULK_TRANSMIT) {
+			VCHIQ_SERVICE_STATS_INC(service, bulk_tx_count);
+			VCHIQ_SERVICE_STATS_ADD(service, bulk_tx_bytes,
+						bulk->actual);
+		} else {
+			VCHIQ_SERVICE_STATS_INC(service, bulk_rx_count);
+			VCHIQ_SERVICE_STATS_ADD(service, bulk_rx_bytes,
+						bulk->actual);
+		}
+	} else {
+		VCHIQ_SERVICE_STATS_INC(service, bulk_aborted_count);
+	}
+
+	if (bulk->mode == VCHIQ_BULK_MODE_BLOCKING) {
+		struct bulk_waiter *waiter;
+
+		spin_lock(&service->state->bulk_waiter_spinlock);
+		waiter = bulk->userdata;
+		if (waiter) {
+			waiter->actual = bulk->actual;
+			complete(&waiter->event);
+		}
+		spin_unlock(&service->state->bulk_waiter_spinlock);
+	} else if (bulk->mode == VCHIQ_BULK_MODE_CALLBACK) {
+		enum vchiq_reason reason = get_bulk_reason(bulk);
+
+		return make_service_callback(service, reason, NULL,
+					     bulk->userdata);
+	}
+
+	return 0;
+}
+
 /* Called by the slot handler - don't hold the bulk mutex */
 static int
 notify_bulks(struct vchiq_service *service, struct vchiq_bulk_queue *queue,
@@ -1333,37 +1370,9 @@ notify_bulks(struct vchiq_service *service, struct vchiq_bulk_queue *queue,
 		 * requests, and non-terminated services
 		 */
 		if (bulk->data && service->instance) {
-			if (bulk->actual != VCHIQ_BULK_ACTUAL_ABORTED) {
-				if (bulk->dir == VCHIQ_BULK_TRANSMIT) {
-					VCHIQ_SERVICE_STATS_INC(service, bulk_tx_count);
-					VCHIQ_SERVICE_STATS_ADD(service, bulk_tx_bytes,
-								bulk->actual);
-				} else {
-					VCHIQ_SERVICE_STATS_INC(service, bulk_rx_count);
-					VCHIQ_SERVICE_STATS_ADD(service, bulk_rx_bytes,
-								bulk->actual);
-				}
-			} else {
-				VCHIQ_SERVICE_STATS_INC(service, bulk_aborted_count);
-			}
-			if (bulk->mode == VCHIQ_BULK_MODE_BLOCKING) {
-				struct bulk_waiter *waiter;
-
-				spin_lock(&service->state->bulk_waiter_spinlock);
-				waiter = bulk->userdata;
-				if (waiter) {
-					waiter->actual = bulk->actual;
-					complete(&waiter->event);
-				}
-				spin_unlock(&service->state->bulk_waiter_spinlock);
-			} else if (bulk->mode == VCHIQ_BULK_MODE_CALLBACK) {
-				enum vchiq_reason reason =
-						get_bulk_reason(bulk);
-				status = make_service_callback(service, reason,	NULL,
-							       bulk->userdata);
-				if (status == -EAGAIN)
-					break;
-			}
+			status = service_notify_bulk(service, bulk);
+			if (status == -EAGAIN)
+				break;
 		}
 
 		queue->remove++;
-- 
2.45.2


