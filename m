Return-Path: <linux-kernel+bounces-442817-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E96AB9EE259
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 10:13:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CCBA4168E6A
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 09:12:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A25520E328;
	Thu, 12 Dec 2024 09:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MTqcmKCM"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADF3C20E305
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 09:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733994751; cv=none; b=KVDnKDUU3zySQ/Heox2z8MXy31oI5W8ty5XCv+oM/yZJD7bW01XnvgcQZLHDHJYl5RRpsgnTES9WN/2hSHmPVIwc6+8JlensnxOWF4lzmCbBEK1L0d+B+TqIQoVJqOacjJU1nz5Sx6jbkvxk1rZjLOtDMG7MLUY8LG7bDBhLdOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733994751; c=relaxed/simple;
	bh=fIjJio/KD81ZacO1Dc56DR9dqfIRXS3uytIJOkntLZ0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FQqgw+RRXyeRbbw0yQ5P58WAd9nJcNXdqFSyJe3upWJW0EzLJ2uvfBhbTtPsR8Fyv2vBdagBr4YbqKsG3VHhC6X9GTQu+yn1zQdz7QFQ0y8EKbqYyPJScjwXhrtyKQ7gXmwI/OgR8N5zYZo6Y/ujJV6jGnEcKdRI28x//BXxnz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MTqcmKCM; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733994748;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=LzqRPciXYVZNr61lsEDxWhyTkYFjeUGoBdGD/quUZ+U=;
	b=MTqcmKCMTXCcdzZO3Ngs0VQ+d1NDne8MqT1US7puT2eKMvkT0dX/Ja5iWVur3JcTeXAZ5V
	kjJvZ/tgnNVU0gcLmNObOAWWhi6MBgWRpFGwdIPZwhX0cC2mtgAVXEjCLQc7hJTxYEbnkZ
	jeF7IXmQZw4YAIhjoqLMCKQeiLExibg=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-148-gAuD937WN5GLG2-G_ZYUOQ-1; Thu,
 12 Dec 2024 04:12:24 -0500
X-MC-Unique: gAuD937WN5GLG2-G_ZYUOQ-1
X-Mimecast-MFC-AGG-ID: gAuD937WN5GLG2-G_ZYUOQ
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 384411955F65;
	Thu, 12 Dec 2024 09:12:21 +0000 (UTC)
Received: from hydra.redhat.com (unknown [10.39.193.39])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id BF941195394B;
	Thu, 12 Dec 2024 09:12:15 +0000 (UTC)
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
Cc: Jocelyn Falempe <jfalempe@redhat.com>,
	Dan Carpenter <dan.carpenter@linaro.org>
Subject: [PATCH] drm/client: Fix drm client endless Kconfig loop
Date: Thu, 12 Dec 2024 10:11:29 +0100
Message-ID: <20241212091153.1592096-1-jfalempe@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

if DRM_CLIENT_SELECTION is enabled, and none of the client is, the
"Default DRM Client" choice is empty, and this makes Kconfig goes
into an infinite loop of:

  Default DRM Client
  choice[1-0?]: 0
  Default DRM Client
  choice[1-0?]: 0
  Default DRM Client
  choice[1-0?]: 0
  ....

So only allow the choice if at least one of the client is selected.

Fixes: f7b42442c4ac ("drm/log: Introduce a new boot logger to draw the kmsg on the screen")
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Signed-off-by: Jocelyn Falempe <jfalempe@redhat.com>
Tested-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/gpu/drm/clients/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/clients/Kconfig b/drivers/gpu/drm/clients/Kconfig
index c18decc90200..82a7d4e584dd 100644
--- a/drivers/gpu/drm/clients/Kconfig
+++ b/drivers/gpu/drm/clients/Kconfig
@@ -87,6 +87,7 @@ config DRM_CLIENT_LOG
 choice
 	prompt "Default DRM Client"
 	depends on DRM_CLIENT_SELECTION
+	depends on DRM_FBDEV_EMULATION || DRM_CLIENT_LOG
 	default DRM_CLIENT_DEFAULT_FBDEV
 	help
 	  Selects the default drm client.

base-commit: 19851fa2ba9824bede16f55234f63d9423897c3d
-- 
2.47.1


