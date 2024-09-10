Return-Path: <linux-kernel+bounces-322520-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B3F1B972A3F
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 09:08:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9CCE286963
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 07:08:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52CA717BB1A;
	Tue, 10 Sep 2024 07:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fgY50WUK"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF30C17C231
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 07:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725952092; cv=none; b=g7quRiVCmi/rJneGmH+h+9paF6bKezAUJ3KOo8xiQGJszzSIrlr9vQ0nS8vs1HaIH0tTQh1B6XGbrfDQVb6jefiErIlEoPVet3eOZ/m1feLkIK5q3DmCTdbOEEyMfsuTTmZSuLdIPqEiAuX+1+tUJ6TN81KbxC2daCmGsG1JijY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725952092; c=relaxed/simple;
	bh=gdkKIIcdSa/aA4JlRHEbsRHkcP0GGcIh4a7ECtuAhxg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=N4G3tCaGAX9sOryDKOqmYf7wubJCMDLJVZUqYIRSODr4/JWgEcQX9/eC66GZ7/aRtylg6JPo/vrgzLYIw/ammILbrtEzeO8xdzSu0M6QF/zAOHpTxulZVsAovEHktyOyrXfVSyROHfWRKzw1La2IREqHZIl6DJyGZ3wqbsAI0IY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fgY50WUK; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725952088;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=p52drQQWWMDPDWHyDAHWFf4kflo+RvAWsxo4nv351ts=;
	b=fgY50WUK5wsoApVai08SXFJIwd/+vWjlwWGPtGOny21tfmk2y3TalLygcmB/dA6YXA7R0P
	rWCMnhCObjpq8zVa4E33n4cntCsVjg259ZOdUg8UlpGnmUFXkkDz2dwUsib8fiS7S176tx
	EDJPZNOMrCo6XR+dhwL8n1zBDKGqP1Q=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-636-5WRrWSkaM2SiVqXkOYDQOA-1; Tue,
 10 Sep 2024 03:08:03 -0400
X-MC-Unique: 5WRrWSkaM2SiVqXkOYDQOA-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 244741954209;
	Tue, 10 Sep 2024 07:08:01 +0000 (UTC)
Received: from hydra.redhat.com (unknown [10.39.194.27])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id F256119560A3;
	Tue, 10 Sep 2024 07:07:56 +0000 (UTC)
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
Subject: [PATCH v3 0/4] drm/log: Introduce a new boot logger to draw the kmsg on the screen
Date: Tue, 10 Sep 2024 08:56:27 +0200
Message-ID: <20240910070733.156127-1-jfalempe@redhat.com>
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
  * drm_log can only be built-in (and drm must be built-in too).
    The reason is that, if you build it as a module, then a userspace application will be more appropriate than this module.
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

Thanks and best regards,

Jocelyn Falempe (4):
  drm/panic: Move drawing functions to drm_draw
  drm/log: Introduce a new boot logger to draw the kmsg on the screen
  drm/log: Do not draw if drm_master is taken
  drm/log: Color the timestamp, to improve readability

 drivers/gpu/drm/Kconfig     |  19 ++
 drivers/gpu/drm/Makefile    |   3 +
 drivers/gpu/drm/drm_draw.c  | 216 ++++++++++++++++++++
 drivers/gpu/drm/drm_draw.h  |  56 ++++++
 drivers/gpu/drm/drm_drv.c   |   2 +
 drivers/gpu/drm/drm_log.c   | 391 ++++++++++++++++++++++++++++++++++++
 drivers/gpu/drm/drm_log.h   |  11 +
 drivers/gpu/drm/drm_panic.c | 247 +++--------------------
 8 files changed, 721 insertions(+), 224 deletions(-)
 create mode 100644 drivers/gpu/drm/drm_draw.c
 create mode 100644 drivers/gpu/drm/drm_draw.h
 create mode 100644 drivers/gpu/drm/drm_log.c
 create mode 100644 drivers/gpu/drm/drm_log.h


base-commit: 9aaeb87ce1e966169a57f53a02ba05b30880ffb8
-- 
2.46.0


