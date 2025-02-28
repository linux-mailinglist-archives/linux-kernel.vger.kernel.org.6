Return-Path: <linux-kernel+bounces-538580-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 25740A49A81
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 14:26:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CAA087A246D
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 13:25:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5671C26BDBA;
	Fri, 28 Feb 2025 13:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="dCaAeNoZ"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAC641D555
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 13:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740749201; cv=none; b=ETcI715+5EoBF93tZX0ww/NUIAcmsC2aHPT3ugcDL500PJsyBjohN2BDOCSBKkjj0HlB5/U+HHXT0xGp4X6/yfPNRZ2toaMx5H6GPi8lROexUGpvyFF39lKDZOxEsn8peO6cEr5PLLAne2vqsyY3QaE3EoZD3uAqIgpxqqdUi3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740749201; c=relaxed/simple;
	bh=kGFidxujuu/5E6/w43jD7cIkQM+gr//1Z9nzVC3249w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FAwRPVd2zz0s6iB4h16Gsf8hjdQL+eHX8nKDBxLrQJLkA++EtCecjppvf6Tc9q3z/AD+SIuHEbafH6aR2AZsB/DD4xAo2FQtPKUCsMa2IQuDP6WhbW9fMvD1LzgN2Mc0lrURAvbetDzwDI6HA2iWeAlV4eTkwgtOflwxOsOcOpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=dCaAeNoZ; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1740749191;
	bh=kGFidxujuu/5E6/w43jD7cIkQM+gr//1Z9nzVC3249w=;
	h=From:To:Cc:Subject:Date:From;
	b=dCaAeNoZeU54zDefZlcSRbx/qgWHWaR8ZjNOK4VSPFUWCMKacfX5AWbpoYe4ZPzgQ
	 yJZl7kTFzok4PNFV6fxZut36Vc3ALn/tZFqao1ln37ZyJ+QhFekZQBKFEiS7ElzkuI
	 c1dWqWlQ8eVKTZH+sV1hb4TbLR74ujLJLupczbqnKUH7NebkONedaqPBluTFvTsczj
	 Fhl2yk9sGxTA0vIU506ZTQpc0O8cswh0FghgtXpqc2jNCGFR3fLteVEYbByhAE2EkR
	 1dQSoWrxJdAb+SRsz4l2gbQVV9u6DmmO6blVgCDvZZzox62XcWeu6z+QJikLRBShWH
	 Qk9CJq9JwY3Zg==
Received: from localhost.localdomain (unknown [171.76.85.20])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: vignesh)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 445A517E07F8;
	Fri, 28 Feb 2025 14:26:29 +0100 (CET)
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
Subject: [PATCH v3] drm/ci: fix merge request rules
Date: Fri, 28 Feb 2025 18:56:18 +0530
Message-ID: <20250228132620.556079-1-vignesh.raman@collabora.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Merge request pipelines were only created when changes
were made to drivers/gpu/drm/ci/, causing MRs that
didn't touch this path to break. Fix MR pipeline rules
to trigger jobs for all changes.

Run jobs automatically for marge-bot and scheduled
pipelines, but in all other cases run manually. Also
remove CI_PROJECT_NAMESPACE checks specific to mesa.

Fixes: df54f04f2020 ("drm/ci: update gitlab rules")
Signed-off-by: Vignesh Raman <vignesh.raman@collabora.com>
---

v2:
  - Run jobs automatically for marge-bot and scheduled
    pipelines, but in all other cases run manually. Also
    remove CI_PROJECT_NAMESPACE checks specific to mesa.

v3:
  - Fix yaml syntax

---
 drivers/gpu/drm/ci/gitlab-ci.yml | 19 ++++---------------
 1 file changed, 4 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/ci/gitlab-ci.yml b/drivers/gpu/drm/ci/gitlab-ci.yml
index f04aabe8327c..b06b9e7d3d09 100644
--- a/drivers/gpu/drm/ci/gitlab-ci.yml
+++ b/drivers/gpu/drm/ci/gitlab-ci.yml
@@ -143,11 +143,11 @@ stages:
     # Pre-merge pipeline
     - if: &is-pre-merge $CI_PIPELINE_SOURCE == "merge_request_event"
     # Push to a branch on a fork
-    - if: &is-fork-push $CI_PROJECT_NAMESPACE != "mesa" && $CI_PIPELINE_SOURCE == "push"
+    - if: &is-fork-push $CI_PIPELINE_SOURCE == "push"
     # nightly pipeline
     - if: &is-scheduled-pipeline $CI_PIPELINE_SOURCE == "schedule"
     # pipeline for direct pushes that bypassed the CI
-    - if: &is-direct-push $CI_PROJECT_NAMESPACE == "mesa" && $CI_PIPELINE_SOURCE == "push" && $GITLAB_USER_LOGIN != "marge-bot"
+    - if: &is-direct-push $CI_PIPELINE_SOURCE == "push" && $GITLAB_USER_LOGIN != "marge-bot"
 
 
 # Rules applied to every job in the pipeline
@@ -170,26 +170,15 @@ stages:
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
       when: manual
-    # Skip everything for pre-merge and merge pipelines which don't change
-    # anything in the build
-    - if: *is-merge-attempt
-      when: never
-    - if: *is-pre-merge
-      when: never
     # Build everything after someone bypassed the CI
     - if: *is-direct-push
-      when: on_success
+      when: manual
     # Build everything in scheduled pipelines
     - if: *is-scheduled-pipeline
       when: on_success
-- 
2.47.2


