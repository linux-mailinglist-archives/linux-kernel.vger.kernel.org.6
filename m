Return-Path: <linux-kernel+bounces-561179-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DFE2A60E57
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 11:11:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5B901B60A90
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 10:11:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52C831F4739;
	Fri, 14 Mar 2025 10:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DII7biZc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B38421F3FF1
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 10:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741947068; cv=none; b=Ib4iuCI4WTFct7uYYdOMD9ePIsZSoktr0vRX01nCxSMCR4x7PmWgnlYYC7/OMyTU8N5EuUhp8jGE1h7E5VgFM/r0sBBBtI1JvtShsgYKS0MjwJHXY23vhlsG4/cHQZh77dVA5tzyyQYn8SlZdNKBXifjhVLcJX4JhBHJqh8ZYuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741947068; c=relaxed/simple;
	bh=U98yKqR09pci6Dos0Xkhum9zeW7dWjBPjiKDCl11NQ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FLLYFUIoB1I4f/KpNGsNdogJZBtoN+IXD95Cm0Nrjvwwh+JYRFnzaKvxdo6nvyj0aTctLo4XBZJ/d3cQ3WrhDfpMZLbAddDqkM5XtrN4GLeV2qe4kgigHg60xSd5ud7a9p2ygD1zOWmh71+0ywkHUTMLEeyuIoV2hm9mdP7FbCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DII7biZc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B88BC4CEE9;
	Fri, 14 Mar 2025 10:11:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741947068;
	bh=U98yKqR09pci6Dos0Xkhum9zeW7dWjBPjiKDCl11NQ0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DII7biZchvhnRhdU3rKFzW0yo5dl9ZwMpZtayi1CfTmdqFN+PQIv22aSNvg7oYTgR
	 lHPvJ0NBG3rgGW+XT/294GuK1Rp4csTkCJ2/ZWG+0Aan+NNYMvU1iDLBA/k4P01gQ4
	 zEzhLccNyDWZijIG1GqSe5Mu+bUhBUIrTeqR//Lf0Q4FZOTFQnbWVF/Ma9L3KxI4Rz
	 wGhiZGDF+jjbsfq1TSBWNRGNHJ/Gx299k4XLQLIBF7PDWp0OY9/CpLP62uScflhU45
	 OYIX6wtQ0LxYR7HcZ0auXmVKqQ2i2hdH2o9BDa0QxWH9v5jlm1j5ZVauJTyaTDS7Ih
	 quMNxGTIOqHYQ==
From: Philipp Stanner <phasta@kernel.org>
To: Matthew Brost <matthew.brost@intel.com>,
	Danilo Krummrich <dakr@kernel.org>,
	Philipp Stanner <phasta@kernel.org>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Subject: [PATCH v3 2/2] drm/sched: Remove kthread header
Date: Fri, 14 Mar 2025 11:10:24 +0100
Message-ID: <20250314101023.111248-3-phasta@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250314101023.111248-2-phasta@kernel.org>
References: <20250314101023.111248-2-phasta@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The kthread header doesn't need to be included anymore. It's a relict
from commit a6149f039369 ("drm/sched: Convert drm scheduler to use a
work queue rather than kthread").

Remove the unneeded includes.

Signed-off-by: Philipp Stanner <phasta@kernel.org>
Reviewed-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
---
 drivers/gpu/drm/scheduler/sched_entity.c | 1 -
 drivers/gpu/drm/scheduler/sched_fence.c  | 1 -
 2 files changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/scheduler/sched_entity.c b/drivers/gpu/drm/scheduler/sched_entity.c
index 74a72c0a9c0a..8551892aca12 100644
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


