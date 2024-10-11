Return-Path: <linux-kernel+bounces-361105-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD66F99A376
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 14:11:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2AC51C221A3
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 12:11:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0063B21791B;
	Fri, 11 Oct 2024 12:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="PFBWefsC"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0979218D7F
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 12:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728648632; cv=none; b=iEu7iFdLOSY6aGWubZ3zdsBEJquDjlh5PtmMx5iGoQ3m9Yc2+1F0awE/B0KSVwbYu1LH+XTfcU/pEpYSI8UdlXzwp3laDYoeh2+x+CBT2bfl7+RpXrkNDwkc1gijfdAsG+4TSquNZpX2K7rvyNEIZy/xmCGqO0YJ7nPpmIE0qII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728648632; c=relaxed/simple;
	bh=01ajFvAti3hY90IDMC7z1QMppAuqhsOts5Y1hvRhhiE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qISobEiTQUiG4VCJzmNgRtD6dZTcU3rSbojh9TyiywovQiBwYotpwpr2t2+B08gXKdl5C9AWr/MDEWYxlexIqr3YFiwl0dS5laFuHltgPZT+8+nUFvCIzK41XjANE6B3nuOl1NZNCUSiRWpOozPhn9Ar9Gb5CfiHlTdS7xhfx3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=PFBWefsC; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from umang.jain (unknown [IPv6:2405:201:2015:f873:55d7:c02e:b2eb:ee3f])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id B5A328D4;
	Fri, 11 Oct 2024 14:08:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1728648530;
	bh=01ajFvAti3hY90IDMC7z1QMppAuqhsOts5Y1hvRhhiE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PFBWefsCxxHXpDkzJwngc0rFH5bOexpy6rQD/zs+78cXwIv6c0kuq3+EvIxn0EGb6
	 mrbeeJCWAp/RU4+sRgbqconFtU5ZA46NEYb9idiRrNj2dmIuZzyuecRq4a2fKws4qz
	 THB1fbvg95cblEnVoPDz74Iy9Hp51HUHO9+oerVE=
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
Subject: [PATCH v2 4/6] staging: vchiq_core: Refactor notify_bulks()
Date: Fri, 11 Oct 2024 17:39:08 +0530
Message-ID: <20241011120910.74045-5-umang.jain@ideasonboard.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241011120910.74045-1-umang.jain@ideasonboard.com>
References: <20241011120910.74045-1-umang.jain@ideasonboard.com>
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
 .../interface/vchiq_arm/vchiq_core.c          | 76 +++++++++++--------
 1 file changed, 45 insertions(+), 31 deletions(-)

diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
index e9cd012e2b5f..5509f8b1061a 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
@@ -1309,6 +1309,48 @@ get_bulk_reason(struct vchiq_bulk *bulk)
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
+
+		spin_unlock(&service->state->bulk_waiter_spinlock);
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
@@ -1333,37 +1375,9 @@ notify_bulks(struct vchiq_service *service, struct vchiq_bulk_queue *queue,
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


