Return-Path: <linux-kernel+bounces-434756-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EF8A29E6AD9
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 10:44:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E0301882FC7
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 09:44:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F8C71F4267;
	Fri,  6 Dec 2024 09:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BicLqy1G"
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBC7F1F9EAE
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 09:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733478204; cv=none; b=a/DUuPKvr+CJ7LB1DVnx/+dS1RX428q9XAgOKNtKqdi2NMMRAU+OKo/lNTV5ysMiahnlt9IOf303co/OntL2vTDb3xJVnGaYhYpzxLwvbxB2iBCKwLlvmJkgdUmsDMJrzLiO+mvIjlO2/RHRY0n5lOC8YoFkW1CgU40NGOKr1Ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733478204; c=relaxed/simple;
	bh=S2LNy/QG/Pvu7jaLQRzV8x9aVeJiuTJJixaJAknwzOI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dr6XXjJbhh8nhX17jm1nVhgZepe4thviJCRn7hWSJhCMX3qz5pPwuyQIxCaZgeyD5kBq782lwJSNld8ZVLtnk5/vBo6W6WkiJgOAZn9tQfhnzK0JTkhBsNtd3P03BfuUhP3CS/vHqx7dHdhjDp9tB2raDb1H79ILVdrR41h7828=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BicLqy1G; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2f7657f9f62so17819951fa.3
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2024 01:43:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733478200; x=1734083000; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Wh7X6NiXjO0ZK0icbu5RRSIlyMlU/s3VBkgppSRGnTc=;
        b=BicLqy1GHsDtul6M54FTDxmspEV8KLfCzEGux/KaZ8lSkyzZ8qT8NGwwk8JQEIiRd2
         LGKTaLL8d+mBCb6w3o8ylAvr41d5S/9cNPzrwcOdf7BNBYXgwGRfQNTJfh/1OlfxHsH3
         qmbu5vuRobTkYq61rod7hkDh9zrHspfJPWqpE2QqGiFekonmD4fD9rqceGGfnfRxb2pL
         Q/CZQkfG7EmsRVfWotClBndg3BnE5H5OOgNL8J0LexKdfthFpUq4/jxM/Sc+YDk54bjZ
         RsLldkeWtG21eBatalhGjBJ9XtrIdo6Rn+3sZepjq26sP4Qv3u66Xn64fido74OdJf/f
         4xLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733478200; x=1734083000;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wh7X6NiXjO0ZK0icbu5RRSIlyMlU/s3VBkgppSRGnTc=;
        b=eN+HFx2ZRkt0o8Babuo3EUp4IkpZBLuWCqiNp2h14TlRycgYe0fRa8Y/sA0xxs2zcR
         7pasm4aW5tAnW7tUoxaAsCZdD+gHQqyjBg+shogj8lYysyRflQxKdtdrEoDS6oIoaMxz
         u2BA0j1BR/x6b2FDp9tUFWNi/ChflWhNoq9QStcy9VJ+x9oyeDrOMoxvXRm7hCZPfOzg
         uKlg5Oaax8kp9TKFvNeUf0tjr5BjprqTlw6LoopWDWUof45QGhBvnFEMtee8giactTsT
         fRNuXTNJk4cu4DkFWFAopOJBpFbT+h9zlWTIttzyf9fr1QDuutF/Or4iZJ//+JTk8dGT
         BCpg==
X-Forwarded-Encrypted: i=1; AJvYcCWtdWRrgWUrR9TOtZZNRnleU7k9Zgri/NYoi3NcWbFydWzLW4zDF3PXuNieEg0VUgH+TG8I/VrHFf/JUkM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKdtVhdqPNdX6Ko8gSGA4BHc+UJmTGAZWa+qUAaut5hhEPAL8R
	qfLKiis8e95m7zvo6H1i/BfLWlZAuceei6F/pPF+/9K4iYp/b5QAhPN8ULxC0Wc=
