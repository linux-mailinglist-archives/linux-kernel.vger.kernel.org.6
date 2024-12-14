Return-Path: <linux-kernel+bounces-446091-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 445E99F1FC4
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 16:36:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60B781656A7
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 15:36:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 290D219F410;
	Sat, 14 Dec 2024 15:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KDxhaJKv"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45B79194A66
	for <linux-kernel@vger.kernel.org>; Sat, 14 Dec 2024 15:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734190554; cv=none; b=LXJpGIkmJYpc5jxj0sLS0gapR8ddWx1ReV3Xw9CYGaFmHv7SGT9TwUnkBiMHObDXgbQraXauVVwWaJY4guK8vCcDNK1eLZKw+zTtP/jHJvMC9RlrNNaqSZ2qe0Bxuca9UZtWcp+1XRlynNte+L+yulFK0iNuR1W6q+jue716HF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734190554; c=relaxed/simple;
	bh=V6ybU/ZryBFo9P9r00mNGI18e/mMgAW9p72+Pg5jFvU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KoSVS6pjCKz5qcxk/gX7S0WEQAbD/D5fuJvi26999D1bbiBZmXsM8sEiStEgo2m7tZvuEqbiMxlu21ATUY881QY04qMMiuSzlCB+APLqrjTMoDqPyamprLKmdUWP3C9zP/2/5t+QUETAeRCGDINSi4P8qQaQGtZXywZkN/Duim0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KDxhaJKv; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5401bd6cdb4so2772234e87.2
        for <linux-kernel@vger.kernel.org>; Sat, 14 Dec 2024 07:35:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734190550; x=1734795350; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KZPMimRDyOPmrHk2P3ntOObHSO5fF1Ty+Zfxp6w4+z4=;
        b=KDxhaJKv3X2kH9hA8ItsQn2kn571Bwz+ZLGwJ3SxJJJ3bJ+Wuidm2L4ByGPbXJLge9
         UQkFOe4NXtZ3NlKsofwjeUUzC78OcTIA1v3eEA0gn3DVsN89vvDA81pEmhJi10G3538Y
         3SgTxKa+1UI04+jDpY10+xZsIzzhYIe36/JnnwTX0rTWX46jGd5IxXCC9xDcXNlI+BeE
         RMAiM08X0gABCPvfJJ8ObgvT872K64oNsTfldyaBNaTvlLy0rYvetsk8Jva2f0Mjocr+
         vRSf1HUzH4PpavVpPGtzEf7bWbJGIgngYGCEtudU2ewj/zYY5qGhSNyQPPgnKqQagJ5G
         4arQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734190550; x=1734795350;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KZPMimRDyOPmrHk2P3ntOObHSO5fF1Ty+Zfxp6w4+z4=;
        b=f3G6FHHAtmmJeoCsg3z1RpEAK0VC3ULihvsKo1zWIdYUimlIp1q73uOghc17qqU7gH
         15jeRQvH0ivB9yPldabNTAa4DdfqZsrxdYydKhqedn2lOybPIbM8ugKly9U9Iew222qM
         BEH6XWRjV9tgogxU+RGj3ApFsQqkCKRBzOp0XcmObpXeOppxyhL2557ena18d73cSmSy
         H29qZ5m2O6TmZasGAFpET2K2N3fAvC2tU8/k3v0ISvo5jxvFqPmVqKSPwUxbcn/DCIW3
         nVFeX7f9VD8L2YzwiRdqh//LjTeqDiaafrzd3gDoE+CEIMob5GI1qD1dkfSUhW6TemMC
         zNVg==
X-Forwarded-Encrypted: i=1; AJvYcCXmoxL7FZuoh1xmiG0TArp/fNILfsEPq/XuPOCN79vrUXKPXnEG50ogrdmLoVGCEE4QllBpqBTzTaFur30=@vger.kernel.org
X-Gm-Message-State: AOJu0Yza8pcpzw0OyPKbnCCIIwTuFbyJ3BKr2rEUWVwrcU6lE0if9d9o
	dofggO0VWAhGeP/C8dUjFcrQ0qGYPJh7KMDwZgVDIgJowGRMgotTACJ6PRZjoxU=
