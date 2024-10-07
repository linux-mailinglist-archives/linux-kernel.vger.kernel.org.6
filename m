Return-Path: <linux-kernel+bounces-353229-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C2A5A992ACD
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 13:52:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F9B0280FC4
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 11:52:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B620A1D1302;
	Mon,  7 Oct 2024 11:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ZAx40C6b"
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28B2318A6AD
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 11:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728301937; cv=none; b=eMlDD7LoCGkGy8EuoXdYtGie0uYqZhd1FqL+HeYFlQ7uGmXsJfIuscaD79TWvaD+XrSR/F2BJr8VcJffd9uSezfbyP4TyndoYBxNtThBrjN2bFiyHtOjcT1j388m4UeMNH2Y4tIZYt/ctHtvZcbMfgvsZChoA7L83Q70TzREbLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728301937; c=relaxed/simple;
	bh=6LeBGqTxN8uuATCMQW/12XJFuDpvDJOzpQJuePUC4n8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dQhMo6K582uKHByAeRc4J4kbPRDCbGlsr1O7iqWxqtrBxe2r+FDJ7+MkEMxmD/WNb0qsvGxJEWpQuxq8jGI2aezJFPxNHbtkF4YWzg5IS2+xMSSmJinxp8aOY4gUvjr3pbkPc74YA3DpCUVXtBJtb/UnDJiigrZe/3xoiI2jPUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ZAx40C6b; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1728301932;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=viQ13pmTPlAVs6SlErEUxS34ERLAOpusxyXGHtUEynM=;
	b=ZAx40C6b3+icNhpepjoWGjpGGDVTD9u6rwTN4c3eqX9AZ4w51eyuwgWe3rd7LDdP7yCm5y
	DAhlbEQTDvCB60gmztdIUjqC4d5DoqhFKww845GvBHzid3e+7f5OlRLCZGZllLyLRzgWFE
	R6qEtNEo8gNjzlt1Wl/YfJIXEktYDD0=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Zack Rusin <zack.rusin@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [RESEND PATCH] drm/vmwgfx: Remove unnecessary NULL checks before kvfree()
Date: Mon,  7 Oct 2024 13:51:32 +0200
Message-ID: <20241007115131.1811-3-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Since kvfree() already checks if its argument is NULL, an additional
check before calling kvfree() is unnecessary and can be removed.

Remove both and the following Coccinelle/coccicheck warnings reported by
ifnullfree.cocci:

  WARNING: NULL check before some freeing functions is not needed
  WARNING: NULL check before some freeing functions is not needed

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 drivers/gpu/drm/vmwgfx/vmwgfx_blit.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_blit.c b/drivers/gpu/drm/vmwgfx/vmwgfx_blit.c
index 890a66a2361f..64bd7d74854e 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_blit.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_blit.c
@@ -635,10 +635,8 @@ int vmw_bo_cpu_blit(struct vmw_bo *vmw_dst,
 		kunmap_atomic(d.src_addr);
 	if (d.dst_addr)
 		kunmap_atomic(d.dst_addr);
-	if (src_pages)
-		kvfree(src_pages);
-	if (dst_pages)
-		kvfree(dst_pages);
+	kvfree(src_pages);
+	kvfree(dst_pages);
 
 	return ret;
 }
-- 
2.46.2


