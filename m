Return-Path: <linux-kernel+bounces-260864-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 925E693AF9D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 12:11:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A7B4B1C2122D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 10:11:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3720C155741;
	Wed, 24 Jul 2024 10:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="hkU6BPqR"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAB171448DC
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 10:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721815908; cv=none; b=f2ncq7uY317ECZIKSAPrzX2iEimz40lYaP9DtodPbqnlAFCx6AICJQH3B/rfxOffRKUmG3C7Um0bwNTcmz20z3NQ5Qm/cfMkrPdK7yFPa5OUeWkS7WUZl7/0GNOLO2a7LSa9gyMSbegOJ7v1MjQWTCbfdVMFfkIvVPAdwnsbB+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721815908; c=relaxed/simple;
	bh=y5eg6oSlMBrIqzM60aEB9SQlYliam1C5elKMQH5ygwc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aX/P7xizCX9KizoEvIbvAbDr71O80AsytbdmqAmbmA3H7Wm55iufk6X2yxWBQ86NOUToQ18hiad5iHkVmBVdhwYjzPPwDzSR/dkdo9szeWWHsNe1B9SPbRhBhORoYd/7mMHKN5BMbsALsLXDdhqNc/nYNcZrtX+0Me49SWIf1kI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=hkU6BPqR; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1721815905;
	bh=y5eg6oSlMBrIqzM60aEB9SQlYliam1C5elKMQH5ygwc=;
	h=From:To:Cc:Subject:Date:From;
	b=hkU6BPqRXDOW/mdtaWAspm9aky7N21a7233n8yF9h1F819UjR87WSsYCLc8UIGXxq
	 zkdgnU2TMZp89nDY6LLuOBuL94n096wKXKY0PJfMzd9WyGgr/y1NbHkEA4OSdR7V4G
	 19MfhuBgQ43hYao5h04DldqhgpP98DSHtBST41ljA+zGF488cZ+Q5Euvgvt8+hz6CL
	 A/NLzf9o1nepLAkEm4yQa9NJ1L2dsEP9sZ3R8NkRDY/dXvPWJohmwlzXRZKT+B8Dl2
	 ORam3HCUH1z+UJnYPh77pghZQWUxAC+4Z2VW8RTnKY/67/podB2m7kxTcYgJj0RGd3
	 5HqOz1Q2WmrOw==
Received: from localhost.localdomain (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: vignesh)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 5B36B37820DE;
	Wed, 24 Jul 2024 10:11:42 +0000 (UTC)
From: Vignesh Raman <vignesh.raman@collabora.com>
To: dri-devel@lists.freedesktop.org
Cc: daniels@collabora.com,
	helen.koike@collabora.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	guilherme.gallo@collabora.com,
	sergi.blanch.torne@collabora.com,
	deborah.brouwer@collabora.com,
	robdclark@gmail.com,
	linux-mediatek@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-amlogic@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v8 0/5] drm/ci: Add support for GPU and display testing
Date: Wed, 24 Jul 2024 15:40:03 +0530
Message-ID: <20240724101015.523535-1-vignesh.raman@collabora.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some ARM SOCs have a separate display controller and GPU, each with
different drivers. For mediatek mt8173, the GPU driver is powervr,
and the display driver is mediatek. In the case of mediatek mt8183,
the GPU driver is panfrost, and the display driver is mediatek.
With rockchip rk3288/rk3399, the GPU driver is panfrost, while the
display driver is rockchip. For amlogic meson G12B (A311D) SOC, the
GPU driver is panfrost, and the display driver is meson.

IGT tests run various tests with different xfails and can test both
GPU devices and KMS/display devices. Currently, in drm-ci for MediaTek,
Rockchip, and Amlogic Meson platforms, only the GPU driver is tested.
This leads to incomplete coverage since the display is never tested on
these platforms. This commit series adds support in drm-ci to run tests
for both GPU and display drivers for MediaTek mt8173/mt8183, Rockchip
rk3288/rk3399, and Amlogic Meson G12B (A311D) platforms.

