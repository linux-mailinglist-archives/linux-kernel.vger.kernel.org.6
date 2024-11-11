Return-Path: <linux-kernel+bounces-404048-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E4DE69C3E86
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 13:36:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C30E1F2247C
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 12:36:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A692919D881;
	Mon, 11 Nov 2024 12:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Uq6BOQts"
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06891158DC8
	for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 12:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731328591; cv=none; b=Zvnk9CYf3QPvi6/jD5DtX+Onbc8keWPlyw4qm4qJDHYATdZ6c4HNSJby9F8jalzFQs0VgQ8t5S7miqrfXgg0jfeBfgGDA6sUs9Gh7pglE1TXc3WXp8OQn+AK5RxOejlut3O+NqweDeJPgsQiXNqWQCGW7ptWJYtPxVcaPUdsls8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731328591; c=relaxed/simple;
	bh=kSdWZv45BDDhUC24J4bi6/wPp6QjTa1J8EaAUgQHctE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sWWBLoFU5C9EOLVV4d88AgTpVuw8Vb4vVyzIRYwTJGNQ/jPMAYfJpCIpk2EXJuyTXh5lg8W6R6vNxPRTq2/rIdVMcAWGzOCin4XaKZ50Ufb8ZQXoD9xStjgDoMOYugWQsnUPktFieNY5TqGELGwmoki04MmdOF8Gqm1m6xXvJrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Uq6BOQts; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 998591BF203;
	Mon, 11 Nov 2024 12:36:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1731328587;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Gr5nT2Jnw+/2OVk2gGwP/gOTe4r8NyAUC5u+F+sceZw=;
	b=Uq6BOQtsHDIpjZ9LkBuzskd99TUcAEiOpsOoOXabdCdqVuSs0jba+kLLwlYzoI4As921Qc
	G1zRVfYyWJqtp5ebcCmTbVSJ9COqlpLfqlK1e8DA61uHhgNVFMozglBSY+BhwtPDgrwp68
	RRPp1X+xOvAydUXvDfDXt1iM7gJCY0eX2L5jbaNJ1nyPrtx2PL4mxlRLzjOF8QwuNQuN/L
	Kbd3zo5BfaxzcLMCZ9SaZmdYizBlwXklp0Q3ZhbKcfg5fDAw/IY05N6fDT1zSt7fVrDMEh
	3fX1gAkvKKGfwVjMiL4/S51jRIkpMt7WLUpSycSByRVKiT5feYBTGF41NUBg5A==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Date: Mon, 11 Nov 2024 13:36:21 +0100
Subject: [PATCH v3 2/4] drm/atomic-helper: improve CRTC enabled/connectors
 mismatch logging message
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241111-drm-small-improvements-v3-2-a9f576111b41@bootlin.com>
References: <20241111-drm-small-improvements-v3-0-a9f576111b41@bootlin.com>
In-Reply-To: <20241111-drm-small-improvements-v3-0-a9f576111b41@bootlin.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
 Jani Nikula <jani.nikula@linux.intel.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>
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


