Return-Path: <linux-kernel+bounces-446355-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AF7119F2348
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2024 12:09:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EAC1F18866C4
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2024 11:09:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9DE817BB21;
	Sun, 15 Dec 2024 11:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bgzKISPd"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3915115534D
	for <linux-kernel@vger.kernel.org>; Sun, 15 Dec 2024 11:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734260959; cv=none; b=inSc5bOmdj1M3XHYWzK6Y65MCLlugCUjbgRsGCczXVkZfA4XOCp9kd4WDkQrzo9/PgvMlbbcg8sjDa6MvWUsJhRRWLok85411LShwu+umu7v/zWdKfqzOQFJEGAjJAlY69cSeYlctPOAtbWSjcT8VjEeVJtGsN/huWAKm0T4QsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734260959; c=relaxed/simple;
	bh=9HVg6HBh2+ASzBgpf6mNHTsofNt7kBP/QL4wncnBAys=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qEZEfsY2WwjHGFSM29NF+QLWlFy0d4UF+h6dSwGLu/nL1nwe+dBvqPYiI3zQywF/k4JeR4h4+Gz9hOcmO2K5h+KBsNjdXRvS5OaXE21QXmeQE9gxH0LTaHbs0gv47GiK6vm8MrNpkP2rNWXP7gBsrsWfBnOao4NXz4px7yo/jcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bgzKISPd; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-30227c56b11so31403591fa.3
        for <linux-kernel@vger.kernel.org>; Sun, 15 Dec 2024 03:09:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734260955; x=1734865755; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Rtqsq0uxUn5fTI7xk69AME8ZpJLgefJ43G2XJKPJ1EM=;
        b=bgzKISPdE/GBWGhc1xOk6EFSsnT/Xx5FI0Tsh48XrD6vH7AxuC7oDFq4ACoknwvEqb
         8gdidIGeYJj9RDJysubMZhxj9ZwUpOiBpy7S+e/zx0Kygr3FrSmJAZ1FWZGRwqE4Q9OW
         EOMtNLE7bPqMskhmA/Y1M5owVXppXB749egbN9azQz97YEZ89Lczq6UxwSUAzyhMETnz
         g8xCGHdN5U40rhefWbY3QZOvDor8/RUwjaUbvI1ULV/4sVjDSrrUrM5NiRZxdDAYOsiR
         tI+XbDFIvKhxDIvTByPo9BrCsneeus5v8wGWZcJZtDSYOwjvuT83UXv3As8KwFq/Jgem
         ryJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734260955; x=1734865755;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Rtqsq0uxUn5fTI7xk69AME8ZpJLgefJ43G2XJKPJ1EM=;
        b=JHJOJHFfq23IqPs6+P/O410EuKv9pXBMHc/UszaRP5fr311ZSHbgTPP1bjqUdjDGSU
         cDIxUk90WxPxl3ylswjfdbCSb1oD9D2/mzTWAGbOVobHA5+3ZdsQLFTuH3tHoDR+nD6T
         aCbz8VfrmPszleFBqowcy8PecbTQUwsKvGhltcNRQ2HdmCcMV4WF6RidfeNINmO0oBCN
         LdZjm6xOp19Uju+r41fyoMEeINGx20EX/s1mtvl2Gj5apDcx5dbWieub7Ku8XeXpMfUX
         LfQdKb55H7FQf3KP2ivc7iR9NWY3brEoLqNx3a6WyesTSN6WJnBG+jj26RhmNzSzRnkY
         xWoQ==
X-Gm-Message-State: AOJu0Yy94jlxC50/o8hOsqvEOGeIngqFG2e03EFsZZisglRswqd5GdUM
	Qmbnj5WTI8loOypET+fqJaUhQIe8lnoVPXDoD2bMim38WTrotQ0Ahph3hN7qwZ5jOuje7FI16tV
	J
X-Gm-Gg: ASbGnctCwyF81z/bcyrSR4SaE8tnUjOOcp7EcpsQkMI3O9QIZgqdMzxiNMQ2lJKQGPm
	90CLic+tZHgmknGf/MvlVvWtd4YPJBGIJo/geZHh6FzREwLxGx/2M1dUgLYxMeyNM39JUDhZD4N
	diOB+EV4bzcY9ijVFbKYVNqmc0FHGPOe6+Kw2F+Zckf3/d1AWALmZTGLtd6DPcVuUUO9ZyVN/u0
	m5oDDd78SDrhhjj8KaaR4oPoqZwXHDNdGzypK6Kkz4+xmg8T3IGcsDaAhm/bTR6
X-Google-Smtp-Source: AGHT+IFLmlv6NB9HM3wZEuLR4IJuP/fDkB45V7+26pOX+LvGU9x8LaRy70CNTQyyApNHRA4iD0fP+Q==
X-Received: by 2002:a2e:700b:0:b0:300:360b:bc36 with SMTP id 38308e7fff4ca-30254471c9bmr26058101fa.23.1734260954999;
        Sun, 15 Dec 2024 03:09:14 -0800 (PST)
