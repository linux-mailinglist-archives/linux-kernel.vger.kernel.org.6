Return-Path: <linux-kernel+bounces-385392-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E58CF9B369B
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 17:35:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1A07285FCF
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 16:35:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23A311DE4D5;
	Mon, 28 Oct 2024 16:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h5H9CyHY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BB5A1DEFCF;
	Mon, 28 Oct 2024 16:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730133334; cv=none; b=SUVE4t8ObssrZQDcoJhexxe1EM7jUDNywI9UlCHjcCbZ5Z4SIosts7952RS9FcI1/gFr/qn5qFC94TOnYlN1jkcwYlrUbH8/sHWSHknck2AweIc8efTX/vGtN3xhfYuwg3AKiapbCzDjP54pq2YLi4zqsoVjHZ7pFScztRLdNAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730133334; c=relaxed/simple;
	bh=B+pJhWPiLhnporLquPyi2au3DHThLhnQTOKU50phhKA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=C6hn+ySmkHTa7y3TvYHYgAjM/9RFL4LzoC8ClO7qjiS3tNdPDfJcLtg4KNCxlBzXw8kvPftb1dayw1BcYJ2rJioALoFX02sjYdMVDJ36eRKzMqNxbWZauJRs+lrwx2GBlX7QblzMOEpKMAcm/ZVDkZdjjib0OYXfFhxsJjZ9z8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h5H9CyHY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4354AC4CEC3;
	Mon, 28 Oct 2024 16:35:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730133333;
	bh=B+pJhWPiLhnporLquPyi2au3DHThLhnQTOKU50phhKA=;
	h=From:To:Cc:Subject:Date:From;
	b=h5H9CyHY+7U9M417dT5UQgoE0GhbLmXiFBB0fYmDKClDxIWeb1sYo0spRU3mLXYPF
	 QqrkVeBxEV7DE0/CiFRJBHzeObzzzIJ3KpGZJaw3QKOa1WJkDVa8Q7VzaWbBDNrFcw
	 RQorsCq5K6NhdWFIbwdgGgmmZ6GSqyaUfACbMjfH9vglAkKUrHeRw1uTsoNirn7LF1
	 sJk9KoWtA2H2n5/60Z/zVxNtuwh+KJE0Z78kRxZyXHc8MkFk7aTBp6VYBUB86kYJAL
	 QCLJlx+8qySvwYe2PjVB4NBv32H3y4wCNADIEzrbORnqWGciwBZ5OxO1THfQpb85go
	 784NbkD7g4y9A==
From: Arnd Bergmann <arnd@kernel.org>
To: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	=?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Lucas Stach <l.stach@pengutronix.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Javier Martinez Canillas <javierm@redhat.com>,
	dri-devel@lists.freedesktop.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] drm/imx/dcss: include drm/drm_bridge.h header
Date: Mon, 28 Oct 2024 16:35:07 +0000
Message-Id: <20241028163527.2425783-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

Compile-testing random configurations leads to failures in
dcss-kms.c from a missing declaration:

drivers/gpu/drm/imx/dcss/dcss-kms.c:95:8: error: use of undeclared identifier 'drm_bridge_attach'
   95 |         ret = drm_bridge_attach(encoder, bridge, NULL,
      |               ^
drivers/gpu/drm/imx/dcss/dcss-kms.c:96:5: error: use of undeclared identifier 'DRM_BRIDGE_ATTACH_NO_CONNECTOR'
   96 |                                 DRM_BRIDGE_ATTACH_NO_CONNECTOR);
      |                                 ^

Include the header directly.

Fixes: 004555a18d57 ("drm/imx/dcss: Allow build with COMPILE_TEST=y")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/gpu/drm/imx/dcss/dcss-kms.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/imx/dcss/dcss-kms.c b/drivers/gpu/drm/imx/dcss/dcss-kms.c
index 3ec721afc30c..63a335c62296 100644
--- a/drivers/gpu/drm/imx/dcss/dcss-kms.c
+++ b/drivers/gpu/drm/imx/dcss/dcss-kms.c
@@ -5,6 +5,7 @@
 
 #include <drm/drm_atomic.h>
 #include <drm/drm_atomic_helper.h>
+#include <drm/drm_bridge.h>
 #include <drm/drm_bridge_connector.h>
 #include <drm/drm_client_setup.h>
 #include <drm/drm_drv.h>
-- 
2.39.5


