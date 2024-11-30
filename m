Return-Path: <linux-kernel+bounces-426498-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5557D9DF416
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Dec 2024 00:56:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ECFDB161FC8
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 23:56:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30C9C1BA272;
	Sat, 30 Nov 2024 23:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hAWVdCRy"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDC9117333A
	for <linux-kernel@vger.kernel.org>; Sat, 30 Nov 2024 23:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733010945; cv=none; b=eR8txUZ6bvibUG+o83p09B8V0pPyR0tLVk1VBjgB4D2QgJYBouFc+xZ418Zbek7m8xLeE+JgmdOol8kAUPAHrg3F1wpq8zlVPHRhvWlHxo0mEfr/WQx++jb6rZRuoYdqtLKNgDB9Cv3ZheZml1XY1b0aV46a+qiaJItAGRx5Aic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733010945; c=relaxed/simple;
	bh=IlBBKvhDiY+cvMucjbk73vB6IzNnRZ3+VuxCS/o7lvk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CLkrW7XKnAstVL/ycBgwj12D+foaqt6kSoKdIpsIHTAweromX8+b8ayGuI2icle8TEo+65T4BNkTakCDcFEXdOYd4OHx559q3Ly9eErz0lK8BqtSpxgjWX6j7YwAoaL/hXlfy3CUZ6M2cJRP8qVgrqILdNnTh5jiw0USVOVXMn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hAWVdCRy; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-53df6322ea7so5143213e87.0
        for <linux-kernel@vger.kernel.org>; Sat, 30 Nov 2024 15:55:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733010942; x=1733615742; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Xien0N58sB4iffC9+suYdwxKcgrPQSZoNIx9TfZkSKE=;
        b=hAWVdCRyjjbK+tmx2kI+d4SnwGeUwn2Xj/9MmE5yhYqBFLKdvq4qeRXbr1fg8QR5ls
         a+sMH8AJ/hC98Ohk3Ik4KZZHdAgkHOA2D7d9QWWlPTmDElTHYawriZzS1/ooS3dDnKx1
         HdXOQJmNOv012qe2JvLV/hICxqGdxxIA4EYpv2vqFCNCmkBJwEwhatUM9Wl6fa4qaPN/
         Eog2Y/Jhzd9KXMFAHBPjfVXOggN0g8Cq8NWcYVZOyv7wl2sm1DV50KfAKOZpwGPuW8El
         qTYMnr0S0a93awU2jh/7WuF4Gvs8J5FcxwEAog9EddzBoCVT1xXg773dc8gcvdkZ29Np
         pPWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733010942; x=1733615742;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xien0N58sB4iffC9+suYdwxKcgrPQSZoNIx9TfZkSKE=;
        b=pJpg0gdkapQT3Y7oR/jAZ7b73wEU/ezyPg1UIKW6Qsn201Hn3AX9DGpg9A/5r78MRt
         8UPbY8YQq3h4QwxJRtqiGY0u68XGaKqAFVjAwbPlfG16E8y5jElMSgVpr3ZToE3ogaCh
         AJjyz2nDbjHjPAvXbO3ZPtdnnnuqxzd9EKay0dSD3BTNVj+d4bxbnMlBgQvF41LMKAT0
         ynifiEMgaaRwGkrX+claKY5SeMe30krG2rGCL1f+VtOtxFn3KEK4EZOAB85f81a1mejH
         6EXNLapWowF0qh/yDp3sZBI6oXA+C0HrwhO7T1A2SBD1Zz5Ec058GRG07umNBTxziA1b
         EH5Q==
X-Forwarded-Encrypted: i=1; AJvYcCXVp54LmS8Qrea9Kjy/XHoBEQszRlA6l4NPCjCBqz9CQPyo78y2hV1aeGNoz4g3rserl7ftgY1isUp+UBQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9Xd3bpWSPSx2x5Jl+knJasvN7R0OejuXL+9QTxIPo0I5O3P5V
	jAWikCCTjSuSqkt/cmkko0J9FByox0oaR0iw0+a2meisdq2XNbrxnggFzY9g8cM=
X-Gm-Gg: ASbGncvPWnPLnEUdKVoQ8b7wc5exOPXmt3ArUc05rdIz83TeF67gssEEG/ITtvRGNX9
	x+mwlKkzD4nAWljdlquHvxEvJpywnbULjxOe+2ZSLNfxQv1dRRTE/ujMd5L4H/8DBXzKzHg+tQk
	dY31TRlhngJAyuFdJliTGoZxBnz+ESEymUNy7DrZ58lFe1y9UuRmdr0MopCcZky4ogdlJxTo5QN
	wZ5KPBI+D+6dWgA8cKKn4IAs51ha7PZ+TaXuH1FpZXLLMjhRjBRmlm+CQ==
