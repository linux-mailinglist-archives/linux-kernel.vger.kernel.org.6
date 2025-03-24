Return-Path: <linux-kernel+bounces-574271-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82A3DA6E2F2
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 20:00:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4DA3171C45
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 19:00:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71A5C26738B;
	Mon, 24 Mar 2025 18:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L17Z8LtJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D309F2673B2
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 18:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742842778; cv=none; b=O2D6lTMmhOc5IhQG6rlTYn3u+sEoVRkC2ZplkLCjlCGiNZ/sncG6vpW0oVP04M9IVeiRq+fuqyw9sW0HeipCsgtIr887EzsWVVYoUcPkTBBUwytOuNYqHy2pDXmd5C+VFhLJ8sK+bwwpBAiBbloqoSkKSfjslCRReWoCjMS6qRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742842778; c=relaxed/simple;
	bh=xhoLbq5vLDpkF7vOhtPhJa9aRN77Uui3d6RuWBdXsI8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cTSXU71k13OgPwFt5d/M/yo1GQ9DT2SgoBl08m51DEnJwSAPUpJVk0bW+gIoStvu+SRmjZl+FVYuScoBxel7FwUduRFtUw4+XlwiBFEWWEJ3r3bBVCHcyU/0+oFGEDQBDd2N39O5ev2N/vaLhuJOLOVdQfREG7f3QiOvdYeuMQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L17Z8LtJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58058C4CEEA;
	Mon, 24 Mar 2025 18:59:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742842778;
	bh=xhoLbq5vLDpkF7vOhtPhJa9aRN77Uui3d6RuWBdXsI8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=L17Z8LtJUZIhDsROpLic9OKSKSKVsgxhl+h6ZaPjlrMntjZvf12luHuySfvdldIMb
	 H9HIptsl/RAQq/iYWI1ASRh9cWHvJbTXgd9UdbZPehLyyH8mpR5gl0U6sSjpMZGM/m
	 w4NkTMRsVgukL2Zb4ncQJZBs/SBT31o+6agUzejxxB8rAINQ+CeT9Gjj/wbF0AqkMV
	 fdo778tK3SeJlaxLOZ8q70TLh//c9yBQv+mHXl/7iwppe0rVSfN5lRFcdOvI+bZEOI
	 WPXjEg2U5EkAl2zXk9FWYiaVHL2ymoBRrQp6dsgWAamqK6WBP2VbkpM28uuaFGz8FA
	 0rFxiaBtXFpxA==
From: Philipp Stanner <phasta@kernel.org>
To: Lyude Paul <lyude@redhat.com>,
	Danilo Krummrich <dakr@kernel.org>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Matthew Brost <matthew.brost@intel.com>,
	Philipp Stanner <phasta@kernel.org>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Cc: dri-devel@lists.freedesktop.org,
	nouveau@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 3/5] drm/sched: Warn if pending list is not empty
Date: Mon, 24 Mar 2025 19:57:27 +0100
Message-ID: <20250324185728.45857-5-phasta@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250324185728.45857-2-phasta@kernel.org>
References: <20250324185728.45857-2-phasta@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

drm_sched_fini() can leak jobs under certain circumstances.

Warn if that happens.

Signed-off-by: Philipp Stanner <phasta@kernel.org>
---
 drivers/gpu/drm/scheduler/sched_main.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/scheduler/sched_main.c
index 87acbcb1a821..4f8cc208a231 100644
--- a/drivers/gpu/drm/scheduler/sched_main.c
+++ b/drivers/gpu/drm/scheduler/sched_main.c
@@ -1455,6 +1455,10 @@ void drm_sched_fini(struct drm_gpu_scheduler *sched)
 	sched->ready = false;
 	kfree(sched->sched_rq);
 	sched->sched_rq = NULL;
+
+	if (!list_empty(&sched->pending_list))
+		dev_err(sched->dev, "%s: Tearing down scheduler while jobs are pending!\n",
+			__func__);
 }
 EXPORT_SYMBOL(drm_sched_fini);
 
-- 
2.48.1


