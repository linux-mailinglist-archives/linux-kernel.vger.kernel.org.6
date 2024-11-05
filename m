Return-Path: <linux-kernel+bounces-396434-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 961759BCD05
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 13:51:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C83DE1C2156B
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 12:51:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94D401D5AAC;
	Tue,  5 Nov 2024 12:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ho6hO4I+"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0B5F1D0B82
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 12:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730811091; cv=none; b=L71BZnhMeaMbwIsL6lOwCV4XAOkjKhVFz9N4unsW8lNU9nYk39/WHC5N87MpXPkMSgCSFMW1M89Ogd59/owAbkesNsIS6FCRrRd9KEG41+fi9qGj++7A1TDq09VjD/x1DayM8tZUc4W1RMpAwQ0EHUN5L+69OMvgWgxMTkAP5rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730811091; c=relaxed/simple;
	bh=nWcXxC0AotC7OQiHqMCTtFbx4bJnZGRULMdMW446AUc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YwCr+DBy5O95DcQADG0LFOyLYYkg9hjULuQXIwLD6mUUyFLEviu+aDxzMw7fMeZPR1O6aShZHTnKvATJ55EK/Desm+tb3b1zAn9mQRxWAJWHapfuKA254XXTb4R9269tkOyYqfjIFe9qmI509PxCSBM9cHcUpoM5WURdKhrm09Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ho6hO4I+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730811087;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=4qZIiHm0ama7KMOdEhG12GBEN3YN2U7MriBJ2ZH+vvU=;
	b=Ho6hO4I+3Cja85qRxTdNXT/v9VhRcYYXR4IXUDAot35KuTTHsCDV9dErQ2a6VsJNIo+4Tp
	/uSzKHd8H0ljLPszLTXDEx8h6JPUZRr6p/hq2tFEV9ewm739Xx3IO5BcywXslNIg0fd8KN
	/6xybyoWUHWdUH7y+bdcQXaxc9/cFgw=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-677-V7OqT96nOWq-E28owUraBg-1; Tue,
 05 Nov 2024 07:51:26 -0500
X-MC-Unique: V7OqT96nOWq-E28owUraBg-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C922A1977029;
	Tue,  5 Nov 2024 12:51:23 +0000 (UTC)
Received: from hydra.redhat.com (unknown [10.39.193.51])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9198719560AD;
	Tue,  5 Nov 2024 12:51:19 +0000 (UTC)
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
Subject: [PATCH v6 0/6] drm/log: Introduce a new boot logger to draw the kmsg on the screen
Date: Tue,  5 Nov 2024 13:42:20 +0100
Message-ID: <20241105125109.226866-1-jfalempe@redhat.com>
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
 drivers/gpu/drm/drm_draw.c         | 233 ++++++++++++++++
 drivers/gpu/drm/drm_draw.h         |  56 ++++
 drivers/gpu/drm/drm_log.c          | 420 +++++++++++++++++++++++++++++
 drivers/gpu/drm/drm_log.h          |  11 +
 drivers/gpu/drm/drm_panic.c        | 257 ++----------------
 8 files changed, 811 insertions(+), 237 deletions(-)
 create mode 100644 drivers/gpu/drm/drm_draw.c
 create mode 100644 drivers/gpu/drm/drm_draw.h
 create mode 100644 drivers/gpu/drm/drm_log.c
 create mode 100644 drivers/gpu/drm/drm_log.h


base-commit: d78f0ee0406803cda8801fd5201746ccf89e5e4a
-- 
2.47.0


