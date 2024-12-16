Return-Path: <linux-kernel+bounces-447709-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9600A9F364B
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 17:41:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4578D1883BFD
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 16:41:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B453920457E;
	Mon, 16 Dec 2024 16:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="bFHND2C2"
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7266114EC62
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 16:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734367274; cv=none; b=NHKK2Bu3FUidlrYvccYtiH8IuwClxu07Fywc0wFjFrM0l9pOM4w5ajEG6WohuHAOirnm/nJZ2D5fdn1jaLxUQgZlYHJcX47RuoAUsomjnzFUzaNNfsdxS15HO5AQyUOiw2zPVhByD/5WqO1A4aUC4cOd+jpnDCr0QtPbjcoY71k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734367274; c=relaxed/simple;
	bh=kSdWZv45BDDhUC24J4bi6/wPp6QjTa1J8EaAUgQHctE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rO7iXRROqNCOGQqxyGXaQNSreolycxXe6mparc8EtePjn3dgAfJdQ1iqv7dqqvq6qhrGC9Ku9fntZ3ku9FvEFEXjhqJ93O/fluzJfUlEQS79ilpXUOe5/7ygqWJDOAFUQ9Bg4E6sAb1k38Dw5M6nIewxvqXSx5B1T2J84SJ3VQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=bFHND2C2; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id B4AC9E000E;
	Mon, 16 Dec 2024 16:41:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1734367270;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Gr5nT2Jnw+/2OVk2gGwP/gOTe4r8NyAUC5u+F+sceZw=;
	b=bFHND2C2mCjVfFmvgtYTrE9l4QjIlqVzSC3EiYV3vZlKWQfkpURtHJXHOTt8iFvYDSwM9s
	T8tVET48Pp+6JWLGs7lzo5AwyYT5ylSf37dVX9rkQSPxRvruQzFxFV43KFzrdcwtgN4N4l
	vdrhgrh72oElFMmtukaD69YAMIUsmhaYq9jBOtF4IVpe+2MLwVteWAgyoRTmKI/c3uGDAT
	4u479LHnpXjuvyG1bQtS1tKqZ7x4Mh4PgqfO0J2DMo4LtkltZzILNF/vetjVblQMpOWV8g
	umsyCPZyP9wgqmtj9Hb8FkrWwdVQaxifnSJHfPGOF44YmpYKsxyU0rx4jKdTYA==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Date: Mon, 16 Dec 2024 17:40:49 +0100
Subject: [PATCH RESEND v3 2/4] drm/atomic-helper: improve CRTC
 enabled/connectors mismatch logging message
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241216-drm-small-improvements-v3-2-78bbc95ac776@bootlin.com>
References: <20241216-drm-small-improvements-v3-0-78bbc95ac776@bootlin.com>
In-Reply-To: <20241216-drm-small-improvements-v3-0-78bbc95ac776@bootlin.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
 Jani Nikula <jani.nikula@linux.intel.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Louis Chauvet <louis.chauvet@bootlin.com>
X-Mailer: b4 0.14.2
X-GND-Sasl: luca.ceresoli@bootlin.com

This message reports a mismatch between new_crtc_state->enable and
has_connectors, which should be either both true or both false. However it
does not mention which one is true and which is false, which can be useful
for debugging. Add the value of both avriables to the log message.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
---
 drivers/gpu/drm/drm_atomic_helper.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/drm_atomic_helper.c b/drivers/gpu/drm/drm_atomic_helper.c
index 43cdf39019a44537794cc5a519d139b0cb77073c..3c3bdef9bcf3c4ffcd861744f6607f317ab0c041 100644
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


