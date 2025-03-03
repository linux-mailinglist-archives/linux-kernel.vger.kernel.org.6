Return-Path: <linux-kernel+bounces-542014-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 179CAA4C4A4
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 16:17:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23C323A337D
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 15:16:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ABA8214A79;
	Mon,  3 Mar 2025 15:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qCZqWMCu"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5328F214A7A
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 15:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741014925; cv=none; b=MakQGi9ZyjX7jss9Yg2/l3EZmS007L4fcXpCxqRpuhfHM2f1U2/TpeENQF3KkTal4iMHj1eX5NVqPJz1zOF+S6zafeQ6ivw0gAOaLaG0JT1qaAvMFR8ki3ICVCnSh59vFcI3gGoAeQKlcXnkhu7+EtI/AN89XHDEilFVS5Px9JU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741014925; c=relaxed/simple;
	bh=BbqtIHW7JPzSyRGmtZOcXUwUkV9c75Bm5PqICVDkcB0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sOW5Uo5o8/GwsTq79VJO1qTmdoVG7rtHogl7BpKXrKSldBuD0qoFLuBdOfyOR7caPlPBsXYLcjICdhLzLAkBuPEBX2tluYGcI1r+FRqbJ+tWclb5x9x5dLfBFWnXHnxb5a880mQnmR16JuBMh2zmHTtR1YYSfQqYZ/Cp7cQ7Qrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qCZqWMCu; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-22185cddbffso93797535ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 07:15:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741014923; x=1741619723; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Qq+zAHNdvdZOSJ//3Q5rS+vuxV2fvoAwakzSqW6Ri/w=;
        b=qCZqWMCuLAZ3e+VqMgnzYTZim9d0eWeoW0Ho1Gfl/QrxSibYftsbi0JWpzFz7woaMz
         dSKjz8i1WmPeTWmr9tr8+y4sl6sLkfhFhahNYfWgk/601nXHltVSvVewFpU9+tBcYcX8
         NwIkkPerpTWBrGsn0mMOmY5/ULXbMbZ3Sfu06FbyJKcHjFTOz1B4hzvG0DS6QUm0l+QZ
         /R6cOlkv2nQgB9763Gpq/PYWt73WfDjOmDtYTylSJi92w41wpZ/DXQPnAnhoMZ5BQfx/
         NYn6m+n16hm7prdj5ODxk5HV3XUj4Kn7gFrcuvz84scg4+wTblt3/quN1Bg4iP5RAPJo
         sU/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741014923; x=1741619723;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qq+zAHNdvdZOSJ//3Q5rS+vuxV2fvoAwakzSqW6Ri/w=;
        b=YotlydIeGopbzXe1dtNlVv04uJAPxPwJ7tQs9vzYOme77Tx1/bG5SdOkTL0HuCKb3u
         2YvtoS4TyMyFQHjiwx+A/JC3DKnbi2MEe3YShH/HAtzbibLONeM0I3HJJzfE79L3iyl5
         Ka178I3ilxCQxxAv5q+GoERFeblLhg5Uams6jbnAcXYd2KIC1XBjBg1LlfWSz6Jjv7jx
         M0e8FLzS51Yf8n70+lehyp3a+n86/Eo8C1w++hAdQAFwlnNbK9qmh0bAW7nC0T0n9BEG
         HmM6KP9AvmPc3DHn1+2883noWHf+k42wBQwLWrYEmxEjT12PxiE3fgcz9U6pRIkA+cVt
         jiuA==
X-Forwarded-Encrypted: i=1; AJvYcCXO96SUmzP+k7qL5+CR6SDYSgWRJ5ur3i7BQMXo0PPBntcpJHcl+kSY5xrZLsLKf07sgGs5w3wzoQP8hkk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYDeEE6vhWggRStTGCylOT1OVxw+x83ONNqOn1OZTpM1OYUQwF
	v7kWuUlCQ8SQzwPp5budfuKGXgHvcDP7rBXXn+GWYPHJmagOADQFe5vNW0NcIIuYxe5+Zqm9o+d
	xL/KTkw==
X-Gm-Gg: ASbGncsFmdx1tYMz6pOobsUKyoJ43wyxnbxX9EkQYTJ132/cpX3YMuklVlovib/s4YT
	YgnUJNOZd4piZ+XetCNpx9E22Yu6mjEfufKbYnzLwg1Mn3lObEepar6+tYRGklt2t5TkMTyLEQR
	Xuzn3uFy94dJ6wnhy6BVfM8uDYl6uQVPBquuUSdTcBMrA55jpichQOQV4Cc1W/UnoASxV0YQTtG
	IDjGEkqvq8bW+Ur+SzIED3IdB/0F46Wwy0qUbpUyUpA8K2+f+VYdaqFWFLZyjPE9dG+4pBYXCxA
	Q4tOt8OkURwwiPQ+5HFmh5+cHJAC9MLxeFob8nz7gg==
