Return-Path: <linux-kernel+bounces-227689-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 194D691558A
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 19:40:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 989931F24409
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 17:40:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56A8419EEDF;
	Mon, 24 Jun 2024 17:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="J9uB0i/A"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9181019E83A
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 17:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719250803; cv=none; b=gqK6RpbuLgB8wf7Z+PYufY4YDy1Botpq/jMfsyMIs29F3yENSRuzOLMYk0YKKo7DIj0KSwHMXCMKJ2S+s6yxpG/hrZEjBTMNSZtv0GDQiFdbgXp847D8myxNamgiyMd4bGTDZSRAjIUyRBS9f8ln6riI6Otvucgxhkhxj6B7ur4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719250803; c=relaxed/simple;
	bh=rFspHFmOyiFGXqZvDfFVtBS2+jLZUsqxipNk0i6GmJE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=SKzcCW8voHaPxBOoRY2HZGW8USWCfBlR5+qfSQk4CrUwexwe2bPEM5wAVml8TYVe8YqeZ6MaYf8oSNUgm1xA1650d/lcS4Iq2UZbxe8TCIYaSgl5xGXW2QgWRKvuiGmxtqmu5AHFLgo7DpWnkcObZa7uvF4UB8V8sEVFqAXSodc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=J9uB0i/A; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2ebed33cb65so51032631fa.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 10:40:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719250800; x=1719855600; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=X4I6nP/vTxwMdJ/dV3TQHmb3v1qJ/dluw5GaWCNXlms=;
        b=J9uB0i/A+T0QJg8TIpsw5GqmgS5+XDK1TDR/QhsPR7OFiU8OwY6t2m3vKRsN9bgsjX
         BAV1kKK8jJsMkV2r+0Pb5CD9Zep8VGXx1ifv7luzR8AInO3DavpkF1FejjGXq3QG3f3H
         9Tjv5n5W5Wx+p3YflBoyFfDvTNnMDdmSD16t1MC3yDT70cGByqoWdCtjBVogJyAhvQuw
         SkBKKny0zHGY2SwCqLce71OIjiH9WZsXtPDx+qSQmD8sn0GiGjs3I9WM2iqxb7kZV1lr
         X1TgjVeF5Lz3b1b33iEcishtqU4vDKdT3sw6K47mcTRTawm9NzFO9gkujPuHKFqCE3lB
         U8FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719250800; x=1719855600;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X4I6nP/vTxwMdJ/dV3TQHmb3v1qJ/dluw5GaWCNXlms=;
        b=wL0DtptlcxaMb8if3Jg9kBKCfP37nluaadhwl1zVa9nKuqQUR2wb3CP7+vTm/QGSVP
         /5vajtXieRymbX5TXm9LSPm5vTrvWbv0tHTH++QA2+jZi7Rdrhy/2hrMYZIbWzOaD/Aw
         MKXypfq2G2JGjhOTGEzQAH6cF4NliGAldZJ3gUe6ODFNIlViFnWWksoL/SkU2DHZ8bcq
         vSTV4LGOrrR9cPhKSVu8Qx3vGVkBSVbnVJ2g/XlnJPChOQep4snw4H9Y4pLvFj8NiD/2
         eiWE+xPyP8DJYdbfb694EJZHa4Sy0G2QrzAI2ii+HB8j68EXlWxULzQqby9wf/Arx0SD
         GSnQ==
X-Forwarded-Encrypted: i=1; AJvYcCUxcbSfKBOkVzGA1hOiKVgLlM6WSecR+JJIKkadx/fBteegJnGC7PzaMRn0s/CmeFbku+TVl5DxXErEB2aT2ZfzRqaTXKFaKOWjnIki
X-Gm-Message-State: AOJu0Yx/htmbn1rZKqrQi59DtlH68ovvwjQTkydZyCaImxXXcs6zfrOL
	XBMOXnWhi6w94pg0bzk6X1wReCfhCo1ZNXPV0upWGbEAOtHZCjVAd1CrgJBYzyIF9EGD0eMqy7a
	tGvs=
X-Google-Smtp-Source: AGHT+IEh/iyrIRntkObUotPBA+wdBYxw0BsT77HvhE4PadtEX9XW7b2sxv0RwYrWpQ0mB8zBTSgWgQ==
X-Received: by 2002:a05:651c:2119:b0:2ec:681b:5b50 with SMTP id 38308e7fff4ca-2ec681b5f72mr4572391fa.11.1719250799656;
        Mon, 24 Jun 2024 10:39:59 -0700 (PDT)
