Return-Path: <linux-kernel+bounces-533847-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D7295A45F3F
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 13:33:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 652151759ED
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 12:33:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DAA621C160;
	Wed, 26 Feb 2025 12:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZFUMgEUp"
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1662E21C19B
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 12:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740573183; cv=none; b=l2hHVkOEjNdzjo1AQKBYwU74fIW3Qam3sp7kN9uVgtf9iGXnI+bTejK6xgqp6q4QQNwWi6mBtzCCSY4KUE7pZLvu34MyE9flKF98gBE4hnsMFAc8Wqza89hlpe5rthBKxtu+mjv98PdO/INZfZJqtVsN8aI4lGT//YYMbtiJiyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740573183; c=relaxed/simple;
	bh=6KiLXjEpLod6o/Ty8ouIA+JWP5hGEqwM+aKGxHjhLOQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=g2zEs1qxv5T63HdXgQr38u+oB9kY2y8782LMt1D/TKVBPyy0EO4xA+8ZKUypJfBoz3HAHDLkIgHan15XNY0ENJKJo5HF/lXMu8WPJjj7UyueRQasmn1/SLeXmhAjlhzs0eD0K10nTxdVAOv+7EM74Om8XKEcypqeBMJRduoMxv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZFUMgEUp; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2fcce9bb0ecso12892321a91.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 04:33:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740573181; x=1741177981; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZEgnok+ywGlBannr6oE9rIQ6mvdj6w1AkrRgjoSATVE=;
        b=ZFUMgEUpiwymrk1AsyC4ZLNnuM0DH7KZ98ZyfjKcxGCrNVqvTXqW6IGUsaVvpPE+T4
         /mC8CXHYEIKSbStJC3RE0Q5pcy0lSNhzerjlFLo1grYHHPrAJTdKtW27Tf7mQSAFcRh4
         FDCqq8A7K6Db3xVmiz/IrwFkQRjVP6qxwbkwSyf/JmtS2sidFUfgaYTIhACtWsID8WJm
         uEZRXAjv4XLo40o+MxWKtBeV5CIXvLcsCoP9lkvwD+LHjgiHexODyNlJHoGuMFGkIWD9
         +T2xVHXImkLxM5aQrrsYnX7ghVJrPDTyiqvZNuEoL+R+RCEj80jpcG/kmM1DTMFMYsYk
         PKdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740573181; x=1741177981;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZEgnok+ywGlBannr6oE9rIQ6mvdj6w1AkrRgjoSATVE=;
        b=fnEtOamGDBPZZIQvgGpTCkrN+0Wgq6t2vrYkAiiTdGmhzmqaDF+rcRHdOvXsHiOysO
         nvQVKws9zZrjCzDlQfTsJOOgDte27j4R9CPgssILjyg06a1+vR5MhJ+tU4ls2I1/HC1n
         q9a7bAvwKAvp4/6ekkEMbQTFtEUBN1O259Nud98NXb32vlmPEnNsyQO6RUOG5QbCfEyW
         4Nl5Wmpq4waA79X/zp/RBeizrNnUFd4dadz68yPSvhPjSRnbGxUutR47+h+0ISVylKO0
         d2kFqmcKgNxM53o2b0/odlEXAYxKT29ckFwmfxtISDhPpGfF3bcpkycZ9UmqUT0wLO7Y
         7jmA==
X-Forwarded-Encrypted: i=1; AJvYcCV11H2rXr9DyzAFBwSSVQufFQG2hboXcIHCFlwzWmVSnT+3yBqI8Q5Apa2Fk7SWEokG0KX3yF1TOt8qfUc=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywy8DmykdF0L+7P2VFd9syvCrWr0iYu6/DAU9vvNn8i0iOhercz
	LDY8F1zTCaT2ESVtcLodDnVEP8ghDNgwzy+GXeyg8Mkdk+IbWoSlacttefLYNmE=
