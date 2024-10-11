Return-Path: <linux-kernel+bounces-360987-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B2DE399A215
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 12:55:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4194C1F23392
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 10:55:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94B97212F13;
	Fri, 11 Oct 2024 10:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QpVTJbCM"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C4BD212F0E
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 10:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728644149; cv=none; b=Bxh7z1gH+uheXmRRQCvQQKncET3PpmqWmGLcC0FkX31uNV4WhCjssxOrOW0mTZDtG9qNiKcx3FUiovULbUoQLYDQBQ4CYtR9xb0+JU9DgB+ek5nyrHHhh/rW0zkTXDHX8X9ddiovHZyOdU7PR3p5QYPr7poH3S/TRGFD9qikrak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728644149; c=relaxed/simple;
	bh=c2kNfuihw4bq8T7R7bk+Wqmx/KSQm97r9fm06TxJPRc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=R4F1jb2QEHwntYQ9PTGQmUBHuXLeaBitzF5SK0ZcXHNuPYG9BhfEvRxn+YpG0u5/EnsmQKk1C9BTy+3h+aIVAhohyK+RW9A/+5O1iJZKQuU0+NGitN87zpMbBM4xraGz0bUu3oFKGUNObau6M6SpaXyB6txalLfH7C5zJao0mEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QpVTJbCM; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728644145;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=nKrFKiqw6p8t0Q1gg3l5P1jUJ3sq9xk4VDyC3qcm1dY=;
	b=QpVTJbCM4zIRHgVgjtoYPXkjwqa2eqGjMEF8Kc58E5ZR66ulqKpbug+/4+DtS9Y6kMhWVG
	kidLcnBpsH0cdTrF2YTIw7yfUn7/9WiUzSkSTNJItJds6M2PSRlkq7DgjkRUbRDtzhT3Fh
	Ws7ZnEiVHpBG32k796ecf6WBpc7c2Wk=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-103-Izce6minNjm6ZwfdRZ0OGw-1; Fri,
 11 Oct 2024 06:55:42 -0400
X-MC-Unique: Izce6minNjm6ZwfdRZ0OGw-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B450E1954B08;
	Fri, 11 Oct 2024 10:55:40 +0000 (UTC)
Received: from hydra.redhat.com (unknown [10.39.192.224])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 30BED19560AA;
	Fri, 11 Oct 2024 10:55:35 +0000 (UTC)
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
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Cc: Jocelyn Falempe <jfalempe@redhat.com>
Subject: [PATCH v4 0/7] drm/log: Introduce a new boot logger to draw the kmsg on the screen
Date: Fri, 11 Oct 2024 12:49:57 +0200
Message-ID: <20241011105526.615812-1-jfalempe@redhat.com>
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

Thanks and best regards,

-- 

Jocelyn

Jocelyn Falempe (6):
  drm/panic: Move drawing functions to drm_draw
  drm/log: Introduce a new boot logger to draw the kmsg on the screen
  drm/log: Do not draw if drm_master is taken
  drm/log: Color the timestamp, to improve readability
  drm/log: Implement suspend/resume
  drm/log: Add integer scaling support

Thomas Zimmermann (1):
  [NOT FOR REVIEW] drm/client, squash of drm client pending series

 Documentation/gpu/drm-client.rst              |   3 +
 drivers/gpu/drm/Kconfig                       |  92 +++-
 drivers/gpu/drm/Makefile                      |  23 +-
 drivers/gpu/drm/amd/amdgpu/Kconfig            |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |  22 +-
 drivers/gpu/drm/drm_client.c                  | 121 -----
 drivers/gpu/drm/drm_client_event.c            | 197 ++++++++
 drivers/gpu/drm/drm_client_setup.c            |  21 +-
 drivers/gpu/drm/drm_debugfs.c                 |   1 -
 drivers/gpu/drm/drm_draw.c                    | 216 +++++++++
 drivers/gpu/drm/drm_draw.h                    |  56 +++
 drivers/gpu/drm/drm_drv.c                     |   2 +-
 drivers/gpu/drm/drm_fb_helper.c               |  31 --
 drivers/gpu/drm/drm_fbdev_client.c            |  30 +-
 drivers/gpu/drm/drm_file.c                    |   2 +-
 drivers/gpu/drm/drm_internal.h                |  15 +
 drivers/gpu/drm/drm_kms_helper_common.c       |  38 ++
 drivers/gpu/drm/drm_log.c                     | 426 ++++++++++++++++++
 drivers/gpu/drm/drm_log.h                     |  11 +
 drivers/gpu/drm/drm_modeset_helper.c          |  14 +-
 drivers/gpu/drm/drm_panic.c                   | 247 +---------
 drivers/gpu/drm/drm_probe_helper.c            |   2 +-
 drivers/gpu/drm/i915/Kconfig                  |   1 +
 .../drm/i915/display/intel_display_driver.c   |   2 +-
 drivers/gpu/drm/nouveau/nouveau_display.c     |   8 +-
 drivers/gpu/drm/nouveau/nouveau_vga.c         |   2 +-
 drivers/gpu/drm/radeon/radeon_device.c        |  19 +-
 drivers/gpu/drm/radeon/radeon_fbdev.c         |   6 -
 drivers/gpu/drm/radeon/radeon_mode.h          |   3 -
 drivers/gpu/drm/xe/Kconfig                    |   1 +
 include/drm/drm_client.h                      |  41 +-
 include/drm/drm_client_event.h                |  27 ++
 32 files changed, 1235 insertions(+), 446 deletions(-)
 create mode 100644 drivers/gpu/drm/drm_client_event.c
 create mode 100644 drivers/gpu/drm/drm_draw.c
 create mode 100644 drivers/gpu/drm/drm_draw.h
 create mode 100644 drivers/gpu/drm/drm_log.c
 create mode 100644 drivers/gpu/drm/drm_log.h
 create mode 100644 include/drm/drm_client_event.h


base-commit: 33c255312660653cf54f8019896b5dca28e3c580
-- 
2.46.2


