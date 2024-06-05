Return-Path: <linux-kernel+bounces-201584-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99C828FC06C
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 02:24:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EBFE7B2473F
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 00:24:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60A571FAA;
	Wed,  5 Jun 2024 00:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hfkQ+ejv"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAF271854
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 00:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717547053; cv=none; b=AKstWYf3D/iWd9v8/ZGC4ppsrCE77ROnp6nrBo9iYVtj/Bc2O6PA/LxUEUfz3fZlYm6d+uteGyccA+oUnclEgQgWaPwolkLXwxfiJ51IZfedkFSCtuR7Ey83bd8ZjmM/A03+6W82AnxY3+SZp7mfdu7kiLbEzdpkglgIak9d+68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717547053; c=relaxed/simple;
	bh=JpfVrYJ+gH0YcLqe5ekq+QaLudPjixZ0FuZsjhaO310=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=H2E7+tZ2ve4Ia3J4vwZBXsPIuncpeUnC28ikQWnpJrCQ4j36qyCtYVvWF2BEo7dFpUI6dOOrvtEh+Uz+QvzwUmkJ/9L7wECIcHsDbqciEjg8MKXLxB07LsJopoouQQ7EWfM6wPgRIwFIxiMvressyC4zvz+PGSWYbA6KV5Z1ytc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=hfkQ+ejv; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1f44b4404dfso55298315ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2024 17:24:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1717547050; x=1718151850; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UXkqvnUlOHE+7g2Lf+Wpe/9y5rRcSPhO6InYqluayHc=;
        b=hfkQ+ejv78tMOcx7vLgryEQ+Yr/C3vZ6ZiQAlou2PacwzytbhOQUv2f7zHBUGIr5rv
         HlYCB04wwjs/ealGuSiMw9YJHjsfXPKZOzFtLa3EC7crREQT5j+CavQZcWRgvizLV3En
         WD+1X9jZpQS30A1zDZufUZYjbEFHjErE5FSsw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717547050; x=1718151850;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UXkqvnUlOHE+7g2Lf+Wpe/9y5rRcSPhO6InYqluayHc=;
        b=pA+pUXFCX6uXtqaIcEZqqtOyGLffmzn0ijo23LhnB3x+ReL8ziuqCXlyhs+K0eYaDA
         o5YZDxmhLmHOyObmlpG9W0GmH84rz2h0qoO3ffq2tKNlZFPFDEOIlu9PVeLGCh1pj+hD
         BuXHJ3PjaCBTJcHClKXtP2y9a3sNqqWz1iCJP9mX1IMwYUGGBPtQizc+70zPSxVJfQQ8
         UdRhu7ij3ANPuj4gzNAOIjNAYN/TOFjDBB7ISwnBOgi+OTJ0EYuWAl/nfAyIO35phMQ9
         u2VD8/Giag0V2rw8HTptnimXCmtUsFFHv+rQuLKvD+Zwpy+0dZ5jzaFinVC6RtfZdu0Z
         Y9KQ==
X-Forwarded-Encrypted: i=1; AJvYcCVsUC0sEcD90xtwHM/Q3PSAfHZUVILPMK6bIVm7lCusU69g7tDD1t8EwGTwUIjf//N6rAUn8HPzAZT5D+8qRP1Lm+8TLAzV1MglHIsZ
X-Gm-Message-State: AOJu0YwEof++OEZXw6I9FyrqAVz7x0JxLHGjwej0LcFWDww0DT5KjHFh
	no9VGQrK2WJD66hcL5uhaXXgnOWjvDoJdnSzApM3dyqmViVIaXI+wpLBq6doUA==
X-Google-Smtp-Source: AGHT+IGvUgTyAuYEN02i7ZduVODq/yACl5LSlZJPkmZP9QjjxS40pxNiem+pMYUDo4VgKeR8msH+hQ==
X-Received: by 2002:a17:902:d512:b0:1f6:1c5f:e089 with SMTP id d9443c01a7336-1f6a5a86e72mr14291545ad.60.1717547050047;
        Tue, 04 Jun 2024 17:24:10 -0700 (PDT)
