Return-Path: <linux-kernel+bounces-382243-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A968F9B0B6F
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 19:26:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5CA61C21DBA
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 17:26:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2781217672;
	Fri, 25 Oct 2024 17:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b="bM51e3JL"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D30222804F
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 17:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729876593; cv=none; b=FDNflDYtOF4WB7coFXoB67OqF3qR8km3iBTSNcq+guCMyZKsE0dKyc4lC/saQHaXxX7IKhj/iFrpj5OkPZQiJ/ihl8Z9q8doeqF4lPbf/n+krbJO3Qn2UvFo28YN/Pfu6I0+OG3zKEww+HNO97CGDXka/vo1e7muhoojQUkIi2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729876593; c=relaxed/simple;
	bh=m3UAiUE0biP1FsK0/13FGVcYEVRBGrRWaA1DplqidxU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FMMdD51/Z4uK8STC2yNfHwIdbzXG3Koj/eUzSqponaB0px70ooB8i0ERkoiGV0CW3Y9e0Qul9irse0kHQprZiGNGj5b5NEno2ooCX6o+WMbP53etWrgpLcx4+4AruZnUYcBQt96D8f5OB4+CGr29q5qFOTSS8ICB86RcNLlvgnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com; spf=pass smtp.mailfrom=raspberrypi.com; dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b=bM51e3JL; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=raspberrypi.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-37d41894a32so1759593f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 10:16:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google; t=1729876587; x=1730481387; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0vbQi4zffHZmgrFZhlEz3qZo9PncYkAwxBP66oHpwT0=;
        b=bM51e3JLX/AblHVdshfApzC+P3lV2ccqvqstnX92nceI9sTCgzG3LK3S52Om0udVM4
         PslHaFUlOQ8bLeL1gYlxsRMd940QP6RsyAPAnJR8rvdH/knsXFky7/6XW/Ma3jrcZPdD
         t6LLE0zfnYk3IojsPCFnKIl8zC1T+tWQhWjAUfz3u8JDgDnniRYRCUTgZJmUnHH42BKA
         /DZEZGDKPIpqju49ZUty18+6BFlSQUTa5LOcsBOvUIz8U9Ro0XwdVzMmg6QHwksRRBXa
         8XlagxmE4NFp3F5i7riHt1Bzq8RNqL8fRn2pHIKM/gtn/hMeU4KIkZMV7mf1l2lM5hMR
         L3Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729876587; x=1730481387;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0vbQi4zffHZmgrFZhlEz3qZo9PncYkAwxBP66oHpwT0=;
        b=H4eHavuRoFQz1DscwGDAxO0/ezogXb8+UqtlHSUKEWq2/PxEzV6j7C8uZ3TQFWzTBP
         Mlf/QgNX75CAW2XhLbd1FvI98gn6YZlun4ewF2zs8g3lTcvLgBpbn5gX12OB8AtwC3EH
         lxGAFTZyqRXAEf1YRw7glNb3WDX39qbd5ZXWhWOt83Pyq4Jq+RY30rYbrpzMLAnio53A
         59YXzVMvzz41W7Ytq58K5nLzvKnuxKZneHvVYe+Cbn3JUThatV6Q7Mssr5G+OMFvd8to
         jt5f9DzlzGSREe8ma6CcmrZAjvlQpSfLyGqutVwjs/hmF9jlE/CVtnZf4PeV+FsKWZP1
         r1bA==
X-Forwarded-Encrypted: i=1; AJvYcCXHmrCkKTjsLhCmdKpgYcZB0FCEzcY68illF70CeVU1StQRw5bXhEh3ICUM6Y9PpnqU3fOLnp3zl+FDZKs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+30AqaU1uYzeLJaWzllWg9HFWS8WhqY0cpA1bEJYOQtUQTRYo
	j4+ztq2wffQZGGLQ+1Pv+nZq5MfXPhXN7u39gIq1NoIp+uoPRvhjBVrFv1S8CLY=
X-Google-Smtp-Source: AGHT+IH+29oPVsRqs2fqHrAWDnK5QD/g1okRZ89yJvrj7HxIWsx6pgAGD3QO00ZuQ026KdKRThmfow==
X-Received: by 2002:adf:ec8f:0:b0:374:cd3c:db6d with SMTP id ffacd0b85a97d-3803abc51c6mr5147977f8f.6.1729876587557;
        Fri, 25 Oct 2024 10:16:27 -0700 (PDT)
Received: from [127.0.1.1] ([2a00:1098:3142:e::8])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-38058b91f50sm2013649f8f.94.2024.10.25.10.16.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2024 10:16:27 -0700 (PDT)
From: Dave Stevenson <dave.stevenson@raspberrypi.com>
Date: Fri, 25 Oct 2024 18:15:58 +0100
Subject: [PATCH v2 27/36] drm/vc4: Enable bg_fill if there are no planes
 enabled
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241025-drm-vc4-2712-support-v2-27-35efa83c8fc0@raspberrypi.com>
References: <20241025-drm-vc4-2712-support-v2-0-35efa83c8fc0@raspberrypi.com>
In-Reply-To: <20241025-drm-vc4-2712-support-v2-0-35efa83c8fc0@raspberrypi.com>
To: Maxime Ripard <mripard@kernel.org>, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>, 
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Florian Fainelli <florian.fainelli@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, 
 Javier Martinez Canillas <javierm@redhat.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org, 
 Dave Stevenson <dave.stevenson@raspberrypi.com>
X-Mailer: b4 0.14.1

The default was to have enable_bg_fill disabled and the first
plane set it if it wasn't opaque and covering the whole screen.
However that meant that if no planes were enabled, then the
background fill wasn't enabled, and would give a striped
output from the uninitialised output buffer.

Initialise it to enabled to avoid this.

Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
Reviewed-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/vc4/vc4_hvs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/vc4/vc4_hvs.c b/drivers/gpu/drm/vc4/vc4_hvs.c
index 2493ac17d78f..c8bc2b48648f 100644
--- a/drivers/gpu/drm/vc4/vc4_hvs.c
+++ b/drivers/gpu/drm/vc4/vc4_hvs.c
@@ -936,7 +936,7 @@ void vc4_hvs_atomic_flush(struct drm_crtc *crtc,
 	struct drm_plane *plane;
 	struct vc4_plane_state *vc4_plane_state;
 	bool debug_dump_regs = false;
-	bool enable_bg_fill = false;
+	bool enable_bg_fill = true;
 	u32 __iomem *dlist_start = vc4->hvs->dlist + vc4_state->mm.start;
 	u32 __iomem *dlist_next = dlist_start;
 	unsigned int zpos = 0;

-- 
2.34.1


