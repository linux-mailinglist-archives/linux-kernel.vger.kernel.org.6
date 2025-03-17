Return-Path: <linux-kernel+bounces-564770-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CB45A65A84
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 18:22:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25678188FFB4
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 17:18:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 486431A5BB5;
	Mon, 17 Mar 2025 17:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b="ssdTqcTG"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA61C1FECB8
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 17:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742231618; cv=none; b=ZGq9oI1FC0IZveKu4sM/o49XlpsLcAGMPNqlX7eSDMOZWUs0at++0kVfsBdQ5aPVLa8/LTt/y3ED3urtBnYL/BUEOTOl6JmdjKJRn8bYMHdUCRcu2fv+bU6vOO6N1PfUt/ZWMBcWcY0WTYNC6DaB1qOc2zt422Fr5xcTONxys8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742231618; c=relaxed/simple;
	bh=Yrp2WBDWbyS4CuMObPwAXQhUd31qFj3zSfQP0EjWyTU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Nu4yBeX/KJwAD5SLyZkjBS1V5HQipPab+yrNXFU/baIheLt9VC/SdglIKEuTKnFibdy70MwDk616YFeO1ex/XcSFLJ8l75HXLRDGPOXchadYkHo1rjltO6GS5vRrHj+j/rPmaOlr5UjcvdXiwgr8xkcr2PdNUt1qXZr6mdDlp60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com; spf=pass smtp.mailfrom=raspberrypi.com; dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b=ssdTqcTG; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=raspberrypi.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-43cf58eea0fso12605455e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 10:13:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google; t=1742231615; x=1742836415; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IDlaYwRgBjONniOC+WQROb7al/p94+af7oPPA6nLeCw=;
        b=ssdTqcTGmeiC2kxcs+fjj9ME7lWwHszT86P0W7Ze7jxXPA9jN37WcpkGdGMYmr7OFr
         JHZb4UxIshe6GBLulTJN2+3h3JcL3UYbLQXJghYu7xFTi5sOf2MvtBYWSRtqaHz2624C
         Pz3cUJsQrYPElYMpsq7s3sTmKsLuOkAnffiSo2aZd7+iFxgHOypBfBmDNhf4csEqmcoz
         W4YqYZDtGX83MEwjTfd/BlChbY3FdFaoXKq/Sjo8tvV3KbIdRS3ndJAU/73bEzc9CVPy
         Aoh2ctE6xNa6hwlrSjVGc5OLjXe848NL9PQNCtddHyVyAP1nnjaYWgm0r+SvDPqAMxAE
         VEUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742231615; x=1742836415;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IDlaYwRgBjONniOC+WQROb7al/p94+af7oPPA6nLeCw=;
        b=AcEFPovVvrbrplo1THfDWLPPZnYnZTyW4n7YR1Q07OcApwuZE84e2fUYVxoYJj0UDm
         UvtHbHuBiYGHs353VFiHpcA/A1f/2NXAuamlz+7kw+j5U1/kUC6mwxdUHWvfT6cNdCaw
         bY0dZhsmZJEMIV42kSYWj7I0AQSoXZsTjcJ9Kg8GOmWvgZssMKsYLKfE0jUvdeuMF3mk
         dDUoWxFWXeiDwIhehWm+gyVU3yuQMIVGZ0krPLvQWVdXc/Wi+LU6uNpxrxqmi5COZvN1
         41TpK1q5NSe2Z9m6PLWfnuigO1lYzoHE+Njg5GqR20LrB0nMh6uxWKLMVl2TNOL+t9gx
         IFLA==
X-Forwarded-Encrypted: i=1; AJvYcCWvt4MSloHYSH/bGvbsedlHvXJLl1lbbKKPJ2U9RVlQGfT/GKXMcMI8XWjmcLIJHJC9+xiRqMX/C9MSsnc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2cDnrCA7SpP7Uh9hiB9kHEVU8EZoL6TZeHIVOa7oLprDxKIx5
	xfItC8TMGXfsPTajYvDI/K0YeiOD69LbGzI8NbvxjvALyQ1irxvN3Lpkpmbc6wk=
X-Gm-Gg: ASbGncuQpP1+kvWScj9ojMUj+4We2NEBmJEXP5W9Af8slC9W+E7O8JIyuY1kN3OGcip
	aR0BNfDJqxuMceo1UzSwcbbVv8DytGkfqFeBv6X7HEud1uYrLywBsmmLWqNCOA0byMRly92VOqw
	lxDclNn8usLNdnPNIgeHbsPsvmpdCpuym6iApq5QMbADXvSOvgghnxNXH7cW9vET45bg8JNI00b
	As8mX8DhZR6FrXG7LfdmgUDwsX0TGDgtoN8OxFvbQrxpGUoYBFLE7CVVy1JxVa9rtg712Y3WLc5
	jqy+az0U8gjYdxSEaFB0J1lo6A0TfyuvNQ==
X-Google-Smtp-Source: AGHT+IFvMG8C/DswjrgMcrIcB5vcUNJhIfY6inhq7RlXMQ5STO4yZJWkrfjDg2k3WPUIILjObGT+xQ==
X-Received: by 2002:a05:600c:511c:b0:43c:fbba:41ba with SMTP id 5b1f17b1804b1-43d1ecd60c1mr126561595e9.28.1742231614956;
        Mon, 17 Mar 2025 10:13:34 -0700 (PDT)
