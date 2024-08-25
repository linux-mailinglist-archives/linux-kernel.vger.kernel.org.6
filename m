Return-Path: <linux-kernel+bounces-300578-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6809795E566
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Aug 2024 23:19:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95F0B1C20D03
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Aug 2024 21:19:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AABA515B56E;
	Sun, 25 Aug 2024 21:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ZpCT4VGd"
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6A4728F4
	for <linux-kernel@vger.kernel.org>; Sun, 25 Aug 2024 21:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724620787; cv=none; b=PeSoXdj1YgFsTIOA1tzigI6xbgVR1eSX1hfYq/y/t10CzkLwotzfX0zM4/2/QV6IkvPGjt1HrSv34xnYi32cdiDOsbjyhsavg/ctVLr1j/BrFUxz1FZZHBeaJ4VqcQIrL/XvUuizYhE++ljoduEhuQFMW2+GwVFV/vrBD/QbVaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724620787; c=relaxed/simple;
	bh=TfYDz5k3liv3kvPIhX51DyTSFNAAhS30ItXdTQY59cg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=uJSPJPrPQf2b4rM2qDoiiHxcWgyr2FiqKGcUpy1UPqK9NZLEeAz4EhKIx6q5LJYt2JKl04NwwHaVjeW40rQ6BNcAe7a3FxgT8IDdMaFxLY+5TlHOY22F0foPRWwZ5qDLOdavjxnTleJlwkqcy6Vgrk3fWkUiRNPoaEs2Y0x9bfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ZpCT4VGd; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1724620782;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=LdZOrRmqpEiA7n2tnAtRogGoCmmowhl7JYIfyH8GvSY=;
	b=ZpCT4VGdIm1gckRv7ViqH19u9opQeKB3EH5a//nGmOQzw7kS01+AHXG499VUg4IIEFguBZ
	zTX503GrI2aPTu/1wZ+FXj1pmLSTJo5HmO8BzuNA9oK6QsZJVeO7osHiAfPrJ5Urcr4K8A
	vASc985F6iROpSvafHt+0TqMjbQOmoY=
From: Sui Jingfeng <sui.jingfeng@linux.dev>
To: Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Russell King <linux+etnaviv@armlinux.org.uk>,
	Christian Gmeiner <christian.gmeiner@gmail.com>
Cc: David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	etnaviv@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Sui Jingfeng <sui.jingfeng@linux.dev>
Subject: [PATCH 0/2] drm/etnaviv: Implement drm_gem_object_funcs::print_info()
Date: Mon, 26 Aug 2024 05:19:27 +0800
Message-Id: <20240825211929.614631-1-sui.jingfeng@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

It will be called by drm_gem_print_info() if have implemented, and this can
provide more information about the framebuffer objects. In order to make
the newly implemented etnaviv_gem_object_funcs::print_info() get in use,
we make the drm_gem_print_info() exported, then we re-implement the
etnaviv_gem_describe() base on it.

Sample Testing Information:

[root@fedora 0]# ls
clients  DPI-1	    encoder-1	 gem_names	   mm	 ring
crtc-0	 DPI-2	    framebuffer  gpu		   mmu	 state
crtc-1	 encoder-0  gem		 internal_clients  name
[root@fedora 0]# cat framebuffer 
framebuffer[49]:
	allocated by = Xorg
	refcount=1
	format=AR24 little-endian (0x34325241)
	modifier=0x0
	size=32x32
	layers:
		size[0]=32x32
		pitch[0]=128
		offset[0]=0
		obj[0]:
			name=0
			refcount=3
			start=00040096
			size=16384
			imported=no
			caching mode=write-combine
			active=no
			vaddr=0000000000000000
framebuffer[47]:
	allocated by = Xorg
	refcount=2
	format=XR24 little-endian (0x34325258)
	modifier=0x0
	size=1024x600
	layers:
		size[0]=1024x600
		pitch[0]=4096
		offset[0]=0
		obj[0]:
			name=0
			refcount=3
			start=00040000
			size=2457600
			imported=no
			caching mode=write-combine
			active=no
			vaddr=0000000000000000
			
[root@fedora 0]# cat gem
obj[0]:
	name=0
	refcount=3
	start=00040000
	size=2457600
	imported=no
	caching mode=write-combine
	active=no
	vaddr=0000000000000000
obj[1]:
	name=0
	refcount=3
	start=00040096
	size=16384
	imported=no
	caching mode=write-combine
	active=no
	vaddr=0000000000000000
obj[2]:
	name=0
	refcount=2
	start=00040097
	size=16384
	imported=no
	caching mode=write-combine
	active=no
	vaddr=0000000000000000
Total 3 objects, 2490368 bytes

Sui Jingfeng (2):
  drm/etnaviv: Implement drm_gem_object_funcs::print_info()
  drm/etnaviv: Export drm_gem_print_info() and use it

 drivers/gpu/drm/drm_gem.c             |  1 +
 drivers/gpu/drm/etnaviv/etnaviv_gem.c | 43 ++++++++++++++++++++++-----
 drivers/gpu/drm/etnaviv/etnaviv_gem.h |  2 +-
 include/drm/drm_gem.h                 |  2 ++
 4 files changed, 40 insertions(+), 8 deletions(-)

-- 
2.34.1


