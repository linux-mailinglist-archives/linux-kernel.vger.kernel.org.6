Return-Path: <linux-kernel+bounces-434759-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D45819E6AE1
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 10:44:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E12291883035
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 09:44:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0FF91FCD0A;
	Fri,  6 Dec 2024 09:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zMTifyCZ"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 454921FAC5F
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 09:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733478207; cv=none; b=oweX2LcDletPkBYuNKIq+kG5TwVwSHEKB539FFVmFVieuiwk7DkFAGWmLveyI+9aYZnc269BD/ZL0iofGNMyWr5xP7n/hbA0hXhYjjBeUXh9SHCn40PcdO9tdZM9p553SXGYoVbtHjarJR+SfoTfqUK6dJR6RavCKHWKFH6uup0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733478207; c=relaxed/simple;
	bh=I1wH9N5enlUiSVwdDRB0wmAdGhFse9ySIo7WNjanmNE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Y99N04jWO1Mx5HgiP0ceDqTvO95XT3p0O6+9vojhkRAvFhlQz4wuDpu3Ycn8UJiGtIM2bXVzsp4djn6MA3ucthdqI/jYFwIFWfDHqsM354CeKWTZ49Ru33S1U7jECz6k0fV88wEucWAarf4pVA0aokY29wMe8kIvwDwrzeJRzl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zMTifyCZ; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2ff976ab0edso19065091fa.1
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2024 01:43:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733478203; x=1734083003; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DR5UNfjajRu4P0t/KAHkaq8u/GtT1QuQGweWq5XMJM8=;
        b=zMTifyCZgNtKN3aR21By3nPi/D2irO8K4vuxD0UBeYLWeFFFana11lOWMgnoUeaySf
         j3RK6V3qR4EvdazHgY2402LnuPeHaoM2pxExEi9GkZiHuSCgSFnC8CxXcWzBJXxxBK2F
         2Dlkc6fRxzTXGrwUf3+31o7DucopTradayayEvjfjQ3uH8i/r+LAkJOUzhAddJrPGqdq
         c0Mk28/cGzZWkW8pnewbaSSGQoVrx1DceypxgBBb0ptE3OMVocprmSjQ+BJQCiPmP62H
         ifJmcvCwf9zVRJ2P9PGrgo126Xzs8qwtk+PWsqHjiYJEzMbuVWQwSNp4xCx5qO3seBTY
         vGmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733478203; x=1734083003;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DR5UNfjajRu4P0t/KAHkaq8u/GtT1QuQGweWq5XMJM8=;
        b=MLdAt4jlGX/DLz+/MF5urZ5VXGPuUr9thSMTwlugVtRarq33BG7RSrVjLgSwr5uBJL
         3rN9TLqKm9lw/5gRxgvaLMa07i5xTZDvjUOBI78Lt+bNZY/OMn4KMKgKsTYbVx7m/cBn
         CL9y1TopHoNyxx2SHQ5oALIF4BLTvG4CFWR4uSFnZj45IcunG0soLLYINPo7OTLEeLJt
         F5UUh2l7FjPsTEWn+P1iv7Irenkc4OMjTbzdPnb8YddlPNvD50zxUqh20RWOu9dJt4nD
         dlOH5MawDjzbE6A6gXrSWmb3ZXqT4OCB1wh4qcAsaZydpHLFNIgy+Kg40N0b8g2QqbTi
         16PQ==
X-Forwarded-Encrypted: i=1; AJvYcCW66xqYZZ2k7DiB0vHb8BD6L0VOubdCI2mi9zCKlfahVDV4ghzTHrelwD+O+NMemefpEp1mVtS+wITFSso=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNdyAEFqUeKgsPLG6wsLUa17QdUUW7f02T/m3McAJykp91+gHJ
	ZaW14lg1ysUvEQxs1kcswluYCsXrzOVjUI5szR0nbWmqiiuAJSVpRpC9RDFW4P8=
X-Gm-Gg: ASbGnct7cB+hAz6GvigCRRlQUc3LyzlqdTTKlKLDLhGbx58gcZyg7VRpH5gf8/kUTYe
	PWdUWKEuPUIj9WXeiEv9WtY23Z3i/7VIjtYypXjzJ8U7w08uAteiKqrEz9i6CVlRNAExUPzoIkS
	XsULnyGphN269sAyJd3okHn8tKj79kOLMTZts+Tn+4aFA44eLQ7nykQuiDk/K3crWpDNH2eXrxU
	9MYSqw9XZweBnsbHy61TaBQla2Kpbg/gJABp068IquDN/Pd2stWb9coOA==
X-Google-Smtp-Source: AGHT+IGCjsHeF9S3xd5zx/P4eEcmZ95qD374mHfeNE0TcJsafXsKauKXde2wl439IjRQlzjjyxvauA==
X-Received: by 2002:a05:651c:19a5:b0:300:eb1:a4f3 with SMTP id 38308e7fff4ca-3002f8df262mr10870581fa.14.1733478203466;
        Fri, 06 Dec 2024 01:43:23 -0800 (PST)
Received: from umbar.lan ([192.130.178.90])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30020db3805sm4128441fa.50.2024.12.06.01.43.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2024 01:43:23 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Fri, 06 Dec 2024 11:43:08 +0200
Subject: [PATCH v2 05/10] drm/exynos: hdmi: use eld_mutex to protect access
 to connector->eld
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241206-drm-connector-eld-mutex-v2-5-c9bce1ee8bea@linaro.org>
References: <20241206-drm-connector-eld-mutex-v2-0-c9bce1ee8bea@linaro.org>
In-Reply-To: <20241206-drm-connector-eld-mutex-v2-0-c9bce1ee8bea@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1061;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=I1wH9N5enlUiSVwdDRB0wmAdGhFse9ySIo7WNjanmNE=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBnUscuTpR0+HiR38S1fTr4ertYoyhKL7gh5Neki
 QVFnX1dWgWJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZ1LHLgAKCRCLPIo+Aiko
 1cP5B/4t0Yy2pHo0bHZjNzf9FSu/qDR8IpkFFhM98PVBn8EV3bNlLhb3/FOwaAYFawC0R7RFsei
 6gC0/YzWxhmMGYPjsOa/37GrWtmPrdHhBZ+KBT63EfOBOW+V3p8zsoWg67YBwUdMuuGRt0u0auc
 DgeeGk8WkE3xEW+/kPD2P0j0s/FWIYP6HpthpzIzXnTLkTKofLtovXgVO4JA7XKTloel9mAL6hd
 YV3thOkL+KoTiLV5O4nnCwLlrkMriaWauaCc/+rcxPaFF/ZnLJwVFuHb04GMj7WXisEfuKJ47PX
 zmzNh+qUndFSRAODqbBfgIEe9P0WLax3l98lRYUC73tWfPVy
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

Reading access to connector->eld can happen at the same time the
drm_edid_to_eld() updates the data. Take the newly added eld_mutex in
order to protect connector->eld from concurrent access.

Reviewed-by: Maxime Ripard <mripard@kernel.org>
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


