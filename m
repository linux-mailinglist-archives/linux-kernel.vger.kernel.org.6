Return-Path: <linux-kernel+bounces-332815-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DEDD97BF28
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 18:33:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 139361F22044
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 16:33:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 041DD1C9EB2;
	Wed, 18 Sep 2024 16:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="TRGAXEFQ"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0C2C189F47
	for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 16:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726677112; cv=none; b=NCrKNfnuwj/o10M66xCShX1S2KxRT7lgMqFfqh1x2RQvsVZFj4xO5BQCOPWBWU5Sx+6odZeheZmUZtFXBivBHDQeayMQwMRdgzrwMBzvrRoYr8/lGosHA/Zn6Na3fwtxtdC81AsWomjihqfEl/EAn3Gmpb+ndhdoyMsq4pMzuI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726677112; c=relaxed/simple;
	bh=Gve0uMYsv6ZYvapmFb9XKu322dhAffKigvnNzUNpz/w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uSpwKdnd/LqN1K0tufSK8NDzjXyCReKI3hfxb2E02gYBZwiHrMzayWMQlOMAsnrzcldFO0GU7t2dwHFG0eCkatXz75kW7pBnS2Mz0YtUY/WnJyY6JRVW9jErucTfzN71oKAlX4r43q57u/aK4dVV2eRAepy1wEOkmjn8im0u9mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=TRGAXEFQ; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from umang.jain (unknown [IPv6:2405:201:2015:f873:55d7:c02e:b2eb:ee3f])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 4DAE9D52;
	Wed, 18 Sep 2024 18:30:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1726677023;
	bh=Gve0uMYsv6ZYvapmFb9XKu322dhAffKigvnNzUNpz/w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TRGAXEFQUU/4iV+pRTWVna2lvwGjEvRRvcpZ+p3jwT0Ej651GsbIzfkgc/9aF33uc
	 3zt5TTtFAJ11NdTpewbfoJ/WpifHPNnWmW4lCPyVsLfTb5MdCblz1ia7kzEJ7s59/K
	 7CmTChUuZVQng2reLs1IbCGeb3XFotvod8VErK0Q=
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
Subject: [PATCH 6/6] staging: vchiq_core: Drop retry loop on -EINTR
Date: Wed, 18 Sep 2024 22:01:00 +0530
Message-ID: <20240918163100.870596-7-umang.jain@ideasonboard.com>
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

-EINTR is returned by vchiq_queue_message() on receiving a fatal
signal to the process. Since the process is deemed to be terminated
anyway, do not retry queuing with vchiq_queue_message() on -EINTR.

Signed-off-by: Umang Jain <umang.jain@ideasonboard.com>
---
 .../interface/vchiq_arm/vchiq_core.c          | 19 ++-----------------
 1 file changed, 2 insertions(+), 17 deletions(-)

diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
index 426e729b71ee..7ad43a3d1bab 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
@@ -3269,24 +3269,9 @@ vchiq_queue_message(struct vchiq_instance *instance, unsigned int handle,
 int vchiq_queue_kernel_message(struct vchiq_instance *instance, unsigned int handle, void *data,
 			       unsigned int size)
 {
-	int status;
-
-	while (1) {
-		status = vchiq_queue_message(instance, handle, memcpy_copy_callback,
-					     data, size);
-
-		/*
-		 * vchiq_queue_message() may return -EINTR, so we need to
-		 * implement a retry mechanism since this function is supposed
-		 * to block until queued
-		 */
-		if (status != -EINTR)
-			break;
 
-		msleep(1);
-	}
-
-	return status;
+	return vchiq_queue_message(instance, handle, memcpy_copy_callback,
+				   data, size);
 }
 EXPORT_SYMBOL(vchiq_queue_kernel_message);
 
-- 
2.45.2


