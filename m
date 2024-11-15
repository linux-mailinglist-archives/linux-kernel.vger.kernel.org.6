Return-Path: <linux-kernel+bounces-410816-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 56C339CE144
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 15:31:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A8E92812B2
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 14:31:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80C9E1D4610;
	Fri, 15 Nov 2024 14:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VdT9e4sL"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5593A1D435C
	for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 14:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731681035; cv=none; b=M6PBz1/jiK2zLcivDqfwzLbcrGygmY2xOExVgEiVp6A4rZPGDIGhry/aa9q3QehGA5DnBtwYmNweB2NPajAEqbTO3YFKqgnELJ5ASaqJitEK/iYtAURZM9E2fpIZ451YKLaSsxoai8LxcJNE3WESY4xvPHLf/oaDW+ejREeAoyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731681035; c=relaxed/simple;
	bh=kS67XaoZZyQ7AVrY3Qk+0HW5vS53T0tFYHQ/9+zll1E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rj1WO55QKgnCTFOmk3nl8AHmV3bfTUmZUhgHOE2pkIasY4icU0NGGjKlQQq2e4VYp1XSZEmeuDwWNZSs7ARa7YV4/8IyhMq0AIdrWqlep0hNSdG2JoZdw7G+o3K72wX2GU45FZ1G5C54NmPEAD5o5ZxoKns+C6Z049qqC0DlBTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VdT9e4sL; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731681033;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PqzXwfom8uMA5cWS07luULgcBuSRhlxoOEl4sjQVQRQ=;
	b=VdT9e4sLmgvU/CcQt4y9UcmJeYHP4p7I/kwXoKwqObd8Pq/j3J3QB7Kj0HH7BZiUm6x75p
	kW+kNcB8TpP8bpnDWTasDIlMp7d0peQjBG35OomtpS9qQvs5BrShnbkpdBolT+coDi6TnE
	DLvmSh5LclkZBvLa1f9rVyfG1XbrIzY=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-439-LpYCq0O1Mw2Wmk6bm7DzLw-1; Fri,
 15 Nov 2024 09:30:30 -0500
X-MC-Unique: LpYCq0O1Mw2Wmk6bm7DzLw-1
X-Mimecast-MFC-AGG-ID: LpYCq0O1Mw2Wmk6bm7DzLw
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 530591955F2B;
	Fri, 15 Nov 2024 14:30:27 +0000 (UTC)
Received: from hydra.redhat.com (unknown [10.39.194.181])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 66D501956089;
	Fri, 15 Nov 2024 14:30:23 +0000 (UTC)
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
	Caleb Connolly <caleb.connolly@linaro.org>,
	Petr Mladek <pmladek@suse.com>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Cc: Jocelyn Falempe <jfalempe@redhat.com>
Subject: [PATCH v8 3/6] drm/log: Do not draw if drm_master is taken
Date: Fri, 15 Nov 2024 14:40:40 +0100
Message-ID: <20241115142950.1758007-4-jfalempe@redhat.com>
In-Reply-To: <20241115142950.1758007-1-jfalempe@redhat.com>
References: <20241115142950.1758007-1-jfalempe@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

When userspace takes drm_master, the drm_client buffer is no more
visible, so drm_log shouldn't waste CPU cycle to draw on it.

Signed-off-by: Jocelyn Falempe <jfalempe@redhat.com>
---
 drivers/gpu/drm/clients/drm_log.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/clients/drm_log.c b/drivers/gpu/drm/clients/drm_log.c
index cb793a348f1f9..8eca8044f1f08 100644
--- a/drivers/gpu/drm/clients/drm_log.c
+++ b/drivers/gpu/drm/clients/drm_log.c
@@ -19,6 +19,7 @@
 
 #include "drm_client_internal.h"
 #include "../drm_draw.h"
+#include "../drm_internal.h"
 
 MODULE_AUTHOR("Jocelyn Falempe");
 MODULE_DESCRIPTION("DRM boot logger");
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
2.47.0


