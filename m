Return-Path: <linux-kernel+bounces-429115-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0402D9E18BC
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 11:04:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 55282B3EFD4
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 09:30:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBAA41DFDAA;
	Tue,  3 Dec 2024 09:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GtAncijK"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF2241DF738
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 09:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733218146; cv=none; b=Bxk2ptPv7P0NS4Orf/Kdkw6Hnn1l+HBWYUZgj6ANqP3D4BxmEcCnIAuqKAQVOBRW7TvWeLOUSeQOvIAfshkSFJSMJvnEcR1E0ltt5tdGzbEBItZiYKch3l708a33A7FHdcUoKLioiNNFbJeS4hLxJ4h8g4Gr/ZDwhKRH8pN++GU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733218146; c=relaxed/simple;
	bh=+rkj49IT5OG8C/5f/fvi9Pk1afBX4kgCKtvAzmknLy0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Gmb5ynhQTZ3amIfEeyVMaT01uPFlnwUfPnxJZpr9JLYpJKPzbmdgx5Eda88GKMP0Oc2gRdA61bnS74p9YkdrR5phAu+HD1Tn47stmWMzMlPRkT7zMS3WEefUd+A3Qaegdj5gdJxv1SEhIcAXobCQmNpYw9HJZ27VxWQaLsn+FLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GtAncijK; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733218143;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=F2f8WGdinxkKeIjuZL8rVRbdkdX4e9z6nxeN+NAj5Jo=;
	b=GtAncijKbW4vICqCkJKpFb8c6qx9NV1qhezjN5NJ5B89v7HVcm30OWLBAsbQZOVtnO9el4
	3/VSX3uTB7EAn6GVMLVi2W0RzaJ6QCHq7O9Z6xVjO+nCW30kKpnLpRABIDwvTqITggRZqV
	8il/8v/krlZ1nnrArG8P/jee5EJmqNQ=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-387-EyGH7FZuNKyc-0mETd87KA-1; Tue,
 03 Dec 2024 04:28:58 -0500
X-MC-Unique: EyGH7FZuNKyc-0mETd87KA-1
X-Mimecast-MFC-AGG-ID: EyGH7FZuNKyc-0mETd87KA
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9F47C19560A2;
	Tue,  3 Dec 2024 09:28:56 +0000 (UTC)
Received: from hydra.redhat.com (unknown [10.39.193.255])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E05AE1955D45;
	Tue,  3 Dec 2024 09:28:52 +0000 (UTC)
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
Subject: [RFC PATCH v2 0/5] drm/i915: Add drm_panic support
Date: Tue,  3 Dec 2024 09:50:17 +0100
Message-ID: <20241203092836.426422-1-jfalempe@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

This is a first draft of drm_panic support for i915.

I've tested it on the 3 intel laptops I have at my disposal.
one Haswell with 128MB of eDRAM, one Cometlake and one Alderlake.

I tested panic in both fbdev console and gnome desktop.

I still have an issue with Alderlake, and it doesn't work when in gnome desktop.
If I disable tiling on a framebuffer using DPT, then it displays some other memory location.
As DPT is enabled only for tiled framebuffer, there might be some hardware limitations?
I think it can be worked around by drawing the image tiled, (like what I've done on nouveau https://patchwork.freedesktop.org/series/133963/), but maybe there is another way?

Best regards,

v2:
 * Add the proper abstractions to build also for Xe.
 * Fix dim checkpatch issues.

Jocelyn Falempe (5):
  drm/i915/fbdev: Add intel_fbdev_get_vaddr()
  drm/i915/display/i9xx: Add a disable_tiling() for i9xx planes
  drm/i915/display: Add a disable_tiling() for skl planes
  drm/i915/gem: Add i915_gem_object_panic_map()
  drm/i915: Add drm_panic support

 drivers/gpu/drm/i915/display/i9xx_plane.c     | 23 +++++
 .../gpu/drm/i915/display/intel_atomic_plane.c | 85 ++++++++++++++++++-
 drivers/gpu/drm/i915/display/intel_bo.c       | 10 +++
 drivers/gpu/drm/i915/display/intel_bo.h       |  2 +
 .../drm/i915/display/intel_display_types.h    |  2 +
 drivers/gpu/drm/i915/display/intel_fb_pin.c   |  5 ++
 drivers/gpu/drm/i915/display/intel_fb_pin.h   |  1 +
 drivers/gpu/drm/i915/display/intel_fbdev.c    |  5 ++
 drivers/gpu/drm/i915/display/intel_fbdev.h    |  6 ++
 .../drm/i915/display/skl_universal_plane.c    | 20 +++++
 drivers/gpu/drm/i915/gem/i915_gem_object.h    |  2 +
 drivers/gpu/drm/i915/gem/i915_gem_pages.c     | 25 ++++++
 drivers/gpu/drm/i915/i915_vma.h               |  5 ++
 drivers/gpu/drm/xe/display/intel_bo.c         | 11 +++
 drivers/gpu/drm/xe/display/xe_fb_pin.c        |  5 ++
 15 files changed, 206 insertions(+), 1 deletion(-)


base-commit: 44cff6c5b0b17a78bc0b30372bcd816cf6dd282a
-- 
2.47.1


