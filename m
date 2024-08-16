Return-Path: <linux-kernel+bounces-289690-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69913954A62
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 14:57:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C88D1C24042
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 12:57:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDF1E1BA86D;
	Fri, 16 Aug 2024 12:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hoSU6OV8"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBCD11B9B33
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 12:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723813023; cv=none; b=EH5Kypb+aoxo3iQ/HdmCKjyijPdojdSBsr3qdUGQA5gawU9akRsndJ3LgKGMQPsbwg608cfQf4dPr1EiE9c3txp77Q09SMAq8Vf+YM+ncNwbpWFlBS8JT/Ui2bkALeo6Scvvi8cT1uv2VDNXZw2dszM5NBTtBlsUApVszt1pOQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723813023; c=relaxed/simple;
	bh=Yx+lLUigl+dUu2UU0/svEZlNB+jQA9BbPVs9uyA75JU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Th9j9ir3PXuyDepn64BBKapGt4jAapgSAc26rJBCUX2tTnWkwuaho0ny8V0WLV8U/fySOLOi+KCOKMeFynOeLHuBwduezRPeZ1ATxszgYs9SNltsHSh1g2i7vfOch0bO1tqrAiHZ3nJJ9pUhD8FlFbptIMP82CDEUmKNreYU7FA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hoSU6OV8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723813020;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nA2fhJxmDHNUaunZRJWh3bds0Bd+LjK0XRFUieOvKyc=;
	b=hoSU6OV8OJgaxkE1RrwbtVHMIFgSQs2uHsM5e3pGQG7yukat2faQgPZqUcnx2PJdchZOxR
	JvIOhknLX56sE4iCD5oFt/j0F24iNCazfeB38XHtFrmGayJMOjr4vWkoZ+gCjido4Bgw+v
	mBQNLkqtYfhRwrsAqjO9dI0pG92POrE=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-160-ZXISmhc6M6uS0g20RoPHvw-1; Fri,
 16 Aug 2024 08:56:55 -0400
X-MC-Unique: ZXISmhc6M6uS0g20RoPHvw-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D455C1955BED;
	Fri, 16 Aug 2024 12:56:53 +0000 (UTC)
Received: from hydra.redhat.com (unknown [10.39.193.28])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 34BF91956048;
	Fri, 16 Aug 2024 12:56:49 +0000 (UTC)
From: Jocelyn Falempe <jfalempe@redhat.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	John Ogness <john.ogness@linutronix.de>,
	Javier Martinez Canillas <javierm@redhat.com>,
	"Guilherme G . Piccoli" <gpiccoli@igalia.com>,
	bluescreen_avenger@verizon.net,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Cc: Jocelyn Falempe <jfalempe@redhat.com>
Subject: [PATCH v2 4/5] drm/log: Do not draw if drm_master is taken
Date: Fri, 16 Aug 2024 14:52:36 +0200
Message-ID: <20240816125612.1003295-5-jfalempe@redhat.com>
In-Reply-To: <20240816125612.1003295-1-jfalempe@redhat.com>
References: <20240816125612.1003295-1-jfalempe@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

When userspace takes drm_master, the drm_client buffer is no more
visible, so drm_log shouldn't waste CPU cycle to draw on it.

Signed-off-by: Jocelyn Falempe <jfalempe@redhat.com>
---
 drivers/gpu/drm/drm_log.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/drm_log.c b/drivers/gpu/drm/drm_log.c
index 0739a4c72bb7..b94ce3ea48a0 100644
--- a/drivers/gpu/drm/drm_log.c
+++ b/drivers/gpu/drm/drm_log.c
@@ -22,6 +22,7 @@
 
 #include "drm_draw.h"
 #include "drm_log.h"
+#include "drm_internal.h"
 
 MODULE_AUTHOR("Jocelyn Falempe");
 MODULE_DESCRIPTION("DRM boot logger");
@@ -361,10 +362,15 @@ static bool drm_log_active_output(void)
 	bool active = false;
 
 	mutex_lock(&drm_log_lock);
-	list_for_each_entry(dclient, &drm_log_clients, head)
-		if (dclient->n_scanout || !dclient->probed)
-			active = true;
-
+	list_for_each_entry(dclient, &drm_log_clients, head) {
+		if (dclient->n_scanout || !dclient->probed) {
+			/* Also check that we are still the master */
+			if (drm_master_internal_acquire(dclient->client.dev)) {
+				drm_master_internal_release(dclient->client.dev);
+				active = true;
+			}
+		}
+	}
 	mutex_unlock(&drm_log_lock);
 	return active;
 }
-- 
2.46.0


