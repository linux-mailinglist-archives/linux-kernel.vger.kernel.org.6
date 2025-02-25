Return-Path: <linux-kernel+bounces-531437-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3550FA44087
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 14:20:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7DE5417FF69
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 13:14:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA98F2698AF;
	Tue, 25 Feb 2025 13:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CuF6w+6q"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49C9726982F
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 13:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740489258; cv=none; b=NKdVMT+T0gYInFy7GrL9LxRKmFn6QWpLt5F4Yazw0iNH09xuQi9SGWMW2m5B4De1m7QKKzNTzQ5Uu8uWNsI6IoJqrU4F12R8IT8/2kNZFaWvWWqAW7qFGP09+OsqF9IAAU7FBbsngbxmR8RTzwWi7iQ/J8jKFc6rr3f5nxdPp0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740489258; c=relaxed/simple;
	bh=Bhp6PbDhhFe8mAEBp5rNuHjMn4cQ68XhArMiM1W9hj0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AYw1+SPQNocdPeS9Yw8KZxnyEw3kOoVc4LfpUKDA1ZSfRpT/tJzup1DAbmN+Ol3iKDCBPDzPCvcn/mRwlbtrTss4jcP23Zeadx/g4jhdgIjolFhB0M/BbrNdmYhxSm2fgKGouqefkyKzSoVI47GbNaq9hkHlH6ygU+9sUi8Izc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CuF6w+6q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E0CBC4CEE6;
	Tue, 25 Feb 2025 13:14:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740489255;
	bh=Bhp6PbDhhFe8mAEBp5rNuHjMn4cQ68XhArMiM1W9hj0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CuF6w+6qjVigVJZkDmwvBn+Sx0iSbeYdO3MCwdWUTqRqVnmB/Sa73RJxdyOAGddx6
	 7MaoMF9M6pCNdUMUTp8DN13Hr+8r5/lyD3JQzUB5b5hZzk6lx99S709IlWHBU/PEtb
	 dQA0X66Sa2KZVPtqaelKrLSaSWk2l6IeIA7FtFD4gmTq9dOlRlf2Zy3kd/LTw5IuDQ
	 hFl8mOkROADnvSQ28J26FI0NjHGRGfsgpOY5HmIKDUEOP9LPrdJP51L3EsEK52+olv
	 mM4HybygvF33tv3gCLBjEuGrZc60hvIrFoEFjwx11lp5udtrNK2bM5n8DeapERGV+P
	 oBn0EXSCcgtCg==
From: Philipp Stanner <phasta@kernel.org>
To: Matthew Brost <matthew.brost@intel.com>,
	Danilo Krummrich <dakr@kernel.org>,
	Philipp Stanner <phasta@kernel.org>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] drm/sched: Remove kthread header
Date: Tue, 25 Feb 2025 14:13:34 +0100
Message-ID: <20250225131332.83415-4-phasta@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250225131332.83415-2-phasta@kernel.org>
References: <20250225131332.83415-2-phasta@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The kthread header doesn't need to be included anymore. It's a relict
from the days when the scheduler was still using a kthread instead of
workqueues.

Remove the unneeded includes.

Fixes: a6149f039369 ("drm/sched: Convert drm scheduler to use a work queue rather than kthread")
Signed-off-by: Philipp Stanner <phasta@kernel.org>
---
I'm not sure whether we should Cc the stable kernel. It's inconvenient
and makes build times slower, but isn't really a bug.
---
 drivers/gpu/drm/scheduler/sched_entity.c | 1 -
 drivers/gpu/drm/scheduler/sched_fence.c  | 1 -
 2 files changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/scheduler/sched_entity.c b/drivers/gpu/drm/scheduler/sched_entity.c
index f9811420c787..e55b98af8a50 100644
--- a/drivers/gpu/drm/scheduler/sched_entity.c
+++ b/drivers/gpu/drm/scheduler/sched_entity.c
@@ -21,7 +21,6 @@
  *
  */
 
-#include <linux/kthread.h>
 #include <linux/slab.h>
 #include <linux/completion.h>
 
diff --git a/drivers/gpu/drm/scheduler/sched_fence.c b/drivers/gpu/drm/scheduler/sched_fence.c
index e971528504a5..d6239e015b66 100644
--- a/drivers/gpu/drm/scheduler/sched_fence.c
+++ b/drivers/gpu/drm/scheduler/sched_fence.c
@@ -21,7 +21,6 @@
  *
  */
 
-#include <linux/kthread.h>
 #include <linux/module.h>
 #include <linux/sched.h>
 #include <linux/slab.h>
-- 
2.48.1


