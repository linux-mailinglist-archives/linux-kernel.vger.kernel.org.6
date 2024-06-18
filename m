Return-Path: <linux-kernel+bounces-218404-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 03EDD90BF4D
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 00:52:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 439BF1F2305F
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 22:52:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FFB619AA6C;
	Mon, 17 Jun 2024 22:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fP07davX"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D968A19AA40;
	Mon, 17 Jun 2024 22:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718664705; cv=none; b=BmyJV4FGPgmG3Y5bfaUm0LDvbN3rawXGDOQT66+tcmb+UAm+l0PunE4t+31FEUI07EoRZctZXld+yujxWmuV6TMhl1P47FAGZYPBf8KD1zZgz0jmk0VSxECIYapzmpsPlVv7UKCAmPXjsKoGxdk/ENgoUPvXTy/6n4DTS0tBvQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718664705; c=relaxed/simple;
	bh=eOscFJDkYp6ji+iozo4FujpQSbyF3comUesVVXuL7sM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=If5NFwUc5dmbrh2Td6eKM3wYOEbyjvf/O8eLlNtxgH6lAga09sgh1ZvoL7ihfJstQo3gI0IbYUM7duW/uCRowVGjyChZOyWsGlNRcYo6ClYMdY+ETmWlatPEsq42jW1qjRbG1hZlHSE4OWEFsLCB7SXhytQX8/IQY/UcARxX/ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fP07davX; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1f6f1677b26so34390365ad.0;
        Mon, 17 Jun 2024 15:51:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718664702; x=1719269502; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BwH4AlxWU0DzShNSkr0qXjDZ/YbYRwvAI41qs9exkfA=;
        b=fP07davXaMPBPBzK5dsqBLUj0Xat5Byg9hPXKhdBhONJIweRPuB5VTNPmvx+9eAATB
         vWvrxU0V7/oUKEyTZdeBCMd17KedfaMzIpJmOJESngn9JLHC+wRRG3zIUPWp61XxLp7X
         hN08da2LCduH85HimUP3TpePUYklk+gN2c6IItgQRDo1tTlcYNjgnNpVq0r3s4Mjp613
         T72X1YOPLO9oAecO6hhf5xkwSNBRDqMC4EethP42yTqYm0bw6SvbAlsmOFwuZUggic1V
         ShXuQV92nNiiG7+dsoX+Jq0b/gF6OEMwksuijYFun9YT4yfVlIdnY0Ps4gn0ehUMUbfR
         skjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718664702; x=1719269502;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BwH4AlxWU0DzShNSkr0qXjDZ/YbYRwvAI41qs9exkfA=;
        b=Q/oa7LSpXe3GIzuojvTzXrG81q4zSJ/Ocq/cz1bq0hNfc++SI0RPA3tGvTLswPtqOC
         dHSzHCRPpTRirDd8fiPYF23n3cwL4LIwHLPfjiBjeJcc4uORnLIRwynoC8/yEdLPVuX9
         j3lwnybRu/2pYuK7QK9ysJjYd7tKoxV90ZHuWRMfZlVX/R3JvZ20KWyldN1P1zENkeq1
         Ir5JNvVB8Z2v42liWhPIHWfww3y1rMOWwNGPxAYPgxxvQisTuMLqaNawXIadlu/08M9j
         DADoEOtnbYylnJC4844K+/m8XWoFwU2tvwBOZtnyD4miedaBj6jP5tzJBMCxJ3QsL2Z1
         /JRw==
X-Forwarded-Encrypted: i=1; AJvYcCXSm1+NPYEWURKUdlCjPn4myTUzH9GnUV37kDIx7iVLPCQd3VmAuoZrit6AFwGIGmriKKEI5yCjHeCbkfGg/redj9oqqjSEObryXLNz
X-Gm-Message-State: AOJu0Yx4zT9k9aMtJU4J9anPJokBNnHRG5tfxMpggA9M08L7fFwkkCUu
	gIhQlfCys9yoNSjf3nsBATodRpFFoBi9yghQ9lqbZaT09rwktohsBsaMtw==
X-Google-Smtp-Source: AGHT+IEs4KLZ28XfZMkzv6qWkT8ADJ85sSntXtp2JjEZZZ7cNiDJ+mGh+mAktclrn2b7QbmOYMAarg==
X-Received: by 2002:a17:903:2443:b0:1f7:1d71:25aa with SMTP id d9443c01a7336-1f98b213273mr14840665ad.6.1718664701774;
        Mon, 17 Jun 2024 15:51:41 -0700 (PDT)
Received: from localhost (c-73-37-105-206.hsd1.or.comcast.net. [73.37.105.206])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f855f1b13bsm84288025ad.245.2024.06.17.15.51.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jun 2024 15:51:41 -0700 (PDT)
From: Rob Clark <robdclark@gmail.com>
To: dri-devel@lists.freedesktop.org
Cc: linux-arm-msm@vger.kernel.org,
	freedreno@lists.freedesktop.org,
	Rob Clark <robdclark@chromium.org>,
	Rob Clark <robdclark@gmail.com>,
	Abhinav Kumar <quic_abhinavk@quicinc.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Sean Paul <sean@poorly.run>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3 2/5] drm/msm/adreno: Split catalog into separate files
Date: Mon, 17 Jun 2024 15:51:12 -0700
Message-ID: <20240617225127.23476-3-robdclark@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240617225127.23476-1-robdclark@gmail.com>
References: <20240617225127.23476-1-robdclark@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Rob Clark <robdclark@chromium.org>

Split each gen's gpu table into it's own file.  Only code-motion, no
functional change.

Signed-off-by: Rob Clark <robdclark@chromium.org>
---
 drivers/gpu/drm/msm/Makefile               |   5 +
 drivers/gpu/drm/msm/adreno/a2xx_catalog.c  |  52 ++
 drivers/gpu/drm/msm/adreno/a3xx_catalog.c  |  81 +++
 drivers/gpu/drm/msm/adreno/a4xx_catalog.c  |  50 ++
 drivers/gpu/drm/msm/adreno/a5xx_catalog.c  | 148 +++++
 drivers/gpu/drm/msm/adreno/a6xx_catalog.c  | 338 +++++++++++
 drivers/gpu/drm/msm/adreno/adreno_device.c | 625 +--------------------
 7 files changed, 680 insertions(+), 619 deletions(-)
 create mode 100644 drivers/gpu/drm/msm/adreno/a2xx_catalog.c
 create mode 100644 drivers/gpu/drm/msm/adreno/a3xx_catalog.c
 create mode 100644 drivers/gpu/drm/msm/adreno/a4xx_catalog.c
 create mode 100644 drivers/gpu/drm/msm/adreno/a5xx_catalog.c
 create mode 100644 drivers/gpu/drm/msm/adreno/a6xx_catalog.c

diff --git a/drivers/gpu/drm/msm/Makefile b/drivers/gpu/drm/msm/Makefile
index eb788921ff4f..f5e2838c6a76 100644
--- a/drivers/gpu/drm/msm/Makefile
+++ b/drivers/gpu/drm/msm/Makefile
@@ -8,13 +8,18 @@ ccflags-$(CONFIG_DRM_MSM_DP) += -I $(src)/dp
 adreno-y := \
 	adreno/adreno_device.o \
 	adreno/adreno_gpu.o \
+	adreno/a2xx_catalog.o \
 	adreno/a2xx_gpu.o \
 	adreno/a2xx_gpummu.o \
+	adreno/a3xx_catalog.o \
 	adreno/a3xx_gpu.o \
+	adreno/a4xx_catalog.o \
 	adreno/a4xx_gpu.o \
+	adreno/a5xx_catalog.o \
 	adreno/a5xx_gpu.o \
 	adreno/a5xx_power.o \
 	adreno/a5xx_preempt.o \
+	adreno/a6xx_catalog.o \
 	adreno/a6xx_gpu.o \
 	adreno/a6xx_gmu.o \
 	adreno/a6xx_hfi.o \
