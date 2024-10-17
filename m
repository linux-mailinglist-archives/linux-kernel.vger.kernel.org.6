Return-Path: <linux-kernel+bounces-369350-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DBD59A1C21
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 09:57:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CB8A1C211FB
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 07:57:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE7591D1302;
	Thu, 17 Oct 2024 07:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VCgFANGK"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16E641B6CF2
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 07:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729151864; cv=none; b=AXGwCQPyDUlXfPZheJenbk64INFWP506dGcHT245crAmaDCdM/Jhmy1aM+U1ffOx/EMuc5g8KXQv/+ToZ0h7SQMjJnT25KFWg0QufnXWr4UIrfqQnvCta38PMv/KX7V37eZHFL03IUc611XRJlQY3ZWNOxDMSvKBBLL5Z0bz8tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729151864; c=relaxed/simple;
	bh=ysFEzHoIf05CPEXg2NSlaQt9BxxK0u3BMEtL+x53qSQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BRf64Wd9SPD0f95iujEDgLA1c80hw07kR5OHle10VhaqMXv+/K/Sl/Nw+eBPNKzLfgUTEyZEaXEG2ri4eBJrc/VfpestxFIPpUPXD2SCb3G62bYW3wa8sSGA3r1yD2bPtTo1jykj3GCmq/b3rxRjMEj4db7AfCrBg6iyRBV1Uy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VCgFANGK; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-539e690479cso710074e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 00:57:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729151858; x=1729756658; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kEg0zeTWEzgOxEOcS7zMMhXVtwfnHJYFvRIaI/gF0MU=;
        b=VCgFANGKMbIPgjfdxPKj2O4CvU7HpTMiWsarA33fjql6KxTLKxJA1cdjwHwICoWtxx
         NXQFKMjDtuWQk2z19cB8b+J/8anrl5alOCbOggWu3reb8njb3XL1eCk6llSLRIrNPaHo
         rrlNtMJ69kKdN33cKNcMJit0Bd0ndUvqJD0blNHUwMI6jSSvWwj4HI06B62Wxd9Lw+o4
         6DHBrICSn9YU98HN/G85GAa+hGuVuno8417Ym9zZYnax/p+GdJ3J/EZaP/P0f4HUflxM
         GTivtzOfRtWX+yavjOeixJ6GEjNgwX6/uivNoeGYjGr2A9pWWtWqkdA4n6hqzxyZuzxy
         aHVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729151858; x=1729756658;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kEg0zeTWEzgOxEOcS7zMMhXVtwfnHJYFvRIaI/gF0MU=;
        b=vS3MKoAZx9Cjxsqn9OzvGTkDHLUhNX5BYycZ/ywKJhDXWnkmgB1/+cZ5F5LR/EA4NY
         mgvas3tCYcf7P345hT5P8cDuPqwQiQyogasxKH0QlNhFjFq5R7+XKJKwcJYjmN3xbKHU
         Z5zUv+0pw2it0qnXFtxRWWqNRbKWzPXJocN90Dw8esavR8zuoLDynWcKz67n/9mnaulq
         uN5hyznXsvSu89whdl2tNiRMMuuruPNjnhEVrYvr8NHvP8K/wRA0c9mDhMGJ1uSDuN08
         PRVhdU2hsmMdYcyDq56bCx8xGNj0/2PP8AXiuJK2dy8hbR/TNEOrsJCYcDPhemoXPpjU
         3KEA==
X-Forwarded-Encrypted: i=1; AJvYcCVUVWQpisKluI+bu2NRhdTjWQjI++QN7h9IxeCBHzmAR+NJFGBeWwcwfRKu3cL7uAtPR92H5r0eFZPqTY4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHPJyJ0H1Qa3X5AxeznGF3VTGpSsSUA4Amo1EivaXAE9Gv5L+T
	+7AjRNDCuXfonTux6p7Bhj+D+B2Q3d55t3Qok2Lm7joR0OjwWe+e
X-Google-Smtp-Source: AGHT+IHc7cprvzcrGEg//WDzWKJt7hzqpefGqFa4tXnkGFB7777RAmwgm7rdKxdryrFGxYqTZIOxyA==
X-Received: by 2002:a05:6512:6c9:b0:539:9527:3d59 with SMTP id 2adb3069b0e04-539e572854amr10138398e87.52.1729151857765;
        Thu, 17 Oct 2024 00:57:37 -0700 (PDT)
