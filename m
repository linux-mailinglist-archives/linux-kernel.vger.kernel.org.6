Return-Path: <linux-kernel+bounces-410818-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 430D89CE248
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 15:50:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CBB90B3512C
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 14:32:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FA091D515B;
	Fri, 15 Nov 2024 14:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O7FZzSgw"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ABE31D45FD
	for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 14:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731681043; cv=none; b=mxjw4slGgcP5Fh3jDmCsPvSc6W8L1gHJX0z63aUjIfZHWniO/jr/7PwrEAZONSSqZxRyqzWrrztzAFpX2rbVQ6hsCU8iHwCIZk4ugsv6P9qEnIMlojILn5wjzW/wNjhZFQwQuTh1UsXAX3ocRrOQ3mZT9DPKOMiyYsqEp2BJdsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731681043; c=relaxed/simple;
	bh=Ql5k98fr2HD9CbAAnTmfFWtfhTY8P61mMtPNzCdLaJ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ULizgBlnpauyxMRpiDXvdW9l66I3S3m+Nb9FnKmH6Jzh8eqRnCdzGwItRVDHrKKWckAWRvhXTc1O/6vniiJTSFQ01YoAaEzr8uQ0rab/ZQCVtbUwr3ojRk6B46KIFqzop7bDl3b8uV92KijEioHdbGoKogfUrmnSUQTM7se5Syo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=O7FZzSgw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731681041;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bksWKa/WbnBjZpz5dnVht4uLe7bVPW6YnTgkX32dc9A=;
	b=O7FZzSgwEXcmJI60xgvjPXc/bmhX7t8HuGiOKUXMq0Aupxegn1MajjoqotZjLkWq808YDW
	DMJ0lWvbxt6JojWDsYmEfi0XtILhOnTAG1PIE9FPKS0kr3N1ilpIezTplAZStmKIeP23St
	cNLGg9FMVBglz2EdJ/1EoOck4wtQ6cM=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-237-PBrFdfh2PI2I5DDlaMY9-w-1; Fri,
 15 Nov 2024 09:30:40 -0500
X-MC-Unique: PBrFdfh2PI2I5DDlaMY9-w-1
X-Mimecast-MFC-AGG-ID: PBrFdfh2PI2I5DDlaMY9-w
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 58E711954223;
	Fri, 15 Nov 2024 14:30:36 +0000 (UTC)
Received: from hydra.redhat.com (unknown [10.39.194.181])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 4C4D31956089;
	Fri, 15 Nov 2024 14:30:32 +0000 (UTC)
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
Subject: [PATCH v8 5/6] drm/log: Implement suspend/resume
Date: Fri, 15 Nov 2024 14:40:42 +0100
Message-ID: <20241115142950.1758007-6-jfalempe@redhat.com>
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

Normally the console is already suspended when the graphic driver
suspend callback is called, but if the parameter no_console_suspend
is set, it might still be active.
So call console_stop()/console_start() in the suspend/resume
callbacks, to make sure it won't try to write to the framebuffer
while the graphic driver is suspended.

Signed-off-by: Jocelyn Falempe <jfalempe@redhat.com>
Reviewed-by: John Ogness <john.ogness@linutronix.de>
Acked-by: Petr Mladek <pmladek@suse.com>
---

v6:
 * Use console_stop() and console_start() in the suspend/resume callback (Petr Mladek).

 drivers/gpu/drm/clients/drm_log.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/gpu/drm/clients/drm_log.c b/drivers/gpu/drm/clients/drm_log.c
index 615396e7b3739..03c59784c829f 100644
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
2.47.0


