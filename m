Return-Path: <linux-kernel+bounces-512809-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D91ABA33DEF
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 12:26:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71EDE188C6F7
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 11:27:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38AAF227E98;
	Thu, 13 Feb 2025 11:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Mha22r1V"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5209227E82
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 11:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739446004; cv=none; b=e4PLjBqWJN/f75eUgyeB/3fKsUYDOWPnuvMDHH0RJ5u4g6B4u4n3n6mxK4aEAQBsehzTYzkX+z3lUbCwzCthqg702RPmm3DPWvmgG5JrqwEo8u50+Xaax6HXpSELsojlEa/yA9yXQT4IIuUYXz6GLZ0ljZgQE9N7td3ruCdQ95c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739446004; c=relaxed/simple;
	bh=1+x2r2mKd82CSPvyZIBEPw2LNiO80yAu/I/w3jE5B5k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OsHQZNx0m+WiCR0RE6hKpnr2RP2syybyujOLwUy3BOOGp/50TTszuNGc/9XRqPj0YK17hTVfSxpLmJcrDoOW88V7hX8mJQqvFCDz3naHslTX1TUmXG/XwlaU0f5uyt6yPUXeVYGmLXFdeqzAKfgbpYgfp1bVLEMKLUjfRZq3gIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Mha22r1V; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739446001;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=tqCQhoc9yHBw/Ye9zCVr4BN8IJWP/oqPEgk4B/klK10=;
	b=Mha22r1VtySmYkdU75lNRP30MaLUkvMm/30Gumwr1ne1VdFCCMkschUTvZlijCkYfNSnUy
	BtLSX9JQEyUE6eXx206L7cJs8EGA/GC4EUH8PlGAZY69nPXBLhcj1ym6EKKqTEz4vnAWsD
	TnnU9UOsFOZrPzgfeOtVMKK+TK4ycwo=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-86-qVJDI2yZMZa2Wn-XGHgW5A-1; Thu,
 13 Feb 2025 06:26:35 -0500
X-MC-Unique: qVJDI2yZMZa2Wn-XGHgW5A-1
X-Mimecast-MFC-AGG-ID: qVJDI2yZMZa2Wn-XGHgW5A_1739445994
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 809821800876;
	Thu, 13 Feb 2025 11:26:33 +0000 (UTC)
Received: from hydra.redhat.com (unknown [10.45.225.79])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5A70E300018D;
	Thu, 13 Feb 2025 11:26:28 +0000 (UTC)
From: Jocelyn Falempe <jfalempe@redhat.com>
To: Jani Nikula <jani.nikula@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Cc: Jocelyn Falempe <jfalempe@redhat.com>
Subject: [RFC PATCH v4 0/8] drm/i915: Add drm_panic support
Date: Thu, 13 Feb 2025 12:19:24 +0100
Message-ID: <20250213112620.1923927-1-jfalempe@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

This is a draft of drm_panic support for i915.

I've tested it on the 4 intel laptops I have at my disposal.
 * Haswell with 128MB of eDRAM.
 * Comet Lake.
 * Alder Lake (with DPT, and Y-tiling).
 * Lunar Lake (with DPT, and 4-tiling, and using the Xe driver.

I tested panic in both fbdev console and gnome desktop.

Best regards,

v2:
 * Add the proper abstractions to build also for Xe.
 * Fix dim checkpatch issues.

v3:
 * Add support for Y-tiled framebuffer when DPT is enabled.

v4:
 * Add support for Xe driver, which shares most of the code.
 * Add support for 4-tiled framebuffer found in newest GPU.

Jocelyn Falempe (8):
  drm/i915/fbdev: Add intel_fbdev_get_map()
  drm/i915/display/i9xx: Add a disable_tiling() for i9xx planes
  drm/i915/display: Add a disable_tiling() for skl planes
  drm/i915/gem: Add i915_gem_object_panic_map()
  drm/i915/display: Add drm_panic support
  drm/i915/display: Flush the front buffer in panic handler
  drm/i915/display: Add drm_panic support for Y-tiling with DPT
  drm/i915: Add drm_panic support for 4-tiling with DPT

 drivers/gpu/drm/i915/display/i9xx_plane.c     |  23 +++
 .../gpu/drm/i915/display/intel_atomic_plane.c | 177 +++++++++++++++++-
 drivers/gpu/drm/i915/display/intel_bo.c       |  10 +
 drivers/gpu/drm/i915/display/intel_bo.h       |   2 +
 .../drm/i915/display/intel_display_types.h    |   2 +
 drivers/gpu/drm/i915/display/intel_fb_pin.c   |   5 +
 drivers/gpu/drm/i915/display/intel_fb_pin.h   |   2 +
 drivers/gpu/drm/i915/display/intel_fbdev.c    |   5 +
 drivers/gpu/drm/i915/display/intel_fbdev.h    |   6 +
 .../drm/i915/display/skl_universal_plane.c    |  27 +++
 drivers/gpu/drm/i915/gem/i915_gem_object.h    |   2 +
 drivers/gpu/drm/i915/gem/i915_gem_pages.c     |  25 +++
 drivers/gpu/drm/i915/i915_vma.h               |   5 +
 drivers/gpu/drm/xe/display/intel_bo.c         |  17 ++
 drivers/gpu/drm/xe/display/xe_fb_pin.c        |   5 +
 15 files changed, 312 insertions(+), 1 deletion(-)


base-commit: ff3881cc6a588f8cd714c9ffbbcc9ef6b02c8d0f
-- 
2.47.1


