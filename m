Return-Path: <linux-kernel+bounces-336408-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4A0C983A7E
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 01:49:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85F24283BBF
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 23:49:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C857612CDBA;
	Mon, 23 Sep 2024 23:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="JC+ko8oq"
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD3412907
	for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 23:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727135382; cv=none; b=dvUHPw3usNSSk6vp46YeuQnj4kXdL3BlIGruvzNufHEv7t8E/3IyFtjpi2cO5d6/zpBNKgKp3CAVMbgjG1HnAq/jWHD2wNWveViDMj1UzIBzU4orVnB+xWuWxHoFWfLZ9xlh3nv7vMPsEtWIr9IV4qio7Evp3qmxpALTz0cVTNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727135382; c=relaxed/simple;
	bh=Ecf9w+e01+sq6jgIrA3EgI80df1KuNB4w2B7/z5pTtE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gLAIabanh57LH1s7UZay4xt/KvCvfDtW4Xfxa4oxUGOjcTYGCR3wllek5jQx+KK3CTZvqUv8MTUrRQZC5AWtFthcsyxO2fTVW5oRjiZ2hx7z5rmVD+rGf5Kfouaws2aaPVAOtci02ekybIu54P8nZT+TTItrkNpiMQ7YlcfGM4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=JC+ko8oq; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1727135377;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=rDdO/5vF6ykhIVNsYXGYgfmGlQo19Ylf96enkGpatXQ=;
	b=JC+ko8oqNj0vJCSlFt89UXWkK5Pfq5t5GaRASiIYpZVa4vyF8eFbq1SGhsqbFVSWGtK8xQ
	Us4tzF4750mvUT4fh0L7PbjJv0kYYc1nNhtVo1xZQJ44dCOIOVgD7ko9C2PBqWMjnvTu0G
	ZZNM+kk+DgX1dAwIrZlq3sLaAQG31qo=
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
Subject: [PATCH] drm/vmwgfx: Remove unnecessary NULL checks before kvfree()
Date: Tue, 24 Sep 2024 01:46:41 +0200
Message-ID: <20240923234638.236319-5-thorsten.blum@linux.dev>
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
2.46.1


