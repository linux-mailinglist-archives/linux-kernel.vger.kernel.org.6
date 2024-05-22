Return-Path: <linux-kernel+bounces-186582-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 015C98CC5F4
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 19:59:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 80D2AB21ACB
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 17:59:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E722D145B17;
	Wed, 22 May 2024 17:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="RO7l+xWm"
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7BDC145FF6
	for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 17:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716400731; cv=none; b=d7ygZM6TjB5EMONfbX6NRV8mZuKBsmVjsPNUmdbbFhGzjrCSxElrFkkufxSX2Kr/oZSs040Ap98tZwUVioohydi+M18+GVUXqqVcCYtAPAtVr7jbXTYUuKihEkANQBMHNoFa7x+Zw8pE//spSRuCpL4y01mblr1/wDCvyTDhkwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716400731; c=relaxed/simple;
	bh=JSigu62ltqLJCXUWDafIf56Zq1mZCARO6az4/E7iy70=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jPlp63YbdbHjkSTZOnDNSuK0jJElsVREaNURnXLofUl3fCq84e7lvYKlC6bANzRx3rhy1mCWE0uZ4k2sV5RxbVrs6583v4DCf6uEsmh4NGzy6a79IpygS03mCpyR/4kgW2CdZnSNKhGqJ0NnmMm85lq5gcVBmLP762C+6ARyY2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=RO7l+xWm; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=Wbd6zrA/kHzFGZUfOfAivCujWYrNUgCo+i5BpHmbrpQ=; b=RO7l+xWmNB/ayxPi
	tk47ep9m8n4rhaVvauBOexM6xSFIm69KE5wgl+cFv8EexhJykSUZ2o65t4QmBMStXkVtfGw3cI/b6
	q3HyvuFpOJqC7pZLLwkzAZPdo9NcRdibgbguQSRvnHQUkqwB69V6dmAQfPFqvbMQQKb1d3yysRM6Q
	4ePvQe7e/xSZvQ/sHHykf2guysjaAPFr5vsFa4v2sHbEUBcEHCsRBSwpPopXQcN0JGMCTu3DGDMkU
	QWR4+aMz589J5VxBA4pAn6qAW4DyaTCIZrlfmxTQR0NFhzY+oMUcsdYsUubXuTNLrWWufrAC6L9z0
	CkwDOnwnS/QyZwOt1g==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1s9qEb-0025bK-2J;
	Wed, 22 May 2024 17:58:42 +0000
From: linux@treblig.org
To: matthew.d.roper@intel.com,
	lucas.demarchi@intel.com
Cc: maarten.lankhorst@linux.intel.com,
	airlied@gmail.com,
	intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH] drm/xe: remove unused struct 'xe_gt_desc'
Date: Wed, 22 May 2024 18:58:40 +0100
Message-ID: <20240522175840.382107-1-linux@treblig.org>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

'xe_gt_desc' is unused since
commit 1e6c20be6c83 ("drm/xe: Drop extra_gts[] declarations and
XE_GT_TYPE_REMOTE").

Remove it.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 drivers/gpu/drm/xe/xe_pci.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_pci.c b/drivers/gpu/drm/xe/xe_pci.c
index f326dbb1cecd..2ca210480bd1 100644
--- a/drivers/gpu/drm/xe/xe_pci.c
+++ b/drivers/gpu/drm/xe/xe_pci.c
@@ -40,12 +40,6 @@ struct xe_subplatform_desc {
 	const u16 *pciidlist;
 };
 
-struct xe_gt_desc {
-	enum xe_gt_type type;
-	u32 mmio_adj_limit;
-	u32 mmio_adj_offset;
-};
-
 struct xe_device_desc {
 	/* Should only ever be set for platforms without GMD_ID */
 	const struct xe_graphics_desc *graphics;
-- 
2.45.1


