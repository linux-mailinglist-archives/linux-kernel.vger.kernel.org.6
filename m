Return-Path: <linux-kernel+bounces-425771-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67F859DEADC
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 17:23:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2781C163B26
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 16:23:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC109149E17;
	Fri, 29 Nov 2024 16:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CCCXqJXB"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9770E1B95B
	for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 16:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732897380; cv=none; b=Oih/IX+AwvqJZNDLwlfK+lIR9zuv3/7VEJt/Vhhn9jVYTKktkDMo/awv/7zEqLjQRDCDeIdMNH7J5cvvjLBTEXQ3UX5zY208l7CuOJLdU7RcMI6IuAWytvnm73C0t7rwExFIkH9IsRjQmhjH8K/vi1rky+qnxYjX1rW2Y9hmRNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732897380; c=relaxed/simple;
	bh=0HwIGA3JekSjYVJ4fFBi7FUlAB+Yx8HvyI6Hrs7LnXI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EU27pDun89PWqEl4kFW8e54M6FXv9D3vH94RjouaOciK2SwqERvaLpGoWlq9AEekNJomOm3RTkICOX2USzl7DVreb8ronW2MJs2BoJsplzjYCQ0yGHZr+h+2hLppdfhin2+94BUAZJ7KNRcRVOhRpSiS/CEb5knQdOzDDVbtwwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CCCXqJXB; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732897377;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=T2NzOJNybc+OxZcBXIBIIDO3D2n3JMJ6jTFDWviJdRA=;
	b=CCCXqJXBkNHnTyh875nYxmxd1CSXKAiq8XN2dY4Q6GO0MLhueyjUSEQkhdlQM356VFZAIA
	MMOB+1l+nXXvzqMHxcLdqx+1+rdULeWW2nLy5GGC4Wx35HHOKOSuqRkErmZUhPrl57Mv2v
	WFUhugZLSBPw18QK1+Ts2GuGjGhKonk=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-451-3NM6bngZNY2P5h0oY6nDgQ-1; Fri,
 29 Nov 2024 11:22:52 -0500
X-MC-Unique: 3NM6bngZNY2P5h0oY6nDgQ-1
X-Mimecast-MFC-AGG-ID: 3NM6bngZNY2P5h0oY6nDgQ
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 59423195394F;
	Fri, 29 Nov 2024 16:22:50 +0000 (UTC)
Received: from hydra.redhat.com (unknown [10.39.192.13])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id DD63F1955F2D;
	Fri, 29 Nov 2024 16:22:46 +0000 (UTC)
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
Subject: [RFC PATCH 0/5] drm/i915: Add drm_panic support
Date: Fri, 29 Nov 2024 17:20:25 +0100
Message-ID: <20241129162232.7594-1-jfalempe@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

This is a first draft of drm_panic support for i915.

I've tested it on the 3 intel laptops I have at my disposal.
one Haswell with 128MB of eDRAM, one Cometlake and one Alderlake.

I tested panic in both fbdev console and gnome desktop.

I still have an issue with Alderlake, and it doesn't work when in gnome desktop.
If I disable tiling on a framebuffer using DPT, then it displays some other memory location.
As DPT is enabled only for tiled framebuffer, there might be some hardware limitations?
I think it can be worked around by drawing the image tiled, (like what I've done on nouveau https://patchwork.freedesktop.org/series/133963/), but maybe there is another way?

Best regards,

Jocelyn Falempe (5):
  drm/i915/fbdev: Add intel_fbdev_getvaddr()
  drm/i915/display/i9xx: Add a disable_tiling() for i9xx planes
  drm/i915/display: Add a disable_tiling() for skl planes
  drm/i915/gem: export i915_gem_object_map_page/pfn
  drm/i915: Add drm_panic support

 drivers/gpu/drm/i915/display/i9xx_plane.c     | 24 +++++
 .../gpu/drm/i915/display/intel_atomic_plane.c | 98 ++++++++++++++++++-
 .../drm/i915/display/intel_display_types.h    |  2 +
 drivers/gpu/drm/i915/display/intel_fbdev.c    |  5 +
 drivers/gpu/drm/i915/display/intel_fbdev.h    |  5 +
 .../drm/i915/display/skl_universal_plane.c    | 20 ++++
 drivers/gpu/drm/i915/gem/i915_gem_object.h    |  5 +
 drivers/gpu/drm/i915/gem/i915_gem_pages.c     |  4 +-
 8 files changed, 160 insertions(+), 3 deletions(-)


base-commit: 44cff6c5b0b17a78bc0b30372bcd816cf6dd282a
-- 
2.47.0