Received: from [127.0.1.1] ([2a00:1098:3142:e::8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d1fdda15dsm112003365e9.3.2025.03.17.10.13.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 10:13:34 -0700 (PDT)
From: David Turner <david.turner@raspberrypi.com>
Date: Mon, 17 Mar 2025 17:12:24 +0000
Subject: [PATCH v4 3/3] drm/vc4: hdmi: Add jack detection to HDMI audio
 driver
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250317-vc4_hotplug-v4-3-2af625629186@raspberrypi.com>
References: <20250317-vc4_hotplug-v4-0-2af625629186@raspberrypi.com>
In-Reply-To: <20250317-vc4_hotplug-v4-0-2af625629186@raspberrypi.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Dave Stevenson <dave.stevenson@raspberrypi.com>, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>, 
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 David Turner <david.turner@raspberrypi.com>, 
 Stefan Wahren <wahrenst@gmx.net>
X-Mailer: b4 0.14.2

Add ALSA jack detection to the vc4-hdmi audio driver so userspace knows
when to add/remove HDMI audio devices.

Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
Reviewed-by: Maxime Ripard <mripard@kernel.org>
Signed-off-by: David Turner <david.turner@raspberrypi.com>
---
 drivers/gpu/drm/vc4/vc4_hdmi.c | 18 ++++++++++++++++++
 drivers/gpu/drm/vc4/vc4_hdmi.h |  7 +++++++
 2 files changed, 25 insertions(+)

diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.c b/drivers/gpu/drm/vc4/vc4_hdmi.c
index 37a7d45695f236d3ab281d9a8676921fd434955c..a29a6ef266f9a5952af53030a9a2d313e2ecdfce 100644
--- a/drivers/gpu/drm/vc4/vc4_hdmi.c
+++ b/drivers/gpu/drm/vc4/vc4_hdmi.c
@@ -51,6 +51,7 @@
 #include <linux/reset.h>
 #include <sound/dmaengine_pcm.h>
 #include <sound/hdmi-codec.h>
+#include <sound/jack.h>
 #include <sound/pcm_drm_eld.h>
 #include <sound/pcm_params.h>
 #include <sound/soc.h>
@@ -2175,6 +2176,22 @@ static const struct drm_connector_hdmi_audio_funcs vc4_hdmi_audio_funcs = {
 	.shutdown = vc4_hdmi_audio_shutdown,
 };
 
+static int vc4_hdmi_codec_init(struct snd_soc_pcm_runtime *rtd)
+{
+	struct vc4_hdmi *vc4_hdmi = snd_soc_card_get_drvdata(rtd->card);
+	struct snd_soc_component *component = snd_soc_rtd_to_codec(rtd, 0)->component;
+	int ret;
+
+	ret = snd_soc_card_jack_new(rtd->card, "HDMI Jack", SND_JACK_LINEOUT,
+				    &vc4_hdmi->hdmi_jack);
+	if (ret) {
+		dev_err(rtd->dev, "HDMI Jack creation failed: %d\n", ret);
+		return ret;
+	}
+
+	return snd_soc_component_set_jack(component, &vc4_hdmi->hdmi_jack, NULL);
+}
+
 static int vc4_hdmi_audio_init(struct vc4_hdmi *vc4_hdmi)
 {
 	const struct vc4_hdmi_register *mai_data =
@@ -2288,6 +2305,7 @@ static int vc4_hdmi_audio_init(struct vc4_hdmi *vc4_hdmi)
 	dai_link->cpus->dai_name = dev_name(dev);
 	dai_link->codecs->name = dev_name(&vc4_hdmi->connector.hdmi_audio.codec_pdev->dev);
 	dai_link->platforms->name = dev_name(dev);
+	dai_link->init = vc4_hdmi_codec_init;
 
 	card->dai_link = dai_link;
 	card->num_links = 1;
diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.h b/drivers/gpu/drm/vc4/vc4_hdmi.h
index e3d989ca302b72533c374dfa3fd0d5bd7fe64a82..a31157c99bee6b33527c4b558fc72fff65d2a278 100644
--- a/drivers/gpu/drm/vc4/vc4_hdmi.h
+++ b/drivers/gpu/drm/vc4/vc4_hdmi.h
@@ -4,6 +4,7 @@
 #include <drm/drm_connector.h>
 #include <media/cec.h>
 #include <sound/dmaengine_pcm.h>
+#include <sound/hdmi-codec.h>
 #include <sound/soc.h>
 
 #include "vc4_drv.h"
@@ -211,6 +212,12 @@ struct vc4_hdmi {
 	 * KMS hooks. Protected by @mutex.
 	 */
 	enum hdmi_colorspace output_format;
+
+	/**
+	 * @hdmi_jack: Represents the connection state of the HDMI plug, for
+	 * ALSA jack detection.
+	 */
+	struct snd_soc_jack hdmi_jack;
 };
 
 #define connector_to_vc4_hdmi(_connector)				\

-- 
2.34.1


