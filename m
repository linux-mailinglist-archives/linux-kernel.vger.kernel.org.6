Return-Path: <linux-kernel+bounces-398772-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CD2B49BF5CE
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 19:58:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84ED31F232D4
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 18:58:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D484B20896A;
	Wed,  6 Nov 2024 18:58:23 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F682207A1A
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 18:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730919503; cv=none; b=dmkG/4ae29PdahIzNQCsTYCHkGtoAjRZwek1luklMPDi6IAm/NX2oilDvmLYJlBaY2gYME7SD/EeMgSYaGgWxbdU6IAt0n0pJNtHWcVRiLbqKLV+IrV6PxZeiHvMyQ/2TO2mkZ6ojwSav9FP3AnDS+3led67SaerLEssp13NpaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730919503; c=relaxed/simple;
	bh=a790h49AtUkJxgr+O+C1kiwWl+LUuuzrKpUHyHSOc3Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=O5Cvw+c8h3Gfb/+tt0k1V3Eibg280HQ/tPv1kUbKROE2FaGWvUcmjSnI5lCBCSMF7Iej1z6Xmi1trm8Nd/j/SrpYL2k38qTPdWF2klcrVKWKFXNKFivQ+lvNHQCnw0Wyw2Sx9EPWN7dCAwV/zzDazTZztqhwFlhkPGudsj10QK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 490F7497;
	Wed,  6 Nov 2024 10:58:48 -0800 (PST)
Received: from e110455-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 067FE3F528;
	Wed,  6 Nov 2024 10:58:16 -0800 (PST)
From: Liviu Dudau <liviu.dudau@arm.com>
To: Boris Brezillon <boris.brezillon@collabora.com>
Cc: Liviu Dudau <liviu.dudau@arm.com>,
	Steven Price <steven.price@arm.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Jann Horn <jannh@google.com>
Subject: [PATCH v2] drm/panthor: Lock XArray when getting entries for the VM
Date: Wed,  6 Nov 2024 18:58:06 +0000
Message-ID: <20241106185806.389089-1-liviu.dudau@arm.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Similar to cac075706f29 ("drm/panthor: Fix race when converting
group handle to group object") we need to use the XArray's internal
locking when retrieving a vm pointer from there.

v2: Removed part of the patch that was trying to protect fetching
the heap pointer from XArray, as that operation is protected by
the @pool->lock.

Fixes: 647810ec2476 ("drm/panthor: Add the MMU/VM logical block")
Reported-by: Jann Horn <jannh@google.com>
Cc: Boris Brezillon <boris.brezillon@collabora.com>
Cc: Steven Price <steven.price@arm.com>
Signed-off-by: Liviu Dudau <liviu.dudau@arm.com>
---
 drivers/gpu/drm/panthor/panthor_mmu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/panthor/panthor_mmu.c b/drivers/gpu/drm/panthor/panthor_mmu.c
index 8ca85526491e6..46b84a557d9cc 100644
--- a/drivers/gpu/drm/panthor/panthor_mmu.c
+++ b/drivers/gpu/drm/panthor/panthor_mmu.c
@@ -1580,7 +1580,9 @@ panthor_vm_pool_get_vm(struct panthor_vm_pool *pool, u32 handle)
 {
 	struct panthor_vm *vm;
 
+	xa_lock(&pool->xa);
 	vm = panthor_vm_get(xa_load(&pool->xa, handle));
+	xa_unlock(&pool->xa);
 
 	return vm;
 }
-- 
2.47.0


