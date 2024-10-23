Return-Path: <linux-kernel+bounces-377998-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 818049AC9C5
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 14:12:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7752C1C216DA
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 12:12:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32FF91ADFE3;
	Wed, 23 Oct 2024 12:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GO/aycKe"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2057D1ABED8
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 12:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729685542; cv=none; b=nR/vGqcgXTUgz7uQQgBtFz/fnS0r+tVc3Y+1WbC4jPlhvjo1hhkeYttL/Fk2rJLAeMLLwaXCeuK6g3GMZ25KQNVotiEs8w4fvc5nKlGLHWHTRHcYNaiJGTC5AgEal3YYo9JGaJgnVjc2WcHa2VlFU5U1VhjpTBshT8spAznRUdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729685542; c=relaxed/simple;
	bh=Y/Il7iSZsrR4fAR8cBOGnN95gVjY5AMEFZkYUxSz694=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dHQiC1ui5NEucx64952SpNAbAXVrToPD6MembNQboaT6B6I2ZqEQUUJsOCdiWLPx7C9hVV89ojqWqPC3Sth6c5BqSvfzlEdFQGaNX6bZQiOBUIkdJeHVATmhMA2F6/QobJTkChRCb5j3Izk+e+98YW3BZSd51135hWhfHF4RXig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GO/aycKe; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729685539;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XGA7oJJlOgWlZrqq643jRTkZUCuA07JORfE5OuKX5n8=;
	b=GO/aycKeOi7+zyQ0l5lvXEE+iF/0NNu/AmeZ4+dUIweRRit4B80MycY1j15uZS8htJvr6A
	JMcHBHB/eXzrclhph36z29VxoS+eWHCoIAY2J6r27SUaRTwCINbGbSkqTFe9PH8eAzyKjV
	U8oUaV4BF26QqGywj33mN4e/vGhUalw=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-449--c7vOzWUPza0MGpkcS9WwQ-1; Wed,
 23 Oct 2024 08:12:16 -0400
X-MC-Unique: -c7vOzWUPza0MGpkcS9WwQ-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B37FE1955F45;
	Wed, 23 Oct 2024 12:12:10 +0000 (UTC)
Received: from hydra.redhat.com (unknown [10.39.193.145])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0FB5A30001A7;
	Wed, 23 Oct 2024 12:12:06 +0000 (UTC)
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
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Cc: Jocelyn Falempe <jfalempe@redhat.com>
Subject: [PATCH v5 3/6] drm/log: Do not draw if drm_master is taken
Date: Wed, 23 Oct 2024 14:00:11 +0200
Message-ID: <20241023121145.1321921-4-jfalempe@redhat.com>
In-Reply-To: <20241023121145.1321921-1-jfalempe@redhat.com>
References: <20241023121145.1321921-1-jfalempe@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

When userspace takes drm_master, the drm_client buffer is no more
visible, so drm_log shouldn't waste CPU cycle to draw on it.

Signed-off-by: Jocelyn Falempe <jfalempe@redhat.com>
---
 drivers/gpu/drm/drm_log.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/drm_log.c b/drivers/gpu/drm/drm_log.c
index 376ee173d99d9..226e206e8b6a3 100644
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
2.47.0