X-Gm-Gg: ASbGncvqA1E5c171/6r35Ivhrn70YpCZ3tb1uZwLfYfr6oEDle0pES91eWNuSFiJ4JR
	EG48hudgc0PtDUbMz+5ZikzeUtbCZEdN7EKOYJUV7Ye07XXzCCHj0muFRLnWqqKNB1RX6WMLD7H
	Q0BHwa6KJLk9LONcUs5RgnPtAakMH/EDrc8dw6tqV9fGg8KHl2cEoGzPc/bpEb4liMxgNqmI1MK
	bdtAfiEzPvF15/UY3UYMAl4Mh1rx6ywxR89TijMqy9fo5g+3CQWcieniw4832kU
X-Google-Smtp-Source: AGHT+IF4824okURcZ8IVtc3fuOUyKMzTtnxfMvIh8EwCwuYsWttCdeE0CtzcguYMExNjzfyDwjVYrA==
X-Received: by 2002:a05:6512:1388:b0:53e:38c3:5f7e with SMTP id 2adb3069b0e04-54090595789mr1997987e87.45.1734190550096;
        Sat, 14 Dec 2024 07:35:50 -0800 (PST)
Received: from umbar.lan ([192.130.178.90])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54120c1357csm249821e87.182.2024.12.14.07.35.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Dec 2024 07:35:48 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Sat, 14 Dec 2024 17:35:44 +0200
Subject: [PATCH 1/2] drm/nouveau: incorporate I2C TV encoder drivers
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241214-nouveau-encoder-slave-v1-1-beda767472e3@linaro.org>
References: <20241214-nouveau-encoder-slave-v1-0-beda767472e3@linaro.org>
In-Reply-To: <20241214-nouveau-encoder-slave-v1-0-beda767472e3@linaro.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Karol Herbst <kherbst@redhat.com>, Lyude Paul <lyude@redhat.com>, 
 Danilo Krummrich <dakr@kernel.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 nouveau@lists.freedesktop.org, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=7526;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=V6ybU/ZryBFo9P9r00mNGI18e/mMgAW9p72+Pg5jFvU=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBnXaXQfJfNKmGcRWBMaBaTs5fhcrn/7EEVSqTOh
 mWArJPEz5aJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZ12l0AAKCRCLPIo+Aiko
 1XcjB/4g21FLQVlpzajzWFU60jHrhYQ2Drihbj+Mr/CQq/mB8WLU874QL53oHKDEfI+k64lEob/
 kqpK8zQTkMZHriuXk1zYy7xEfoCKksXLPnUr+M8zpE4a5jn43ERIFVndwmWr+8DRF8oC7UnLdJc
 b8FSB4ac9CTmgsHq6QaX66cgStNGsq+vVus7P2cDkzNcNVI5hSIK7BvziWJyQWBjy9IA8nuaFok
 bB041vxZSDy0mY2lYWBSdNLExmLNi9yN/SZSom+PWKOAnWlsWQp7LHkffIF7J4nzrTHZfIc4lRI
 VCBqCaYBmh779C5XYkNEH/dIQxC/6rFdwgXyqzgfEWi+bMsq
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

Chrontel CH7006 and Silicon Image sil164 drivers use drm_encoder_slave
interface which is being used only by the nouveau driver. It doesn't
make sense to keep this interface inside the DRM subsystem. In
preparation to moving this set of helpers to the nouveau driver, move
the only two I2C driver that use that interface to the nouveau driver
too.

Suggested-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/gpu/drm/i2c/Kconfig                          | 18 ------------------
 drivers/gpu/drm/i2c/Makefile                         |  6 ------
 drivers/gpu/drm/nouveau/Kconfig                      | 20 ++++++++++++++++++++
 drivers/gpu/drm/nouveau/dispnv04/Kbuild              |  2 ++
 drivers/gpu/drm/nouveau/dispnv04/dfp.c               |  2 +-
 .../gpu/drm/{ => nouveau/dispnv04}/i2c/ch7006_drv.c  |  0
 .../gpu/drm/{ => nouveau/dispnv04}/i2c/ch7006_mode.c |  0
 .../gpu/drm/{ => nouveau/dispnv04}/i2c/ch7006_priv.h |  3 ++-
 .../gpu/drm/{ => nouveau/dispnv04}/i2c/sil164_drv.c  |  3 ++-
 drivers/gpu/drm/nouveau/dispnv04/tvnv04.c            |  2 +-
 .../gpu/drm/nouveau/include}/i2c/ch7006.h            |  0
 .../gpu/drm/nouveau/include}/i2c/sil164.h            |  0
 12 files changed, 28 insertions(+), 28 deletions(-)

