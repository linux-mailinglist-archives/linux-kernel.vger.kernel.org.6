Return-Path: <linux-kernel+bounces-361103-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 741A699A372
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 14:10:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E9A5AB2508F
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 12:10:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F956218581;
	Fri, 11 Oct 2024 12:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="cahST3Yt"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DED921733B
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 12:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728648627; cv=none; b=ZuRNyEaQwcXDzJiqVudPT2y8cKWm0PnvDoDftM5SpNsZY5g4bDYHwpQMJuoRosomyAs/jc/WAL5SX1wDqtv0dUQQpBiS0M1tU3xEzJjdihrt7M123SbvJNxpeHGxOLn/GEAtPb28d4CrUXUzkxtaBavSj8GbVog7gVDW6L3usUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728648627; c=relaxed/simple;
	bh=WBqPaPeDJDpOXJCYWiEMmcPkk6BJUzfDh0i0SctEqUQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IS60iSmiI8KEApVfmMfCtvcb0Zely/YhstYS/eh9/N2+SMwZXH4GVjeLqzjUqgWX8tj33iXYg7U+BjvGeJ9/MyiAjpNsP/vjjT2tvVz240d1/jSxspNGmeOXp/KLjCfVZYQTOTs+35oNYGJm+IcmQhu9LJ1ndumCR8wVHRjr+88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=cahST3Yt; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from umang.jain (unknown [IPv6:2405:201:2015:f873:55d7:c02e:b2eb:ee3f])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 04FABD8B;
	Fri, 11 Oct 2024 14:08:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1728648526;
	bh=WBqPaPeDJDpOXJCYWiEMmcPkk6BJUzfDh0i0SctEqUQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cahST3YtkY1BxWTrohz9PNGvVxR/kKsj35FE0zk/Hn3/RjOOQxTtzWPjiRp3p73v9
	 FJpvhB6iKw8ruuaGfEy+LVtgxGCw0JnFtvQtHDGhGGZNNcxHGjstz8fKEX8oilh0Wt
	 a/sXZSPRqC7ImIJOeZqZdKBUWRDfA484yp9qYs44=
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
Subject: [PATCH v2 2/6] staging: vchiq_core: Do not log debug in a separate scope
Date: Fri, 11 Oct 2024 17:39:06 +0530
Message-ID: <20241011120910.74045-3-umang.jain@ideasonboard.com>
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

Do not log a dev_dbg() with a separate scope. Drop the {..}
scope and align the dev_dbg() to make it more readable.

No functional changes intended in this patch.

Signed-off-by: Umang Jain <umang.jain@ideasonboard.com>
Reviewed-by: Stefan Wahren <wahrenst@gmx.net>
---
 .../interface/vchiq_arm/vchiq_core.c            | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
index e9b60dd8d419..0324dfe59dca 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
@@ -936,6 +936,7 @@ queue_message(struct vchiq_state *state, struct vchiq_service *service,
 	struct vchiq_service_quota *quota = NULL;
 	struct vchiq_header *header;
 	int type = VCHIQ_MSG_TYPE(msgid);
+	int svc_fourcc;
 
 	size_t stride;
 
@@ -1128,17 +1129,13 @@ queue_message(struct vchiq_state *state, struct vchiq_service *service,
 	header->msgid = msgid;
 	header->size = size;
 
-	{
-		int svc_fourcc;
-
-		svc_fourcc = service
-			? service->base.fourcc
-			: VCHIQ_MAKE_FOURCC('?', '?', '?', '?');
+	svc_fourcc = service ? service->base.fourcc
+			     : VCHIQ_MAKE_FOURCC('?', '?', '?', '?');
 
-		dev_dbg(state->dev, "core_msg: Sent Msg %s(%u) to %p4cc s:%u d:%d len:%zu\n",
-			msg_type_str(VCHIQ_MSG_TYPE(msgid)), VCHIQ_MSG_TYPE(msgid),
-			&svc_fourcc, VCHIQ_MSG_SRCPORT(msgid), VCHIQ_MSG_DSTPORT(msgid), size);
-	}
+	dev_dbg(state->dev, "core_msg: Sent Msg %s(%u) to %p4cc s:%u d:%d len:%zu\n",
+		msg_type_str(VCHIQ_MSG_TYPE(msgid)),
+		VCHIQ_MSG_TYPE(msgid), &svc_fourcc,
+		VCHIQ_MSG_SRCPORT(msgid), VCHIQ_MSG_DSTPORT(msgid), size);
 
 	/* Make sure the new header is visible to the peer. */
 	wmb();
-- 
2.45.2


