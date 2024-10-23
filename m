Return-Path: <linux-kernel+bounces-378000-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90B719AC9C9
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 14:13:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 07F1EB22CEA
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 12:13:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6610B1B4F09;
	Wed, 23 Oct 2024 12:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dCzqNZII"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F9E61AE01F
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 12:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729685546; cv=none; b=B0SO/Pcf0bCraHYaVfRIXx8GA3MwIpRnxKJuCn0tC1Cu5vsibZF5qbbqO0U//N526cgR8MgLNOnHiT57ljIf2oHqKu3e4UOCdZekeuXRUR2DO9tSkgwlXGMECSvwdtewwbnEzn3sbvwxsGPoxjQjLGoU/so3xqMjj7A/ZGSIFiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729685546; c=relaxed/simple;
	bh=LiSN6tooqIkaAAgNCmt29B1J+fv6j9/I+h0oGZp0w8c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dt9v0IvIfzwly+XXykToZ1yvkQ5bzkslo4xP9X6arjtimIQxoTvbh7kDv1/khG6U1HmCTra3rzmS25+OdZxXX1BOz1GpfHCfgPVjxL2EkNeXjYrtKwT1o6qijjDT7PNXRcOqXWgxfedjepsX1e9z+Gw2+Tc2U4/Hy6ySw81sF6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dCzqNZII; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729685544;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vLQ4EQ67+8gevIx/PP1n5uexwWyC+rShOaFtXswP62Q=;
	b=dCzqNZIILnFigylX1CecfcwYVa97h6OyoemDf/4pcH+j67qf7EUROryq3NzKBuqsVex9Ta
	oJNMNV/fBpMBJs8St1nLgjVH4HbbDMnxze3yR1EvU/CJh3+QVdFMheyB3x8CtY/TXWwTzf
	SL3Vj4UMGOQQk9NFrySKq01ZrGVPAWk=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-572-jZ4_tS8rNvWMvwHPJDBRbw-1; Wed,
 23 Oct 2024 08:12:21 -0400
X-MC-Unique: jZ4_tS8rNvWMvwHPJDBRbw-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6E3791956089;
	Wed, 23 Oct 2024 12:12:19 +0000 (UTC)
Received: from hydra.redhat.com (unknown [10.39.193.145])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 90F343000198;
	Wed, 23 Oct 2024 12:12:15 +0000 (UTC)
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
Subject: [PATCH v5 5/6] drm/log: Implement suspend/resume
Date: Wed, 23 Oct 2024 14:00:13 +0200
Message-ID: <20241023121145.1321921-6-jfalempe@redhat.com>
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
index 635dff7b37ce5..07d1513001468 100644
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
2.47.0


