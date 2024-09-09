Return-Path: <linux-kernel+bounces-322073-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61550972398
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 22:25:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5FC971C21379
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 20:25:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74825189F33;
	Mon,  9 Sep 2024 20:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K09CiIvB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D63CF18C31
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 20:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725913528; cv=none; b=qUycEmOsd+x3xFlnT18JaU6D1xghajQ8fhqExZE+nQpRzZQRHv1yJd3C8rzhH2pc6GnMBQJxF6zqOKOaAtpaPx0AmyDgISdG4yv2LV8oAl2JGc0NlodVJfwObfxav2s16zHN+TInB+CTo8FKIttUZAFIBqr5JHF8ZpD6K2L5Fyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725913528; c=relaxed/simple;
	bh=IoliWmKGaEhCYdKBghauwV3MP5okR9y80Qjj6G0/EN4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=NvveNiD8w6Mvr/ayqFuDWL6J8nT5wnSnetdu8ql/Ys7BopXqB+Q38fL0cBOriHMsel/N7+gqAol2GloGWkwIGjLmn+KGUvBq5+TS/Y9u0saRLncZ9Dn2Lwk0WR99zMos5e6bDbaz/dDCENjODJWpUWcZY3hDtIH7H8v061ZPx20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K09CiIvB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3823C4CEC5;
	Mon,  9 Sep 2024 20:25:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725913528;
	bh=IoliWmKGaEhCYdKBghauwV3MP5okR9y80Qjj6G0/EN4=;
	h=From:To:Cc:Subject:Date:From;
	b=K09CiIvB+58xqQbvxhPjwyN28rZ465yImGKT8X4NdVANWyYJqvyRSBr9IsV2pT0Go
	 SZ9vF3vORB5MDSFuDFLhEUlVsiyn/fcfoz8htrQU0ZyH24J/3CtLsfJPHs/rd+jmli
	 g3nzju0myd42sdx92p3o+/Dd+lMaZXbXD955O6QIR0Sn4DBlRinkj/2Cm5LNF72fnO
	 EvDITU4nbPh7hKX9z17suVxMdhVty3sDmAVth3tO4cgIEZn8GvboWvWAkaT+qdG4pH
	 +BGf7LdobcHVw2s2Uwgd8OIUVg3HmNjRTNKYTDTX5rPC4HWJz99OqxzsDNHtz6/Sj7
	 /dX6WQrxEX5Kg==
From: Arnd Bergmann <arnd@kernel.org>
To: Lucas De Marchi <lucas.demarchi@intel.com>,
	=?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Anshuman Gupta <anshuman.gupta@intel.com>,
	Matthew Auld <matthew.auld@intel.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Riana Tauro <riana.tauro@intel.com>,
	Jonathan Cavitt <jonathan.cavitt@intel.com>,
	intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] drm/xe: fix build warning with CONFIG_PM=n
Date: Mon,  9 Sep 2024 20:25:08 +0000
Message-Id: <20240909202521.1018439-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

The 'runtime_status' field is an implementation detail of the
power management code, so a device driver should not normally
touch this:

drivers/gpu/drm/xe/xe_pm.c: In function 'xe_pm_suspending_or_resuming':
drivers/gpu/drm/xe/xe_pm.c:606:26: error: 'struct dev_pm_info' has no member named 'runtime_status'
  606 |         return dev->power.runtime_status == RPM_SUSPENDING ||
      |                          ^
drivers/gpu/drm/xe/xe_pm.c:607:27: error: 'struct dev_pm_info' has no member named 'runtime_status'
  607 |                 dev->power.runtime_status == RPM_RESUMING;
      |                           ^
drivers/gpu/drm/xe/xe_pm.c:608:1: error: control reaches end of non-void function [-Werror=return-type]

Add an #ifdef check to avoid the build regression.

Fixes: cb85e39dc5d1 ("drm/xe: Suppress missing outer rpm protection warning")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/gpu/drm/xe/xe_pm.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/xe/xe_pm.c b/drivers/gpu/drm/xe/xe_pm.c
index 9c59a30d7646..a3d1509066f7 100644
--- a/drivers/gpu/drm/xe/xe_pm.c
+++ b/drivers/gpu/drm/xe/xe_pm.c
@@ -601,10 +601,14 @@ bool xe_pm_runtime_get_if_in_use(struct xe_device *xe)
  */
 static bool xe_pm_suspending_or_resuming(struct xe_device *xe)
 {
+#ifdef CONFIG_PM
 	struct device *dev = xe->drm.dev;
 
 	return dev->power.runtime_status == RPM_SUSPENDING ||
 		dev->power.runtime_status == RPM_RESUMING;
+#else
+	return false;
+#endif
 }
 
 /**
-- 
2.39.2


