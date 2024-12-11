Return-Path: <linux-kernel+bounces-441322-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A0AED9ECCD2
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 14:05:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B9E3284D39
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 13:05:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 483272368EA;
	Wed, 11 Dec 2024 13:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dOXl2GZb"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7920233690
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 13:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733922281; cv=none; b=QTIPPiTPynOuwNXuJ4X22qJ9ue7zMaVrUoeln9Op5reBJGB+2HEVHKU0KNzk9EIpTbzRNEUgJbZjckcq2Ub4fGgy27JSI3N2D6r5rB6rraVtJtCrn/8Y293GcPrR09hjUxHdx6syWVcrTGgwzva0fFanw89VUeg9EYmwqNQ3Ifg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733922281; c=relaxed/simple;
	bh=yJyF2pRWoU6DoNOFceA6M5EvvSsiRr5WvZMjlqLU/hw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NdXtPeSPKlsHmcNibojQvTBgFqlIa9Ye3G9yOr8jYW2qGBuopobHZ8BRnND1AwIVsIIiNpnxik3Lauj7F9B+zTrcdMAlW04otCXbDoPVjwk/44Ev+Nqg4wwB6AFEwL2JKTwG8oL4RbAnuVi0RkW1lWiESyy6PTcVZRSS5co7Voo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dOXl2GZb; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4361f664af5so5045175e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 05:04:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733922277; x=1734527077; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=28bZGkoWiLyO5A4XpJ79KUw0LbLMW2C62tX+fuihWns=;
        b=dOXl2GZb/ObuhnlEiggOyuN1VB5s4qtO9JYrEijmZ0D6//4wIshBuk8YqnR3tPTEJi
         2p+dJPGMw4ZHuSrmFrtEHqE3je3AFt+FJF/tJqxlRElRwjn/DaIRKR10vRMN2HjFuRLW
         4YFZncEWoS0WfqnRwGiUK1B/Xn5JDq+GGmH44UjEbMXUyP9qmXmeA+ppfEAOGTypjW9F
         JBHeeN3fPG3nF8XDBcw7WIIXzOsOgJc+mZTLRW0Qf9YJY25jdQlKbT1tHWR9U7M7x5XP
         11HWJpQ3SMWV4rBKZ38BZXfeBXIQ6c1c5JA3hwoPjqJ9m1xKQr9SIGOWAht/HykETYhK
         XVzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733922277; x=1734527077;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=28bZGkoWiLyO5A4XpJ79KUw0LbLMW2C62tX+fuihWns=;
        b=v4mmmd5SHYJWo5/6Nk02BvP51IOByn0YIavG0BYrYwJKIM/gjLoBHNF5RZPoeuPxV1
         bGaWaYRgV4FU1wX2stN/wk3Tp6VQmg9688eBBgtJuhbQRJQyMir7Owkp57sOS72kAuot
         meWH6509ZPIEIH1z4Wh6oU5JsX92z8Luec9iJJeFWFj672bEi2Qi3q/l8FlGPMxAqaQ8
         R9FWjZGaYBDvhbLje2OI+v57UjEs30E5xo0qGuQ/tlcIdPKt7sySaCUhRU8LM5x7rUqx
         rRp7ereExiwbD7lHh+eiLYcXWD3Y1aiXFzsviSKkIYtzzRVLYBE8YW5+AA43+Ez3P8Zr
         RMRQ==
X-Forwarded-Encrypted: i=1; AJvYcCWBAmX8YvQ0xPCS24xqnRTOJN+dRcUBDortkojj7omZp7xRj437XDKKSL4zUsRfWLLsdYDsfaNPHnT/NHY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFuAsWd7J+r9Pg5Tgduv1YkNUfiRsMzyPEVnBtr4P1LIsCHDIl
	uME8zV8GaGylVOEAjPehpmv0KgLSfoD/UFsZhq+wN8bdiAPwUJm9/fnUTMEn0rQ=
