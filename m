Return-Path: <linux-kernel+bounces-446346-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB3AF9F2320
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2024 11:19:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D84E3164B90
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2024 10:19:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DA81154449;
	Sun, 15 Dec 2024 10:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SMFE8nrC"
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0964E56B81
	for <linux-kernel@vger.kernel.org>; Sun, 15 Dec 2024 10:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734257976; cv=none; b=YDg7rertCtOnyCVl3GGIvow76x8L0yCmnveea0AYGAdJepkqneWveP2KMMoGnf68RUPeWn8+8bQeFe420Wt+TbSyPuE8Nv8INcKdG0bqMhHtWLEDKpmdw5qiVi5uk2D/GZUAZW1pIZYzuTQaD6BAH7BWuXskkbV7yAofs03JAOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734257976; c=relaxed/simple;
	bh=URv90sDi3FjEk/GhJLTr5K8X04KZk3euo1MdVzvepzg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LEWNIdVnqWYtxGpvBPMVsVIyK7Lm+ySdlaAs4U0/M+zp5OG/+tzRcljxy7bOeYIcQa3tDDiDWjrc/XxC98fd21ixrta24tjIRS7ZLRSkxKXk3T8Zez5cNmDzfnAIQIgjMVWAMrZyzy7f/8FPidJdmEN7XmrUd6OxYY6H/Ofqf6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SMFE8nrC; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2ffd6af012eso36444251fa.2
        for <linux-kernel@vger.kernel.org>; Sun, 15 Dec 2024 02:19:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734257972; x=1734862772; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K0Pa1DpQtTQf5AsxhpFIP1iouoGhFtMYxmKB7fMM9Hc=;
        b=SMFE8nrC9YuPd8XdrSAjb37DDZzjpd8N43RlhUJCwo3o1TltqJmFnW4gGyrwV9RBSq
         g7VdY+Fpus+8ArfqJ10spcXtijv/iBL/xcLhYo3OTY9tg9L8ZCzQOssGZanUtVI35pYb
         0W5Wn42K+b/8p3s2IadCB7IDnMlGTvKq7Ed528q15+tqvD+/SzAtWrk60L1MO1m8RT53
         CUCqhcDAB23jzgQeoGaJXKcZ0LmbA2Zs2mJ4PIe+/cXrZ4fx+BWRqb2fZHDVJTXoW2O1
         mQqG9Jp7TlQQKOZtiMyOebT25nL5XWXSWsVez3Su9DZptLXyb42PVOF+4pO5D31DMNBW
         YOuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734257972; x=1734862772;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K0Pa1DpQtTQf5AsxhpFIP1iouoGhFtMYxmKB7fMM9Hc=;
        b=H7mzKTVGMIOK8Tq9U+HSXOBlvzoZNSsh29sU3++9+vjELQATNw/RojsexXsZ2YsgXp
         t1ekKy087/9x3oiezQGeCYnwDr+B5/bS35ZjKb4M80lfjV16VjCLU/Lv5plK66BZRyef
         N4e4/Wrv8VmiTwxIHstvumwG/YTnARaFzj4jfFiCDGS/ac9zGBSPwMk59fuSP+YaQQ4U
         3zBfSb04hXp0YIrcMa6XDWs9J/efOFKhMYHjYVaclqgKbLwglrcgDF5vw33HAF37htJD
         HrKa/XUXrgRmClT8o60pbikpQzPefqZdKDxYm0zbSNucBvADxiu/rGTxsic6dcoyYwfk
         z2gg==
X-Forwarded-Encrypted: i=1; AJvYcCU0wtFNUclzqj1Vv88rXMkRRT3dHbcSuVvO5thVJqnSriTB/0t7X9btuTD6w5WW4quY4eIU6h9oVWy30og=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9amhaqefRGMMejNma5ZmkGfvWmz+Sijc40+wQJ+ixXkHzVzMi
	Yz1lV0gLBdFOi4r8DBSxuniHBCdeJULTFOdP1j2LaULQI4ZbE1woZSiFlg3pPn0=
X-Gm-Gg: ASbGncv8Ht75mB6iKN7D1knzT/A1vNQ2IJtaYXdvVvPqH4g7yv5eVF6wJ884xU6ytry
	Z+H89PGLHErbvBq9Ch3irS41gZcmDf0JWU91GYh6BSmsHr7zcDNjcJvaFsrHmE7+1mPXVR9YrBy
	e8ROT0RP6mrle+Znv+6iu0d4NZ2ruyKsRJfaQzvMCXatanX8fxajZdmBiaQDEUuzBJuPQkW8zuk
	eCERKMhFm4zFhM6lAaChoaKPCnuOmgHVSd+ti8wt+yyteCBQ4lB1VXVtgTv9m9i
X-Google-Smtp-Source: AGHT+IHjLGhEq3RJ7lY+doWC0Q9bi0Mw9xPvbxoiNsVJdZ8CUlxXv2l1nmcvW3T7FZcOVj8KGQqKFA==
X-Received: by 2002:a2e:a5cb:0:b0:2ff:c3d2:b0ab with SMTP id 38308e7fff4ca-302544b1a1amr35005071fa.29.1734257972037;
        Sun, 15 Dec 2024 02:19:32 -0800 (PST)
