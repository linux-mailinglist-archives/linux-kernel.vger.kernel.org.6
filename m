Return-Path: <linux-kernel+bounces-431587-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A240F9E3F27
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 17:06:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E81E284AF2
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 16:06:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64F2C20DD75;
	Wed,  4 Dec 2024 16:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Fi25ZcHC"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45C0420DD66
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 16:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733328049; cv=none; b=krdAMKnlcYl75RAxqqW4ZDwqw1pmM+wxxIzJ5v9WE8psCy7RxTxadYCYys6D8gLq8Cl3UJQPau3aWCX4wWdXXTwRLLGD078JOocQBVBVCcOKLKejH0BbuwxrtIs3XOd28LP9sj49UnBLRuJBKKHYzj3cPph6XGRIYjwcSdcVW6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733328049; c=relaxed/simple;
	bh=iPUGez6YQnw7+siPex8PyKyZACTaklyKaV6dtnbnukU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UEb8KY15ChqqAF2UAd8O7i42N0jm2j4OP0AagjEOhLnH17KZib088MmUKiVgAbqTVLzh+2h/V/Zz6uH5VXQRAd2gLjDIj/vkoj1Ifbr8qVQFV0/l+vv2pdvPhX19hJ3/uj43p//+ZWOtltHJOPVwgG2FuoPjp8vLWxQJBSEnIzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Fi25ZcHC; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733328047;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=g6jiLmVcWGLp2iun5zGYIdV90Ef3CpXMFT+ZPabmc1s=;
	b=Fi25ZcHC+i1DeGcKhJOWaYQ3E1EBNY9j29cz//0omrNBTMJApjP1q54v9uz0OmOqNZUNi9
	C9MUBHv2zuTfNN0zw+amMFXJjsqWDi5mFhGwjySm7lTXRz3+8Ll9ImCN1+edMGx4TxJuOI
	qOh+9N4b+uamI3yiSjwNXmF66xHJoEQ=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-120-1Vsoyi6cP0GPsoESuc0YuA-1; Wed,
 04 Dec 2024 11:00:43 -0500
X-MC-Unique: 1Vsoyi6cP0GPsoESuc0YuA-1
X-Mimecast-MFC-AGG-ID: 1Vsoyi6cP0GPsoESuc0YuA
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 379F619560BD;
	Wed,  4 Dec 2024 16:00:40 +0000 (UTC)
Received: from hydra.redhat.com (unknown [10.39.193.255])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E37821956052;
	Wed,  4 Dec 2024 16:00:35 +0000 (UTC)
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
	Jani Nikula <jani.nikula@linux.intel.com>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Cc: Jocelyn Falempe <jfalempe@redhat.com>
Subject: [PATCH v9 3/6] drm/log: Do not draw if drm_master is taken
Date: Wed,  4 Dec 2024 16:45:02 +0100
Message-ID: <20241204160014.1171469-4-jfalempe@redhat.com>
In-Reply-To: <20241204160014.1171469-1-jfalempe@redhat.com>
References: <20241204160014.1171469-1-jfalempe@redhat.com>
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
Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/gpu/drm/clients/drm_log.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/clients/drm_log.c b/drivers/gpu/drm/clients/drm_log.c
index 4e07bff6c864..a933da024b1a 100644
--- a/drivers/gpu/drm/clients/drm_log.c
+++ b/drivers/gpu/drm/clients/drm_log.c
@@ -19,6 +19,7 @@
 
 #include "drm_client_internal.h"
 #include "drm_draw_internal.h"
+#include "drm_internal.h"
 
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
2.47.1


