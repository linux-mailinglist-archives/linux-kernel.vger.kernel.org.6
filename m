Return-Path: <linux-kernel+bounces-563153-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1BB4A63798
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Mar 2025 22:53:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 445E816D706
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Mar 2025 21:53:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ACD81A0BF1;
	Sun, 16 Mar 2025 21:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="Gmakg9V2"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37F6E1922FD
	for <linux-kernel@vger.kernel.org>; Sun, 16 Mar 2025 21:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742161979; cv=pass; b=Rrzko3+j+ZDpNpjflaIHs+OHcCJ1ruK7aQ016XuCu2CoFqIS10k877zaBPsD6iF5aM14Bln132/7GcC0SjkGLIwt3X2QNca75FHHkoyqs6M/yrZXqVhyfllNQAWpkjwGnE4yahdRibvV2AKxfkhlD6C2W7KmIDosPb8py1MCBws=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742161979; c=relaxed/simple;
	bh=gOtEsb6HSERcxDboCRZ7luxxDc9oP7IfI+1tCC2E3LI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jG1fqBBKLNQprYmUG43JVoPfMYQeRSBE1k0t7b2in+bGeCLr+fkW82YNr/cXZfUTsEFcRIkmmmrOx9tsO9qoxKASLCfogbeuljX8nmYkFXw7ygaMT8YtU0HrTO5AjgVMlgxsP9FFE8cfE+BsR7kf6OoIfDI8bHM+mw1SKv09M9Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b=Gmakg9V2; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1742161946; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=JowPB6SIVkG4fTsYXcWiZOcFNiOP+d/ysK9ktZeLTZN95vLDS7o3MWOByno/J7vWNdhsA/WW5NimYnanClM6nUo/FHbEPM85qkyfZdV5moU4ANkAci7dI4YSnjWLLTw3o6pe3+mpREjnZYuyUtj2+ZlEnd392ylfb/GLuRvB0M0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1742161946; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=aAicki8o0dcPGsCDGnk1JMD1P/KiyJERoLKGn0P0zSQ=; 
	b=JFYv28ixUE6Wb9DiogMSrhR1oNqNgdTXEhYTgPJHsWMXONEyOEECaDP1z+DCeBuDUZCbr3I8iQRCFzGXhXIxApqUH/UQSBG66q2guaJ3tXThRDxzOyAb1pZaauyXqWkkvt1FCmpDk5/ZAf7oOgKTYgjM6hc8jhubNHeVxAM1rEA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
	dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1742161946;
	s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=aAicki8o0dcPGsCDGnk1JMD1P/KiyJERoLKGn0P0zSQ=;
	b=Gmakg9V2GZDEiyYvzE35WtJ3yXYfXZ6Xl0ETCPkClguUeSXqooWlRTQcsfcRyJhI
	teejeRY3XNdH4VoP8kwGhHqOfNSIPZmkztnhY8BiCrF45mr+RcAJMXdLTgBOXSRQLcS
	kTUy4nPErkA6R0JdmrU/ZjjFye1VajqY06popXzU=
Received: by mx.zohomail.com with SMTPS id 1742161944404241.90075270214368;
	Sun, 16 Mar 2025 14:52:24 -0700 (PDT)
From: =?UTF-8?q?Adri=C3=A1n=20Larumbe?= <adrian.larumbe@collabora.com>
To: Boris Brezillon <boris.brezillon@collabora.com>,
	Steven Price <steven.price@arm.com>,
	Liviu Dudau <liviu.dudau@arm.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>
Cc: kernel@collabora.com,
	=?UTF-8?q?Adri=C3=A1n=20Larumbe?= <adrian.larumbe@collabora.com>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] Panthor BO tagging and GEMS debug display
Date: Sun, 16 Mar 2025 21:51:31 +0000
Message-ID: <20250316215139.3940623-1-adrian.larumbe@collabora.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This patch series is aimed at providing UM with detailed memory profiling
information in debug builds. It is achieved through a device-wide list of
DRM GEM objects, and also implementing the ability to label BO's from UM
through a new IOCTL.

The new debugfs file shows a list of driver DRM GEM objects in tabular mode.
To visualise it, cat sudo cat /sys/kernel/debug/dri/*.gpu/gems.
To test this functionality from UM, please refer to this Mesa patch series:

https://gitlab.collabora.com/alarumbe/mesa/-/commits/bo-tagging-panthor-gl

Adrián Larumbe (4):
  drm/panthor: Introduce BO labeling
  drm/panthor: Add driver IOCTL for setting BO labels
  drm/panthor: show device-wide list of DRM GEM objects over DebugFS
  drm/panthor: Display heap chunk entries in DebugFS GEMS file

 drivers/gpu/drm/panthor/panthor_device.c |   5 +
 drivers/gpu/drm/panthor/panthor_device.h |   8 ++
 drivers/gpu/drm/panthor/panthor_drv.c    |  57 +++++++++++
 drivers/gpu/drm/panthor/panthor_gem.c    | 119 +++++++++++++++++++++++
 drivers/gpu/drm/panthor/panthor_gem.h    |  34 +++++++
 drivers/gpu/drm/panthor/panthor_heap.c   |  15 +++
 include/uapi/drm/panthor_drm.h           |  14 +++
 7 files changed, 252 insertions(+)

--
2.48.1

