Return-Path: <linux-kernel+bounces-434762-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8144F9E6AEE
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 10:45:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B98E188526D
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 09:45:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5C801FF7B0;
	Fri,  6 Dec 2024 09:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CCAJvUX5"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19DD61FCFEB
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 09:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733478215; cv=none; b=MNDZESt134emquH0a6J0GnXKI5H6sL3D5/kncKXjR5w3l5VGpd5q6r9/PJBPaL9g1idSR/lznAbQ332GTY1HCXqBpmyF5RBV+gJVTm3atDMTW9ZnzSEyxEs/pF8M6aPPW200UhZ/OBUCHAyw8aOZK1Ralc5g/ZTINIpgKjlr/84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733478215; c=relaxed/simple;
	bh=AjWhuCZJu09L0XJl9lmri3iZkU99jRBF7lQVFbOa47M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=d7toCW3/1VKIdEqMO3wSPQi389rJwxL84X50dQerikQlX/DCuxKrO6u3aMHr6Czfl4Bx2VQYCrVdsTFuQl2i7WfjrM+71DmUi/zSOT2bmheAynh8mE0xFf4FGe3uaaIeJFcWt8nKkd8ULayNs9EfFC1yrOSkrqsbpK4ofhsnrWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CCAJvUX5; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2ffe4569fbeso28673441fa.1
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2024 01:43:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733478210; x=1734083010; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AjfS6UDkVSnKuZTI4p5OY7qDfSEHNtP2btpHCtUSsMw=;
        b=CCAJvUX56CFYhOlbMhPZ+4P8UkO2TLATNbO9w+T4d6GP6Zq/ZCcqv6yEbtOX1qo717
         p628w7u/4Ew00961aC9Jsdz5em0S3P0+KB9N/+An6CGSWfJPO+BMCKMDbt+Fhuviwi0P
         aOp2pIwx6NPYDpAW5f2SqY+fC4M6oKszKHCikKz64jys7jkA5jxxADOQYkwlPag3giDx
         CcjjtL5Z9SntcKqzg1h5uy1gtyyQa8uoM6Z7HDgzMaBfwlvs0LX12BBsmlFeMuKQkMuy
         gw8PbK12/WY9hIT1HuuOIhX55KWhRMUNDCUUerGUim8L2VfbhvEVz2dVBAmbS0XSeeLm
         /eGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733478210; x=1734083010;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AjfS6UDkVSnKuZTI4p5OY7qDfSEHNtP2btpHCtUSsMw=;
        b=uvTpSHmDQk644QfM+RDgAKsImxIp8cxN0KezGHZztAz5A/tINv479xFnc+5C30x7fo
         fZavdZ8LFaSU0uiwhnFB141QNRW9+5LoWbdNJkS4xEjv0PB8G2JG4mM8IMEu4ZaNPXpC
         7FJUcOuvYbF4BeWEPgGB71V1eThdRcJtZk9AudyNPzgHP6DtlY7jSQaLq7zHLX/kRX/Y
         vHgCwyo+CZ1wHtUlZA3FzA/OU3TrCIrAEm7sRV6H132wFTTrA2I9bP2fSIeQ0+pBzbUq
         kjuD/7/FQtkKEMqXezUVzzB8N/Acq0yqQkvjhrQ7zJ299iR6w6EPe89swshjdBSd/nob
         +8fw==
X-Forwarded-Encrypted: i=1; AJvYcCX/Rbg8/R01Lifz3Z+xYjYdobv/MaBWor8Tdzllcshb0If4BO1skntxwer6JYWAuJId6QXvaKJa6E+97o0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxX9ELoSYJe4CXQhWCeB8nKAujTraj1Xq4ZiJxJAE8Xm+sEvI5u
	Xo4TBYDcdp+bfHGTkaKt+UoJynIEufIuzzDNcL5hriR0YLVL5Kjgrji8sJMdlvU=
X-Gm-Gg: ASbGncsG0PgTQMycUOdDQfZjEyv8rLq8xKzlEz+AMFV8NjINV+EIOQaQE7/+OIDxAnN
	1atONDiEUp68MUiksPL2Z0/h4/Osvom515T9icIkV5Erk2Cw4AkrynNcHL2msUjFoVQXfro0QkX
	z6/lqpqa2vh0dp9BoKEeZRjJlopjm6I46aaVDPivKmG1OyaBSHtMh9ClAn0icqMjOUbHdpCtUK6
	NNP5/+vc+TDXbh3PsOAeUq+vcIjBw6qjymK67ipMJyv3GqnSmoSshX6rw==
X-Google-Smtp-Source: AGHT+IGlcn6F3j2D0eEiigVRHmv//hcsZLDTDwaSW1v+B5KM/LuoTROXlD1yn9Re0AjNw0cch3o94w==
X-Received: by 2002:a2e:bc20:0:b0:300:ea4:4e24 with SMTP id 38308e7fff4ca-3001eac5caemr19445861fa.7.1733478210244;
        Fri, 06 Dec 2024 01:43:30 -0800 (PST)
Received: from umbar.lan ([192.130.178.90])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30020db3805sm4128441fa.50.2024.12.06.01.43.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2024 01:43:29 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Fri, 06 Dec 2024 11:43:11 +0200
Subject: [PATCH v2 08/10] drm/radeon: use eld_mutex to protect access to
 connector->eld
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241206-drm-connector-eld-mutex-v2-8-c9bce1ee8bea@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1057;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=AjWhuCZJu09L0XJl9lmri3iZkU99jRBF7lQVFbOa47M=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBnUscv8mrxYpdnQrN5t7MGxWbI8gUEf4HV9oqdH
 /GygnY/E/+JATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZ1LHLwAKCRCLPIo+Aiko
 1eNuCACvtbdy2xfHWggRb/DI8ZumCyXC4iUXD9iziSzFcEDO8vqI/2fCDKjMpxlhsveDfytOBQZ
 oRdOPeOkoLL3uO62vDV5V2VYiUsdsxy4In6Ro6X3P/aCKb6E/3bVJBjfF1e+BpO4HzEDq5bshin
 Q8sislvKTDt/zFBM9TzroMIyWvYqMXzAusI5WH25he5flEL1wFwcBCMNr+2XOZ0+scdlLKi33FI
 Oi2na5oqsLdlqihifCjf1U3GXLKvDL4fvq79UN3+5aL4Wj6ChZbQ3Kt5ArimSGb7uZURbdsOMGp
 mVjDJQsRZ9XvpdnrqBt0x2sTm0oevUE5ykOyS/V7haBZ9PQf
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

Reading access to connector->eld can happen at the same time the
drm_edid_to_eld() updates the data. Take the newly added eld_mutex in
order to protect connector->eld from concurrent access.

Reviewed-by: Maxime Ripard <mripard@kernel.org>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/gpu/drm/radeon/radeon_audio.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/radeon/radeon_audio.c b/drivers/gpu/drm/radeon/radeon_audio.c
index 5b69cc8011b42b4686c02f97a2b451a63d6c346d..8d64ba18572ec4bb6f6985be3a5edf581c47d7a3 100644
--- a/drivers/gpu/drm/radeon/radeon_audio.c
+++ b/drivers/gpu/drm/radeon/radeon_audio.c
@@ -775,8 +775,10 @@ static int radeon_audio_component_get_eld(struct device *kdev, int port,
 		if (!dig->pin || dig->pin->id != port)
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