Received: from umbar.lan ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ec5d2c3446sm5120581fa.38.2024.06.24.10.39.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jun 2024 10:39:59 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Mon, 24 Jun 2024 20:39:58 +0300
Subject: [PATCH] drm/connector: hdmi: shorten too long function name
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240624-hdmi-connector-shorten-name-v1-1-5bd3410138db@linaro.org>
X-B4-Tracking: v=1; b=H4sIAG2veWYC/x3MwQqDMAwA0F+RnA3UWNzYrwwPXRvXHExHKjIQ/
 93i8V3eAZVNuMKrO8B4lypFG4a+g5iDfhklNQM58m4ijzmtgrGoctyKYc3FNlbUsDKOA1F6Ov+
 Z4gPa8DNe5H/v7/k8L1LoJTltAAAA
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3067;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=rFspHFmOyiFGXqZvDfFVtBS2+jLZUsqxipNk0i6GmJE=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBmea9uPJTjZRiOibJPcz5nFHytq9vOX0HcFPm1P
 jPg/exgeCOJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZnmvbgAKCRCLPIo+Aiko
 1WQDB/4zH94esAY7J/6Qv7nPTGRI9qb7iXNNoQI+f3yug4LgXeV2+rvQDDc2z7dPfb1VKWNFy6Y
 Et9nvs2Xv6lQ3QHh3xl0X3l/DqhzxOtfmg8XO7LhqRqS5KhWXA95CyrGzOLwuNgxVFC7R+GxX95
 qE18uh8iTr9U4iKLZ+FliIekM+kz+hAw8KkP3B7UqBU1PnTI7ZyerW6XS3Si6C6vcodm8E8gkwb
 IVljS88TG9+eOzSfUqrjqklLZYOsfQbGMnSZkrSHrXKFIN+fyj8y5QMfuSmVAmxOF4n0guNS81d
 CN7+Om6r/u9MJplaEeaang585QgXa4+pAvjXFD96gK+TNEIN
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

If CONFIG_MODVERSIONS is enabled, then using the HDMI Connector
framework can result in build failures. Rename the function to make it
fit into the name requirements.

ERROR: modpost: too long symbol "drm_atomic_helper_connector_hdmi_disable_audio_infoframe" [drivers/gpu/drm/msm/msm.ko]

Reported-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/gpu/drm/display/drm_hdmi_state_helper.c | 6 +++---
 include/drm/display/drm_hdmi_state_helper.h     | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/display/drm_hdmi_state_helper.c b/drivers/gpu/drm/display/drm_hdmi_state_helper.c
index 2dab3ad8ce64..7854820089ec 100644
--- a/drivers/gpu/drm/display/drm_hdmi_state_helper.c
+++ b/drivers/gpu/drm/display/drm_hdmi_state_helper.c
@@ -716,7 +716,7 @@ drm_atomic_helper_connector_hdmi_update_audio_infoframe(struct drm_connector *co
 EXPORT_SYMBOL(drm_atomic_helper_connector_hdmi_update_audio_infoframe);
 
 /**
- * drm_atomic_helper_connector_hdmi_disable_audio_infoframe - Stop sending the Audio Infoframe
+ * drm_atomic_helper_connector_hdmi_clear_audio_infoframe - Stop sending the Audio Infoframe
  * @connector: A pointer to the HDMI connector
  *
  * This function is meant for HDMI connector drivers to stop sending their
@@ -727,7 +727,7 @@ EXPORT_SYMBOL(drm_atomic_helper_connector_hdmi_update_audio_infoframe);
  * Zero on success, error code on failure.
  */
 int
-drm_atomic_helper_connector_hdmi_disable_audio_infoframe(struct drm_connector *connector)
+drm_atomic_helper_connector_hdmi_clear_audio_infoframe(struct drm_connector *connector)
 {
 	struct drm_connector_hdmi_infoframe *infoframe =
 		&connector->hdmi.infoframes.audio;
@@ -749,4 +749,4 @@ drm_atomic_helper_connector_hdmi_disable_audio_infoframe(struct drm_connector *c
 
 	return ret;
 }
-EXPORT_SYMBOL(drm_atomic_helper_connector_hdmi_disable_audio_infoframe);
+EXPORT_SYMBOL(drm_atomic_helper_connector_hdmi_clear_audio_infoframe);
diff --git a/include/drm/display/drm_hdmi_state_helper.h b/include/drm/display/drm_hdmi_state_helper.h
index 285f366cf716..2d45fcfa4619 100644
--- a/include/drm/display/drm_hdmi_state_helper.h
+++ b/include/drm/display/drm_hdmi_state_helper.h
@@ -16,7 +16,7 @@ int drm_atomic_helper_connector_hdmi_check(struct drm_connector *connector,
 
 int drm_atomic_helper_connector_hdmi_update_audio_infoframe(struct drm_connector *connector,
 							    struct hdmi_audio_infoframe *frame);
-int drm_atomic_helper_connector_hdmi_disable_audio_infoframe(struct drm_connector *connector);
+int drm_atomic_helper_connector_hdmi_clear_audio_infoframe(struct drm_connector *connector);
 int drm_atomic_helper_connector_hdmi_update_infoframes(struct drm_connector *connector,
 						       struct drm_atomic_state *state);
 

---
base-commit: f76698bd9a8ca01d3581236082d786e9a6b72bb7
change-id: 20240624-hdmi-connector-shorten-name-3122d804b6c7

Best regards,
-- 
Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


