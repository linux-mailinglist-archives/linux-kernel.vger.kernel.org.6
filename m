Return-Path: <linux-kernel+bounces-341173-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A277987C0A
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 02:02:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DCF851F2434F
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 00:02:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8983B8F77;
	Fri, 27 Sep 2024 00:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WmIJnHME"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AE6BEEAA
	for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 00:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727395315; cv=none; b=kl4lrrVNRBYKK3REkByqj7yPee9njjbWuYj0+Ycs4MXsuPVjcQ3Tv6JcZO90AZifHbz71VP8fhvFDT007vO1l/aaxVadHbKM4hJI9XHqC6gWyc28FcQKxqf8kgCWakTy1GQnyFV9p2ML86epzluI2ymIg6XwhTDG6MYV+/KnU3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727395315; c=relaxed/simple;
	bh=wG1fb7RQLeE1k8Xc01+ulCtomfuFWlAH1S1tSuyfWd4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=u8bQAXBCXzCgG2HS53FNVbPBZAdxlWSGN9adzh0vxh9a/sbfUjW6KsCqPMTr8IzEWTWP2un+N5xfcEO3ebzlCm28kFLBA1LymPkgNpXN0BhVIxUx1n2kOSiMvfMRahiME206i+8yqqtTYJy7fK1g69xYkdDVaLZrnd3SXbRfqk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WmIJnHME; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a8d4979b843so203516066b.3
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 17:01:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727395312; x=1728000112; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=U4DmHwZhZIQSDJ1IAkiV7HNtDx5RPl1Sb5duaMbxKCs=;
        b=WmIJnHMEv/vGkWLexUdkHI0w0ysXAg0K+y7MX1GqCneD93RmBJGmgNA1809E8+9WV6
         ExjytKIcPBbqSp08HdsmIOsLPi8jVP8DUaMU9D1RxfuM217OwVLr6KO3vD58tVRP8NZW
         gmMPrqcZlxNQDhhlgIbNHI7BhDM6os7xtjsqtAjafb9IOh08kR4ncRvsf0spR/oworDO
         eCXO772esE8Mj1ZrEi4gZ5hLAISZUs2PTlH1ZBRm9k0It9kIubkz1tWageKOcDWkDZtU
         rPWvAWwlojQdXBe4prjfqhwIGjuEmU57qBL87xTYyzInZ7dp8Ijx4fSUGvfkK+17GMhb
         EGgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727395312; x=1728000112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U4DmHwZhZIQSDJ1IAkiV7HNtDx5RPl1Sb5duaMbxKCs=;
        b=KGL4emMr2JaBF97fybsckLb2LKk5EKEtu/yZEqcCuUUCdBpLzAyLYg2FZuqmmhlna1
         eS6vN8v7x3myGzInCQqU6XuHMMHG8B5T9fSFimrdwh83hME1WMRqlluPA9seLcXbrINr
         Rlk/Ta0FLGnJQbHa8AxCaA0ftIJz1lFON4cfyCVnl4weUnlepNUMeAVRg+gVG8gc33KT
         kJNjtwMEEyj843tua1oI+mIGO2ySQZMwWZeYsGfPUPKFoEeF4Ant7zzLjaIDQNKTzAUs
         T9OAM03v1opogpi3sCi8tFTUIKv1yDJEOPerk727H4zTmssmvWCZe6FWZ1H9vY2frrlc
         5khw==
X-Forwarded-Encrypted: i=1; AJvYcCVs7i4kJWwNEBpUn5DnH8fqm9JHseKSbPPzLfv9H5hfVPw5TGXeoD0fnaVZZYhoGDVIaxM69MWmAsiZXQk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnqGeO8n8qx9zX9uPvqPKgUd3tYIgHbdfnfvE/s8gNnVtBvg/O
	7/tmmKHRHsPuWAp3SesZztP9QNQy5zK4cRynQJIEq96IEJ7nDYaK
X-Google-Smtp-Source: AGHT+IEe+4qv/gH8mKQLQOBF/U3++C2ZiNBlIGNXsVrwjBIzuzBkLAg83454FCfI+dydv3Tdevl6sg==
X-Received: by 2002:a17:907:9492:b0:a7a:8da1:eb00 with SMTP id a640c23a62f3a-a93c48f6ea4mr88816366b.7.1727395311367;
        Thu, 26 Sep 2024 17:01:51 -0700 (PDT)
Received: from alessandro-pc.station (net-37-119-37-200.cust.vodafonedsl.it. [37.119.37.200])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a93c2979d88sm52566666b.156.2024.09.26.17.01.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2024 17:01:50 -0700 (PDT)
From: Alessandro Zanni <alessandro.zanni87@gmail.com>
To: jani.nikula@linux.intel.com,
	rodrigo.vivi@intel.com,
	joonas.lahtinen@linux.intel.com,
	tursulin@ursulin.net,
	airlied@gmail.com,
	simona@ffwll.ch
Cc: Alessandro Zanni <alessandro.zanni87@gmail.com>,
	intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	anupnewsmail@gmail.com
Subject: [PATCH] gpu: drm: i915: display: Avoid null values intel_plane_atomic_check_with_state
Date: Fri, 27 Sep 2024 02:01:44 +0200
Message-ID: <20240927000146.50830-1-alessandro.zanni87@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This fix solves multiple Smatch errors:

drivers/gpu/drm/i915/display/intel_atomic_plane.c:660
intel_plane_atomic_check_with_state() error:
we previously assumed 'fb' could be null (see line 648)

drivers/gpu/drm/i915/display/intel_atomic_plane.c:664
intel_plane_atomic_check_with_state()
error: we previously assumed 'fb' could be null (see line 659)

drivers/gpu/drm/i915/display/intel_atomic_plane.c:671
intel_plane_atomic_check_with_state()
error: we previously assumed 'fb' could be null (see line 663)

We should check first if fb is not null before to access its properties.

Signed-off-by: Alessandro Zanni <alessandro.zanni87@gmail.com>
---
 drivers/gpu/drm/i915/display/intel_atomic_plane.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_atomic_plane.c b/drivers/gpu/drm/i915/display/intel_atomic_plane.c
index e979786aa5cf..1606f79b39e6 100644
--- a/drivers/gpu/drm/i915/display/intel_atomic_plane.c
+++ b/drivers/gpu/drm/i915/display/intel_atomic_plane.c
@@ -656,18 +656,18 @@ int intel_plane_atomic_check_with_state(const struct intel_crtc_state *old_crtc_
 	    intel_plane_is_scaled(new_plane_state))
 		new_crtc_state->scaled_planes |= BIT(plane->id);
 
-	if (new_plane_state->uapi.visible &&
+	if (new_plane_state->uapi.visible && fb &&
 	    intel_format_info_is_yuv_semiplanar(fb->format, fb->modifier))
 		new_crtc_state->nv12_planes |= BIT(plane->id);
 
-	if (new_plane_state->uapi.visible &&
+	if (new_plane_state->uapi.visible && fb &&
 	    fb->format->format == DRM_FORMAT_C8)
 		new_crtc_state->c8_planes |= BIT(plane->id);
 
 	if (new_plane_state->uapi.visible || old_plane_state->uapi.visible)
 		new_crtc_state->update_planes |= BIT(plane->id);
 
-	if (new_plane_state->uapi.visible &&
+	if (new_plane_state->uapi.visible && fb &&
 	    intel_format_info_is_yuv_semiplanar(fb->format, fb->modifier)) {
 		new_crtc_state->data_rate_y[plane->id] =
 			intel_plane_data_rate(new_crtc_state, new_plane_state, 0);
-- 
2.43.0


