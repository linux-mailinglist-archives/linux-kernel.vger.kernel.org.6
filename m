Return-Path: <linux-kernel+bounces-447256-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16BF09F2FA5
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 12:40:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A0C516B44F
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 11:37:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37399204F7E;
	Mon, 16 Dec 2024 11:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="Q8X3uZbR"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28776204579
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 11:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734348894; cv=none; b=liD02+S8FvNqeOZrSnxlmzxcpk2jG33I1eZIoUNAu8GPJD1vZ6GhvLU11lUtbcK9XHaX+obnJS8OAhtSc0cp4j3cUzCTXU+XIh6da1CueX29CY2t1p38OQhLpM3z7ga5yrd57Dlfs88TgAvytGYLITVn6trnm+4WcjnOt43fFQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734348894; c=relaxed/simple;
	bh=JrDLH7p18msOukR2ZaEDeYMa++p2Hc53UfMP6H+bFkY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=mmdcLM/GS8FKgOtmsKOBGap9X3N8L7/5jcAHGhbpnWKMnnZvkutGTSuHaGNuL+6OpIGcuJkqXml7bgyeFbrb+QN7hf9nMZ886bLZKObG9M5dFyvsjM7vyM870htDb/MMz/t2JQWDTa+8KdTNpwuZmO2rIOM5IC/+qVnYIWwStxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=Q8X3uZbR; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1734348890;
	bh=JrDLH7p18msOukR2ZaEDeYMa++p2Hc53UfMP6H+bFkY=;
	h=From:Subject:Date:To:Cc:From;
	b=Q8X3uZbRg9FYXju4K4AV8wuHPp1Z5kkc+5QRYWmkiU6dDjuLFcyxH3J5phdv4cEQi
	 poL+yaMJ/CxlEBDJnXlmaHuGfS5xmL8dq31N/GpSrH8tOIkkQgnZQb5r8ULpK83MZP
	 Ovpz2ObDaOltbl6o0mLPn0CiRt4BxpFTbh1a1UP0=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Subject: [PATCH 0/5] drm: Constify 'struct bin_attribute'
Date: Mon, 16 Dec 2024 12:34:46 +0100
Message-Id: <20241216-sysfs-const-bin_attr-drm-v1-0-210f2b36b9bf@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAFYQYGcC/x3MQQqDMBBA0avIrB1Iglbbq4hINJN2Fo1lJogi3
 t3Q5Vv8f4KSMCm8qhOENlZeU4GtK1g+Pr0JORSDM66xzraoh0bFZU2aceY0+ZwFg3zxOceuMyb
 4vn9AyX9Ckff/ehiv6wbk5oKRagAAAA==
X-Change-ID: 20241215-sysfs-const-bin_attr-drm-9bf7700da886
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Qiang Yu <yuq825@gmail.com>, Jani Nikula <jani.nikula@linux.intel.com>, 
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, 
 Rodrigo Vivi <rodrigo.vivi@intel.com>, 
 Tvrtko Ursulin <tursulin@ursulin.net>, 
 Alex Deucher <alexander.deucher@amd.com>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Xinhui Pan <Xinhui.Pan@amd.com>, Harry Wentland <harry.wentland@amd.com>, 
 Leo Li <sunpeng.li@amd.com>, Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 lima@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, 
 amd-gfx@lists.freedesktop.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1734348889; l=1344;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=JrDLH7p18msOukR2ZaEDeYMa++p2Hc53UfMP6H+bFkY=;
 b=Xj9EbjZgGe/b+nVilZvAUNOPjobV5Pr3zvNLYMijU+Cqt7GNooFVhGe8zr7suSEuHgTAadNxv
 EqLRPoJWl7iAGW/qiD88SXGLPYXJObEWP0Ve31yZ+iBZIN5+6wrMarN
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

The sysfs core now allows instances of 'struct bin_attribute' to be
moved into read-only memory. Make use of that to protect them against
accidental or malicious modifications.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
Thomas Weißschuh (5):
      drm/sysfs: Constify 'struct bin_attribute'
      drm/lima: Constify 'struct bin_attribute'
      drm/i915: Constify 'struct bin_attribute'
      drm/amdgpu: Constify 'struct bin_attribute'
      drm/amd/display: Constify 'struct bin_attribute'

 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c             |  6 +++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c                | 14 +++++++-------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c                | 13 ++++++-------
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c |  8 ++++----
 drivers/gpu/drm/drm_sysfs.c                            | 10 +++++-----
 drivers/gpu/drm/i915/i915_gpu_error.c                  |  8 ++++----
 drivers/gpu/drm/i915/i915_sysfs.c                      | 12 ++++++------
 drivers/gpu/drm/lima/lima_drv.c                        |  8 ++++----
 8 files changed, 39 insertions(+), 40 deletions(-)
---
base-commit: 78d4f34e2115b517bcbfe7ec0d018bbbb6f9b0b8
change-id: 20241215-sysfs-const-bin_attr-drm-9bf7700da886

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>


