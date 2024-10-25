Return-Path: <linux-kernel+bounces-382251-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 42D4D9B0B80
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 19:27:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 920E31F260D7
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 17:27:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F236C230885;
	Fri, 25 Oct 2024 17:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b="T41xgAoi"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F0B022ADBB
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 17:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729876600; cv=none; b=UinVxfYNseOEqE0km5HnseqYbcjkB+zH/JdAtO8qU6fCCd81n+wLjt8WVspxb47AQriz6f/BGGOgYPum2uqkoHPQap3f7wivt7TgFn0ZMdJhhwcDL/7VmzsHOpjnRpDOgGAGFxCBfSduhoR/U244krDmsD39umN/ItvTQ9lP2SI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729876600; c=relaxed/simple;
	bh=dgB9TDqOjPHC53NYjTeAKDgaQq5QKMSxepqaspF/csI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=J9MVZrVjb5WVij3mfjHAa8hNvzxw7bHy2/DNUvSUF9/0X4mmMO4oiiEY41I6VuENabun7GjbYvdMzVpmUdHZ/5jzPRAxw3ggRgT9NOJv7xJGSERkIYsbzE2LQbSwm6axyZbSM4qBzUaYu0uMRmqV0tDiqlMg42jBiIqSuNLf8lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com; spf=pass smtp.mailfrom=raspberrypi.com; dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b=T41xgAoi; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=raspberrypi.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4315839a7c9so23004225e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 10:16:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google; t=1729876593; x=1730481393; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k+NR5LKr4OxeWQLlNj8flZMDifFbPCFEGLf/3iSNdew=;
        b=T41xgAoiYjYRG2N0x87OEJB+S31juJxn6G+S//lU9tdYfEjy/tTmCFzAYtgNiI9b69
         Uk3Sok50qteYAYGjcy5syzXCi6NAxM+1wrcG/FuiSrm4v88Bx92DjjrbvPUAmNeKDBqm
         rVwU/7fAtV8TqbQhclQXxnJmoWqPnb7rkSA5Zqh7vJqplG3s/e4GtNen2iJkTvxuVC/Y
         RVUx+TsxLJ2BLAh2wRe7a3wqeJNfx25bB6OSF+YSiqoHJ56vXpA1wORCG886l6G45gP1
         bwbxxCQbIfFIHlmCHZ2PG0AgbfbyuogSQ+wRCBCg3HlxMFGrWa1mxJ40w/iAPbMaLfUi
         3TEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729876593; x=1730481393;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k+NR5LKr4OxeWQLlNj8flZMDifFbPCFEGLf/3iSNdew=;
        b=sqFnnYB8ZgMeH1Edt/gNCkPtI+CWRebLodIuzCsleIClw24lUQVPILjTGoj8Nu/cpQ
         rtaPT6QpuOzUGXQqk9NHsJWIekaX0bp1HkfMYMP+PT5YHRy0Wseo12wt/TVWY2Jszn1b
         bDPyXh4QvxvigoSzHnWCGr/qaNW5EOOp1PWxjI73BBAfeuVdpLd8hlotSx5Eyh9EjlVU
         g6Mgc7n19/LoTaiabMLmuHcNxuwTjwDkSgtObEEShy3vKfnqS2brMI2JlJoYXL0CwyVN
         T/p9YgCjjyzWdpmC8wtTPY2rcPYS/Fc2uUnd88Z2YFtGBnmH7KySD0eVRFtxzdmpb9rg
         HyoA==
X-Forwarded-Encrypted: i=1; AJvYcCUzGiAOJ0dQUBF7qf/D343AaoqBqKbpPyeZ8zUtP2b0ZNn6y9bMqobhBUngzT7rB30usSre4DbgtHjyef0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgAniYyJ7IQyRSISLe9n2pavbru1F2HSzXyqeNRIlmMJbtlyNR
	RYxCqwNoEgtOV2Te2dy3I8dEypHcvC7ZTy2Odr213LqvOCfbs/8mORgwkXyFQU0=
X-Google-Smtp-Source: AGHT+IHe5tCoSz92UO987eOIzi01b4rnj6tRANtMPS83mpXtoleIp32yTkc1Cq0CRABNQvTNNn9/Eg==
X-Received: by 2002:a5d:63cf:0:b0:37c:d57d:71cd with SMTP id ffacd0b85a97d-380611ff862mr97480f8f.52.1729876593018;
        Fri, 25 Oct 2024 10:16:33 -0700 (PDT)
Received: from [127.0.1.1] ([2a00:1098:3142:e::8])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-38058b91f50sm2013649f8f.94.2024.10.25.10.16.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2024 10:16:32 -0700 (PDT)
From: Dave Stevenson <dave.stevenson@raspberrypi.com>
Date: Fri, 25 Oct 2024 18:16:04 +0100
Subject: [PATCH v2 33/36] clk: bcm: rpi: Add disp clock
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241025-drm-vc4-2712-support-v2-33-35efa83c8fc0@raspberrypi.com>
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

From: Maxime Ripard <mripard@kernel.org>

BCM2712 has an extra clock exposed by the firmware called DISP, and used
by (at least) the HVS. Let's add it to the list of clocks to register in
Linux.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
---
 drivers/clk/bcm/clk-raspberrypi.c          | 5 +++++
 include/soc/bcm2835/raspberrypi-firmware.h | 1 +
 2 files changed, 6 insertions(+)

diff --git a/drivers/clk/bcm/clk-raspberrypi.c b/drivers/clk/bcm/clk-raspberrypi.c
index b12d86720207..0e1fe3759530 100644
--- a/drivers/clk/bcm/clk-raspberrypi.c
+++ b/drivers/clk/bcm/clk-raspberrypi.c
@@ -34,6 +34,7 @@ static char *rpi_firmware_clk_names[] = {
 	[RPI_FIRMWARE_M2MC_CLK_ID]	= "m2mc",
 	[RPI_FIRMWARE_PIXEL_BVB_CLK_ID]	= "pixel-bvb",
 	[RPI_FIRMWARE_VEC_CLK_ID]	= "vec",
+	[RPI_FIRMWARE_DISP_CLK_ID]	= "disp",
 };
 
 #define RPI_FIRMWARE_STATE_ENABLE_BIT	BIT(0)
@@ -139,6 +140,10 @@ raspberrypi_clk_variants[RPI_FIRMWARE_NUM_CLK_ID] = {
 		.export = true,
 		.minimize = true,
 	},
+	[RPI_FIRMWARE_DISP_CLK_ID] = {
+		.export = true,
+		.minimize = true,
+	},
 };
 
 /*
diff --git a/include/soc/bcm2835/raspberrypi-firmware.h b/include/soc/bcm2835/raspberrypi-firmware.h
index 73cac8d0287e..e1f87fbfe554 100644
--- a/include/soc/bcm2835/raspberrypi-firmware.h
+++ b/include/soc/bcm2835/raspberrypi-firmware.h
@@ -152,6 +152,7 @@ enum rpi_firmware_clk_id {
 	RPI_FIRMWARE_M2MC_CLK_ID,
 	RPI_FIRMWARE_PIXEL_BVB_CLK_ID,
 	RPI_FIRMWARE_VEC_CLK_ID,
+	RPI_FIRMWARE_DISP_CLK_ID,
 	RPI_FIRMWARE_NUM_CLK_ID,
 };
 

-- 
2.34.1


