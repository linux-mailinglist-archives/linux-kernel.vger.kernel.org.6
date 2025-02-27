Return-Path: <linux-kernel+bounces-535567-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2392FA474AB
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 05:38:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF1E3188CCA0
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 04:38:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D89F71F5857;
	Thu, 27 Feb 2025 04:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="h+bvhONl"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1577717A5A4
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 04:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740631024; cv=none; b=qM5j3IkEP6pU/Eg43wou3h7HiN3dj0/sYPVVV1WPZ8HfdQvFyt8gVov6svm8QsIeNv1N/QXMSusazhv6PJ2uK+Z3RO501F6X4XL496o7Dt5yu7Gk3scAZ4DVEaSbB2eM8ztlIYYjORwwSe8oGV/BylWeyYuJdUrYFe0Sg+umqBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740631024; c=relaxed/simple;
	bh=dTLiIcGg+7VcR4Jututcykw9L0J9eF3fh+IAUJFRshM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eFfYJtxcNrPTTT/aE+DODQgqzCwt7/O3U3aDDSqYuihZ5uGMEIdjTTeR13lCFG8LoO3L6fuI1lBRUxTx2XNCruq+w8fWXcvgLxytCerRqgnIPxAhsqLRmyuOtgssQfuq1UN0XdtmHDzcbk0eoPcvZ0uEwMudnvuEGSMtwNS0xog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=h+bvhONl; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1740631020;
	bh=dTLiIcGg+7VcR4Jututcykw9L0J9eF3fh+IAUJFRshM=;
	h=From:To:Cc:Subject:Date:From;
	b=h+bvhONlg44ykMXqLn8yZyAIVVSkPrQt17gJjPJmzwSNanNZFJctyA3acfNgBZs6I
	 ZWD5OFhI/IrHedTsnjbApva0AMUIG8G9LNjyPV+jsLy8B7w411fAtRpfbry33AzK1l
	 63jexskqMMhRYoWKORpnIlIRC/suVay+RKlBxPVncrqn/AE3M2fvkhZC+mLrD6s70O
	 KwRLWiWiU10R9He+vpgWNX0lYTD6MnUssS8hwjMDiEIuTmA0ounve/ISeVG0kJURpQ
	 WWMHHJDGYqHj8LDn7nkcSN4QU5BiYLDzuhGMF6p4mCB4Brqxmu6k5pD8My6KZJMKQF
	 m7vIpWzGtfvzA==
Received: from localhost.localdomain (unknown [171.76.83.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: vignesh)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 6A4BE17E068B;
	Thu, 27 Feb 2025 05:36:55 +0100 (CET)
From: Vignesh Raman <vignesh.raman@collabora.com>
To: dri-devel@lists.freedesktop.org
Cc: daniels@collabora.com,
	helen.fornazier@gmail.com,
	airlied@gmail.com,
	simona.vetter@ffwll.ch,
	robdclark@gmail.com,
	dmitry.baryshkov@linaro.org,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	guilherme.gallo@collabora.com,
	sergi.blanch.torne@collabora.com,
	valentine.burley@collabora.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1] drm/ci: remove CI_PRE_CLONE_SCRIPT
Date: Thu, 27 Feb 2025 10:06:24 +0530
Message-ID: <20250227043640.411696-1-vignesh.raman@collabora.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If we are not caching the git archive, do not
set CI_PRE_CLONE_SCRIPT. Setting it makes CI
try to download the cache first, and if it is
missing, it tries to clone the repo within a
time limit, which can cause build failures.

Signed-off-by: Vignesh Raman <vignesh.raman@collabora.com>
---
 drivers/gpu/drm/ci/gitlab-ci.yml | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/gpu/drm/ci/gitlab-ci.yml b/drivers/gpu/drm/ci/gitlab-ci.yml
index f4e324e156db..0bc4ac344757 100644
--- a/drivers/gpu/drm/ci/gitlab-ci.yml
+++ b/drivers/gpu/drm/ci/gitlab-ci.yml
@@ -13,12 +13,6 @@ variables:
   FDO_UPSTREAM_REPO: helen.fornazier/linux   # The repo where the git-archive daily runs
   MESA_TEMPLATES_COMMIT: &ci-templates-commit d5aa3941aa03c2f716595116354fb81eb8012acb
   DRM_CI_PROJECT_URL: https://gitlab.freedesktop.org/${DRM_CI_PROJECT_PATH}
-  CI_PRE_CLONE_SCRIPT: |-
-          set -o xtrace
-          curl -L --retry 4 -f --retry-all-errors --retry-delay 60 -s ${DRM_CI_PROJECT_URL}/-/raw/${DRM_CI_COMMIT_SHA}/.gitlab-ci/download-git-cache.sh -o download-git-cache.sh
-          bash download-git-cache.sh
-          rm download-git-cache.sh
-          set +o xtrace
   S3_JWT_FILE: /s3_jwt
   S3_JWT_FILE_SCRIPT: |-
       echo -n '${S3_JWT}' > '${S3_JWT_FILE}' &&
-- 
2.47.2


