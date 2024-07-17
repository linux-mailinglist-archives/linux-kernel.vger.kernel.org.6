Return-Path: <linux-kernel+bounces-254941-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68057933985
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 11:02:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22B8B283B5D
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 09:02:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2A2238F97;
	Wed, 17 Jul 2024 09:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z+obHz2r"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CE3937160
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 09:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721206917; cv=none; b=hDGjx9l+Fgi19RGg45T1u2TwVd+jX3dPSBKjcUOgTBk0o4uWx2JHb7LWweVcRL4Dz5O1uN22xEKvRYPVFHkgvKmPuB7WRB4mN6VpfT9agjTkhsZPqmxysR12+oYAiqFtwtGzIZxKRxvEQ7SYom7BUcBIUxeZ7bPqHcUWS70LiaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721206917; c=relaxed/simple;
	bh=IyosArDWVjjT9mg9qNfQW5tTmi7yUA/cLqYqFiwyND0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=qoqh5bDW9nmeqR+h0k4ilk7GmoTHdlqhl9aHZnQvhGeL+Dl3VyVUhgHalKnzPq+iL+Gib8o/TVWjEarXL1h++Y36WvAc95XSsDx3dY20efwihVSM2BsTPfcr+8uwW5txPwjCUIu05WO4/7POTwOM/zRs9Xfh1D6i7YmNytvkMaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Z+obHz2r; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721206914;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=KrgDLQF/5OvH9cl5dgPPJLVwc5mVIqPT9oH+q0LK9fo=;
	b=Z+obHz2riE6qyKKq0Yzro+1WrO/HQ0B1glQ8LefPSVMorUmGZDJPcwDrti3xcmYKPtDIAe
	z7szbD14PW6043xohUSn0qVvHkAtuckWqAfiJ4bNbvfHuWnKUltDAVII6KAbABocbGaqJX
	zra5iDWrT2Xy1DxC0ySMxnANPugUbKc=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-206-Xn3Sl3I1PIKCdwciIuVYUw-1; Wed,
 17 Jul 2024 05:01:52 -0400
X-MC-Unique: Xn3Sl3I1PIKCdwciIuVYUw-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C52FB1955F08;
	Wed, 17 Jul 2024 09:01:43 +0000 (UTC)
Received: from hydra.redhat.com (unknown [10.39.194.18])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D379B1955F3B;
	Wed, 17 Jul 2024 09:01:38 +0000 (UTC)
From: Jocelyn Falempe <jfalempe@redhat.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Helge Deller <deller@gmx.de>,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Javier Martinez Canillas <javierm@redhat.com>,
	Samuel Thibault <samuel.thibault@ens-lyon.org>,
	Jocelyn Falempe <jfalempe@redhat.com>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	linux-fbdev@vger.kernel.org
Subject: [PATCH 0/3] drm/panic: Remove build time dependency with FRAMEBUFFER_CONSOLE
Date: Wed, 17 Jul 2024 10:48:38 +0200
Message-ID: <20240717090102.968152-1-jfalempe@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

When proposing to enable DRM_PANIC on Fedora, some users raised concern about the need to disable VT_CONSOLE.
So this is my new attempt to avoid fbcon/vt_console to overwrite the panic screen.
This time it doesn't involve any locking, so it should be safe.
I added a skip_panic option in struct fb_info, and check if this option and the panic_cpu are set in fb_is_inactive(), to prevent any framebuffer operation.
Also skip_panic is only true if the drm driver supports drm_panic, so you will still get the VT panic info on drivers that don't have drm_panic support yet.

Jocelyn Falempe (3):
  drm/panic: Add drm_panic_is_enabled()
  fbcon: Add an option to disable fbcon in panic.
  drm/panic: Remove build time dependency with FRAMEBUFFER_CONSOLE

 drivers/gpu/drm/Kconfig          |  2 +-
 drivers/gpu/drm/drm_fb_helper.c  |  2 ++
 drivers/gpu/drm/drm_panic.c      | 20 ++++++++++++++++++++
 drivers/video/fbdev/core/fbcon.c |  7 ++++++-
 include/drm/drm_panic.h          |  2 ++
 include/linux/fb.h               |  1 +
 6 files changed, 32 insertions(+), 2 deletions(-)


base-commit: a237f217bad50c381773da5b00442710d1449098
-- 
2.45.2