diff --git a/drivers/gpu/drm/msm/adreno/a2xx_catalog.c b/drivers/gpu/drm/msm/adreno/a2xx_catalog.c
new file mode 100644
index 000000000000..9ddb7b31fd98
--- /dev/null
+++ b/drivers/gpu/drm/msm/adreno/a2xx_catalog.c
@@ -0,0 +1,52 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2013-2014 Red Hat
+ * Author: Rob Clark <robdclark@gmail.com>
+ *
+ * Copyright (c) 2014,2017 The Linux Foundation. All rights reserved.
+ */
+
+#include "adreno_gpu.h"
+
+static const struct adreno_info a2xx_gpus[] = {
+	{
+		.chip_ids = ADRENO_CHIP_IDS(0x02000000),
+		.family = ADRENO_2XX_GEN1,
+		.revn  = 200,
+		.fw = {
+			[ADRENO_FW_PM4] = "yamato_pm4.fw",
+			[ADRENO_FW_PFP] = "yamato_pfp.fw",
+		},
+		.gmem  = SZ_256K,
+		.inactive_period = DRM_MSM_INACTIVE_PERIOD,
+		.init  = a2xx_gpu_init,
+	}, { /* a200 on i.mx51 has only 128kib gmem */
+		.chip_ids = ADRENO_CHIP_IDS(0x02000001),
+		.family = ADRENO_2XX_GEN1,
+		.revn  = 201,
+		.fw = {
+			[ADRENO_FW_PM4] = "yamato_pm4.fw",
+			[ADRENO_FW_PFP] = "yamato_pfp.fw",
+		},
+		.gmem  = SZ_128K,
+		.inactive_period = DRM_MSM_INACTIVE_PERIOD,
+		.init  = a2xx_gpu_init,
+	}, {
+		.chip_ids = ADRENO_CHIP_IDS(0x02020000),
+		.family = ADRENO_2XX_GEN2,
+		.revn  = 220,
+		.fw = {
+			[ADRENO_FW_PM4] = "leia_pm4_470.fw",
+			[ADRENO_FW_PFP] = "leia_pfp_470.fw",
+		},
+		.gmem  = SZ_512K,
+		.inactive_period = DRM_MSM_INACTIVE_PERIOD,
+		.init  = a2xx_gpu_init,
+	}
+};
+DECLARE_ADRENO_GPULIST(a2xx);
+
+MODULE_FIRMWARE("qcom/leia_pfp_470.fw");
+MODULE_FIRMWARE("qcom/leia_pm4_470.fw");
+MODULE_FIRMWARE("qcom/yamato_pfp.fw");
+MODULE_FIRMWARE("qcom/yamato_pm4.fw");
diff --git a/drivers/gpu/drm/msm/adreno/a3xx_catalog.c b/drivers/gpu/drm/msm/adreno/a3xx_catalog.c
new file mode 100644
index 000000000000..0de8465b6cf0
--- /dev/null
+++ b/drivers/gpu/drm/msm/adreno/a3xx_catalog.c
@@ -0,0 +1,81 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2013-2014 Red Hat
+ * Author: Rob Clark <robdclark@gmail.com>
+ *
+ * Copyright (c) 2014,2017 The Linux Foundation. All rights reserved.
+ */
+
+#include "adreno_gpu.h"
+
+static const struct adreno_info a3xx_gpus[] = {
+	{
+		.chip_ids = ADRENO_CHIP_IDS(0x03000512),
+		.family = ADRENO_3XX,
+		.fw = {
+			[ADRENO_FW_PM4] = "a330_pm4.fw",
+			[ADRENO_FW_PFP] = "a330_pfp.fw",
+		},
+		.gmem  = SZ_128K,
+		.inactive_period = DRM_MSM_INACTIVE_PERIOD,
+		.init  = a3xx_gpu_init,
+	}, {
+		.chip_ids = ADRENO_CHIP_IDS(0x03000520),
+		.family = ADRENO_3XX,
+		.revn  = 305,
+		.fw = {
+			[ADRENO_FW_PM4] = "a300_pm4.fw",
+			[ADRENO_FW_PFP] = "a300_pfp.fw",
+		},
+		.gmem  = SZ_256K,
+		.inactive_period = DRM_MSM_INACTIVE_PERIOD,
+		.init  = a3xx_gpu_init,
+	}, {
+		.chip_ids = ADRENO_CHIP_IDS(0x03000600),
+		.family = ADRENO_3XX,
+		.revn  = 307,        /* because a305c is revn==306 */
+		.fw = {
+			[ADRENO_FW_PM4] = "a300_pm4.fw",
+			[ADRENO_FW_PFP] = "a300_pfp.fw",
+		},
+		.gmem  = SZ_128K,
+		.inactive_period = DRM_MSM_INACTIVE_PERIOD,
+		.init  = a3xx_gpu_init,
+	}, {
+		.chip_ids = ADRENO_CHIP_IDS(
+			0x03020000,
+			0x03020001,
+			0x03020002
+		),
+		.family = ADRENO_3XX,
+		.revn  = 320,
+		.fw = {
+			[ADRENO_FW_PM4] = "a300_pm4.fw",
+			[ADRENO_FW_PFP] = "a300_pfp.fw",
+		},
+		.gmem  = SZ_512K,
+		.inactive_period = DRM_MSM_INACTIVE_PERIOD,
+		.init  = a3xx_gpu_init,
+	}, {
+		.chip_ids = ADRENO_CHIP_IDS(
+			0x03030000,
+			0x03030001,
+			0x03030002
+		),
+		.family = ADRENO_3XX,
+		.revn  = 330,
+		.fw = {
+			[ADRENO_FW_PM4] = "a330_pm4.fw",
+			[ADRENO_FW_PFP] = "a330_pfp.fw",
+		},
+		.gmem  = SZ_1M,
+		.inactive_period = DRM_MSM_INACTIVE_PERIOD,
+		.init  = a3xx_gpu_init,
+	}
+};
+DECLARE_ADRENO_GPULIST(a3xx);
+
+MODULE_FIRMWARE("qcom/a300_pm4.fw");
+MODULE_FIRMWARE("qcom/a300_pfp.fw");
+MODULE_FIRMWARE("qcom/a330_pm4.fw");
+MODULE_FIRMWARE("qcom/a330_pfp.fw");
diff --git a/drivers/gpu/drm/msm/adreno/a4xx_catalog.c b/drivers/gpu/drm/msm/adreno/a4xx_catalog.c
new file mode 100644
index 000000000000..93519f807f87
--- /dev/null
+++ b/drivers/gpu/drm/msm/adreno/a4xx_catalog.c
@@ -0,0 +1,50 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2013-2014 Red Hat
+ * Author: Rob Clark <robdclark@gmail.com>
+ *
+ * Copyright (c) 2014,2017 The Linux Foundation. All rights reserved.
+ */
+
+#include "adreno_gpu.h"
+
+static const struct adreno_info a4xx_gpus[] = {
+	{
+		.chip_ids = ADRENO_CHIP_IDS(0x04000500),
+		.family = ADRENO_4XX,
+		.revn  = 405,
+		.fw = {
+			[ADRENO_FW_PM4] = "a420_pm4.fw",
+			[ADRENO_FW_PFP] = "a420_pfp.fw",
+		},
+		.gmem  = SZ_256K,
+		.inactive_period = DRM_MSM_INACTIVE_PERIOD,
+		.init  = a4xx_gpu_init,
+	}, {
+		.chip_ids = ADRENO_CHIP_IDS(0x04020000),
+		.family = ADRENO_4XX,
+		.revn  = 420,
+		.fw = {
+			[ADRENO_FW_PM4] = "a420_pm4.fw",
+			[ADRENO_FW_PFP] = "a420_pfp.fw",
+		},
+		.gmem  = (SZ_1M + SZ_512K),
+		.inactive_period = DRM_MSM_INACTIVE_PERIOD,
+		.init  = a4xx_gpu_init,
+	}, {
+		.chip_ids = ADRENO_CHIP_IDS(0x04030002),
+		.family = ADRENO_4XX,
+		.revn  = 430,
+		.fw = {
+			[ADRENO_FW_PM4] = "a420_pm4.fw",
+			[ADRENO_FW_PFP] = "a420_pfp.fw",
+		},
+		.gmem  = (SZ_1M + SZ_512K),
+		.inactive_period = DRM_MSM_INACTIVE_PERIOD,
+		.init  = a4xx_gpu_init,
+	}
+};
+DECLARE_ADRENO_GPULIST(a4xx);
+
+MODULE_FIRMWARE("qcom/a420_pm4.fw");
+MODULE_FIRMWARE("qcom/a420_pfp.fw");
diff --git a/drivers/gpu/drm/msm/adreno/a5xx_catalog.c b/drivers/gpu/drm/msm/adreno/a5xx_catalog.c
new file mode 100644
index 000000000000..455a953dee67
--- /dev/null
+++ b/drivers/gpu/drm/msm/adreno/a5xx_catalog.c
@@ -0,0 +1,148 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2013-2014 Red Hat
+ * Author: Rob Clark <robdclark@gmail.com>
+ *
+ * Copyright (c) 2014,2017 The Linux Foundation. All rights reserved.
+ */
+
+#include "adreno_gpu.h"
+
+static const struct adreno_info a5xx_gpus[] = {
+	{
+		.chip_ids = ADRENO_CHIP_IDS(0x05000600),
+		.family = ADRENO_5XX,
+		.revn = 506,
+		.fw = {
+			[ADRENO_FW_PM4] = "a530_pm4.fw",
+			[ADRENO_FW_PFP] = "a530_pfp.fw",
+		},
+		.gmem = (SZ_128K + SZ_8K),
+		/*
+		 * Increase inactive period to 250 to avoid bouncing
+		 * the GDSC which appears to make it grumpy
+		 */
+		.inactive_period = 250,
+		.quirks = ADRENO_QUIRK_TWO_PASS_USE_WFI |
+			  ADRENO_QUIRK_LMLOADKILL_DISABLE,
+		.init = a5xx_gpu_init,
+		.zapfw = "a506_zap.mdt",
+	}, {
+		.chip_ids = ADRENO_CHIP_IDS(0x05000800),
+		.family = ADRENO_5XX,
+		.revn = 508,
+		.fw = {
+			[ADRENO_FW_PM4] = "a530_pm4.fw",
+			[ADRENO_FW_PFP] = "a530_pfp.fw",
+		},
+		.gmem = (SZ_128K + SZ_8K),
+		/*
+		 * Increase inactive period to 250 to avoid bouncing
+		 * the GDSC which appears to make it grumpy
+		 */
+		.inactive_period = 250,
+		.quirks = ADRENO_QUIRK_LMLOADKILL_DISABLE,
+		.init = a5xx_gpu_init,
+		.zapfw = "a508_zap.mdt",
+	}, {
+		.chip_ids = ADRENO_CHIP_IDS(0x05000900),
+		.family = ADRENO_5XX,
+		.revn = 509,
+		.fw = {
+			[ADRENO_FW_PM4] = "a530_pm4.fw",
+			[ADRENO_FW_PFP] = "a530_pfp.fw",
+		},
+		.gmem = (SZ_256K + SZ_16K),
+		/*
+		 * Increase inactive period to 250 to avoid bouncing
+		 * the GDSC which appears to make it grumpy
+		 */
+		.inactive_period = 250,
+		.quirks = ADRENO_QUIRK_LMLOADKILL_DISABLE,
+		.init = a5xx_gpu_init,
+		/* Adreno 509 uses the same ZAP as 512 */
+		.zapfw = "a512_zap.mdt",
+	}, {
+		.chip_ids = ADRENO_CHIP_IDS(0x05010000),
+		.family = ADRENO_5XX,
+		.revn = 510,
+		.fw = {
+			[ADRENO_FW_PM4] = "a530_pm4.fw",
+			[ADRENO_FW_PFP] = "a530_pfp.fw",
+		},
+		.gmem = SZ_256K,
+		/*
+		 * Increase inactive period to 250 to avoid bouncing
+		 * the GDSC which appears to make it grumpy
+		 */
+		.inactive_period = 250,
+		.init = a5xx_gpu_init,
+	}, {
+		.chip_ids = ADRENO_CHIP_IDS(0x05010200),
+		.family = ADRENO_5XX,
+		.revn = 512,
+		.fw = {
+			[ADRENO_FW_PM4] = "a530_pm4.fw",
+			[ADRENO_FW_PFP] = "a530_pfp.fw",
+		},
+		.gmem = (SZ_256K + SZ_16K),
+		/*
+		 * Increase inactive period to 250 to avoid bouncing
+		 * the GDSC which appears to make it grumpy
+		 */
+		.inactive_period = 250,
+		.quirks = ADRENO_QUIRK_LMLOADKILL_DISABLE,
+		.init = a5xx_gpu_init,
+		.zapfw = "a512_zap.mdt",
+	}, {
+		.chip_ids = ADRENO_CHIP_IDS(
+			0x05030002,
+			0x05030004
+		),
+		.family = ADRENO_5XX,
+		.revn = 530,
+		.fw = {
+			[ADRENO_FW_PM4] = "a530_pm4.fw",
+			[ADRENO_FW_PFP] = "a530_pfp.fw",
+			[ADRENO_FW_GPMU] = "a530v3_gpmu.fw2",
+		},
+		.gmem = SZ_1M,
+		/*
+		 * Increase inactive period to 250 to avoid bouncing
+		 * the GDSC which appears to make it grumpy
+		 */
+		.inactive_period = 250,
+		.quirks = ADRENO_QUIRK_TWO_PASS_USE_WFI |
+			ADRENO_QUIRK_FAULT_DETECT_MASK,
+		.init = a5xx_gpu_init,
+		.zapfw = "a530_zap.mdt",
+	}, {
+		.chip_ids = ADRENO_CHIP_IDS(0x05040001),
+		.family = ADRENO_5XX,
+		.revn = 540,
+		.fw = {
+			[ADRENO_FW_PM4] = "a530_pm4.fw",
+			[ADRENO_FW_PFP] = "a530_pfp.fw",
+			[ADRENO_FW_GPMU] = "a540_gpmu.fw2",
+		},
+		.gmem = SZ_1M,
+		/*
+		 * Increase inactive period to 250 to avoid bouncing
+		 * the GDSC which appears to make it grumpy
+		 */
+		.inactive_period = 250,
+		.quirks = ADRENO_QUIRK_LMLOADKILL_DISABLE,
+		.init = a5xx_gpu_init,
+		.zapfw = "a540_zap.mdt",
+	}
+};
+DECLARE_ADRENO_GPULIST(a5xx);
+
+MODULE_FIRMWARE("qcom/a530_pm4.fw");
+MODULE_FIRMWARE("qcom/a530_pfp.fw");
+MODULE_FIRMWARE("qcom/a530v3_gpmu.fw2");
+MODULE_FIRMWARE("qcom/a530_zap.mdt");
+MODULE_FIRMWARE("qcom/a530_zap.b00");
+MODULE_FIRMWARE("qcom/a530_zap.b01");
+MODULE_FIRMWARE("qcom/a530_zap.b02");
+MODULE_FIRMWARE("qcom/a540_gpmu.fw2");
diff --git a/drivers/gpu/drm/msm/adreno/a6xx_catalog.c b/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
new file mode 100644
index 000000000000..10a92eab0232
--- /dev/null
+++ b/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
@@ -0,0 +1,338 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2013-2014 Red Hat
+ * Author: Rob Clark <robdclark@gmail.com>
+ *
+ * Copyright (c) 2014,2017 The Linux Foundation. All rights reserved.
+ */
+
+#include "adreno_gpu.h"
+
+static const struct adreno_info a6xx_gpus[] = {
+	{
+		.chip_ids = ADRENO_CHIP_IDS(0x06010000),
+		.family = ADRENO_6XX_GEN1,
+		.revn = 610,
+		.fw = {
+			[ADRENO_FW_SQE] = "a630_sqe.fw",
+		},
+		.gmem = (SZ_128K + SZ_4K),
+		.inactive_period = DRM_MSM_INACTIVE_PERIOD,
+		.init = a6xx_gpu_init,
+		.zapfw = "a610_zap.mdt",
+		.hwcg = a612_hwcg,
+		/*
+		 * There are (at least) three SoCs implementing A610: SM6125
+		 * (trinket), SM6115 (bengal) and SM6225 (khaje). Trinket does
+		 * not have speedbinning, as only a single SKU exists and we
+		 * don't support khaje upstream yet.  Hence, this matching
+		 * table is only valid for bengal.
+		 */
+		.speedbins = ADRENO_SPEEDBINS(
+			{ 0,   0 },
+			{ 206, 1 },
+			{ 200, 2 },
+			{ 157, 3 },
+			{ 127, 4 },
+		),
+	}, {
+		.machine = "qcom,sm7150",
+		.chip_ids = ADRENO_CHIP_IDS(0x06010800),
+		.family = ADRENO_6XX_GEN1,
+		.fw = {
+			[ADRENO_FW_SQE] = "a630_sqe.fw",
+			[ADRENO_FW_GMU] = "a630_gmu.bin",
+		},
+		.gmem = SZ_512K,
+		.inactive_period = DRM_MSM_INACTIVE_PERIOD,
+		.quirks = ADRENO_QUIRK_HAS_CACHED_COHERENT,
+		.init = a6xx_gpu_init,
+		.zapfw = "a615_zap.mbn",
+		.hwcg = a615_hwcg,
+		.speedbins = ADRENO_SPEEDBINS(
+			{ 0,   0 },
+			{ 128, 1 },
+			{ 146, 2 },
+			{ 167, 3 },
+			{ 172, 4 },
+		),
+	}, {
+		.chip_ids = ADRENO_CHIP_IDS(0x06010800),
+		.family = ADRENO_6XX_GEN1,
+		.revn = 618,
+		.fw = {
+			[ADRENO_FW_SQE] = "a630_sqe.fw",
+			[ADRENO_FW_GMU] = "a630_gmu.bin",
+		},
+		.gmem = SZ_512K,
+		.inactive_period = DRM_MSM_INACTIVE_PERIOD,
+		.quirks = ADRENO_QUIRK_HAS_CACHED_COHERENT,
+		.init = a6xx_gpu_init,
+		.speedbins = ADRENO_SPEEDBINS(
+			{ 0,   0 },
+			{ 169, 1 },
+			{ 174, 2 },
+		),
+	}, {
+		.machine = "qcom,sm4350",
+		.chip_ids = ADRENO_CHIP_IDS(0x06010900),
+		.family = ADRENO_6XX_GEN1,
+		.revn = 619,
+		.fw = {
+			[ADRENO_FW_SQE] = "a630_sqe.fw",
+			[ADRENO_FW_GMU] = "a619_gmu.bin",
+		},
+		.gmem = SZ_512K,
+		.inactive_period = DRM_MSM_INACTIVE_PERIOD,
+		.init = a6xx_gpu_init,
+		.zapfw = "a615_zap.mdt",
+		.hwcg = a615_hwcg,
+		.speedbins = ADRENO_SPEEDBINS(
+			{ 0,   0 },
+			{ 138, 1 },
+			{ 92,  2 },
+		),
+	}, {
+		.machine = "qcom,sm6375",
+		.chip_ids = ADRENO_CHIP_IDS(0x06010901),
+		.family = ADRENO_6XX_GEN1,
+		.revn = 619,
+		.fw = {
+			[ADRENO_FW_SQE] = "a630_sqe.fw",
+			[ADRENO_FW_GMU] = "a619_gmu.bin",
+		},
+		.gmem = SZ_512K,
+		.inactive_period = DRM_MSM_INACTIVE_PERIOD,
+		.init = a6xx_gpu_init,
+		.zapfw = "a615_zap.mdt",
+		.hwcg = a615_hwcg,
+		.speedbins = ADRENO_SPEEDBINS(
+			{ 0,   0 },
+			{ 190, 1 },
+			{ 177, 2 },
+		),
+	}, {
+		.chip_ids = ADRENO_CHIP_IDS(0x06010900),
+		.family = ADRENO_6XX_GEN1,
+		.revn = 619,
+		.fw = {
+			[ADRENO_FW_SQE] = "a630_sqe.fw",
+			[ADRENO_FW_GMU] = "a619_gmu.bin",
+		},
+		.gmem = SZ_512K,
+		.inactive_period = DRM_MSM_INACTIVE_PERIOD,
+		.quirks = ADRENO_QUIRK_HAS_CACHED_COHERENT,
+		.init = a6xx_gpu_init,
+		.zapfw = "a615_zap.mdt",
+		.hwcg = a615_hwcg,
+		.speedbins = ADRENO_SPEEDBINS(
+			{ 0,   0 },
+			{ 120, 4 },
+			{ 138, 3 },
+			{ 169, 2 },
+			{ 180, 1 },
+		),
+	}, {
+		.chip_ids = ADRENO_CHIP_IDS(
+			0x06030001,
+			0x06030002
+		),
+		.family = ADRENO_6XX_GEN1,
+		.revn = 630,
+		.fw = {
+			[ADRENO_FW_SQE] = "a630_sqe.fw",
+			[ADRENO_FW_GMU] = "a630_gmu.bin",
+		},
+		.gmem = SZ_1M,
+		.inactive_period = DRM_MSM_INACTIVE_PERIOD,
+		.quirks = ADRENO_QUIRK_HAS_CACHED_COHERENT,
+		.init = a6xx_gpu_init,
+		.zapfw = "a630_zap.mdt",
+		.hwcg = a630_hwcg,
+	}, {
+		.chip_ids = ADRENO_CHIP_IDS(0x06040001),
+		.family = ADRENO_6XX_GEN2,
+		.revn = 640,
+		.fw = {
+			[ADRENO_FW_SQE] = "a630_sqe.fw",
+			[ADRENO_FW_GMU] = "a640_gmu.bin",
+		},
+		.gmem = SZ_1M,
+		.inactive_period = DRM_MSM_INACTIVE_PERIOD,
+		.quirks = ADRENO_QUIRK_HAS_CACHED_COHERENT,
+		.init = a6xx_gpu_init,
+		.zapfw = "a640_zap.mdt",
+		.hwcg = a640_hwcg,
+		.speedbins = ADRENO_SPEEDBINS(
+			{ 0, 0 },
+			{ 1, 1 },
+		),
+	}, {
+		.chip_ids = ADRENO_CHIP_IDS(0x06050002),
+		.family = ADRENO_6XX_GEN3,
+		.revn = 650,
+		.fw = {
+			[ADRENO_FW_SQE] = "a650_sqe.fw",
+			[ADRENO_FW_GMU] = "a650_gmu.bin",
+		},
+		.gmem = SZ_1M + SZ_128K,
+		.inactive_period = DRM_MSM_INACTIVE_PERIOD,
+		.quirks = ADRENO_QUIRK_HAS_CACHED_COHERENT |
+			ADRENO_QUIRK_HAS_HW_APRIV,
+		.init = a6xx_gpu_init,
+		.zapfw = "a650_zap.mdt",
+		.hwcg = a650_hwcg,
+		.address_space_size = SZ_16G,
+		.speedbins = ADRENO_SPEEDBINS(
+			{ 0, 0 },
+			{ 1, 1 },
+			{ 2, 3 }, /* Yep, 2 and 3 are swapped! :/ */
+			{ 3, 2 },
+		),
+	}, {
+		.chip_ids = ADRENO_CHIP_IDS(0x06060001),
+		.family = ADRENO_6XX_GEN4,
+		.revn = 660,
+		.fw = {
+			[ADRENO_FW_SQE] = "a660_sqe.fw",
+			[ADRENO_FW_GMU] = "a660_gmu.bin",
+		},
+		.gmem = SZ_1M + SZ_512K,
+		.inactive_period = DRM_MSM_INACTIVE_PERIOD,
+		.quirks = ADRENO_QUIRK_HAS_CACHED_COHERENT |
+			ADRENO_QUIRK_HAS_HW_APRIV,
+		.init = a6xx_gpu_init,
+		.zapfw = "a660_zap.mdt",
+		.hwcg = a660_hwcg,
+		.address_space_size = SZ_16G,
+	}, {
+		.chip_ids = ADRENO_CHIP_IDS(0x06030500),
+		.family = ADRENO_6XX_GEN4,
+		.fw = {
+			[ADRENO_FW_SQE] = "a660_sqe.fw",
+			[ADRENO_FW_GMU] = "a660_gmu.bin",
+		},
+		.gmem = SZ_512K,
+		.inactive_period = DRM_MSM_INACTIVE_PERIOD,
+		.quirks = ADRENO_QUIRK_HAS_CACHED_COHERENT |
+			ADRENO_QUIRK_HAS_HW_APRIV,
+		.init = a6xx_gpu_init,
+		.zapfw = "a660_zap.mbn",
+		.hwcg = a660_hwcg,
+		.address_space_size = SZ_16G,
+		.speedbins = ADRENO_SPEEDBINS(
+			{ 0,   0 },
+			{ 117, 0 },
+			{ 172, 2 }, /* Called speedbin 1 downstream, but let's not break things! */
+			{ 190, 1 },
+		),
+	}, {
+		.chip_ids = ADRENO_CHIP_IDS(0x06080001),
+		.family = ADRENO_6XX_GEN2,
+		.revn = 680,
+		.fw = {
+			[ADRENO_FW_SQE] = "a630_sqe.fw",
+			[ADRENO_FW_GMU] = "a640_gmu.bin",
+		},
+		.gmem = SZ_2M,
+		.inactive_period = DRM_MSM_INACTIVE_PERIOD,
+		.quirks = ADRENO_QUIRK_HAS_CACHED_COHERENT,
+		.init = a6xx_gpu_init,
+		.zapfw = "a640_zap.mdt",
+		.hwcg = a640_hwcg,
+	}, {
+		.chip_ids = ADRENO_CHIP_IDS(0x06090000),
+		.family = ADRENO_6XX_GEN4,
+		.fw = {
+			[ADRENO_FW_SQE] = "a660_sqe.fw",
+			[ADRENO_FW_GMU] = "a660_gmu.bin",
+		},
+		.gmem = SZ_4M,
+		.inactive_period = DRM_MSM_INACTIVE_PERIOD,
+		.quirks = ADRENO_QUIRK_HAS_CACHED_COHERENT |
+			ADRENO_QUIRK_HAS_HW_APRIV,
+		.init = a6xx_gpu_init,
+		.zapfw = "a690_zap.mdt",
+		.hwcg = a690_hwcg,
+		.address_space_size = SZ_16G,
+	}
+};
+DECLARE_ADRENO_GPULIST(a6xx);
+
+MODULE_FIRMWARE("qcom/a615_zap.mbn");
+MODULE_FIRMWARE("qcom/a619_gmu.bin");
+MODULE_FIRMWARE("qcom/a630_sqe.fw");
+MODULE_FIRMWARE("qcom/a630_gmu.bin");
+MODULE_FIRMWARE("qcom/a630_zap.mbn");
+MODULE_FIRMWARE("qcom/a640_gmu.bin");
+MODULE_FIRMWARE("qcom/a650_gmu.bin");
+MODULE_FIRMWARE("qcom/a650_sqe.fw");
+MODULE_FIRMWARE("qcom/a660_gmu.bin");
+MODULE_FIRMWARE("qcom/a660_sqe.fw");
+
+static const struct adreno_info a7xx_gpus[] = {
+	{
+		.chip_ids = ADRENO_CHIP_IDS(0x07000200),
+		.family = ADRENO_6XX_GEN1, /* NOT a mistake! */
+		.fw = {
+			[ADRENO_FW_SQE] = "a702_sqe.fw",
+		},
+		.gmem = SZ_128K,
+		.inactive_period = DRM_MSM_INACTIVE_PERIOD,
+		.quirks = ADRENO_QUIRK_HAS_HW_APRIV,
+		.init = a6xx_gpu_init,
+		.zapfw = "a702_zap.mbn",
+		.hwcg = a702_hwcg,
+		.speedbins = ADRENO_SPEEDBINS(
+			{ 0,   0 },
+			{ 236, 1 },
+			{ 178, 2 },
+			{ 142, 3 },
+		),
+	}, {
+		.chip_ids = ADRENO_CHIP_IDS(0x07030001),
+		.family = ADRENO_7XX_GEN1,
+		.fw = {
+			[ADRENO_FW_SQE] = "a730_sqe.fw",
+			[ADRENO_FW_GMU] = "gmu_gen70000.bin",
+		},
+		.gmem = SZ_2M,
+		.inactive_period = DRM_MSM_INACTIVE_PERIOD,
+		.quirks = ADRENO_QUIRK_HAS_CACHED_COHERENT |
+			  ADRENO_QUIRK_HAS_HW_APRIV,
+		.init = a6xx_gpu_init,
+		.zapfw = "a730_zap.mdt",
+		.hwcg = a730_hwcg,
+		.address_space_size = SZ_16G,
+	}, {
+		.chip_ids = ADRENO_CHIP_IDS(0x43050a01), /* "C510v2" */
+		.family = ADRENO_7XX_GEN2,
+		.fw = {
+			[ADRENO_FW_SQE] = "a740_sqe.fw",
+			[ADRENO_FW_GMU] = "gmu_gen70200.bin",
+		},
+		.gmem = 3 * SZ_1M,
+		.inactive_period = DRM_MSM_INACTIVE_PERIOD,
+		.quirks = ADRENO_QUIRK_HAS_CACHED_COHERENT |
+			  ADRENO_QUIRK_HAS_HW_APRIV,
+		.init = a6xx_gpu_init,
+		.zapfw = "a740_zap.mdt",
+		.hwcg = a740_hwcg,
+		.address_space_size = SZ_16G,
+	}, {
+		.chip_ids = ADRENO_CHIP_IDS(0x43051401), /* "C520v2" */
+		.family = ADRENO_7XX_GEN3,
+		.fw = {
+			[ADRENO_FW_SQE] = "gen70900_sqe.fw",
+			[ADRENO_FW_GMU] = "gmu_gen70900.bin",
+		},
+		.gmem = 3 * SZ_1M,
+		.inactive_period = DRM_MSM_INACTIVE_PERIOD,
+		.quirks = ADRENO_QUIRK_HAS_CACHED_COHERENT |
+			  ADRENO_QUIRK_HAS_HW_APRIV,
+		.init = a6xx_gpu_init,
+		.zapfw = "gen70900_zap.mbn",
+		.address_space_size = SZ_16G,
+	}
+};
+DECLARE_ADRENO_GPULIST(a7xx);
diff --git a/drivers/gpu/drm/msm/adreno/adreno_device.c b/drivers/gpu/drm/msm/adreno/adreno_device.c
index a57659eaddc2..1e789ff6945e 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_device.c
+++ b/drivers/gpu/drm/msm/adreno/adreno_device.c
@@ -20,596 +20,12 @@ bool allow_vram_carveout = false;
 MODULE_PARM_DESC(allow_vram_carveout, "Allow using VRAM Carveout, in place of IOMMU");
 module_param_named(allow_vram_carveout, allow_vram_carveout, bool, 0600);
 
