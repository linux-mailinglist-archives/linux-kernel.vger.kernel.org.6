Return-Path: <linux-kernel+bounces-534004-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1455BA4615F
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 14:55:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 287203A7107
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 13:54:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBBA721D3F0;
	Wed, 26 Feb 2025 13:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="FsGVDgOp"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A7E621C19B
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 13:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740578099; cv=none; b=PN/EmGWXpAqbfwSfd7DjQrDfJP+dA6zLyrLTXNkvCDbiHaSEMc4ZqN8KeRzZc1+k90LS+985nU3OWX5lF+xzkPD257yUSZeZqNeb/m+sN1GuTM4TaWhLqadXcOzZWc7FvgNh0VEs10mulBw3e505khAlruGXHK4kNT+/7AoXnn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740578099; c=relaxed/simple;
	bh=LtFuR081QOM86nBX0UXcuDbM695SSowbkwTzuFTdC6M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ohE/xKLf5ZHxz5uJVpnemTSYGR8bXWh7UKQ3UY8B1qAmG53vH3rpBBcGPBWK4df0Wn2D+Vkhs1ZtlWoJIyvR/ysTfZwhf04wALjQtpAYRVP+jmsytU9E0MlppTZKUeRX0PWLUjOE2Or83dmnFGyOumaaRwqs882+fw4cmsyr21s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=FsGVDgOp; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1740578095;
	bh=LtFuR081QOM86nBX0UXcuDbM695SSowbkwTzuFTdC6M=;
	h=From:To:Cc:Subject:Date:From;
	b=FsGVDgOpDsLoa0MQISghg6u5ZF9DRvCIezUabZLV+779mH56R0cPZUe0jl/2H0xkD
	 3QoEV1+J6fvSdvEL/1oFuY1Rs/uz03D1jlIuNMP++ahpdKXrIJeeABZBkt0Clo0MUp
	 iELJA9NBEOIhB8eKw7KWwQGKJHwbqZoBnb3tUZOjYS8PgWYg3rRve157WwYlb+24XX
	 WpSUTDmolDO1AZ9iHKRlck3cqVPNiml8t4sqxsVabuKvlk2veWpJUMYU8psIMAqCBX
	 GarS1SlibuOqZ4Rc74Kz7lwIpeqIS6iH1bxngOyEc7pQ0NoMK8ezDmV0o+azbpufCb
	 G95d3EU4TQF9A==
Received: from localhost.localdomain (unknown [171.76.83.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: vignesh)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id A4F4A17E0657;
	Wed, 26 Feb 2025 14:54:51 +0100 (CET)
From: Vignesh Raman <vignesh.raman@collabora.com>
To: dri-devel@lists.freedesktop.org
Cc: daniels@collabora.com,
	helen.fornazier@gmail.com,
	airlied@gmail.com,
	simona.vetter@ffwll.ch,
	robdclark@gmail.com,
	dmitry.baryshkov@linaro.org,
	guilherme.gallo@collabora.com,
	sergi.blanch.torne@collabora.com,
	valentine.burley@collabora.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1] drm/ci: fix merge request rules
Date: Wed, 26 Feb 2025 19:23:58 +0530
Message-ID: <20250226135415.363605-1-vignesh.raman@collabora.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Merge request pipelines were only created when changes
were made to drivers/gpu/drm/ci/, causing MRs that didn't
touch this path to break. Fix MR pipeline rules to trigger
jobs for all changes.

Fixes: df54f04f2020 ("drm/ci: update gitlab rules")
Signed-off-by: Vignesh Raman <vignesh.raman@collabora.com>
---
 drivers/gpu/drm/ci/gitlab-ci.yml | 15 ++-------------
 1 file changed, 2 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/ci/gitlab-ci.yml b/drivers/gpu/drm/ci/gitlab-ci.yml
index f04aabe8327c..3991cd36af5f 100644
--- a/drivers/gpu/drm/ci/gitlab-ci.yml
+++ b/drivers/gpu/drm/ci/gitlab-ci.yml
@@ -170,23 +170,12 @@ stages:
     - !reference [.disable-farm-mr-rules, rules]
     # Never run immediately after merging, as we just ran everything
     - !reference [.never-post-merge-rules, rules]
-    # Build everything in merge pipelines, if any files affecting the pipeline
-    # were changed
+    # Build everything in merge pipelines
     - if: *is-merge-attempt
-      changes: &all_paths
-      - drivers/gpu/drm/ci/**/*
       when: on_success
     # Same as above, but for pre-merge pipelines
     - if: *is-pre-merge
-      changes:
-        *all_paths
-      when: manual
-    # Skip everything for pre-merge and merge pipelines which don't change
-    # anything in the build
-    - if: *is-merge-attempt
-      when: never
-    - if: *is-pre-merge
-      when: never
+      when: on_success
     # Build everything after someone bypassed the CI
     - if: *is-direct-push
       when: on_success
-- 
2.47.2


