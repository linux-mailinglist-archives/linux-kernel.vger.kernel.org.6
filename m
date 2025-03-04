Return-Path: <linux-kernel+bounces-544418-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 759B6A4E0FC
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 15:33:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BBFCB188A709
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 14:29:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4057B207A16;
	Tue,  4 Mar 2025 14:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EjG16xKn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D961207A05
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 14:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741098436; cv=none; b=OLRYZnvTWQmD+JlukGGFy4kfX5x24Y71g7V2Gn/VmxiEn/9Ycqv9ifMpqvJROdqVCmfjZI2SZGdg4g6IHp8cYFpFso4oXbHa+lvKDYMewxUflIBJ/vuYVzKBoHLTOW79OOFhkDzmNXH4RD4qz31eMLbk+XPx8eRkLfSW282TjHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741098436; c=relaxed/simple;
	bh=2Au5twRhQNpRl3N3lvaKrD+Ua/A/kyLQZmS2YDyTLdw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JCBUhtz7l3iPfHqo1lM3iFXdOcjD+eX+PL5fa8EqNnfTN8j+oT1Hcu4Db/FvExhQCVamx30BgGY+GS420IHqGlKsXnFV86VAD+FlS8QHe+ZO8mINjcvBecKyF+JO4XDDwLglvMQASjnQR8wg8kTOyAOORgimLGh7O++pa5/8TKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EjG16xKn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C80CCC4CEE5;
	Tue,  4 Mar 2025 14:27:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741098436;
	bh=2Au5twRhQNpRl3N3lvaKrD+Ua/A/kyLQZmS2YDyTLdw=;
	h=From:To:Cc:Subject:Date:From;
	b=EjG16xKn/AtxzKmrjZqFjYiTeT+NW1IrqUNWbmmj5F9aiEttvCAs7ZflsW94exvRP
	 OvBxc7Nuwmd6AKeP35DIIVZGnN+kUTZDP+txloWvPinT7WOdwK/aMJ4v8H3X4zNveJ
	 5XR4ghZMQunpy/7CPsuMkVLM89dTrvuI+36HQ5lMAbhaLKd92il9joVMsTZMeO/Awp
	 z0v388Y1QD1IezObGWxCekSXEKtStXDDV4mGUsqON43FA/A2LXDYp7otz1uQiPwQIm
	 FmA0IOZM0MFveO8iduOODA9LIdr9kccea4MWHrFFxiVfgp9jOKl/o811jLGh2Aslht
	 y1Up8kdrAFavA==
From: Arnd Bergmann <arnd@kernel.org>
To: Aun-Ali Zaidi <admin@kodeit.net>,
	Aditya Garg <gargaditya08@live.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Atharva Tiwari <evepolonium@gmail.com>,
	Kerem Karabay <kekrby@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] drm/tiny: fix printk format string for 32-bit
Date: Tue,  4 Mar 2025 15:27:02 +0100
Message-Id: <20250304142711.621330-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

A size_t must be printed with the %z modifier instead of %l:

In file included from include/linux/device.h:15,
                 from include/linux/usb.h:19,
                 from drivers/gpu/drm/tiny/appletbdrm.c:19:
drivers/gpu/drm/tiny/appletbdrm.c: In function 'appletbdrm_send_request':
include/drm/drm_print.h:589:54: error: format '%lu' expects argument of type 'long unsigned int', but argument 4 has type 'size_t' {aka 'unsigned int'} [-Werror=format=]
drivers/gpu/drm/tiny/appletbdrm.c:170:17: note: in expansion of macro 'drm_err'
  170 |                 drm_err(drm, "Actual size (%d) doesn't match expected size (%lu)\n",
      |                 ^~~~~~~
drivers/gpu/drm/tiny/appletbdrm.c: In function 'appletbdrm_read_response':
include/drm/drm_print.h:589:54: error: format '%lu' expects argument of type 'long unsigned int', but argument 4 has type 'size_t' {aka 'unsigned int'} [-Werror=format=]
drivers/gpu/drm/tiny/appletbdrm.c:211:17: note: in expansion of macro 'drm_err'
  211 |                 drm_err(drm, "Actual size (%d) doesn't match expected size (%lu)\n",
      |                 ^~~~~~~

Fixes: 0670c2f56e45 ("drm/tiny: add driver for Apple Touch Bars in x86 Macs")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/gpu/drm/tiny/appletbdrm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/tiny/appletbdrm.c b/drivers/gpu/drm/tiny/appletbdrm.c
index f5d177e234e4..394c8f9bd41a 100644
--- a/drivers/gpu/drm/tiny/appletbdrm.c
+++ b/drivers/gpu/drm/tiny/appletbdrm.c
@@ -167,7 +167,7 @@ static int appletbdrm_send_request(struct appletbdrm_device *adev,
 	}
 
 	if (actual_size != size) {
-		drm_err(drm, "Actual size (%d) doesn't match expected size (%lu)\n",
+		drm_err(drm, "Actual size (%d) doesn't match expected size (%zu)\n",
 			actual_size, size);
 		return -EIO;
 	}
@@ -208,7 +208,7 @@ static int appletbdrm_read_response(struct appletbdrm_device *adev,
 	}
 
 	if (actual_size != size) {
-		drm_err(drm, "Actual size (%d) doesn't match expected size (%lu)\n",
+		drm_err(drm, "Actual size (%d) doesn't match expected size (%zu)\n",
 			actual_size, size);
 		return -EBADMSG;
 	}
-- 
2.39.5


