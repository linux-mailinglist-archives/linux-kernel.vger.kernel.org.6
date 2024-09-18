Return-Path: <linux-kernel+bounces-332812-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F7DC97BF25
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 18:32:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24FB21F22031
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 16:32:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49E771C9DFA;
	Wed, 18 Sep 2024 16:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="O2aULEyI"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B23E91C9872
	for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 16:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726677106; cv=none; b=tGfs3mkYzh8iiCzUTI1pglj6MCUnsDO52+SkJe3u7m+KyYeIuHdqvd6lefAQStEHtatbCnZ3JDLn5DwCf0iMudZ3tzZT7yYmmxcXTW66cxUGmGXR1tlNw3juBP1vkNMYI6YT8tOuNbtrOnz9R1YcVb4Huxcp3te24acDOgcjW8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726677106; c=relaxed/simple;
	bh=sHrmkv7qdL/VGUyX+8A53+Ph6+f7Wq5flFy4YcSlqf0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GyMLxLEVMdgznRsa/hmSo/qZg/XoFWF0NWuHFYUOudFG/jAGAcqDsb0lE+qAMn1l1eG3i4M54Eyh993ZPnsPZAyNSYUlwctyIB47X7z3qNEzcIYQM001Ayf1z2aOz6CQMKrO04sVXHhN558HIy4AKiBeVxmf5tD/oqtbbJvOonM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=O2aULEyI; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from umang.jain (unknown [IPv6:2405:201:2015:f873:55d7:c02e:b2eb:ee3f])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id DC194593;
	Wed, 18 Sep 2024 18:30:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1726677013;
	bh=sHrmkv7qdL/VGUyX+8A53+Ph6+f7Wq5flFy4YcSlqf0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=O2aULEyIGBmK0xBduyXBqZiu5uggYc7cDcj+2oqnmqG0u7cTYbVAYILxKb9T13LzC
	 dlpumv/jOYknAem5RAKbpRhLXZ4bvFib6Nv3ooT364tdMPxj8BQdjeZ26/lkPVqand
	 AGTCqW0/K8/0eM7yU0SuRgFweyQmEpen8PrJCRpY=
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
Subject: [PATCH 2/6] staging: vchiq_core: Return on all errors from queue_message()
Date: Wed, 18 Sep 2024 22:00:56 +0530
Message-ID: <20240918163100.870596-3-umang.jain@ideasonboard.com>
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

In vchiq_connect_internal(), a MAKE_CONNECT message is queued
if the connection is disconnected, but only -EAGAIN error is
checked on the error path and returned.

However, queue_message() can fail with other errors as well hence,
vchiq_connect_internal() should return in those cases as well.

Signed-off-by: Umang Jain <umang.jain@ideasonboard.com>
---
 .../vc04_services/interface/vchiq_arm/vchiq_core.c     | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
index a381a633d3d5..4279dd182a98 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
@@ -2945,6 +2945,7 @@ int
 vchiq_connect_internal(struct vchiq_state *state, struct vchiq_instance *instance)
 {
 	struct vchiq_service *service;
+	int status = 0;
 	int i;
 
 	/* Find all services registered to this client and enable them. */
@@ -2956,9 +2957,10 @@ vchiq_connect_internal(struct vchiq_state *state, struct vchiq_instance *instanc
 	}
 
 	if (state->conn_state == VCHIQ_CONNSTATE_DISCONNECTED) {
-		if (queue_message(state, NULL, MAKE_CONNECT, NULL, NULL, 0,
-				  QMFLAGS_IS_BLOCKING) == -EAGAIN)
-			return -EAGAIN;
+		status = queue_message(state, NULL, MAKE_CONNECT, NULL, NULL, 0,
+				       QMFLAGS_IS_BLOCKING);
+		if (status)
+			return status;
 
 		vchiq_set_conn_state(state, VCHIQ_CONNSTATE_CONNECTING);
 	}
@@ -2971,7 +2973,7 @@ vchiq_connect_internal(struct vchiq_state *state, struct vchiq_instance *instanc
 		complete(&state->connect);
 	}
 
-	return 0;
+	return status;
 }
 
 void
-- 
2.45.2


