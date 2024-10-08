Return-Path: <linux-kernel+bounces-355612-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFB549954C3
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 18:45:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6D66FB271CF
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 16:45:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 730ED1E1041;
	Tue,  8 Oct 2024 16:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b="ES2Y2dL2"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DAEB1E0DEF
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 16:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728405892; cv=none; b=h83BLiZzvWNlgK4QsH6w81XIHqJiskG5gP9YV3YLdszcqlv+yH+c5dI/4i2wbqNToCIE1yE3fpo9JW2y7agRh+uwqMbgs7cAFGkJ52wsSmJyTYkBivHPapGX0m2QiL9xtXgYAH9xzvYLAPcj+5fZmWLBn05Bo5vWZhJXIl22VtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728405892; c=relaxed/simple;
	bh=7LJFaZ5lVg4DIQoHqNAd7OFH5xxkU2BgOP/yAhDK6Yo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TmY86aKNVfc+RJ+FPp7DUpvyID4M7KEjYlI/v0YL1t3utH2v7epZPygWkQO0Uhpmex+h381obnCpR/47McMcQeK1SADWk63cSXeEWJNo6LTrOpxPkIaQOZ9hXTWEKHPw5QV14yzI4wGwMqKOBonMPOo/HBXHHLMsvh+d315rLLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com; spf=pass smtp.mailfrom=raspberrypi.com; dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b=ES2Y2dL2; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=raspberrypi.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-42cb9a0c300so55114725e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2024 09:44:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google; t=1728405889; x=1729010689; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2l4FLyzwOuwNRQ0BH8EkMWwB8eDzTs5gmrCiRkeOxgQ=;
        b=ES2Y2dL2VeoLS4X+8FDJ/HcEx/IfM2mDyKg/ElGhwiS45XX0sCRRfPUUHh+t5jrY2x
         yRUnqTGooPIOwakYtg8yPFw3wYQz+gzwMiwJVFp2Fy2esKY8j8zX05vaG5cc9Dcv2Sx+
         lWNQwO7HJh8h1NtCdKoPhN0hhooaUoBNTJrMU46ApPUwRPlCkz6GOpgyKX3sW0dtGes+
         JpRNAjIBjOcYO9spsTHr4U0b+iw8c2vgOW1RGJBW/97jv5cp25TNtKgXj/NWX3B6dEIC
         GR44eBW4GbHugmephqZk0YF8XxWlHMTio9bOR/1AxojM+XSCe2LAKXQ1/CCFIC+KJvdY
         2B2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728405889; x=1729010689;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2l4FLyzwOuwNRQ0BH8EkMWwB8eDzTs5gmrCiRkeOxgQ=;
        b=sDPsG11wQ0UugvCRKvQIbSZc46GWS4mx0n+KdRoQZnpl6IUbIp0GuEsFjnZpSyqWTZ
         IhVc15hKZq2YUQmk3tdtSnTHX9jO1fV2equq5tJ5m9Zt+zgy8dlQnsDjRXKzBWFNan0E
         MsaAhTXkpp/zAt6ud+wIRpH6z5MxjYkga0gP2Q87Se6+Ao3MZIHbm0QFs6S2Swem0hoR
         k0sj/ivyJ4PSqtcAJMSci1e89ZuJfnhMxgSwzqg5cA+4VCSmlKkgiAyjxIUeK+gcREYC
         bLs67+rYdHmYubHyTOsAlgf0gZUYB8eK8OjfGKVAu8unCVQ88ZPtulBYirqRfsFbq1LC
         OAnQ==
X-Forwarded-Encrypted: i=1; AJvYcCX9+b+Fo4f4iIZj7A57+FPYUrG8trtCC1YJRo23flU2DE3BmCwbTiSIlLOIODQhM8piCvASkY3B9dDT0ME=@vger.kernel.org
X-Gm-Message-State: AOJu0YxG8Q0/+GMN6zGlgDod+tODLKMpfI4x/OJVEc8fVlqBXWUE2LpR
	KzibI/pS9ShXtH4nj3mZND+e8/aWgXr0FvjgeFgF2eqeW4rQUkfq7T/iijKo3I4=
X-Google-Smtp-Source: AGHT+IHutSlQhM1lnWVmLyvUAsNDvxWyNHWdvnQugeExpuf3dCs4jPGscvamNYC8t4b6FoA34h4a+w==
X-Received: by 2002:a05:600c:35ca:b0:42c:bae0:f05b with SMTP id 5b1f17b1804b1-43023094011mr28998195e9.1.1728405889355;
        Tue, 08 Oct 2024 09:44:49 -0700 (PDT)
Received: from [127.0.1.1] ([2a00:1098:3142:e::8])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-42f86b4acddsm132133155e9.44.2024.10.08.09.44.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 09:44:48 -0700 (PDT)
From: Dave Stevenson <dave.stevenson@raspberrypi.com>
Date: Tue, 08 Oct 2024 17:44:36 +0100
Subject: [PATCH 3/3] drm/vc4: Correct generation check in vc4_hvs_lut_load
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241008-drm-vc4-fixes-v1-3-9d0396ca9f42@raspberrypi.com>
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

Commit 24c5ed3ddf27 ("drm/vc4: Introduce generation number enum")
incorrectly swapped a check of hvs->vc4->is_vc5 to
hvs->vc4->gen == VC4_GEN_4 in vc4_hvs_lut_load, hence breaking
loading the gamma look up table on Pi0-3.

Correct that conditional.

Fixes: 24c5ed3ddf27 ("drm/vc4: Introduce generation number enum")
Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
---
 drivers/gpu/drm/vc4/vc4_hvs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/vc4/vc4_hvs.c b/drivers/gpu/drm/vc4/vc4_hvs.c
index c5ebc317188a..1edf6e3fa7e6 100644
--- a/drivers/gpu/drm/vc4/vc4_hvs.c
+++ b/drivers/gpu/drm/vc4/vc4_hvs.c
@@ -224,7 +224,7 @@ static void vc4_hvs_lut_load(struct vc4_hvs *hvs,
 	if (!drm_dev_enter(drm, &idx))
 		return;
 
-	if (hvs->vc4->gen == VC4_GEN_4)
+	if (hvs->vc4->gen != VC4_GEN_4)
 		goto exit;
 
 	/* The LUT memory is laid out with each HVS channel in order,

-- 
2.34.1


