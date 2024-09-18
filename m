Return-Path: <linux-kernel+bounces-332814-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E12597BF27
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 18:32:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5BB511C21A33
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 16:32:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 538BC1CA686;
	Wed, 18 Sep 2024 16:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="IDzWrYTJ"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36CC31C9EB6
	for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 16:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726677109; cv=none; b=edA7n6mlcW034VEuzlp/BLLEoV0vsuYFCcCB7FUc8g/ylUVc1btLvEr/qpNYzlUnZL2R71HIIh7F1xYeq/FAnwD7dL92Z78G4lbKWtwZ9myqbQ7gH/OTfpMQO979yCFYYnZYCpPVDRLMgIs8rALlO5G6Qrk3qcg/fHEnQ6CHhDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726677109; c=relaxed/simple;
	bh=349glJfpIeTFW2mCeCBwQ4Qkx92zWKGbpqqM1CAa22U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GAUbffggkd4+X81KVJJAdcAg3PXsvavKsnrvtNmNKJFu7nG+BXoZdJPIkoWZkIpnvnwZ7Mls68MnAFAVfPQG3ADB6ZO3qaUoBdzWgVM0h3SSdbG1DKND2ATdIcmQGCrNOpqy6GmjH7x3pZ6ryhckJjsPRQCN1ieh0tA2vIsBL9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=IDzWrYTJ; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from umang.jain (unknown [IPv6:2405:201:2015:f873:55d7:c02e:b2eb:ee3f])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 0B8D4173E;
	Wed, 18 Sep 2024 18:30:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1726677020;
	bh=349glJfpIeTFW2mCeCBwQ4Qkx92zWKGbpqqM1CAa22U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IDzWrYTJJy9RoAMynBQb678LUOaxzzLNT8O6pIymYX4FFer/09cXoVxjYd/X3y6zs
	 qQJvHJuzFPk8tnb3q7MKiF1/7sbwHEIB/NQ0qQEW1CvB4M1U2uuysY+1vV5u0QbE2c
	 4fEBhMqVt3gOXSVFPVb7AymBJ5IfsKG0F85cRmiw=
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
Subject: [PATCH 5/6] staging: vchiq_arm: Do not retry bulk transfers on -EINTR
Date: Wed, 18 Sep 2024 22:00:59 +0530
Message-ID: <20240918163100.870596-6-umang.jain@ideasonboard.com>
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

-EINTR is returned by various vchiq bulk transfer code paths
on receiving a fatal signal to the process. Since the process is
deemed to be terminated anyway, do not retry the bulk transfer
on -EINTR.

Signed-off-by: Umang Jain <umang.jain@ideasonboard.com>
---
 .../interface/vchiq_arm/vchiq_arm.c           | 74 +++++++------------
 1 file changed, 25 insertions(+), 49 deletions(-)

diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
index d5b23f3fee87..c44b4dc79c03 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
@@ -853,31 +853,19 @@ vchiq_bulk_transmit(struct vchiq_instance *instance, unsigned int handle, const
 {
 	int ret;
 
-	while (1) {
-		switch (mode) {
-		case VCHIQ_BULK_MODE_NOCALLBACK:
-		case VCHIQ_BULK_MODE_CALLBACK:
-			ret = vchiq_bulk_xfer_callback(instance, handle, (void *)data,
-						       NULL, size, mode, userdata,
-						       VCHIQ_BULK_TRANSMIT);
-			break;
-		case VCHIQ_BULK_MODE_BLOCKING:
-			ret = vchiq_blocking_bulk_transfer(instance, handle, (void *)data, size,
-							   VCHIQ_BULK_TRANSMIT);
-			break;
-		default:
-			return -EINVAL;
-		}
-
-		/*
-		 * vchiq_*_bulk_transfer() may return -EINTR, so we need
-		 * to implement a retry mechanism since this function is
-		 * supposed to block until queued
-		 */
-		if (ret != -EINTR)
-			break;
-
-		msleep(1);
+	switch (mode) {
+	case VCHIQ_BULK_MODE_NOCALLBACK:
+	case VCHIQ_BULK_MODE_CALLBACK:
+		ret = vchiq_bulk_xfer_callback(instance, handle, (void *)data,
+					       NULL, size, mode, userdata,
+					       VCHIQ_BULK_TRANSMIT);
+		break;
+	case VCHIQ_BULK_MODE_BLOCKING:
+		ret = vchiq_blocking_bulk_transfer(instance, handle, (void *)data, size,
+						   VCHIQ_BULK_TRANSMIT);
+		break;
+	default:
+		return -EINVAL;
 	}
 
 	return ret;
@@ -890,30 +878,18 @@ int vchiq_bulk_receive(struct vchiq_instance *instance, unsigned int handle,
 {
 	int ret;
 
-	while (1) {
-		switch (mode) {
-		case VCHIQ_BULK_MODE_NOCALLBACK:
-		case VCHIQ_BULK_MODE_CALLBACK:
-			ret = vchiq_bulk_xfer_callback(instance, handle, (void *)data, NULL,
-						       size, mode, userdata, VCHIQ_BULK_RECEIVE);
-			break;
-		case VCHIQ_BULK_MODE_BLOCKING:
-			ret = vchiq_blocking_bulk_transfer(instance, handle, (void *)data, size,
-							   VCHIQ_BULK_RECEIVE);
-			break;
-		default:
-			return -EINVAL;
-		}
-
-		/*
-		 * vchiq_*_bulk_transfer() may return -EINTR, so we need
-		 * to implement a retry mechanism since this function is
-		 * supposed to block until queued
-		 */
-		if (ret != -EINTR)
-			break;
-
-		msleep(1);
+	switch (mode) {
+	case VCHIQ_BULK_MODE_NOCALLBACK:
+	case VCHIQ_BULK_MODE_CALLBACK:
+		ret = vchiq_bulk_xfer_callback(instance, handle, (void *)data, NULL,
+					       size, mode, userdata, VCHIQ_BULK_RECEIVE);
+		break;
+	case VCHIQ_BULK_MODE_BLOCKING:
+		ret = vchiq_blocking_bulk_transfer(instance, handle, (void *)data, size,
+						   VCHIQ_BULK_RECEIVE);
+		break;
+	default:
+		return -EINVAL;
 	}
 
 	return ret;
-- 
2.45.2


