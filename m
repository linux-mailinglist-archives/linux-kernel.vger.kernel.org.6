Return-Path: <linux-kernel+bounces-371935-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E45A9A4250
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 17:27:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2D891F252E3
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 15:27:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DC622022D6;
	Fri, 18 Oct 2024 15:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="gfwoivWF"
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEC021FCF64
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 15:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729265218; cv=none; b=kvz1pdseyqISy8PEtBTbngQ20GHOOa/cZwPPxArW+U8gvYbKoPCUbS7abMMh3pvSLC3W4RIxTGCFeiWxiYoUqubWw6K8fWqyfZzYaz2jh2jMleInZ0LOMC30bBOE1NAWkfLrW+zhsfv/RDbFIF/Dh+LlPH/th3u40igKhGEgDW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729265218; c=relaxed/simple;
	bh=wTgUMBJZregR1HY6OaPjtC46CJqMzkb6K+Uyrrm295c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GI/JjxW/iqWaIMSFDIiPO6zi88CZhmLru0Q7seQmg6twmOvwYWOwGfUf/vBjFULKyRcLQ0S4lLHIDZAPPFY4kHVuPMWDLfaaCuQC9omAAM7XB8lYjnG24EPRQbAupct2MEk088XYMaCjneK0i52BUf5zgP29hc5eOVB0lfeo8uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=gfwoivWF; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 618361BF20B;
	Fri, 18 Oct 2024 15:26:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1729265215;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FGK9fEgqI+13HgE5VhXXxqWGt4Xoy4ktT4WvsnSGxdc=;
	b=gfwoivWFx8APqHTwPluRpdOziuW8xr69rPjImANC0BvOuePgwpY6IkDjfzUGvafXJb7mc9
	/dltg/JRZTaf6Ysh70FpyuCmn5eOA1FE2xh70vD/Bc/nDFHp6snQ4g0IkvszUaY6OEsK1X
	w5KvOUzzvt9GU46h9Gu5nK03y+iPCKKzEz1PGP/exW7f1Jxdj6DVeEb5xKbpd8Q7LUT1zX
	g75Hv1nddmzE+RN2QCgy7qoaJ3tVlumtbXaUFrcXiF5kFFEYiee4gmHCWWPJTY9xggY9JS
	B+oYDxi+Z/65tq/+ha/zNyekTUv3nAPbqNF0OtNcpYW39kXMgMf23rEyDUZZ7A==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Date: Fri, 18 Oct 2024 17:26:52 +0200
Subject: [PATCH 2/2] drm/atomic-helper: improve CRTC enabled/connectors
 mismatch logging message
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241018-drm-small-improvements-v1-2-cc316e1a98c9@bootlin.com>
References: <20241018-drm-small-improvements-v1-0-cc316e1a98c9@bootlin.com>
In-Reply-To: <20241018-drm-small-improvements-v1-0-cc316e1a98c9@bootlin.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>
X-Mailer: b4 0.14.1
X-GND-Sasl: luca.ceresoli@bootlin.com

This message reports a mismatch between new_crtc_state->enable and
has_connectors, which should be either both true or both false. However it
does not mention which one is true and which is false, which can be useful
for debugging. Add the value of both avriables to the log message.

Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
---
 drivers/gpu/drm/drm_atomic_helper.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/drm_atomic_helper.c b/drivers/gpu/drm/drm_atomic_helper.c
index 43cdf39019a4..3c3bdef9bcf3 100644
--- a/drivers/gpu/drm/drm_atomic_helper.c
+++ b/drivers/gpu/drm/drm_atomic_helper.c
@@ -666,8 +666,9 @@ drm_atomic_helper_check_modeset(struct drm_device *dev,
 		}
 
 		if (new_crtc_state->enable != has_connectors) {
-			drm_dbg_atomic(dev, "[CRTC:%d:%s] enabled/connectors mismatch\n",
-				       crtc->base.id, crtc->name);
+			drm_dbg_atomic(dev, "[CRTC:%d:%s] enabled/connectors mismatch (%d/%d)\n",
+				       crtc->base.id, crtc->name,
+				       new_crtc_state->enable, has_connectors);
 
 			return -EINVAL;
 		}

-- 
2.34.1


