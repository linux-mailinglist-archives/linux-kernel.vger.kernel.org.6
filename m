Return-Path: <linux-kernel+bounces-239821-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A17E29265B6
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 18:12:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C7101F23088
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 16:12:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAD83181CED;
	Wed,  3 Jul 2024 16:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GaIgYZNc"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A401417E904
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 16:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720023050; cv=none; b=JUM1GAUbKv6XitU8ua8X94Ne0TKRoZ6+ljOa8HIBysVSTYMTj5+PASN72CM4+RerWhG5thc94mtjF4Q3C31w9z/ck/QJXCjTefyrmCi5DDUqBDxsYX/o4MstR520s0xz9Q5lxM8Th19k8nKDmP74mcD2NlP46LJkkdDsYea94PM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720023050; c=relaxed/simple;
	bh=9R5WRTDouFlBw7vJyduxiA37uM8NfVzWWiaPg6a+knc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KtOLA0nZ9eU64anzhbB23kJo8da4DO9VaqoKqZbSkt/wI92UWOTWPFjXluVhQwc/+fWBSXiB6+cPwBHhTt1rMwMYY6u5rRMfYFX9/byK+S4LNljPzALfSXoIHcLZHu/+MdMf/fRp2JKi5JIPzAoAUIhQiJeWfxG8u4GSaLj3cO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GaIgYZNc; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720022993;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=a1sXr0thktmDx/q8cOENxbGCufmQp1QnvYwSpw++kfk=;
	b=GaIgYZNc4420LRNm4WJaHLzHkGSXzdZw7LMOEZuRFwPw3xNBXS8JKBl9mf/y3qkzfeckKo
	rMc6AOzMus49goJllC1rLmJQ51BGLmrkNgsxMtdpyt39IjmQm0BnAHEIGGjLA0/DpTo7ee
	lZIAnHw68FU93vWJgQlpcWQr0VEgDxo=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-678-rGv9wkdxPuKIHorf-4LgQA-1; Wed,
 03 Jul 2024 12:08:14 -0400
X-MC-Unique: rGv9wkdxPuKIHorf-4LgQA-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 99B10191DADF;
	Wed,  3 Jul 2024 16:05:05 +0000 (UTC)
Received: from chopper.lyude.net (unknown [10.22.10.132])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 742CE1954B0D;
	Wed,  3 Jul 2024 16:05:02 +0000 (UTC)
From: Lyude Paul <lyude@redhat.com>
To: dri-devel@lists.freedesktop.org
Cc: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
	Melissa Wen <melissa.srw@gmail.com>,
	=?UTF-8?q?Ma=C3=ADra=20Canal?= <mairacanal@riseup.net>,
	Haneen Mohammed <hamohammed.sa@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] drm/vkms: Remove event from vkms_output
Date: Wed,  3 Jul 2024 12:04:58 -0400
Message-ID: <20240703160458.1303872-1-lyude@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

While working on rvkms, I noticed that there's no code that actually uses
the drm_pending_vblank_event that's embedded in vkms_output. So, just drop
the member from the struct.

Signed-off-by: Lyude Paul <lyude@redhat.com>
---
 drivers/gpu/drm/vkms/vkms_drv.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/vkms/vkms_drv.h b/drivers/gpu/drm/vkms/vkms_drv.h
index 8f5710debb1eb..5e46ea5b96dcc 100644
--- a/drivers/gpu/drm/vkms/vkms_drv.h
+++ b/drivers/gpu/drm/vkms/vkms_drv.h
@@ -103,7 +103,6 @@ struct vkms_output {
 	struct drm_writeback_connector wb_connector;
 	struct hrtimer vblank_hrtimer;
 	ktime_t period_ns;
-	struct drm_pending_vblank_event *event;
 	/* ordered wq for composer_work */
 	struct workqueue_struct *composer_workq;
 	/* protects concurrent access to composer */
-- 
2.45.2


