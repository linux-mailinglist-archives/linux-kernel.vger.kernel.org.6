Return-Path: <linux-kernel+bounces-177456-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 525B08C3F00
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 12:38:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F1301F21DCC
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 10:38:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A92C51465AC;
	Mon, 13 May 2024 10:37:54 +0000 (UTC)
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2203E31A67
	for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 10:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715596674; cv=none; b=EOKY7oQsUNeYT06LxElJlzduQSFBd43d57/957UidKqlGELHaxerpjRlKmKukwJWDvcSZ+WNORoyVKX8qw0ShE4tkM1ACVRgOEA6Z+cGV19lowwAEzlsXjKN2UiVFfRSczA2NSD9/xu8OOXq9s1d9qgNv5HWIL9UFYbYNNnSvHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715596674; c=relaxed/simple;
	bh=bDn8OyW4sG4kceNzTwND2nLqSNDXzbk6gIp12v3wzt0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DuuoHDNlr5WW6yTEUkU/G/jk+zdiBCvJnFCzv1chDLhFJ4O7WLndtGvnaeek2iYzu9KV+SbApvx6JsR3HGDJhTYKRk2GVCehaSnnl2f9sGAFojXvYodiRfA49QNzexg/E7jkvkNYsM+a8/X5DTcAp3RKFy+2efXQdehhfl+PxqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from abreu.molgen.mpg.de (g34.guest.molgen.mpg.de [141.14.220.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 7B18161E5FE01;
	Mon, 13 May 2024 12:36:59 +0200 (CEST)
From: Paul Menzel <pmenzel@molgen.mpg.de>
To: Jani Nikula <jani.nikula@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>
Cc: Paul Menzel <pmenzel@molgen.mpg.de>,
	intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] drm/i915/fbc: Add sizes to info message about reducing fb size
Date: Mon, 13 May 2024 12:36:51 +0200
Message-ID: <20240513103652.371721-1-pmenzel@molgen.mpg.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The info message currently does not contain any information, how much
the stolen memory size should be increased.

    [drm] Reducing the compressed framebuffer size. This may lead to less power savings than a non-reduced-size. Try to increase stolen memory size if available in BIOS.

To be more useful to the user, add the sizes to the message.

Signed-off-by: Paul Menzel <pmenzel@molgen.mpg.de>
---
 drivers/gpu/drm/i915/display/intel_fbc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/display/intel_fbc.c b/drivers/gpu/drm/i915/display/intel_fbc.c
index b453fcbd67da..e4a5d251013f 100644
--- a/drivers/gpu/drm/i915/display/intel_fbc.c
+++ b/drivers/gpu/drm/i915/display/intel_fbc.c
@@ -801,7 +801,8 @@ static int intel_fbc_alloc_cfb(struct intel_fbc *fbc,
 		goto err_llb;
 	else if (ret > min_limit)
 		drm_info_once(&i915->drm,
-			      "Reducing the compressed framebuffer size. This may lead to less power savings than a non-reduced-size. Try to increase stolen memory size if available in BIOS.\n");
+			      "Reducing the compressed framebuffer size from %d bytes to %d bytes. This may lead to less power savings than a non-reduced-size. Try to increase stolen memory size if available in BIOS.\n",
+			      min_limit, ret);
 
 	fbc->limit = ret;
 
-- 
2.43.0


