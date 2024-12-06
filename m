Return-Path: <linux-kernel+bounces-434755-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C05829E6AD4
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 10:43:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6450216C4BC
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 09:43:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF7FE1F12E1;
	Fri,  6 Dec 2024 09:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="I4CIDWrh"
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76B8E1F6671
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 09:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733478201; cv=none; b=bWcmbLDvcI8SNvQ1TUzUjjhj8jnhGVaafxn5KzmTu3gY5GST3CoTFGjrB3ZcZfw8o3vbqAkdeS456zl0qH/wr4Z5zFbGxo5TA91S4OC2EEkgBnVKVfzEhOPcp9PcPOR3LqPYEyXBpeEoY0GRvFBb2rqavA4LGFllDYKZVnhp8Gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733478201; c=relaxed/simple;
	bh=zYvAEMAKJI/pMjPuMCGmB4bmJnIIZvQ3OxFQhHsqYJE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EKbim/1na2nrpBHetmFtnnC8TSPJorc3PNyiy5KFG0dX/rytejx0Ws4rLnfzVKgOceHOphxG2X1A+9FOyVKcLMcdtJnc1VJZxKkSRnVCDBT4bxSaHMPKnIm4sRAxPbpEPN/qVu8yFKnMeOKkTv+ljIuDLzbEaWaoQXwkXBNbUSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=I4CIDWrh; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-30034ad2ca3so1923511fa.1
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2024 01:43:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733478197; x=1734082997; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BXd2OzHxXLbpmSJUeio7TPXwyPaZHSalM8FhliMGDmw=;
        b=I4CIDWrhvKO5AWKXxQ7OxMFlE2m208pgGQOgIjc2Y6oMvBhkSnarTVKWkDtf+23kMe
         nbV73FlBjZ9N89JW+elnxYc3Tvo0S4CKKgwadS4QLgG2o97ld5Wya0vmOxZuZdisap/k
         oOKlBPnajOYDJJUYoWie0OcPo1D10B/TQGQNXBwnAX4yfj4t7NMpyvjAfs44YN8oGCso
         C9qbAdNtXjd1MP5U8Dic99KYdMrllRL+v2Oyx1aPjkpUf97FMbwGwwXOEAbyT8VT9pY+
         i8k1/HU7aBXNEh/9drXAAYI3hSUfXB4+R004UYEehJmuvSSHsUqStzPvRQTbwakPBMQV
         7Egw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733478197; x=1734082997;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BXd2OzHxXLbpmSJUeio7TPXwyPaZHSalM8FhliMGDmw=;
        b=i9R1L5PFfLIy6HMa/ILDIz+ylboyVQynUQMcDdlsh7td2hOf/1Z/eYxY/jm7i21EKV
         IorHbY8baJsa3rDMRTUZ7YDdUIAryqClenPCHcghWUiZekZjQ5Atm9XqwfyfrSGwqXDM
         gI9YUQOrAp65j8bNHQDAd0o8/Lw7zuMyZ7ax1NtyzZFOLofWmj+QH3Kvd+u035lPl4wn
         7yDCnHFeXtc8/gvhTBXNA1T8CUTWEvnMIOW6ahWzyQN3EhVdT1FT/+XgRkxOBmdQiGoO
         LWePX2lhMUV/zHIWTpGVhIeZp1Kr5QgakAPq7400tlAjcIMHVwNH1cUZeTTkb32FhWmK
         iMOA==
X-Forwarded-Encrypted: i=1; AJvYcCV325T918FNCRIyCh38DV941jFZQgMHUod8+fQVe45/KLR/VO0X7HwpIkIRBC6nCbEYhtcS/90uGAIaFfg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAzqwtF+CDiSBaTBO82qUrHrCNYBIOh0hRbtpLsbpqWjsTBmAC
	Bdb5npKhB7X2oQM70Rzac1x2Uf5u5sGudX9bF8EtpuCneGqSNYpWNXHVjhtaXDE=
