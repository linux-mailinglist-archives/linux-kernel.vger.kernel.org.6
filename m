Return-Path: <linux-kernel+bounces-286337-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 100A99519D2
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 13:24:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8EF951F230C0
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 11:24:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A78E31AED48;
	Wed, 14 Aug 2024 11:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=mary.guillemard@collabora.com header.b="B3P64W6/"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 590FC1AE87C
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 11:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723634665; cv=pass; b=CgLW0evzfFm6/CFZpSqzEC+OYxOGsXt/r0l+VdkF6OdW7oPS+ND4WDYwWTX0cUVNAoOekepmar+RI0zdr4pixBhX7A93Ic3m/mmGELvlJky7rxOKPE6gakbz7hKGn9jNabT3jIzX3lG41EQDx9vAhjityJiS5MHCybWwdqhnyKo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723634665; c=relaxed/simple;
	bh=AeZWJAaF+CR7t6Bbs5X3uh+KTL0vG+ZXJYEHjjDuud8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oegoAxEUddlq/YrHmxugi+6/DwGeEqj7xfxe4mccyDKQk5s551pr8CUK8idCj2tdKzucwepkzosH0BRORxmtx0IQID1Poe+ZSqDAwOl4nx8AXamVGZWLg8lNTtuz68KmEa4ZhrUmdHZHoowmH4zV497HXMEK9jqUz79OGq6Ktxs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=mary.guillemard@collabora.com header.b=B3P64W6/; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Delivered-To: kernel@collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1723634658; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=drrrib3PgACWU4DLDK7aTEnw+bGSJNXDrOpFJLK4ZAQshORSEWiIf/PiHsKqxBZ5HcCPQrjc56TD74KdYmr3EAnYYiU8lnyS9waJ2/DZTKxi1AJBbpyuNLkMpEcuZ4CrQLYr4q1n2P7y72yV/7X/C/yIPlbUetmGY06zM+Z8FYE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1723634658; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=TMK+Y9UR3sCfF0PcWam3voFzP/LTHIDFW55Ab2pv/wU=; 
	b=D6Mf94R+EetoPreUEEoc/RjczyuxCFFgKQpInHFpwmt6EsxbsGMWGhwUE+RJYyMH1Q3kHWomxjSv1WKRMUKKUKEroauFWT9SUvfKm4XAJRHjqzmM1cyr9C2y74PA40mytFFPVHdTDIUmWHlp3V7zevmFNE8iOGeIfAMutWZoAaM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=mary.guillemard@collabora.com;
	dmarc=pass header.from=<mary.guillemard@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1723634658;
	s=zohomail; d=collabora.com; i=mary.guillemard@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=TMK+Y9UR3sCfF0PcWam3voFzP/LTHIDFW55Ab2pv/wU=;
	b=B3P64W6/AK73kI/q9/WOwlPBDQ5rydJyaxMUr9YFCtbVb+gkWWeYqrwWmSFMAXH3
	4v2JgjNWJTrJ0eQGLaecuygajmOhsS2Lzallw7gtdHX/EBkqdrGKKkkCVbbeSkWQ9ce
	fW5Ms+8k1jTVVxvyPx6+Wjyd9tlJqOiXw9gUYxB4=
Received: by mx.zohomail.com with SMTPS id 1723634657098217.00384123545962;
	Wed, 14 Aug 2024 04:24:17 -0700 (PDT)
From: Mary Guillemard <mary.guillemard@collabora.com>
To: linux-kernel@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org,
	kernel@collabora.com,
	Mary Guillemard <mary.guillemard@collabora.com>
Subject: [PATCH v2 0/2] drm/panfrost: Wire cycle counters and timestamp info to userspace
Date: Wed, 14 Aug 2024 13:21:20 +0200
Message-ID: <20240814112121.61137-2-mary.guillemard@collabora.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Mali has hardware cycle counters and GPU timestamps available for
profiling.

This patch series adds support for cycle counters propagation and
also new timestamp info parameters.

Those new changes to the uAPI will be used in Mesa to implement
timestamp queries for OpenGL and Vulkan.

The Mesa MR using this series is available here [1].

v2:
- Rewrote to use GPU timestamp register
- Add missing include for arch_timer_get_cntfrq
- Squash job requirement uAPI changes and implementation in one patch
- Simplify changes based on Steven Price comments

[1]https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/30553

Mary Guillemard (2):
  drm/panfrost: Add SYSTEM_TIMESTAMP and SYSTEM_TIMESTAMP_FREQUENCY
    parameters
  drm/panfrost: Add cycle counter job requirement

 drivers/gpu/drm/panfrost/panfrost_drv.c  | 43 ++++++++++++++++++++++--
 drivers/gpu/drm/panfrost/panfrost_gpu.c  | 12 +++++++
 drivers/gpu/drm/panfrost/panfrost_gpu.h  |  1 +
 drivers/gpu/drm/panfrost/panfrost_job.c  | 28 +++++++++------
 drivers/gpu/drm/panfrost/panfrost_regs.h |  2 ++
 include/uapi/drm/panfrost_drm.h          |  3 ++
 6 files changed, 76 insertions(+), 13 deletions(-)


base-commit: dfa5543193f303a7270ec7c725e656970faf7d57
-- 
2.45.2