Update the expectations file and skip driver-specific tests.

Working pipeline link,
https://gitlab.freedesktop.org/vigneshraman/linux/-/pipelines/1231543

Vignesh Raman (5):
  drm/ci: arm64.config: Enable CONFIG_DRM_ANALOGIX_ANX7625
  drm/ci: mediatek: add tests for mediatek display driver
  drm/ci: mediatek: add tests for powervr gpu driver
  drm/ci: meson: add tests for meson display driver
  drm/ci: rockchip: add tests for rockchip display driver

 MAINTAINERS                                   |   2 +
 drivers/gpu/drm/ci/arm64.config               |   1 +
 drivers/gpu/drm/ci/gitlab-ci.yml              |   3 +-
 drivers/gpu/drm/ci/igt_runner.sh              |  10 --
 drivers/gpu/drm/ci/test.yml                   | 123 ++++++++++++++----
 .../drm/ci/xfails/mediatek-mt8183-fails.txt   |  27 +++-
 .../drm/ci/xfails/mediatek-mt8183-flakes.txt  |  13 ++
 .../drm/ci/xfails/mediatek-mt8183-skips.txt   |   4 +-
 .../gpu/drm/ci/xfails/meson-g12b-fails.txt    |  18 ++-
 .../gpu/drm/ci/xfails/meson-g12b-skips.txt    |   4 +-
 .../gpu/drm/ci/xfails/panfrost-g12b-fails.txt |   8 ++
 .../gpu/drm/ci/xfails/panfrost-g12b-skips.txt |  18 +++
 .../drm/ci/xfails/panfrost-mt8183-fails.txt   |  11 ++
 .../drm/ci/xfails/panfrost-mt8183-skips.txt   |  18 +++
 .../drm/ci/xfails/panfrost-rk3288-fails.txt   |   8 ++
 .../drm/ci/xfails/panfrost-rk3288-skips.txt   |  71 ++++++++++
 .../drm/ci/xfails/panfrost-rk3399-fails.txt   |   8 ++
 .../drm/ci/xfails/panfrost-rk3399-flakes.txt  |   6 +
 .../drm/ci/xfails/panfrost-rk3399-skips.txt   |  24 ++++
 .../drm/ci/xfails/rockchip-rk3288-fails.txt   |  21 ++-
 .../drm/ci/xfails/rockchip-rk3288-flakes.txt  |   6 +
 .../drm/ci/xfails/rockchip-rk3288-skips.txt   |  54 +-------
 .../drm/ci/xfails/rockchip-rk3399-fails.txt   |  90 ++++++++++++-
 .../drm/ci/xfails/rockchip-rk3399-flakes.txt  |  50 ++++++-
 .../drm/ci/xfails/rockchip-rk3399-skips.txt   |   7 +-
 25 files changed, 478 insertions(+), 127 deletions(-)
 create mode 100644 drivers/gpu/drm/ci/xfails/mediatek-mt8183-flakes.txt
 create mode 100644 drivers/gpu/drm/ci/xfails/panfrost-g12b-fails.txt
 create mode 100644 drivers/gpu/drm/ci/xfails/panfrost-g12b-skips.txt
 create mode 100644 drivers/gpu/drm/ci/xfails/panfrost-mt8183-fails.txt
 create mode 100644 drivers/gpu/drm/ci/xfails/panfrost-mt8183-skips.txt
 create mode 100644 drivers/gpu/drm/ci/xfails/panfrost-rk3288-fails.txt
 create mode 100644 drivers/gpu/drm/ci/xfails/panfrost-rk3288-skips.txt
 create mode 100644 drivers/gpu/drm/ci/xfails/panfrost-rk3399-fails.txt
 create mode 100644 drivers/gpu/drm/ci/xfails/panfrost-rk3399-flakes.txt
 create mode 100644 drivers/gpu/drm/ci/xfails/panfrost-rk3399-skips.txt
 create mode 100644 drivers/gpu/drm/ci/xfails/rockchip-rk3288-flakes.txt

-- 
2.43.0