X-Gm-Gg: ASbGnctehhKNgMZqkTX6HG58sd+FypB2H2A9LRHlrt/iv4T4jsz2yMEfj+zoK7pCDgv
	c1qbam5ZhFzCGPoWdmzPCESso9GOs21wG0bTSORplZ+243jwOQE4kVdj8aTqYejuH5pAGkk9RsF
	hQTRBpfc0a1zYDqNWCpNdYT+Qjy+fQ2h7rBYB4oc4eseNS9AQg+CVdU4un9vs4CNDv+NDGCwYf+
	kwAp+l2bB7lDf/AipbdvckjxkmtqcOpWZNx1LrscPwXq7M9yVjtzg==
X-Google-Smtp-Source: AGHT+IFZXSfLm1b/QrF6/gmf0rL4rQkDB8lDObG2xoYYrC2PbfvXR4plcwl4l0GsTbAHftPRAcd2vQ==
X-Received: by 2002:a05:600c:3b9b:b0:434:fa61:fdfb with SMTP id 5b1f17b1804b1-4361c3c6dd9mr21544895e9.18.1733922276963;
        Wed, 11 Dec 2024 05:04:36 -0800 (PST)
Received: from [127.0.1.1] ([82.76.168.176])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3878248e633sm1288081f8f.4.2024.12.11.05.04.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 05:04:36 -0800 (PST)
From: Abel Vesa <abel.vesa@linaro.org>
Date: Wed, 11 Dec 2024 15:04:15 +0200
Subject: [PATCH v2 4/4] drm/msm/dp: Add support for LTTPR handling
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241211-drm-dp-msm-add-lttpr-transparent-mode-set-v2-4-d5906ed38b28@linaro.org>
References: <20241211-drm-dp-msm-add-lttpr-transparent-mode-set-v2-0-d5906ed38b28@linaro.org>
In-Reply-To: <20241211-drm-dp-msm-add-lttpr-transparent-mode-set-v2-0-d5906ed38b28@linaro.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Karol Herbst <kherbst@redhat.com>, Lyude Paul <lyude@redhat.com>, 
 Danilo Krummrich <dakr@redhat.com>, 
 Jani Nikula <jani.nikula@linux.intel.com>, 
 Rodrigo Vivi <rodrigo.vivi@intel.com>, 
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, 
 Tvrtko Ursulin <tursulin@ursulin.net>, Rob Clark <robdclark@gmail.com>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>
Cc: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Johan Hovold <johan@kernel.org>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 nouveau@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, 
 intel-xe@lists.freedesktop.org, linux-arm-msm@vger.kernel.org, 
 freedreno@lists.freedesktop.org, Abel Vesa <abel.vesa@linaro.org>
X-Mailer: b4 0.15-dev-dedf8
X-Developer-Signature: v=1; a=openpgp-sha256; l=3196; i=abel.vesa@linaro.org;
 h=from:subject:message-id; bh=yJyF2pRWoU6DoNOFceA6M5EvvSsiRr5WvZMjlqLU/hw=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBnWY3ZmjK9nP2mI5vRrJF2OoY0F6I9GZVuOIkuE
 U9JJNJfAXOJAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCZ1mN2QAKCRAbX0TJAJUV
 VqA/EAC5MeQnOtUM3E6JKASMby2RnxPkjX1cJM9tj9E1A01ZNC8qGF4pIjpJImpXaSxPWi2XB1O
 10dxLgkhDegiDtFYJ2Z1U/fL+hi2prXQccQUrALOPl9VBvg/lqLGigcJNcj51MikceOQOifC9la
 Cpwn9N4Qss+kTr1IlOz0KjGeIqZpGT4+EoA8Ti2Ity8TVRneorf7FXdbwmeawO1SXX15W32DI/e
 C4+4xVdQmeE3Aq/rZXCxHnHNhqv2K2EYqwebsVbhbjAEg2yIRK8BD++k8a9cnROEZ2HTd80wCok
 QWUbs1jiNHeznKyDQKUe3nb4hAXGisDXjL467VuiimNUnZ3ZEvhzmwYJGxA30qmrvf75NPeEW6m
 gUKlIQHk/YmyYiT6a8Rw9Ja5DQjvRKdjE1vyr0dzZqhIW5969Qo+fvSZySqymcTrv0HX/Gy+Frs
 x7KogH+1zd8Q5ubpPrTpvv/2Ntxetgey1kr9o+WhfBvDz8lEenqhy4voXOTrDmZlwQBbUkApbRD
 e5u52Wm0mfFYYv/klst3rYRyHusbQ/a8A7uuLRoGnHU5yjlwOiBXNgpVw20k5AXuSzcdyyZqfoD
 g8iFwlwnWlptrdtgsQ21zXF7Mj65ksD9pukcnrM+e3e7uJe/bHgFFkY8yQ5YjJ/FvJiVzQEkNWc
 g9ko+QTKP4o5Khw==