Received: from umbar.lan ([192.130.178.90])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3034404544csm5261531fa.29.2024.12.15.03.09.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Dec 2024 03:09:13 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Sun, 15 Dec 2024 13:09:08 +0200
Subject: [PATCH 2/2] drm/i2c: move TDA drivers under drivers/gpu/drm/bridge
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241215-drm-move-tda998x-v1-2-7817122b1d73@linaro.org>
References: <20241215-drm-move-tda998x-v1-0-7817122b1d73@linaro.org>
In-Reply-To: <20241215-drm-move-tda998x-v1-0-7817122b1d73@linaro.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Liviu Dudau <liviu.dudau@arm.com>, Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Russell King <linux@armlinux.org.uk>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5882;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=9HVg6HBh2+ASzBgpf6mNHTsofNt7kBP/QL4wncnBAys=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBnXrjUQZKmGmQo8Fo8eAtPuOigqvQqQFAG2xwiX
 ey6K6dHUHaJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZ1641AAKCRCLPIo+Aiko
 1UxDB/0dxBw7DkueqenVzrvtWIOi2XXKAwKj+z31BJbjN099lOMVlTpMQHLXwsOzl1Y8UyEa9q0
 Df839NBVAQ7J05qOAf+MNlDEamFfoO4hChP+uVDIQY3syjwsQByNzYX2lrlZs4jZSicsLQY/Ma4
 Y/NK1E5QZf3A16uKaTtjbk7IS7QKwY6bpsQtFpz83eJyfAha1EDtq0mtLK/0O+ctXFZyjLCe7OW
 drghIcUUel3etPtsF7aYUAAEqv4i2D0vRZlY7+O8CjdN1sG9af3KALazOvd91rJPaE12TwXeP8f
 zM+ObiTq63sSxE/RcensAbq1KnEHOjj5E8vavQ7vRegV32MH
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

TDA998x is the HDMI bridge driver, incorporating drm_connector and
optional drm_encoder (created via the component bind API by the TICLDC
and HDLCD drivers). Thus it should be residing together with the other
DRM bridge drivers under drivers/gpu/drm/bridge/.

TDA9950 is an I2C-CEC translator, being present on-die on the TDA9989
and TDA19989 chips, so it is being instantiated by the TDA998x driver.
Move it together with the TDA998x under bridge drivers subdir.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 MAINTAINERS                                       |  2 +-
 drivers/gpu/drm/arm/Kconfig                       |  1 +
 drivers/gpu/drm/bridge/Kconfig                    |  2 ++
 drivers/gpu/drm/bridge/Makefile                   |  1 +
 drivers/gpu/drm/bridge/tda/Kconfig                | 13 +++++++++++++
 drivers/gpu/drm/bridge/tda/Makefile               |  4 ++++
 drivers/gpu/drm/{i2c => bridge/tda}/tda9950.c     |  0
 drivers/gpu/drm/{i2c => bridge/tda}/tda998x_drv.c |  0
 drivers/gpu/drm/i2c/Kconfig                       | 13 -------------
 drivers/gpu/drm/i2c/Makefile                      |  4 ----
 10 files changed, 22 insertions(+), 18 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 9a23e80abf309cbd918a74683895f8dbe0507a6e..a4c7afd564e721e14aebaf828b75776e50760a45 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16982,7 +16982,7 @@ M:	Russell King <linux@armlinux.org.uk>
 S:	Maintained
 T:	git git://git.armlinux.org.uk/~rmk/linux-arm.git drm-tda998x-devel
 T:	git git://git.armlinux.org.uk/~rmk/linux-arm.git drm-tda998x-fixes
-F:	drivers/gpu/drm/i2c/tda998x_drv.c
+F:	drivers/gpu/drm/bridge/tda/tda998x_drv.c
 F:	include/dt-bindings/display/tda998x.h
 K:	"nxp,tda998x"
 
diff --git a/drivers/gpu/drm/arm/Kconfig b/drivers/gpu/drm/arm/Kconfig
index c901ac00c0c3a8f356bd53d97305c6b39b3e6662..ed3ed617c6884876368c8bd072c53f1b710df443 100644
--- a/drivers/gpu/drm/arm/Kconfig
+++ b/drivers/gpu/drm/arm/Kconfig
@@ -9,6 +9,7 @@ config DRM_HDLCD
 	select DRM_CLIENT_SELECTION
 	select DRM_KMS_HELPER
 	select DRM_GEM_DMA_HELPER
+	select DRM_BRIDGE # for TDA998x
 	help
 	  Choose this option if you have an ARM High Definition Colour LCD
 	  controller.
diff --git a/drivers/gpu/drm/bridge/Kconfig b/drivers/gpu/drm/bridge/Kconfig
index 6b4664d91faa80f096ac6a0548ed342e802ae68b..1ef16dcc2ae53eb172604de2d6899004c080a979 100644
--- a/drivers/gpu/drm/bridge/Kconfig
+++ b/drivers/gpu/drm/bridge/Kconfig
@@ -438,4 +438,6 @@ source "drivers/gpu/drm/bridge/imx/Kconfig"
 
 source "drivers/gpu/drm/bridge/synopsys/Kconfig"
 
