Return-Path: <linux-kernel+bounces-184350-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B4C18CA5EB
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 03:43:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D76EE1F21AFB
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 01:43:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47D39C15B;
	Tue, 21 May 2024 01:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="bOJALKK7"
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4645DBA53
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 01:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716255781; cv=none; b=fWScAFTW+wFshBAEiQUhuX3LIDiktFFfBzmdzlUA6SB+/WhMdwMRNUmrxvi2at2+0ELQdNz+mMkrK9Wjgim4KCB2o5ukxctSpbNh9fvdzrkPnU5reAcmX7JjIVZOOceJCV0+lmfImBLWw80Z3lI555jlV3nz+ijJvGlVhXqrrW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716255781; c=relaxed/simple;
	bh=QjC9/bKcWK1cW2tBuZ2tdhIMkvyk3pVUrAM56Sm2igQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=SqWT+8qGn+uYwe+B9Ldthf9h/Im8FB2p9DyP1cR+06lHXwoOYiw/Q49YYAG9TAjGhkWbr9ycNbcXnnsoa6YbaEHUi/eyltd7eFLN5Z62uRF9ktZHdTn6Uxh7wJt9698Wn9X8ZTUkm9y8y+Xyj1w6K79+56CLQyKt6+yC49B3KTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=bOJALKK7; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1716255776; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=3bb0F+rW2A9d/TPFvZuKQflLMyVtWyJLrNl20e+QGcY=;
	b=bOJALKK7VR6mdUVmKZ3RQ99HIz44de9vZj62n2ENCvSYx0oz/x+g4s+nourSAthmgpPeiktZ7UyKl1OwGroEn/ckXIgRhD8zQT50x2jTPgCkjMAMa3adQncuYFxXKQHJ5/hMi1Jf30dL2+rRuO0BBP8EB0IRYa9M6G0YWGdzwD8=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R941e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067113;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0W6vwJNX_1716255775;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0W6vwJNX_1716255775)
          by smtp.aliyun-inc.com;
          Tue, 21 May 2024 09:42:56 +0800
From: Yang Li <yang.lee@linux.alibaba.com>
To: alexander.deucher@amd.com,
	airlied@gmail.com
Cc: amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Yang Li <yang.lee@linux.alibaba.com>
Subject: [PATCH -next] drm/amdgpu: Fix kernel-doc param for amdgpu_vm_is_bo_always_valid
Date: Tue, 21 May 2024 09:42:53 +0800
Message-Id: <20240521014253.125836-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make @abo to @bo to silence the kernel-doc warning.

Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index b9cca51356b1..3abfa66d72a2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -3008,7 +3008,7 @@ void amdgpu_vm_update_fault_cache(struct amdgpu_device *adev,
  * amdgpu_vm_is_bo_always_valid - check if the BO is VM always valid
  *
  * @vm: VM to test against.
- * @abo: BO to be tested.
+ * @bo: BO to be tested.
  *
  * Returns true if the BO shares the dma_resv object with the root PD and is
  * always guaranteed to be valid inside the VM.
-- 
2.20.1.7.g153144c


