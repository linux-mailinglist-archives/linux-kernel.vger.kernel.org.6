Return-Path: <linux-kernel+bounces-347775-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 713A098DE62
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 17:07:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 62D6E1F27EE2
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 15:07:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CDD81D0B88;
	Wed,  2 Oct 2024 15:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b="P89GCkDb"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 304E61D0434
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 15:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727881614; cv=none; b=HwS/vVeJ0pupbchN8n+jHrERSqe15IaXMzsNX+iCUp1ZIQQ05+8QMSAwe4h1/YswcS/4e57JJXyhTw6YyEQ7ST/WfQWzkN0tniNLpDm+qJ9Cz8iO6r/elJwYBmlN00bCJvfXFMxRuvdy7kzTa4ELprgwg6kV/Gl+bkR3FrT+G38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727881614; c=relaxed/simple;
	bh=s0ZYaoZy5RxDRoP4fCLym1q4d4J+shoVMr+lDQeMhks=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mhXVC1NA1epytqHzpuEwhofn3j6HwV7w8ME1SHJ7ZbzByzucK92MKW27jOs6h0LokLm/0ypUMzkAkLCKglxB4yxEDo+NssUvxZXZ/euVs2rHHxkRHTG/vWjfU7O95m202QkiQ1PwLQXXWLt4v9Ju6Xo11fOLZRsGcSsR2v4OpKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com; spf=pass smtp.mailfrom=raspberrypi.com; dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b=P89GCkDb; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=raspberrypi.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-37ce8458ae3so3100842f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2024 08:06:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google; t=1727881611; x=1728486411; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3wuudxDZwL1ziyHfxVsUQH/I2F8ewPn5gbw+DbZPTKE=;
        b=P89GCkDbHT9rTmWBVG2WFjvNY8nBb0PcQ+NwPMzmdyCLsplPT5wjDjQ628wplrPCz5
         9VLK6n5CaHQbbk9MFAOLF2xCpFx1ekhtMy7f2L0ulfIHmiXfu1+kSWdyBDfpG4h1QQuQ
         UVUbfgbrgBuPTnnEfPG+e5O3of+3fEZ1elbvETolpVE2uo2oIXXs3TAj1KrrU2Nn/Goi
         jgSPb1XrRG1VRNVR0cT0evqjziPfGM80fBfRwIax0oSvaK5Rfs5IpZCzkwt9G1ohlr6e
         KuComgD5NtniQfc+dDipafTOkm7wOiK5z3tre8uVN0X6e4gxBoQrXdugFE8+ceavrbLo
         fFJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727881611; x=1728486411;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3wuudxDZwL1ziyHfxVsUQH/I2F8ewPn5gbw+DbZPTKE=;
        b=Rji/l8/fenM+ttJq6M6UI2ffhgaLBKGNWF/NuoTTOeUOr7zTtnERPrhZNvpcaPHqOu
         Exwk94YpQXtMhWOZlXpdKGDFcYe3omU9Vnvi65nXqav2aTKIgZ53zMmIjVikpfamq2HL
         zqashOz4XKOgVKpE7q2E1+yrEnjFHAfiRIfoKrU/k0T7q2j+nxweCFXUxBzxs62jknAN
         bYwSNJEao+dCJwpL27LZUp3m99cSalrkhhzPWJC7XqcC5jUEyp+iPpm9VBbF1q/qpQHD
         79THyfMkGeKir+jIA45OcM+E1m0HIoTwYLxFX1kgcwJLoeFUtuuq48vE98y4vG5qqDYp
         ma9A==
X-Forwarded-Encrypted: i=1; AJvYcCUVSIzD29BDpc7MIC6M/Gfi+EBghwHZeSP121O1PslRy9Y3CNHbU8W4B0E1bU5rb4ITiZ+AkZiZd/tW12A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7WqUv7q7nfch1jfZDetz0tH3DLvxb7Q7T4JWF8ZuV0YWNIs8m
	mjboRFmH6+zVb40kwswA6uqtHXq8Fc5zNgO53DsyAG+ZjMyrcJQrnscFXcwiFTM=
X-Google-Smtp-Source: AGHT+IHWOP5x5OgGMlJLFrprCPz4xB9T/rqwZqubCZ2Ex7qOQhyYFFIozvlL0zfFLPyvvUeHBp07Mw==
X-Received: by 2002:a5d:64a5:0:b0:37c:d53a:612e with SMTP id ffacd0b85a97d-37cfba189d3mr2738282f8f.51.1727881611322;
        Wed, 02 Oct 2024 08:06:51 -0700 (PDT)
Received: from [127.0.1.1] ([2a00:1098:3142:e::8])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-42f79ec0a44sm20794485e9.17.2024.10.02.08.06.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 08:06:49 -0700 (PDT)
From: Dave Stevenson <dave.stevenson@raspberrypi.com>
Date: Wed, 02 Oct 2024 16:06:19 +0100
Subject: [PATCH 1/2] drm/vc4: Run default client setup for all variants.
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241002-vc4_fbdev_fix-v1-1-8737bd11b147@raspberrypi.com>
References: <20241002-vc4_fbdev_fix-v1-0-8737bd11b147@raspberrypi.com>
In-Reply-To: <20241002-vc4_fbdev_fix-v1-0-8737bd11b147@raspberrypi.com>
To: Maxime Ripard <mripard@kernel.org>, 
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, 
 Javier Martinez Canillas <javierm@redhat.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Dave Stevenson <dave.stevenson@raspberrypi.com>
X-Mailer: b4 0.14.1

Commit 45903624e9fc ("drm/vc4: Run DRM default client setup")
only added DRM_FBDEV_DMA_DRIVER_OPS for the vc4 (Pi0-3) driver
definition, which caused an issue on vc5 (Pi4) as there was no
fbdev_probe function defined.

Fixes: 45903624e9fc ("drm/vc4: Run DRM default client setup")
Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
---
 drivers/gpu/drm/vc4/vc4_drv.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/vc4/vc4_drv.c b/drivers/gpu/drm/vc4/vc4_drv.c
index 13a1ecddbca3..a238f76a6073 100644
--- a/drivers/gpu/drm/vc4/vc4_drv.c
+++ b/drivers/gpu/drm/vc4/vc4_drv.c
@@ -238,6 +238,7 @@ const struct drm_driver vc5_drm_driver = {
 #endif
 
 	DRM_GEM_DMA_DRIVER_OPS_WITH_DUMB_CREATE(vc5_dumb_create),
+	DRM_FBDEV_DMA_DRIVER_OPS,
 
 	.fops = &vc4_drm_fops,
 

-- 
2.34.1


