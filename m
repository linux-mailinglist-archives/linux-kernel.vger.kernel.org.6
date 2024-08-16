Return-Path: <linux-kernel+bounces-289686-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E14A8954A26
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 14:56:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 56E5FB224C1
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 12:56:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 265EB1B3F3D;
	Fri, 16 Aug 2024 12:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I7hSibTG"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0F8813CF86
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 12:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723813004; cv=none; b=YRhCqM0peDKI/XIIeRBPkhiHGt2Ba1aakfv8NZ8oHUWeK7vXOZiA6LMoVI1ytBHW4adEKD+SYS4JjtbCDTXJbplG6y+tqBXo3wwgWKORDW5KCsfahJHBzQ7/i7zlAPY9/+Q3GSaXcIeNah3XswbR072nxqeRH2T8tmtHG++wUS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723813004; c=relaxed/simple;
	bh=GD6GChZ+Igs5XE8jMbC8oZKx2TCiNCO0517e/t2L/rs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XFs4tVKagsqAX+PeHGqR2BGz2+oYnoYU0ZIrafIov1xAe8MChb7f/iTTWO30L9KtvWmUPmO1YOdvrY143nDRpi4peRHTkhO7/YcWmrsm+jTTIFa9h0xdYlEX05TLGpnxrdwEKHy5jRURX90IMgdKmc5r9Rw1i0rys4uOUiPy+Gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=I7hSibTG; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723813001;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=PbvZorZrTLiJIcsIRreQJ4q0L+3ldT0TNULndS/qqPA=;
	b=I7hSibTG4l+PrBLmoAZHT317f4NfMco872EcL5VVgVy46l16Us1d8nbkaBAkjUvXKOZmc8
	R0D9ttU0TqoYPt3SXm1LzIEcZ0dD26VGdlmgjabuwAwckO7G7kSHjA4GhwTwR7G2MZrhQf
	TM5+InMShIVn6sgUJ2QOzLX7L/SbaC4=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-595-L73TajsFPAivaDBHb4TVDg-1; Fri,
 16 Aug 2024 08:56:38 -0400
X-MC-Unique: L73TajsFPAivaDBHb4TVDg-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D50BB1955BF1;
	Fri, 16 Aug 2024 12:56:36 +0000 (UTC)
Received: from hydra.redhat.com (unknown [10.39.193.28])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9F71719560A3;
	Fri, 16 Aug 2024 12:56:32 +0000 (UTC)
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
Subject: [RFC PATCH v2 0/5] drm/log: Introduce a new boot logger to draw the kmsg on the screen
Date: Fri, 16 Aug 2024 14:52:32 +0200
Message-ID: <20240816125612.1003295-1-jfalempe@redhat.com>
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
  * It uses a circular buffer so the console->write() callback is very quick, and will never stall.
  * Drawing is done asynchronously using a workqueue.
  * drm_log can only be built-in (and drm must be built-in too).
    The reason is that, if you build it as a module, then a userspace application will be more appropriate than this module.
  * When nbcon will be ready, I will use it. It should simplify this a lot, but I prefer not to depend on it yet.
 
The first patch is not for review/merge, it's a squash of my pending drm_panic series:
https://patchwork.freedesktop.org/series/135944/

The second patch, moves the drawing function from drm_panic.c, to drm_draw.c, so they can be re-used by drm_log.
The next patches are the actual drm_log implementation.

v2:
 * Use vmap_local() api, with that change, I've tested it successfully on simpledrm, virtio-gpu, amdgpu, and nouveau.
 * Stop drawing when the drm_master is taken. This avoid wasting CPU cycle if the buffer is not visible.
 * Use deferred probe. Only do the probe the first time there is a log to draw. With this, if you boot with quiet, drm_log won't do any modeset.
 * Add color support for the timestamp prefix, like what dmesg does.
 * Add build dependency on  disabling the fbdev emulation, as they are both drm_client, and there is no way to choose which one gets the focus.

Thanks and best regards,

-- 

Jocelyn

Jocelyn Falempe (5):
  [NOT FOR REVIEW] drm/panic: Squash of pending series
  drm/panic: Move drawing functions to drm_draw
  drm/log: Introduce a new boot logger to draw the kmsg on the screen
  drm/log: Do not draw if drm_master is taken
  drm/log: Color the timestamp, to improve readability

 drivers/gpu/drm/Kconfig             |   50 ++
 drivers/gpu/drm/Makefile            |    4 +
 drivers/gpu/drm/drm_crtc_internal.h |    4 +
 drivers/gpu/drm/drm_draw.c          |  216 ++++++
 drivers/gpu/drm/drm_draw.h          |   56 ++
 drivers/gpu/drm/drm_drv.c           |    5 +
 drivers/gpu/drm/drm_log.c           |  515 ++++++++++++++
 drivers/gpu/drm/drm_log.h           |   11 +
 drivers/gpu/drm/drm_panic.c         |  569 ++++++++-------
 drivers/gpu/drm/drm_panic_qr.rs     | 1003 +++++++++++++++++++++++++++
 include/drm/drm_rect.h              |   15 +
 11 files changed, 2193 insertions(+), 255 deletions(-)
 create mode 100644 drivers/gpu/drm/drm_draw.c
 create mode 100644 drivers/gpu/drm/drm_draw.h
 create mode 100644 drivers/gpu/drm/drm_log.c
 create mode 100644 drivers/gpu/drm/drm_log.h
 create mode 100644 drivers/gpu/drm/drm_panic_qr.rs


base-commit: 8befe8fa5a4e4b30787b17e078d9d7b5cb92ea19
-- 
2.46.0


