Return-Path: <linux-kernel+bounces-434763-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E05709E6AED
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 10:45:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9CB822823B1
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 09:45:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 296B01FF7CA;
	Fri,  6 Dec 2024 09:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Rbsh7qLN"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA1091FF7A7
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 09:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733478216; cv=none; b=Jamrf2kqPnBYSjHks6ZdA1h+zDPjN9C2wFgVnMWcFStC+LbSad8O8JUUl6IHCaa4SWAXj2mGuhAZlKpRt4oqRqO7+b7XVy0xNLofbH3NIW0COOOeIZoWdGFogZwLwNOVHOs3INblpa/JR1k261qU2+IA+kiyRmbzTzP8+ofGNgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733478216; c=relaxed/simple;
	bh=T6JPeyhrynxKGaIZwOdTxaj7xNpnpZ0LTNopG/6n9Zs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YtAmJJZgeNd4U5p0A4yBeeLisntdrFATQaGY//TWi2HOp0vMSm11IsVdI/Pp08rqXHAScyWaZIVA/p+ZYmuOq/MAwDtvB4hZF/UyT29Iqj65CJEeHXNHl/SDRW3K2wfJ3ubiDXznf7fotFjMOHlKJ+uUyoMBNOYnWUj3mXndhZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Rbsh7qLN; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2ffa49f623cso19396081fa.1
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2024 01:43:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733478213; x=1734083013; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZkigUKob5Mc9L+QSG9Cb+AQa6odUVvq9Ya0HTSeW6cY=;
        b=Rbsh7qLNujyPUFQKinxIN0Ng2skvZKA+NxG5JdezxXKgpGWF8BBpIGILxoMe7V7b4h
         wAjBLdAdrLprXb2yr0Bm2t8ix8bBIwj46kT7PPzcS6FPNeWOC8ZPLpVymvwhS7/wJ3xr
         EClxmZt1FdA10TkQh0jb0o+Xh2WonncuqEORr8EtaLVCgM5HTPCp3wlPiewU1F6v7cS/
         RIe+UNy4HZ40pYmafo44uTIeG37lqmY8KkDya8UsOJpq+jNP/MRo4FuBa9A5KRfYP8om
         v8c9xFcEbWEPPjHtB60RXoN1/7E46r0O4oGzc3PWOn4/oX9VLMqmi2iNorBlkm7IRjE7
         Su8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733478213; x=1734083013;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZkigUKob5Mc9L+QSG9Cb+AQa6odUVvq9Ya0HTSeW6cY=;
        b=lxJYhRhabuJ7iC5BFdP8sDVG6UeyrkfPtlGIq0pZvkMDrimOsArsySrRb6pOl3TX7N
         y8ZKmnP/GNn/SXcEdrz2ELlI7lfPpTwX6A76CbgMcYChsT4XvcJ3TYDk8rH2VpcVO/VR
         fuERtTGPbWdi+bYPyUQqgpEPkUKYbAQDDZQq+w5492mmESByGP3GG4g8P1gGzEFkroz7
         KsY+BKGQ2+A18EqAnoBzD3WUR2uj6u6wuJI9dAeMk7UVyqACdEfVzLMzfg2wGe35eBmx
         /T86ZPuxbZZpMQfvbvWS7gJdZ4+MDgMFYjFiZ780HohDO5tXNinYTgoVT0jFr1MBRHiA
         vEZg==
X-Forwarded-Encrypted: i=1; AJvYcCW3fyIgSAmi1VphkXi228rBcuzQv+w3sB5kODtmgKS6Rvryl86Ut3MA6CQfYlEpnAYKLdqH95vBvrjjJ2g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvL58fjbiNryg9/PxvIGB3DfiW2u8rNyXosbEkoJ+FdqM+A94S
	eK7h3wqECBphcb1Sq8RR9yHwvZ/peRCltARtltYaX1tXljVklv3KEXXFIjszvCk=
