Return-Path: <linux-kernel+bounces-377995-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A96D9AC9BC
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 14:12:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C93ED1C21417
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 12:12:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06AE61ABEAC;
	Wed, 23 Oct 2024 12:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GOc0cHX5"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9CB61AB6ED
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 12:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729685526; cv=none; b=uYPk8z8kGQcpWecxarpajXZWa2Eswx1Gaee6F4Xg9qLMHV9FC11ekoXz+Dc/DTeOJyu4YXjAslYDRsV2tJ10Ls/hTLHsgv9YtotEi/vzxPanoK6iv2JTxkZPEr2C4Rz5vqTuIYXNNwn3mEGZjPkyzo+9GijVz/XG6uenFsbsFp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729685526; c=relaxed/simple;
	bh=267pId+68W9vT43Le+DwA2luVRWCzazrVDCf1fLXPSE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=btBBsDoaIK/eL+ovRLrHg5Me5fTYOT0wC+X54lkxBH2zaOQZ2RBrHE1Msd55g9gVmJ7yVdAx+5ctUgne8YPDcvmGjSLMUMOdgXMRZ+kWXDlj//nPUYLL1FUpmuhp5dUt3ADZIl6sZjjmBuNnnU2yRIwwtb1ABm0c7t9G81NbLUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GOc0cHX5; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729685523;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=YacGGiubhp4cLP/Rq3Z20+XugGduRvDoRkyi8QeB+Xw=;
	b=GOc0cHX5e7PvZFqcHBaLWmGbEBAkC8lFi8Br/zDxOarZK4l0qyzuZWaCfsA/ZzcNlR+/9w
	Tg784PHRGPwf/qaLATiZM2dWwsy+p4h5jAIUsbIbn4rzWHG4p5o2PIzVws/IDeclTEImXU
	3lZkQfJLHZxsy1ugm55n3q4/15Rg3TQ=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-438-9JnfRoiOOBG8gN5zGhTdtQ-1; Wed,
 23 Oct 2024 08:12:00 -0400
X-MC-Unique: 9JnfRoiOOBG8gN5zGhTdtQ-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7D3A019560A6;
	Wed, 23 Oct 2024 12:11:57 +0000 (UTC)
Received: from hydra.redhat.com (unknown [10.39.193.145])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7119A300018D;
	Wed, 23 Oct 2024 12:11:53 +0000 (UTC)
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
Subject: [PATCH v5 0/6] drm/log: Introduce a new boot logger to draw the kmsg on the screen
Date: Wed, 23 Oct 2024 14:00:08 +0200
Message-ID: <20241023121145.1321921-1-jfalempe@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

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

Jocelyn Falempe (6):
  drm/panic: Move drawing functions to drm_draw
  drm/log: Introduce a new boot logger to draw the kmsg on the screen
  drm/log: Do not draw if drm_master is taken
  drm/log: Color the timestamp, to improve readability
  drm/log: Implement suspend/resume
  drm/log: Add integer scaling support

 drivers/gpu/drm/Kconfig            |  51 ++++
 drivers/gpu/drm/Makefile           |   2 +
 drivers/gpu/drm/drm_client_setup.c |  18 +-
 drivers/gpu/drm/drm_draw.c         | 223 +++++++++++++++
 drivers/gpu/drm/drm_draw.h         |  56 ++++
 drivers/gpu/drm/drm_log.c          | 426 +++++++++++++++++++++++++++++
 drivers/gpu/drm/drm_log.h          |  11 +
 drivers/gpu/drm/drm_panic.c        | 247 ++---------------
 8 files changed, 807 insertions(+), 227 deletions(-)
 create mode 100644 drivers/gpu/drm/drm_draw.c
 create mode 100644 drivers/gpu/drm/drm_draw.h
 create mode 100644 drivers/gpu/drm/drm_log.c
 create mode 100644 drivers/gpu/drm/drm_log.h


base-commit: 91e21479c81dd4e9e22a78d7446f92f6b96a7284
-- 
2.47.0


