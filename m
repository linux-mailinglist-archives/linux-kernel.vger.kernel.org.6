Return-Path: <linux-kernel+bounces-435364-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA8749E7693
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 18:00:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4325166D66
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 17:00:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 370441CA94;
	Fri,  6 Dec 2024 17:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thalesgroup.com header.i=@thalesgroup.com header.b="JFCLA9iH"
Received: from esa.hc1631-21.eu.iphmx.com (esa.hc1631-21.eu.iphmx.com [23.90.122.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F0CB819
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 17:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.90.122.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733504434; cv=none; b=eW+/vWxZnFut03FatRVMAwjSQ2gfB5BGMu6iAK9eolxHn8+KmrDvFhScoGBG/GbffylUpJqNNjTFTqhWe9eXSpzOciDTqFf3TDUwArqtmL+qHI9hfa6BIsMyyvyqVUfMzh5lhIz9Ho0pnlaJnjw6Mjj2bJjAVfN+K7eSae5RZgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733504434; c=relaxed/simple;
	bh=uEGM8Z4UHsY6F2XYbWLhB+QfJWBLPZ30RLApCc+SoTA=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=EyOr2L2KEPl/KPgdi9L1+ZN6DWXBW5wtvxOMoftQC6JfV5waOOLv1p6g1+IQ1nU/i+M2cfgUP+73royxFKXZgNAQpQFVKJsj16gJmN3YozOS5Wb2oRTAqBHCsEG0+6Y9PU3M4eJ0BK84ujSd3Apdgl2aHNHHcz2+tCKo3HQeNSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=thalesgroup.com; spf=pass smtp.mailfrom=thalesgroup.com; dkim=pass (2048-bit key) header.d=thalesgroup.com header.i=@thalesgroup.com header.b=JFCLA9iH; arc=none smtp.client-ip=23.90.122.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=thalesgroup.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thalesgroup.com
X-CSE-ConnectionGUID: UclqZLrISpawPpxistZesQ==
X-CSE-MsgGUID: LQezsqbVTgaTKEKK4CNryQ==
Authentication-Results: ob1.hc1631-21.eu.iphmx.com; dkim=pass (signature verified) header.i=@thalesgroup.com
X-IronPort-AV: E=McAfee;i="6700,10204,11278"; a="23332492"
X-IronPort-AV: E=Sophos;i="6.12,213,1728943200"; 
   d="scan'208";a="23332492"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=thalesgroup.com; i=@thalesgroup.com; s=bbmfo20230504;
  t=1733504424;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=MMvxvcjwmGaoaI6TY+sGHOwLrNIxmnQoHv/0XjIcJL0=;
  b=JFCLA9iHPfZChCYziT4FCoZq5xfuNdNlFwDUjpvRpaf9r/lt9gl1gTEg
   Kr2nBSZOFYvROPaDaDkLpQqDPhTFfWcnRfVWvg2nlqbvukDCSnQtu1pbk
   rPL05NyYG6lxWJaqhviEv7Eus8OlNqvycKEHDxvl35xFZocs3Q9vsdNL9
   uv98CmLAN50lD3EV1+xGlX15n5rHeWDVFaw6KDmQ+uVdJ4Lb+YjOfLWiV
   BVAb+p3Cp5hc01Xm73ixQdBgshqrOFsyJCqqS1XxJ7QCTpplpN/YkRIpY
   La2Q4yT9z7+5nKLCptWkrzSZgssL0N8DuSuPKNj1Fc5ouha0FilJ3GdFW
   A==;
X-CSE-ConnectionGUID: 7LdCRkuVSxWGyOteYqmJwg==
X-CSE-MsgGUID: a6Spk8VFQaarM3WTfLC1Aw==
X-CSE-ConnectionGUID: ivLhYqsyQXuhkMMHH+jcsQ==
X-CSE-MsgGUID: sFIkbeDeSBacDqZf3dN5sg==
X-IronPort-AV: E=McAfee;i="6700,10204,11278"; a="36858925"
X-IronPort-AV: E=Sophos;i="6.12,213,1728943200"; 
   d="scan'208";a="36858925"
From: LECOINTRE Philippe <philippe.lecointre@thalesgroup.com>
To: Lucas Stach <l.stach@pengutronix.de>, Russell King
	<linux+etnaviv@armlinux.org.uk>, Christian Gmeiner
	<christian.gmeiner@gmail.com>
CC: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	"etnaviv@lists.freedesktop.org" <etnaviv@lists.freedesktop.org>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, LENAIN Simon
	<simon.lenain@thalesgroup.com>, BARBEAU Etienne
	<etienne.barbeau@thalesgroup.com>, LEJEUNE Sebastien
	<sebastien.lejeune@thalesgroup.com>
Subject: [PATCH v3] drm/etnaviv: add optional reset support
Thread-Topic: [PATCH v3] drm/etnaviv: add optional reset support
Thread-Index: AdtIAAvrmB6eEfCxSuiZypoaKXF8Jg==
Date: Fri, 6 Dec 2024 17:00:23 +0000
Message-ID: <afcb562602e54c969964a608e3b6494a@thalesgroup.com>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-nodisclaimer: 0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Add optional reset support which is mentioned in vivante,gc.yaml to
allow the driver to work on SoCs whose reset signal is asserted by default

Signed-off-by: Philippe Lecointre <philippe.lecointre@thalesgroup.com>
Reviewed-by: Simon Lenain <simon.lenain@thalesgroup.com>
---
v3:
- Rework to match initial feedback
---
 drivers/gpu/drm/etnaviv/etnaviv_gpu.c | 37 +++++++++++++++++++++++++++
 drivers/gpu/drm/etnaviv/etnaviv_gpu.h |  1 +
 2 files changed, 38 insertions(+)

diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gpu.c b/drivers/gpu/drm/etnavi=
v/etnaviv_gpu.c
index 2d4c112ce033..1961ebac315a 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
@@ -13,6 +13,7 @@
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/regulator/consumer.h>
+#include <linux/reset.h>
 #include <linux/thermal.h>
=20
 #include "etnaviv_cmdbuf.h"
@@ -172,6 +173,25 @@ int etnaviv_gpu_get_param(struct etnaviv_gpu *gpu, u32=
 param, u64 *value)
 	return 0;
 }
=20
+static int etnaviv_gpu_reset_deassert(struct etnaviv_gpu *gpu)
+{
+	int ret;
+
+	/* 32 core clock cycles (slowest clock) required before deassertion */
+	/* 1 microsecond might match all implementations without computation */
+	usleep_range(1, 2);
+
+	ret =3D reset_control_deassert(gpu->rst);
+	if (ret)
+		return ret;
+
+	/* 128 core clock cycles (slowest clock) required before any activity on =
AHB */
+	/* 1 microsecond might match all implementations without computation */
+	usleep_range(1, 2);
+
+	return 0;
+}
+
 static inline bool etnaviv_is_model_rev(struct etnaviv_gpu *gpu, u32 model=
, u32 revision)
 {
 	return gpu->identity.model =3D=3D model &&
@@ -799,6 +819,12 @@ int etnaviv_gpu_init(struct etnaviv_gpu *gpu)
 		goto pm_put;
 	}
=20
+	ret =3D etnaviv_gpu_reset_deassert(gpu);
+	if (ret) {
+		dev_err(gpu->dev, "GPU reset deassert failed\n");
+		goto fail;
+	}
+
 	etnaviv_hw_identify(gpu);
=20
 	if (gpu->identity.model =3D=3D 0) {
@@ -1860,6 +1886,17 @@ static int etnaviv_gpu_platform_probe(struct platfor=
m_device *pdev)
 	if (IS_ERR(gpu->mmio))
 		return PTR_ERR(gpu->mmio);
=20
+
+	/* Get Reset: */
+	gpu->rst =3D devm_reset_control_get_optional_exclusive(&pdev->dev, NULL);
+	if (IS_ERR(gpu->rst))
+		return dev_err_probe(dev, PTR_ERR(gpu->rst),
+				     "failed to get reset\n");
+
+	err =3D reset_control_assert(gpu->rst);
+	if (err)
+		return dev_err_probe(dev, err, "failed to assert reset\n");
+
 	/* Get Interrupt: */
 	gpu->irq =3D platform_get_irq(pdev, 0);
 	if (gpu->irq < 0)
diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gpu.h b/drivers/gpu/drm/etnavi=
v/etnaviv_gpu.h
index 4d8a7d48ade3..0985ea548b82 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_gpu.h
+++ b/drivers/gpu/drm/etnaviv/etnaviv_gpu.h
@@ -158,6 +158,7 @@ struct etnaviv_gpu {
 	struct clk *clk_reg;
 	struct clk *clk_core;
 	struct clk *clk_shader;
+	struct reset_control *rst;
=20
 	unsigned int freq_scale;
 	unsigned int fe_waitcycles;
--=20
2.19.1