Received: from umbar.lan ([192.130.178.90])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3034401d546sm5270851fa.11.2024.12.15.02.19.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Dec 2024 02:19:30 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Sun, 15 Dec 2024 12:19:23 +0200
Subject: [PATCH v2 1/2] drm/nouveau: incorporate I2C TV encoder drivers
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241215-nouveau-encoder-slave-v2-1-ef7a0e687242@linaro.org>
References: <20241215-nouveau-encoder-slave-v2-0-ef7a0e687242@linaro.org>
In-Reply-To: <20241215-nouveau-encoder-slave-v2-0-ef7a0e687242@linaro.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Karol Herbst <kherbst@redhat.com>, Lyude Paul <lyude@redhat.com>, 
 Danilo Krummrich <dakr@kernel.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 nouveau@lists.freedesktop.org, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=11337;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=URv90sDi3FjEk/GhJLTr5K8X04KZk3euo1MdVzvepzg=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBnXq0vFHr+/MyrxXW6dXjXWRfz8KCeUrPRwE5Zc
 rM2sW+AOCCJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZ16tLwAKCRCLPIo+Aiko
 1TorB/92locLwkzuuTxEwRPYjyHNWDvMSECsDyxVR24D76YM7BYwRBgLpT2R6S+ZZ9NS3RXKMaw
 7cPCBG4zvyaA5PLReg3SwfGEXLKKrn7OYjQzV6d1hze6IVNyu4zlrOH39Brt5aYt27TXzliL8KR
 66S827IWk0fSyuqFK9nkdAERwww4i9nvl2A+fj/xymxBw1QJcSmnKC+NoAi0EkTYCsjk3IbH4iD
 fMj6sOcWzPtjgO6jMQz3uks5wZvWuWM2RDfGBvuwGEnXjRR5IRr8WeImo5CjhlMRb4UInSv5GPR
 c+aGqTeHeMggebuVjU0+FGAwfBty/T18BxWVN7SRzqDN5sNq
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
 arch/arm/configs/multi_v7_defconfig                  |  4 ++--
 arch/parisc/configs/generic-32bit_defconfig          |  4 ++--
 arch/parisc/configs/generic-64bit_defconfig          |  4 ++--
 drivers/gpu/drm/i2c/Kconfig                          | 18 ------------------
 drivers/gpu/drm/i2c/Makefile                         |  6 ------
 drivers/gpu/drm/nouveau/Kconfig                      | 20 ++++++++++++++++++++
 drivers/gpu/drm/nouveau/dispnv04/Kbuild              |  2 ++
 drivers/gpu/drm/nouveau/dispnv04/dfp.c               |  2 +-
 drivers/gpu/drm/nouveau/dispnv04/i2c/Kbuild          |  5 +++++
 .../gpu/drm/{ => nouveau/dispnv04}/i2c/ch7006_drv.c  |  0
 .../gpu/drm/{ => nouveau/dispnv04}/i2c/ch7006_mode.c |  0
 .../gpu/drm/{ => nouveau/dispnv04}/i2c/ch7006_priv.h |  7 ++++---
 .../gpu/drm/{ => nouveau/dispnv04}/i2c/sil164_drv.c  |  3 ++-
 drivers/gpu/drm/nouveau/dispnv04/tvnv04.c            |  2 +-
 .../gpu/drm/nouveau/include}/i2c/ch7006.h            |  4 ++--
 .../gpu/drm/nouveau/include}/i2c/sil164.h            |  4 ++--
 16 files changed, 45 insertions(+), 40 deletions(-)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 9d4336261e450ce5bf99a1aa53e603bd7c0037bb..7fb24a4fb9f697c0c726204d0ba3754e87000e6a 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -713,10 +713,10 @@ CONFIG_VIDEO_ADV7604_CEC=y
 CONFIG_VIDEO_ML86V7667=m
 CONFIG_IMX_IPUV3_CORE=m
 CONFIG_DRM=y
-# CONFIG_DRM_I2C_CH7006 is not set
-# CONFIG_DRM_I2C_SIL164 is not set
 CONFIG_DRM_I2C_NXP_TDA998X=m
 CONFIG_DRM_NOUVEAU=m
+# CONFIG_DRM_NOUVEAU_CH7006 is not set
+# CONFIG_DRM_NOUVEAU_SIL164 is not set
 CONFIG_DRM_EXYNOS=m
 CONFIG_DRM_EXYNOS_FIMD=y
 CONFIG_DRM_EXYNOS_MIXER=y
diff --git a/arch/parisc/configs/generic-32bit_defconfig b/arch/parisc/configs/generic-32bit_defconfig
index 5ce258f3fffaf0e3aac5f8f5450dd65bad305879..f5fffc24c3bc5baf0d77b845e3ac77fae49b276e 100644
--- a/arch/parisc/configs/generic-32bit_defconfig
+++ b/arch/parisc/configs/generic-32bit_defconfig
@@ -132,11 +132,11 @@ CONFIG_I2C=y
 CONFIG_HWMON=m
 CONFIG_DRM=m
 CONFIG_DRM_DISPLAY_DP_AUX_CEC=y
