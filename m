Return-Path: <linux-kernel+bounces-343873-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 442AF98A095
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 13:28:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0572028917B
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 11:28:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC83818E04B;
	Mon, 30 Sep 2024 11:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b="Hsrz8pTW"
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E248D1991DD;
	Mon, 30 Sep 2024 11:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.134.164.83
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727695319; cv=none; b=H7JeF+I7+abZQFwamz4gIQ+75os9lh39UulihGhT+qYykguL114ETNhCLGYWnMMVHzyyAkC2KpU9MOwJkDniZ/YDRklVJdlHzB8u0PzmHLU3SeXeZXjFFoMZE8mr8O5C/PLzpbRZAmw9VtAVtWZZNNvWkuuOygM2+glQ+vRMhJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727695319; c=relaxed/simple;
	bh=EHU2iMOgANqGUPZJ3Ro5pssOmIbIe3s/GjjnRdeP9x4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kLpIqPoxk9CdH2ASTAKMNZL5j3qJMvQlK99qIiYMa8MBdr+J6fmXmFlN3UpvwAPivSxyJLwEwNYO2Yvc4M93NQe0JliJRwfIjkyYT5WiR1YAomoWFn4EFxiTEEn39goiHYzTwwd3/TCrLjIbJbNLYWlg6le9cbuivVsM3TqbT3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr; spf=pass smtp.mailfrom=inria.fr; dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b=Hsrz8pTW; arc=none smtp.client-ip=192.134.164.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inria.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5wdreZebx+hIO6b8UfY5M+z6lqJsf400rN74nypioAc=;
  b=Hsrz8pTWfcdNzv0+3GMzM3AMEtjhgim/041sggmI8xlBA9h5Ax8l1xOv
   9XzgANw4gEAMNoZ1eaUCUgxLU3y2wB37FPzbI0VOFRwDV8V2ehYRiu2OR
   WjVmNHTF+diHPu0LQ/3qcOkEmR6o3Q7vF3j0XmzxV343BjTn5bi1Kza4i
   Q=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=Julia.Lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.11,165,1725314400"; 
   d="scan'208";a="185956909"
Received: from i80.paris.inria.fr (HELO i80.paris.inria.fr.) ([128.93.90.48])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2024 13:21:28 +0200
From: Julia Lawall <Julia.Lawall@inria.fr>
To: Alex Deucher <alexander.deucher@amd.com>
Cc: kernel-janitors@vger.kernel.org,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Xinhui Pan <Xinhui.Pan@amd.com>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 29/35] drivers/gpu/drm: Reorganize kerneldoc parameter names
Date: Mon, 30 Sep 2024 13:21:15 +0200
Message-Id: <20240930112121.95324-30-Julia.Lawall@inria.fr>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20240930112121.95324-1-Julia.Lawall@inria.fr>
References: <20240930112121.95324-1-Julia.Lawall@inria.fr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Reorganize kerneldoc parameter names to match the parameter
order in the function header.

Problems identified using Coccinelle.

Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>

---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c |    2 +-
 drivers/gpu/drm/radeon/radeon_ib.c     |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 6005280f5f38..ad4fdd4d4d82 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -2773,11 +2773,11 @@ int amdgpu_vm_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
  * amdgpu_vm_handle_fault - graceful handling of VM faults.
  * @adev: amdgpu device pointer
  * @pasid: PASID of the VM
- * @ts: Timestamp of the fault
  * @vmid: VMID, only used for GFX 9.4.3.
  * @node_id: Node_id received in IH cookie. Only applicable for
  *           GFX 9.4.3.
  * @addr: Address of the fault
+ * @ts: Timestamp of the fault
  * @write_fault: true is write fault, false is read fault
  *
  * Try to gracefully handle a VM fault. Return true if the fault was handled and
diff --git a/drivers/gpu/drm/radeon/radeon_ib.c b/drivers/gpu/drm/radeon/radeon_ib.c
index 1aa41cc3f991..8611a27dfb3d 100644
--- a/drivers/gpu/drm/radeon/radeon_ib.c
+++ b/drivers/gpu/drm/radeon/radeon_ib.c
@@ -49,8 +49,8 @@ static void radeon_debugfs_sa_init(struct radeon_device *rdev);
  *
  * @rdev: radeon_device pointer
  * @ring: ring index the IB is associated with
- * @vm: requested vm
  * @ib: IB object returned
+ * @vm: requested vm
  * @size: requested IB size
  *
  * Request an IB (all asics).  IBs are allocated using the


