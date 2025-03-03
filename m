Return-Path: <linux-kernel+bounces-542015-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D026A4C4A7
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 16:17:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D2633A3152
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 15:16:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08978215F6B;
	Mon,  3 Mar 2025 15:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IFM4aIYM"
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08B40214A68
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 15:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741014932; cv=none; b=mI30a9/eySgEltW6DhA1F/4ejY6gii1e4D9rCUwzS8ePfwbQWQrI8F2wmRfiPWRH9AN0qrcOH64ACJ4kUqVs3ReEvZ/n2rfH25Objldi1e0g7yUFAU6JCfhf2TDkLlc25FglIgmeT9i/FvCdXHJDlP+AdJ0AY1OrRcBsxhy0pZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741014932; c=relaxed/simple;
	bh=6KiLXjEpLod6o/Ty8ouIA+JWP5hGEqwM+aKGxHjhLOQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lftzI36qQIACbaSPAceAusLrJQL5EPChagOBZsEXog+66x3rpdgL3POd7qQnox+7KaDAoGw3M1NhZtIOiISqUdnP8k6Hj2MSoRfm4rsthDa1IBDoxjuAXSjMDboGhd8iB4RU7g2SwwjmvOKwxE5LhueL7me1UUSEfxw9Si1g848=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IFM4aIYM; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2fef5c978ccso2101707a91.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 07:15:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741014930; x=1741619730; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZEgnok+ywGlBannr6oE9rIQ6mvdj6w1AkrRgjoSATVE=;
        b=IFM4aIYMmNKquzh3u7i0OSX/rB0bh0Dj2zS/sCgQD4iHGAUt+GuUyt0m2X3GsYk6uH
         QGEQIrjhhNB77OlZe2IHH+ZIW1QNNfHEhncpJrQtSL+8s11qqZLd2BnNmnyY2ID+ztES
         qHl/GbqTzDc6Fh0cYCP5qZC/yJTLYk0cL6OM0f7N1GEHOVSXdqE9bs1j51Cuk2aYpQzs
         4mS4s7x3JrnLgSJaCRb/6qV1W10RGbljfHoWKnCGj6QqilmACfom9PSgFF0Lex94F4o0
         m7PnwGi9lh5euflVLXABTZ8FTW+UZ9GxwwckDtriXXg4euXavBNIGEE1SIFNz2lSoG4f
         pJHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741014930; x=1741619730;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZEgnok+ywGlBannr6oE9rIQ6mvdj6w1AkrRgjoSATVE=;
        b=VEYIASgO+HyAEHgUB6Oq0l5SFkWJi0wFAnFYJ6WW5lQ6ZyyiKOfd4DIuQPFlBZnXcQ
         uLvQF1ulOpE01uwFohNsC/a1Bg9U8GG12xpew1M0xorQvZ/f2V9W5S42pvTzZX6dEUg+
         2otihZb2PRHzDi7PpLMYQul7SU5dnontAeLqvasOc86Lhny8HlwnXIJpmogOIcmZeG9p
         T6Pk1P0bEigQRekIOSlq8kY/A/M60VEZRn5qebm33N6MqO/MV1OFXs92S+GZCOi6UzM+
         +rSjRO9jhrXLIupnZ4+9qZNV+zwWRKha1Xpl2PxpFfroq2jKxLOz39jkk3x7XdEP7B4i
         y13Q==
X-Forwarded-Encrypted: i=1; AJvYcCVB4XfyhgFBI0MzWKDTthTbXsYoKGSsoCHBCIflE+keJXYElPdCz6Q4Y7Dqc9RFmKft428UjzD4NF6yczM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbbKADyVl0nVSnWCPcHp0v78fnnfcpIAv7mx8EfxbXP7UAf2/P
	xJ5048d3pl03ItbvWCvkpo6UImHACkhW+O4+H+19hrYlc7cFPg3fnRv2KEoS/ELpJhdHEXC5zvH
	61Hr9KA==
X-Gm-Gg: ASbGncthSBVnJCT/LLusbDA5ig6KoJajxQM3oaedz0ZWaBx+TYYwzKV2Gpfxo+3fzn4
	WnhiIkq98ROtRdAfgku/36xqQMcncYiNeKuF+LACLDEzaux3xdMAzYlPHKQUvr27vRMVcm59+0G
	OUpQ+P4TBZpDw52WTfWO4ti1dMeo4tOOpW5erFkBK5yQlEDA/XgC210MY+Htt5A5g9aoe0EIbK+
	7KnU92whQnOe+PE73Gq2024LArCk6Jw2ZLdops/KgVnUmlWc7N8TEjmVx80dmq3HYQ/Bt5PjnKO
	0GeaEbi0Ma1FmO+tXC8FkMQIZ7UoZ+9C+eczvbkFhg==
X-Google-Smtp-Source: AGHT+IHgPd7hB7yPXWWisVd5/ez/yv8IIykroy6iDLwr4GSkdS1zMX0dZhCdL6RsY2usvlf3TSat5w==
X-Received: by 2002:a05:6a00:17a8:b0:736:3bd3:1a64 with SMTP id d2e1a72fcca58-7363bd31b45mr12732813b3a.24.1741014930031;
        Mon, 03 Mar 2025 07:15:30 -0800 (PST)
Received: from [127.0.1.1] ([112.64.60.252])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-736584b3cffsm1851984b3a.4.2025.03.03.07.15.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 07:15:29 -0800 (PST)
From: Jun Nie <jun.nie@linaro.org>
Date: Mon, 03 Mar 2025 23:14:35 +0800
Subject: [PATCH v8 06/15] drm/msm/dpu: fix mixer number counter on
 allocation
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250303-sm8650-v6-14-hmd-deckard-mdss-quad-upstream-oldbootwrapper-36-prep-v8-6-eb5df105c807@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1741014878; l=1366;
 i=jun.nie@linaro.org; s=20240403; h=from:subject:message-id;
 bh=6KiLXjEpLod6o/Ty8ouIA+JWP5hGEqwM+aKGxHjhLOQ=;
 b=zm/Dw2llcmLMxDOCKUf+KzaXpfdqsyYFQikzN+y7EhKHagSgLgkAFyLnGbdWcff/N4pYIIHb8
 lplymHQX0B5DPwFJBQPw95+6cR9b/sdHAxGHSuLrnNR1aCJruHUViE+
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