X-Google-Smtp-Source: AGHT+IH8ciiBAiPz51W2tR23I7EbaKEiqHRlhwb3pmWcoE72Do5A2AxJD4u+8qKk0YjyQanKYtbzqw==
X-Received: by 2002:a05:6a00:1310:b0:727:39a4:30cc with SMTP id d2e1a72fcca58-7349d1a73e0mr28617699b3a.1.1741014923366;
        Mon, 03 Mar 2025 07:15:23 -0800 (PST)
Received: from [127.0.1.1] ([112.64.60.252])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-736584b3cffsm1851984b3a.4.2025.03.03.07.15.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 07:15:22 -0800 (PST)
From: Jun Nie <jun.nie@linaro.org>
Date: Mon, 03 Mar 2025 23:14:34 +0800
Subject: [PATCH v8 05/15] drm/msm/dpu: decide right side per last bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250303-sm8650-v6-14-hmd-deckard-mdss-quad-upstream-oldbootwrapper-36-prep-v8-5-eb5df105c807@linaro.org>
References: <20250303-sm8650-v6-14-hmd-deckard-mdss-quad-upstream-oldbootwrapper-36-prep-v8-0-eb5df105c807@linaro.org>
In-Reply-To: <20250303-sm8650-v6-14-hmd-deckard-mdss-quad-upstream-oldbootwrapper-36-prep-v8-0-eb5df105c807@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1741014878; l=1985;
 i=jun.nie@linaro.org; s=20240403; h=from:subject:message-id;
 bh=BbqtIHW7JPzSyRGmtZOcXUwUkV9c75Bm5PqICVDkcB0=;
 b=0UvNk46EPZ4R1btXvQ5qsC6M/xPiIKiZt74mBiD/8nGd1TCcQLFWDWnxpVruAaubbFg3jMisl
 7JN9ORSQifZDKqYz0JrteTdbTxfJa1MxXbP6jYP/s4c7/Fji7JTh7T9
X-Developer-Key: i=jun.nie@linaro.org; a=ed25519;
 pk=MNiBt/faLPvo+iJoP1hodyY2x6ozVXL8QMptmsKg3cc=

Currently, only one pair of mixers is supported, so a non-zero counter
value is sufficient to identify the correct mixer within that pair.
However, future implementations may involve multiple mixer pairs. With
the current implementation, all mixers within the second pair would be
incorrectly selected as right mixer. To correctly select the mixer
within a pair, test the least significant bit of the counter. If the
least significant bit is not set, select the mixer as left one;
otherwise, select the mixer as right one for all pairs.

Signed-off-by: Jun Nie <jun.nie@linaro.org>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Reviewed-by: Jessica Zhang <quic_jesszhan@quicinc.com>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
index 7191b1a6d41b3a96f956d199398f12b2923e8c82..41c9d3e3e3c7c0c74ac9007a1ea6dcdde0b05f97 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
@@ -369,11 +369,10 @@ static void _dpu_crtc_setup_blend_cfg(struct dpu_crtc_mixer *mixer,
 static void _dpu_crtc_program_lm_output_roi(struct drm_crtc *crtc)
 {
 	struct dpu_crtc_state *crtc_state;
-	int lm_idx, lm_horiz_position;
+	int lm_idx;
 
 	crtc_state = to_dpu_crtc_state(crtc->state);
 
-	lm_horiz_position = 0;
 	for (lm_idx = 0; lm_idx < crtc_state->num_mixers; lm_idx++) {
 		const struct drm_rect *lm_roi = &crtc_state->lm_bounds[lm_idx];
 		struct dpu_hw_mixer *hw_lm = crtc_state->mixers[lm_idx].hw_lm;
@@ -384,7 +383,7 @@ static void _dpu_crtc_program_lm_output_roi(struct drm_crtc *crtc)
 
 		cfg.out_width = drm_rect_width(lm_roi);
 		cfg.out_height = drm_rect_height(lm_roi);
-		cfg.right_mixer = lm_horiz_position++;
+		cfg.right_mixer = lm_idx & 0x1;
 		cfg.flags = 0;
 		hw_lm->ops.setup_mixer_out(hw_lm, &cfg);
 	}

-- 
2.34.1