Received: from giedriuslaptop.. ([78.63.144.185])
        by smtp.googlemail.com with ESMTPSA id 2adb3069b0e04-539ffff3e5asm678703e87.151.2024.10.17.00.57.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2024 00:57:37 -0700 (PDT)
From: =?UTF-8?q?Giedrius=20Statkevi=C4=8Dius?= <giedriuswork@gmail.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>
Cc: =?UTF-8?q?Giedrius=20Statkevi=C4=8Dius?= <giedriuswork@gmail.com>,
	Ankit Nautiyal <ankit.k.nautiyal@intel.com>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org
Subject: [PATCH v2] drm/i915/lspcon: do not hardcode settle timeout
Date: Thu, 17 Oct 2024 10:57:24 +0300
Message-ID: <20241017075725.207384-1-giedriuswork@gmail.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Avoid hardcoding the LSPCON settle timeout because it takes a longer
time on certain chips made by certain vendors. Use the function that
already exists to determine the timeout.

Reviewed-by: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
Signed-off-by: Giedrius Statkevičius <giedriuswork@gmail.com>
---
v2: add documentation about the parameter, apply 80 character line
    length limit.

 drivers/gpu/drm/display/drm_dp_dual_mode_helper.c | 4 ++--
 drivers/gpu/drm/i915/display/intel_lspcon.c       | 3 ++-
 include/drm/display/drm_dp_dual_mode_helper.h     | 2 +-
 3 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/display/drm_dp_dual_mode_helper.c b/drivers/gpu/drm/display/drm_dp_dual_mode_helper.c
index 14a2a8473682..d14b262b2344 100644
--- a/drivers/gpu/drm/display/drm_dp_dual_mode_helper.c
+++ b/drivers/gpu/drm/display/drm_dp_dual_mode_helper.c
@@ -486,16 +486,16 @@ EXPORT_SYMBOL(drm_lspcon_get_mode);
  * @dev: &drm_device to use
  * @adapter: I2C-over-aux adapter
  * @mode: required mode of operation
+ * @time_out: LSPCON mode change settle timeout
  *
  * Returns:
  * 0 on success, -error on failure/timeout
  */
 int drm_lspcon_set_mode(const struct drm_device *dev, struct i2c_adapter *adapter,
-			enum drm_lspcon_mode mode)
+			enum drm_lspcon_mode mode, int time_out)
 {
 	u8 data = 0;
 	int ret;
-	int time_out = 200;
 	enum drm_lspcon_mode current_mode;
 
 	if (mode == DRM_LSPCON_MODE_PCON)
diff --git a/drivers/gpu/drm/i915/display/intel_lspcon.c b/drivers/gpu/drm/i915/display/intel_lspcon.c
index f9db867fae89..30c31fddec99 100644
--- a/drivers/gpu/drm/i915/display/intel_lspcon.c
+++ b/drivers/gpu/drm/i915/display/intel_lspcon.c
@@ -211,7 +211,8 @@ static int lspcon_change_mode(struct intel_lspcon *lspcon,
 		return 0;
 	}
 
-	err = drm_lspcon_set_mode(intel_dp->aux.drm_dev, ddc, mode);
+	err = drm_lspcon_set_mode(intel_dp->aux.drm_dev, ddc, mode,
+				  lspcon_get_mode_settle_timeout(lspcon));
 	if (err < 0) {
 		drm_err(display->drm, "LSPCON mode change failed\n");
 		return err;
diff --git a/include/drm/display/drm_dp_dual_mode_helper.h b/include/drm/display/drm_dp_dual_mode_helper.h
index 7ee482265087..7ac6969db935 100644
--- a/include/drm/display/drm_dp_dual_mode_helper.h
+++ b/include/drm/display/drm_dp_dual_mode_helper.h
@@ -117,5 +117,5 @@ const char *drm_dp_get_dual_mode_type_name(enum drm_dp_dual_mode_type type);
 int drm_lspcon_get_mode(const struct drm_device *dev, struct i2c_adapter *adapter,
 			enum drm_lspcon_mode *current_mode);
 int drm_lspcon_set_mode(const struct drm_device *dev, struct i2c_adapter *adapter,
-			enum drm_lspcon_mode reqd_mode);
+			enum drm_lspcon_mode reqd_mode, int time_out);
 #endif
-- 
2.47.0


