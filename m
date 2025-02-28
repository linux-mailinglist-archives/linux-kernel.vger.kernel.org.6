Return-Path: <linux-kernel+bounces-537678-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B934AA48F05
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 04:15:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FFE33B18D7
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 03:15:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5580015A87C;
	Fri, 28 Feb 2025 03:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="o/J00Skz"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0A53276D37
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 03:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740712531; cv=none; b=Mk8Xv9CiQSGUIfLRe5b0VkXpATtxK8MHw3vs5pFz7qmbx/GCs2RxPY++bPeQSGJfpxABVVP9WskdKF3rnbfL/pdnFjvjL9hkeN6gWhNhwAcEi9UNau0lA90GS9ifU6tVW/Ha5I8vHMyTLSzOP0AuLS7IoklH4sCR5vJkqCkKhHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740712531; c=relaxed/simple;
	bh=nw5vEqkhGgPyQFHb/TYw6eebIhv1qAqoUxPrfuW3GwY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GzktSO1AFecSY71Z35PBqKI6ggId5n9NLJEkMr2CD3zAxq4/y6oL6RmDkRSxM4kqhGk4b+nHLsKjlBA4P9DyV8aVbk2pLP01u0RZYUvR9Wjd1Oj96Ucq0gjucP8cb7Fi2og+qwSEZnxgg9dRuDzzKPDXBWwTJKQo4OtpHKiM7IQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=o/J00Skz; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1740712527;
	bh=nw5vEqkhGgPyQFHb/TYw6eebIhv1qAqoUxPrfuW3GwY=;
	h=From:To:Cc:Subject:Date:From;
	b=o/J00SkzvMH/iub6bvhMb5enMJo8ZAfBpZjHr6m8UNiIFfBANiw2y52V6UXvbBmKU
	 W5QmOd+1+eyNrsINee427iEbAwpzuf/hd2a8agu0xMcCKum0KZOXtil6XVx1Sb2VGY
	 xb1MasyMbfTDBOrQAFpOKI4HuEKQR7qpZCef2Zq2RoWG37LNALhrVlW3+tX8H1V5R6
	 07aNyXntPaPRmcIGs8m7gEdnFFarHzkfFBIB/QPmS91AvXDz+2mnccOg42/L5HPlaD
	 YvfYZKZTbNGMYo/xDkWUnez350Z0LECCchAdpKOGmZqCzLXQTcAS8HUy2M5DLMJt0g
	 M2COvGH2HKnpw==
Received: from localhost.localdomain (unknown [171.76.85.20])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: vignesh)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 35C0E17E05E7;
	Fri, 28 Feb 2025 04:15:24 +0100 (CET)
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
Subject: [PATCH v1] drm/ci: use shallow clone to avoid timeouts
Date: Fri, 28 Feb 2025 08:44:57 +0530
Message-ID: <20250228031501.483475-1-vignesh.raman@collabora.com>
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
specified limits. Set GIT_DEPTH to 10 to speed up cloning and avoid
build failures due to timeouts when fetching the full repository.

Signed-off-by: Vignesh Raman <vignesh.raman@collabora.com>
---
 drivers/gpu/drm/ci/gitlab-ci.yml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/ci/gitlab-ci.yml b/drivers/gpu/drm/ci/gitlab-ci.yml
index f04aabe8327c..647ef980ad4a 100644
--- a/drivers/gpu/drm/ci/gitlab-ci.yml
+++ b/drivers/gpu/drm/ci/gitlab-ci.yml
@@ -40,6 +40,8 @@ variables:
   ARTIFACTS_BASE_URL: https://${CI_PROJECT_ROOT_NAMESPACE}.${CI_PAGES_DOMAIN}/-/${CI_PROJECT_NAME}/-/jobs/${CI_JOB_ID}/artifacts
   # Python scripts for structured logger
   PYTHONPATH: "$PYTHONPATH:$CI_PROJECT_DIR/install"
+  # Set to 0 to disable shallow cloning
+  GIT_DEPTH: 10
 
 
 default:
-- 
2.47.2