X-Developer-Key: i=abel.vesa@linaro.org; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE

Link Training Tunable PHY Repeaters (LTTPRs) are defined in DisplayPort
1.4a specification. As the name suggests, these PHY repeaters are
capable of adjusting their output for link training purposes.

According to the DisplayPort standard, LTTPRs have two operating
modes:
 - non-transparent - it replies to DPCD LTTPR field specific AUX
   requests, while passes through all other AUX requests
 - transparent - it passes through all AUX requests.

Switching between this two modes is done by the DPTX by issuing
an AUX write to the DPCD PHY_REPEATER_MODE register.

The msm DP driver is currently lacking any handling of LTTPRs.
This means that if at least one LTTPR is found between DPTX and DPRX,
the link training would fail if that LTTPR was not already configured
in transparent mode.

The section 3.6.6.1 from the DisplayPort v2.0 specification mandates
that before link training with the LTTPR is started, the DPTX may place
the LTTPR in non-transparent mode by first switching to transparent mode
and then to non-transparent mode. This operation seems to be needed only
on first link training and doesn't need to be done again until device is
unplugged.

It has been observed on a few X Elite-based platforms which have
such LTTPRs in their board design that the DPTX needs to follow the
procedure described above in order for the link training to be successful.

So add support for reading the LTTPR DPCD caps to figure out the number
of such LTTPRs first. Then, for platforms (or Type-C dongles) that have
at least one such an LTTPR, set its operation mode to transparent mode
first and then to non-transparent, just like the mentioned section of
the specification mandates.

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
 drivers/gpu/drm/msm/dp/dp_display.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index aff51bb973ebe0835c96420d16547ebae0c6c0f2..a8d5563538bbcd83cf88a159dc86080e2c897fe1 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -107,6 +107,8 @@ struct msm_dp_display_private {
 	struct msm_dp_event event_list[DP_EVENT_Q_MAX];
 	spinlock_t event_lock;
 
+	u8 lttpr_caps[DP_LTTPR_COMMON_CAP_SIZE];
+
 	bool wide_bus_supported;
 
 	struct msm_dp_audio *audio;
@@ -367,12 +369,27 @@ static int msm_dp_display_send_hpd_notification(struct msm_dp_display_private *d
 	return 0;
 }
 
+static void msm_dp_display_lttpr_init(struct msm_dp_display_private *dp)
+{
+	int lttpr_count;
+
+	if (drm_dp_read_lttpr_common_caps(dp->aux, dp->panel->dpcd,
+					  dp->lttpr_caps))
+		return;
+
+	lttpr_count = drm_dp_lttpr_count(dp->lttpr_caps);
+
+	drm_dp_lttpr_init(dp->aux, lttpr_count);
+}
+
 static int msm_dp_display_process_hpd_high(struct msm_dp_display_private *dp)
 {
 	struct drm_connector *connector = dp->msm_dp_display.connector;
 	const struct drm_display_info *info = &connector->display_info;
 	int rc = 0;
 
+	msm_dp_display_lttpr_init(dp);
+
 	rc = msm_dp_panel_read_sink_caps(dp->panel, connector);
 	if (rc)
 		goto end;

-- 
2.34.1