X-Gm-Gg: ASbGncv1YWdgr1SK355FeJkUNPlcmkGnqj+ygl1x7+5Y5w8PxXHD9Dp/aNQrCtj/5Eo
	S/+MI0culZ/jEU/qNe6R1MEQGG7P0WkCca6PjJ4Nf4orApbT1FQzNvMUuvkuf4AsiR6WI6UPICu
	BOYnaV6cx0yS7uW3h/N0hXKHAvEuL3ZV4nK1aPpnH75DB2ZpgJ5BX+YfDGZ88dEO1cDzgULE/RF
	Y2LdfWxSlmIfVufYBB+AtZ6sHLWWCQdWxhCtVrnJ3T2IOSLT0p0jUoysg==
X-Google-Smtp-Source: AGHT+IFnWgDd0LQiOOyqxao9HQ2SRRt2EDypVuazWQgG9g3xYWmvYLAFADof0/JzzA41KcgjmV4COA==
X-Received: by 2002:a2e:bc12:0:b0:2ff:d81f:2d34 with SMTP id 38308e7fff4ca-3002f89e73amr8312691fa.8.1733478212768;
        Fri, 06 Dec 2024 01:43:32 -0800 (PST)
Received: from umbar.lan ([192.130.178.90])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30020db3805sm4128441fa.50.2024.12.06.01.43.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2024 01:43:31 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Fri, 06 Dec 2024 11:43:12 +0200
Subject: [PATCH v2 09/10] drm/sti: hdmi: use eld_mutex to protect access to
 connector->eld
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241206-drm-connector-eld-mutex-v2-9-c9bce1ee8bea@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1066;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=T6JPeyhrynxKGaIZwOdTxaj7xNpnpZ0LTNopG/6n9Zs=;
 b=owGbwMvMwMXYbdNlx6SpcZXxtFoSQ3rQcX25kP/6099+Y3hx23Dzne8aLO9XzJFZb9z4/HOYm
 bH+tPU/OxmNWRgYuRhkxRRZfApapsZsSg77sGNqPcwgViaQKQxcnAIwkYJV7P8sEtsYGnS1fHZY
 N6v4y56cu637YlyXwKadV03zMlc4ttxq3Crwz6qYV7CtsrDo9MHlXvvuuuT7v7hov3+iOGuw84P
 eOuPsuE9iV7LLFxUsPR5gYsiefjVFO1nyt2usyI6ibhPhj7UMf39E749suNgw22P/LxFtziC+Tn
 WRtWELrrEc5tq9toNNREI5uXeBpOlzlubMi7bXX1sfPDcrdsf/x9liHJvac29p84ZL8z2dq1QgM
 7WlwLDhy4Qy7cfXWq0FX/w0s3kRpWmncvTdkXlJk4OKo1obHuSqT/3/T0mjdGMFO+vbmWI5eW1f
 jWc/nph+IGb3ku4TXWv7Lms/8ba/PcPz0OyqzlDRlRoPAQ==
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

Reading access to connector->eld can happen at the same time the
drm_edid_to_eld() updates the data. Take the newly added eld_mutex in
order to protect connector->eld from concurrent access.

Reviewed-by: Maxime Ripard <mripard@kernel.org>
Acked-by: Raphael Gallais-Pou <rgallaispou@gmail.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/gpu/drm/sti/sti_hdmi.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/sti/sti_hdmi.c b/drivers/gpu/drm/sti/sti_hdmi.c
index 847470f747c0efad61c2ebdc3fb3746a7a13a863..3c8f3532c79723e7b1a720c855c90e40584cc6ca 100644
--- a/drivers/gpu/drm/sti/sti_hdmi.c
+++ b/drivers/gpu/drm/sti/sti_hdmi.c
@@ -1225,7 +1225,9 @@ static int hdmi_audio_get_eld(struct device *dev, void *data, uint8_t *buf, size
 	struct drm_connector *connector = hdmi->drm_connector;
 
 	DRM_DEBUG_DRIVER("\n");
+	mutex_lock(&connector->eld_mutex);
 	memcpy(buf, connector->eld, min(sizeof(connector->eld), len));
+	mutex_unlock(&connector->eld_mutex);
 
 	return 0;
 }

-- 
2.39.5


