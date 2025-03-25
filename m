Return-Path: <linux-kernel+bounces-575856-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D18C0A70818
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 18:24:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EBF021648EB
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 17:24:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45C2B26158F;
	Tue, 25 Mar 2025 17:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EO1z036c"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BE2C263C77
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 17:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742923469; cv=none; b=FRaBqPADsRrRuuCpQA8dW3HN3nyhc92KlvW71NDsrBPFiV2HNAY9CnU/M2jSOwpuX9McZgHu06tzVwm1bH6sh2nybepMSdKTXwPWEAS2lZCXFLc8wmF/yg1aqhM+yA0QsMXWjE1Kk6w0sizQhyMwPCAg52FkszXf9pUprck2Y8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742923469; c=relaxed/simple;
	bh=jaQNQ/kuDtEGuJTKiK0Rwf99pImE3NiWoOT21bZR5zA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XheXYeIXdfT90APTGGemH+R6s2fGaVfF+28EZlE5YmXUEpou4f6Q0M8UIjjHZHQyVkTzik5QtynqN/2PnDD5u6pdJNf5qyQZhJvHEbjda7BYtDmBpcoBxyBDhT/77qRlgfDK96armOp9b1W6BV6ri1vRuJ1BU8JJMFV6CdIZ5KE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EO1z036c; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742923467;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fJiXdpIGTwXcm1LoDXxfl4Gs+ELqOtdGET7nsd9L1IM=;
	b=EO1z036ci7nqJwV7G5EBBRqwt5I3/xwKrkTwHKQ+bvVeJ3bQNLCJfHjTdnTBZZ1hqh73AB
	p1fqfE9O15laQBknjE/iQ2E3FG0+EicAydi43hkUsh0drfPTzGLsaqg1ruvIqLaXa5Nucm
	ZvGvxEXidKtKWmrbuMSh2LwcgrQbb6I=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-311-N6ZnEp8WP4yQiY0w38hhAA-1; Tue,
 25 Mar 2025 13:24:23 -0400
X-MC-Unique: N6ZnEp8WP4yQiY0w38hhAA-1
X-Mimecast-MFC-AGG-ID: N6ZnEp8WP4yQiY0w38hhAA_1742923462
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 14865180049D;
	Tue, 25 Mar 2025 17:24:22 +0000 (UTC)
Received: from asrivats-na.rmtustx.csb (unknown [10.2.16.186])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E5971180A802;
	Tue, 25 Mar 2025 17:24:19 +0000 (UTC)
From: Anusha Srivatsa <asrivats@redhat.com>
Date: Tue, 25 Mar 2025 13:24:10 -0400
Subject: [PATCH 3/5] drm/panel: get/put panel reference in
 drm_panel_add/remove()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250325-b4-panel-refcounting-v1-3-4e2bf5d19c5d@redhat.com>
References: <20250325-b4-panel-refcounting-v1-0-4e2bf5d19c5d@redhat.com>
In-Reply-To: <20250325-b4-panel-refcounting-v1-0-4e2bf5d19c5d@redhat.com>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <quic_jesszhan@quicinc.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Anusha Srivatsa <asrivats@redhat.com>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1742923451; l=1117;
 i=asrivats@redhat.com; s=20250122; h=from:subject:message-id;
 bh=jaQNQ/kuDtEGuJTKiK0Rwf99pImE3NiWoOT21bZR5zA=;
 b=xeQemeTWiqshaEsVEFDP+ZHuaVq2kRHLh8DorV3VzuPa2lvVBlT+CaGhN568POE1NS8p1C/cT
 wwLahBqcoYZBat3s+c6Ls5f80RRtqhxNxIn8neEJF1gSOvedhJcHCgd
X-Developer-Key: i=asrivats@redhat.com; a=ed25519;
 pk=brnIHkBsUZEhyW6Zyn0U92AeIZ1psws/q8VFbIkf1AU=
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Take the panel reference and put it back as required
using the helpers introduced in previous patch.
drm_panel_add() and drm_panel_remove()
add a panel to the global registry and removes a panel
respectively, use get() and put() helpers to keep up
with refcounting.

Signed-off-by: Anusha Srivatsa <asrivats@redhat.com>
---
 drivers/gpu/drm/drm_panel.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/drm_panel.c b/drivers/gpu/drm/drm_panel.c
index 079c3c666a2ddc99a0051d1a3c9ba65d986dd003..11a0415bc61f59190ef5eb378d1583c493265e6a 100644
--- a/drivers/gpu/drm/drm_panel.c
+++ b/drivers/gpu/drm/drm_panel.c
@@ -79,6 +79,7 @@ EXPORT_SYMBOL(drm_panel_init);
  */
 void drm_panel_add(struct drm_panel *panel)
 {
+	drm_panel_get(panel);
 	mutex_lock(&panel_lock);
 	list_add_tail(&panel->list, &panel_list);
 	mutex_unlock(&panel_lock);
@@ -96,6 +97,7 @@ void drm_panel_remove(struct drm_panel *panel)
 	mutex_lock(&panel_lock);
 	list_del_init(&panel->list);
 	mutex_unlock(&panel_lock);
+	drm_panel_put(panel);
 }
 EXPORT_SYMBOL(drm_panel_remove);
 

-- 
2.48.1