X-Gm-Gg: ASbGncu1sfbGF54ZfMIOQnlmlp9YPMkTot7eI1E48EukmaJ+Pi7yH5bAPnqWmW+g3aU
	7+oBoZGdSu92bu9whKyBZuPOJrQkGiwQyeRPrEmT403IElLj6cHJCFcHZUXYq2qsCIdjLvera5A
	97SKhYdULCHx0EApeejqW9XQVKoZG1HePYpLN/8d8rgccEhAY4Ct182EmtJgcexVPFOLMBfnKWn
	lNXuvqQd8Hz7yT6htEhiv3cBmTglsCTozpCxv4MXgxXDimJCd2nyrv7jg==
X-Google-Smtp-Source: AGHT+IHOzYvZJj8Vkykxd2x0JSD+NBvzpXfm6jlvPobPhv2vFXWDLmCYeuoQOdT69cvmzqWGVgvY9Q==
X-Received: by 2002:a2e:a9ab:0:b0:2ff:d0aa:11b with SMTP id 38308e7fff4ca-3002f79b514mr6682241fa.16.1733478197396;
        Fri, 06 Dec 2024 01:43:17 -0800 (PST)
Received: from umbar.lan ([192.130.178.90])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30020db3805sm4128441fa.50.2024.12.06.01.43.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2024 01:43:16 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Fri, 06 Dec 2024 11:43:05 +0200
Subject: [PATCH v2 02/10] drm/bridge: anx7625: use eld_mutex to protect
 access to connector->eld
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241206-drm-connector-eld-mutex-v2-2-c9bce1ee8bea@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1073;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=zYvAEMAKJI/pMjPuMCGmB4bmJnIIZvQ3OxFQhHsqYJE=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBnUscuOWsnWIy+09WL6ZmIga61MhuoPN14wFRyc
 CTUUhM7PIGJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZ1LHLgAKCRCLPIo+Aiko
 1QuCB/9GVQCw++i7vtbIm18C0qWy2CcrBgiveGKyYFt0iSpolRcgaG6RbcwjW5qst9mjy3Q6fyT
 wfoOatec5nsxe7H0nq3z0RdLACzVly4qvlxnotelWRdH/BQ6ujFXyFerWcmtX3JM/VBGIQ2IBAc
 cy6kBFVrFFfY0hrjJEvNHpO8Jw7wJ8KQT4IzkIw7DCzBnKyhq7QShr5O2I++bdw+2PCmYR+Ig4l
 AKpe8UolsbHTV1DesMVMTPNQMXDw/veYJp5B5GOVzXYZoSXeg0/Wp4HONWYO6yhjuqBKn4BL1Kz
 Qv9O5BOb777DITYj54ixLYloqlzSi9P0cRUdPa0UewnOGLrp
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

Reading access to connector->eld can happen at the same time the
drm_edid_to_eld() updates the data. Take the newly added eld_mutex in
order to protect connector->eld from concurrent access.

Reviewed-by: Maxime Ripard <mripard@kernel.org>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/gpu/drm/bridge/analogix/anx7625.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/bridge/analogix/anx7625.c b/drivers/gpu/drm/bridge/analogix/anx7625.c
index a2675b121fe44b96945f34215fd900f35bfde43a..c036bbc92ba96ec4663c55cca091cd5da9f6d271 100644
--- a/drivers/gpu/drm/bridge/analogix/anx7625.c
+++ b/drivers/gpu/drm/bridge/analogix/anx7625.c
@@ -2002,8 +2002,10 @@ static int anx7625_audio_get_eld(struct device *dev, void *data,
 		memset(buf, 0, len);
 	} else {
 		dev_dbg(dev, "audio copy eld\n");
+		mutex_lock(&ctx->connector->eld_mutex);
 		memcpy(buf, ctx->connector->eld,
 		       min(sizeof(ctx->connector->eld), len));
+		mutex_unlock(&ctx->connector->eld_mutex);
 	}
 
 	return 0;

-- 
2.39.5


