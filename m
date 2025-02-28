Return-Path: <linux-kernel+bounces-538777-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB40DA49CF8
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 16:14:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E85C33B49E5
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 15:13:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FFE11EF38B;
	Fri, 28 Feb 2025 15:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="FClhitgE"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8989E1EF37B
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 15:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740755556; cv=none; b=OdS1FJV1k/qZOnksSo4P5WA4XajvF9oWrNfMFUsBaZ1vqz9E/KkU95SEssyWRpPSsZTNwB1E8SJRWfAc5KK+eFEcs0hPB1wHR5gHDRdijwIix4b4tPz+kPLejQ8yqkHqFd49YrDDPJmYJqP7ewW5nACNQk1DZDgrMEWDUBZ9apc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740755556; c=relaxed/simple;
	bh=IdxijL2MKs5ZKc3W56BJQd2rktqrB8w0eK8g/S1abHs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hbfYCYPUArg0caKNbBPyCHDwNIu60/awTff3BmVR2vmj4Ojc/scffnsKMbuNF3TFZXNQjO4KfKwZoGQXc5tKEYp7X38ONJudD378NbQAUme7htJAdFjShlOgY3N5vXsZjxBHXvzlUcKnAOCVsNEuaae3JbxgBILK8SsvLanRl0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=FClhitgE; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1740755552;
	bh=IdxijL2MKs5ZKc3W56BJQd2rktqrB8w0eK8g/S1abHs=;
	h=From:To:Cc:Subject:Date:From;
	b=FClhitgEXxiiyxS1uGMDRJEzbKKwnNPFp+y2W+t/PIbI3XEpO85OW7o0yfxWWY/B3
	 hXGWCDuXwVF/jypCMQJ4zEvk+6yf/Vmr3u5FRZEUxYTTjbw2aooaif90OT43++AgFK
	 KdTOhw4ftcLIklUIa7U7tQI83kCB6sNn9OgTADm5lhSQa1XjKd0mo3KvidUszYwTKQ
	 zVWWt5NF0IuPa2j5YgewkQK7IE/fUcOmo/NwFFuuUXqCBG3/1zTWmWxhqTZBZZtuhY
	 JJsRzrZeV+veLOKZcKJIihT5wKBWMauhyIpOJdsksUk5oGKtSYH9gkx6W2av6NR2ZS
	 ouWSkFZ4XU3qQ==
Received: from localhost.localdomain (unknown [171.76.85.20])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: vignesh)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 78B2117E066F;
	Fri, 28 Feb 2025 16:12:29 +0100 (CET)
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
Subject: [PATCH v2] drm/ci: use shallow clone to avoid timeouts
Date: Fri, 28 Feb 2025 20:42:12 +0530
Message-ID: <20250228151217.563807-1-vignesh.raman@collabora.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The python-artifacts job has a timeout of 10 minutes, which causes
build failures as it was unable to clone the repository within the
specified limits. Set GIT_DEPTH to 50 to speed up cloning and avoid
build failures due to timeouts when fetching the full repository.

Signed-off-by: Vignesh Raman <vignesh.raman@collabora.com>
---

v2:
  - Set GIT_DEPTH to 50 to allow the check-patch job to pass

---
 drivers/gpu/drm/ci/gitlab-ci.yml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/ci/gitlab-ci.yml b/drivers/gpu/drm/ci/gitlab-ci.yml
index f4e324e156db..3ba50fcd6f15 100644
--- a/drivers/gpu/drm/ci/gitlab-ci.yml
+++ b/drivers/gpu/drm/ci/gitlab-ci.yml
@@ -40,6 +40,8 @@ variables:
   ARTIFACTS_BASE_URL: https://${CI_PROJECT_ROOT_NAMESPACE}.${CI_PAGES_DOMAIN}/-/${CI_PROJECT_NAME}/-/jobs/${CI_JOB_ID}/artifacts
   # Python scripts for structured logger
   PYTHONPATH: "$PYTHONPATH:$CI_PROJECT_DIR/install"
+  # Set to 0 to disable shallow cloning
+  GIT_DEPTH: 50
 
 
 default:
-- 
2.47.2


