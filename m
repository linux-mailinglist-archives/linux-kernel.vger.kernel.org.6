Return-Path: <linux-kernel+bounces-377913-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C4B179AC87F
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 13:06:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C4581F21268
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 11:06:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE6D81A7AC7;
	Wed, 23 Oct 2024 11:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="qM2MTKsW"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B18A01AB6C7
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 11:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729681498; cv=none; b=FTGXLHVSc6K2kvsZv3HJtxo6wImYFpmtGLlRkDg7TCMumzWqpaewqUYYgYmADCfl7EWbXANdlMkb0GEtgt9Ovs4SUTbVBqqYrWSr6dpu6kSkMGoiDV5XiRZwQ1FaCUsSQQZpcdAbXQi9w98vCovcuwzEGB6VbcIYA2AaNuBIvaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729681498; c=relaxed/simple;
	bh=fvlat9AHEEDf8cSpGbz1hc5d3oS8Gf8tdHnvlCW1ce8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iz0xUwqGpplAOPh8MkMgucUiBY6Sc46v6mhgoFcgKB1tJ8Xy3fMmjGj8Q+LsvuL5H2D+zdJgb1MZkIp5Jl32iQ81gttkhhS9cqX9vTGN1hjRBMjyKdvMOokoogoIMcmHzu/uTfp9UY9xumXsRYGj5cXqHfce2GSrKci8WY8/Iuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=qM2MTKsW; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from umang.jain (unknown [IPv6:2405:201:2015:f873:55d7:c02e:b2eb:ee3f])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 076709FC;
	Wed, 23 Oct 2024 13:03:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1729681387;
	bh=fvlat9AHEEDf8cSpGbz1hc5d3oS8Gf8tdHnvlCW1ce8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qM2MTKsWBIq5UwKpFip16eKxS29ok1aao6A1BS4GeXxgZSiz9Wim9gpWqfsrkzQDb
	 QGioOTRQbxHKQkIkEqDUbjQJ6n+skq1Wm2X61T379uXvFyjLar+6fUGGkB6XFcI9KT
	 MN7ITKrXxZvSTlmS9LVTQgoDL+4FYKG8AmndkRZo=
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
Subject: [PATCH 5/6] staging: vchiq_core: Pass vchiq_bulk pointer to make_service_callback()
Date: Wed, 23 Oct 2024 16:34:05 +0530
Message-ID: <20241023110406.885199-6-umang.jain@ideasonboard.com>
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

Pass struct vchiq_bulk pointer to make_service_callback() instead of
just passing the bulk->cb_data. This is a preparatory change when we
need to pass the callback data user pointer (__user) in a subsequent
commit.

Signed-off-by: Umang Jain <umang.jain@ideasonboard.com>
---
 .../vc04_services/interface/vchiq_arm/vchiq_core.c  | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
index 6095adaf0cf6..3c811b8f210c 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
@@ -455,10 +455,18 @@ mark_service_closing(struct vchiq_service *service)
 
 static inline int
 make_service_callback(struct vchiq_service *service, enum vchiq_reason reason,
-		      struct vchiq_header *header, void *cb_data)
+		      struct vchiq_header *header, struct vchiq_bulk *bulk)
 {
+	void *cb_data = NULL;
 	int status;
 
+	/*
+	 * If a bulk transfer is in progress, pass bulk->cb_data to the
+	 * callback function.
+	 */
+	if (bulk)
+		cb_data = bulk->cb_data;
+
 	dev_dbg(service->state->dev, "core: %d: callback:%d (%s, %pK, %pK)\n",
 		service->state->id, service->localport, reason_names[reason],
 		header, cb_data);
@@ -1339,8 +1347,7 @@ static int service_notify_bulk(struct vchiq_service *service,
 	} else if (bulk->mode == VCHIQ_BULK_MODE_CALLBACK) {
 		enum vchiq_reason reason = get_bulk_reason(bulk);
 
-		return make_service_callback(service, reason, NULL,
-					     bulk->cb_data);
+		return make_service_callback(service, reason, NULL, bulk);
 	}
 
 	return 0;
-- 
2.45.2


