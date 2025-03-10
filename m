Return-Path: <linux-kernel+bounces-554995-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9401A5A446
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 21:00:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A96A3A8761
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 20:00:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C90371DE4E0;
	Mon, 10 Mar 2025 20:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=ariel.dalessandro@collabora.com header.b="TKCbmJJX"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E2061DE899
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 20:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741636827; cv=pass; b=KHxYFNSXwNkkXEYQCUInXOBbCrseejPjdlRK1m7UxVE0GzkC+ls4zJWIQUcWHlDUKluL6wkvMsYRxKeWnsnvDlXtEreuI4QbXsLmVT9LFoMoFVHfnzqy+dw7Rv2clzO+TG38zczVNw84OcZ58oWg28+5jkkWFG0TCf1otEI3K/M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741636827; c=relaxed/simple;
	bh=Y6FGRDriAY0EJ5RtU5LWQBBW6zj3xIbKdVhhyiDcgxA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Jqy602hTNTn5kWa365nD1NJem8dn23KFcPpvf2ys/6pvgiK8mSZrOyElT3IYKzHD/2ORw4RFEGA81l4LZ5fbJoz47mMvqnysXdz+fKX+Ag3675nHyC3W4wUYv3n6LriaE0QaOM8jJZsX47gQv4mAnXEesH2pMXz5OTS5KymQc0k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=ariel.dalessandro@collabora.com header.b=TKCbmJJX; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1741636806; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Didrex8uRpE34xQet91uiVU/940LLu6uZ2qqwKaBvg5Zvph5e3cSv049gp2z91mIZBRhtXpqjXT5tmEgFIM9aIT09uy8CQBZF/pgsZyvdBEKSN7zKv/Gfi5STM7NC+zUswVIrKnrbze26Km70DcHTxfDJalOlJwcrWIi4954MA8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1741636806; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=2zhv36KL2NS19H8dU1GGarEClA3dye5rhXTkWyrsrIE=; 
	b=RKfva+Ef4FJOBrt35N/BIFcpVtV0gOcvA1ZHdlSzrAwmE9cbJm4qoDqyR+bPV3YqxKbPGP+9mYVFp7WOtC/hG5aTwqLdOjxk/FdhiJrRHkbjVlFKc+jCERjwrFAJgsnLFhNGZPouAeO9+AraCStMEa/rFZzStzHjt90mYNOchnI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=ariel.dalessandro@collabora.com;
	dmarc=pass header.from=<ariel.dalessandro@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1741636805;
	s=zohomail; d=collabora.com; i=ariel.dalessandro@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=2zhv36KL2NS19H8dU1GGarEClA3dye5rhXTkWyrsrIE=;
	b=TKCbmJJXGqx2hwYssKFXHjMcEtoS6TrLM95ti+VBMg/NmmodRObFBkuqF5G7esS+
	4RoCoAfqTYjF2C3gpRhkDF2sWihCIrHky7EDO9erY+sopQrh50+q4QK7xsetGNgZiqI
	BKK/ZaHeuhqeEuoZeHqsrFzjjxQHe2rxbH3k8Fg4=
Received: by mx.zohomail.com with SMTPS id 1741636804736523.5407434249297;
	Mon, 10 Mar 2025 13:00:04 -0700 (PDT)
From: Ariel D'Alessandro <ariel.dalessandro@collabora.com>
To: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Cc: boris.brezillon@collabora.com,
	robh@kernel.org,
	steven.price@arm.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch,
	kernel@collabora.com,
	linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	sjoerd@collabora.com,
	Ariel D'Alessandro <ariel.dalessandro@collabora.com>
Subject: [PATCH v1 3/6] drm/panfrost: Unify panfrost_mmu_enable/disable common code
Date: Mon, 10 Mar 2025 16:59:18 -0300
Message-ID: <20250310195921.157511-4-ariel.dalessandro@collabora.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250310195921.157511-1-ariel.dalessandro@collabora.com>
References: <20250310195921.157511-1-ariel.dalessandro@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Both these functions write to MMU_AS_CONTROL register in the same way.
Define a common _panfrost_mmu_as_control_write function with the shared
code.