+source "drivers/gpu/drm/bridge/tda/Kconfig"
+
 endmenu
diff --git a/drivers/gpu/drm/bridge/Makefile b/drivers/gpu/drm/bridge/Makefile
index 97304b429a530c108dcbff906965cda091b0a7a2..52e6c9b3094bba0fd6aaf28af1b58f4bd8bf26d0 100644
--- a/drivers/gpu/drm/bridge/Makefile
+++ b/drivers/gpu/drm/bridge/Makefile
@@ -43,3 +43,4 @@ obj-y += analogix/
 obj-y += cadence/
 obj-y += imx/
 obj-y += synopsys/
+obj-y += tda/
diff --git a/drivers/gpu/drm/bridge/tda/Kconfig b/drivers/gpu/drm/bridge/tda/Kconfig
new file mode 100644
index 0000000000000000000000000000000000000000..5f13e4ffc24eeaa8dd0015c7e84d0dbac93e170c
--- /dev/null
+++ b/drivers/gpu/drm/bridge/tda/Kconfig
@@ -0,0 +1,13 @@
+# SPDX-License-Identifier: GPL-2.0-only
+config DRM_I2C_NXP_TDA998X
+	tristate "NXP Semiconductors TDA998X HDMI encoder"
+	default m if DRM_TILCDC
+	select CEC_CORE if CEC_NOTIFIER
+	select SND_SOC_HDMI_CODEC if SND_SOC
+	help
+	  Support for NXP Semiconductors TDA998X HDMI encoders.
+
+config DRM_I2C_NXP_TDA9950
+	tristate "NXP Semiconductors TDA9950/TDA998X HDMI CEC"
+	select CEC_NOTIFIER
+	select CEC_CORE
diff --git a/drivers/gpu/drm/bridge/tda/Makefile b/drivers/gpu/drm/bridge/tda/Makefile
new file mode 100644
index 0000000000000000000000000000000000000000..31fd35527d99d7eb23851d290175a3ff0c756772
--- /dev/null
+++ b/drivers/gpu/drm/bridge/tda/Makefile
@@ -0,0 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
+tda998x-y := tda998x_drv.o
+obj-$(CONFIG_DRM_I2C_NXP_TDA998X) += tda998x.o
+obj-$(CONFIG_DRM_I2C_NXP_TDA9950) += tda9950.o
diff --git a/drivers/gpu/drm/i2c/tda9950.c b/drivers/gpu/drm/bridge/tda/tda9950.c
similarity index 100%
rename from drivers/gpu/drm/i2c/tda9950.c
rename to drivers/gpu/drm/bridge/tda/tda9950.c
diff --git a/drivers/gpu/drm/i2c/tda998x_drv.c b/drivers/gpu/drm/bridge/tda/tda998x_drv.c
similarity index 100%
rename from drivers/gpu/drm/i2c/tda998x_drv.c
rename to drivers/gpu/drm/bridge/tda/tda998x_drv.c
diff --git a/drivers/gpu/drm/i2c/Kconfig b/drivers/gpu/drm/i2c/Kconfig
index 6f19e1c35e30b0e595c1a60628a6b8cf313fcabc..3205cdb827b95209a4bba9fb126ad2df27ddbdfb 100644
--- a/drivers/gpu/drm/i2c/Kconfig
+++ b/drivers/gpu/drm/i2c/Kconfig
@@ -20,17 +20,4 @@ config DRM_I2C_SIL164
 	  when used in pairs) TMDS transmitters, used in some nVidia
 	  video cards.
 
-config DRM_I2C_NXP_TDA998X
-	tristate "NXP Semiconductors TDA998X HDMI encoder"
-	default m if DRM_TILCDC
-	select CEC_CORE if CEC_NOTIFIER
-	select SND_SOC_HDMI_CODEC if SND_SOC
-	help
-	  Support for NXP Semiconductors TDA998X HDMI encoders.
-
-config DRM_I2C_NXP_TDA9950
-	tristate "NXP Semiconductors TDA9950/TDA998X HDMI CEC"
-	select CEC_NOTIFIER
-	select CEC_CORE
-
 endmenu
diff --git a/drivers/gpu/drm/i2c/Makefile b/drivers/gpu/drm/i2c/Makefile
index a962f6f085686674ed33010345730db776815ebe..1df3869491e277ca210368c4e48efe6d11af62b6 100644
--- a/drivers/gpu/drm/i2c/Makefile
+++ b/drivers/gpu/drm/i2c/Makefile
@@ -4,7 +4,3 @@ obj-$(CONFIG_DRM_I2C_CH7006) += ch7006.o
 
 sil164-y := sil164_drv.o
 obj-$(CONFIG_DRM_I2C_SIL164) += sil164.o
-
-tda998x-y := tda998x_drv.o
-obj-$(CONFIG_DRM_I2C_NXP_TDA998X) += tda998x.o
-obj-$(CONFIG_DRM_I2C_NXP_TDA9950) += tda9950.o

-- 
2.39.5


