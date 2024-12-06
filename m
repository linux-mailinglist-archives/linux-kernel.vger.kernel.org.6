Return-Path: <linux-kernel+bounces-434758-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33AE89E6ADA
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 10:44:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6ABA816C46B
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 09:44:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E1A51F4276;
	Fri,  6 Dec 2024 09:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="quko07NC"
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2D5F1FA251
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 09:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733478205; cv=none; b=gc2Q35gPu6pbnvBZM4ffV17IgzW/+e09QH9j9B00wfiTCY6izDDD8M2lzKmnpkWHm9Ch0J+tAQeQqiS7iMdTBn3kGkFIT0ORkEYB0CuJHCg6peY40YIjyMvavcoprQgYxtJdFJmdfdXGrq2yx0QJgcmVIBe56krFqubzTWcaM7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733478205; c=relaxed/simple;
	bh=xBnYTDnWSnfj2+gm2t5bxnQqQ5FnybkVoMOlzhUTQDQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VPNDrbVLmWyjud8mAXgcjnhZU6hTsok+VnpC+ANWG+ovl/PDEga5P4sMIwJZKBnBKlko5fgFMkFjvc4cPj7X6liCZb0IkGgI1grS9609euY5td3iIpO/fSRuVtJmEKqOXilLaXh8Xtihd+WaPekRKaOIUKqueOgpfoK4wGqkpUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=quko07NC; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2ffe4569fbeso28672161fa.1
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2024 01:43:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733478202; x=1734083002; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AlZ85fU7bMEdCr3Ivk/JPNhlYCX1et1nGUUrgQd3Dz8=;
        b=quko07NCXqWS0Xgi6LIRAYHEReu+9w+oFREWo2Bq2kwuku59n9Ebs8f04BkQVCxbES
         +kl5x4SUW4SFTGp4aolUqwQFhBZbwCd4XCMMk8kACEoK6fWt+4lHlWtBxuBTOIlItbHK
         MW52XBr57yk1UXihvM0hu3rlkiJBnAzA2s6pfWTJCxUex8MvP/uHBuMN7kYubKX9rKp3
         LRXuhnzsMvIbvVljSugrcvc9ILQiKn7L/zy73NO4g1+jNxu21UYn2RPLGQ3v5S9GnJNP
         E2AYeLdeun+MOjrFRKMIQdlsimDVC26AP4MIGQwJ6i3iE92pZMOgtuJiGYn01VRKJxsI
         IMFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733478202; x=1734083002;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AlZ85fU7bMEdCr3Ivk/JPNhlYCX1et1nGUUrgQd3Dz8=;
        b=NszNWEFBptdYB1YrcLD3vaawSttM+VI/VxNSJAwfkMiO/tJsSiwv/K4rr/N5K44CT+
         P6+fOyriIoDSwfTfKvadxc99K3w8ha7swrWRdL9WQZMHo0KLJ7+CJQhDqYsV/8t+kJ45
         qvD1u4WIjeMvPalvKFIERrvCYcQKGtNhrGIk8CUlgjdTMPF0tjqnvrImqg+qEt5PT0GK
         Jgfwo5wwaTQBAxQXxcaEPPtxjHUN1IMg0NR7ZVGM70BZqTrlJcp5tB/LLcUbnxed4OI+
         sWbaKMwqbUUsllogvKOi86Zz2v36kNTzOEpfRPVZSoLTLvFQJH2Rrk5pGZiXZFdro9cV
         19gQ==
X-Forwarded-Encrypted: i=1; AJvYcCVXXh072nnBimvL7HqT5tpEms5dWiAW9dxQ6+MWfyNnygDFpTCNSuETUgqQrCZj/NZH3Eqb69WcFioGuYA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzP8iqDkvTPuYrHqjQ/bTBFicPdNthskCB6nXKguDGWf0aPiOfQ
	fO+qZwiS8OrBp/xaeS5CJyQuXLHd/8m/OmR0QuLj8p8rfViVQLV18/fn681FpzY=
X-Gm-Gg: ASbGncs+M+JAny3DqMuKoRfUjkB4PKuzAQSxN57JiKf/9otWWrpQq++Y0nxJksSr/lU
	ltaaGdXhJDVsfBUURfLTk652L83zcw7zB3fe+1hwJ1vJ+8hfnUlzv358u3KJBfoS7t9wxsoUAf3
	XknbCaIPDisqzN9FNyxnJLiPChDcmsmPQMMX8UR/YeEJDDtAGBhmPoWN4wnkkcudaEL6HnSAeUz
	GJIXt25PuprmrSvTVOT4OAXm5YKe9FZqbKrlUG1abaTop/+OArgqvgMMg==
X-Google-Smtp-Source: AGHT+IGE6b4F5G8fB5UzCy612X2zS/z9Gws1TIKohedsOmxkKxomXTuE6wjdB8eKM7SaKj4xHi2otw==
X-Received: by 2002:a2e:a9a6:0:b0:2ff:bf0a:2226 with SMTP id 38308e7fff4ca-3001eb8e67dmr19885601fa.17.1733478201781;
        Fri, 06 Dec 2024 01:43:21 -0800 (PST)
Received: from umbar.lan ([192.130.178.90])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30020db3805sm4128441fa.50.2024.12.06.01.43.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2024 01:43:21 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Fri, 06 Dec 2024 11:43:07 +0200
Subject: [PATCH v2 04/10] drm/amd/display: use eld_mutex to protect access
 to connector->eld
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241206-drm-connector-eld-mutex-v2-4-c9bce1ee8bea@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1082;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=xBnYTDnWSnfj2+gm2t5bxnQqQ5FnybkVoMOlzhUTQDQ=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBnUscueDleWgUKJKAcLnM9AVfyZmdn0HpKF5uCT
 kBmRHGm9H6JATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZ1LHLgAKCRCLPIo+Aiko
 1eleB/9rtsqyEXNmADXNUhLtuCtrT54s5AaOypZT19JWbxxkqIS98oj7wNLlcf7TA1rOQTNS5RC
 dvsjFVOL4cizIF20+Xp8TdJpnBVVRKORmoXxY/g+sGQsD+EyOh+b04CJUaXVrWxd8DJsAwzaO8w
 75HquG2asaq4K33OkBPkZ85wATKlXdb9yjA+34HEfbGr4Dd71VsgTtQ3Ozs0zJ7lDxU778quIl/
 b+/N+ADy5pyhsVGIAgmAr74L8TzRGdbpMnzmSPT2IwV7qsqdNr+KY8fyDGlhRaj2FA4wIhoLac1
 9tx5/gz16qNpAiJ9A8ijUf1L2Ck59EMtUlTVlC/at/0sY+sa
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

Reading access to connector->eld can happen at the same time the
drm_edid_to_eld() updates the data. Take the newly added eld_mutex in
order to protect connector->eld from concurrent access.

Reviewed-by: Maxime Ripard <mripard@kernel.org>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 19a58630e774029767bf2a27eb4ddf17e3c21129..04c68c320252b5ce9647f0606fb86fe57f347639 100644
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


