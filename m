Return-Path: <linux-kernel+bounces-206124-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BCDF900496
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 15:23:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C7EADB24820
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 13:23:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CDBC194122;
	Fri,  7 Jun 2024 13:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hghTrTSF"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE93915B567
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 13:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717766588; cv=none; b=ukv1or7WDDO5ZUpZh6shoFTIk3AObqiqOnae/nHMsaahX9n4oXAvRN6bY5G1tC91GUpbPVqzPje3pBq1LTUvDaamZZeL7YDPOjDZvWow/kwTrezDgYDeOs2FnocjFE7X44IR4YUqTmBzDI/TeeQDvygYIR/OQ9eIIutLSy+yVMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717766588; c=relaxed/simple;
	bh=ZpBWCc8zTiSyZgAlt8eDA4MQfiQXS330IXqEN1kPi0M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IZcyeSDChUhgKix3/Ott0/pwhz7DAll12YheJ6lr324im5/ALiLZam7esSxmHOaQjrSxGLYvq8WSSDVG5lHV1ZMwBq3hrMxeKY7a0xWLpNS3JJwsp9EmL5ZQaA1ZoJ+g2VT/d97tcf470FjPFGjQSUOD2h/+vTJPmE4OJ2jN4HU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hghTrTSF; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-52b992fd796so2245647e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2024 06:23:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717766585; x=1718371385; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NGmpKRkgIHjKMtoAdUdGd2aPwvq/Jsn37fNkdYwGNhI=;
        b=hghTrTSFCEVH9Snc6a9EEKFBSkB3Z94mzeug2DCWRt7NQbzb0LoqcBL4KikkZuzFpG
         4IM88qYLoxAwR95Bi9okEELKOqaacvs6S9KQMDWPSLAuKsOsxy7p4cqJk6ZaKyKs3N/L
         0LA33K8JhIyjRXNTUP5onkZ+tfkwqX0TpeoLICw3IHs+DHBshHB+p8wx8fo7RAjEOK+f
         J1v6k3ZHF0Xu9FntaK6KwaA6zkZB3O4zJbViNzcJDDyICWOY1pVhmqK8LFk68LUepEW1
         wCaQ1+5RHZLSdN3uZDhkwYrnUUcxEqPq0935lrNVk+JRkl9BY6aWqwxFrf0AyrChaG0Z
         yzBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717766585; x=1718371385;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NGmpKRkgIHjKMtoAdUdGd2aPwvq/Jsn37fNkdYwGNhI=;
        b=D6Ti+uJiVeyG97ot3gArUvunmU1dhQqja9uxw0wqOU2Tny9L+ko5DbvB6+QGO2eMSa
         rmRN5lyGmnaZCzcLiNEg9GAFAsTzTefgMjpKs3v7EuicotWqjSr3dR72WAyND995QlOa
         JLdRkPiEGLmEV1JSikQxXRA//Ff+KjEbGQNcS0h4LTHXLFDJ7nqDm5HCEI4I4JlAWm8l
         duA6PV0S/srDSeEOIJOVUxc4rEhBYzcQKi4YE5ezUylTXz8SuJc7IoMBwGkQr3NH1x4d
         RLzyC4p8XVCSxyi4qQ7aCVgr2CBGjxYDn32HrU3ynsLpErI4fqIAEXSMaDJ26MWCB75t
         3kBw==
X-Forwarded-Encrypted: i=1; AJvYcCX4m1Vb42n0L4Gr08nUS6gRm4VbmzYvaOlOST2Z911RmWlGmKGIgZdY80FY5tjWfDJ2NT/GOMPAcbQEJcACUJyNoFP+6UoH5sShN3Or
X-Gm-Message-State: AOJu0YzAe/Ju/zy/nu0EUzwQcaYcil2vb27sR8MWWYI6LkjenCnhOZIT
	cAPm5sMyNHuoMsH+Iz7EZCeqSwniSjObELDqnXWzxd2+9MQR8GRmn475prk6ymg=
X-Google-Smtp-Source: AGHT+IGkFA9sCK5b9UnRQRQ7bRK91vz2yp59ks7G/LIcbZgp/giIrE4JTn7qvXmfHw4wED6xGKgR/g==
X-Received: by 2002:ac2:5dee:0:b0:51a:cafd:3872 with SMTP id 2adb3069b0e04-52bb9f5d36emr1401032e87.3.1717766585105;
        Fri, 07 Jun 2024 06:23:05 -0700 (PDT)
Received: from umbar.lan ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52bc27640easm80944e87.104.2024.06.07.06.23.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 06:23:04 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Fri, 07 Jun 2024 16:22:58 +0300
Subject: [PATCH v5 1/9] drm/connector: hdmi: allow disabling Audio
 Infoframe
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240607-bridge-hdmi-connector-v5-1-ab384e6021af@linaro.org>
References: <20240607-bridge-hdmi-connector-v5-0-ab384e6021af@linaro.org>
In-Reply-To: <20240607-bridge-hdmi-connector-v5-0-ab384e6021af@linaro.org>
To: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Rob Clark <robdclark@gmail.com>, Abhinav Kumar <quic_abhinavk@quicinc.com>, 
 Sean Paul <sean@poorly.run>, Marijn Suijten <marijn.suijten@somainline.org>
