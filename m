Return-Path: <linux-kernel+bounces-396439-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68F709BCD13
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 13:52:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A7611C2163E
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 12:52:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E28E01D6DA8;
	Tue,  5 Nov 2024 12:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MujDPqCg"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCD0C1D63FF
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 12:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730811112; cv=none; b=BOnQA+sCbPm3GNMmI3ummlckEKOQVI96CSpJwZ9ssL6R5B9i0/mkDGV8Pxaw5g8DIg76eG6+4CfWFuXhp3Gpvg6KfG7v4ZncWlXHjCrCppljiBz2deb67OnSl/0JfgiBL/6Gv9ZLT22cCmX7QsFxRSSXzJ+KHG6E6hTHaqtgy24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730811112; c=relaxed/simple;
	bh=IxNGvHGNyhzvqbsu/sAuNqjCnTkCtIbKsU35A57IhRE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QxOVqZ/w3oHGQOhZdbG3wfaa6yrGmSA7sLNrn43AeiArXgLxgu07+BWMswdhTBFLoZBn97ZGfBrR93qaXDubqg1j7Iy5hNXgq/Qz3Iq0XLJQ3sVU5crO5JgaLl3PUuybe/8C5DWEAfA2hYFtW7/kgzh/szdDv+CEAEVwqYz7gb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MujDPqCg; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730811109;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eKwQ8aftb1Cok9JLSK6t50SeV6DDoreUPh56f8j0u2Q=;
	b=MujDPqCgIyVRad11egzeANKECyC2GM9VkyBlVPd7EyG0mg/QjEd0cvlDB8aCmt0Ag+MUw1
	kM2BOZxVWAjHEieh63vv8re2ET/i1qHbjDQRYz/nt58h0lDIogZE2pu2P1T9E2PWF+nO8y
	UJsxzmEaJYfHSPTHNc1pwIp/b45zbuQ=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-81-T07LDvzBPgGXTcqS7gQgsg-1; Tue,
 05 Nov 2024 07:51:48 -0500
X-MC-Unique: T07LDvzBPgGXTcqS7gQgsg-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id F393C1955D6A;
	Tue,  5 Nov 2024 12:51:46 +0000 (UTC)
Received: from hydra.redhat.com (unknown [10.39.193.51])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 4FE9219560AA;
	Tue,  5 Nov 2024 12:51:43 +0000 (UTC)
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
Subject: [PATCH v6 5/6] drm/log: Implement suspend/resume
Date: Tue,  5 Nov 2024 13:42:25 +0100
Message-ID: <20241105125109.226866-6-jfalempe@redhat.com>
In-Reply-To: <20241105125109.226866-1-jfalempe@redhat.com>
References: <20241105125109.226866-1-jfalempe@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

Normally the console is already suspended when the graphic driver
suspend callback is called, but if the parameter no_console_suspend
is set, it might still be active.
So call console_stop()/console_start() in the suspend/resume
callbacks, to make sure it won't try to write to the framebuffer
while the graphic driver is suspended.

Signed-off-by: Jocelyn Falempe <jfalempe@redhat.com>
---

v6:
 * Use console_stop() and console_start() in the suspend/resume callback (Petr Mladek).

 drivers/gpu/drm/drm_log.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/gpu/drm/drm_log.c b/drivers/gpu/drm/drm_log.c
index 635dff7b37ce5..e6900c6b96436 100644
--- a/drivers/gpu/drm/drm_log.c
+++ b/drivers/gpu/drm/drm_log.c
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
2.47.0


