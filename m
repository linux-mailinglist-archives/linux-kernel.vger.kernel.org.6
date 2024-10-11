Return-Path: <linux-kernel+bounces-360993-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36B7199A223
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 12:57:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 668A71C21CF2
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 10:57:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF42D2141D3;
	Fri, 11 Oct 2024 10:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="adKPI4ie"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EE1920CCE8
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 10:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728644177; cv=none; b=eNIaFTgRTIjHUZnA6BDgSEaTkKiifOtQs9eJ88DM24xvJ8iLU9i2fTre/q+6L6wwmMJBAxdWfyug7Z5uRAo0sXrwIHCYtz7MlFj8Ooo1mx8t4XWupBF9F1/UOOyUW/fFxSps3ByAwh7lpDhDavWFfx097uCDlpstM3KCeqDSREQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728644177; c=relaxed/simple;
	bh=DV+yjGsPujNz4t7ofG+jlvy5B0vusa0ogBlYIQ4NN90=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ixyNIwoENbEuYWYqqUKMS68k8oFX2bNL0FyS2hdK9/VkjkCceFyVfbJSaStz987SZG1rTEt457+aQrH0Tzmcyq7vF4hctMgbUtUqdbWeGBvVF25Muu54wWFwAUJkh0PMLeXG8MSJ+XTnsRUfe7hxgfj50/eJHOUQtDdmJRdcva0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=adKPI4ie; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728644174;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2au55nCawPb4kHsDHlFJeqOUgMsSnwRtO/Zd5af/hzI=;
	b=adKPI4ieUiRKcTu1SWiPNBSvbNpR5O4b5e0DI8Q2x7+AmWg4O4u0+ivdU/Z6/iPB/4N1m5
	8Avyo5zv+oQOEHpz6CIEIAzzTdCFFvPQDIqqyt4npljexdB2M8jvezGBL+N9+TLHVCOnyl
	kwgCbvATF07FPoI/JubT/Hbqvhs4Oes=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-65-LUDfZL0BNhGjB7IwaxxCVg-1; Fri,
 11 Oct 2024 06:56:09 -0400
X-MC-Unique: LUDfZL0BNhGjB7IwaxxCVg-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9F73A1954B1F;
	Fri, 11 Oct 2024 10:56:07 +0000 (UTC)
Received: from hydra.redhat.com (unknown [10.39.192.224])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0D8DC19560AE;
	Fri, 11 Oct 2024 10:56:03 +0000 (UTC)
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
Subject: [PATCH v4 6/7] drm/log: Implement suspend/resume
Date: Fri, 11 Oct 2024 12:50:03 +0200
Message-ID: <20241011105526.615812-7-jfalempe@redhat.com>
In-Reply-To: <20241011105526.615812-1-jfalempe@redhat.com>
References: <20241011105526.615812-1-jfalempe@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

The console is already suspended in printk.c.
Just make sure we don't write to the framebuffer while the graphic
driver is suspended.
It may lose a few messages between graphic suspend and console
suspend.

Signed-off-by: Jocelyn Falempe <jfalempe@redhat.com>
---
 drivers/gpu/drm/drm_log.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/gpu/drm/drm_log.c b/drivers/gpu/drm/drm_log.c
index 635dff7b37ce..07d151300146 100644
--- a/drivers/gpu/drm/drm_log.c
+++ b/drivers/gpu/drm/drm_log.c
@@ -50,6 +50,7 @@ struct drm_log {
 	struct drm_client_dev client;
 	struct console con;
 	bool probed;
+	bool suspended;
 	u32 n_scanout;
 	struct drm_log_scanout *scanout;
 };
@@ -310,10 +311,32 @@ static int drm_log_client_hotplug(struct drm_client_dev *client)
 	return 0;
 }
 
+static int drm_log_client_suspend(struct drm_client_dev *client, bool _console_lock)
+{
+	struct drm_log *dlog = client_to_drm_log(client);
+
+	mutex_lock(&dlog->lock);
+	dlog->suspended = true;
+	mutex_unlock(&dlog->lock);
+	return 0;
+}
+
+static int drm_log_client_resume(struct drm_client_dev *client, bool _console_lock)
+{
+	struct drm_log *dlog = client_to_drm_log(client);
+
+	mutex_lock(&dlog->lock);
+	dlog->suspended = false;
+	mutex_unlock(&dlog->lock);
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
@@ -321,6 +344,9 @@ static void drm_log_write_thread(struct console *con, struct nbcon_write_context
 	struct drm_log *dlog = console_to_drm_log(con);
 	int i;
 
+	if (dlog->suspended)
+		return;
+
 	if (!dlog->probed)
 		drm_log_init_client(dlog);
 
-- 
2.46.2


