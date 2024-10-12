Return-Path: <linux-kernel+bounces-362591-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D37699B6AF
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 20:58:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C00E6283429
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 18:58:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B16619CC3D;
	Sat, 12 Oct 2024 18:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="hRvFH7Cg"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E04A16DECB
	for <linux-kernel@vger.kernel.org>; Sat, 12 Oct 2024 18:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728759435; cv=none; b=sUV7y2FCXKXHpWtmRBCp4DjfPuU0gcxADMK3zLljsGCh9YE7YCLNiHeX21jcvYyzJkhw50SbDZNKB8+ByTdOnu21TBr0z4ZoO4SO0eiRlBdauLksaQoxuoyLtgegE/C1iOKMTYAbR5mVSo8ksyn13/gJG36CUMzdau7xFpFOyn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728759435; c=relaxed/simple;
	bh=5W15jzoniFMFksB/oDiFHS9Y8Y1koviywK7KIRbWEF0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KKyVEk24jhUt05kkT/SRY2363Twa/qDcB4EPRlJEzy1DdVOYVTArJSWOeRhWlzgdv3BgmC7ira1FLTAKUfsrdDNuB56agt0zEYkoBo6mzxYJyK9qDNjp0Yny+0Wn7Xyqr0RpHSfEYqHYk5gl+IGdNVyzSwKbgcsJNPPJrjblG5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=hRvFH7Cg; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from umang.jain (unknown [IPv6:2405:201:2015:f873:55d7:c02e:b2eb:ee3f])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id B9438DF3;
	Sat, 12 Oct 2024 20:55:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1728759333;
	bh=5W15jzoniFMFksB/oDiFHS9Y8Y1koviywK7KIRbWEF0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hRvFH7CgDnbPDUjpSViGWE8P0JU4gYHqdnmaBqu8AfMtulfB/x76A5lP15gfU5drn
	 QeMB/rhrbYtsQyEalo9Gj5ZTLfaozAd207AfYsudVy+/AuYVpSnTjU8kSsN0MXInS1
	 xgKd5IzRb8sX2+KCheirvRoz34OG8sCFOgKiB7Ec=
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
Subject: [PATCH v3 4/6] staging: vchiq_core: Refactor notify_bulks()
Date: Sun, 13 Oct 2024 00:26:50 +0530
Message-ID: <20241012185652.316172-5-umang.jain@ideasonboard.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241012185652.316172-1-umang.jain@ideasonboard.com>
References: <20241012185652.316172-1-umang.jain@ideasonboard.com>
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
---
 .../interface/vchiq_arm/vchiq_core.c          | 77 +++++++++++--------
 1 file changed, 46 insertions(+), 31 deletions(-)

diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
index e9cd012e2b5f..19dfcd98dcde 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
@@ -1309,6 +1309,49 @@ get_bulk_reason(struct vchiq_bulk *bulk)
 	return VCHIQ_BULK_RECEIVE_DONE;
 }
 
+static int service_notify_bulk(struct vchiq_service *service,
+			       struct vchiq_bulk *bulk)
+{
+	int status = -EINVAL;
+
+	if (!service || !bulk)
+		return status;
+
+	if (bulk->actual != VCHIQ_BULK_ACTUAL_ABORTED) {
+		if (bulk->dir == VCHIQ_BULK_TRANSMIT) {
+			VCHIQ_SERVICE_STATS_INC(service, bulk_tx_count);
+			VCHIQ_SERVICE_STATS_ADD(service, bulk_tx_bytes,
+						bulk->actual);
+		} else {
+			VCHIQ_SERVICE_STATS_INC(service, bulk_rx_count);
+			VCHIQ_SERVICE_STATS_ADD(service, bulk_rx_bytes,
+						bulk->actual);
+				}
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
+
+		status = 0;
+	} else if (bulk->mode == VCHIQ_BULK_MODE_CALLBACK) {
+		enum vchiq_reason reason = get_bulk_reason(bulk);
+		status = make_service_callback(service, reason,	NULL,
+					       bulk->userdata);
+	}
+
+	return status;
+}
+
 /* Called by the slot handler - don't hold the bulk mutex */
 static int
 notify_bulks(struct vchiq_service *service, struct vchiq_bulk_queue *queue,
@@ -1333,37 +1376,9 @@ notify_bulks(struct vchiq_service *service, struct vchiq_bulk_queue *queue,
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


