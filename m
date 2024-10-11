Return-Path: <linux-kernel+bounces-360648-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0355D999DC0
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 09:22:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A119A1F23711
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 07:22:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1A0C209690;
	Fri, 11 Oct 2024 07:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="sk8bw1jm"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CA67209F28
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 07:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728631366; cv=none; b=GglGPAYsLe+RbZ6PKYBpdqpFsZO1muaWFgxYJ5WXrJLxEp4udvbwBm8mHM6DmIBWf7jWVaz+MAF25w+m75Ttnz9ezOC8720EOdbCgGQhjcn5HibXJ/5JZl8a10395Hyx/By9cCW5ocSFP14x0IMwq+jkOm6INX8VBp3Y1fE/kb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728631366; c=relaxed/simple;
	bh=xD3T27aSbZGVWM3LeK6ZydUsioF47rQqpXbA99qZANY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VQOUdFh+tEDBM+XWbxWc9IxJTrtbWX3oZdX5eBUWO4Uvj5sjjyQHVsAUXBGSE2GtZnI1j24wUlHaivMqxiOBQayYDD/4C/KHC593wqcGaV8W7AJj9a/JRRnnfv/IkIX6FbzSY/2+ZC/5Ph5TssQFjMJ+yURbOUohSktRFoULClo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=sk8bw1jm; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from umang.jain (unknown [IPv6:2405:201:2015:f873:55d7:c02e:b2eb:ee3f])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 1E0CAD8B;
	Fri, 11 Oct 2024 09:21:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1728631263;
	bh=xD3T27aSbZGVWM3LeK6ZydUsioF47rQqpXbA99qZANY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sk8bw1jmvxjhrc5iEPBuJhwkTPZOY32VV1NqZUihD47hreLaGLG48vSNWpVoBoz0u
	 Kh6a7b9erjNZn8+N6WUvblXBXdOxiLezxeZdJZTzny7pvY050GL5GCdKFaVe6vaUpa
	 S8ajAIaNM11ixccxHb0ItwHYWmXW+slhjyPxtCec=
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
Subject: [PATCH 2/8] staging: vchiq_core: Properly log dev_err()
Date: Fri, 11 Oct 2024 12:52:04 +0530
Message-ID: <20241011072210.494672-3-umang.jain@ideasonboard.com>
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

Properly log a dev_err() message when the msgid is not of
VCHIQ_MSG_PADDING type. Drop 'oldmsgid' scoped variable and improve
on the error string as well.

Signed-off-by: Umang Jain <umang.jain@ideasonboard.com>
---
 .../vc04_services/interface/vchiq_arm/vchiq_core.c    | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
index e9b60dd8d419..1dca676186b6 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
@@ -1188,13 +1188,10 @@ queue_message_sync(struct vchiq_state *state, struct vchiq_service *service,
 	header = (struct vchiq_header *)SLOT_DATA_FROM_INDEX(state,
 		local->slot_sync);
 
-	{
-		int oldmsgid = header->msgid;
-
-		if (oldmsgid != VCHIQ_MSGID_PADDING)
-			dev_err(state->dev, "core: %d: qms - msgid %x, not PADDING\n",
-				state->id, oldmsgid);
-	}
+	if (header->msgid != VCHIQ_MSGID_PADDING)
+		dev_err(state->dev,
+			"core: %d: qms - msgid %x, is not a PADDING message\n",
+			state->id, header->msgid);
 
 	dev_dbg(state->dev, "sync: %d: qms %s@%pK,%x (%d->%d)\n",
 		state->id, msg_type_str(VCHIQ_MSG_TYPE(msgid)), header, size,
-- 
2.45.2


