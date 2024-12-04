Return-Path: <linux-kernel+bounces-431589-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C6A359E3F4F
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 17:10:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 453CBB478F9
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 16:07:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9382320E02B;
	Wed,  4 Dec 2024 16:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dlj/COBh"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55CFE20E015
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 16:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733328055; cv=none; b=XVwx+GqcKWLlWsZc8RqESPV1P5vvTE7x1JJn2PzGnNZORK4iMlnVtRgyk7W0XAEmqgWo403c4//4lnysrbTAjboKFdRrwXODLpeg21yQPiHheRNb2IMzENCalkAL8P+AuTEHfws+pk4wrPYyHhjy5OMKlVH2R6E9HT1KIsqCr6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733328055; c=relaxed/simple;
	bh=Vi1e8gOsOJzOUXky4fnUkVvzlKCwc2vy3smiCmR6jEM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iAmwygsP5j+zDLYle6utKmv9Fnu2PkTGYwPGYGMV3Nkd7Zc34SxC6KzgFYuiFOT9JIljgoSboTCPHvMcjbPiF+nhOHy41mnyIb4pKvDmdw0YzC9+Q5yYR/IIQRUhFOFUprSlUHrKwCMUaD7BuyYK6aHYIMR0gc9bOWpf7KAl18k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dlj/COBh; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733328053;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EAXkKWQ2t10EV7HQmykqucMmUkoD2K+BIB1/5XkIlnY=;
	b=dlj/COBhAx7C1V4hQwCcQisB6wS1GNBMoZhc0oYl8i+TSkLtLEWGy+LmYHTEOf/Xs3YQS0
	cklB9SKt7hp0p0rnRBnLQk8PpPmRFxJuNDIXBfULt+NYa36mg5wv41NfyGGRhSkjEz5TQo
	KGQwrDa7mUwFziUoT8ogu3Gk+uvKCZ4=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-623-0LCxpcDfMAu6QEUgS7aIMg-1; Wed,
 04 Dec 2024 11:00:51 -0500
X-MC-Unique: 0LCxpcDfMAu6QEUgS7aIMg-1
X-Mimecast-MFC-AGG-ID: 0LCxpcDfMAu6QEUgS7aIMg
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 431091955F3F;
	Wed,  4 Dec 2024 16:00:49 +0000 (UTC)
Received: from hydra.redhat.com (unknown [10.39.193.255])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 292771956052;
	Wed,  4 Dec 2024 16:00:44 +0000 (UTC)
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
Subject: [PATCH v9 5/6] drm/log: Implement suspend/resume
Date: Wed,  4 Dec 2024 16:45:04 +0100
Message-ID: <20241204160014.1171469-6-jfalempe@redhat.com>
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

Normally the console is already suspended when the graphic driver
suspend callback is called, but if the parameter no_console_suspend
is set, it might still be active.
So call console_stop()/console_start() in the suspend/resume
callbacks, to make sure it won't try to write to the framebuffer
while the graphic driver is suspended.

Signed-off-by: Jocelyn Falempe <jfalempe@redhat.com>
Reviewed-by: John Ogness <john.ogness@linutronix.de>
Acked-by: Petr Mladek <pmladek@suse.com>
Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
---


v6:
 * Use console_stop() and console_start() in the suspend/resume callback (Petr Mladek).

 drivers/gpu/drm/clients/drm_log.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/gpu/drm/clients/drm_log.c b/drivers/gpu/drm/clients/drm_log.c
index 5a995742aec5..d5f9c679f2c0 100644
--- a/drivers/gpu/drm/clients/drm_log.c
+++ b/drivers/gpu/drm/clients/drm_log.c
@@ -310,10 +310,30 @@ static int drm_log_client_hotplug(struct drm_client_dev *client)
 	return 0;
 }
 
+static int drm_log_client_suspend(struct drm_client_dev *client, bool _console_lock)
+{
+	struct drm_log *dlog = client_to_drm_log(client);
+
+	console_stop(&dlog->con);
+
+	return 0;
+}
+
+static int drm_log_client_resume(struct drm_client_dev *client, bool _console_lock)
+{
+	struct drm_log *dlog = client_to_drm_log(client);
+
+	console_start(&dlog->con);
+
+	return 0;
+}
+
 static const struct drm_client_funcs drm_log_client_funcs = {
 	.owner		= THIS_MODULE,
 	.unregister	= drm_log_client_unregister,
 	.hotplug	= drm_log_client_hotplug,
+	.suspend	= drm_log_client_suspend,
+	.resume		= drm_log_client_resume,
 };
 
 static void drm_log_write_thread(struct console *con, struct nbcon_write_context *wctxt)
-- 
2.47.1


