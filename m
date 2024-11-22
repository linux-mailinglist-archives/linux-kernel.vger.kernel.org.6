Return-Path: <linux-kernel+bounces-418498-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AC399D6249
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 17:28:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5BFC6B24AEE
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 16:28:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 094C01CEAD2;
	Fri, 22 Nov 2024 16:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="XYlXDhrJ"
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 295376F30C
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 16:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732292891; cv=none; b=nscT475JBVKN8m2FDIshlFqtVMpJvUGjDzIzeRfk8YJ8uLMAOsSArxhfRiKAO5PgHH3R8RiuGj9CVoYR93uUZibHxRGQhiQ43hckW443tddmv/V1nYJDSmM4ihXKyDwTWi6JsqkqMo+f+Xfbn0xlmBaBesCOnn1HYtxH3rJWsNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732292891; c=relaxed/simple;
	bh=ZhfnABr7/0v+IKoElmwmDDns/QME0eBgVjAC+RDBUrM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=t3zPmDNPyR4LzWV6IcSU5zCGye6dZRSrdvO8wH5GSPvyTa1s1Fy6AlnYXGyOYpuuaVH81JDWc8IJWmuyEHMdJ9Az4WMNzautYm8+e/zD7MsoNWQXJotw7SS4udHG/kGSI+iwfFbaehTogmCxyXIvXPlZ8R31r//66Q/W2/dorT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=XYlXDhrJ; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id A7082FF80A;
	Fri, 22 Nov 2024 16:27:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1732292881;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=LU6gbsQShqZCx3WrJuxI/JRiigMCYgE3TNnA7yxnsb8=;
	b=XYlXDhrJ5XnMql26AwcYg/+8bqgUD2W0T+Oi6QCOGbInqV69zQkQOLkTLUP/vDHlEQZR6N
	QFbXz3nwN1yxKPk1DRRZVH7U8GgfQ5qHgeRwTtIPxkMI/iho2afDvccHaQpvXI2eiePNBj
	yJxlfEza7Ot4uAF3MEjJ2zsB4Bcf9y4I4ouGUPI3WYiNff32e2Ab+sBv/0Uc08CzHDLgOQ
	UXrTEqB2yQZJJgJBPnfZ+tNcFizxmr/c+C9DMQjn3vycj0cmo6fIOAQ8bkQrPhSrlfeguz
	RfrSixOCngZmP+NhhSiMJYi4pHHF7+HBIQ6sVUXv8NInDThnpIPHx9B7xKHMmQ==
From: Louis Chauvet <louis.chauvet@bootlin.com>
Subject: [PATCH v5 0/5] drm/vkms: Switch all vkms object to DRM managed
 objects
Date: Fri, 22 Nov 2024 17:27:55 +0100
Message-Id: <20241122-google-vkms-managed-v5-0-1ab60403e960@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAuxQGcC/23PTW7DIBQE4KtYrEsLz9jYWfUeVRdgXhzUAClQl
 Cry3Usc9UeNdwzSfAwXkjBaTGTXXEjEYpMNvobuoSHTQfkZqTU1E2AgWAecziHMR6TlzSXqlFc
 zGioUTuMoeq6kJLV5iri351V9eb3liO8fFc+3S6JVQjoF52zeNSY66myanr4P1OM5k2vzYFMO8
 XOdV/haXZcMXGwuKZwyKpUe9DAC56x91iHko/WP9bFVLPBHAbmtQFX2ovZF17UK9b3S/iojh22
 lvW6RbDC9MtCDuVfEj8IZZ9uKqAoaJlQPlcF/P1qW5Qu/J07vxAEAAA==
