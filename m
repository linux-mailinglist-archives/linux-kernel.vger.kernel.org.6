Return-Path: <linux-kernel+bounces-552855-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F453A57FE5
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 00:44:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E1773B029E
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 23:44:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDCD11B4F08;
	Sat,  8 Mar 2025 23:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="oZ/g9b/J"
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7B381A3177
	for <linux-kernel@vger.kernel.org>; Sat,  8 Mar 2025 23:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741477476; cv=none; b=CWWeSaStvgPVZNOfp+ojotPwq1GVJ/DC5lEiIzvTjzFx633ZX3gLI50BhnBC5s94VgKqoY64cI1lp2Rka5sIV6UN+gRzF/CZXguCta1yMxVG/KlQcxTG96lXbs9fE9r2wunXAy138rjeH9/0Fz5kNbGeo0v+/VmWgWPa6QYnSkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741477476; c=relaxed/simple;
	bh=5n+U689q3p5e2ChF/H4lRTmn+Y8EFyxdg2R8N6J4Hr0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aRq21sOxhT9rI+Jt53GU87VXRDqKuTeINCH4GXl4AZcfPoEL795TXl+f1FZsXvX3ox/dNTuIwViIY32dHmRZXKA2VB5yeTe6LyMw+MawmUlCXEvs6BDb/fReFfuyAzY4CuOkv6xtnEZK8DekibxkRQuHuq+NSSUafP0sPs5AxJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=oZ/g9b/J; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=LFSdD4kJ7yJc6B+RnrYL9iqh3L8Tq6imwJSAk9Z8eLU=; b=oZ/g9b/JQEXaZehe
	GpFGXO0MdL/YPTAiXJ1zTBONKDn6qIv/2PUcvoASEGQetPPS4Vlt2r/fuBCPpEVOt4p4kyrdlP9dj
	FcNIhiC8m/0ZrFxNj+idcnhToTOHhf8npyDIrgLyhTJe+07is+b3GC3JytqgTN3ABeMUU5FdmW/qb
	mbFmk64b/oCE5zj9odHezNnG77Sw7/W/EO7tP0RgptJohO+as1/eM/rsp8mifwgQsaZImTAXlg8Lh
	LMqQjl2iJUdDyuLo0WuR/Ca+CCGX0ECLk2FQHY8uXYP91PZnBZsQRqK8yzQUp+ngy+Pq2fzsnL1Ad
	aH+ZuSOlT4X4FrYKZQ==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1tr3qH-003f1I-0L;
	Sat, 08 Mar 2025 23:44:29 +0000
From: linux@treblig.org
To: patrik.r.jakobsson@gmail.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de
Cc: airlied@gmail.com,
	simona@ffwll.ch,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH] drm/gma500: Remove unused psb_mmu_virtual_to_pfn
Date: Sat,  8 Mar 2025 23:44:28 +0000
Message-ID: <20250308234428.255164-1-linux@treblig.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

psb_mmu_virtual_to_pfn() was added in 2011 by
commit 8c8f1c958ab5 ("gma500: introduce the GTT and MMU handling logic")
but hasn't been used.

Remove it.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 drivers/gpu/drm/gma500/mmu.c | 41 ------------------------------------
 drivers/gpu/drm/gma500/mmu.h |  2 --
 2 files changed, 43 deletions(-)

diff --git a/drivers/gpu/drm/gma500/mmu.c b/drivers/gpu/drm/gma500/mmu.c
index 4d78b33eaa82..e6753282e70e 100644
--- a/drivers/gpu/drm/gma500/mmu.c
+++ b/drivers/gpu/drm/gma500/mmu.c
@@ -730,44 +730,3 @@ int psb_mmu_insert_pages(struct psb_mmu_pd *pd, struct page **pages,
 
 	return ret;
 }
-
-int psb_mmu_virtual_to_pfn(struct psb_mmu_pd *pd, uint32_t virtual,
-			   unsigned long *pfn)
-{
-	int ret;
-	struct psb_mmu_pt *pt;
-	uint32_t tmp;
-	spinlock_t *lock = &pd->driver->lock;
-
-	down_read(&pd->driver->sem);
-	pt = psb_mmu_pt_map_lock(pd, virtual);
-	if (!pt) {
-		uint32_t *v;
-
-		spin_lock(lock);
-		v = kmap_atomic(pd->p);
-		tmp = v[psb_mmu_pd_index(virtual)];
-		kunmap_atomic(v);
-		spin_unlock(lock);
-
-		if (tmp != pd->invalid_pde || !(tmp & PSB_PTE_VALID) ||
-		    !(pd->invalid_pte & PSB_PTE_VALID)) {
-			ret = -EINVAL;
-			goto out;
-		}
-		ret = 0;
-		*pfn = pd->invalid_pte >> PAGE_SHIFT;
-		goto out;
-	}
-	tmp = pt->v[psb_mmu_pt_index(virtual)];
-	if (!(tmp & PSB_PTE_VALID)) {
-		ret = -EINVAL;
-	} else {
-		ret = 0;
-		*pfn = tmp >> PAGE_SHIFT;
-	}
-	psb_mmu_pt_unmap_unlock(pt);
-out:
-	up_read(&pd->driver->sem);
-	return ret;
-}
diff --git a/drivers/gpu/drm/gma500/mmu.h b/drivers/gpu/drm/gma500/mmu.h
index d4b5720ef08e..e6d39703718c 100644
--- a/drivers/gpu/drm/gma500/mmu.h
+++ b/drivers/gpu/drm/gma500/mmu.h
@@ -71,8 +71,6 @@ extern int psb_mmu_insert_pfn_sequence(struct psb_mmu_pd *pd,
 				       uint32_t start_pfn,
 				       unsigned long address,
 				       uint32_t num_pages, int type);
-extern int psb_mmu_virtual_to_pfn(struct psb_mmu_pd *pd, uint32_t virtual,
-				  unsigned long *pfn);
 extern void psb_mmu_set_pd_context(struct psb_mmu_pd *pd, int hw_context);
 extern int psb_mmu_insert_pages(struct psb_mmu_pd *pd, struct page **pages,
 				unsigned long address, uint32_t num_pages,
-- 
2.48.1