X-Gm-Gg: ASbGncvRPW83rHYkvI+JZBCcxPPd8RS4L4mx+Mswk389FSBxSVUC5xHKzW8ZjFDPXKK
	u/ow6hFbA2MtU3ztyJVisUNXG8xgVK66ol3SxUpp4/CAxHHNkHsKMgrZOL3qvR2h/jvh++Iskfr
	m7+ubKMl+ymCA8FE3lsNy8/c0AeG7+e852/b/lvJiYJt1wuza8mpc3C9m+LUxP7bRcfnwaqLyNG
	HPJYUEtZsU1FK65tj7OXPcBgBeTP33EVekzOeQMOgNG32+BKx3zOgCijA==
X-Google-Smtp-Source: AGHT+IFBxT03pxchsuAow8zXPe44X5vXMeN6+pzw5XgO7yRZwFTl4DSSqXqmQN/nIOwdAf9XNhMk0g==
X-Received: by 2002:a2e:a90f:0:b0:2fa:cc86:f217 with SMTP id 38308e7fff4ca-3002fcc6314mr10909661fa.35.1733478199996;
        Fri, 06 Dec 2024 01:43:19 -0800 (PST)
Received: from umbar.lan ([192.130.178.90])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30020db3805sm4128441fa.50.2024.12.06.01.43.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2024 01:43:18 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Fri, 06 Dec 2024 11:43:06 +0200
Subject: [PATCH v2 03/10] drm/bridge: ite-it66121: use eld_mutex to protect
 access to connector->eld
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241206-drm-connector-eld-mutex-v2-3-c9bce1ee8bea@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1093;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=S2LNy/QG/Pvu7jaLQRzV8x9aVeJiuTJJixaJAknwzOI=;
 b=owGbwMvMwMXYbdNlx6SpcZXxtFoSQ3rQcT0D+fWrdf7eTuO7miErYRRq/uGdQ1bilxVd2j16Z
 z/vrJ/SyWjMwsDIxSArpsjiU9AyNWZTctiHHVPrYQaxMoFMYeDiFICJpAtzMKxmXrAmIf3sx79J
 n5x5p8lbc0yOj9hTUFTN17jvemrJ5y/aGWJsN90qs3j2HCpJO3d947HLoiufHO66EK487WcPu11
 nm12ex98Nfkt75Zb+CJdfGT4lNHqmtrDVbxVb710nCjUmbrr9djMbP9vtiRfb/tVodHA/9zbjTp
 F0UW+v3VO2sZRl3zl7tlRnDkUX0/ud0U8Cn1rduKSQ9zDX7POhM+sniP9cXR1c0TOtPPZAG7NQc
 23p9xmHks64efKmbr0dkTlrP/cz+ZmZz6Y5SZ2ZxRdyk8vljuq/sP1L23tFZb+4PNSt8KvLEfbi
 rq6MWdlq8X/xgh4O6wU1LBPiahwNfFNvHJtbsfeP697ZAA==
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

Reading access to connector->eld can happen at the same time the
drm_edid_to_eld() updates the data. Take the newly added eld_mutex in
order to protect connector->eld from concurrent access.

Reviewed-by: Maxime Ripard <mripard@kernel.org>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/gpu/drm/bridge/ite-it66121.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/bridge/ite-it66121.c b/drivers/gpu/drm/bridge/ite-it66121.c
index 35ae3f0e8f51f768229e055a086b53a419ffcd9f..940083e5d2ddbfc56f14e2bdc6ddd0b9dd50b1f8 100644
--- a/drivers/gpu/drm/bridge/ite-it66121.c
+++ b/drivers/gpu/drm/bridge/ite-it66121.c
@@ -1450,8 +1450,10 @@ static int it66121_audio_get_eld(struct device *dev, void *data,
 		dev_dbg(dev, "No connector present, passing empty EDID data");
 		memset(buf, 0, len);
 	} else {
+		mutex_lock(&ctx->connector->eld_mutex);
 		memcpy(buf, ctx->connector->eld,
 		       min(sizeof(ctx->connector->eld), len));
+		mutex_unlock(&ctx->connector->eld_mutex);
 	}
 	mutex_unlock(&ctx->lock);
 

-- 
2.39.5


