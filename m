Return-Path: <linux-kernel+bounces-360649-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FA03999DC1
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 09:23:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44F401C217C0
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 07:23:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9539920A5C9;
	Fri, 11 Oct 2024 07:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="hwZeJGMN"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EC68209686
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 07:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728631368; cv=none; b=HB3JE8ZwOSDr0Ymq4avUId7MJWH2QHOdsXVMW7Wx+dA5+eqcz3Yx+pXMiQiFq4boghYHhcmBcnX51mbs2aHTlUehkZwBieFPSkx0ZiwDiu6MvW0XKvFD4Hia3DwzEw4a/vHAC2afclXwfpSCnCifMbSYWft5chB3ZmzFQ1Ubq7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728631368; c=relaxed/simple;
	bh=2r8iDPbU33zt3eyRnDjAEsNRDwFTo3MDsTAsUAMhUPk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ALWcpyp0k4w2k2JwQ7MScbpy2Vk2lYK072b7RDkTg9OQ8kgJP7G+bcoL1KJM8xiuFXAuTQOGCdCJNwffI2l6TD4SmkxlA/SXRSt4S4XpBCG2d069MxW2xvohp1/ov8xJlIHYPIkv0THLgarBYSaU2LFUMZKOr+lWMshueySEaBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=hwZeJGMN; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from umang.jain (unknown [IPv6:2405:201:2015:f873:55d7:c02e:b2eb:ee3f])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 379931659;
	Fri, 11 Oct 2024 09:21:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1728631266;
	bh=2r8iDPbU33zt3eyRnDjAEsNRDwFTo3MDsTAsUAMhUPk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hwZeJGMNYQeb58MTevyGN9pnCW3RkDcTGvRNQ2CXVRbFU4+oNqk1PCIxed2v0S4Pe
	 2K28W2ikC29pWZd5vNenvXN4uPgzJgsLnky+0B8/FuyiTRBJfyBOGnwf/tB/mEV4Bq
	 V49E4eIkxw/iqNC1rDXspc6dNUfJu8b9xSagFoo4=
From: Umang Jain <umang.jain@ideasonboard.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
Cc: linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Kieran Bingham <kieran.bingham@ideasonboard.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Stefan Wahren <wahrenst@gmx.net>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Umang Jain <umang.jain@ideasonboard.com>
Subject: [PATCH 3/8] staging: vchiq_core: Do not log debug in a separate scope
Date: Fri, 11 Oct 2024 12:52:05 +0530
Message-ID: <20241011072210.494672-4-umang.jain@ideasonboard.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241011072210.494672-1-umang.jain@ideasonboard.com>
References: <20241011072210.494672-1-umang.jain@ideasonboard.com>
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
---
 .../interface/vchiq_arm/vchiq_core.c            | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
index 1dca676186b6..15257cf66fa4 100644
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