diff --git a/drivers/gpu/drm/i2c/Kconfig b/drivers/gpu/drm/i2c/Kconfig
index 6f19e1c35e30b0e595c1a60628a6b8cf313fcabc..d5200f67958e68a8ec73401f1d3b79cbe0aa303d 100644
--- a/drivers/gpu/drm/i2c/Kconfig
+++ b/drivers/gpu/drm/i2c/Kconfig
@@ -2,24 +2,6 @@
 menu "I2C encoder or helper chips"
      depends on DRM && DRM_KMS_HELPER && I2C
 
-config DRM_I2C_CH7006
-	tristate "Chrontel ch7006 TV encoder"
-	default m if DRM_NOUVEAU
-	help
-	  Support for Chrontel ch7006 and similar TV encoders, found
-	  on some nVidia video cards.
-
-	  This driver is currently only useful if you're also using
-	  the nouveau driver.
-
-config DRM_I2C_SIL164
-	tristate "Silicon Image sil164 TMDS transmitter"
-	default m if DRM_NOUVEAU
-	help
-	  Support for sil164 and similar single-link (or dual-link
-	  when used in pairs) TMDS transmitters, used in some nVidia
-	  video cards.
-
 config DRM_I2C_NXP_TDA998X
 	tristate "NXP Semiconductors TDA998X HDMI encoder"
 	default m if DRM_TILCDC
diff --git a/drivers/gpu/drm/i2c/Makefile b/drivers/gpu/drm/i2c/Makefile
index a962f6f085686674ed33010345730db776815ebe..31fd35527d99d7eb23851d290175a3ff0c756772 100644
--- a/drivers/gpu/drm/i2c/Makefile
+++ b/drivers/gpu/drm/i2c/Makefile
@@ -1,10 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0
-ch7006-y := ch7006_drv.o ch7006_mode.o
-obj-$(CONFIG_DRM_I2C_CH7006) += ch7006.o
-
-sil164-y := sil164_drv.o
-obj-$(CONFIG_DRM_I2C_SIL164) += sil164.o
-
 tda998x-y := tda998x_drv.o
 obj-$(CONFIG_DRM_I2C_NXP_TDA998X) += tda998x.o
 obj-$(CONFIG_DRM_I2C_NXP_TDA9950) += tda9950.o
diff --git a/drivers/gpu/drm/nouveau/Kconfig b/drivers/gpu/drm/nouveau/Kconfig
index ce840300578d8a4011c448b61caf830cef3805bf..4cffac26f90ae6130ef30ba389b2a8c9b732058c 100644
--- a/drivers/gpu/drm/nouveau/Kconfig
+++ b/drivers/gpu/drm/nouveau/Kconfig
@@ -109,3 +109,23 @@ config DRM_NOUVEAU_GSP_DEFAULT
 	help
 	  Say Y here if you want to use the GSP codepaths by default on
 	  Turing and Ampere GPUs.
+
+config DRM_NOUVEAU_CH7006
+	tristate "Chrontel ch7006 TV encoder"
+	depends on DRM_NOUVEAU
+	default m
+	help
+	  Support for Chrontel ch7006 and similar TV encoders, found
+	  on some nVidia video cards.
+
+	  This driver is currently only useful if you're also using
+	  the nouveau driver.
+
+config DRM_NOUVEAU_SIL164
+	tristate "Silicon Image sil164 TMDS transmitter"
+	depends on DRM_NOUVEAU
+	default m
+	help
+	  Support for sil164 and similar single-link (or dual-link
+	  when used in pairs) TMDS transmitters, used in some nVidia
+	  video cards.
diff --git a/drivers/gpu/drm/nouveau/dispnv04/Kbuild b/drivers/gpu/drm/nouveau/dispnv04/Kbuild
index 975c4e2269366d57e928eedbbbc669d24744379f..949802882ebd53c15e124c218a092af9693d36bc 100644
--- a/drivers/gpu/drm/nouveau/dispnv04/Kbuild
+++ b/drivers/gpu/drm/nouveau/dispnv04/Kbuild
@@ -10,3 +10,5 @@ nouveau-y += dispnv04/overlay.o
 nouveau-y += dispnv04/tvmodesnv17.o
 nouveau-y += dispnv04/tvnv04.o
 nouveau-y += dispnv04/tvnv17.o
+
+include $(src)/dispnv04/i2c/Kbuild
diff --git a/drivers/gpu/drm/nouveau/dispnv04/dfp.c b/drivers/gpu/drm/nouveau/dispnv04/dfp.c
index 504c421aa176ef3d944592a0109cb72e21fd47b7..28a42ab5cb900ebe8a526e154f9e90598333356c 100644
--- a/drivers/gpu/drm/nouveau/dispnv04/dfp.c
+++ b/drivers/gpu/drm/nouveau/dispnv04/dfp.c
@@ -35,7 +35,7 @@
 #include "hw.h"
 #include "nvreg.h"
 
