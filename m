Return-Path: <linux-kernel+bounces-431584-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A234A9E3FC8
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 17:35:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3328FB24155
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 16:06:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0381B20D4F6;
	Wed,  4 Dec 2024 16:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="foLjaB3E"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B03920C03C
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 16:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733328034; cv=none; b=IPJc1TOTud0EIgrrw7ka5jCkoC6MShn7IPcS3NNtIG4x3qprKlKFQU2evUyYa0HHTtOBKkyWe8RbyQMyyfojuph5snChj1eV4vir3SRFHLh6aZGlGLiTgP0H/Sj7uinxyIs4SnvRwmw3Ln43Oyl5ND+TVYBen8PiDiyXi14rqHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733328034; c=relaxed/simple;
	bh=sV5dUYBKF4bYa7lh4A/7Jo32lQgSn0vm4/TcXns05OE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nk6mw2nPlkQT1L8Kp5eWILpZrvqiPunvXDGXp0PuqCUiplOKqRYfDg7NgYl/dAeGZxZh2H62aYylvTKcK8NC5f/S1hrNiSmExibv89XAVCPikVeo5MuL6MIDpH5GJNyy//iD26Pp6o9xichENcl4yrXq51u3A2r3ah6P9fZRQh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=foLjaB3E; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733328031;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=o5d+sc5F03L5d6dCxXM1Zg3XhFejpRpLE7C1CjYJlbc=;
	b=foLjaB3EE326FhEqouxIy361QcBy37DfHYFmrYlyb1DqUB78fUs4rzodQ24Un6Uu/YKYTm
	ADSnZFdJzyzDF8EkVC58XmNzdZeBNfbX/AaBRI9HaJ5V1fSkBVnNp7iOKFxgEp2CKEX0mZ
	f50heZspxbyKoSSpgM0WTro465ELZAo=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-351-F6clsVNHPJ6ROWLnUSaDdw-1; Wed,
 04 Dec 2024 11:00:27 -0500
X-MC-Unique: F6clsVNHPJ6ROWLnUSaDdw-1
X-Mimecast-MFC-AGG-ID: F6clsVNHPJ6ROWLnUSaDdw
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 467261953959;
	Wed,  4 Dec 2024 16:00:24 +0000 (UTC)
Received: from hydra.redhat.com (unknown [10.39.193.255])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B1E161955F42;
	Wed,  4 Dec 2024 16:00:18 +0000 (UTC)
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
	Caleb Connolly <caleb.connolly@linaro.org>,
	Petr Mladek <pmladek@suse.com>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Cc: Jocelyn Falempe <jfalempe@redhat.com>
Subject: [PATCH v9 0/6] drm/log: Introduce a new boot logger to draw the kmsg on the screen
Date: Wed,  4 Dec 2024 16:44:59 +0100
Message-ID: <20241204160014.1171469-1-jfalempe@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

drm_log is a simple logger that uses the drm_client API to print the kmsg boot log on the screen.
This is not a full replacement to fbcon, as it will only print the kmsg.
It will never handle user input, or a terminal because this is better done in userspace.

If you're curious on how it looks like, I've put a small demo here:
https://people.redhat.com/jfalempe/drm_log/drm_log_draft_boot_v2.mp4

Design decisions:
  * It uses the drm_client API, so it should work on all drm drivers from the start.
  * It doesn't scroll the message, that way it doesn't need to redraw the whole screen for each new message.
    It also means it doesn't have to keep drawn messages in memory, to redraw them when scrolling.
  * It uses the new non-blocking console API, so it should work well with PREEMPT_RT
 
v2:
 * Use vmap_local() api, with that change, I've tested it successfully on simpledrm, virtio-gpu, amdgpu, and nouveau.
 * Stop drawing when the drm_master is taken. This avoid wasting CPU cycle if the buffer is not visible.
 * Use deferred probe. Only do the probe the first time there is a log to draw. With this, if you boot with quiet, drm_log won't do any modeset.
 * Add color support for the timestamp prefix, like what dmesg does.
 * Add build dependency on  disabling the fbdev emulation, as they are both drm_client, and there is no way to choose which one gets the focus.

v3:
 * Remove the work thread and circular buffer, and use the new write_thread() console API.
 * Register a console for each drm driver.

v4:
 * Can be built as a module, even if that's not really useful.
 * Rebased on top of "drm: Introduce DRM client library" series from Thomas Zimmermann.
 * Add a Kconfig menu to choose between drm client.
 * Add suspend/resume callbacks.
 * Add integer scaling support.
 
v5:
 * Build drm_log in drm_client_lib module, to avoid circular dependency.
 * Export drm_draw symbols, so they can be used if drm_client_lib is built as module.
 * Change scale parameter to unsigned int (Jani Nikula)

v6:
 * Use console_stop() and console_start() in the suspend/resume callback (Petr Mladek).
 * rebase and solve conflict with "drm/panic: Add ABGR2101010 support"

v7:
 * Add a patch fix a build issue due to missing DRM_CLIENT_LIB, reported by kernel test bot.

v8:
 * Rebased after drm client moved to drivers/gpu/drm/clients/
 * Rename DRM_LOG to DRM_CLIENT_LOG (Thomas Zimmermann)
 * Drop "Always select DRM_CLIENT_LIB", and select only if DRM_CLIENT_LOG is set
 * Add an info message if no clients are initialized in drm_client_setup()

v9:
 * Rename drm_draw.h to drm_draw_internal.h (Jani Nikula)
 * Add cflags to remove the "../" when including drm internal headers (Jani Nikula)
 * Order select alphabetically in KConfig (Thomas Zimmermann)
 * Replace drm_info with drm_dbg, to be less verbose (Thomas Zimmermann)
 * Rename module parameter to drm_client_lib.active (Thomas Zimmermann)
 * Warn if drm_client_lib.active is malformated (Thomas Zimmermann)
 
Jocelyn Falempe (6):
  drm/panic: Move drawing functions to drm_draw
  drm/log: Introduce a new boot logger to draw the kmsg on the screen
  drm/log: Do not draw if drm_master is taken
  drm/log: Color the timestamp, to improve readability
  drm/log: Implement suspend/resume
  drm/log: Add integer scaling support

 drivers/gpu/drm/Kconfig                       |   5 +
 drivers/gpu/drm/Makefile                      |   1 +
 drivers/gpu/drm/clients/Kconfig               |  48 ++
 drivers/gpu/drm/clients/Makefile              |   3 +
 drivers/gpu/drm/clients/drm_client_internal.h |   6 +
 drivers/gpu/drm/clients/drm_client_setup.c    |  29 +-
 drivers/gpu/drm/clients/drm_log.c             | 420 ++++++++++++++++++
 drivers/gpu/drm/drm_draw.c                    | 233 ++++++++++
 drivers/gpu/drm/drm_draw_internal.h           |  56 +++
 drivers/gpu/drm/drm_panic.c                   | 257 +----------
 10 files changed, 820 insertions(+), 238 deletions(-)
 create mode 100644 drivers/gpu/drm/clients/drm_log.c
 create mode 100644 drivers/gpu/drm/drm_draw.c
 create mode 100644 drivers/gpu/drm/drm_draw_internal.h


base-commit: c6eabbab359c156669e10d5dec3e71e80ff09bd2
-- 
2.47.1


