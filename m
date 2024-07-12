Return-Path: <linux-kernel+bounces-250432-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A83E492F7C8
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 11:17:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DACC51C230A1
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 09:17:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F8C015539A;
	Fri, 12 Jul 2024 09:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="hI2q64PQ"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05BAD1474D8
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 09:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720775846; cv=none; b=jAbCqO5HN3NWzBBZETU+xTUWIcdYwINxItb0n/y6gt6Et/M9Nl7hx+UJfxEKQea0tkG+YGg3QrWnbTxhcBkt/rfr7HzGngC5Lji0bZeXK2jmPERbPHWIDFpnpNA0dpoATjUYRhj+56oFbxZrKs0GZupmBciD6hqZ26hXqMOCTkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720775846; c=relaxed/simple;
	bh=WH1SUOebBJNnQPD/uiBVf/l9MIUB8lghzx3M3c7b0Go=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OBzX1fhUHaDAj0cgSCy8mMMcZRIlcEdfMTvy6ekjWfL72X0Fb2OJPGxu0zsXfmcSf+TewCtSrpzd3N3KjbKCxNsiLadw97jo1jjS1i1d6OUkcoBeT1pBjjv0uhAnipkSsCFPjPwakRNfn8c8kU4u6moX8n14jGrEqafOMIi1O0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=hI2q64PQ; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1720775843;
	bh=WH1SUOebBJNnQPD/uiBVf/l9MIUB8lghzx3M3c7b0Go=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hI2q64PQp1b+RChVxHJcmbmWXNFMYOAQ9PjKRQ22VTCmcp17hv6bnNswJkXGgQ08o
	 90oq5HMrQi5B3c78+cmiFkC9cGt0zK8cua8ohkxH8lhdMTKRyUgCM5odq1+eI6rZQ3
	 qlBcKZswDYkDvQ7p3CnXFQuIhiEN0bPChNzmJqlDxwtnWzPYVGTG5zo+ilsQgXJ5Jn
	 PZ1IVNMFq+VYDCTkLFqaCQ6R8ko9j9ZTD7Ro8tcbstEfd8/ZNMTlYVGtk4W0z80H50
	 9EbS9lrodJ/2PjiuJtYGExGBxl7OVBHKekeGU8OgPDdoy89xUtVeRxHWrJuIHKGY+U
	 yX8UXvVf7CVdg==
Received: from localhost.localdomain (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: vignesh)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 6BDB53782211;
	Fri, 12 Jul 2024 09:17:20 +0000 (UTC)
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
Subject: [PATCH v7 3/5] drm/ci: mediatek: add tests for powervr gpu driver
Date: Fri, 12 Jul 2024 14:45:47 +0530
Message-Id: <20240712091549.56635-4-vignesh.raman@collabora.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240712091549.56635-1-vignesh.raman@collabora.com>
References: <20240712091549.56635-1-vignesh.raman@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For mediatek mt8173, the display driver is mediatek, while the
gpu driver is powervr. Currently, in drm-ci for mt8173, only the
display driver is tested. Add support in drm-ci to test powervr
driver for mt8173. Powervr driver was merged in linux kernel,
but there's no mediatek support yet. So disable the powervr:mt8173
job which uses powervr driver.

Also update the MAINTAINERS file to include xfails for powervr driver.

Signed-off-by: Vignesh Raman <vignesh.raman@collabora.com>
---

v6:
  - New patch in the series. Split powervr changes into a new commit.

v7:
  - No changes. 

---
 MAINTAINERS                      |  1 +
 drivers/gpu/drm/ci/gitlab-ci.yml |  1 +
 drivers/gpu/drm/ci/test.yml      | 14 ++++++++++++++
 3 files changed, 16 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index f3783f2269ff..05f72eaf5267 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10778,6 +10778,7 @@ T:	git https://gitlab.freedesktop.org/drm/misc/kernel.git
 F:	Documentation/devicetree/bindings/gpu/img,powervr-rogue.yaml
 F:	Documentation/devicetree/bindings/gpu/img,powervr-sgx.yaml
 F:	Documentation/gpu/imagination/
+F:	drivers/gpu/drm/ci/xfails/powervr*
 F:	drivers/gpu/drm/imagination/
 F:	include/uapi/drm/pvr_drm.h
 
diff --git a/drivers/gpu/drm/ci/gitlab-ci.yml b/drivers/gpu/drm/ci/gitlab-ci.yml
index 9d800f629f08..ca7f873bc2d4 100644
--- a/drivers/gpu/drm/ci/gitlab-ci.yml
+++ b/drivers/gpu/drm/ci/gitlab-ci.yml
@@ -122,6 +122,7 @@ stages:
   - meson
   - msm
   - panfrost
+  - powervr
   - rockchip
   - software-driver
 
diff --git a/drivers/gpu/drm/ci/test.yml b/drivers/gpu/drm/ci/test.yml
index 219eca5ef24c..86875fb96eb5 100644
--- a/drivers/gpu/drm/ci/test.yml
+++ b/drivers/gpu/drm/ci/test.yml
@@ -294,6 +294,11 @@ amdgpu:stoney:
   variables:
     DRIVER_NAME: mediatek
 
+.powervr-gpu:
+  stage: powervr
+  variables:
+    DRIVER_NAME: powervr
+
 .panfrost-gpu:
   stage: panfrost
   variables:
@@ -322,6 +327,15 @@ mediatek:mt8173:
     - .mt8173
     - .mediatek-display
 
+powervr:mt8173:
+  extends:
+    - .mt8173
+    - .powervr-gpu
+  rules:
+    # TODO: powervr driver was merged in linux kernel, but there's no mediatek support yet
+    # Remove the rule once mediatek support is added for powervr
+    - when: never
+
 mediatek:mt8183:
   extends:
     - .mt8183
-- 
2.40.1