-#include <drm/i2c/sil164.h>
+#include <i2c/sil164.h>
 
 #include <subdev/i2c.h>
 
diff --git a/drivers/gpu/drm/i2c/ch7006_drv.c b/drivers/gpu/drm/nouveau/dispnv04/i2c/ch7006_drv.c
similarity index 100%
rename from drivers/gpu/drm/i2c/ch7006_drv.c
rename to drivers/gpu/drm/nouveau/dispnv04/i2c/ch7006_drv.c
diff --git a/drivers/gpu/drm/i2c/ch7006_mode.c b/drivers/gpu/drm/nouveau/dispnv04/i2c/ch7006_mode.c
similarity index 100%
rename from drivers/gpu/drm/i2c/ch7006_mode.c
rename to drivers/gpu/drm/nouveau/dispnv04/i2c/ch7006_mode.c
diff --git a/drivers/gpu/drm/i2c/ch7006_priv.h b/drivers/gpu/drm/nouveau/dispnv04/i2c/ch7006_priv.h
similarity index 99%
rename from drivers/gpu/drm/i2c/ch7006_priv.h
rename to drivers/gpu/drm/nouveau/dispnv04/i2c/ch7006_priv.h
index 052bdc48a339df47073ab305f224f96c8630d66c..c66ca7f525034bb9fd113c5edf10c371a01c3c79 100644
--- a/drivers/gpu/drm/i2c/ch7006_priv.h
+++ b/drivers/gpu/drm/nouveau/dispnv04/i2c/ch7006_priv.h
@@ -29,7 +29,8 @@
 
 #include <drm/drm_encoder_slave.h>
 #include <drm/drm_probe_helper.h>
-#include <drm/i2c/ch7006.h>
+
+#include <i2c/ch7006.h>
 
 typedef int64_t fixed;
 #define fixed1 (1LL << 32)
diff --git a/drivers/gpu/drm/i2c/sil164_drv.c b/drivers/gpu/drm/nouveau/dispnv04/i2c/sil164_drv.c
similarity index 99%
rename from drivers/gpu/drm/i2c/sil164_drv.c
rename to drivers/gpu/drm/nouveau/dispnv04/i2c/sil164_drv.c
index ff23422727fce290a188e495d343e32bc2c373ec..74fc961c0d0de06f1fe8dd93d351452cd20cead7 100644
--- a/drivers/gpu/drm/i2c/sil164_drv.c
+++ b/drivers/gpu/drm/nouveau/dispnv04/i2c/sil164_drv.c
@@ -30,7 +30,8 @@
 #include <drm/drm_encoder_slave.h>
 #include <drm/drm_print.h>
 #include <drm/drm_probe_helper.h>
-#include <drm/i2c/sil164.h>
+
+#include <i2c/sil164.h>
 
 struct sil164_priv {
 	struct sil164_encoder_params config;
diff --git a/drivers/gpu/drm/nouveau/dispnv04/tvnv04.c b/drivers/gpu/drm/nouveau/dispnv04/tvnv04.c
index d3014027a8122be499b85459b038fdcce5800720..67f3e0ac0e109b223ca8ec4ddc4e688247373b2e 100644
--- a/drivers/gpu/drm/nouveau/dispnv04/tvnv04.c
+++ b/drivers/gpu/drm/nouveau/dispnv04/tvnv04.c
@@ -32,7 +32,7 @@
 #include "hw.h"
 #include <drm/drm_modeset_helper_vtables.h>
 
-#include <drm/i2c/ch7006.h>
+#include <i2c/ch7006.h>
 
 static struct nvkm_i2c_bus_probe nv04_tv_encoder_info[] = {
 	{
diff --git a/include/drm/i2c/ch7006.h b/drivers/gpu/drm/nouveau/include/i2c/ch7006.h
similarity index 100%
rename from include/drm/i2c/ch7006.h
rename to drivers/gpu/drm/nouveau/include/i2c/ch7006.h
diff --git a/include/drm/i2c/sil164.h b/drivers/gpu/drm/nouveau/include/i2c/sil164.h
similarity index 100%
rename from include/drm/i2c/sil164.h
rename to drivers/gpu/drm/nouveau/include/i2c/sil164.h

-- 
2.39.5