Received: from dianders.sjc.corp.google.com ([2620:15c:9d:2:3609:ff79:4625:8a71])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f6323dd862sm89032025ad.147.2024.06.04.17.24.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jun 2024 17:24:09 -0700 (PDT)
From: Douglas Anderson <dianders@chromium.org>
To: dri-devel@lists.freedesktop.org,
	Maxime Ripard <mripard@kernel.org>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Chris Morgan <macromorgan@hotmail.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Yuran Pereira <yuran.pereira@hotmail.com>,
	Douglas Anderson <dianders@chromium.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	David Airlie <airlied@gmail.com>,
	Jerry Han <hanxu5@huaqin.corp-partner.google.com>,
	Jessica Zhang <quic_jesszhan@quicinc.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Robert Chiras <robert.chiras@nxp.com>,
	Stefan Mavrodiev <stefan@olimex.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	linux-arm-kernel@lists.infradead.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH v3 00/24] drm/panel: Remove most store/double-check of prepared/enabled state
Date: Tue,  4 Jun 2024 17:22:46 -0700
Message-ID: <20240605002401.2848541-1-dianders@chromium.org>
X-Mailer: git-send-email 2.45.1.288.g0e0cd299f1-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit


As talked about in commit d2aacaf07395 ("drm/panel: Check for already
prepared/enabled in drm_panel"), we want to remove needless code from
panel drivers that was storing and double-checking the
prepared/enabled state. Even if someone was relying on the
double-check before, that double-check is now in the core and not
needed in individual drivers.

This series attempts to do just that. While the original grep, AKA:
  git grep 'if.*>prepared' -- drivers/gpu/drm/panel
  git grep 'if.*>enabled' -- drivers/gpu/drm/panel
...still produces a few hits after my series, they are _mostly_ all
gone. The ones that are left are less trivial to fix.

One of the main reasons that many panels probably needed to store and
double-check their prepared/enabled appears to have been to handle
shutdown and/or remove. Panels drivers often wanted to force the power
off for panels in these cases and this was a good reason for the
double-check.

In response to my V1 series [1] we had much discussion of what to
do. The conclusion was that as long as DRM modeset drivers properly
called drm_atomic_helper_shutdown() that we should be able to remove
the explicit shutdown/remove handling in the panel drivers. Most of
the patches to improve DRM modeset drivers [2] [3] [4] have now
landed.

In contrast to my V1 series, I broke the V2 series up a lot
more. Since a few of the panel drivers in V1 already landed, we had
fewer total drivers and so we could devote a patch to each panel.
Also, since we were now relying on DRM modeset drivers I felt like we
should split the patches for each panel into two: one that's
definitely safe and one that could be reverted if we found a
problematic DRM modeset driver that we couldn't fix.

Many of the patches in the V2 series [5] landed, so this V3 series is
the patches that are left plus one new bonus patch. At this point, we
may want to just land the patches that are left since it seems like
nobody is going to test/review them and they've all been Acked by
Linus and Maxime.

NOTE: this touches _a lot_ of drivers, is repetitive, and is not
really possible to generate automatically. That means it's entirely
possible that my eyes glazed over and I did something wrong. Please
double-check me and don't assume that I got everything perfect, though
I did my best. I have at least confirmed that "allmodconfig" for arm64
doesn't fall on its face with this series. I haven't done a ton of
other testing.

[1] https://lore.kernel.org/r/20230804140605.RFC.4.I930069a32baab6faf46d6b234f89613b5cec0f14@changeid
[2] https://lore.kernel.org/r/20230901234015.566018-1-dianders@chromium.org
[3] https://lore.kernel.org/r/20230901234202.566951-1-dianders@chromium.org
[4] https://lore.kernel.org/r/20230921192749.1542462-1-dianders@chromium.org
[5] https://lore.kernel.org/r/20240503213441.177109-1-dianders@chromium.org/

Changes in v3:
- drm/panel: Avoid warnings w/ panel-simple/panel-edp at shutdown

Changes in v2:
- Only handle 1 panel per patch.
- Split removal of prepared/enabled from handling of remove/shutdown.

Douglas Anderson (24):
  drm/panel: boe-himax8279d: Stop tracking prepared/enabled
  drm/panel: boe-himax8279d: Don't call unprepare+disable at
    shutdown/remove
  drm/panel: khadas-ts050: Stop tracking prepared/enabled
  drm/panel: khadas-ts050: Don't call unprepare+disable at
    shutdown/remove
  drm/panel: olimex-lcd-olinuxino: Stop tracking prepared/enabled
  drm/panel: olimex-lcd-olinuxino: Don't call unprepare+disable at
    remove
  drm/panel: osd-osd101t2587-53ts: Stop tracking prepared/enabled
  drm/panel: osd-osd101t2587-53ts: Don't call unprepare+disable at
    shutdown/remove
  drm/panel: tdo-tl070wsh30: Stop tracking prepared
  drm/panel: tdo-tl070wsh30: Don't call unprepare+disable at
    shutdown/remove
  drm/panel: jdi-lt070me05000: Stop tracking prepared/enabled
  drm/panel: jdi-lt070me05000: Don't call disable at shutdown/remove
  drm/panel: panasonic-vvx10f034n00: Stop tracking prepared/enabled
  drm/panel: panasonic-vvx10f034n00: Don't call disable at
    shutdown/remove
  drm/panel: seiko-43wvf1g: Stop tracking prepared/enabled
  drm/panel: seiko-43wvf1g: Don't call disable at shutdown/remove
  drm/panel: sharp-lq101r1sx01: Stop tracking prepared/enabled
  drm/panel: sharp-lq101r1sx01: Don't call disable at shutdown/remove
  drm/panel: sharp-ls043t1le01: Stop tracking prepared
  drm/panel: sharp-ls043t1le01: Don't call disable at shutdown/remove
  drm/panel: raydium-rm67191: Stop tracking enabled
  drm/panel: raydium-rm67191: Don't call unprepare+disable at shutdown
  drm/panel: Update TODO list item for cleaning up prepared/enabled
    tracking
  drm/panel: Avoid warnings w/ panel-simple/panel-edp at shutdown

 Documentation/gpu/todo.rst                    |  47 +++---
 drivers/gpu/drm/drm_panel.c                   |  12 ++
 drivers/gpu/drm/panel/panel-boe-himax8279d.c  |  40 -----
 .../gpu/drm/panel/panel-drm-shutdown-check.h  | 151 ++++++++++++++++++
 drivers/gpu/drm/panel/panel-edp.c             |  19 +--
 .../gpu/drm/panel/panel-jdi-lt070me05000.c    |  35 ----
 drivers/gpu/drm/panel/panel-khadas-ts050.c    |  39 -----
 .../drm/panel/panel-olimex-lcd-olinuxino.c    |  44 -----
 .../drm/panel/panel-osd-osd101t2587-53ts.c    |  41 +----
 .../drm/panel/panel-panasonic-vvx10f034n00.c  |  47 +-----
 drivers/gpu/drm/panel/panel-raydium-rm67191.c |  26 ---
 drivers/gpu/drm/panel/panel-seiko-43wvf1g.c   |  49 ------
 .../gpu/drm/panel/panel-sharp-lq101r1sx01.c   |  63 +-------
 .../gpu/drm/panel/panel-sharp-ls043t1le01.c   |  24 ---
 drivers/gpu/drm/panel/panel-simple.c          |  19 +--
 drivers/gpu/drm/panel/panel-tdo-tl070wsh30.c  |  23 ---
 16 files changed, 199 insertions(+), 480 deletions(-)
 create mode 100644 drivers/gpu/drm/panel/panel-drm-shutdown-check.h

-- 
2.45.1.288.g0e0cd299f1-goog


