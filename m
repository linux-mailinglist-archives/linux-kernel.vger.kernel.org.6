Return-Path: <linux-kernel+bounces-547182-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACC7DA503E7
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 16:54:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0B6A3AED8F
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 15:54:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82DA72505C2;
	Wed,  5 Mar 2025 15:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YjatVu0u"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E608D2054FA
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 15:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741190056; cv=none; b=d0o58TqoCPibKH2ZSJs4168cTYVmvHgXIkrW9gmnZji4lJx3MO6hxN2F8h/f7sT7Kfay/Gs7TVEMd/vABLU8SllH57ON5IQqprbAMBUXo41DAyHQPYZxZeSnYzXJuYd6yWB8PvvXfh3qZXZIWIPmHQUD7gMNqRbI1K0HAd2swCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741190056; c=relaxed/simple;
	bh=hjKg1gDFgtmx4nrhI0ndame1TsHOJmcFeEivWJNbSco=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Uh9y8CiCfir19a+KZTQeB/AQ7wTZOi25knwAO8Oih+WLwL7l8yXUyB7yhDDPVvrEMBOUfyXPTW8mbYAWFg7sOqo6yEw/2CsEBN2AdCAq+PUnxQqcj3IH1IjYB0TvCF8+S6mH1mvTQP5WcrQTWxTynVqQOeVXtUZLRM18kPNopmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YjatVu0u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E02A8C4CEEA;
	Wed,  5 Mar 2025 15:54:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741190054;
	bh=hjKg1gDFgtmx4nrhI0ndame1TsHOJmcFeEivWJNbSco=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YjatVu0uHiwI2J/y+PPIKOC4X8mTngak0sPMk/cR4/SX6/MuzU459KjcIg1SFe/jA
	 75jCEF4Itbfq2PNLhmvioXcSkOQB5y8pSydjDRWDLQGbwPEVe/GpSzXqalZ0x5Nxck
	 5c5zneYao891QDGdLVxaeDTHKAQKNubSU0CtsnS4r+kXptlRuY5XE8fcptatCEcdy1
	 D952VYh//2AKcNK6RW/coWrp37vAPRZA5GuY/YCi56a7AiqdZtQuK/iAyrvl34N23c
	 7LtAKleE5CfqldcjhL5RSEeLPnrXz+0C/DzK60E8r+SXAsJfknMZPipVAyYVPvqZQp
	 VWMBHUZSnxhAQ==
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
	Sumit Semwal <sumit.semwal@linaro.org>
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] drm/sched: Remove kthread header
Date: Wed,  5 Mar 2025 16:53:27 +0100
Message-ID: <20250305155326.153596-3-phasta@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250305155326.153596-2-phasta@kernel.org>
References: <20250305155326.153596-2-phasta@kernel.org>
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