-# CONFIG_DRM_I2C_CH7006 is not set
-# CONFIG_DRM_I2C_SIL164 is not set
 CONFIG_DRM_RADEON=m
 CONFIG_DRM_NOUVEAU=m
 # CONFIG_DRM_NOUVEAU_BACKLIGHT is not set
+# CONFIG_DRM_NOUVEAU_CH7006 is not set
+# CONFIG_DRM_NOUVEAU_SIL164 is not set
 CONFIG_DRM_VGEM=m
 CONFIG_DRM_UDL=m
 CONFIG_DRM_MGAG200=m
diff --git a/arch/parisc/configs/generic-64bit_defconfig b/arch/parisc/configs/generic-64bit_defconfig
index 19a804860ed5b355f82396c2314bd0d8f3fb768a..704f68fbf960fb865206c8f8ab1751c9f0db6de3 100644
--- a/arch/parisc/configs/generic-64bit_defconfig
+++ b/arch/parisc/configs/generic-64bit_defconfig
@@ -193,11 +193,11 @@ CONFIG_MEDIA_SUPPORT=m
 CONFIG_AGP=y
 CONFIG_AGP_PARISC=y
 CONFIG_DRM=y
-# CONFIG_DRM_I2C_CH7006 is not set
-# CONFIG_DRM_I2C_SIL164 is not set
 CONFIG_DRM_RADEON=y
 CONFIG_DRM_NOUVEAU=m
 # CONFIG_DRM_NOUVEAU_BACKLIGHT is not set
+# CONFIG_DRM_NOUVEAU_CH7006 is not set
+# CONFIG_DRM_NOUVEAU_SIL164 is not set
 CONFIG_DRM_MGAG200=m
 CONFIG_FB=y
 CONFIG_FB_PM2=m
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
 
diff --git a/drivers/gpu/drm/nouveau/dispnv04/i2c/Kbuild b/drivers/gpu/drm/nouveau/dispnv04/i2c/Kbuild
new file mode 100644
index 0000000000000000000000000000000000000000..3fddfc97bcb399ef3821c6065e5868363883ac74
--- /dev/null
+++ b/drivers/gpu/drm/nouveau/dispnv04/i2c/Kbuild
@@ -0,0 +1,5 @@
+ch7006-y := dispnv04/i2c/ch7006_drv.o dispnv04/i2c/ch7006_mode.o
+obj-$(CONFIG_DRM_NOUVEAU_CH7006) += ch7006.o
+
+sil164-y := dispnv04/i2c/sil164_drv.o
+obj-$(CONFIG_DRM_NOUVEAU_SIL164) += sil164.o
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
index 052bdc48a339df47073ab305f224f96c8630d66c..8136f8cd8f9b859ccf915e295c783f9fc8321c2e 100644
--- a/drivers/gpu/drm/i2c/ch7006_priv.h
+++ b/drivers/gpu/drm/nouveau/dispnv04/i2c/ch7006_priv.h
@@ -24,12 +24,13 @@
  *
  */
 
-#ifndef __DRM_I2C_CH7006_PRIV_H__
-#define __DRM_I2C_CH7006_PRIV_H__
+#ifndef __NOUVEAU_I2C_CH7006_PRIV_H__
+#define __NOUVEAU_I2C_CH7006_PRIV_H__
 
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
similarity index 97%
rename from include/drm/i2c/ch7006.h
rename to drivers/gpu/drm/nouveau/include/i2c/ch7006.h
index 5305b9797f938626c8f6c464ddc9bf424a39b4a0..1a6fa405f85b2a0d0f9a4d1c786defc527fa1d3b 100644
--- a/include/drm/i2c/ch7006.h
+++ b/drivers/gpu/drm/nouveau/include/i2c/ch7006.h
@@ -24,8 +24,8 @@
  *
  */
 
-#ifndef __DRM_I2C_CH7006_H__
-#define __DRM_I2C_CH7006_H__
+#ifndef __NOUVEAU_I2C_CH7006_H__
+#define __NOUVEAU_I2C_CH7006_H__
 
 /**
  * struct ch7006_encoder_params
diff --git a/include/drm/i2c/sil164.h b/drivers/gpu/drm/nouveau/include/i2c/sil164.h
similarity index 96%
rename from include/drm/i2c/sil164.h
rename to drivers/gpu/drm/nouveau/include/i2c/sil164.h
index ddf248693c8be8809777723c272f82af8d334c99..b86750d7abe1c2e7142eac32898398475fd42531 100644
--- a/include/drm/i2c/sil164.h
+++ b/drivers/gpu/drm/nouveau/include/i2c/sil164.h
@@ -24,8 +24,8 @@
  *
  */
 
-#ifndef __DRM_I2C_SIL164_H__
-#define __DRM_I2C_SIL164_H__
+#ifndef __NOUVEAU_I2C_SIL164_H__
+#define __NOUVEAU_I2C_SIL164_H__
 
 /**
  * struct sil164_encoder_params

-- 
2.39.5