Signed-off-by: Ariel D'Alessandro <ariel.dalessandro@collabora.com>
---
 drivers/gpu/drm/panfrost/panfrost_mmu.c | 33 ++++++++++++-------------
 1 file changed, 16 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/panfrost/panfrost_mmu.c b/drivers/gpu/drm/panfrost/panfrost_mmu.c
index 294f86b3c25e7..31df3a96f89bd 100644
--- a/drivers/gpu/drm/panfrost/panfrost_mmu.c
+++ b/drivers/gpu/drm/panfrost/panfrost_mmu.c
@@ -121,38 +121,37 @@ static int mmu_hw_do_operation(struct panfrost_device *pfdev,
 	return ret;
 }
 
-static void panfrost_mmu_enable(struct panfrost_device *pfdev, struct panfrost_mmu *mmu)
+static void
+_panfrost_mmu_as_control_write(struct panfrost_device *pfdev, u32 as_nr,
+			       u64 transtab, u64 memattr)
 {
-	int as_nr = mmu->as;
-	struct io_pgtable_cfg *cfg = &mmu->pgtbl_cfg;
-	u64 transtab = cfg->arm_mali_lpae_cfg.transtab;
-	u64 memattr = cfg->arm_mali_lpae_cfg.memattr;
-
 	mmu_hw_do_operation_locked(pfdev, as_nr, 0, ~0ULL, AS_COMMAND_FLUSH_MEM);
 
 	mmu_write(pfdev, AS_TRANSTAB_LO(as_nr), lower_32_bits(transtab));
 	mmu_write(pfdev, AS_TRANSTAB_HI(as_nr), upper_32_bits(transtab));
 
-	/* Need to revisit mem attrs.
-	 * NC is the default, Mali driver is inner WT.
-	 */
 	mmu_write(pfdev, AS_MEMATTR_LO(as_nr), lower_32_bits(memattr));
 	mmu_write(pfdev, AS_MEMATTR_HI(as_nr), upper_32_bits(memattr));
 
 	write_cmd(pfdev, as_nr, AS_COMMAND_UPDATE);
 }
 
-static void panfrost_mmu_disable(struct panfrost_device *pfdev, u32 as_nr)
+static void panfrost_mmu_enable(struct panfrost_device *pfdev, struct panfrost_mmu *mmu)
 {
-	mmu_hw_do_operation_locked(pfdev, as_nr, 0, ~0ULL, AS_COMMAND_FLUSH_MEM);
-
-	mmu_write(pfdev, AS_TRANSTAB_LO(as_nr), 0);
-	mmu_write(pfdev, AS_TRANSTAB_HI(as_nr), 0);
+	int as_nr = mmu->as;
+	struct io_pgtable_cfg *cfg = &mmu->pgtbl_cfg;
+	u64 transtab = cfg->arm_mali_lpae_cfg.transtab;
+	u64 memattr = cfg->arm_mali_lpae_cfg.memattr;
 
-	mmu_write(pfdev, AS_MEMATTR_LO(as_nr), 0);
-	mmu_write(pfdev, AS_MEMATTR_HI(as_nr), 0);
+	/* Need to revisit mem attrs.
+	 * NC is the default, Mali driver is inner WT.
+	 */
+	_panfrost_mmu_as_control_write(pfdev, as_nr, transtab, memattr);
+}
 
-	write_cmd(pfdev, as_nr, AS_COMMAND_UPDATE);
+static void panfrost_mmu_disable(struct panfrost_device *pfdev, u32 as_nr)
+{
+	_panfrost_mmu_as_control_write(pfdev, as_nr, 0, 0);
 }
 
 u32 panfrost_mmu_as_get(struct panfrost_device *pfdev, struct panfrost_mmu *mmu)
-- 
2.47.2


