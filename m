Return-Path: <linux-kernel+bounces-250430-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A73392F7C5
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 11:17:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A52A2815D9
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 09:17:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F9AD14D71D;
	Fri, 12 Jul 2024 09:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="4NUpWcrO"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F850148841
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 09:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720775839; cv=none; b=kKnVR9KTKzqjIGtaQMuNFicbN7YN5PQZYaNjh+SbGgWgc/GdSz0mHQvHkUZNJF1uZcbMn3b5Ii6/FqFRKhYM2VWSHT6/ofDJOLDqZiwQw9KV6D5oD5pcjmohpJpNVtXd6Vco3U3mwPw/FSIl0p8hppPUktT08sfMiYoef9JdDAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720775839; c=relaxed/simple;
	bh=wFLcljlhEltmQSod5ZN/H9JvR5/jrjC4cd8jdXQmAVY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EJH6X9jvuYQGGnTlhzVkAac7Y2OsXvyIvGf+1pZBaGDI49x7rv0pAO93Oc6Y+MfpFBB7bh0WX/v5hmqK4V2CcBkbv96WdJtcBU4+S9fhUtcZf1ezf3F3WVEVeeBerxv6/aTUk1NofnMVjQ4XuXpBYwIlTkrE+Rxl6XyO/eEv0VA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=4NUpWcrO; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1720775836;
	bh=wFLcljlhEltmQSod5ZN/H9JvR5/jrjC4cd8jdXQmAVY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=4NUpWcrOPyYjbEjqNr1E5QC4hFir4s1GF2bJmq4hBt7c8NPyfSdk5dHZpDDYolXLF
	 mOx96WWg/+2GmQwZzZSEroyIVwUAi+CVUeSr8mnPnocfsUzZxQDZRAdXGYYGFd15eR
	 LYgCKegF4uvKiJtZTIVHF4nmy76RTd39NCUsF7XWuOuT5O/vemBb0cmeQzc3b79wgy
	 vVNOfPe3wwuJctGGssqxKm1aV7MlVlzqWuoHVPkztOgf90hQWcmpVLq+KXpKOTu7NB
	 x7Z66UQDYi+kC4taVha3rN/gIdoC9Vxt69mVts4aa3RnZxBNXyHbM4ndfmVpxk/PzF
	 +mY3Zx4MrAAew==
Received: from localhost.localdomain (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: vignesh)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id C785B3782211;
	Fri, 12 Jul 2024 09:17:13 +0000 (UTC)
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
Subject: [PATCH v7 1/5] drm/ci: arm64.config: Enable CONFIG_DRM_ANALOGIX_ANX7625
Date: Fri, 12 Jul 2024 14:45:45 +0530
Message-Id: <20240712091549.56635-2-vignesh.raman@collabora.com>
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

Enable CONFIG_DRM_ANALOGIX_ANX7625 in the arm64 defconfig to get
display driver probed on the mt8183-kukui-jacuzzi-juniper machine.

arch/arm64/configs/defconfig has CONFIG_DRM_ANALOGIX_ANX7625=m,
but drm-ci don't have initrd with modules, so add
CONFIG_DRM_ANALOGIX_ANX7625=y in CI arm64 config.

Acked-by: Helen Koike <helen.koike@collabora.com>
Signed-off-by: Vignesh Raman <vignesh.raman@collabora.com>
---

v2:
  - No changes

v3:
  - No changes

v4:
  - No changes

v5:
  - No changes

v6:
  - No changes

v7:
  - No changes

---
 drivers/gpu/drm/ci/arm64.config | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/ci/arm64.config b/drivers/gpu/drm/ci/arm64.config
index 4140303d6260..66e70ced796f 100644
--- a/drivers/gpu/drm/ci/arm64.config
+++ b/drivers/gpu/drm/ci/arm64.config
@@ -187,6 +187,7 @@ CONFIG_MTK_DEVAPC=y
 CONFIG_PWM_MTK_DISP=y
 CONFIG_MTK_CMDQ=y
 CONFIG_REGULATOR_DA9211=y
+CONFIG_DRM_ANALOGIX_ANX7625=y
 
 # For nouveau.  Note that DRM must be a module so that it's loaded after NFS is up to provide the firmware.
 CONFIG_ARCH_TEGRA=y
-- 
2.40.1