X-Change-ID: 20240521-google-vkms-managed-4aec99461a77
To: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>, 
 Melissa Wen <melissa.srw@gmail.com>, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mairacanal@riseup.net>, 
 Haneen Mohammed <hamohammed.sa@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Simona Vetter <simona.vetter@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, arthurgrillo@riseup.net, 
 linux-kernel@vger.kernel.org, jeremie.dautheribes@bootlin.com, 
 miquel.raynal@bootlin.com, thomas.petazzoni@bootlin.com, 
 seanpaul@google.com, nicolejadeyee@google.com, 
 Louis Chauvet <louis.chauvet@bootlin.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2863;
 i=louis.chauvet@bootlin.com; h=from:subject:message-id;
 bh=ZhfnABr7/0v+IKoElmwmDDns/QME0eBgVjAC+RDBUrM=;
 b=owEBbQKS/ZANAwAIASCtLsZbECziAcsmYgBnQLENlewUY9ZaxyWAoiGc7hbws81gacGor/kB/
 gxFoQmajmSJAjMEAAEIAB0WIQRPj7g/vng8MQxQWQQgrS7GWxAs4gUCZ0CxDQAKCRAgrS7GWxAs
 4rbUEACpMmTvptfzfmQ1qjJsGJndT4acpMhmnI0yh5gim8oY0i7Y+KVbA2kVwvd4uXNTj3OL1QM
 Ak9NB7v2WM9Rg/1xzaFoaH4UDop1QhLL+KYOUnINpSgr7wa65B47x71UGgvxXPEuq6IhL3G0KTn
 OZMhCyjmVsvFlf/HGNQhE7Re6Daflnun7W16dzNpL0ApLmkTxmP4MQVFd0OFaKFVQTVph9W1+jg
 0MAi7cgq1KCxYpaxTMaLh+MJDGoNLtTeeQjfLVsKhzpEhuSPBr4YU0gEg0t9e6zwn+2LLo2Wfza
 hf8men2vW/WNL3YTLzQqU+hXfm7MCyBeVgPuskxSHU7YcnQiTxyiZnWjHV84nsTBNelJqJ6eFZl
 J9hjfSUzmWZuw38j8K1lO/vaEFHH0nIQ7REgUCQv+XYqh/4q6G8ObQdNSLHlv+l7/YXoKBlabK6
 BwJAQkuTjppcJnvPARx2O6MVk75vkb4ecydEFK0o3n1FyshSLByGXlVJ63mG4sN2KuSmSjCWhAA
 4q3Dt/vDp9WgvqBatk/HhmdHZj9sLJY6qmPO8pWdpMiKgWAYRWC+71d6G5+TDOamX9HoCQkd2Q8
 zEo9uTh16+rEbS+lMWoRvCNBx96FTewa1JRQ4RsUzBldeQhBm4A3mcQxF76nx0eKkR8anRZVUTs
 wEIp8EpzUccYxGQ==
X-Developer-Key: i=louis.chauvet@bootlin.com; a=openpgp;
 fpr=8B7104AE9A272D6693F527F2EC1883F55E0B40A5
X-GND-Sasl: louis.chauvet@bootlin.com

To simplify the memory managment this series replace all manual drm 
object managment by drm-managed one. This way the VKMS code don't have to 
manage it directly and the DRM core will handle the object destruction.

No functional changes are intended in this series. 

PATCH 1/5: Migrate connector managment to drmm
PATCH 2/5: Migrate encoder managment to drmm
PATCH 3/5: Migrate connector management to drm
PATCH 4/5: Introduce drmm_writeback helpers
PATCH 5/5: Migrate writeback connector management to drm

For the drmm_writeback helpers, you can find some discussions here [3].

[3]:https://lore.kernel.org/all/20240906-writeback-drmm-v1-1-01ede328182c@bootlin.com/

Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
Changes in v5:
- Rebased on drm-misc-next
- Link to v4: https://lore.kernel.org/r/20241010-google-vkms-managed-v4-0-ed04a62ad2e3@bootlin.com

Changes in v4:
- No changes for the managed part
- Add the patch to introduce drmm_writeback helpers
- Link to v3: https://lore.kernel.org/r/20240912-google-vkms-managed-v3-0-7708d6ad262d@bootlin.com

Changes in v3:
- As suggested by Maxime, split the managed and the dynamic allocation 
  parts in different series
- To reduce the diff in this series, extract the "remove crtc index" part, 
  see https://lore.kernel.org/all/20240906-vkms-remove-index-v1-1-3cfedd8ccb2f@bootlin.com/
- Link to v2: https://lore.kernel.org/r/20240827-google-vkms-managed-v2-0-f41104553aeb@bootlin.com

Changes in v2:
- Applied comments from José
- Extract the rename vkms_output -> vkms_crtc to avoid useless changes in 
  the last commit
- Extract the rename to_vkms_crtc_state to
  drm_crtc_state_to_vkms_crtc_state to avoid useless changes in last 
  commit
- Extract the drm_mode_crtc_set_gamma_size result check in its own commit
- Rebased on drm-misc/drm-misc-next
- Link to v1: https://lore.kernel.org/r/20240814-google-vkms-managed-v1-0-7ab8b8921103@bootlin.com

---
Louis Chauvet (5):
      drm/vkms: Switch to managed for connector
      drm/vkms: Switch to managed for encoder
      drm/vkms: Switch to managed for crtc
      drm: writeback: Introduce drm managed helpers
      drm/vkms: Switch to managed for writeback connector

 drivers/gpu/drm/drm_connector.c       |   4 +
 drivers/gpu/drm/drm_writeback.c       | 224 +++++++++++++++++++++++++++++-----
 drivers/gpu/drm/vkms/vkms_crtc.c      |  14 +++
 drivers/gpu/drm/vkms/vkms_drv.c       |   9 --
 drivers/gpu/drm/vkms/vkms_output.c    |  24 ++--
 drivers/gpu/drm/vkms/vkms_writeback.c |  13 +-
 include/drm/drm_writeback.h           |  10 ++
 7 files changed, 235 insertions(+), 63 deletions(-)
---
base-commit: 98efdd02e220fea84c1491012d7292749a71faeb
change-id: 20240521-google-vkms-managed-4aec99461a77

Best regards,
-- 
Louis Chauvet <louis.chauvet@bootlin.com>


