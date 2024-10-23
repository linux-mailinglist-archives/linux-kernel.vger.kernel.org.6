Return-Path: <linux-kernel+bounces-378522-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BD119AD1D0
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 18:57:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1A7928761A
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 16:57:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE480200CBD;
	Wed, 23 Oct 2024 16:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b="pOwL66H6"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D5E22038CC
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 16:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729702251; cv=none; b=JRorUjrmV5Ba5lfUDnUaepEwqx/0Yj3AvW+a1kp3vJSLbpUynEDGiHKJl06y/DpneBfy74tksRVU85DvVRb4/pw7OQdorbcIhOvzQrqrt5mt1ytH7Goi0Jof9gfJYw4H51V1zFv9IMOE0gdFrV1oqdDcZlU/g7uiBnr5HdAz5a4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729702251; c=relaxed/simple;
	bh=ZpoQHHOugAokWeviZCRyfQ9yR7PkyScHju2uFvM9Aw0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iPHWniMl1VZeLhteIFtnYf3VOa5VbUZU5KuFYhXByi74eA4bJlDF4lyOqS5L2UEeHi5EmZDhqOoQVmmvWdFVg9H031/nOHKD9hm1GIHMKoI97OhJucw2bo+AEZ6/Sv83ITG6KmBG8wQi3C63H3DECYwgUxbyjpflUjbQsRPIkkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com; spf=pass smtp.mailfrom=raspberrypi.com; dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b=pOwL66H6; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=raspberrypi.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-43161c0068bso56791735e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 09:50:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google; t=1729702248; x=1730307048; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LXVu+XPK1twrhAqeJinZn0FZ1mNK/jEIbakCvmjUtPs=;
        b=pOwL66H6CdJ7bJg8VymBw5mpXmteWXfca5HnOJkb5CIchGrgbvPK5mWE0EX6i7obCc
         mxDdm8xY8ir9gCzab7wRdcarsArLtx588RfkJcdD+1dYkVLoHiQkUc+QZypVNNxAtxRS
         0vhVsprVFQOlo3sElaIzOb76LZbaAoCym/0Q+9/pUZfOxWG75JwfOtYllmDkpkC849qc
         ijPJ6fwRKWyGOI1ySaXl+aV4djI+aAgNMVw0ybWGEhNvwjkNOwMYo5dU4tDqNnQ4P4VJ
         uXxEP6iBcq9wGzC2E2Zjn2zGu+uGpybiWwLaOKRYB4s6gXyuNsctxtAVl+g+FMl+EzbO
         h2HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729702248; x=1730307048;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LXVu+XPK1twrhAqeJinZn0FZ1mNK/jEIbakCvmjUtPs=;
        b=GFPzmgdLSRz5vtjd9M3rsOWbPFf1pKMJAa5iifxaEWF39Uq67m1EFv4jPebfXOqCO1
         lkyBXKvTaSgA65yCGLQQZRfyipem/C7frPut+WIgPAXDxG7p2veYfoyNHZI/9ar2Hb9D
         9v21PoGK0VwYsL5FFCD1bb586UcMXGU8RZCIT8eOnNaAKC0tt1JRM/XhdRJO9inNc2lQ
         /U5G0vOFJlL8ajr+Ck/ay1aMlMQhAyrzr4azCZPjO/00sGos9hDSixWX5B99llEpDz89
         ZDPQa7EWBGomIqAyi+KaAoGi7RhshA7fGGMEixe7dKm92I/PzJDfhEGjbRT8NgD3fQK5
         okqQ==
X-Forwarded-Encrypted: i=1; AJvYcCXQy9RP9ca1gyj5T8XeOorQmMQgKUMESDxdhi9cEotSxIIpOMxKOHRZxYTn2p0NoIBFWu7ZOpaYKyIMpU8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz48vK9uwjz+skaclZt4FocIKr3Hk+eGQmKi4RtOJt4zWayJ1Xj
	ed+JvwlTSrhWXOjZlgnksg4YMxmtZbYuzGETuyXTXwtT3XlW1Tm8e59yoc6MhOA=
X-Google-Smtp-Source: AGHT+IE4mgCaYm2elKT76LlNq3zUCFQBwxYPgla+kkQUxdQtty9ocFGx1hYzfLUy3hw38CapCGa/1g==
X-Received: by 2002:a05:600c:4ecd:b0:431:612f:189b with SMTP id 5b1f17b1804b1-431841fdademr30938035e9.12.1729702247813;
        Wed, 23 Oct 2024 09:50:47 -0700 (PDT)
Received: from [127.0.1.1] ([2a00:1098:3142:e::8])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-43186c50445sm21642035e9.39.2024.10.23.09.50.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 09:50:47 -0700 (PDT)
From: Dave Stevenson <dave.stevenson@raspberrypi.com>
Date: Wed, 23 Oct 2024 17:50:25 +0100
Subject: [PATCH 28/37] drm/vc4: Enable bg_fill if there are no planes
 enabled
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241023-drm-vc4-2712-support-v1-28-1cc2d5594907@raspberrypi.com>
References: <20241023-drm-vc4-2712-support-v1-0-1cc2d5594907@raspberrypi.com>
In-Reply-To: <20241023-drm-vc4-2712-support-v1-0-1cc2d5594907@raspberrypi.com>
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
---
 drivers/gpu/drm/vc4/vc4_hvs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/vc4/vc4_hvs.c b/drivers/gpu/drm/vc4/vc4_hvs.c
index f15aba4b81d7..5d40bbcb3b54 100644
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


