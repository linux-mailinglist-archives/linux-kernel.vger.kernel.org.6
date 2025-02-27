Return-Path: <linux-kernel+bounces-536379-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 88E05A47EE5
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 14:21:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B56CE3A4FB4
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 13:20:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9440322F38C;
	Thu, 27 Feb 2025 13:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QpjlQW8z"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0044422171A
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 13:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740662442; cv=none; b=IFyQQCpuWdAnuAIFOSYExuSA8Lde0CyX98xlTvuZ51n3qQY52hpXJbxZJXrzChs9V/DCcQil8Ralo8qMXPdr4KuQ/pfaPf7Hz/QVzKQHKm8DQvOs/d3Sy7aBXZAk1B1H/NnNf33bQud6ezwE/HK5sTxGdsrbedDIe1A6Fch12tE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740662442; c=relaxed/simple;
	bh=FLYX4MtQxNdE09SlMrP22m+WXbicdAzLZnnz94YMMU8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gdnsJhy1nrTEw25gfHWsg6kMsYZMoLrn1EDxO920CP9oKBPr3/NAiyWENR/khDEjVcbGxSuNnGmOMXAC1XaTtFSS/7CHloBLzje3AfrZ+I/QsiCfbfKoxU73ZC8OnxMPk/LNswq9QyzF7gz/HY8qCAUyB2qKuSF0wzzzaGtL968=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QpjlQW8z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DAE0C4CEDD;
	Thu, 27 Feb 2025 13:20:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740662441;
	bh=FLYX4MtQxNdE09SlMrP22m+WXbicdAzLZnnz94YMMU8=;
	h=From:To:Cc:Subject:Date:From;
	b=QpjlQW8zNpmJ08WB9JTBJqlF36PognoNnSxjJT4tKa/l4ZaFM4w5dpNn+VhYJjU5s
	 OEotBr056p3g1inqlXhP9bDQpWQ9686G5QktZbrtWl/m0Fi2c3OGLt1gHEUmuqqzyW
	 7M2nS6lvIxRpR6Kus5NMH92N8IDOYpiX+fF00t3gvEn7Bx+0k83cm5qeRokiID3461
	 3EBuBvfN/aEO8C3a/C10HFjRnfka4BhCcUdtH1r4OnDqVeLg1nXJ9Go8txXaqCZS5B
	 MMuls9Q5smhRdLfS+6lbTeGPVAiA9jHTeu/9uFKMMmDSVqQqNxUmTuG6PHSVYO70or
	 rE82cHC1EXnPQ==
From: Arnd Bergmann <arnd@kernel.org>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Vishal Sagar <vishal.sagar@amd.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Jani Nikula <jani.nikula@intel.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] drm: xlnx: zynqmp_dpsub: fix Kconfig dependencies for ASoC
Date: Thu, 27 Feb 2025 14:20:32 +0100
Message-Id: <20250227132036.1136600-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

The new audio code fails to build when sounds support is in a loadable
module but the GPU driver is built-in:

x86_64-linux-ld: zynqmp_dp_audio.c:(.text+0x6a8): undefined reference to `devm_snd_soc_register_card'
x86_64-linux-ld: drivers/gpu/drm/xlnx/zynqmp_dp_audio.o:(.rodata+0x1bc): undefined reference to `snd_soc_info_volsw'
x86_64-linux-ld: drivers/gpu/drm/xlnx/zynqmp_dp_audio.o:(.rodata+0x1f0): undefined reference to `snd_soc_get_volsw'
x86_64-linux-ld: drivers/gpu/drm/xlnx/zynqmp_dp_audio.o:(.rodata+0x1f4): undefined reference to `snd_soc_put_volsw'

Change the Kconfig dependency to disallow the sound support in this
configuration.

Fixes: 3ec5c1579305 ("drm: xlnx: zynqmp_dpsub: Add DP audio support")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/gpu/drm/xlnx/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/xlnx/Kconfig b/drivers/gpu/drm/xlnx/Kconfig
index dbecca9bdd54..cfabf5e2a0bb 100644
--- a/drivers/gpu/drm/xlnx/Kconfig
+++ b/drivers/gpu/drm/xlnx/Kconfig
@@ -22,6 +22,7 @@ config DRM_ZYNQMP_DPSUB_AUDIO
 	bool "ZynqMP DisplayPort Audio Support"
 	depends on DRM_ZYNQMP_DPSUB
 	depends on SND && SND_SOC
+	depends on SND_SOC=y || DRM_ZYNQMP_DPSUB=m
 	select SND_SOC_GENERIC_DMAENGINE_PCM
 	help
 	  Choose this option to enable DisplayPort audio support in the ZynqMP
-- 
2.39.5


