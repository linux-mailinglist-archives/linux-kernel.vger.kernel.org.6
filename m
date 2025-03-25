Return-Path: <linux-kernel+bounces-575859-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 99315A7081B
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 18:25:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63EED188A4AF
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 17:25:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A86D626463F;
	Tue, 25 Mar 2025 17:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aSDhD4m5"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74ED6263F28
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 17:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742923476; cv=none; b=RYocBJd/EAcMavcliUS2Aowr7LR4IQtbnGW1i+Ph43JXsAbyhrn4u/S+nnzleTMMLYRy1fEKU4BF3SONBnmKEo1md4Pr11rMdVDtXEGER8RjdH0Bp5cpbZDmCnFT+HxpLmXEs73gFxk3Mq4Gi5GgFC6V1RgXyg7gbdsVaT214ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742923476; c=relaxed/simple;
	bh=A+LU5lgwdNhiA1Kyn1XfW5gM4lg/FJ5Fagf5T/rOWc4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oj0auwcP8qf5f7/TGhFKa5MxC4JTNEs3vt22YJTL7ep2Tbn/VSmLEdw2BSyTo17lcKDeMUccPfmS9OoXDVZ5m4akzCVO9FCRlaXp5P1D72JHsq06SyMw4DS8JVLO0lz4uh9SFkxGoolcQ3UVQSao+dfTSujS0q9PapcewmQyO6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aSDhD4m5; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742923473;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lpjtlppTK5/lkJhOBorlfU7lpS28Avy09+tU63n0DK4=;
	b=aSDhD4m5GbtXErzUZSZ2E54YG6lBGdTT0VTAW3xXD9hKBXo0BevnmfXZYOKGEfvTyXyl8w
	h7WGes2PvGT0jLL2N+hjjtr49uCjl16CwwgKJqHPvp37N/AwaLm9k3XHqe0zUv221v/e9l
	Rgf0vSUzuE6BndO9kzkUaskTkQWt/VM=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-248-VI23VYtMNHG7GgGXvoSg4g-1; Tue,
 25 Mar 2025 13:24:28 -0400
X-MC-Unique: VI23VYtMNHG7GgGXvoSg4g-1
X-Mimecast-MFC-AGG-ID: VI23VYtMNHG7GgGXvoSg4g_1742923464
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BB89B180AF52;
	Tue, 25 Mar 2025 17:24:24 +0000 (UTC)
Received: from asrivats-na.rmtustx.csb (unknown [10.2.16.186])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6EDCE180A802;
	Tue, 25 Mar 2025 17:24:22 +0000 (UTC)
From: Anusha Srivatsa <asrivats@redhat.com>
Date: Tue, 25 Mar 2025 13:24:11 -0400
Subject: [PATCH 4/5] drm/panel: deprecate old-style panel allocation
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250325-b4-panel-refcounting-v1-4-4e2bf5d19c5d@redhat.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1742923451; l=1073;
 i=asrivats@redhat.com; s=20250122; h=from:subject:message-id;
 bh=A+LU5lgwdNhiA1Kyn1XfW5gM4lg/FJ5Fagf5T/rOWc4=;
 b=K9aJBhUC+EevWim2Moo3gSH2V6CmaEQO37I9AS4oIlot73QvPQhsPCDYe76uoIwwY5sdYE0Vf
 xsHnsK9OkxuC1jzj+/0sT/JFzHAJg8qKt3YIrfuM28TgspaY53KqmO2
X-Developer-Key: i=asrivats@redhat.com; a=ed25519;
 pk=brnIHkBsUZEhyW6Zyn0U92AeIZ1psws/q8VFbIkf1AU=
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Start moving to the new refcounted allocations using
the new API devm_drm_panel_alloc(). Deprecate any other
allocation.

Signed-off-by: Anusha Srivatsa <asrivats@redhat.com>
---
 drivers/gpu/drm/drm_panel.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/drm_panel.c b/drivers/gpu/drm/drm_panel.c
index 11a0415bc61f59190ef5eb378d1583c493265e6a..5793011f4938a2d4fb9d84a700817bda317af305 100644
--- a/drivers/gpu/drm/drm_panel.c
+++ b/drivers/gpu/drm/drm_panel.c
@@ -74,8 +74,10 @@ EXPORT_SYMBOL(drm_panel_init);
  * drm_panel_add - add a panel to the global registry
  * @panel: panel to add
  *
- * Add a panel to the global registry so that it can be looked up by display
- * drivers.
+ * Add a panel to the global registry so that it can be looked
+ * up by display drivers. The panel to be added must have been
+ * allocated by devm_drm_panel_alloc(). Old-style allocation by
+ * kzalloc(), devm_kzalloc() and similar is deprecated.
  */
 void drm_panel_add(struct drm_panel *panel)
 {

-- 
2.48.1