X-Google-Smtp-Source: AGHT+IEoIeugoET5BqjT6NRzZzzy0ZjjP0TBRwdTQ5WPutajVCKBkgCZ3DW7I0WGOJti6hbbaxziUA==
X-Received: by 2002:a05:6512:3d86:b0:53d:a3a7:fe84 with SMTP id 2adb3069b0e04-53df00a96e8mr14561366e87.8.1733010941990;
        Sat, 30 Nov 2024 15:55:41 -0800 (PST)
Received: from umbar.lan ([192.130.178.90])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53df649647dsm900706e87.195.2024.11.30.15.55.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Nov 2024 15:55:40 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Sun, 01 Dec 2024 01:55:22 +0200
Subject: [PATCH 05/10] drm/exynos: hdmi: use eld_mutex to protect access to
 connector->eld
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241201-drm-connector-eld-mutex-v1-5-ba56a6545c03@linaro.org>
References: <20241201-drm-connector-eld-mutex-v1-0-ba56a6545c03@linaro.org>
In-Reply-To: <20241201-drm-connector-eld-mutex-v1-0-ba56a6545c03@linaro.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, 
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Xinhui Pan <Xinhui.Pan@amd.com>, Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Phong LE <ple@baylibre.com>, Inki Dae <inki.dae@samsung.com>, 
 Seung-Woo Kim <sw0312.kim@samsung.com>, 
 Kyungmin Park <kyungmin.park@samsung.com>, 
 Krzysztof Kozlowski <krzk@kernel.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>, 
 Jani Nikula <jani.nikula@linux.intel.com>, 
 Rodrigo Vivi <rodrigo.vivi@intel.com>, 
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, 
 Tvrtko Ursulin <tursulin@ursulin.net>, Rob Clark <robdclark@gmail.com>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 Alain Volmat <alain.volmat@foss.st.com>, 
 Raphael Gallais-Pou <rgallaispou@gmail.com>, 
 Dave Stevenson <dave.stevenson@raspberrypi.com>, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>, 
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 amd-gfx@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org, 
 linux-samsung-soc@vger.kernel.org, intel-gfx@lists.freedesktop.org, 
 intel-xe@lists.freedesktop.org, linux-arm-msm@vger.kernel.org, 
 freedreno@lists.freedesktop.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1012;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=IlBBKvhDiY+cvMucjbk73vB6IzNnRZ3+VuxCS/o7lvk=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBnS6XtFcmUlMe9gPJdYbealc8FI/qrUiornp5Sz
 cmdQjBUbCqJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZ0ul7QAKCRCLPIo+Aiko
 1ZUyB/467hRM5fIPQYymRfBPSsYEC5gNFcEsRNSKClp6yBUjqbuT5K54U8veccTLagqpg6mrQHB
 sJYGNPnkUEjnK/JULDL886lHb/pd7SixyezCY9k1Mvf+/vpb3UQCr09dSOMw30NiV6NkWvyKje3
 BIlrF/FZ/tS1DHxqV582BXI4mw5v2jinlQQFFXaTrs/2hLdXOEQ4QHa+nzNK2KyOa5RBmbNeNVm
 uQ+khov3pAbgUTXsoLh/W7vnwwJOU8GBcFGjx4o9CWpP8W8q76JzryVKmf3dp+2WCcFdRfvArJ2
 8NknAwK5Hx6FXILV/EdSpHepfGGp/Zv/ytvXybjv5g6YrJ17
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

Reading access to connector->eld can happen at the same time the
drm_edid_to_eld() updates the data. Take the newly added eld_mutex in
order to protect connector->eld from concurrent access.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/gpu/drm/exynos/exynos_hdmi.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/exynos/exynos_hdmi.c b/drivers/gpu/drm/exynos/exynos_hdmi.c
index c9d4b9146df95bb46cb6bea4849c331616c2b463..6fc537c9048f5c8e57e30f083121c9aea6b99a5f 100644
--- a/drivers/gpu/drm/exynos/exynos_hdmi.c
+++ b/drivers/gpu/drm/exynos/exynos_hdmi.c
@@ -1648,7 +1648,9 @@ static int hdmi_audio_get_eld(struct device *dev, void *data, uint8_t *buf,
 	struct hdmi_context *hdata = dev_get_drvdata(dev);
 	struct drm_connector *connector = &hdata->connector;
 
+	mutex_lock(&connector->eld_mutex);
 	memcpy(buf, connector->eld, min(sizeof(connector->eld), len));
+	mutex_unlock(&connector->eld_mutex);
 
 	return 0;
 }

-- 
2.39.5


