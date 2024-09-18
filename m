Return-Path: <linux-kernel+bounces-332813-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2C7B97BF26
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 18:32:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F3E92837D4
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 16:32:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E34C1CA68C;
	Wed, 18 Sep 2024 16:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="WO6bIGq4"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03ACF1C9EB2
	for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 16:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726677109; cv=none; b=tSvWPeXpMtE3szAkHdUAqUO5rG+xoaeUAJ8cghGcmfozS3fE9Cw1dUcCuZ5ELJT13ZLLPz823CYN3rlmpEj9M+5e25i9o+XP8DDsHszY9YS6L639nzAvoHgzrPSKTPW3bfiB7n5hduUnYxysM2iuY9t11qtg9BR6AUDd5n0A0Tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726677109; c=relaxed/simple;
	bh=IOIPt9AVMml8XUc4ADrmjHxDtvBlrA5jWwdoFYKT1j8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XlwPI2b4rkyxW4Rqw/IKLQVFiYXeTOb4VjeAz48L3dH2vShRpj+pRH889xWyW7w+AiPxMZRrDw8v9Q23PGinu3knIa/HIjJtn8fhP+pASmsVjDjVULZ4zjyoXPTNk17stp0i7s/4YSus6eQSv2noNET/LmlG3G8u5de8RjaNGrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=WO6bIGq4; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from umang.jain (unknown [IPv6:2405:201:2015:f873:55d7:c02e:b2eb:ee3f])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id BD3061111;
	Wed, 18 Sep 2024 18:30:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1726677018;
	bh=IOIPt9AVMml8XUc4ADrmjHxDtvBlrA5jWwdoFYKT1j8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WO6bIGq4fR5ZldqhBYs6Ls+o5SqReFrjaP2h+rL1LcG0A0j8GOLHk+HFPa3rH0iyA
	 16OyiobEWGWMyUJd47BdWJef2OxlhaY5F+w7qE6m0xKT7Cf7Dt0cO80fkMRt8UP7wU
	 A22+zX4seVKssMZCrJR3IDwhZRE+pi79n9vez4wY=
From: Umang Jain <umang.jain@ideasonboard.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
Cc: linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Kieran Bingham <kieran.bingham@ideasonboard.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Stefan Wahren <wahrenst@gmx.net>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Nicolas Saenz Julienne <nsaenz@kernel.org>,
	Umang Jain <umang.jain@ideasonboard.com>
Subject: [PATCH 4/6] staging: vchiq_core: Return -EINTR when bulk transfers are interrupted
Date: Wed, 18 Sep 2024 22:00:58 +0530
Message-ID: <20240918163100.870596-5-umang.jain@ideasonboard.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240918163100.870596-1-umang.jain@ideasonboard.com>
References: <20240918163100.870596-1-umang.jain@ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Bulk transfers for various VCHIQ modes use mutex_lock_killable() and
wait_for_completion_killable() variations. Currently, -EAGAIN is
returned if these are interrupted by a fatal signal.

-EAGAIN may mislead the caller into thinking the operation can be
retried, while in reality, the process has received a fatal signal
and is terminating. Therefore, we should update the return value to
align with what these killable functions would return, specifically
-EINTR (Interrupted system call).

Signed-off-by: Umang Jain <umang.jain@ideasonboard.com>
---
 .../vc04_services/interface/vchiq_arm/vchiq_arm.c    |  8 ++++----
 .../vc04_services/interface/vchiq_arm/vchiq_core.c   | 12 ++++++------
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
index 661b3a9a8280..d5b23f3fee87 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
@@ -870,11 +870,11 @@ vchiq_bulk_transmit(struct vchiq_instance *instance, unsigned int handle, const
 		}
 
 		/*
-		 * vchiq_*_bulk_transfer() may return -EAGAIN, so we need
+		 * vchiq_*_bulk_transfer() may return -EINTR, so we need
 		 * to implement a retry mechanism since this function is
 		 * supposed to block until queued
 		 */
-		if (ret != -EAGAIN)
+		if (ret != -EINTR)
 			break;
 
 		msleep(1);
@@ -906,11 +906,11 @@ int vchiq_bulk_receive(struct vchiq_instance *instance, unsigned int handle,
 		}
 
 		/*
-		 * vchiq_*_bulk_transfer() may return -EAGAIN, so we need
+		 * vchiq_*_bulk_transfer() may return -EINTR, so we need
 		 * to implement a retry mechanism since this function is
 		 * supposed to block until queued
 		 */
-		if (ret != -EAGAIN)
+		if (ret != -EINTR)
 			break;
 
 		msleep(1);
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
index d7b22e37c2ff..426e729b71ee 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
@@ -2689,16 +2689,16 @@ vchiq_bulk_xfer_queue_msg_killable(struct vchiq_service *service,
 		&service->bulk_tx : &service->bulk_rx;
 
 	if (mutex_lock_killable(&service->bulk_mutex))
-		return -EAGAIN;
+		return -EINTR;
 
 	if (queue->local_insert == queue->remove + VCHIQ_NUM_SERVICE_BULKS) {
 		VCHIQ_SERVICE_STATS_INC(service, bulk_stalls);
 		do {
 			mutex_unlock(&service->bulk_mutex);
 			if (wait_for_completion_killable(&service->bulk_remove_event))
-				return -EAGAIN;
+				return -EINTR;
 			if (mutex_lock_killable(&service->bulk_mutex))
-				return -EAGAIN;
+				return -EINTR;
 		} while (queue->local_insert == queue->remove +
 				VCHIQ_NUM_SERVICE_BULKS);
 	}
@@ -2729,7 +2729,7 @@ vchiq_bulk_xfer_queue_msg_killable(struct vchiq_service *service,
 	 * claim it here to ensure that isn't happening
 	 */
 	if (mutex_lock_killable(&state->slot_mutex)) {
-		status = -EAGAIN;
+		status = -EINTR;
 		goto cancel_bulk_error_exit;
 	}
 
@@ -2764,7 +2764,7 @@ vchiq_bulk_xfer_queue_msg_killable(struct vchiq_service *service,
         if (bulk_waiter) {
                 bulk_waiter->bulk = bulk;
 		if (wait_for_completion_killable(&bulk_waiter->event))
-                        status = -EAGAIN;
+			status = -EINTR;
                 else if (bulk_waiter->actual == VCHIQ_BULK_ACTUAL_ABORTED)
                         status = -EINVAL;
         }
@@ -3203,7 +3203,7 @@ vchiq_bulk_xfer_waiting(struct vchiq_instance *instance,
 	status = 0;
 
 	if (wait_for_completion_killable(&bulk_waiter->event))
-		return -EAGAIN;
+		return -EINTR;
 	else if (bulk_waiter->actual == VCHIQ_BULK_ACTUAL_ABORTED)
 		return -EINVAL;
 
-- 
2.45.2


