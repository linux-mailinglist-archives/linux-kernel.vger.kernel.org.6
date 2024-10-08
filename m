Return-Path: <linux-kernel+bounces-355611-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA3F69954C2
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 18:45:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBC1D1C20946
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 16:45:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3B311E1020;
	Tue,  8 Oct 2024 16:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b="UoDMisc+"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B67B1E0DE2
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 16:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728405892; cv=none; b=prJC3r9U/mDgYceRHOgfAmiitJ0Wve4w9tMJLFIRwEDnqzSAqCACw+kD06waOH0Ls6H8PsXkUfxWqd1vqKPx4lOpsuutIMFRTLQ+9H3LOb2v/xEbnOEvO2Yw/ku6nmkVebuRigndVCATazfLIFXGhcjB9QWKVAblngftvcSpjT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728405892; c=relaxed/simple;
	bh=h3UCe1Rt32rV9sM43SpJCsE3HPW1UX3cfs9j80OLF9Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Pi9TUNu7qdlOl0PvvP5o0Ev5KEOdxDL9W2teurOz5srbKGyyKWxYIgZ8BXR8qj4jt6/adhOicjZRY67ES+t3FKwnuUbUUzkGO5YNJOYiY3UTRuZBBcl52C8d/TaZVSH6sVS3i4pBeSocxhUpmogkjdUR/EiLAxVauNE2EH4t7oE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com; spf=pass smtp.mailfrom=raspberrypi.com; dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b=UoDMisc+; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=raspberrypi.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-42cbb08a1a5so60057975e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2024 09:44:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google; t=1728405889; x=1729010689; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=90ANlFWGN+t7YRM+OQtOzbvQb+vC2EWhHHwqfHzlk5w=;
        b=UoDMisc+Q7Wwni4VR69WesJn4ksXMHy3c031X2Ar7J0guaKzVGy14BdL2TBUkxnvnj
         KPdvyK3srW+KgPW1Lfm7p8rfOWgH7UU4iZp/ZrsDuxHSSFQRb6UazOX66T8CvHmCXttk
         DGVC+75Scvub/M/tweJjps1l5gLpgaONDZDR8mx7D5Njg3Gp6Tyrp+Zr8d8ztdsf8pXG
         daPTPXju4NENFq1bDP2hYTvCycNZwH3V5ayPXYMZ8JoJY1r3gKIXSSsZ9bS+ORc3Nwr9
         oefgKRNNqGvOXDqGS9RMGogK56geBMAcJUUNFFi+FQ+5OUSjCUVFRjZmyLAki1x/J7ba
         ZJgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728405889; x=1729010689;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=90ANlFWGN+t7YRM+OQtOzbvQb+vC2EWhHHwqfHzlk5w=;
        b=wtAjFDjAhdIvWIp/GWU1+7ddrvuuX5bCnb3s/rDpfW4FTv1G6aXpThQd8ltNLezsvG
         jAxRhdlYqO0hkWAkAlz6OcVRGNn5Z91XhhlteZNf+M+qN4mozWQSNBGNaQDKKftYluRw
         1XDNH8DwqZRsIEhLdZk850rUy7qX5GSajiWlOQN0JUre1Z8zoHcL6wJzEmhrvz0b5C6W
         g7nbW91ndALTYOva1GWAt/gLcRNisMFBh+o1anI3RikGcIJB8RPc+vleYaQ7XJ6RASSD
         EMtRPef1dGpAptgW0+dAcih26MatVdOxJI5ZSoh+RD4pb2RbyqQ4FBNOczmzXPJDoHZa
         Sz7A==
X-Forwarded-Encrypted: i=1; AJvYcCUrHGgu/SmLC3+/9zxeg2IfKm5y/TEO48554GiS6vU4v72KGVzcxsqYUoiSzjSGh/jAgxKLGKsICzAsrgI=@vger.kernel.org
X-Gm-Message-State: AOJu0YykBTvtB5XVHKmea0Wuxim2SF12EzvyOftU42xS7jOl1Wy1LuTB
	O/Q1bPJJoPyEdqIdBgSACey0+XpVSGQ4Lj1MWgtRwdDyWFpVo2nU4S2PWhjAT5E=
X-Google-Smtp-Source: AGHT+IFvA3g8BnPqda9AgaP6SE6nfhTyCYyUtjJJCs7ai6iH9pJMhXZuRLfeVaJbZvQEw/32OWwilg==
X-Received: by 2002:a05:600c:47d2:b0:430:5701:93a4 with SMTP id 5b1f17b1804b1-430570198c6mr14325085e9.14.1728405888599;
        Tue, 08 Oct 2024 09:44:48 -0700 (PDT)
Received: from [127.0.1.1] ([2a00:1098:3142:e::8])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-42f86b4acddsm132133155e9.44.2024.10.08.09.44.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 09:44:48 -0700 (PDT)
From: Dave Stevenson <dave.stevenson@raspberrypi.com>
Date: Tue, 08 Oct 2024 17:44:35 +0100
Subject: [PATCH 2/3] drm/vc4: Match drm_dev_enter and exit calls in
 vc4_hvs_atomic_flush
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241008-drm-vc4-fixes-v1-2-9d0396ca9f42@raspberrypi.com>
References: <20241008-drm-vc4-fixes-v1-0-9d0396ca9f42@raspberrypi.com>
In-Reply-To: <20241008-drm-vc4-fixes-v1-0-9d0396ca9f42@raspberrypi.com>
To: Maxime Ripard <mripard@kernel.org>, 
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Dave Stevenson <dave.stevenson@raspberrypi.com>
X-Mailer: b4 0.14.1

Commit 92c17d16476c ("drm/vc4: hvs: Ignore atomic_flush if we're disabled")
added a path which returned early without having called drm_dev_exit.

Ensure all paths call drm_dev_exit.

Fixes: 92c17d16476c ("drm/vc4: hvs: Ignore atomic_flush if we're disabled")
Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
---
 drivers/gpu/drm/vc4/vc4_hvs.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/vc4/vc4_hvs.c b/drivers/gpu/drm/vc4/vc4_hvs.c
index 546ee11016b2..c5ebc317188a 100644
--- a/drivers/gpu/drm/vc4/vc4_hvs.c
+++ b/drivers/gpu/drm/vc4/vc4_hvs.c
@@ -603,7 +603,7 @@ void vc4_hvs_atomic_flush(struct drm_crtc *crtc,
 	}
 
 	if (vc4_state->assigned_channel == VC4_HVS_CHANNEL_DISABLED)
-		return;
+		goto exit;
 
 	if (debug_dump_regs) {
 		DRM_INFO("CRTC %d HVS before:\n", drm_crtc_index(crtc));
@@ -686,6 +686,7 @@ void vc4_hvs_atomic_flush(struct drm_crtc *crtc,
 		vc4_hvs_dump_state(hvs);
 	}
 
+exit:
 	drm_dev_exit(idx);
 }
 

-- 
2.34.1


