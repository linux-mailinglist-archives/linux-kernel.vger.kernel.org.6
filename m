Return-Path: <linux-kernel+bounces-544425-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E35F3A4E12F
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 15:38:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB5453B2D8E
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 14:30:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ACAF205AC1;
	Tue,  4 Mar 2025 14:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gU/b9v4A"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A2D72046BD
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 14:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741098553; cv=none; b=pudEmunz2zy948LDcEzVx59pYa8OfXC93at/kQiHB3N83K68B8wi2ZSvBfcXA55rO6vmD/4J6hS6Bc84TFH9fIeywlHL5isfroqpRmVh95hPW9sif/DB1pJ5tZsULTuAivNyaebnj9r74trmiCDYi8jieduoWUfiNcwQLZ612F4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741098553; c=relaxed/simple;
	bh=khdG65bPlGvNQL4Lss2vc1W5hJeqULPsPGO4kSfUOOE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bkRHuNLJ9A9w6QPVmt+aok9jiWGC6ReE6IFn/X5N5+hdpUuSBTnR+URkvB73Sfzn6OuJRgzZ/nVQ5s6+DT6x3bfJ94Ot3MOMRLQGuX8xKDdFPB8UudjMBROpP+VoULYjtJDzW/8ysd5kt9/h6ujmPKo71nsuTtVKC96UB8k68YQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gU/b9v4A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B88EC4CEE5;
	Tue,  4 Mar 2025 14:29:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741098553;
	bh=khdG65bPlGvNQL4Lss2vc1W5hJeqULPsPGO4kSfUOOE=;
	h=From:To:Cc:Subject:Date:From;
	b=gU/b9v4AVvPUXBnn+BB6c9u5mTLIBgVJoceQLI2ZCuGQdIjqsF4IsNKGyDbPsR/Xu
	 YrPfLzGU24s7tVZ+/dF7z3Lbg1ph+6zA1C7yCsJq/giRpTO/kWtfVa2xIy3ZQb91sO
	 qRxHyYlYO/bvOlTK1Q11NlbIY9Gx9RfVsznsnqzfOVftiTuUWszFI1b4OxWpFm7M8y
	 xNeQtb3+tVdcovbE1Fghmuduid5JsUnpCScStMN94RAkm7NqnFkKre6mefEJ6lyTxt
	 uz8qK0CHewetnlN1CEV0PNj2204xS7CjBjBuOhE4Qt+tTUVOyezJbU3xZk7jCQREgo
	 rEYWCh1E30+vQ==
From: Arnd Bergmann <arnd@kernel.org>
To: Neil Armstrong <neil.armstrong@linaro.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Danila Tikhonov <danila@jiaxyga.com>,
	Eugene Lepshy <fekz115@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Jessica Zhang <quic_jesszhan@quicinc.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	David Wronek <david@mainlining.org>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] drm/panel: fix Visionox RM692E5 dependencies
Date: Tue,  4 Mar 2025 15:29:02 +0100
Message-Id: <20250304142907.732196-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

The newly added driver uses the DSC helpers, so the corresponding
Kconfig option must be enabled:

ERROR: modpost: "drm_dsc_pps_payload_pack" [drivers/gpu/drm/panel/panel-visionox-rm692e5.ko] undefined!

Fixes: 7cb3274341bf ("drm/panel: Add Visionox RM692E5 panel driver")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/gpu/drm/panel/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/panel/Kconfig b/drivers/gpu/drm/panel/Kconfig
index 5927806cb4a9..e059b06e0239 100644
--- a/drivers/gpu/drm/panel/Kconfig
+++ b/drivers/gpu/drm/panel/Kconfig
@@ -1020,6 +1020,8 @@ config DRM_PANEL_VISIONOX_RM692E5
 	depends on OF
 	depends on DRM_MIPI_DSI
 	depends on BACKLIGHT_CLASS_DEVICE
+	select DRM_DISPLAY_DSC_HELPER
+	select DRM_DISPLAY_HELPER
 	help
 	  Say Y here if you want to enable support for Visionox RM692E5 amoled
 	  display panels, such as the one found in the Nothing Phone (1)
-- 
2.39.5


