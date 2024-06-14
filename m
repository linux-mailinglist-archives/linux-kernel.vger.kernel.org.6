Return-Path: <linux-kernel+bounces-215156-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E6A17908EE4
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 17:36:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BF53281A1D
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 15:36:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A91BA16F0D5;
	Fri, 14 Jun 2024 15:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="oCqhgpcJ"
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B1E7154457
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 15:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718379365; cv=none; b=RB0jbnxUv7X9DMNEgHW6/7iHmraAGMVz3zpJ8anTpYkgQEXrI+3wSy9WTWtYxSljf0jfncHECemasJEruCngCR3jP2vEVpcoG01cfieddvqcU24p8B4JGF6RiUCE6VcSfG7377xuRAdI07bR+3fUOwoaE6LSzBdZwQjaDssoXZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718379365; c=relaxed/simple;
	bh=VwRqPOS8y46VqB8sUNGMNMY2Lqxkut+KtxqK2F0ldMM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=HK1fbbz1enb8MW4ABJzsdV7TrfhjhSA1u00aokQRiomUmR15dNy1LlGAvIhdh4Np087TRf+vOlQb8dZkH0+G57Rv4b+s3XZqQpAF0hOSgqXb+50hSTRsaM+slsDVSefKMNYMPpRLJ5yGY1o0GMzPO8vWGqRwe74Ed89h+SX5Cpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=oCqhgpcJ; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
	Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=LmgvFS549yo/YJvBvlKRwZA43KduQg2X1Xw5E+iXCqk=; b=oCqhgpcJY25QyoVWX+uB03kyG2
	/ZKPtyUgAi+WRtJpJbSAk0Z8S+juSoNehw0j1cMQHQusZN4oWiE9eVpoM3ptOxGy3PQHvW6imEZVk
	ZXFRl9I8/HCKYWPbhWggebBI1GbsZU42PN4F53sCx6P5no9VliYDpbY0CiKuOrP/c2dtAHW1NhJb0
	qGqbxOJ2GbJX3WrWAyLSgmy0/Mj63yzynYCzaRD9QvrXiOP+mYzrHbgcc9O80zRAn7y4oWaUwtgQK
	KzwWD4d4fJ1SMm/VdD7KaTvbe3nWyRimrT60THmDJWDh2XjbxL6ZhkjG7hqp3poSga0GdOaUFRz+3
	kE6URfiA==;
Received: from [179.118.191.115] (helo=localhost.localdomain)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1sI8xu-003B8v-DG; Fri, 14 Jun 2024 17:35:46 +0200
From: =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>
To: dri-devel@lists.freedesktop.org,
	amd-gfx@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	nouveau@lists.freedesktop.org,
	intel-gfx@lists.freedesktop.org
Cc: kernel-dev@igalia.com,
	Melissa Wen <mwen@igalia.com>,
	alexander.deucher@amd.com,
	christian.koenig@amd.com,
	Simon Ser <contact@emersion.fr>,
	Pekka Paalanen <ppaalanen@gmail.com>,
	daniel@ffwll.ch,
	Daniel Stone <daniel@fooishbar.org>,
	=?UTF-8?q?=27Marek=20Ol=C5=A1=C3=A1k=27?= <maraeo@gmail.com>,
	Dave Airlie <airlied@gmail.com>,
	ville.syrjala@linux.intel.com,
	Xaver Hugl <xaver.hugl@gmail.com>,
	Joshua Ashton <joshua@froggi.es>,
	=?UTF-8?q?Michel=20D=C3=A4nzer?= <michel.daenzer@mailbox.org>,
	Sam Ravnborg <sam@ravnborg.org>,
	Boris Brezillon <bbrezillon@kernel.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Karol Herbst <kherbst@redhat.com>,
	Lyude Paul <lyude@redhat.com>,
	=?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>
Subject: [PATCH v6 0/8] drm: Support per-plane async flip configuration
Date: Fri, 14 Jun 2024 12:35:27 -0300
Message-ID: <20240614153535.351689-1-andrealmeid@igalia.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

AMD hardware can do async flips with overlay planes, but currently there's no
easy way to enable that in DRM. To solve that, this patchset creates a new
drm_plane field, bool async_flip, that allows drivers to choose which plane can
or cannot do async flips. This is latter used on drm_atomic_set_property when
users want to do async flips.

Patch 1 allows async commits with IN_FENCE_ID in any driver.

Patches 2 to 7 have no function change. As per current code, every driver that
allows async page flips using the atomic API, allows doing it only in the
primary plane. Those patches then enable it for every driver.

Patch 8 finally enables async flip on overlay planes for amdgpu.

Changes from v5:
- Instead of enabling plane->async_flip in the common code, move it to driver
code.
- Enable primary plane async flip on every driver
https://lore.kernel.org/dri-devel/20240612193713.167448-1-andrealmeid@igalia.com/

André Almeida (8):
  drm/atomic: Allow userspace to use explicit sync with atomic async
    flips
  drm: Support per-plane async flip configuration
  drm/amdgpu: Enable async flips on the primary plane
  drm: atmel-hlcdc: Enable async flips on the primary plane
  drm/i915: Enable async flips on the primary plane
  drm/nouveau: Enable async flips on the primary plane
  drm/vc4: Enable async flips on the primary plane
  drm/amdgpu: Make it possible to async flip overlay planes

 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c | 2 ++
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c         | 3 +++
 drivers/gpu/drm/drm_atomic_uapi.c                       | 8 +++++---
 drivers/gpu/drm/i915/display/i9xx_plane.c               | 3 +++
 drivers/gpu/drm/nouveau/dispnv04/crtc.c                 | 4 ++++
 drivers/gpu/drm/nouveau/dispnv50/wndw.c                 | 4 ++++
 drivers/gpu/drm/vc4/vc4_plane.c                         | 4 +++-
 include/drm/drm_plane.h                                 | 5 +++++
 8 files changed, 29 insertions(+), 4 deletions(-)

-- 
2.45.2


