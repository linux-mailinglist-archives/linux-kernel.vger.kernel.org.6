Return-Path: <linux-kernel+bounces-398061-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 97E489BE4C9
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 11:51:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C5E0281629
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 10:51:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 163B61E04B5;
	Wed,  6 Nov 2024 10:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="iwmaAYVc"
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63BA61DED75
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 10:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730890130; cv=none; b=KoKHhvAAvWWKd2Fisful5XKS8U79QWfsRptwcztqNAVlEH0SYfX4ixkhJt7qsBf/uLm/bdWrNCKnm/drClvIkNH203lio8AjFDFkKVrhrUTB7tVjB2PbQrEl7QlE21D6xUhQ3a6UyOH3ZNwdT4JUIZoYiva0+B3togcwe4Gi/5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730890130; c=relaxed/simple;
	bh=Ar5XcHYjGMdPKGP6HDRcTQA2Or08PdX9Ib9xsuXrf8M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=o1Ay4tA4c9fjA2VWhYQVNVhpyfK7wIDnejOe8QM5luSyMt6saqmW3uZ0uULcfNNm/4JK4fokuHQI9yREe4MW3FdS+N6eiGXh7WxxZ3DbN4UO1kazeOOxrzwazic4346P0Jp6XRj4tNU8rlX9eCo2aXEcLxp5qct+8HfncHzZYfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=iwmaAYVc; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id EB5D560004;
	Wed,  6 Nov 2024 10:48:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1730890123;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BCLa0tO35kgSJnAc+IEReJ7llWiZ9cXdN6mBzaWALkE=;
	b=iwmaAYVcgo+NHt/egv/3PkjhMCjvpztcz+EeVbCapBLbwFRLH5OqjT5Mzck1Y4H40/HLn+
	fpfr3r9+z4vLBtlm58VyKfv+PDXdiJk+gyFZ9npIM4jpZXbgM7bZ93d4wAmG3Lpp8yyM4O
	70zcbYFYoFL1LFWWLNWf3Cj/63Sd0AsTmVQg9rCdadKkkJ91ZKBVf5Q7yMfq9B/8cbVKjg
	SYDc90FGwNBWEuz6yAEcFSYt5l2huPNwLlZm5VlrrpXaIJbFL87vItKN/mrOZVW6bRnCOR
	QU6IcbukSn9avYdZ/YpOeBfDn2yjml+3yg8y440KeAxG8E9OBBmspsthqC7kjg==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Date: Wed, 06 Nov 2024 11:48:25 +0100
Subject: [PATCH v2 2/4] drm/atomic-helper: improve CRTC enabled/connectors
 mismatch logging message
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241106-drm-small-improvements-v2-2-f6e2aef86719@bootlin.com>
References: <20241106-drm-small-improvements-v2-0-f6e2aef86719@bootlin.com>
In-Reply-To: <20241106-drm-small-improvements-v2-0-f6e2aef86719@bootlin.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>
X-Mailer: b4 0.14.2
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


