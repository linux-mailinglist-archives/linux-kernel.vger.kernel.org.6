Return-Path: <linux-kernel+bounces-426497-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40FD49DF414
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Dec 2024 00:56:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2007E16314E
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 23:56:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3894A1B9B50;
	Sat, 30 Nov 2024 23:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="w0bRe/dc"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3F7F1B5821
	for <linux-kernel@vger.kernel.org>; Sat, 30 Nov 2024 23:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733010943; cv=none; b=mXBd1g6sVSuXrJSeFRK+ZUwF6vfc/ee1RwRAHV/xsJa2xi3mXM8Ls9dk/CH8lQPRdBqCnRgc/uIsW+ZPkFWXhsriD8V43tZQepHcVD013oH6ygwxuZfofQ5MVS43h44gAj333A7RE9VfsrBQeb/TlKW8hJC3/Tn/+xWmILZVeU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733010943; c=relaxed/simple;
	bh=tW4andf3hq3R7WEIVc+7/mi1YkJBAZuwRdePwQe7SPw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gIftr4b3TyfEJ/DbZeG5Hgmn+pS41Qe3p48PEWZfsvkEyxxx1H/POsh2TKuE5jTGg60F4YPDhy7R2AI9HGqms8iEi5Rxh7Dvg3umVOso8HwKXnR134XeBu35AB9sWdpC3rY7Xs2X0OwSY6a97ehnkcSqfauuFKUCGucIrJLyNtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=w0bRe/dc; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-53de7321675so3063314e87.2
        for <linux-kernel@vger.kernel.org>; Sat, 30 Nov 2024 15:55:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733010939; x=1733615739; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4cxY+K4yZx53tAspmDt/c32sXFm2om2yzHiockIbOqk=;
        b=w0bRe/dckUa15PVW4A7JFk3k1MLklX7jJLUIQMNaoXajh885W6XYIyt3JX/qqAWASk
         ljaUFcXL72U0NI6n+sRUb/Vw9SjQap2wDR5nZqQfhqtuQoVPqIvh7GDi1crEp+wNPwCx
         zFQNAangiaWo6SOs1M7B9CAZW3tIzsp9V/jOv0D+KT8qttvIn+acP12i3t+ftbOWgPpY
         I6xG6egcrW0OvTGbck+7xMxuuhdT5JSpQhyVXH56AYa5UHgD86Xvc0MgH7M55IuLp2Mu
         71WlQpt1CfypEEJToE6T0nuBl6uEa6ECkA8lgkqgLt9w7yYBlqa7CAa+dRyjJWNuEce6
         aBgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733010939; x=1733615739;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4cxY+K4yZx53tAspmDt/c32sXFm2om2yzHiockIbOqk=;
        b=evh5wz5szcZu2jqjMENSAqklDdT6iCdZASavlvI2x1CGOG+3LqmtxEBT9YJ+Gs5Fg5
         ieX3fMHirBugMzkEMFUZQCsaJzokeWH75dBFZtqccF4eY8o/TUw5kczcv8F/fYwuD/eP
         HXTOD5hngGAkcctwkLEXdoSMtrcgXRjkdJtVY4s6xiPKE99DRwiPdSo+ITVWEAMEI5f0
         uYrN8doF3VZ3TTnVOD2NVfyYSB98V8hKAbr3t2ny510rnmtstix+j48+H+LlJc4yloMt
         FzDP7C1xg0jl4mzs13WuFR9/uznZ2CsXYWpBFFYnLLksOzvdmNP5ge32g4Mm7ORUyp7y
         2spw==
X-Forwarded-Encrypted: i=1; AJvYcCUeyg9BvoOObJu25Mpka9fGqj+0OC6n1qgI9S7odRugdO2v0ownWddoYl6dVV4pRFcaOIaEBbZrlE1SEyU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0sQZVgDklKD4123DWrBbxTpAmfAXnasqAu9MdXzVoafCrGd8N
	EG/MIJgjFatZJHzwSe9eF/QM+4OFwcs2MIdDmwO17oI1TJSyW7GFTROBw+zEb+I=
X-Gm-Gg: ASbGncvW+INIQN+UXf1wBn4aRkDJ6jLK8k2c7OZev0rO6WHPL1An1trnYKQof73+fih
	WNJyb6pxhrJLlHIP4AxFGunAHgmbMXwYa1+XR9Xvl0LK9SFPI3ftDNyHc3yZBAIOmUcgeL5inKZ
	uRADppt8bkQKPKV3cmf/Jgzq3N00w917a8IjMxB2oFD/dK2zOeyTyq7aMDu91IPn6A9tdL/GYfl
	NvrTkMXPXhUNuTmIozFk8jEPtM0lFU+D5cbh3uMRrjP3xSUk3KrufwaGw==
X-Google-Smtp-Source: AGHT+IEqhH9kCuwXPt69aMI3EvWDASBu5c9Vx1nORTc0e8euAsFhVw9NvHYYoIvx2navJeV6UfeSbQ==
X-Received: by 2002:a05:6512:3d89:b0:539:f9b9:e6d2 with SMTP id 2adb3069b0e04-53df00ff7c6mr10203616e87.35.1733010939471;
        Sat, 30 Nov 2024 15:55:39 -0800 (PST)
Received: from umbar.lan ([192.130.178.90])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53df649647dsm900706e87.195.2024.11.30.15.55.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Nov 2024 15:55:38 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Sun, 01 Dec 2024 01:55:21 +0200
Subject: [PATCH 04/10] drm/amd/display: use eld_mutex to protect access to
 connector->eld
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241201-drm-connector-eld-mutex-v1-4-ba56a6545c03@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1033;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=tW4andf3hq3R7WEIVc+7/mi1YkJBAZuwRdePwQe7SPw=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBnS6XtKnM5W7YbjO8PfgAgXIKJMU347EHoG7pN6
 bC7slgMtUeJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZ0ul7QAKCRCLPIo+Aiko
 1UpAB/98T+k5U79sPWHDEfdVoK/uxOqdWekFRUGXmaXz8lVAUaoc1w3Ob2vgVsHEmXEpRZcEqWq
 bqDqWhVxSkMp+nC/KP4LYMkzeAhQdwu6z7o3M+cI/LhyEPck5mRwoKlsIKia5ENA0q+YRaJX8R8
 D/MbaqjEkVX7h5ODRsXt0b8del0LoST99BcdJPq6yynl2AInKf1mwGTeXOm09nkJ7B6JX9D3N0r
 XnUieG4H8ZtcZAOSBh2bHBQePXm7XUKBlvFoHDklRqI/YU7jyKDWow4es6KEqLKgoa9z5zUayj2
 4MDN8Hi3OJ8XFsnfXmBTUuMae75l5OufjL1fj5yqKjhqazvg
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

Reading access to connector->eld can happen at the same time the
drm_edid_to_eld() updates the data. Take the newly added eld_mutex in
order to protect connector->eld from concurrent access.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index a0bcc62f280f8e80f5d174cd2f567a8ec616e54f..2843283375551b0b85f5f897acdb2aeab652892c 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -1037,8 +1037,10 @@ static int amdgpu_dm_audio_component_get_eld(struct device *kdev, int port,
 			continue;
 
 		*enabled = true;
+		mutex_lock(&connector->eld_mutex);
 		ret = drm_eld_size(connector->eld);
 		memcpy(buf, connector->eld, min(max_bytes, ret));
+		mutex_unlock(&connector->eld_mutex);
 
 		break;
 	}

-- 
2.39.5


