Return-Path: <linux-kernel+bounces-401248-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83A739C17BD
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 09:21:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 479DC2840D2
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 08:20:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 008C71DD534;
	Fri,  8 Nov 2024 08:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dLVzHcly"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E7FC1F5FA
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 08:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731054054; cv=none; b=j/cA4ortcgm7wPvEE7kY2jWGDsq2uYFIGXVHUKCSohFMFhCLTXXPgAd++BHeBUKuWlEMBk9CkGR1YhXCDz2N3iD/mO0VIbft6JMJNQPX6HzvNwZ2gpIEc7S22IYFe84vKyaOejLlVmMyWoGfB60mI1ITnReK7Xc3bPo1ZIYQwRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731054054; c=relaxed/simple;
	bh=m9lM0w6P9a7uSkyG/8gM1J0rO9rtbEUKMBJpEOFd5M8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ClGXnZW/qiJtdKkBemTS8HvJx/ZMlc2USZiY2C1iU/RICuU8b5TdEW3vZ+eORK44ankunVV9j2B8VqyiycBPPHmXLdQH1EoSTtY8E/s5wEsH0Pd5GW5wW7fT4YfydIG8O8N4NVaOR/ng/3Q+CgGStZSPLwYvslVfCVn2rVh0Y/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dLVzHcly; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731054051;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=8A3ThVrC7cTil9Qo1AWQe62YpyZnM2l43IjuztPMCjc=;
	b=dLVzHclyTalIqATByNs6xz3gTvBBcIq9G127oOD57LRGYKYOZ9WT3N8bHj3DuoTzmwZB64
	c9TnqDUNtd6KIjvgjeilDDdK+dDjwWYo8Ml1zmA5zUPRopfYVzsQ2x5xaq8rxvciFe6JwD
	K5aE9FilMmO7s75jggDfhBm5EcZ2RSw=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-163-4b9tNNR4MfWSbMIQM27DwQ-1; Fri,
 08 Nov 2024 03:20:47 -0500
X-MC-Unique: 4b9tNNR4MfWSbMIQM27DwQ-1
X-Mimecast-MFC-AGG-ID: 4b9tNNR4MfWSbMIQM27DwQ
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C1B941955D75;
	Fri,  8 Nov 2024 08:20:38 +0000 (UTC)
Received: from hydra.redhat.com (unknown [10.39.193.51])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A03111955F3D;
	Fri,  8 Nov 2024 08:20:33 +0000 (UTC)
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
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Cc: Jocelyn Falempe <jfalempe@redhat.com>
Subject: [PATCH v7 0/7] drm/log: Introduce a new boot logger to draw the kmsg on the screen
Date: Fri,  8 Nov 2024 09:10:18 +0100
Message-ID: <20241108082025.1004653-1-jfalempe@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

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

Jocelyn Falempe (7):
  drm/panic: Move drawing functions to drm_draw
  drm/client: Always select DRM_CLIENT_LIB
  drm/log: Introduce a new boot logger to draw the kmsg on the screen
  drm/log: Do not draw if drm_master is taken
  drm/log: Color the timestamp, to improve readability
  drm/log: Implement suspend/resume
  drm/log: Add integer scaling support

 drivers/gpu/drm/Kconfig            |  53 +++-
 drivers/gpu/drm/Makefile           |   2 +
 drivers/gpu/drm/drm_client_setup.c |  18 +-
 drivers/gpu/drm/drm_draw.c         | 233 ++++++++++++++++
 drivers/gpu/drm/drm_draw.h         |  56 ++++
 drivers/gpu/drm/drm_log.c          | 420 +++++++++++++++++++++++++++++
 drivers/gpu/drm/drm_log.h          |  11 +
 drivers/gpu/drm/drm_panic.c        | 257 ++----------------
 8 files changed, 812 insertions(+), 238 deletions(-)
 create mode 100644 drivers/gpu/drm/drm_draw.c
 create mode 100644 drivers/gpu/drm/drm_draw.h
 create mode 100644 drivers/gpu/drm/drm_log.c
 create mode 100644 drivers/gpu/drm/drm_log.h


base-commit: baf4afc5831438b35de4b0e951b9cd58435a6d99
-- 
2.47.0