X-Gm-Gg: ASbGncvR0PIeqzHCEfdbBA/PUf3yTWHSrcpXREPY0bKJX27AQAnHfi9adQuG2ySEV4z
	zJSrY0o8LrjqPecRhScvdZWzzBkplzb6PAbvPyX9KPtnDf/iQAVt8iUQKrTsyf5JfTPMP13jw7A
	Uc3yhYKEwH5FWl/qMDbuQfCWLwa+kRH3RNU1RgfU9rq9tM0lRKcPxBhmfq8OIZ4FVAbOEFRdVp7
	Yl7dfcEOXFlexa/m86QWg3pT6L6ff1bRtBent+GSYQqous3ICuHeHrLqtsY93hXMncei25owRdA
	3sGhcSgZlFBqRb5LNHo78zw=
X-Google-Smtp-Source: AGHT+IFmJoY2mBo0xxfFQ7Ywn1i3nU3kAa1LrI5vEVOIHrTlfQRoikIpN0oY87mAPA0Vd9oR9ShShw==
X-Received: by 2002:a17:90b:6cc:b0:2ee:ad18:b309 with SMTP id 98e67ed59e1d1-2fe68accf77mr10373331a91.3.1740573181355;
        Wed, 26 Feb 2025 04:33:01 -0800 (PST)
Received: from [127.0.1.1] ([112.64.61.158])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fe825d2ed3sm1352479a91.29.2025.02.26.04.32.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 04:33:01 -0800 (PST)
From: Jun Nie <jun.nie@linaro.org>
Date: Wed, 26 Feb 2025 20:30:55 +0800
Subject: [PATCH v7 06/15] drm/msm/dpu: fix mixer number counter on
 allocation
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250226-sm8650-v6-14-hmd-deckard-mdss-quad-upstream-oldbootwrapper-36-prep-v7-6-8d5f5f426eb2@linaro.org>
References: <20250226-sm8650-v6-14-hmd-deckard-mdss-quad-upstream-oldbootwrapper-36-prep-v7-0-8d5f5f426eb2@linaro.org>
In-Reply-To: <20250226-sm8650-v6-14-hmd-deckard-mdss-quad-upstream-oldbootwrapper-36-prep-v7-0-8d5f5f426eb2@linaro.org>
To: Rob Clark <robdclark@gmail.com>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Jessica Zhang <quic_jesszhan@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Jun Nie <jun.nie@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1740573128; l=1366;
 i=jun.nie@linaro.org; s=20240403; h=from:subject:message-id;
 bh=6KiLXjEpLod6o/Ty8ouIA+JWP5hGEqwM+aKGxHjhLOQ=;
 b=ZO2ghG0JyyoYcOLf/+8cCAyyspMD2kjL3PJ/FnFqbVZ/KuisT8Y7WJMpntuXCbFT654tzlfaj
 DsEgNa1WhsPBBzBPJQT+aa8yx3WzEHxSFrGA0OxCn9gIQF9pcY5QOaY
X-Developer-Key: i=jun.nie@linaro.org; a=ed25519;
 pk=MNiBt/faLPvo+iJoP1hodyY2x6ozVXL8QMptmsKg3cc=

Current code only supports usage cases with one pair of mixers at
most. To support quad-pipe usage case, two pairs of mixers need to
be reserved. The lm_count for all pairs is cleared if a peer
allocation fails in current implementation. Reset the current lm_count
to an even number instead of completely clearing it. This prevents all
pairs from being cleared in cases where multiple LM pairs are needed.

Signed-off-by: Jun Nie <jun.nie@linaro.org>
Reviewed-by: Jessica Zhang <quic_jesszhan@quicinc.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c
index 24e085437039e677e0fb4bbd755a8cb3852300a4..3b3660d0b166d9b0e947b2c918e37adaae8b76d2 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c
@@ -321,7 +321,11 @@ static int _dpu_rm_reserve_lms(struct dpu_rm *rm,
 		if (!rm->mixer_blks[i])
 			continue;
 
-		lm_count = 0;
+		/*
+		 * Reset lm_count to an even index. This will drop the previous
+		 * primary mixer if failed to find its peer.
+		 */
+		lm_count &= ~1;
 		lm_idx[lm_count] = i;
 
 		if (!_dpu_rm_check_lm_and_get_connected_blks(rm, global_state,

-- 
2.34.1


