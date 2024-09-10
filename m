Return-Path: <linux-kernel+bounces-322523-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ED81972A42
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 09:09:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1D181C2415F
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 07:09:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B03CA17E009;
	Tue, 10 Sep 2024 07:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aDZyCkTb"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E9A517DFE0
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 07:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725952102; cv=none; b=tMOai1hbxJ3DlsBnOVDGkAK5AKteVYPBa2NYZtIKz2xkdQMh3atDptwKSaRmSNqI5FgVxirOWQkOU0SYUDf75XArGKq4MJNpE3rj91tFatMdCqMAlv/8QYgfLud68ACwjY53iXi0+bLsCstjOun5cWKq3wfVZMA3tFT0AIusgco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725952102; c=relaxed/simple;
	bh=RS53L4by8r/j0GTOvnC0/BKXEAvXK9m7F0HefnTie2w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uwcj1x9gnnH4KbzzC9EY18NTgHCJqaG07zaRG6Zy8NOSZ+crus8k8M5P5DBBD/guhEUyZrPxHNGBH+E8W+OTJf/SOOIj3yMAR3YLpynlYaXBjEk4CusaESvpaK/m7r7Py9UneCiW/qfYNsi8v0yFHBBJJZk9JCHyzQgZH/6YPlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aDZyCkTb; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725952099;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+qYqf8EV0qGoYbUfIBSC2thNukzxdmEJJY8VSs2kDz0=;
	b=aDZyCkTbuQBD2/cYIR0s0ohOYeWGSrBJJng+Ntj8d7HRFd3zjC+pHSXO3mhivUEXywL8cW
	IHJHPTW6B5oWA9oIQ1RFNLfUEM3iAgWLlnIb+fe8IJNvGAiRlEIc2ypPfwh9Gr3APd8Eyq
	4nZNPEFFUm1DAKbpvwhCuc8ZvLCmt9E=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-455-tiemH5QHM8yEkFhHP-SRPQ-1; Tue,
 10 Sep 2024 03:08:16 -0400
X-MC-Unique: tiemH5QHM8yEkFhHP-SRPQ-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 11E5C1955F45;
	Tue, 10 Sep 2024 07:08:14 +0000 (UTC)
Received: from hydra.redhat.com (unknown [10.39.194.27])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 33A121956048;
	Tue, 10 Sep 2024 07:08:09 +0000 (UTC)
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
Subject: [PATCH v3 3/4] drm/log: Do not draw if drm_master is taken
Date: Tue, 10 Sep 2024 08:56:30 +0200
Message-ID: <20240910070733.156127-4-jfalempe@redhat.com>
In-Reply-To: <20240910070733.156127-1-jfalempe@redhat.com>
References: <20240910070733.156127-1-jfalempe@redhat.com>
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
 drivers/gpu/drm/drm_log.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/drm_log.c b/drivers/gpu/drm/drm_log.c
index 376ee173d99d..226e206e8b6a 100644
--- a/drivers/gpu/drm/drm_log.c
+++ b/drivers/gpu/drm/drm_log.c
@@ -18,6 +18,7 @@
 #include <drm/drm_print.h>
 
 #include "drm_draw.h"
+#include "drm_internal.h"
 #include "drm_log.h"
 
 MODULE_AUTHOR("Jocelyn Falempe");
@@ -308,8 +309,13 @@ static void drm_log_write_thread(struct console *con, struct nbcon_write_context
 	if (!dlog->probed)
 		drm_log_init_client(dlog);
 
-	for (i = 0; i < dlog->n_scanout; i++)
-		drm_log_draw_kmsg_record(&dlog->scanout[i], wctxt->outbuf, wctxt->len);
+	/* Check that we are still the master before drawing */
+	if (drm_master_internal_acquire(dlog->client.dev)) {
+		drm_master_internal_release(dlog->client.dev);
+
+		for (i = 0; i < dlog->n_scanout; i++)
+			drm_log_draw_kmsg_record(&dlog->scanout[i], wctxt->outbuf, wctxt->len);
+	}
 }
 
 static void drm_log_lock(struct console *con, unsigned long *flags)
-- 
2.46.0