Cc: dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org, 
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2850;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=ZpBWCc8zTiSyZgAlt8eDA4MQfiQXS330IXqEN1kPi0M=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBmYwm1CHGwjYZAJiNnZZJ8HIs/c/AaFq8Y/mIyf
 HH+Gf0hfTGJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZmMJtQAKCRCLPIo+Aiko
 1WsXB/9H/P6S1HmWYKfRrVugdTWONtzVxDuCGBYt45omPJNztrXP8WTw6A3d+v9gLRv6UFgPy4g
 OpFHr1h2R6AoPyq7nOeZEW0vJgUmK7xwkehgJAkt/mG3ts4D6tXYBI7Ywov72UgVutx6HJd4CXi
 D3jgL0CDFfLxDoW0CWtiLNZCCJMYOMaLadsD/p25MumWEfohFIyoyYzLxn3W5AhNX8Xzt6DX1ZU
 o1Grx3hkc12HEXSMqI5v8Sw5aOTNcBkIw11JFfrz9ab2i95LMWARG2mnLxOLwIUg2VH/qhu7Fva
 BAynQcu68XHcFKp23k1Wx2A/JAVb4XlttCGdgAPX3gMG7/4A
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

Add drm_atomic_helper_connector_hdmi_disable_audio_infoframe(), an API
to allow the driver disable sending the Audio Infoframe. This is to be
used by the drivers if setup of the infoframes is not tightly coupled
with the audio functionality and just disabling the audio playback
doesn't stop the HDMI hardware from sending the Infoframe.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/gpu/drm/display/drm_hdmi_state_helper.c | 36 +++++++++++++++++++++++++
 include/drm/display/drm_hdmi_state_helper.h     |  1 +
 2 files changed, 37 insertions(+)

diff --git a/drivers/gpu/drm/display/drm_hdmi_state_helper.c b/drivers/gpu/drm/display/drm_hdmi_state_helper.c
index ce96837eea65..731873b3bdf2 100644
--- a/drivers/gpu/drm/display/drm_hdmi_state_helper.c
+++ b/drivers/gpu/drm/display/drm_hdmi_state_helper.c
@@ -714,3 +714,39 @@ drm_atomic_helper_connector_hdmi_update_audio_infoframe(struct drm_connector *co
 	return ret;
 }
 EXPORT_SYMBOL(drm_atomic_helper_connector_hdmi_update_audio_infoframe);
+
+/**
+ * drm_atomic_helper_connector_hdmi_disable_audio_infoframe - Stop sending the Audio Infoframe
+ * @connector: A pointer to the HDMI connector
+ *
+ * This function is meant for HDMI connector drivers to stop sending their
+ * audio infoframe. It will typically be used in one of the ALSA hooks
+ * (most likely shutdown).
+ *
+ * Returns:
+ * Zero on success, error code on failure.
+ */
+int
+drm_atomic_helper_connector_hdmi_disable_audio_infoframe(struct drm_connector *connector)
+{
+	struct drm_connector_hdmi_infoframe *infoframe =
+		&connector->hdmi.infoframes.audio;
+	struct drm_display_info *info = &connector->display_info;
+	int ret;
+
+	if (!info->is_hdmi)
+		return 0;
+
+	mutex_lock(&connector->hdmi.infoframes.lock);
+
+	infoframe->set = false;
+
+	ret = clear_infoframe(connector, infoframe);
+
+	memset(&infoframe->data, 0, sizeof(infoframe->data));
+
+	mutex_unlock(&connector->hdmi.infoframes.lock);
+
+	return ret;
+}
+EXPORT_SYMBOL(drm_atomic_helper_connector_hdmi_disable_audio_infoframe);
diff --git a/include/drm/display/drm_hdmi_state_helper.h b/include/drm/display/drm_hdmi_state_helper.h
index fbf86ff9cdfb..c3d23725f0b8 100644
--- a/include/drm/display/drm_hdmi_state_helper.h
+++ b/include/drm/display/drm_hdmi_state_helper.h
@@ -16,6 +16,7 @@ int drm_atomic_helper_connector_hdmi_check(struct drm_connector *connector,
 
 int drm_atomic_helper_connector_hdmi_update_audio_infoframe(struct drm_connector *connector,
 							    struct hdmi_audio_infoframe *frame);
+int drm_atomic_helper_connector_hdmi_disable_audio_infoframe(struct drm_connector *connector);
 int drm_atomic_helper_connector_hdmi_update_infoframes(struct drm_connector *connector,
 						       struct drm_atomic_state *state);
 

-- 
2.39.2