-static const struct adreno_info a2xx_gpus[] = {
-	{
-		.chip_ids = ADRENO_CHIP_IDS(0x02000000),
-		.family = ADRENO_2XX_GEN1,
-		.revn  = 200,
-		.fw = {
-			[ADRENO_FW_PM4] = "yamato_pm4.fw",
-			[ADRENO_FW_PFP] = "yamato_pfp.fw",
-		},
-		.gmem  = SZ_256K,
-		.inactive_period = DRM_MSM_INACTIVE_PERIOD,
-		.init  = a2xx_gpu_init,
-	}, { /* a200 on i.mx51 has only 128kib gmem */
-		.chip_ids = ADRENO_CHIP_IDS(0x02000001),
-		.family = ADRENO_2XX_GEN1,
-		.revn  = 201,
-		.fw = {
-			[ADRENO_FW_PM4] = "yamato_pm4.fw",
-			[ADRENO_FW_PFP] = "yamato_pfp.fw",
-		},
-		.gmem  = SZ_128K,
-		.inactive_period = DRM_MSM_INACTIVE_PERIOD,
-		.init  = a2xx_gpu_init,
-	}, {
-		.chip_ids = ADRENO_CHIP_IDS(0x02020000),
-		.family = ADRENO_2XX_GEN2,
-		.revn  = 220,
-		.fw = {
-			[ADRENO_FW_PM4] = "leia_pm4_470.fw",
-			[ADRENO_FW_PFP] = "leia_pfp_470.fw",
-		},
-		.gmem  = SZ_512K,
-		.inactive_period = DRM_MSM_INACTIVE_PERIOD,
-		.init  = a2xx_gpu_init,
-	}
-};
-DECLARE_ADRENO_GPULIST(a2xx);
-
-static const struct adreno_info a3xx_gpus[] = {
-	{
-		.chip_ids = ADRENO_CHIP_IDS(0x03000512),
-		.family = ADRENO_3XX,
-		.fw = {
-			[ADRENO_FW_PM4] = "a330_pm4.fw",
-			[ADRENO_FW_PFP] = "a330_pfp.fw",
-		},
-		.gmem  = SZ_128K,
-		.inactive_period = DRM_MSM_INACTIVE_PERIOD,
-		.init  = a3xx_gpu_init,
-	}, {
-		.chip_ids = ADRENO_CHIP_IDS(0x03000520),
-		.family = ADRENO_3XX,
-		.revn  = 305,
-		.fw = {
-			[ADRENO_FW_PM4] = "a300_pm4.fw",
-			[ADRENO_FW_PFP] = "a300_pfp.fw",
-		},
-		.gmem  = SZ_256K,
-		.inactive_period = DRM_MSM_INACTIVE_PERIOD,
-		.init  = a3xx_gpu_init,
-	}, {
-		.chip_ids = ADRENO_CHIP_IDS(0x03000600),
-		.family = ADRENO_3XX,
-		.revn  = 307,        /* because a305c is revn==306 */
-		.fw = {
-			[ADRENO_FW_PM4] = "a300_pm4.fw",
-			[ADRENO_FW_PFP] = "a300_pfp.fw",
-		},
-		.gmem  = SZ_128K,
-		.inactive_period = DRM_MSM_INACTIVE_PERIOD,
-		.init  = a3xx_gpu_init,
-	}, {
-		.chip_ids = ADRENO_CHIP_IDS(
-			0x03020000,
-			0x03020001,
-			0x03020002
-		),
-		.family = ADRENO_3XX,
-		.revn  = 320,
-		.fw = {
-			[ADRENO_FW_PM4] = "a300_pm4.fw",
-			[ADRENO_FW_PFP] = "a300_pfp.fw",
-		},
-		.gmem  = SZ_512K,
-		.inactive_period = DRM_MSM_INACTIVE_PERIOD,
-		.init  = a3xx_gpu_init,
-	}, {
-		.chip_ids = ADRENO_CHIP_IDS(
-			0x03030000,
-			0x03030001,
-			0x03030002
-		),
-		.family = ADRENO_3XX,
-		.revn  = 330,
-		.fw = {
-			[ADRENO_FW_PM4] = "a330_pm4.fw",
-			[ADRENO_FW_PFP] = "a330_pfp.fw",
-		},
-		.gmem  = SZ_1M,
-		.inactive_period = DRM_MSM_INACTIVE_PERIOD,
-		.init  = a3xx_gpu_init,
-	}
-};
-DECLARE_ADRENO_GPULIST(a3xx);
-
-static const struct adreno_info a4xx_gpus[] = {
-	{
-		.chip_ids = ADRENO_CHIP_IDS(0x04000500),
-		.family = ADRENO_4XX,
-		.revn  = 405,
-		.fw = {
-			[ADRENO_FW_PM4] = "a420_pm4.fw",
-			[ADRENO_FW_PFP] = "a420_pfp.fw",
-		},
-		.gmem  = SZ_256K,
-		.inactive_period = DRM_MSM_INACTIVE_PERIOD,
-		.init  = a4xx_gpu_init,
-	}, {
-		.chip_ids = ADRENO_CHIP_IDS(0x04020000),
-		.family = ADRENO_4XX,
-		.revn  = 420,
-		.fw = {
-			[ADRENO_FW_PM4] = "a420_pm4.fw",
-			[ADRENO_FW_PFP] = "a420_pfp.fw",
-		},
-		.gmem  = (SZ_1M + SZ_512K),
-		.inactive_period = DRM_MSM_INACTIVE_PERIOD,
-		.init  = a4xx_gpu_init,
-	}, {
-		.chip_ids = ADRENO_CHIP_IDS(0x04030002),
-		.family = ADRENO_4XX,
-		.revn  = 430,
-		.fw = {
-			[ADRENO_FW_PM4] = "a420_pm4.fw",
-			[ADRENO_FW_PFP] = "a420_pfp.fw",
-		},
-		.gmem  = (SZ_1M + SZ_512K),
-		.inactive_period = DRM_MSM_INACTIVE_PERIOD,
-		.init  = a4xx_gpu_init,
-	}
-};
-DECLARE_ADRENO_GPULIST(a4xx);
-
-static const struct adreno_info a5xx_gpus[] = {
-	{
-		.chip_ids = ADRENO_CHIP_IDS(0x05000600),
-		.family = ADRENO_5XX,
-		.revn = 506,
-		.fw = {
-			[ADRENO_FW_PM4] = "a530_pm4.fw",
-			[ADRENO_FW_PFP] = "a530_pfp.fw",
-		},
-		.gmem = (SZ_128K + SZ_8K),
-		/*
-		 * Increase inactive period to 250 to avoid bouncing
-		 * the GDSC which appears to make it grumpy
-		 */
-		.inactive_period = 250,
-		.quirks = ADRENO_QUIRK_TWO_PASS_USE_WFI |
-			  ADRENO_QUIRK_LMLOADKILL_DISABLE,
-		.init = a5xx_gpu_init,
-		.zapfw = "a506_zap.mdt",
-	}, {
-		.chip_ids = ADRENO_CHIP_IDS(0x05000800),
-		.family = ADRENO_5XX,
-		.revn = 508,
-		.fw = {
-			[ADRENO_FW_PM4] = "a530_pm4.fw",
-			[ADRENO_FW_PFP] = "a530_pfp.fw",
-		},
-		.gmem = (SZ_128K + SZ_8K),
-		/*
-		 * Increase inactive period to 250 to avoid bouncing
-		 * the GDSC which appears to make it grumpy
-		 */
-		.inactive_period = 250,
-		.quirks = ADRENO_QUIRK_LMLOADKILL_DISABLE,
-		.init = a5xx_gpu_init,
-		.zapfw = "a508_zap.mdt",
-	}, {
-		.chip_ids = ADRENO_CHIP_IDS(0x05000900),
-		.family = ADRENO_5XX,
-		.revn = 509,
-		.fw = {
-			[ADRENO_FW_PM4] = "a530_pm4.fw",
-			[ADRENO_FW_PFP] = "a530_pfp.fw",
-		},
-		.gmem = (SZ_256K + SZ_16K),
-		/*
-		 * Increase inactive period to 250 to avoid bouncing
-		 * the GDSC which appears to make it grumpy
-		 */
-		.inactive_period = 250,
-		.quirks = ADRENO_QUIRK_LMLOADKILL_DISABLE,
-		.init = a5xx_gpu_init,
-		/* Adreno 509 uses the same ZAP as 512 */
-		.zapfw = "a512_zap.mdt",
-	}, {
-		.chip_ids = ADRENO_CHIP_IDS(0x05010000),
-		.family = ADRENO_5XX,
-		.revn = 510,
-		.fw = {
-			[ADRENO_FW_PM4] = "a530_pm4.fw",
-			[ADRENO_FW_PFP] = "a530_pfp.fw",
-		},
-		.gmem = SZ_256K,
-		/*
-		 * Increase inactive period to 250 to avoid bouncing
-		 * the GDSC which appears to make it grumpy
-		 */
-		.inactive_period = 250,
-		.init = a5xx_gpu_init,
-	}, {
-		.chip_ids = ADRENO_CHIP_IDS(0x05010200),
-		.family = ADRENO_5XX,
-		.revn = 512,
-		.fw = {
-			[ADRENO_FW_PM4] = "a530_pm4.fw",
-			[ADRENO_FW_PFP] = "a530_pfp.fw",
-		},
-		.gmem = (SZ_256K + SZ_16K),
-		/*
-		 * Increase inactive period to 250 to avoid bouncing
-		 * the GDSC which appears to make it grumpy
-		 */
-		.inactive_period = 250,
-		.quirks = ADRENO_QUIRK_LMLOADKILL_DISABLE,
-		.init = a5xx_gpu_init,
-		.zapfw = "a512_zap.mdt",
-	}, {
-		.chip_ids = ADRENO_CHIP_IDS(
-			0x05030002,
-			0x05030004
-		),
-		.family = ADRENO_5XX,
-		.revn = 530,
-		.fw = {
-			[ADRENO_FW_PM4] = "a530_pm4.fw",
-			[ADRENO_FW_PFP] = "a530_pfp.fw",
-			[ADRENO_FW_GPMU] = "a530v3_gpmu.fw2",
-		},
-		.gmem = SZ_1M,
-		/*
-		 * Increase inactive period to 250 to avoid bouncing
-		 * the GDSC which appears to make it grumpy
-		 */
-		.inactive_period = 250,
-		.quirks = ADRENO_QUIRK_TWO_PASS_USE_WFI |
-			ADRENO_QUIRK_FAULT_DETECT_MASK,
-		.init = a5xx_gpu_init,
-		.zapfw = "a530_zap.mdt",
-	}, {
-		.chip_ids = ADRENO_CHIP_IDS(0x05040001),
-		.family = ADRENO_5XX,
-		.revn = 540,
-		.fw = {
-			[ADRENO_FW_PM4] = "a530_pm4.fw",
-			[ADRENO_FW_PFP] = "a530_pfp.fw",
-			[ADRENO_FW_GPMU] = "a540_gpmu.fw2",
-		},
-		.gmem = SZ_1M,
-		/*
-		 * Increase inactive period to 250 to avoid bouncing
-		 * the GDSC which appears to make it grumpy
-		 */
-		.inactive_period = 250,
-		.quirks = ADRENO_QUIRK_LMLOADKILL_DISABLE,
-		.init = a5xx_gpu_init,
-		.zapfw = "a540_zap.mdt",
-	}
-};
-DECLARE_ADRENO_GPULIST(a5xx);
-
-static const struct adreno_info a6xx_gpus[] = {
-	{
-		.chip_ids = ADRENO_CHIP_IDS(0x06010000),
-		.family = ADRENO_6XX_GEN1,
-		.revn = 610,
-		.fw = {
-			[ADRENO_FW_SQE] = "a630_sqe.fw",
-		},
-		.gmem = (SZ_128K + SZ_4K),
-		.inactive_period = DRM_MSM_INACTIVE_PERIOD,
-		.init = a6xx_gpu_init,
-		.zapfw = "a610_zap.mdt",
-		.hwcg = a612_hwcg,
-		/*
-		 * There are (at least) three SoCs implementing A610: SM6125
-		 * (trinket), SM6115 (bengal) and SM6225 (khaje). Trinket does
-		 * not have speedbinning, as only a single SKU exists and we
-		 * don't support khaje upstream yet.  Hence, this matching
-		 * table is only valid for bengal.
-		 */
-		.speedbins = ADRENO_SPEEDBINS(
-			{ 0,   0 },
-			{ 206, 1 },
-			{ 200, 2 },
-			{ 157, 3 },
-			{ 127, 4 },
-		),
-	}, {
-		.machine = "qcom,sm7150",
-		.chip_ids = ADRENO_CHIP_IDS(0x06010800),
-		.family = ADRENO_6XX_GEN1,
-		.fw = {
-			[ADRENO_FW_SQE] = "a630_sqe.fw",
-			[ADRENO_FW_GMU] = "a630_gmu.bin",
-		},
-		.gmem = SZ_512K,
-		.inactive_period = DRM_MSM_INACTIVE_PERIOD,
-		.quirks = ADRENO_QUIRK_HAS_CACHED_COHERENT,
-		.init = a6xx_gpu_init,
-		.zapfw = "a615_zap.mbn",
-		.hwcg = a615_hwcg,
-		.speedbins = ADRENO_SPEEDBINS(
-			{ 0,   0 },
-			{ 128, 1 },
-			{ 146, 2 },
-			{ 167, 3 },
-			{ 172, 4 },
-		),
-	}, {
-		.chip_ids = ADRENO_CHIP_IDS(0x06010800),
-		.family = ADRENO_6XX_GEN1,
-		.revn = 618,
-		.fw = {
-			[ADRENO_FW_SQE] = "a630_sqe.fw",
-			[ADRENO_FW_GMU] = "a630_gmu.bin",
-		},
-		.gmem = SZ_512K,
-		.inactive_period = DRM_MSM_INACTIVE_PERIOD,
-		.quirks = ADRENO_QUIRK_HAS_CACHED_COHERENT,
-		.init = a6xx_gpu_init,
-		.speedbins = ADRENO_SPEEDBINS(
-			{ 0,   0 },
-			{ 169, 1 },
-			{ 174, 2 },
-		),
-	}, {
-		.machine = "qcom,sm4350",
-		.chip_ids = ADRENO_CHIP_IDS(0x06010900),
-		.family = ADRENO_6XX_GEN1,
-		.revn = 619,
-		.fw = {
-			[ADRENO_FW_SQE] = "a630_sqe.fw",
-			[ADRENO_FW_GMU] = "a619_gmu.bin",
-		},
-		.gmem = SZ_512K,
-		.inactive_period = DRM_MSM_INACTIVE_PERIOD,
-		.init = a6xx_gpu_init,
-		.zapfw = "a615_zap.mdt",
-		.hwcg = a615_hwcg,
-		.speedbins = ADRENO_SPEEDBINS(
-			{ 0,   0 },
-			{ 138, 1 },
-			{ 92,  2 },
-		),
-	}, {
-		.machine = "qcom,sm6375",
-		.chip_ids = ADRENO_CHIP_IDS(0x06010901),
-		.family = ADRENO_6XX_GEN1,
-		.revn = 619,
-		.fw = {
-			[ADRENO_FW_SQE] = "a630_sqe.fw",
-			[ADRENO_FW_GMU] = "a619_gmu.bin",
-		},
-		.gmem = SZ_512K,
-		.inactive_period = DRM_MSM_INACTIVE_PERIOD,
-		.init = a6xx_gpu_init,
-		.zapfw = "a615_zap.mdt",
-		.hwcg = a615_hwcg,
-		.speedbins = ADRENO_SPEEDBINS(
-			{ 0,   0 },
-			{ 190, 1 },
-			{ 177, 2 },
-		),
-	}, {
-		.chip_ids = ADRENO_CHIP_IDS(0x06010900),
-		.family = ADRENO_6XX_GEN1,
-		.revn = 619,
-		.fw = {
-			[ADRENO_FW_SQE] = "a630_sqe.fw",
-			[ADRENO_FW_GMU] = "a619_gmu.bin",
-		},
-		.gmem = SZ_512K,
-		.inactive_period = DRM_MSM_INACTIVE_PERIOD,
-		.quirks = ADRENO_QUIRK_HAS_CACHED_COHERENT,
-		.init = a6xx_gpu_init,
-		.zapfw = "a615_zap.mdt",
-		.hwcg = a615_hwcg,
-		.speedbins = ADRENO_SPEEDBINS(
-			{ 0,   0 },
-			{ 120, 4 },
-			{ 138, 3 },
-			{ 169, 2 },
-			{ 180, 1 },
-		),
-	}, {
-		.chip_ids = ADRENO_CHIP_IDS(
-			0x06030001,
-			0x06030002
-		),
-		.family = ADRENO_6XX_GEN1,
-		.revn = 630,
-		.fw = {
-			[ADRENO_FW_SQE] = "a630_sqe.fw",
-			[ADRENO_FW_GMU] = "a630_gmu.bin",
-		},
-		.gmem = SZ_1M,
-		.inactive_period = DRM_MSM_INACTIVE_PERIOD,
-		.quirks = ADRENO_QUIRK_HAS_CACHED_COHERENT,
-		.init = a6xx_gpu_init,
-		.zapfw = "a630_zap.mdt",
-		.hwcg = a630_hwcg,
-	}, {
-		.chip_ids = ADRENO_CHIP_IDS(0x06040001),
-		.family = ADRENO_6XX_GEN2,
-		.revn = 640,
-		.fw = {
-			[ADRENO_FW_SQE] = "a630_sqe.fw",
-			[ADRENO_FW_GMU] = "a640_gmu.bin",
-		},
-		.gmem = SZ_1M,
-		.inactive_period = DRM_MSM_INACTIVE_PERIOD,
-		.quirks = ADRENO_QUIRK_HAS_CACHED_COHERENT,
-		.init = a6xx_gpu_init,
-		.zapfw = "a640_zap.mdt",
-		.hwcg = a640_hwcg,
-		.speedbins = ADRENO_SPEEDBINS(
-			{ 0, 0 },
-			{ 1, 1 },
-		),
-	}, {
-		.chip_ids = ADRENO_CHIP_IDS(0x06050002),
-		.family = ADRENO_6XX_GEN3,
-		.revn = 650,
-		.fw = {
-			[ADRENO_FW_SQE] = "a650_sqe.fw",
-			[ADRENO_FW_GMU] = "a650_gmu.bin",
-		},
-		.gmem = SZ_1M + SZ_128K,
-		.inactive_period = DRM_MSM_INACTIVE_PERIOD,
-		.quirks = ADRENO_QUIRK_HAS_CACHED_COHERENT |
-			ADRENO_QUIRK_HAS_HW_APRIV,
-		.init = a6xx_gpu_init,
-		.zapfw = "a650_zap.mdt",
-		.hwcg = a650_hwcg,
-		.address_space_size = SZ_16G,
-		.speedbins = ADRENO_SPEEDBINS(
-			{ 0, 0 },
-			{ 1, 1 },
-			{ 2, 3 }, /* Yep, 2 and 3 are swapped! :/ */
-			{ 3, 2 },
-		),
-	}, {
-		.chip_ids = ADRENO_CHIP_IDS(0x06060001),
-		.family = ADRENO_6XX_GEN4,
-		.revn = 660,
-		.fw = {
-			[ADRENO_FW_SQE] = "a660_sqe.fw",
-			[ADRENO_FW_GMU] = "a660_gmu.bin",
-		},
-		.gmem = SZ_1M + SZ_512K,
-		.inactive_period = DRM_MSM_INACTIVE_PERIOD,
-		.quirks = ADRENO_QUIRK_HAS_CACHED_COHERENT |
-			ADRENO_QUIRK_HAS_HW_APRIV,
-		.init = a6xx_gpu_init,
-		.zapfw = "a660_zap.mdt",
-		.hwcg = a660_hwcg,
-		.address_space_size = SZ_16G,
-	}, {
-		.chip_ids = ADRENO_CHIP_IDS(0x06030500),
-		.family = ADRENO_6XX_GEN4,
-		.fw = {
-			[ADRENO_FW_SQE] = "a660_sqe.fw",
-			[ADRENO_FW_GMU] = "a660_gmu.bin",
-		},
-		.gmem = SZ_512K,
-		.inactive_period = DRM_MSM_INACTIVE_PERIOD,
-		.quirks = ADRENO_QUIRK_HAS_CACHED_COHERENT |
-			ADRENO_QUIRK_HAS_HW_APRIV,
-		.init = a6xx_gpu_init,
-		.zapfw = "a660_zap.mbn",
-		.hwcg = a660_hwcg,
-		.address_space_size = SZ_16G,
-		.speedbins = ADRENO_SPEEDBINS(
-			{ 0,   0 },
-			{ 117, 0 },
-			{ 172, 2 }, /* Called speedbin 1 downstream, but let's not break things! */
-			{ 190, 1 },
-		),
-	}, {
-		.chip_ids = ADRENO_CHIP_IDS(0x06080001),
-		.family = ADRENO_6XX_GEN2,
-		.revn = 680,
-		.fw = {
-			[ADRENO_FW_SQE] = "a630_sqe.fw",
-			[ADRENO_FW_GMU] = "a640_gmu.bin",
-		},
-		.gmem = SZ_2M,
-		.inactive_period = DRM_MSM_INACTIVE_PERIOD,
-		.quirks = ADRENO_QUIRK_HAS_CACHED_COHERENT,
-		.init = a6xx_gpu_init,
-		.zapfw = "a640_zap.mdt",
-		.hwcg = a640_hwcg,
-	}, {
-		.chip_ids = ADRENO_CHIP_IDS(0x06090000),
-		.family = ADRENO_6XX_GEN4,
-		.fw = {
-			[ADRENO_FW_SQE] = "a660_sqe.fw",
-			[ADRENO_FW_GMU] = "a660_gmu.bin",
-		},
-		.gmem = SZ_4M,
-		.inactive_period = DRM_MSM_INACTIVE_PERIOD,
-		.quirks = ADRENO_QUIRK_HAS_CACHED_COHERENT |
-			ADRENO_QUIRK_HAS_HW_APRIV,
-		.init = a6xx_gpu_init,
-		.zapfw = "a690_zap.mdt",
-		.hwcg = a690_hwcg,
-		.address_space_size = SZ_16G,
-	}
-};
-DECLARE_ADRENO_GPULIST(a6xx);
-
-static const struct adreno_info a7xx_gpus[] = {
-	{
-		.chip_ids = ADRENO_CHIP_IDS(0x07000200),
-		.family = ADRENO_6XX_GEN1, /* NOT a mistake! */
-		.fw = {
-			[ADRENO_FW_SQE] = "a702_sqe.fw",
-		},
-		.gmem = SZ_128K,
-		.inactive_period = DRM_MSM_INACTIVE_PERIOD,
-		.quirks = ADRENO_QUIRK_HAS_HW_APRIV,
-		.init = a6xx_gpu_init,
-		.zapfw = "a702_zap.mbn",
-		.hwcg = a702_hwcg,
-		.speedbins = ADRENO_SPEEDBINS(
-			{ 0,   0 },
-			{ 236, 1 },
-			{ 178, 2 },
-			{ 142, 3 },
-		),
-	}, {
-		.chip_ids = ADRENO_CHIP_IDS(0x07030001),
-		.family = ADRENO_7XX_GEN1,
-		.fw = {
-			[ADRENO_FW_SQE] = "a730_sqe.fw",
-			[ADRENO_FW_GMU] = "gmu_gen70000.bin",
-		},
-		.gmem = SZ_2M,
-		.inactive_period = DRM_MSM_INACTIVE_PERIOD,
-		.quirks = ADRENO_QUIRK_HAS_CACHED_COHERENT |
-			  ADRENO_QUIRK_HAS_HW_APRIV,
-		.init = a6xx_gpu_init,
-		.zapfw = "a730_zap.mdt",
-		.hwcg = a730_hwcg,
-		.address_space_size = SZ_16G,
-	}, {
-		.chip_ids = ADRENO_CHIP_IDS(0x43050a01), /* "C510v2" */
-		.family = ADRENO_7XX_GEN2,
-		.fw = {
-			[ADRENO_FW_SQE] = "a740_sqe.fw",
-			[ADRENO_FW_GMU] = "gmu_gen70200.bin",
-		},
-		.gmem = 3 * SZ_1M,
-		.inactive_period = DRM_MSM_INACTIVE_PERIOD,
-		.quirks = ADRENO_QUIRK_HAS_CACHED_COHERENT |
-			  ADRENO_QUIRK_HAS_HW_APRIV,
-		.init = a6xx_gpu_init,
-		.zapfw = "a740_zap.mdt",
-		.hwcg = a740_hwcg,
-		.address_space_size = SZ_16G,
-	}, {
-		.chip_ids = ADRENO_CHIP_IDS(0x43051401), /* "C520v2" */
-		.family = ADRENO_7XX_GEN3,
-		.fw = {
-			[ADRENO_FW_SQE] = "gen70900_sqe.fw",
-			[ADRENO_FW_GMU] = "gmu_gen70900.bin",
-		},
-		.gmem = 3 * SZ_1M,
-		.inactive_period = DRM_MSM_INACTIVE_PERIOD,
-		.quirks = ADRENO_QUIRK_HAS_CACHED_COHERENT |
-			  ADRENO_QUIRK_HAS_HW_APRIV,
-		.init = a6xx_gpu_init,
-		.zapfw = "gen70900_zap.mbn",
-		.address_space_size = SZ_16G,
-	}
-};
-DECLARE_ADRENO_GPULIST(a7xx);
+extern const struct adreno_gpulist a2xx_gpulist;
+extern const struct adreno_gpulist a3xx_gpulist;
+extern const struct adreno_gpulist a4xx_gpulist;
+extern const struct adreno_gpulist a5xx_gpulist;
+extern const struct adreno_gpulist a6xx_gpulist;
+extern const struct adreno_gpulist a7xx_gpulist;
 
 static const struct adreno_gpulist *gpulists[] = {
 	&a2xx_gpulist,
@@ -620,35 +36,6 @@ static const struct adreno_gpulist *gpulists[] = {
 	&a6xx_gpulist,
 };
 
-MODULE_FIRMWARE("qcom/a300_pm4.fw");
-MODULE_FIRMWARE("qcom/a300_pfp.fw");
-MODULE_FIRMWARE("qcom/a330_pm4.fw");
-MODULE_FIRMWARE("qcom/a330_pfp.fw");
-MODULE_FIRMWARE("qcom/a420_pm4.fw");
-MODULE_FIRMWARE("qcom/a420_pfp.fw");
-MODULE_FIRMWARE("qcom/a530_pm4.fw");
-MODULE_FIRMWARE("qcom/a530_pfp.fw");
-MODULE_FIRMWARE("qcom/a530v3_gpmu.fw2");
-MODULE_FIRMWARE("qcom/a530_zap.mdt");
-MODULE_FIRMWARE("qcom/a530_zap.b00");
-MODULE_FIRMWARE("qcom/a530_zap.b01");
-MODULE_FIRMWARE("qcom/a530_zap.b02");
-MODULE_FIRMWARE("qcom/a540_gpmu.fw2");
-MODULE_FIRMWARE("qcom/a615_zap.mbn");
-MODULE_FIRMWARE("qcom/a619_gmu.bin");
-MODULE_FIRMWARE("qcom/a630_sqe.fw");
-MODULE_FIRMWARE("qcom/a630_gmu.bin");
-MODULE_FIRMWARE("qcom/a630_zap.mbn");
-MODULE_FIRMWARE("qcom/a640_gmu.bin");
-MODULE_FIRMWARE("qcom/a650_gmu.bin");
-MODULE_FIRMWARE("qcom/a650_sqe.fw");
-MODULE_FIRMWARE("qcom/a660_gmu.bin");
-MODULE_FIRMWARE("qcom/a660_sqe.fw");
-MODULE_FIRMWARE("qcom/leia_pfp_470.fw");
-MODULE_FIRMWARE("qcom/leia_pm4_470.fw");
-MODULE_FIRMWARE("qcom/yamato_pfp.fw");
-MODULE_FIRMWARE("qcom/yamato_pm4.fw");
-
 static const struct adreno_info *adreno_info(uint32_t chip_id)
 {
 	/* identify gpu: */
-- 
2.45.2


