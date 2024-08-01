Return-Path: <linux-kernel+bounces-271061-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5AF3944901
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 12:07:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 026381C2174F
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 10:07:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3BCE184523;
	Thu,  1 Aug 2024 10:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FdmjFGuR"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D00222AD25
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 10:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722506825; cv=none; b=GIEA1N++lENvJaoGXjgTfcGpjnBUo5BIX95fizdSwRTRKOGtpGgQGQex/P2qqCqX+62KcrkW6sRM7oEtULmoU6JXkXJ3m28/QAa16LCxJgijbdkqvcVh+yZfktxWmoVOIhbQiuMiMt9GolIkV10pVk0QBZo99k25iYoQuOKL3vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722506825; c=relaxed/simple;
	bh=gAb+6vR0sOYi5fLw6gDJGEdLaB/Azj5L3dYTlH5YL1w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ah6FIB5IY7qXb/eQeDdBNGZk75M2NP075nmZR6zloNa1D59d92O5VTElN8CUhkTO1JsSQ8D+4rSVsv9Qd71zcK2XuFSMFPn7WJFpXSnPd3ut/nI0bIRCS3P63PAIlpRJpJdGUF8GelycyLqlRY651qGAad0lzv/oEbhnU8bBqMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FdmjFGuR; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722506821;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=m+AcU6QzSb7rs1jXvTepEqbC5SaD+a0PmE71dwYSIWA=;
	b=FdmjFGuRL+fbUY5DNYv7lIuZ5L2x2RcOPzGQtrgqgRBPg6ROvLrQKQUogDHFRpfbVJngEZ
	/a8epxbZbmr1d0qyheESll2khaHymbb/uPFDQGTKnujrEh/3xO/143gTFupq5PyEOAhFdD
	fEGrDOBVMHjm6Y3bi6uWzDLxF3cGq+g=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-635-VRl68sAXMaCzfFtezGHSrw-1; Thu,
 01 Aug 2024 06:06:58 -0400
X-MC-Unique: VRl68sAXMaCzfFtezGHSrw-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A71E71955F45;
	Thu,  1 Aug 2024 10:06:56 +0000 (UTC)
Received: from hydra.redhat.com (unknown [10.39.193.214])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7C16A19560B2;
	Thu,  1 Aug 2024 10:06:52 +0000 (UTC)
From: Jocelyn Falempe <jfalempe@redhat.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	John Ogness <john.ogness@linutronix.de>,
	Javier Martinez Canillas <javierm@redhat.com>,
	"Guilherme G . Piccoli" <gpiccoli@igalia.com>,
	bluescreen_avenger@verizon.net,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Cc: Jocelyn Falempe <jfalempe@redhat.com>
Subject: [RFC PATCH 0/3] drm/log: Introduce a new boot logger to draw the kmsg on the screen
Date: Thu,  1 Aug 2024 12:04:22 +0200
Message-ID: <20240801100640.462606-1-jfalempe@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

drm_log is a simple logger that uses the drm_client API to print the kmsg boot log on the screen.
This is not a full replacement to fbcon, as it will only print the kmsg.
It will never handle user input, or a terminal because this is better done in userspace.

If you're curious on how it looks like, I've put a small demo here:
https://people.redhat.com/jfalempe/drm_log/drm_log_draft_preview.webm

Design decisions:
  * It uses the drm_client API, so it should work on all drm drivers from the start.
  * It doesn't scroll the message, that way it doesn't need to redraw the whole screen for each new message.
    It also means it doesn't have to keep drawn messages in memory, to redraw them when scrolling.
  * It uses a circular buffer so the console->write() callback is very quick, and will never stall.
  * Drawing is done asynchronously using a workqueue.
  * drm_log can only be built-in (and drm must be built-in too).
    The reason is that, if you build it as a module, then a userspace application will be more appropriate than this module.

TODO items:
 * It currently only handles the first drm_client hotplug event, I need a bit more time to fix that. 
 * I didn't find a way to know when drm_log loses focus, I would like to unregister it, so it won't waste CPU cycles in the background.
 * I copied the drm_client API usage from drm_fbdev_shmem, so there might be some adjustment to work on DMA GPU (I didn't try yet).
 * Flicker-free boot: I don't want drm_log to introduce new modeset during the boot, so it may need some adjustment.
 * I tried to use the new nbcon interface, but didn't get any message from the write_atomic() callback, but the goal is to use that when it's ready.
 * Add color support, to make timestamp, or error message, in different color for better visibility.
 * If built with VT_CONSOLE=n and FRAMEBUFFER_CONSOLE=y, fbcon is taking the focus, and you won't see the drm_log.
   It would be nice to have drm_log for boot logs, and still use fbcon for terminal, when userspace is started.
 
The first patch is not for review/merge, it's a squash of my pending drm_panic series:
https://patchwork.freedesktop.org/series/136377/
https://patchwork.freedesktop.org/series/135944/

The second patch, moves the drawing function from drm_panic.c, to drm_draw.c, so they can be re-used by drm_log.
The third patch is the actual drm_log implementation.

I want to get some feedbacks before spending more time on this, and make sure I'm heading in the right direction.

Thanks and best regards,

-- 

Jocelyn

Jocelyn Falempe (3):
  [NOT FOR REVIEW] drm/panic: Squash of pending series
  drm/panic: Move drawing functions to drm_draw
  drm/log: Introduce a new boot logger to draw the kmsg on the screen

 drivers/gpu/drm/Kconfig             |   47 ++
 drivers/gpu/drm/Makefile            |    4 +
 drivers/gpu/drm/drm_crtc_internal.h |    8 +
 drivers/gpu/drm/drm_draw.c          |  216 ++++++
 drivers/gpu/drm/drm_draw.h          |   56 ++
 drivers/gpu/drm/drm_drv.c           |    5 +
 drivers/gpu/drm/drm_log.c           |  477 +++++++++++++
 drivers/gpu/drm/drm_log.h           |    8 +
 drivers/gpu/drm/drm_panic.c         |  596 +++++++++-------
 drivers/gpu/drm/drm_panic_qr.rs     | 1003 +++++++++++++++++++++++++++
 include/drm/drm_panic.h             |   21 +-
 include/drm/drm_rect.h              |   15 +
 12 files changed, 2181 insertions(+), 275 deletions(-)
 create mode 100644 drivers/gpu/drm/drm_draw.c
 create mode 100644 drivers/gpu/drm/drm_draw.h
 create mode 100644 drivers/gpu/drm/drm_log.c
 create mode 100644 drivers/gpu/drm/drm_log.h
 create mode 100644 drivers/gpu/drm/drm_panic_qr.rs


base-commit: bb99c51bdaa846bddb85a1e7acca3a3aa5e9f082
-- 
2.45.2


